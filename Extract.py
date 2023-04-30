import sqlite3
import sys
from xml.dom import minidom

def childtextnode(doc, name, text):
    """Convenience function to create an Element with a tag name of 'name' from Document 'doc', 
       containing a single text node with the contents 'text' in it."""

    node = doc.createElement(name)
    node.appendChild(doc.createTextNode(text))
    return node

# Script extracts pokemon from the database into an XML format:
# <pokemon pokedex="" classification="" generation="">
#     <name>...</name>
#     <hp>...</name>
#     <type>...</type>
#     <type>...</type>
#     <attack>...</attack>
#     <defense>...</defense>
#     <speed>...</speed>
#     <sp_attack>...</sp_attack>
#     <sp_defense>...</sp_defense>
#     <height><m>...</m></height>
#     <weight><kg>...</kg></weight>
#     <abilities>
#         <ability />
#     </abilities>
# </pokemon>
#
def pokeTupleToXML(doc, pokeTuple):
    """Converts the SQLite-retrieved 'pokeTuple' into XML using 'doc' to create the nodes."""

    (id, name, pokedex_number, generation, classification, 
     type1name, type2name, 
     hp, attack, defense, speed, sp_attack, sp_defense, 
     height_m, weight_kg) = pokeTuple

    pokemonNode = doc.createElement('pokemon')

    pokemonNode.attributes['generation'] = str(generation)
    pokemonNode.attributes['pokedexNumber'] = str(pokedex_number)
    pokemonNode.attributes['classification'] = classification

    pokemonNode.appendChild(childtextnode(doc, 'name', name))
    pokemonNode.appendChild(childtextnode(doc, 'type', type1name))
    if type2name != "":
        pokemonNode.appendChild(childtextnode(doc, 'type', type2name))
    pokemonNode.appendChild(childtextnode(doc, 'hp', str(hp)))
    pokemonNode.appendChild(childtextnode(doc, 'attack', str(attack)))
    pokemonNode.appendChild(childtextnode(doc, 'defense', str(defense)))
    pokemonNode.appendChild(childtextnode(doc, 'speed', str(speed)))
    pokemonNode.appendChild(childtextnode(doc, 'sp_attack', str(sp_attack)))
    pokemonNode.appendChild(childtextnode(doc, 'sp_defense', str(sp_defense)))
    heightNode = doc.createElement('height')
    heightNode.appendChild(childtextnode(doc, 'm', str(height_m)))
    weightNode = doc.createElement('weight')
    weightNode.appendChild(childtextnode(doc, 'kg', str(weight_kg)))
    pokemonNode.appendChild(heightNode)
    pokemonNode.appendChild(weightNode)
    return pokemonNode

def pokeAbilitiesToXML(doc, abilities):
    """Converts the list of Pokemon abilities in 'abilities' into XML using 'doc' to create nodes."""

    abilitiesNode = doc.createElement('abilities')
    for ability in abilities:
        (name) = ability[0]
        abilitiesNode.appendChild(childtextnode(doc, 'ability', str(name)))
    return abilitiesNode

def main():
    pokedexSQL = ("SELECT p.id, p.name, p.pokedex_number, p.generation, c.text, "
            "t1.name, t2.name, "
            "p.hp, p.attack, p.defense, p.speed, p.sp_attack, p.sp_defense, "
            "p.height_m, p.weight_kg "
            "FROM pokemon p, classification c, type t1, type t2, pokemon_type pt1, pokemon_type pt2 "
            "WHERE c.id = p.classification_id AND "
            "pt1.type_id = t1.id AND pt1.which = 1 AND pt1.pokemon_id = p.id AND "
            "pt2.type_id = t2.id AND pt2.which = 2 AND pt2.pokemon_id = p.id")

    if len(sys.argv) < 2:
        print("Extracting all Pokemon into pokedex.xml")
        doc = minidom.Document()
        pokedexNode = doc.createElement('pokedex') 
        doc.appendChild(pokedexNode)

        with sqlite3.connect("pokemon.sqlite") as con:
            cursor = con.cursor()
            pokemonlist = cursor.execute(pokedexSQL).fetchall()
            for pokemon in pokemonlist:
                pokemonNode = pokeTupleToXML(doc, pokemon)

                abilitiessql = ("SELECT a.name FROM pokemon p, ability a, pokemon_abilities pa "
                    "WHERE pa.ability_id = a.id AND pa.pokemon_id = p.id AND p.id = " + str(pokemon[0]))
                
                abilities = con.cursor().execute(abilitiessql).fetchall()
                abilitiesNode = pokeAbilitiesToXML(doc, abilities)
                pokemonNode.appendChild(abilitiesNode)

                pokedexNode.appendChild(pokemonNode)

        xml_str = doc.toprettyxml(indent ="\t") 
        with open("pokedex.xml", "w") as pokeFile:
            pokeFile.write(xml_str)

    else:
        for i, arg in enumerate(sys.argv):
            if i == 0:
                continue

            filename = ""
            pokemonSQL = ""
            try:
                string_int = int(arg)
                # If it converted, it's an ID                    
                pokemonSQL = pokedexSQL + " AND p.id = " + arg
            except ValueError:
                # If it didn't, assume it's a name
                pokemonSQL = pokedexSQL + " AND p.name = '" + arg + "'"

            print("Extracting", arg, "...", end=' ')
            doc = minidom.Document()

            with sqlite3.connect("pokemon.sqlite") as con:
                cursor = con.cursor()

                pokemon = cursor.execute(pokemonSQL).fetchone()
                filename = str(pokemon[1]) + ".xml"
                pokemonNode = pokeTupleToXML(doc, pokemon)

                abilitiessql = ("SELECT a.name FROM pokemon p, ability a, pokemon_abilities pa "
                    "WHERE pa.ability_id = a.id AND pa.pokemon_id = p.id AND p.id = " + str(pokemon[0]))
                
                abilities = con.cursor().execute(abilitiessql).fetchall()
                abilitiesNode = pokeAbilitiesToXML(doc, abilities)
                pokemonNode.appendChild(abilitiesNode)

                doc.appendChild(pokemonNode)

            xml_str = doc.toprettyxml(indent ="\t") 
            print("into", filename)
            with open(filename, "w") as pokeFile:
                pokeFile.write(xml_str)
                
main()



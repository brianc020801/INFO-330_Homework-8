# ExploringXML

Again if you don't care to read the backstory, feel free to [skip to the goals](#goals).

## Background

Professor Oak was having dinner with his favorite dinner partner, Mrs Ketchum, Ash's mom.

![](Images/dinner.jpeg)

He was quite enjoying the evening, for Ash's mom was a wonderful cook and an even more delightful conversationalist, listening to his stories about his grandson, Gary, and matching them with stories that she'd heard from her son. The boys might have been rivals, but in this kitchen, the two households got along fabulously.

![](Images/HGSS_Professor_Elm.webp)

For that reason, when the doorbell rang and Professor Oak saw through the window that it was Professor Elm, a bad feeling began to develop in the pit of his stomach. Lately, all of his phone calls had turned into something that took him away from his research, and he was loathe to take on yet *another* thing for somebody else that would never go anywhere. "Great," he muttered under his breath. Unfortunately, Ash's mom was already up and moving, and she cheerfully answered the door.

"Oh, hello, Professor Elm!"

"Ah! Mrs Ketchum! Professor Oak! I'm sorry to have interrupted you in the middle--say, is that sushi? That looks lovely!" Without hesitation, he came in, sat down in the other chair, and began to partake. "Say, Samuel, hand me that fish sauce, would you, yes thank you!"

For several moments there was nothing but the sound of a hungry Professor devouring vast amounts of food, and then Professor Oak cleared his throat. "Did you want something in particular, or were you just dropping by for dinner?"

"What? Oh! Yes!" Professor Elm picked up the sheaf of papers he'd brought in with him. "I was talking with Birchie yesterday, and he mentioned that you'd done some great work for him converting your Pokemon database over to a form they could use over there at Rocket."

Professor Oak said nothing. Professor Elm didn't notice.

"Well, as you know, I'm doing a great deal of research myself, and I've found that for what I'm doing, XML works *far* better, so I was hoping you could work that same magic and turn your database into XML for me." He munched a few more morsels while Professor Oak just stared flatly. "Very helpful, you know." Silence. "Very *very* helpful."

When the silence grew a little uncomfortable, Ash's mom jumped in. "Oh, of course, Professor, the Professor would love to help!"

Professor Oak groaned.

Professor Elm clapped his hands. "Delightful! And lovely meal, Mrs. Ketchum, I'm quite full!." Standing up, he brushed crumbs from his lab coat, picked up his papers, and left.

Professor Oak looked at the crumbs of what had once been his dinner, wondered if he had enough in his pocket to pick up a falafel on the way home, and sighed. "Why me?" he wondered out loud.

"Oh, don't worry, Samuel. I've got this one." Pulling up a chair at her desk, Ash's mom pulled out her MacBook and plugged it into the wall monitor. "I've been doing XML since Ash was a baby. You start working on the dishes, and I'll get this done for him before the falafel place closes."

Later, when he was elbows-deep in soap suds, Professor Oak suddenly wondered why all the women in his life were better at IT than he was.

## Goals
Use XPath and XSLT to generate HTML files for various collections of Pokemon. You will need to make use of an XSLT processor (the most popular of which is [xsltproc](http://xmlsoft.org/xslt/xsltproc.html)) to transform an XML representation of the data into various output formats (most notably HTML). In it, you will write XPath queries to identify the correct XML nodes to satisfy the kinds of queries desired. Each query is in its own XSL file.

## Details

The `pokedex.xml` file has all of the pokemon.sqlite data in an XML format, wherein each Pokemon is described using the following schema:

```
<pokemon pokedex="" classification="" generation="">
    <name>...</name>
    <hp>...</name>
    <type>...</type>
    <type>...</type>
    <attack>...</attack>
    <defense>...</defense>
    <speed>...</speed>
    <sp_attack>...</sp_attack>
    <sp_defense>...</sp_defense>
    <height><m>...</m></height>
    <weight><kg>...</kg></weight>
    <abilities>
        <ability />
    </abilities>
</pokemon>
```

You can see the Python code that created this XML file in `Extract.py`.

To run the XSLT stylesheets with xsltproc, you do it like so: `xsltproc stylesheet.xsl pokemon.xml`. Each stylesheet has two sets of rules, one which outputs plain text (such as `Oricorio (741): Dancing Pokémon`), and a second set that outputs HTML (so you can see it in a more pleasant setting). The first set is easier for debugging, the second set is generally what you want your final output to look like. For this homework, you are free to use either set.

## Stories/Rubric

Each point of the homework is in its own stylesheet. Your job is to replace the `XPATH-QUERY-GOES-HERE` with the appropriate XPath query to identify the XML in question.

* (1 pt) genone.xsl: Find all generation-1 Pokemon
* (1 pt) fire.xsl: Find all Pokemon that have a type of "fire"
* (1 pt) elemental.xsl: Find all Pokemon that have a type of "fire", "water", "flying", or "ground"
* (1 pt) singular.xsl: Find all Pokemon that have only one type
* (1 pt) stats.xsl: Find all Pokemon with statistics that match the comments in the stylesheet.

## Extra Credit

(5 pts) Create a Python program, `Import.py`, which will take an XML file as input, and insert new Pokemon into the `pokemon.sqlite` database. This will require you to open the file given as a command-line argument, use Python's XML libraries to parse the XML, then INSERT the resulting data into the database. An example Pokemon input file of that sort is given in the file `Bulbasaur.xml`.


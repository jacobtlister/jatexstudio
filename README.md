# JaTeXstudio

## about

i started working on this project because there were a few things about vanilla `txs` that really pissed me off, with the biggest offender by far being the following:

in vanilla `txs`, when you moved left/right 1 character, there was an active selection and you were not trying to keep the selection alive, you would just end up moving left or right anyways, as if you hadn't even selected the text. this is very different from the norm (for me); what normally occurs is that when you move your cursor it teleports to the left/right boundary of the selection, corresponding to the inputted direction

it may seem like it would barely ever occur given how many conditions there are for this specific event to occur, but personally i've learned to take great advantage of it for navigating through a text editor, so it was always something that always deeply disturbed me

luckily after spending a couple hours rummaging around in the source code i have successfully managed to mod TeXstudio to support this desired cursor movement, and am already far happier with the experience

## why not use scripts?

scripts in theory are good, but they do not provide me enough power or control over `txs` to be satisfied using them. i started using them for a while, but since they were unable to solve the issue with the cursor movement without lagging all of `txs` i ended up switching to modding `txs`

i have also used scripts in `txs` for other purposes besides trying to make the cursor movement act the way i want, but it was mainly to make compound commands (multiple simple commands simultaneously).

## future plans

i do plan on working on this more and modding more features into `txs`. most of the scripts i have made i desire to properly mod into `txs` at some point. some of the ideas i have with this project are discussed below

1) i think that if i tweak the modified cursor movement i implemented a bit and provide an actual setting to toggle this feature on and off, i think that i could do a real pull request on `txs` and officially implement this. i think that would be a pretty reasonable thing to do, as i know when i was looking around online about this i know others were also annoyed

2) i would like to make the built-in pdf viewer more responsive to my actions. for example, upon paging through active documents, have the viewer change the active file being shown to always match the document you are currently tabbed into (or the most recent valid document if your aren't currently tabbed into a document with an associated .pdf). i have already largely implemented this as i have implemented this for `Ctrl+PgUp` and `Ctrl+PgDn` document paging. i would also like to implement this feature if you click on an arbitrary tab you have open and when you open a file

3) make the save command more robust for what i want. that is, upon saving, i want the following events to also happen:

    - prior to saving, remove all trailing whitespace and convert all tabs to spaces in the active document
    - to help work towards the goal of the pdf viewer being more dynamic, have the viewer open the pdf for the current document after saving

4) extend the capabilities of backspacing (and symmetrically deleting). namely, i want support for the following: in the situation where your cursor is sandwiched directly between the start and end of a delimiter pair ((), [], {}, "", and $$, namely) and you press backspace, i also want the delimiter to the right of the cursor to be deleted. i have this feature in vs code and love it because it helps you clean up your mistakes quicker. also as a small related thing, implement support auto-completion for quotes and dollar signs, as `txs` natively only supports delimiter auto-completion for (), [], and {}

5) learn more about the `Editor/Basic Key Mapping` shortcuts and mod it so that they are easier to modify and work with. i am fairly confident that that shortcuts are stored in a different manner than the rest of the shortcuts in `txs`, i just need to figure out how exactly to get more control over them. additionally, i would like to make it so that the macro editor uses all of the same settings as your primary editor (minus macros of course) as currently if you edit some of the keybinds in the `Editor/Basic Key Mapping` category (eg. backspace for deleting 1 character to the left), your macro editor just completely loses access to the keybind and command.

# JaTeXstudio (`jtxs`)

## about

this repository contains a clone of th source code of TeXstudio (`txs`) 4.9.3 i have modded to make it better to use for me

i started working on this project because there were a few things about vanilla TeXstudio that really pissed me off in terms of the way some features were implemented. the biggest offender by far was the following:

- in vanilla TeXstudio, when you moved left/right 1 character, there was an active selection and you were not trying to keep the selection alive, you would just end up moving left or right as normal and unselect the text, as if you hadn't even selected the text

this is very different from the norm of text editors/ides (for me); what i am used to occuring is that when you move your cursor left/right 1 character it teleports to the corresponding boundary of the selection and clears the selection. it may seem like it would barely ever occur given how many conditions there are for this specific event to occur, but personally i've learned to take great advantage of it for navigating through a text editor, so not being able to do it was always something that always deeply frustrated me when using TeXstudio

due to frustration with this quirk of the cursors among other things, i ended up choosing to be a very silly little guy and just starting modding the source code to make TeXstudio work the way i want it to, leading me to make this repository. so far, i have had success in my endeavors, as after spending a couple hours rummaging around in the source code and learning about the 1,000,000 c++ classes qt has i successfully managed to mod TeXstudio to support the cursor movement i desired. i have already been far happier with the experience now that i fixed this issue

## why mod `txs` when you can just make scripts?

i was using scripts in `txs` for a while, but due to some issues that severely limited me i have mostly stopped using it

the big issue i have with it is that the scripting language used by `txs` is relatively weak. it is based on javascript (bad sign already) and also has very limited compatility with the qt c++ classes used in the backend of `txs`; for example, as far as i know scripts are completely unable interact with QList objects, as any time i have even so much as had one get returned by a function the script will throw an error and kill itself

so overall for me, once you try and get a *bit* too technical or fancy with what you want your scripts to do, you end up hitting a pretty brutal wall

i have also used scripts in `txs` for other purposes besides trying to make the cursor movement act the way i want, but i was mainly using it to make compound commands (multiple simple commands being executed simultaneously), beyond that though i have not found much else the scripts able to do

even for all the shit i give them, the scripts i worked on were also part of what helped motivate me to dive into the source code and start working on `jtxs`. they also served as bouncing off points for things i want add to `jtxs`, so i guess in the end they did do some good for me

## installation instructions

installation of `jtxs` is basically the same as vanilla `txs`, as i have not introduced any new dependencies or done anything silly like that. in the repository there is still the `BUILD.sh` script that is included for installing `txs` and it still works, so installing `jtxs` should be just as easy as installing `txs` as long as you know how to build from source

don't use `reupjtxs.sh` though, as that is my custom script i made for automatically uninstalling and reinstalling `jtxs` to be able to quickly test it as i am working on it

## future plans

i do plan on continuing to work on this more and add more features to `jtxs`. as mentioned, most of the scripts made i desire to implement into `jtxs` at some point. i also have a couple of other ideas as well. the plans i currently have with this project are detailed below:

1) i think that if i tweak the modified cursor movement i implemented a bit and provide an actual setting to toggle this feature on/off, i think that i could do a real pull request for `txs` and officially implement this. i think it would be a pretty reasonable thing to do, as i know when i was looking around online about this i know others were also annoyed. i have also made a pretty good "remove trailing whitespace funtion" that could be good to push.

2) i would like to make the built-in pdf viewer more responsive to my actions. for example, upon paging through active documents, have the viewer change the active file being shown to always match the document you are currently tabbed into (or the most recent valid document if your aren't currently tabbed into a document with an associated .pdf). i have already largely implemented this as i have implemented this for `Ctrl+PgUp` and `Ctrl+PgDn` document paging. i would also like to implement this feature if you click on an arbitrary tab you have open and when you open a file

3) learn more about the `Editor/Basic Key Mapping` shortcuts and mod it so that they are easier to modify and work with. i am fairly confident that that shortcuts are stored in a different manner than the rest of the shortcuts in `txs`, i just need to figure out how exactly to get more control over them. additionally, i would like to make it so that the macro editor uses all of the same settings as your primary editor (minus macros of course) as currently if you edit some of the keybinds in the `Editor/Basic Key Mapping` category (eg. removing the binding of backspace deleting 1 character to the left), your macro editor just completely loses access to the keybind and command with no way to edit it unless you go back and edit your global keybindings

4) compile a list of all of the modifications i have made when working on `jtxs` for sanity's sake

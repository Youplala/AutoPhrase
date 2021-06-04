# AutoPhrase: Automated Phrase Mining from Massive Text Corpora

AutoPhrase is used to automate quality phrases extraction from massive text corpora. I automated the program using a bash script to process several text files.

## Requirements

Windows or Linux with g++ and Java installed.

Windows: 

* [Git for windows](https://gitforwindows.org/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)

Ubuntu:

* g++ 4.8 `$ sudo apt-get install g++-4.8`
* Java 8 `$ sudo apt-get install openjdk-8-jdk`
* curl `$ sudo apt-get install curl`

## Default Run

#### Phrase Mining Step
```
$ ./run.sh EN
```
or
```
$ ./run.sh FR
```
depending on the language of your data.


The default run will download an English corpus from the server of AutoPhrase's data
mining group and run AutoPhrase to get 3 ranked lists of phrases as well as 2 segmentation model files under the
```MODEL``` (i.e., ```models/EN```) directory. 
* ```AutoPhrase.txt```: the unified ranked list for both single-word phrases and multi-word phrases. 
* ```AutoPhrase_multi-words.txt```: the sub-ranked list for multi-word phrases only. 
* ```AutoPhrase_single-word.txt```: the sub-ranked list for single-word phrases only.
* ```segmentation.model```: AutoPhrase's segmentation model (saved for later use).
* ```token_mapping.txt```: the token mapping file for the tokenizer (saved for later use).

You can change ```RAW_TRAIN``` to your own corpus and you may also want change ```MODEL``` to a different name.


#### Change data

Put your multiple ```.txt``` files in ```default_data/disciplines```.

#### stopwords.txt

You may try to search online or create your own list. Stopwords are stored in ```data/EN/stopwords.txt```


### Related GitHub Repositories

*   [SegPhrase](https://github.com/shangjingbo1226/SegPhrase)
*	[SegPhrase-MultiLingual](https://github.com/remenberl/SegPhrase-MultiLingual)

### Publications

People who originally made the software:

*   Jingbo Shang, Jialu Liu, Meng Jiang, Xiang Ren, Clare R Voss, Jiawei Han, "**[Automated Phrase Mining from Massive Text Corpora](https://arxiv.org/abs/1702.04457)**", accepted by IEEE Transactions on Knowledge and Data Engineering, Feb. 2018.

*   Jialu Liu\*, Jingbo Shang\*, Chi Wang, Xiang Ren and Jiawei Han, "**[Mining Quality Phrases from Massive Text Corpora](http://hanj.cs.illinois.edu/pdf/sigmod15_jliu.pdf)**”, Proc. of 2015 ACM SIGMOD Int. Conf. on Management of Data (SIGMOD'15), Melbourne, Australia, May 2015. (\* equally contributed, [slides](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/sigmod15SegPhrase.pdf))
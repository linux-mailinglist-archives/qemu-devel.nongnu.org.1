Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AD379A58E
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 10:08:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbsi-0001MH-UR; Mon, 11 Sep 2023 04:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfbsU-0001EV-Ez; Mon, 11 Sep 2023 04:02:39 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfbsQ-00027P-HD; Mon, 11 Sep 2023 04:02:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EAB7F20AEF;
 Mon, 11 Sep 2023 11:02:28 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 390A127244;
 Mon, 11 Sep 2023 11:02:27 +0300 (MSK)
Received: (nullmailer pid 3680125 invoked by uid 1000);
 Mon, 11 Sep 2023 08:02:27 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 02/51] python: drop pipenv
Date: Mon, 11 Sep 2023 11:01:53 +0300
Message-Id: <20230911080225.3680068-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.6-20230911105418@cover.tls.msk.ru>
References: <qemu-stable-7.2.6-20230911105418@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: John Snow <jsnow@redhat.com>

The pipenv tool was nice in theory, but in practice it's just too hard
to update selectively, and it makes using it a pain. The qemu.qmp repo
dropped pipenv support a while back and it's been functioning just fine,
so I'm backporting that change here to qemu.git.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-id: 20230210003147.1309376-3-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit 6832189fd791622c30e7bbe3a12b76be14dc1158)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: the reason for this is to stop CI failing in pipenv for 7.2)

diff --git a/.gitlab-ci.d/static_checks.yml b/.gitlab-ci.d/static_checks.yml
index 289ad1359e..b4cbdbce2a 100644
--- a/.gitlab-ci.d/static_checks.yml
+++ b/.gitlab-ci.d/static_checks.yml
@@ -23,12 +23,12 @@ check-dco:
   before_script:
     - apk -U add git
 
-check-python-pipenv:
+check-python-minreqs:
   extends: .base_job_template
   stage: test
   image: $CI_REGISTRY_IMAGE/qemu/python:latest
   script:
-    - make -C python check-pipenv
+    - make -C python check-minreqs
   variables:
     GIT_DEPTH: 1
   needs:
diff --git a/python/.gitignore b/python/.gitignore
index 904f324bb1..c3ceb1ca0a 100644
--- a/python/.gitignore
+++ b/python/.gitignore
@@ -11,8 +11,8 @@ qemu.egg-info/
 .idea/
 .vscode/
 
-# virtual environments (pipenv et al)
-.venv/
+# virtual environments
+.min-venv/
 .tox/
 .dev-venv/
 
diff --git a/python/Makefile b/python/Makefile
index b170708398..c5bd6ff83a 100644
--- a/python/Makefile
+++ b/python/Makefile
@@ -1,15 +1,16 @@
 QEMU_VENV_DIR=.dev-venv
+QEMU_MINVENV_DIR=.min-venv
 QEMU_TOX_EXTRA_ARGS ?=
 
 .PHONY: help
 help:
 	@echo "python packaging help:"
 	@echo ""
-	@echo "make check-pipenv:"
-	@echo "    Run tests in pipenv's virtual environment."
+	@echo "make check-minreqs:"
+	@echo "    Run tests in the minreqs virtual environment."
 	@echo "    These tests use the oldest dependencies."
-	@echo "    Requires: Python 3.6 and pipenv."
-	@echo "    Hint (Fedora): 'sudo dnf install python3.6 pipenv'"
+	@echo "    Requires: Python 3.6"
+	@echo "    Hint (Fedora): 'sudo dnf install python3.6'"
 	@echo ""
 	@echo "make check-tox:"
 	@echo "    Run tests against multiple python versions."
@@ -33,8 +34,8 @@ help:
 	@echo "    and install the qemu package in editable mode."
 	@echo "    (Can be used in or outside of a venv.)"
 	@echo ""
-	@echo "make pipenv"
-	@echo "    Creates pipenv's virtual environment (.venv)"
+	@echo "make min-venv"
+	@echo "    Creates the minreqs virtual environment ($(QEMU_MINVENV_DIR))"
 	@echo ""
 	@echo "make dev-venv"
 	@echo "    Creates a simple venv for check-dev. ($(QEMU_VENV_DIR))"
@@ -43,21 +44,38 @@ help:
 	@echo "    Remove package build output."
 	@echo ""
 	@echo "make distclean:"
-	@echo "    remove pipenv/venv files, qemu package forwarder,"
+	@echo "    remove venv files, qemu package forwarder,"
 	@echo "    built distribution files, and everything from 'make clean'."
 	@echo ""
 	@echo -e "Have a nice day ^_^\n"
 
-.PHONY: pipenv
-pipenv: .venv
-.venv: Pipfile.lock
-	@PIPENV_VENV_IN_PROJECT=1 pipenv sync --dev --keep-outdated
-	rm -f pyproject.toml
-	@touch .venv
+.PHONY: pipenv check-pipenv
+pipenv check-pipenv:
+	@echo "pipenv was dropped; try 'make check-minreqs' or 'make min-venv'"
+	@exit 1
+
+.PHONY: min-venv
+min-venv: $(QEMU_MINVENV_DIR) $(QEMU_MINVENV_DIR)/bin/activate
+$(QEMU_MINVENV_DIR) $(QEMU_MINVENV_DIR)/bin/activate: setup.cfg tests/minreqs.txt
+	@echo "VENV $(QEMU_MINVENV_DIR)"
+	@python3.6 -m venv $(QEMU_MINVENV_DIR)
+	@(								\
+		echo "ACTIVATE $(QEMU_MINVENV_DIR)";			\
+		. $(QEMU_MINVENV_DIR)/bin/activate;			\
+		echo "INSTALL -r tests/minreqs.txt $(QEMU_MINVENV_DIR)";\
+		pip install -r tests/minreqs.txt 1>/dev/null;		\
+		echo "INSTALL -e qemu $(QEMU_MINVENV_DIR)";		\
+		pip install -e . 1>/dev/null;				\
+	)
+	@touch $(QEMU_MINVENV_DIR)
 
-.PHONY: check-pipenv
-check-pipenv: pipenv
-	@pipenv run make check
+.PHONY: check-minreqs
+check-minreqs: min-venv
+	@(							\
+		echo "ACTIVATE $(QEMU_MINVENV_DIR)";		\
+		. $(QEMU_MINVENV_DIR)/bin/activate;		\
+		make check;					\
+	)
 
 .PHONY: dev-venv
 dev-venv: $(QEMU_VENV_DIR) $(QEMU_VENV_DIR)/bin/activate
@@ -106,6 +124,7 @@ clean:
 
 .PHONY: distclean
 distclean: clean
-	rm -rf qemu.egg-info/ .venv/ .tox/ $(QEMU_VENV_DIR) dist/
+	rm -rf qemu.egg-info/ .eggs/ dist/
+	rm -rf $(QEMU_VENV_DIR) $(QEMU_MINVENV_DIR) .tox/
 	rm -f .coverage .coverage.*
 	rm -rf htmlcov/
diff --git a/python/Pipfile b/python/Pipfile
deleted file mode 100644
index e7acb8cefa..0000000000
--- a/python/Pipfile
+++ /dev/null
@@ -1,13 +0,0 @@
-[[source]]
-name = "pypi"
-url = "https://pypi.org/simple"
-verify_ssl = true
-
-[dev-packages]
-qemu = {editable = true, extras = ["devel"], path = "."}
-
-[packages]
-qemu = {editable = true,path = "."}
-
-[requires]
-python_version = "3.6"
diff --git a/python/Pipfile.lock b/python/Pipfile.lock
deleted file mode 100644
index ce46404ce0..0000000000
--- a/python/Pipfile.lock
+++ /dev/null
@@ -1,347 +0,0 @@
-{
-    "_meta": {
-        "hash": {
-            "sha256": "f1a25654d884a5b450e38d78b1f2e3ebb9073e421cc4358d4bbb83ac251a5670"
-        },
-        "pipfile-spec": 6,
-        "requires": {
-            "python_version": "3.6"
-        },
-        "sources": [
-            {
-                "name": "pypi",
-                "url": "https://pypi.org/simple",
-                "verify_ssl": true
-            }
-        ]
-    },
-    "default": {
-        "qemu": {
-            "editable": true,
-            "path": "."
-        }
-    },
-    "develop": {
-        "appdirs": {
-            "hashes": [
-                "sha256:7d5d0167b2b1ba821647616af46a749d1c653740dd0d2415100fe26e27afdf41",
-                "sha256:a841dacd6b99318a741b166adb07e19ee71a274450e68237b4650ca1055ab128"
-            ],
-            "version": "==1.4.4"
-        },
-        "astroid": {
-            "hashes": [
-                "sha256:09bdb456e02564731f8b5957cdd0c98a7f01d2db5e90eb1d794c353c28bfd705",
-                "sha256:6a8a51f64dae307f6e0c9db752b66a7951e282389d8362cc1d39a56f3feeb31d"
-            ],
-            "index": "pypi",
-            "version": "==2.6.0"
-        },
-        "avocado-framework": {
-            "hashes": [
-                "sha256:244cb569f8eb4e50a22ac82e1a2b2bba2458999f4281efbe2651bd415d59c65b",
-                "sha256:6f15998b67ecd0e7dde790c4de4dd249d6df52dfe6d5cc4e2dd6596df51c3583"
-            ],
-            "index": "pypi",
-            "version": "==90.0"
-        },
-        "distlib": {
-            "hashes": [
-                "sha256:106fef6dc37dd8c0e2c0a60d3fca3e77460a48907f335fa28420463a6f799736",
-                "sha256:23e223426b28491b1ced97dc3bbe183027419dfc7982b4fa2f05d5f3ff10711c"
-            ],
-            "index": "pypi",
-            "version": "==0.3.2"
-        },
-        "filelock": {
-            "hashes": [
-                "sha256:18d82244ee114f543149c66a6e0c14e9c4f8a1044b5cdaadd0f82159d6a6ff59",
-                "sha256:929b7d63ec5b7d6b71b0fa5ac14e030b3f70b75747cef1b10da9b879fef15836"
-            ],
-            "index": "pypi",
-            "version": "==3.0.12"
-        },
-        "flake8": {
-            "hashes": [
-                "sha256:6a35f5b8761f45c5513e3405f110a86bea57982c3b75b766ce7b65217abe1670",
-                "sha256:c01f8a3963b3571a8e6bd7a4063359aff90749e160778e03817cd9b71c9e07d2"
-            ],
-            "index": "pypi",
-            "version": "==3.6.0"
-        },
-        "fusepy": {
-            "hashes": [
-                "sha256:10f5c7f5414241bffecdc333c4d3a725f1d6605cae6b4eaf86a838ff49cdaf6c",
-                "sha256:a9f3a3699080ddcf0919fd1eb2cf743e1f5859ca54c2018632f939bdfac269ee"
-            ],
-            "index": "pypi",
-            "version": "==2.0.4"
-        },
-        "importlib-metadata": {
-            "hashes": [
-                "sha256:90bb658cdbbf6d1735b6341ce708fc7024a3e14e99ffdc5783edea9f9b077f83",
-                "sha256:dc15b2969b4ce36305c51eebe62d418ac7791e9a157911d58bfb1f9ccd8e2070"
-            ],
-            "markers": "python_version < '3.8'",
-            "version": "==1.7.0"
-        },
-        "importlib-resources": {
-            "hashes": [
-                "sha256:54161657e8ffc76596c4ede7080ca68cb02962a2e074a2586b695a93a925d36e",
-                "sha256:e962bff7440364183203d179d7ae9ad90cb1f2b74dcb84300e88ecc42dca3351"
-            ],
-            "index": "pypi",
-            "version": "==5.1.4"
-        },
-        "isort": {
-            "hashes": [
-                "sha256:408e4d75d84f51b64d0824894afee44469eba34a4caee621dc53799f80d71ccc",
-                "sha256:64022dea6a06badfa09b300b4dfe8ba968114a737919e8ed50aea1c288f078aa"
-            ],
-            "index": "pypi",
-            "version": "==5.1.2"
-        },
-        "lazy-object-proxy": {
-            "hashes": [
-                "sha256:17e0967ba374fc24141738c69736da90e94419338fd4c7c7bef01ee26b339653",
-                "sha256:1fee665d2638491f4d6e55bd483e15ef21f6c8c2095f235fef72601021e64f61",
-                "sha256:22ddd618cefe54305df49e4c069fa65715be4ad0e78e8d252a33debf00f6ede2",
-                "sha256:24a5045889cc2729033b3e604d496c2b6f588c754f7a62027ad4437a7ecc4837",
-                "sha256:410283732af311b51b837894fa2f24f2c0039aa7f220135192b38fcc42bd43d3",
-                "sha256:4732c765372bd78a2d6b2150a6e99d00a78ec963375f236979c0626b97ed8e43",
-                "sha256:489000d368377571c6f982fba6497f2aa13c6d1facc40660963da62f5c379726",
-                "sha256:4f60460e9f1eb632584c9685bccea152f4ac2130e299784dbaf9fae9f49891b3",
-                "sha256:5743a5ab42ae40caa8421b320ebf3a998f89c85cdc8376d6b2e00bd12bd1b587",
-                "sha256:85fb7608121fd5621cc4377a8961d0b32ccf84a7285b4f1d21988b2eae2868e8",
-                "sha256:9698110e36e2df951c7c36b6729e96429c9c32b3331989ef19976592c5f3c77a",
-                "sha256:9d397bf41caad3f489e10774667310d73cb9c4258e9aed94b9ec734b34b495fd",
-                "sha256:b579f8acbf2bdd9ea200b1d5dea36abd93cabf56cf626ab9c744a432e15c815f",
-                "sha256:b865b01a2e7f96db0c5d12cfea590f98d8c5ba64ad222300d93ce6ff9138bcad",
-                "sha256:bf34e368e8dd976423396555078def5cfc3039ebc6fc06d1ae2c5a65eebbcde4",
-                "sha256:c6938967f8528b3668622a9ed3b31d145fab161a32f5891ea7b84f6b790be05b",
-                "sha256:d1c2676e3d840852a2de7c7d5d76407c772927addff8d742b9808fe0afccebdf",
-                "sha256:d7124f52f3bd259f510651450e18e0fd081ed82f3c08541dffc7b94b883aa981",
-                "sha256:d900d949b707778696fdf01036f58c9876a0d8bfe116e8d220cfd4b15f14e741",
-                "sha256:ebfd274dcd5133e0afae738e6d9da4323c3eb021b3e13052d8cbd0e457b1256e",
-                "sha256:ed361bb83436f117f9917d282a456f9e5009ea12fd6de8742d1a4752c3017e93",
-                "sha256:f5144c75445ae3ca2057faac03fda5a902eff196702b0a24daf1d6ce0650514b"
-            ],
-            "index": "pypi",
-            "version": "==1.6.0"
-        },
-        "mccabe": {
-            "hashes": [
-                "sha256:ab8a6258860da4b6677da4bd2fe5dc2c659cff31b3ee4f7f5d64e79735b80d42",
-                "sha256:dd8d182285a0fe56bace7f45b5e7d1a6ebcbf524e8f3bd87eb0f125271b8831f"
-            ],
-            "version": "==0.6.1"
-        },
-        "mypy": {
-            "hashes": [
-                "sha256:00cb1964a7476e871d6108341ac9c1a857d6bd20bf5877f4773ac5e9d92cd3cd",
-                "sha256:127de5a9b817a03a98c5ae8a0c46a20dc44442af6dcfa2ae7f96cb519b312efa",
-                "sha256:1f3976a945ad7f0a0727aafdc5651c2d3278e3c88dee94e2bf75cd3386b7b2f4",
-                "sha256:2f8c098f12b402c19b735aec724cc9105cc1a9eea405d08814eb4b14a6fb1a41",
-                "sha256:4ef13b619a289aa025f2273e05e755f8049bb4eaba6d703a425de37d495d178d",
-                "sha256:5d142f219bf8c7894dfa79ebfb7d352c4c63a325e75f10dfb4c3db9417dcd135",
-                "sha256:62eb5dd4ea86bda8ce386f26684f7f26e4bfe6283c9f2b6ca6d17faf704dcfad",
-                "sha256:64c36eb0936d0bfb7d8da49f92c18e312ad2e3ed46e5548ae4ca997b0d33bd59",
-                "sha256:75eed74d2faf2759f79c5f56f17388defd2fc994222312ec54ee921e37b31ad4",
-                "sha256:974bebe3699b9b46278a7f076635d219183da26e1a675c1f8243a69221758273",
-                "sha256:a5e5bb12b7982b179af513dddb06fca12285f0316d74f3964078acbfcf4c68f2",
-                "sha256:d31291df31bafb997952dc0a17ebb2737f802c754aed31dd155a8bfe75112c57",
-                "sha256:d3b4941de44341227ece1caaf5b08b23e42ad4eeb8b603219afb11e9d4cfb437",
-                "sha256:eadb865126da4e3c4c95bdb47fe1bb087a3e3ea14d39a3b13224b8a4d9f9a102"
-            ],
-            "index": "pypi",
-            "version": "==0.780"
-        },
-        "mypy-extensions": {
-            "hashes": [
-                "sha256:090fedd75945a69ae91ce1303b5824f428daf5a028d2f6ab8a299250a846f15d",
-                "sha256:2d82818f5bb3e369420cb3c4060a7970edba416647068eb4c5343488a6c604a8"
-            ],
-            "version": "==0.4.3"
-        },
-        "packaging": {
-            "hashes": [
-                "sha256:5b327ac1320dc863dca72f4514ecc086f31186744b84a230374cc1fd776feae5",
-                "sha256:67714da7f7bc052e064859c05c595155bd1ee9f69f76557e21f051443c20947a"
-            ],
-            "index": "pypi",
-            "version": "==20.9"
-        },
-        "pluggy": {
-            "hashes": [
-                "sha256:15b2acde666561e1298d71b523007ed7364de07029219b604cf808bfa1c765b0",
-                "sha256:966c145cd83c96502c3c3868f50408687b38434af77734af1e9ca461a4081d2d"
-            ],
-            "index": "pypi",
-            "version": "==0.13.1"
-        },
-        "py": {
-            "hashes": [
-                "sha256:21b81bda15b66ef5e1a777a21c4dcd9c20ad3efd0b3f817e7a809035269e1bd3",
-                "sha256:3b80836aa6d1feeaa108e046da6423ab8f6ceda6468545ae8d02d9d58d18818a"
-            ],
-            "index": "pypi",
-            "version": "==1.10.0"
-        },
-        "pycodestyle": {
-            "hashes": [
-                "sha256:74abc4e221d393ea5ce1f129ea6903209940c1ecd29e002e8c6933c2b21026e0",
-                "sha256:cbc619d09254895b0d12c2c691e237b2e91e9b2ecf5e84c26b35400f93dcfb83",
-                "sha256:cbfca99bd594a10f674d0cd97a3d802a1fdef635d4361e1a2658de47ed261e3a"
-            ],
-            "version": "==2.4.0"
-        },
-        "pyflakes": {
-            "hashes": [
-                "sha256:9a7662ec724d0120012f6e29d6248ae3727d821bba522a0e6b356eff19126a49",
-                "sha256:f661252913bc1dbe7fcfcbf0af0db3f42ab65aabd1a6ca68fe5d466bace94dae"
-            ],
-            "version": "==2.0.0"
-        },
-        "pygments": {
-            "hashes": [
-                "sha256:a18f47b506a429f6f4b9df81bb02beab9ca21d0a5fee38ed15aef65f0545519f",
-                "sha256:d66e804411278594d764fc69ec36ec13d9ae9147193a1740cd34d272ca383b8e"
-            ],
-            "index": "pypi",
-            "version": "==2.9.0"
-        },
-        "pylint": {
-            "hashes": [
-                "sha256:082a6d461b54f90eea49ca90fff4ee8b6e45e8029e5dbd72f6107ef84f3779c0",
-                "sha256:a01cd675eccf6e25b3bdb42be184eb46aaf89187d612ba0fb5f93328ed6b0fd5"
-            ],
-            "index": "pypi",
-            "version": "==2.8.0"
-        },
-        "pyparsing": {
-            "hashes": [
-                "sha256:c203ec8783bf771a155b207279b9bccb8dea02d8f0c9e5f8ead507bc3246ecc1",
-                "sha256:ef9d7589ef3c200abe66653d3f1ab1033c3c419ae9b9bdb1240a85b024efc88b"
-            ],
-            "index": "pypi",
-            "version": "==2.4.7"
-        },
-        "qemu": {
-            "editable": true,
-            "path": "."
-        },
-        "setuptools": {
-            "hashes": [
-                "sha256:22c7348c6d2976a52632c67f7ab0cdf40147db7789f9aed18734643fe9cf3373",
-                "sha256:4ce92f1e1f8f01233ee9952c04f6b81d1e02939d6e1b488428154974a4d0783e"
-            ],
-            "markers": "python_version >= '3.6'",
-            "version": "==59.6.0"
-        },
-        "six": {
-            "hashes": [
-                "sha256:1e61c37477a1626458e36f7b1d82aa5c9b094fa4802892072e49de9c60c4c926",
-                "sha256:8abb2f1d86890a2dfb989f9a77cfcfd3e47c2a354b01111771326f8aa26e0254"
-            ],
-            "markers": "python_version >= '2.7' and python_version not in '3.0, 3.1, 3.2, 3.3'",
-            "version": "==1.16.0"
-        },
-        "toml": {
-            "hashes": [
-                "sha256:806143ae5bfb6a3c6e736a764057db0e6a0e05e338b5630894a5f779cabb4f9b",
-                "sha256:b3bda1d108d5dd99f4a20d24d9c348e91c4db7ab1b749200bded2f839ccbe68f"
-            ],
-            "markers": "python_version >= '2.6' and python_version not in '3.0, 3.1, 3.2, 3.3'",
-            "version": "==0.10.2"
-        },
-        "tox": {
-            "hashes": [
-                "sha256:c60692d92fe759f46c610ac04c03cf0169432d1ff8e981e8ae63e068d0954fc3",
-                "sha256:f179cb4043d7dc1339425dd49ab1dd8c916246b0d9173143c1b0af7498a03ab0"
-            ],
-            "index": "pypi",
-            "version": "==3.18.0"
-        },
-        "typed-ast": {
-            "hashes": [
-                "sha256:01ae5f73431d21eead5015997ab41afa53aa1fbe252f9da060be5dad2c730ace",
-                "sha256:067a74454df670dcaa4e59349a2e5c81e567d8d65458d480a5b3dfecec08c5ff",
-                "sha256:0fb71b8c643187d7492c1f8352f2c15b4c4af3f6338f21681d3681b3dc31a266",
-                "sha256:1b3ead4a96c9101bef08f9f7d1217c096f31667617b58de957f690c92378b528",
-                "sha256:2068531575a125b87a41802130fa7e29f26c09a2833fea68d9a40cf33902eba6",
-                "sha256:209596a4ec71d990d71d5e0d312ac935d86930e6eecff6ccc7007fe54d703808",
-                "sha256:2c726c276d09fc5c414693a2de063f521052d9ea7c240ce553316f70656c84d4",
-                "sha256:398e44cd480f4d2b7ee8d98385ca104e35c81525dd98c519acff1b79bdaac363",
-                "sha256:52b1eb8c83f178ab787f3a4283f68258525f8d70f778a2f6dd54d3b5e5fb4341",
-                "sha256:5feca99c17af94057417d744607b82dd0a664fd5e4ca98061480fd8b14b18d04",
-                "sha256:7538e495704e2ccda9b234b82423a4038f324f3a10c43bc088a1636180f11a41",
-                "sha256:760ad187b1041a154f0e4d0f6aae3e40fdb51d6de16e5c99aedadd9246450e9e",
-                "sha256:777a26c84bea6cd934422ac2e3b78863a37017618b6e5c08f92ef69853e765d3",
-                "sha256:95431a26309a21874005845c21118c83991c63ea800dd44843e42a916aec5899",
-                "sha256:9ad2c92ec681e02baf81fdfa056fe0d818645efa9af1f1cd5fd6f1bd2bdfd805",
-                "sha256:9c6d1a54552b5330bc657b7ef0eae25d00ba7ffe85d9ea8ae6540d2197a3788c",
-                "sha256:aee0c1256be6c07bd3e1263ff920c325b59849dc95392a05f258bb9b259cf39c",
-                "sha256:af3d4a73793725138d6b334d9d247ce7e5f084d96284ed23f22ee626a7b88e39",
-                "sha256:b36b4f3920103a25e1d5d024d155c504080959582b928e91cb608a65c3a49e1a",
-                "sha256:b9574c6f03f685070d859e75c7f9eeca02d6933273b5e69572e5ff9d5e3931c3",
-                "sha256:bff6ad71c81b3bba8fa35f0f1921fb24ff4476235a6e94a26ada2e54370e6da7",
-                "sha256:c190f0899e9f9f8b6b7863debfb739abcb21a5c054f911ca3596d12b8a4c4c7f",
-                "sha256:c907f561b1e83e93fad565bac5ba9c22d96a54e7ea0267c708bffe863cbe4075",
-                "sha256:cae53c389825d3b46fb37538441f75d6aecc4174f615d048321b716df2757fb0",
-                "sha256:dd4a21253f42b8d2b48410cb31fe501d32f8b9fbeb1f55063ad102fe9c425e40",
-                "sha256:dde816ca9dac1d9c01dd504ea5967821606f02e510438120091b84e852367428",
-                "sha256:f2362f3cb0f3172c42938946dbc5b7843c2a28aec307c49100c8b38764eb6927",
-                "sha256:f328adcfebed9f11301eaedfa48e15bdece9b519fb27e6a8c01aa52a17ec31b3",
-                "sha256:f8afcf15cc511ada719a88e013cec87c11aff7b91f019295eb4530f96fe5ef2f",
-                "sha256:fb1bbeac803adea29cedd70781399c99138358c26d05fcbd23c13016b7f5ec65"
-            ],
-            "markers": "python_version < '3.8' and implementation_name == 'cpython'",
-            "version": "==1.4.3"
-        },
-        "typing-extensions": {
-            "hashes": [
-                "sha256:0ac0f89795dd19de6b97debb0c6af1c70987fd80a2d62d1958f7e56fcc31b497",
-                "sha256:50b6f157849174217d0656f99dc82fe932884fb250826c18350e159ec6cdf342",
-                "sha256:779383f6086d90c99ae41cf0ff39aac8a7937a9283ce0a414e5dd782f4c94a84"
-            ],
-            "index": "pypi",
-            "version": "==3.10.0.0"
-        },
-        "urwid": {
-            "hashes": [
-                "sha256:588bee9c1cb208d0906a9f73c613d2bd32c3ed3702012f51efe318a3f2127eae"
-            ],
-            "index": "pypi",
-            "version": "==2.1.2"
-        },
-        "urwid-readline": {
-            "hashes": [
-                "sha256:018020cbc864bb5ed87be17dc26b069eae2755cb29f3a9c569aac3bded1efaf4"
-            ],
-            "index": "pypi",
-            "version": "==0.13"
-        },
-        "virtualenv": {
-            "hashes": [
-                "sha256:14fdf849f80dbb29a4eb6caa9875d476ee2a5cf76a5f5415fa2f1606010ab467",
-                "sha256:2b0126166ea7c9c3661f5b8e06773d28f83322de7a3ff7d06f0aed18c9de6a76"
-            ],
-            "index": "pypi",
-            "version": "==20.4.7"
-        },
-        "wrapt": {
-            "hashes": [
-                "sha256:b62ffa81fb85f4332a4f609cab4ac40709470da05643a082ec1eb88e6d9b97d7"
-            ],
-            "version": "==1.12.1"
-        },
-        "zipp": {
-            "hashes": [
-                "sha256:3607921face881ba3e026887d8150cca609d517579abe052ac81fc5aeffdbd76",
-                "sha256:51cb66cc54621609dd593d1787f286ee42a5c0adbb4b29abea5a63edc3e03098"
-            ],
-            "index": "pypi",
-            "version": "==3.4.1"
-        }
-    }
-}
diff --git a/python/README.rst b/python/README.rst
index 9c1fceaee7..d62e71528d 100644
--- a/python/README.rst
+++ b/python/README.rst
@@ -77,9 +77,6 @@ Files in this directory
 - ``MANIFEST.in`` is read by python setuptools, it specifies additional files
   that should be included by a source distribution.
 - ``PACKAGE.rst`` is used as the README file that is visible on PyPI.org.
-- ``Pipfile`` is used by Pipenv to generate ``Pipfile.lock``.
-- ``Pipfile.lock`` is a set of pinned package dependencies that this package
-  is tested under in our CI suite. It is used by ``make check-pipenv``.
 - ``README.rst`` you are here!
 - ``VERSION`` contains the PEP-440 compliant version used to describe
   this package; it is referenced by ``setup.cfg``.
diff --git a/python/setup.cfg b/python/setup.cfg
index c2c61c7519..c16bedf398 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -32,9 +32,7 @@ packages =
 * = py.typed
 
 [options.extras_require]
-# For the devel group, When adding new dependencies or bumping the minimum
-# version, use e.g. "pipenv install --dev pylint==3.0.0".
-# Subsequently, edit 'Pipfile' to remove e.g. 'pylint = "==3.0.0'.
+# Remember to update tests/minreqs.txt if changing anything below:
 devel =
     avocado-framework >= 90.0
     flake8 >= 3.6.0
diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
new file mode 100644
index 0000000000..dfb8abb155
--- /dev/null
+++ b/python/tests/minreqs.txt
@@ -0,0 +1,45 @@
+# This file lists the ***oldest possible dependencies*** needed to run
+# "make check" successfully under ***Python 3.6***. It is used primarily
+# by GitLab CI to ensure that our stated minimum versions in setup.cfg
+# are truthful and regularly validated.
+#
+# This file should not contain any dependencies that are not expressed
+# by the [devel] section of setup.cfg, except for transitive
+# dependencies which must be enumerated here explicitly to eliminate
+# dependency resolution ambiguity.
+#
+# When adding new dependencies, pin the very oldest non-yanked version
+# on PyPI that allows the test suite to pass.
+
+# Dependencies for the TUI addon (Required for successful linting)
+urwid==2.1.2
+urwid-readline==0.13
+Pygments==2.9.0
+
+# Dependencies for FUSE support for qom-fuse
+fusepy==2.0.4
+
+# Test-runners, utilities, etc.
+avocado-framework==90.0
+
+# Linters
+flake8==3.6.0
+isort==5.1.2
+mypy==0.780
+pylint==2.8.0
+
+# Transitive flake8 dependencies
+mccabe==0.6.0
+pycodestyle==2.4.0
+pyflakes==2.0.0
+
+# Transitive mypy dependencies
+mypy-extensions==0.4.3
+typed-ast==1.4.0
+typing-extensions==3.7.4
+
+# Transitive pylint dependencies
+astroid==2.5.4
+lazy-object-proxy==1.4.0
+toml==0.10.0
+wrapt==1.12.1
diff --git a/tests/docker/dockerfiles/python.docker b/tests/docker/dockerfiles/python.docker
index 56d88417df..175c10a34e 100644
--- a/tests/docker/dockerfiles/python.docker
+++ b/tests/docker/dockerfiles/python.docker
@@ -7,7 +7,6 @@ MAINTAINER John Snow <jsnow@redhat.com>
 ENV PACKAGES \
     gcc \
     make \
-    pipenv \
     python3 \
     python3-pip \
     python3-tox \
-- 
2.39.2



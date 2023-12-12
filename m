Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8342A80F265
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:24:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5XV-0007hC-Rf; Tue, 12 Dec 2023 11:23:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD5XU-0007h2-J1
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:23:20 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD5XR-0002xj-En
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:23:20 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40c2d50bfbfso28975085e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398195; x=1703002995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fCRez/S+3jb3oru71S+0zvbLl9dsCL7HJqTGLOdN3l8=;
 b=hXz2lrwNnblZagAYTZhm2L0fxV0a+a87vlKyUKsG2TjSloUTR4EzN91MplAuyfUttI
 A3T/3o4j04SlaR/y29S0Dn94AaMIjWWB68nybZIZb+lzNoma0hWyRF8+kGmNymEf7GwG
 2l1P1GAFR8iNt39zSkMS5dW/+dZtgIM8g7zWQREz2ifLxODS/LKfe23WAm7veIWzcXbd
 j9QvS0XrZc+w5DJKYYnCwlvxSMKtrTwmW/6uP6iJpRi39tqE/9EL9VJB0CsUZ6EiDQFL
 b7aIp8Sy9GVQNvG8howGv0b/wfux1CMQae3xs72f04xJkZiigUyt/ssfI1WQCw18vfLH
 313A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398195; x=1703002995;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fCRez/S+3jb3oru71S+0zvbLl9dsCL7HJqTGLOdN3l8=;
 b=vAZ8YtIdqK7r5qmfr7kvabvY4vfmPJVW4fxUTd1OqXs5hbxzCLcMVLExvTtnQ2BlgU
 y0bbJkEMNuIHnvEC2zMszk56qmtkcfnpL1Gkbj+D08VJM4EAFHeuBQOji5UIGfStbyUO
 NxwB0nY1SLzS0aYKpoPe5bPmxAskeoZbpl55fG1kDrMOsEUQxBdgq90XOmCxq5wHFFkT
 4yO8yKzR1Tm57xDhObuf0IWbw0WDcU4ZB//3je14ANAZaofgpu2qrqVl47tgCOFhky/7
 6+rZAKfDWUuxhAeTauo5W4gg+SSw16Fc0IqCH+n1HOq3zQF3oyH2vrCtySCJ2mJkW8m6
 YqgQ==
X-Gm-Message-State: AOJu0Yz1aoEFYXzja8V6P6NB8BfpQm2BHyfCfxgA9CaAlKwCDkksoQZ/
 y1J4+L99b4j+VDUfqL2brrpDYN9lgscSKBDDIn8=
X-Google-Smtp-Source: AGHT+IF7EF/d5MiG47Bm5MX0ovyIqlXVAC6lU+akTSr53KktUgdl07nExxJUlBUoi0T/Q3RPVnHbug==
X-Received: by 2002:a7b:cb4e:0:b0:40c:4378:f119 with SMTP id
 v14-20020a7bcb4e000000b0040c4378f119mr2172628wmj.157.1702398195648; 
 Tue, 12 Dec 2023 08:23:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a5d48cd000000b0033609750752sm10817673wrs.8.2023.12.12.08.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 08:23:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH for-9.0] docs/devel/docs: Document .hx file syntax
Date: Tue, 12 Dec 2023 16:23:13 +0000
Message-Id: <20231212162313.1742462-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We don't currently document the syntax of .hx files anywhere
except in a few comments at the top of individual .hx files.
We don't even have somewhere in the developer docs where we
could do this.

Add a new files docs/devel/docs.rst which can be a place to
document how our docs build process works. For the moment,
put in only a brief introductory paragraph and the documentation
of the .hx files. We could later add to this file by for
example describing how the QAPI-schema-to-docs process works,
or anything else that developers might need to know about
how to add documentation.

Make the .hx files refer to this doc file, and clean
up their header comments to be more accurate for the
usage in each file and less cut-n-pasted.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
My motivation here is that we're about to add support for
extending the SRST directive to specify a label so we
can hyperlink to a documentation fragment; this gives us
somewhere we can document the syntax for that.
---
 MAINTAINERS                |  1 +
 docs/devel/docs.rst        | 60 ++++++++++++++++++++++++++++++++++++++
 docs/devel/index-build.rst |  1 +
 hmp-commands-info.hx       | 10 +++----
 hmp-commands.hx            | 10 +++----
 qemu-img-cmds.hx           |  2 ++
 qemu-options.hx            |  2 ++
 7 files changed, 76 insertions(+), 10 deletions(-)
 create mode 100644 docs/devel/docs.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 695e0bd34fb..49b8ca9d1a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4149,6 +4149,7 @@ F: docs/conf.py
 F: docs/*/conf.py
 F: docs/sphinx/
 F: docs/_templates/
+F: docs/devel/docs.rst
 
 Miscellaneous
 -------------
diff --git a/docs/devel/docs.rst b/docs/devel/docs.rst
new file mode 100644
index 00000000000..7da067905b8
--- /dev/null
+++ b/docs/devel/docs.rst
@@ -0,0 +1,60 @@
+
+==================
+QEMU Documentation
+==================
+
+QEMU's documentation is written in reStructuredText format and
+built using the Sphinx documentation generator. We generate both
+the HTML manual and the manpages from the some documentation sources.
+
+hxtool and .hx files
+--------------------
+
+The documentation for QEMU command line options and Human Monitor Protocol
+(HMP) commands is written in files with the ``.hx`` suffix. These
+are processed in two ways:
+
+ * ``scripts/hxtool`` creates C header files from them, which are included
+   in QEMU to do things like handle the ``--help`` option output
+ * a Sphinx extension in ``docs/sphinx/hxtool.py`` generates rST output
+   to be included in the HTML or manpage documentation
+
+The syntax of these ``.hx`` files is simple. It is broadly an
+alternation of C code put into the C output and rST format text
+put into the documention. A few special directives are recognised;
+these are all-caps and must be at the beginning of the line.
+
+``HXCOMM`` is the comment marker. The line, including any arbitrary
+text after the marker, is discarded and appears neither in the C output
+nor the documentation output.
+
+``SRST`` starts a reStructuredText section. Following lines
+are put into the documentation verbatim, and discarded from the C output.
+
+``ERST`` ends the documentation section started with ``SRST``,
+and switches back to a C code section.
+
+``DEFHEADING()`` defines a heading that should appear in both the
+``--help`` output and in the documentation. This directive should
+be in the C code block. If there is a string inside the brackets,
+this is the heading to use. If this string is empty, it produces
+a blank line in the ``--help`` output and is ignored for the rST
+output.
+
+``ARCHHEADING()`` is a variant of ``DEFHEADING()`` which produces
+the heading only if the specified guest architecture was compiled
+into QEMU. This should be avoided in new documentation.
+
+Within C code sections, you should check the comments at the top
+of the file to see what the expected usage is, because this
+varies between files. For instance in ``qemu-options.hx`` we use
+the ``DEF()`` macro to define each option and specify its ``--help``
+text, but in ``hmp-commands.hx`` the C code sections are elements
+of an array of structs of type ``HMPCommand`` which define the
+name, behaviour and help text for each monitor command.
+
+In the file ``qemu-options.hx``, do not try to define a
+reStructuredText label within a documentation section. This file
+is included into two separate Sphinx documents, and some
+versions of Sphinx will complain about the duplicate label
+that results.
diff --git a/docs/devel/index-build.rst b/docs/devel/index-build.rst
index 57e8d39d985..90b406ca0ed 100644
--- a/docs/devel/index-build.rst
+++ b/docs/devel/index-build.rst
@@ -10,6 +10,7 @@ the basics if you are adding new files and targets to the build.
 
    build-system
    kconfig
+   docs
    testing
    acpi-bits
    qtest
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index f5b37eb74ab..da120f82a32 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -1,8 +1,8 @@
-HXCOMM Use DEFHEADING() to define headings in both help text and rST.
-HXCOMM Text between SRST and ERST is copied to the rST version and
-HXCOMM discarded from C version.
-HXCOMM DEF(command, args, callback, arg_string, help) is used to construct
-HXCOMM monitor info commands
+HXCOMM See docs/devel/docs.rst for the format of this file.
+HXCOMM
+HXCOMM This file defines the contents of an array of HMPCommand structs
+HXCOMM which specify the name, behaviour and help text for HMP commands.
+HXCOMM Text between SRST and ERST is rST format documentation.
 HXCOMM HXCOMM can be used for comments, discarded from both rST and C.
 HXCOMM
 HXCOMM In this file, generally SRST fragments should have two extra
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 765349ed149..2db5701d49c 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1,8 +1,8 @@
-HXCOMM Use DEFHEADING() to define headings in both help text and rST.
-HXCOMM Text between SRST and ERST is copied to the rST version and
-HXCOMM discarded from C version.
-HXCOMM DEF(command, args, callback, arg_string, help) is used to construct
-HXCOMM monitor commands
+HXCOMM See docs/devel/docs.rst for the format of this file.
+HXCOMM
+HXCOMM This file defines the contents of an array of HMPCommand structs
+HXCOMM which specify the name, behaviour and help text for HMP commands.
+HXCOMM Text between SRST and ERST is rST format documentation.
 HXCOMM HXCOMM can be used for comments, discarded from both rST and C.
 
 
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 068692d13eb..c9dd70a8920 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -1,3 +1,5 @@
+HXCOMM See docs/devel/docs.rst for the format of this file.
+HXCOMM
 HXCOMM Keep the list of subcommands sorted by name.
 HXCOMM Use DEFHEADING() to define headings in both help text and rST
 HXCOMM Text between SRST and ERST are copied to rST version and
diff --git a/qemu-options.hx b/qemu-options.hx
index 42fd09e4de9..d3e31e65c25 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1,3 +1,5 @@
+HXCOMM See docs/devel/docs.rst for the format of this file.
+HXCOMM
 HXCOMM Use DEFHEADING() to define headings in both help text and rST.
 HXCOMM Text between SRST and ERST is copied to the rST version and
 HXCOMM discarded from C version.
-- 
2.34.1



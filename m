Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DD17804C7
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 05:38:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWqIL-0001mX-9K; Thu, 17 Aug 2023 23:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqII-0001lV-Mx
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:37:02 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqIF-0005kU-WC
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:37:02 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6887059f121so405724b3a.3
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 20:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1692329818; x=1692934618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3YJsyqXQrs0zcYRn0vpvlIS4/nJLrndNcBYxxc7MqeI=;
 b=wOCaTWrajJ2WFMlvmVzkK6/vorhprtEzacBvplrT/lfS3bRgeFAIalDVdCRMRGa6bk
 gy/ptlwu55YosHhTm6pZWsKokBGhastw84u28LA6mbY2C1+DYw9gUibD5pOW+3jPpw7B
 4YgaAwUpQMeFwBKZsD+Bq3A9o9rUpgSJCTI+LTgfemzwGSD5yQdllB23k8VOzNALv3sN
 3B3fpOilx1AsCxdo+oyIxn4ACFGRkPWGyiu03n80YFJGlNJc66HV+dUghU+UWc4FICxa
 BA/1QWTMDQd+IUzE1Lx65pkEupCzKbYbc1n71OrCSBNGkUT5m8BBr/zYVpryQIZlsr2I
 sjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692329818; x=1692934618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3YJsyqXQrs0zcYRn0vpvlIS4/nJLrndNcBYxxc7MqeI=;
 b=VQauBpeMNuNmLdZUN2lzsQkuJ9ZcAco9SKUGXf6jixaqdXWOLbdeARt/yhQsRao6Cg
 Tq3cQTxmcyqziM6TxY/3tGWnwHjH6Ds8gPjIIxjBAlbYBBSyN8crbA4lzVHn2oqKsDi8
 T2+OwD85At/5MafCTO6Ae9eH9F5EzwGOjmNyDrrFAmbtyP1nDAO5dwshbeG9ABELSNsG
 MGohPR7aG+nWiQphBePhthKsyIoVhH+VTXX6rQxA/VZ1onnmxWYbCvkwMHgQwT/gTt7l
 qfRDG0Evxc3ATRlPUWec7M0GH22l78spVBdyAACvqsLG2dhaX7Tg6Q7oY7FD+19CsO55
 I69w==
X-Gm-Message-State: AOJu0YyyOwSCC8DPr9rlkKWYxY6Fl/fDEy5WrWSCdC0tMCzLVLYjzgWy
 uBmXCJG0HHA6hzpJA3x9b9UYNQ==
X-Google-Smtp-Source: AGHT+IGw8jm8uKOjzhE7dfEcaML80nky1rRggDrkk/sPcb+RbhJhM1RFm27QtPPrAqjXiH2ewPzyDA==
X-Received: by 2002:a05:6a20:7348:b0:140:a6ec:b56a with SMTP id
 v8-20020a056a20734800b00140a6ecb56amr1960524pzc.3.1692329818407; 
 Thu, 17 Aug 2023 20:36:58 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 c24-20020aa781d8000000b00686a80f431dsm484135pfn.126.2023.08.17.20.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 20:36:58 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH RESEND v5 02/26] gdbstub: Introduce GDBFeature structure
Date: Fri, 18 Aug 2023 12:36:21 +0900
Message-ID: <20230818033648.8326-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818033648.8326-1-akihiko.odaki@daynix.com>
References: <20230818033648.8326-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Before this change, the information from a XML file was stored in an
array that is not descriptive. Introduce a dedicated structure type to
make it easier to understand and to extend with more fields.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS             |  2 +-
 meson.build             |  2 +-
 include/exec/gdbstub.h  |  9 ++++--
 gdbstub/gdbstub.c       |  4 +--
 stubs/gdbstub.c         |  6 ++--
 scripts/feature_to_c.py | 48 ++++++++++++++++++++++++++++
 scripts/feature_to_c.sh | 69 -----------------------------------------
 7 files changed, 62 insertions(+), 78 deletions(-)
 create mode 100755 scripts/feature_to_c.py
 delete mode 100644 scripts/feature_to_c.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 12e59b6b27..514ac74101 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2826,7 +2826,7 @@ F: include/exec/gdbstub.h
 F: include/gdbstub/*
 F: gdb-xml/
 F: tests/tcg/multiarch/gdbstub/
-F: scripts/feature_to_c.sh
+F: scripts/feature_to_c.py
 F: scripts/probe-gdb-support.py
 
 Memory API
diff --git a/meson.build b/meson.build
index 98e68ef0b1..5c633f7e01 100644
--- a/meson.build
+++ b/meson.build
@@ -3683,7 +3683,7 @@ common_all = static_library('common',
                             dependencies: common_all.dependencies(),
                             name_suffix: 'fa')
 
-feature_to_c = find_program('scripts/feature_to_c.sh')
+feature_to_c = find_program('scripts/feature_to_c.py')
 
 if targetos == 'darwin'
   entitlement = find_program('scripts/entitlement.sh')
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 7d743fe1e9..3f08093321 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -10,6 +10,11 @@
 #define GDB_WATCHPOINT_READ      3
 #define GDB_WATCHPOINT_ACCESS    4
 
+typedef struct GDBFeature {
+    const char *xmlname;
+    const char *xml;
+} GDBFeature;
+
 
 /* Get or set a register.  Returns the size of the register.  */
 typedef int (*gdb_get_reg_cb)(CPUArchState *env, GByteArray *buf, int reg);
@@ -38,7 +43,7 @@ void gdb_set_stop_cpu(CPUState *cpu);
  */
 extern bool gdb_has_xml;
 
-/* in gdbstub-xml.c, generated by scripts/feature_to_c.sh */
-extern const char *const xml_builtin[][2];
+/* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
+extern const GDBFeature gdb_static_features[];
 
 #endif
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 6911b73c07..2772f07bbe 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -407,11 +407,11 @@ static const char *get_feature_xml(const char *p, const char **newp,
         }
     }
     for (i = 0; ; i++) {
-        name = xml_builtin[i][0];
+        name = gdb_static_features[i].xmlname;
         if (!name || (strncmp(name, p, len) == 0 && strlen(name) == len))
             break;
     }
-    return name ? xml_builtin[i][1] : NULL;
+    return name ? gdb_static_features[i].xml : NULL;
 }
 
 static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
diff --git a/stubs/gdbstub.c b/stubs/gdbstub.c
index 2b7aee50d3..580e20702b 100644
--- a/stubs/gdbstub.c
+++ b/stubs/gdbstub.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
-#include "exec/gdbstub.h"       /* xml_builtin */
+#include "exec/gdbstub.h"       /* gdb_static_features */
 
-const char *const xml_builtin[][2] = {
-  { NULL, NULL }
+const GDBFeature gdb_static_features[] = {
+  { NULL }
 };
diff --git a/scripts/feature_to_c.py b/scripts/feature_to_c.py
new file mode 100755
index 0000000000..bcbcb83beb
--- /dev/null
+++ b/scripts/feature_to_c.py
@@ -0,0 +1,48 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os, sys
+
+def writeliteral(indent, bytes):
+    sys.stdout.write(' ' * indent)
+    sys.stdout.write('"')
+    quoted = True
+
+    for c in bytes:
+        if not quoted:
+            sys.stdout.write('\n')
+            sys.stdout.write(' ' * indent)
+            sys.stdout.write('"')
+            quoted = True
+
+        if c == b'"'[0]:
+            sys.stdout.write('\\"')
+        elif c == b'\\'[0]:
+            sys.stdout.write('\\\\')
+        elif c == b'\n'[0]:
+            sys.stdout.write('\\n"')
+            quoted = False
+        elif c >= 32 and c < 127:
+            sys.stdout.write(c.to_bytes(1, 'big').decode())
+        else:
+            sys.stdout.write(f'\{c:03o}')
+
+    if quoted:
+        sys.stdout.write('"')
+
+sys.stdout.write('#include "qemu/osdep.h"\n' \
+                 '#include "exec/gdbstub.h"\n' \
+                 '\n'
+                 'const GDBFeature gdb_static_features[] = {\n')
+
+for input in sys.argv[1:]:
+    with open(input, 'rb') as file:
+        read = file.read()
+
+    sys.stdout.write('    {\n')
+    writeliteral(8, bytes(os.path.basename(input), 'utf-8'))
+    sys.stdout.write(',\n')
+    writeliteral(8, read)
+    sys.stdout.write('\n    },\n')
+
+sys.stdout.write('    { NULL }\n};\n')
diff --git a/scripts/feature_to_c.sh b/scripts/feature_to_c.sh
deleted file mode 100644
index c1f67c8f6a..0000000000
--- a/scripts/feature_to_c.sh
+++ /dev/null
@@ -1,69 +0,0 @@
-#!/bin/sh
-
-# Convert text files to compilable C arrays.
-#
-# Copyright (C) 2007 Free Software Foundation, Inc.
-#
-# This file is part of GDB.
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
-
-if test -z "$1"; then
-  echo "Usage: $0 INPUTFILE..."
-  exit 1
-fi
-
-for input; do
-  arrayname=xml_feature_$(echo $input | sed 's,.*/,,; s/[-.]/_/g')
-
-  ${AWK:-awk} 'BEGIN { n = 0
-      printf "#include \"qemu/osdep.h\"\n"
-      print "static const char '$arrayname'[] = {"
-      for (i = 0; i < 255; i++)
-        _ord_[sprintf("%c", i)] = i
-    } {
-      split($0, line, "");
-      printf "  "
-      for (i = 1; i <= length($0); i++) {
-        c = line[i]
-        if (c == "'\''") {
-          printf "'\''\\'\'''\'', "
-        } else if (c == "\\") {
-          printf "'\''\\\\'\'', "
-        } else if (_ord_[c] >= 32 && _ord_[c] < 127) {
-	  printf "'\''%s'\'', ", c
-        } else {
-          printf "'\''\\%03o'\'', ", _ord_[c]
-        }
-        if (i % 10 == 0)
-          printf "\n   "
-      }
-      printf "'\''\\n'\'', \n"
-    } END {
-      print "  0 };"
-    }' < $input
-done
-
-echo
-echo '#include "exec/gdbstub.h"'
-echo "const char *const xml_builtin[][2] = {"
-
-for input; do
-  basename=$(echo $input | sed 's,.*/,,')
-  arrayname=xml_feature_$(echo $input | sed 's,.*/,,; s/[-.]/_/g')
-  echo "  { \"$basename\", $arrayname },"
-done
-
-echo "  { (char *)0, (char *)0 }"
-echo "};"
-- 
2.41.0



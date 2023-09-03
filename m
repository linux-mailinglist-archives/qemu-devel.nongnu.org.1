Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C06BA790ADD
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 07:05:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcfHH-0002ea-4M; Sun, 03 Sep 2023 01:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcfH3-0002eD-79
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 01:03:49 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcfH0-0001fA-UU
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 01:03:48 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6bc9811558cso446076a34.0
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 22:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693717425; x=1694322225;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4xTQLVH/t4lJzmRwDn0811v9zJ3oM+fHQTaO7tk+O4=;
 b=V6A3HYYAlHtkRmJfEaji/sFYbVShTcY5RMTlWoteo2AXhXS/AIS3FT1Ad0sqyUvIFG
 UYm6rzrSRhPA0Jiz8C5vDuU1hg7ppci8ENOXgjwCnNe7KEuK5+H+Jj83Fv1uzNbYQpWL
 Lh1/yzzdGmqyYD8lxKW6FqcI+QDTT0JJZzzp14mSjWEirtZlLgX63PWBANaU9eWrbpc1
 wjXWZyKmetnF1kcjoJ3HynNdVSBqTZnw20L97UuxivV/csVqU/LVB1Lp0kPIn4BjLIWu
 JBX+uuQR/VxUXRaTcDpj+Bxxkfb3dRLYIcIgrl470vU3T3O3k1qOlTA55wzyGkwcp+Hp
 Bukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693717425; x=1694322225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4xTQLVH/t4lJzmRwDn0811v9zJ3oM+fHQTaO7tk+O4=;
 b=kmENIyksnBQEzEsBtQ3CdZKp/VKTAl6ART/ak9gqhl/Z3VHBZSwIbm45qG+cz3Znbk
 Z9f5PSVQVO3PN0hUOBp0yGyRapCnFDWKnDGaJSeaZwrK0NJWnWE8H6xLgFOkaMff2iuU
 bFVc71WUD0Xxfe/w+LN7dDXlC3OBUobRvBseMIUNj+PcO2zGNW+poVA3pgUCI2AuDU6G
 vMwzT+V6eWKwTSeQmhKWeVBWsoXEQJhcqN19n9GssrulrXo5CWsChn03JPTV4p5MBp1S
 6+omA+FmN2NOFaooL1E/UsNhMo4unvsbVEf+iB26kVpMNuOrvqUCqSWHY68/o5hCPuR6
 hVHg==
X-Gm-Message-State: AOJu0Yyfa1hKXu30FLjo/DEmFmwDNh9fUq3l1FMMMt4DLC241CjIFjWW
 P03hseu6xKlT5ehOVi84S+cuuA==
X-Google-Smtp-Source: AGHT+IG0/w5J/TKSNz4r5HxF1fS7r9itlpoTgbf5l2l+y6B8AZzBAq/U2aT6JJQva8eGJpURWcso+w==
X-Received: by 2002:a05:6830:1b65:b0:6bd:152f:9913 with SMTP id
 d5-20020a0568301b6500b006bd152f9913mr7357239ote.29.1693717425626; 
 Sat, 02 Sep 2023 22:03:45 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a170902f68b00b001b8af7f632asm5324835plg.176.2023.09.02.22.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 22:03:45 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH v6 01/18] gdbstub: Add num_regs member to GDBFeature
Date: Sun,  3 Sep 2023 14:03:09 +0900
Message-ID: <20230903050338.35256-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230903050338.35256-1-akihiko.odaki@daynix.com>
References: <20230903050338.35256-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32a.google.com
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

Currently the number of registers exposed to GDB is written as magic
numbers in code. Derive the number of registers GDB actually see from
XML files to replace the magic numbers in code later.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/gdbstub.h  |  1 +
 scripts/feature_to_c.py | 46 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index ecbc60a934..7dc097fcf6 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -13,6 +13,7 @@
 typedef struct GDBFeature {
     const char *xmlname;
     const char *xml;
+    int num_regs;
 } GDBFeature;
 
 
diff --git a/scripts/feature_to_c.py b/scripts/feature_to_c.py
index bcbcb83beb..e04d6b2df7 100755
--- a/scripts/feature_to_c.py
+++ b/scripts/feature_to_c.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os, sys
+import os, sys, xml.etree.ElementTree
 
 def writeliteral(indent, bytes):
     sys.stdout.write(' ' * indent)
@@ -39,10 +39,52 @@ def writeliteral(indent, bytes):
     with open(input, 'rb') as file:
         read = file.read()
 
+    parser = xml.etree.ElementTree.XMLPullParser(['start', 'end'])
+    parser.feed(read)
+    events = parser.read_events()
+    event, element = next(events)
+    if event != 'start':
+        sys.stderr.write(f'unexpected event: {event}\n')
+        exit(1)
+    if element.tag != 'feature':
+        sys.stderr.write(f'unexpected start tag: {element.tag}\n')
+        exit(1)
+
+    regnum = 0
+    regnums = []
+    tags = ['feature']
+    for event, element in events:
+        if event == 'end':
+            if element.tag != tags[len(tags) - 1]:
+                sys.stderr.write(f'unexpected end tag: {element.tag}\n')
+                exit(1)
+
+            tags.pop()
+            if element.tag == 'feature':
+                break
+        elif event == 'start':
+            if len(tags) < 2 and element.tag == 'reg':
+                if 'regnum' in element.attrib:
+                    regnum = int(element.attrib['regnum'])
+
+                regnums.append(regnum)
+                regnum += 1
+
+            tags.append(element.tag)
+        else:
+            raise Exception(f'unexpected event: {event}\n')
+
+    if len(tags):
+        sys.stderr.write('unterminated feature tag\n')
+        exit(1)
+
+    base_reg = min(regnums)
+    num_regs = max(regnums) - base_reg + 1 if len(regnums) else 0
+
     sys.stdout.write('    {\n')
     writeliteral(8, bytes(os.path.basename(input), 'utf-8'))
     sys.stdout.write(',\n')
     writeliteral(8, read)
-    sys.stdout.write('\n    },\n')
+    sys.stdout.write(f',\n        {num_regs},\n    }},\n')
 
 sys.stdout.write('    { NULL }\n};\n')
-- 
2.42.0



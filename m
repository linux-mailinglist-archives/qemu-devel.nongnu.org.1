Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 051B67D66D5
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:32:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvaFE-00020E-S5; Wed, 25 Oct 2023 05:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvaEs-0001hI-Cq
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:31:46 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvaEq-0002Af-CS
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:31:45 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ca215cc713so35669895ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 02:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698226303; x=1698831103;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=21Z173hVFszR8s4nfjM3OYWaOyCmfZYL9fagBQvy26Q=;
 b=Nx78kSk21XhL0PHtUuUkDVjZCgckKJlKnMXCaHGbDLGv+rpAUtb5lbjp/O9o+tBpii
 afnN1gPd5VVbaY+9yBIoZO9GIjA26OoYXrgfEnPlpkAXXPr8yu5g7mScFManVCe5AXsV
 U7/wHTxzFgTb52nYlQnliRF6fZBuQvmZ9fgSKZV86hclOY6wy4lgeUW4whpp5iQ4sLHG
 2N5ZtS6lkfWkfsk2RwMY1+FqSjlDRehP49gUO/4/Ga4ki81aGvstWtucDGSC2Rm/OGsh
 1o5bjI2lMJ6YjWII8YkiAnTAESDZHtHQY4J7CcQp/wo+ZfypDxFLbxQQ13+mVCSO/eKW
 oekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698226303; x=1698831103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=21Z173hVFszR8s4nfjM3OYWaOyCmfZYL9fagBQvy26Q=;
 b=B2n9Y/BXA50P6o+k5kjjF7P6KH5fzIwmGpoJNmX5Dxy7r4PKikLWkeENf9t/NWjY5P
 vr0xknYAV2UU6PKMZYKMZofLdgij+ArQgRDFp8Zxgf5DD13cVB3TM5OzCQ8qfYMCaWjV
 EzAPsJq+eBNoeph0UJRd8KYlKItlZwMtLyFm4Ptp7DaGY9DQzLzaE4TaS1w1pP4dn55G
 nETVKxDBopwdOMVT1Fq9wakkBE3HARi9mOfDD+fvi3ZzZUElGHcAtOcmeoEOwcVmyjec
 HPk8C4jkCQbcIl7YXSjEM5mkNi8ecMUf9X/TaROo0ebu8twsnLzEsZcWTNQoxcm4NKw9
 SuLg==
X-Gm-Message-State: AOJu0YwGP7GagRIhvh9Fcp+8mp9CNi5TaF0u3G80QYKSdMFZpYsilDea
 rEfhiu8makGHlLRpnBwQzgwzuA==
X-Google-Smtp-Source: AGHT+IFlIoPRgVlHZuPd0AhN8EYVuenuVo3Xhi3tMPwfWyjw3gvnyf89EVxT1Bu1mhxMRYcHB/d4nA==
X-Received: by 2002:a17:902:f10a:b0:1c6:2e2c:e6f4 with SMTP id
 e10-20020a170902f10a00b001c62e2ce6f4mr10784355plb.23.1698226302776; 
 Wed, 25 Oct 2023 02:31:42 -0700 (PDT)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 12-20020a170902c14c00b001c75a07f62esm8809231plj.34.2023.10.25.02.31.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 02:31:42 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH v16 01/18] gdbstub: Add num_regs member to GDBFeature
Date: Wed, 25 Oct 2023 18:31:01 +0900
Message-ID: <20231025093128.33116-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025093128.33116-1-akihiko.odaki@daynix.com>
References: <20231025093128.33116-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
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
index 1a01c35f8e..a43aa34dad 100644
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



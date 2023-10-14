Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D65857C928C
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 05:40:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrVVJ-0001lp-1f; Fri, 13 Oct 2023 23:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrVVG-0001lD-WE
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 23:39:51 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrVVF-0004by-Gb
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 23:39:50 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-690fe10b6a4so2264756b3a.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 20:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697254788; x=1697859588;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=21Z173hVFszR8s4nfjM3OYWaOyCmfZYL9fagBQvy26Q=;
 b=RH1wjgxFlXNt1qpZ7JXhd6DXCvZSRypf5Q51ElvkS7p0jneeGM0efa6978n6/e99fN
 EVaEMJx4+ACeHxzVbIKDEheae/GveIE21ZSqeSpNMtlDDsvQkoMkH82rF7GgNQ0REHji
 oD9SN0izuNer3AgpXTX/uwWNUoBO5M56boQSS4ua8DrjhyY9Nq4ieXS27RyEMB/3vOZP
 iOAwvfT/yiITdBytcetZrSXZ1lPwg4XOPl694KqZGwKRXsQ4F7tkbaIiRxBDG+0xpHCR
 7ZxlCq+z4/2cBQpkUskuG1gPkcbs6g799KfAKWwr2mw1PZjFpA5lW74ZcCE1ya4AmvX2
 LBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697254788; x=1697859588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=21Z173hVFszR8s4nfjM3OYWaOyCmfZYL9fagBQvy26Q=;
 b=PgkyC4uZvO6+JiIkAfxDpunq92WLZd3QiskEzWZ4PK3MKYz2QZrl7O5OwVOqx4uHGT
 niG6Hx1Ga30ylmKw6Qx97au+tY+5wYQtSWG58k7COm76/PC5Bj6ttwlnS6b+/uTl6Ds4
 gsw/+CDyUKcM73cVqiUAdCY6gUMDr4jg85CR/oI96n4nmaRKwEatlFAD1Sz3cYLf6I47
 PM6g223bMGLYDkfieUYkNesGDSZtqjX2e/5juVl66zVOTj+N8Qu2wAaPHTnFEA0WD3i6
 7zViBq/ZucT2nxpL17PC58rkUyxEMdHB16/HcDOTmwNG6fXCnzhppCX0nkRG49/eA19L
 7E/A==
X-Gm-Message-State: AOJu0YxBZUx/BZIqc9vi/rG/4Au6sH6jFnQ7qX4WWFaYrsata+ZIB7VJ
 hY14PLSVQ45VRVLWcU5kMMNUGA==
X-Google-Smtp-Source: AGHT+IEwnvWopOyhvITDPAoAOtkI5nMVIw7gX9uxiykRZDxg7bXPOniH5q0kwqSEdsNE88z/U9zV0w==
X-Received: by 2002:a05:6a00:1506:b0:690:cd6e:8d38 with SMTP id
 q6-20020a056a00150600b00690cd6e8d38mr35871625pfu.25.1697254788156; 
 Fri, 13 Oct 2023 20:39:48 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 w26-20020aa79a1a000000b0069b772c4325sm2034789pfj.87.2023.10.13.20.39.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 20:39:47 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH v12 01/18] gdbstub: Add num_regs member to GDBFeature
Date: Sat, 14 Oct 2023 12:39:20 +0900
Message-ID: <20231014033940.15679-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231014033940.15679-1-akihiko.odaki@daynix.com>
References: <20231014033940.15679-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
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



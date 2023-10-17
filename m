Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D09937CCBDE
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 21:11:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qspS1-0004Ef-4e; Tue, 17 Oct 2023 15:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qspRp-00048R-So
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:09:45 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qspRn-0001ak-Ql
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:09:45 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c0ecb9a075so40900625ad.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 12:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697569781; x=1698174581;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=21Z173hVFszR8s4nfjM3OYWaOyCmfZYL9fagBQvy26Q=;
 b=ABYzdbQS9eCrZBOD/zgidsVmW0FvoCy6FHp1lfb7ZyP16zt/QxeTM/Mp2ccJLpuE04
 pcYEPYaVNFkFdozZesoZO0QO+TdVQPIzLo2pCoAMUDZteaJsakEIhZ3KC4Jqt6EWMs9u
 VxR3qtAQHEkBtOXiSnwsC/iAJ4E6C//9myaMv7JA+9Re0v+AgAzM2xYt3Noo39ZKAvKU
 KKO4ZFg8b1VGgoTmEj0y39pG9LLOcpbofuRvSHWaH78ARzk03L6EL3K8jvQxo5URU0Du
 UM2Pt7nxvyz8+ilCmBJ8haFd5FfRKCeEQWiO1DinNZAn1DWYX9PPEvQZwKSH3DnC8YsK
 e8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697569781; x=1698174581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=21Z173hVFszR8s4nfjM3OYWaOyCmfZYL9fagBQvy26Q=;
 b=sNN6G6jvxSX6GwZQYua2ULkMHulWRgJFobkK+zX9yO/uRioIhCNuF3Vfy8iL3chZzJ
 zsNWTXB9ZcMUoPf4RBPpOixHESrJlXSwsdWvWx/cupQRa6v0wcQ6Zc22TZA48Ny1ervJ
 OdEDeGn8EexRCbXEd743OCdPYWXKDIWvqyqZUHHFmDOp4WporAMTxHFgbNHFL4Bn2zPE
 QRPcztQPr/JD/WJ+nqdZnkaHTUgLA6Wu0A6zljy1b/TDg4r3qmQu/Ofa1tOkb3JZhCPV
 rNdU116JEJN4qKHhughmcLFh22iBWaHLocZABw8zX9nnL4Q23tuaFz/Q9jMl+fQS2pxO
 752Q==
X-Gm-Message-State: AOJu0YwllOG8hBODXeRF+x2JM+iMN6FUsiMHrFFKJxbPNOKQzpB01wgz
 Ug9V6F+aJAZ0P5pb7VCJIwwd7oUA0bncJioGHa2Ufw==
X-Google-Smtp-Source: AGHT+IHLhkI18AuFX4LevH8+l3pAv7byt7dEWcgDd+Rls68XRU6hHcujHL93Pgo/MhhTjR6Jxnm1LA==
X-Received: by 2002:a17:902:f688:b0:1c9:e830:160c with SMTP id
 l8-20020a170902f68800b001c9e830160cmr3577762plg.16.1697569781023; 
 Tue, 17 Oct 2023 12:09:41 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 p12-20020a170902bd0c00b001b850c9d7b3sm1935000pls.249.2023.10.17.12.09.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 12:09:40 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH v13 01/18] gdbstub: Add num_regs member to GDBFeature
Date: Wed, 18 Oct 2023 04:09:11 +0900
Message-ID: <20231017190931.16211-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017190931.16211-1-akihiko.odaki@daynix.com>
References: <20231017190931.16211-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
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



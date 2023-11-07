Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 496087E41D4
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:29:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N0I-0004R2-Te; Tue, 07 Nov 2023 09:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzu-0004Dj-OE
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:06 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzr-0007Yl-4X
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:06 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40859c464daso42043375e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367041; x=1699971841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZHYLdqoLGtFuY3dzHamisw3eOa1TzTuGsjgcCCYH8rk=;
 b=B+ZRwc0jSuS7pL+pbu6p+1u56svsNITOIZO7mX/W1AOjza7u9SQxsEuiluArzou7iV
 kQjRjfUfMpWZBrxyAu8n89xNJQgLM90oBoQN+aCq2fS/F0LzXKE+AZ4xr33SCm9vmQM1
 gXGSLAA0MXRaMRNL2EKHOSwQmFhkTE4gcPoBTCySPsxcyV5BYQXwXAY5dUWlG7P9/kjK
 ETHwwteBrXsOUZRS7wnTke/KF+qigglngO5VZSIfhT7m9P8CDCgpPe1SCjydUV1i2gXj
 Jc5HhRE2RPd/FGc/UON5XyYjbeBhqdYgrsj5ra4VQ8lJDKDl8TPym3Z9lukthtgBquMS
 2vcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367041; x=1699971841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZHYLdqoLGtFuY3dzHamisw3eOa1TzTuGsjgcCCYH8rk=;
 b=pX8yda0ROjKuoA7uJLb8Tu5Zq4fyBQQ5K9uRhV0+0r7hfWEKne6BbZJCv+tQUHbtAQ
 jmgDOM5gCSf3Gtq67z3qTSQlzZgKFSychzrELUc0jnk51SWGhxsFZOaTyARECsuJlNL+
 8va+wIJpM3fGdtCPB7YHro1GNucgDcaNXiAQd84U2V2Qr0fKnwijs2pD84bZkaB5I3Be
 GYmjtKsoZe8sGtnuy4aiVGFhEC2bWHEuBcTiOMw/6QRVCC3CwoalIywjcCOfkx2N7AE9
 0hvF/CnmBzqKmARQS2HbixGCmn1TYakowEM/+MrngRx8EA+ugbhDD5B38ZRZF8KhH1q5
 bDrA==
X-Gm-Message-State: AOJu0YzQ0BGgHqxWDcckWvfR52afZDuonnk20K7JcOc5/B9/0C68NEcJ
 uzp1jSHaF0sL+i8lBdck4BpJ2Q==
X-Google-Smtp-Source: AGHT+IHFzcgOpGKvgzMhPvspSFjR6W5wrvnbTAt03RpnisTb9217TmjSFRIDesppNjEquQ31/l5y9Q==
X-Received: by 2002:a05:6000:381:b0:32d:ae31:458c with SMTP id
 u1-20020a056000038100b0032dae31458cmr25341665wrf.33.1699367041668; 
 Tue, 07 Nov 2023 06:24:01 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 i16-20020a5d55d0000000b0032d8354fb43sm2504414wrw.76.2023.11.07.06.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:23:58 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 59C636575E;
 Tue,  7 Nov 2023 14:23:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PULL 08/23] gdbstub: Add num_regs member to GDBFeature
Date: Tue,  7 Nov 2023 14:23:39 +0000
Message-Id: <20231107142354.3151266-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Currently the number of registers exposed to GDB is written as magic
numbers in code. Derive the number of registers GDB actually see from
XML files to replace the magic numbers in code later.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231025093128.33116-2-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231106185112.2755262-9-alex.bennee@linaro.org>

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
index bcbcb83beb..e04d6b2df7 100644
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
2.39.2



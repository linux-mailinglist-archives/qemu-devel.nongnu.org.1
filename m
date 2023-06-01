Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD34F719710
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:36:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4eiJ-0007iu-W4; Thu, 01 Jun 2023 05:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4eiF-0007hL-TJ
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:35:20 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4ei0-0008Sy-5V
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:35:09 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4f3b9e54338so704596e87.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 02:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685612100; x=1688204100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iBmRFGSCUyWrpqUCkJ9/kvAcmY0X7VBtc3pe1bAu4Nw=;
 b=m+53Rqw4BvkMKcWgY8ijZYQZ3MvEhO4yd3IBzpmQXtgmat8Fuijcn8ZNKPpJQyO2Gq
 hnDP6OQNh8fYfyAERrj1toGGmwNqkcH+wCrSBrd42VH5mOcu/Vdu+o0XRK7A4hNcGKMj
 IPCUt2is3km3TLvkvpkm4lGzDT8Zt0xNmxY2p5LZTPxptADt+xXkYnrWK/9YSCozNVwc
 W7USHT5gnm1ZZZvkd3g0HcmgKdckwmcPnyzv/L1da5lC4ambnmmDTI50z0MrV8PveJ2L
 YUl7HbEO3LWXKanfwJ+Vvx5R2BidfMjvOx7XOWj/mT1VdtapjSkwy/sedFUscRS0gQQ5
 R0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685612100; x=1688204100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iBmRFGSCUyWrpqUCkJ9/kvAcmY0X7VBtc3pe1bAu4Nw=;
 b=ejcVYuO8/53YLpmd5n3WHmG7VUNxG+h+7lt1Ef1h+vqvonJbmiyvChOgULULiBgDzN
 43bj8VxWfEQevUUbZLZnoeXIhx6IeZ1iQOzsHr0pHCPlTvNd88yrXG9zN6q+5ZqChJJC
 irtr78Vgth9c9pNGWzB2dieDccD4tTX8V0OeFczUIZgvVFtcT0qruXcFTn8v5w72KW2p
 E0gK9aar8VL8gp4vIfw65sCjspkGDud2gx86DJLBsFf2O+vbWfG9dkJIQ1TsZKTyuy0+
 2SYmF3tsznvo0csn2EmJY1fQEzDQ923Vs2S8BDGbQFbUJhqF8KFs2+GIaq1/Kqb9T+Oq
 6eRQ==
X-Gm-Message-State: AC+VfDxCBaP27Uvz5xxllj1cWNYve+EMGUOVDEItoU/ZxyEFSbbL6AY0
 t1U/OG4DeT7Z4qveM7xg7A5XXFwCn0uC9geC3tI=
X-Google-Smtp-Source: ACHHUZ6I/c3Vdig/3dEpw7hPg7ojlr24arRB5bn20EiJfn+UgwFhv5q2+Xs3uImtPqAkjzdq/PSs+g==
X-Received: by 2002:ac2:5505:0:b0:4f3:b221:558c with SMTP id
 j5-20020ac25505000000b004f3b221558cmr914245lfk.43.1685612099981; 
 Thu, 01 Jun 2023 02:34:59 -0700 (PDT)
Received: from localhost.localdomain ([176.176.141.224])
 by smtp.gmail.com with ESMTPSA id
 n16-20020a1c7210000000b003f60119ee08sm1658709wmc.43.2023.06.01.02.34.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Jun 2023 02:34:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] scripts: Add qom-cast-macro-clean-cocci-gen.py
Date: Thu,  1 Jun 2023 11:34:51 +0200
Message-Id: <20230601093452.38972-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230601093452.38972-1-philmd@linaro.org>
References: <20230601093452.38972-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Add a script to generate Coccinelle semantic patch
removing all pointless QOM cast macro uses.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                               |  1 +
 scripts/qom-cast-macro-clean-cocci-gen.py | 49 +++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 scripts/qom-cast-macro-clean-cocci-gen.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b025a7b63..37a2412011 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3044,6 +3044,7 @@ F: include/qom/
 F: qapi/qom.json
 F: qapi/qdev.json
 F: scripts/coccinelle/qom-parent-type.cocci
+F: scripts/qom-cast-macro-clean-cocci-gen.py
 F: softmmu/qdev-monitor.c
 F: stubs/qdev.c
 F: qom/
diff --git a/scripts/qom-cast-macro-clean-cocci-gen.py b/scripts/qom-cast-macro-clean-cocci-gen.py
new file mode 100644
index 0000000000..2fa8438a14
--- /dev/null
+++ b/scripts/qom-cast-macro-clean-cocci-gen.py
@@ -0,0 +1,49 @@
+#!/usr/bin/env python3
+#
+# Generate a Coccinelle semantic patch to remove pointless QOM cast.
+#
+# Usage:
+#
+# $ qom-cast-macro-clean-cocci-gen.py $(git ls-files) > qom_pointless_cast.cocci
+# $ spatch \
+#           --macro-file scripts/cocci-macro-file.h \
+#           --sp-file qom_pointless_cast.cocci \
+#           --keep-comments \
+#           --use-gitgrep \
+#           --in-place \
+#           --dir .
+#
+# SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
+# SPDX-FileCopyrightText: 2023 Linaro Ltd.
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import re
+import sys
+
+assert len(sys.argv) > 0
+
+def print_cocci_rule(qom_typedef, qom_cast_macro):
+    print(f'''@@
+typedef {qom_typedef};
+{qom_typedef} *obj;
+@@
+-    {qom_cast_macro}(obj)
++    obj
+''')
+
+patterns = [
+    r'DECLARE_INSTANCE_CHECKER\((\w+),\W*(\w+),\W*TYPE_\w+\)',
+    r'DECLARE_OBJ_CHECKERS\((\w+),\W*\w+,\W*(\w+),\W*TYPE_\w+\)',
+    r'OBJECT_DECLARE_TYPE\((\w+),\W*\w+,\W*(\w+)\)',
+    r'OBJECT_DECLARE_SIMPLE_TYPE\((\w+),\W*(\w+)\)',
+    r'INTERFACE_CHECK\((\w+),\W*\(\w+\),\W*TYPE_(\w+)\)',
+]
+
+for fn in sys.argv[1:]:
+    try:
+        content = open(fn, 'rt').read()
+    except:
+        continue
+    for pattern in patterns:
+        for match in re.findall(pattern, content):
+            print_cocci_rule(match[0], match[1])
-- 
2.38.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5532E723704
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 07:58:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Pgb-0004rq-NB; Tue, 06 Jun 2023 01:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6PgY-0004r9-6D
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6PgW-0004Ag-HM
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686031007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DMQO0TnJoS6hEZikAOD2aAaF6PaDGIaaThsJFz5o7vI=;
 b=MsNbc7p3/Hgv+wM7PY220sJ64QbuzPyFck7KZVFWdZ69Lyte/Or68UJrpLx1l9ylW+zW2B
 RTGjxMWq5b3jiJ7JhLN24ufgv8yFbuNaErc5bYRDMWu6o6tihMgnt7X5JTL5HkKlzhoCFz
 Wcup+w73j8wn9bXlTca604ZMslge7rg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-1xvoFSsmMW2PJEnt90HCkQ-1; Tue, 06 Jun 2023 01:56:44 -0400
X-MC-Unique: 1xvoFSsmMW2PJEnt90HCkQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C84585A5AA;
 Tue,  6 Jun 2023 05:56:44 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 249712166B25;
 Tue,  6 Jun 2023 05:56:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 13/18] scripts: Add qom-cast-macro-clean-cocci-gen.py
Date: Tue,  6 Jun 2023 07:56:16 +0200
Message-Id: <20230606055621.523175-14-thuth@redhat.com>
In-Reply-To: <20230606055621.523175-1-thuth@redhat.com>
References: <20230606055621.523175-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Add a script to generate Coccinelle semantic patch
removing all pointless QOM cast macro uses.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230601093452.38972-2-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                               |  1 +
 scripts/qom-cast-macro-clean-cocci-gen.py | 49 +++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 scripts/qom-cast-macro-clean-cocci-gen.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 89f274f85e..b2137111f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3045,6 +3045,7 @@ F: include/qom/
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
2.31.1



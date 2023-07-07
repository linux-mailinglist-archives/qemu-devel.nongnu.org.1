Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D197374ACEA
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 10:31:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHgs5-0008Rj-Uy; Fri, 07 Jul 2023 04:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHgs2-0008Qx-1K
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:31:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHgrz-0003kl-Pb
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688718674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6aLnP5x9FyM2VP05wVgxwpWMLTRpTc/M1OFM5w15Vzg=;
 b=ZE2EguqlVxZXI0KUghoDI87QwLcs/kTHfUkW2sWn5PPb6eux/HYt+8544F7MEAT8K5tAwu
 i7L4xWtGaBO+M5fEXoOWTaZjqhwn4mPE7ra402Gk/vlJ7I2Hk09k2gJDdBpulxTimuDNbk
 ttaSeNcQ5zbNyDre2zlQ11Jmc8pvRkQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-yVflJKSiPTupBmIURp3g1Q-1; Fri, 07 Jul 2023 04:31:10 -0400
X-MC-Unique: yVflJKSiPTupBmIURp3g1Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F9BF104B531;
 Fri,  7 Jul 2023 08:31:10 +0000 (UTC)
Received: from kostyanf14nb.redhat.com (unknown [10.45.225.190])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C9431121330;
 Fri,  7 Jul 2023 08:31:09 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/4] QGA VSS: Add wrapper to send log to debugger and stderr
Date: Fri,  7 Jul 2023 11:31:02 +0300
Message-Id: <20230707083105.746811-2-kkostiuk@redhat.com>
In-Reply-To: <20230707083105.746811-1-kkostiuk@redhat.com>
References: <20230707083105.746811-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/vss-win32/meson.build   |  2 +-
 qga/vss-win32/vss-debug.cpp | 31 +++++++++++++++++++++++++++++++
 qga/vss-win32/vss-debug.h   | 24 ++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 qga/vss-win32/vss-debug.cpp
 create mode 100644 qga/vss-win32/vss-debug.h

diff --git a/qga/vss-win32/meson.build b/qga/vss-win32/meson.build
index 9483ccd3b8..0ac918910b 100644
--- a/qga/vss-win32/meson.build
+++ b/qga/vss-win32/meson.build
@@ -7,7 +7,7 @@ link_args = cc.get_supported_link_arguments([
 
 qga_vss = shared_module(
   'qga-vss',
-  ['requester.cpp', 'provider.cpp', 'install.cpp', genh],
+  ['requester.cpp', 'provider.cpp', 'install.cpp', 'vss-debug.cpp', genh],
   name_prefix: '',
   cpp_args: ['-Wno-unknown-pragmas', '-Wno-delete-non-virtual-dtor', '-Wno-non-virtual-dtor'],
   link_args: link_args,
diff --git a/qga/vss-win32/vss-debug.cpp b/qga/vss-win32/vss-debug.cpp
new file mode 100644
index 0000000000..de190a53f4
--- /dev/null
+++ b/qga/vss-win32/vss-debug.cpp
@@ -0,0 +1,31 @@
+/*
+ * QEMU Guest Agent VSS debug declarations
+ *
+ * Copyright (C) 2023 Red Hat Inc
+ *
+ * Authors:
+ *  Konstantin Kostiuk <kkostiuk@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "vss-common.h"
+
+void G_GNUC_PRINTF(2, 3)
+qga_debug_internal(const char *funcname, const char *fmt, ...)  {
+    char user_sting[512] = {0};
+    char full_string[640] = {0};
+
+    va_list args;
+    va_start(args, fmt);
+    vsnprintf(user_sting, 512, fmt, args);
+    va_end(args);
+
+    snprintf(full_string, 640, QGA_PROVIDER_NAME "[%lu]: %s %s\n",
+             GetCurrentThreadId(), funcname, user_sting);
+
+    OutputDebugString(full_string);
+    fprintf(stderr, "%s", full_string);
+}
diff --git a/qga/vss-win32/vss-debug.h b/qga/vss-win32/vss-debug.h
new file mode 100644
index 0000000000..4a15049a62
--- /dev/null
+++ b/qga/vss-win32/vss-debug.h
@@ -0,0 +1,24 @@
+/*
+ * QEMU Guest Agent VSS debug declarations
+ *
+ * Copyright (C) 2023 Red Hat Inc
+ *
+ * Authors:
+ *  Konstantin Kostiuk <kkostiuk@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include <vss-handles.h>
+
+#ifndef VSS_DEBUG_H
+#define VSS_DEBUG_H
+
+void qga_debug_internal(const char *funcname, const char *fmt, ...);
+
+#define qga_debug(fmt, ...) qga_debug_internal(__func__, fmt, ## __VA_ARGS__)
+#define qga_debug_begin qga_debug("begin")
+#define qga_debug_end qga_debug("end")
+
+#endif
-- 
2.34.1



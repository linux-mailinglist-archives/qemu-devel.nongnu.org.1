Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E77574D78C
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 15:30:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIqwI-0005NY-6g; Mon, 10 Jul 2023 09:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qIqwF-0005MK-0d
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:28:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qIqwD-0007AX-8J
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688995704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6sP+S1hHU5zII49m2W6wr1/TLQ9Jx5+7DabsHHBa7E=;
 b=MF2mubLjQfAeRnPX6i69y4OfI+3U7rApna1HcUKo8dVb0B3Jtikpg/gMcg4ZHFF6Xq0zYd
 qdYD+Pn+4tpTxK3uMmUrHNOfYg1TvqBggER7Qh9dvbHhhsllLIbE3O+CIVxCRhmmGXHy0H
 jThF+d0vH9liIIZm4XlNSvoCT36Z/AY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-AgmLQ1w9Me6PDm0sp-Xyug-1; Mon, 10 Jul 2023 09:28:20 -0400
X-MC-Unique: AgmLQ1w9Me6PDm0sp-Xyug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 908A78FD7A1;
 Mon, 10 Jul 2023 13:28:19 +0000 (UTC)
Received: from kostyanf14nb.redhat.com (unknown [10.45.225.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABA69111E3E4;
 Mon, 10 Jul 2023 13:28:18 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 4/7] QGA VSS: Add wrapper to send log to debugger and stderr
Date: Mon, 10 Jul 2023 16:28:07 +0300
Message-Id: <20230710132810.1049912-5-kkostiuk@redhat.com>
In-Reply-To: <20230710132810.1049912-1-kkostiuk@redhat.com>
References: <20230710132810.1049912-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/vss-win32/meson.build   |  2 +-
 qga/vss-win32/vss-debug.cpp | 39 +++++++++++++++++++++++++++++++++++++
 qga/vss-win32/vss-debug.h   | 25 ++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 1 deletion(-)
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
index 0000000000..820b1c6667
--- /dev/null
+++ b/qga/vss-win32/vss-debug.cpp
@@ -0,0 +1,39 @@
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
+#include "vss-debug.h"
+#include "vss-common.h"
+
+void qga_debug_internal(const char *funcname, const char *fmt, ...)
+{
+    char user_string[512] = {0};
+    char full_string[640] = {0};
+
+    va_list args;
+    va_start(args, fmt);
+    if (vsnprintf(user_string, _countof(user_string), fmt, args) <= 0) {
+        va_end(args);
+        return;
+    }
+
+    va_end(args);
+
+    if (snprintf(full_string, _countof(full_string),
+                 QGA_PROVIDER_NAME "[%lu]: %s %s\n",
+                 GetCurrentThreadId(), funcname, user_string) <= 0) {
+        return;
+    }
+
+    OutputDebugString(full_string);
+    fputs(full_string, stderr);
+}
diff --git a/qga/vss-win32/vss-debug.h b/qga/vss-win32/vss-debug.h
new file mode 100644
index 0000000000..7800457392
--- /dev/null
+++ b/qga/vss-win32/vss-debug.h
@@ -0,0 +1,25 @@
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
+#include <vss-handles.h>
+
+#ifndef VSS_DEBUG_H
+#define VSS_DEBUG_H
+
+void qga_debug_internal(const char *funcname, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
+
+#define qga_debug(fmt, ...) qga_debug_internal(__func__, fmt, ## __VA_ARGS__)
+#define qga_debug_begin qga_debug("begin")
+#define qga_debug_end qga_debug("end")
+
+#endif
-- 
2.34.1



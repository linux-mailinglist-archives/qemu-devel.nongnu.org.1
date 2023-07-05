Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E64C27485C1
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 16:14:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH3GA-0001P6-9u; Wed, 05 Jul 2023 10:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qH3G8-0001OM-DG
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 10:13:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qH3G6-00045y-T5
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 10:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688566409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HMhvn4cltBWZquAtdssTREJJmfKNdq/wzJF8YJTW7BQ=;
 b=JdBWxRS8OaKZ7bdAX3q2EAciU5pYw/IN1LfCH9HE49UZmYsScylv2wbXMJw+LvYCfIeryn
 xmIKe/ljgbNAF2nIILhWfOtVog/SSB7N2JAgmIEPjsue98ow930bcoW0h8vdhhtSW2+IOD
 FHz0tagfxNPnSuE8DhmI9hn9wJZCGac=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-oweX7HbOMdW5Na4v0d55Yg-1; Wed, 05 Jul 2023 10:12:11 -0400
X-MC-Unique: oweX7HbOMdW5Na4v0d55Yg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EFE88910EF;
 Wed,  5 Jul 2023 14:12:10 +0000 (UTC)
Received: from kostyanf14nb.redhat.com (unknown [10.45.224.155])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42C2F492C13;
 Wed,  5 Jul 2023 14:12:09 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Subject: [PATCH 1/4] QGA VSS: Add wrapper to send log to debugger and stderr
Date: Wed,  5 Jul 2023 17:12:02 +0300
Message-Id: <20230705141205.525776-2-kkostiuk@redhat.com>
In-Reply-To: <20230705141205.525776-1-kkostiuk@redhat.com>
References: <20230705141205.525776-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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
 qga/vss-win32/vss-debug.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 qga/vss-win32/vss-debug.h

diff --git a/qga/vss-win32/vss-debug.h b/qga/vss-win32/vss-debug.h
new file mode 100644
index 0000000000..c0bdf7a3fc
--- /dev/null
+++ b/qga/vss-win32/vss-debug.h
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
+#include <vss-handles.h>
+
+#ifndef VSS_DEBUG_H
+#define VSS_DEBUG_H
+
+#define PRINT_DEBUG(fmt, ...) {                                               \
+    char user_sting[512] = { 0 };                                             \
+    char full_string[640] = { 0 };                                            \
+    snprintf(user_sting, 512, fmt, ## __VA_ARGS__);                           \
+    snprintf(full_string, 640, QGA_PROVIDER_NAME"[%lu]: %s %s\n",             \
+        GetCurrentThreadId(), __func__, user_sting);                          \
+    OutputDebugString(full_string);                                           \
+    fprintf(stderr, "%s", full_string);                                       \
+}
+
+#define PRINT_DEBUG_BEGIN PRINT_DEBUG("begin")
+#define PRINT_DEBUG_END PRINT_DEBUG("end")
+
+#endif
-- 
2.34.1



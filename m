Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C46F74D131
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:16:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qImzR-0000cv-Ez; Mon, 10 Jul 2023 05:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qImz0-0000bS-PM
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:15:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qImyu-0004Hm-Jy
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688980495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QiI65rJFr97wDDSZT8nl8r2OQW8wq7Rpu/vhvsXz9qY=;
 b=IEUvAGocfz1lhVQ2fVSWWI+A79lwp5rE7UKM6Nw97jljh+VS/gMQN4KY5VK8MR3HZuI4Uf
 kE8hmDIS77YAyb8IDPTa6WHisP3ZYURzicBdZ3CDGXLHJv4QfjzXit7oqSFawXiW5Doo6o
 JPI40KcS5363J1v2c7zjgynV9E1gukc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-oM7r2jh_NV2ZUt53dx5Wcg-1; Mon, 10 Jul 2023 05:14:51 -0400
X-MC-Unique: oM7r2jh_NV2ZUt53dx5Wcg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 856681044593;
 Mon, 10 Jul 2023 09:14:51 +0000 (UTC)
Received: from kostyanf14nb.redhat.com (unknown [10.45.225.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70C5A200A7CA;
 Mon, 10 Jul 2023 09:14:50 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v5 3/4] QGA VSS: Print error in err_set
Date: Mon, 10 Jul 2023 12:14:38 +0300
Message-Id: <20230710091439.1010553-4-kkostiuk@redhat.com>
In-Reply-To: <20230710091439.1010553-1-kkostiuk@redhat.com>
References: <20230710091439.1010553-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 qga/vss-win32/requester.cpp | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index e85b9bc633..f3eafacfc1 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -26,9 +26,11 @@
 
 #define DEFAULT_VSS_BACKUP_TYPE VSS_BT_FULL
 
-#define err_set(e, err, fmt, ...)                                           \
-    ((e)->error_setg_win32_wrapper((e)->errp, __FILE__, __LINE__, __func__, \
-                                   err, fmt, ## __VA_ARGS__))
+#define err_set(e, err, fmt, ...) {                                         \
+    (e)->error_setg_win32_wrapper((e)->errp, __FILE__, __LINE__, __func__,  \
+                                   err, fmt, ## __VA_ARGS__);               \
+    qga_debug(fmt, ## __VA_ARGS__);                                         \
+}
 /* Bad idea, works only when (e)->errp != NULL: */
 #define err_is_set(e) ((e)->errp && *(e)->errp)
 /* To lift this restriction, error_propagate(), like we do in QEMU code */
-- 
2.34.1



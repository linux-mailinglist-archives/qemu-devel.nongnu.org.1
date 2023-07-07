Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C3F74ADC3
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 11:24:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHhgR-000782-Ut; Fri, 07 Jul 2023 05:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHhgG-00076d-0h
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:23:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHhgE-0001KG-He
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688721790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uQeL/qvwvB/1XthGE7D4je03jB+vFnLXBCCrTaW7rlo=;
 b=gjMyLNSwV4znASEdmloD49YDZMNoQMSxoYzXQYkec9QlKvxoswJIorP61d++lsOvPH5Fwk
 T2qFgOh8YkQa59VaNceUiQIXfDeJqnHgxC6v8cyL9gFehMhV0YRKZKcGhcOB24kaYjAfr5
 nvO6As/ViMhw2pl9YWHK1SJHb5FDgo4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-rSP4nihOO2-KE61Taa3M0A-1; Fri, 07 Jul 2023 05:23:06 -0400
X-MC-Unique: rSP4nihOO2-KE61Taa3M0A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B0A63C10144;
 Fri,  7 Jul 2023 09:23:06 +0000 (UTC)
Received: from kostyanf14nb.redhat.com (unknown [10.45.225.190])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5753F4067A00;
 Fri,  7 Jul 2023 09:23:05 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/4] QGA VSS: Print error in err_set
Date: Fri,  7 Jul 2023 12:22:57 +0300
Message-Id: <20230707092258.768420-4-kkostiuk@redhat.com>
In-Reply-To: <20230707092258.768420-1-kkostiuk@redhat.com>
References: <20230707092258.768420-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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



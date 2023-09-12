Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 156C979CEC6
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 12:48:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg0vw-0004AW-EO; Tue, 12 Sep 2023 06:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0vu-00046d-Lf
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0vs-0003Mc-6D
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694515667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Il54V6ZHs1s2EXU94aKrX5SlbhPP9GSKtWAsuriUKBU=;
 b=PMkG3u9oq77WX/+9CzYTO9rNjI4lOjW2azJyJHy2S7aGeMiqr0iGLqI7LCQaCu4ODk9IfJ
 166ghMEz1yXCabd5dcWkPk4yycaON8P+H78yuSvkkEAv9Foz6oZMv0EDHsh7YqyjdsrJhc
 VwtmukbVgdIJKI780ORAE0PV5u2hi80=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-5cbOYktgPJyQcfP9dZWh4w-1; Tue, 12 Sep 2023 06:47:46 -0400
X-MC-Unique: 5cbOYktgPJyQcfP9dZWh4w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E75862932481
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 10:47:45 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 495AB63A52;
 Tue, 12 Sep 2023 10:47:45 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 14/14] ui: add precondition for dpy_get_ui_info()
Date: Tue, 12 Sep 2023 14:46:48 +0400
Message-ID: <20230912104649.1638640-15-marcandre.lureau@redhat.com>
In-Reply-To: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
References: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Ensure that it only get called when dpy_ui_info_supported(). The
function should always return a result. There should be a non-null
console or active_console.

Modify the argument to be const as well.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Albert Esteve <aesteve@redhat.com>
---
 include/ui/console.h | 2 +-
 ui/console.c         | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 79e4702912..28882f15a5 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -329,7 +329,7 @@ void update_displaychangelistener(DisplayChangeListener *dcl,
                                   uint64_t interval);
 void unregister_displaychangelistener(DisplayChangeListener *dcl);
 
-bool dpy_ui_info_supported(QemuConsole *con);
+bool dpy_ui_info_supported(const QemuConsole *con);
 const QemuUIInfo *dpy_get_ui_info(const QemuConsole *con);
 int dpy_set_ui_info(QemuConsole *con, QemuUIInfo *info, bool delay);
 
diff --git a/ui/console.c b/ui/console.c
index aa1e09462c..4a4f19ed33 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -801,7 +801,7 @@ static void dpy_set_ui_info_timer(void *opaque)
     con->hw_ops->ui_info(con->hw, head, &con->ui_info);
 }
 
-bool dpy_ui_info_supported(QemuConsole *con)
+bool dpy_ui_info_supported(const QemuConsole *con)
 {
     if (con == NULL) {
         con = active_console;
@@ -815,6 +815,8 @@ bool dpy_ui_info_supported(QemuConsole *con)
 
 const QemuUIInfo *dpy_get_ui_info(const QemuConsole *con)
 {
+    assert(dpy_ui_info_supported(con));
+
     if (con == NULL) {
         con = active_console;
     }
-- 
2.41.0



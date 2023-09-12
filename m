Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0353779C6E6
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 08:29:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfwtR-0005RT-LZ; Tue, 12 Sep 2023 02:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qfwtH-0005M9-UH
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qfwtF-0000U6-LM
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694500128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yBsm5xyUOQK7zA7IvJcclqW6DmKLyg00+NbxLD/m1H8=;
 b=KB63LR7ET3tVVx7ONFZhHT4/j7Z85pf7uBcsV3mUApzYE1jmEvjLTlE3cA/Awr+hunkQmz
 FlwjYnmAZJe1XQ3b7XPr7rHfuHsw05u6UFncUeJkl5lGxypwAQfFSYLNqAMFNvFbMCw0yX
 Ts1U/Z+Vyygp6dGclS4efLOhDWHN3dA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-CxPvd3ScMlCuAAFs8YHQdA-1; Tue, 12 Sep 2023 02:28:46 -0400
X-MC-Unique: CxPvd3ScMlCuAAFs8YHQdA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 065A183B8FC
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 06:28:46 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CAB263F9C;
 Tue, 12 Sep 2023 06:28:44 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: aesteve@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 2/2] ui: add precondition for dpy_get_ui_info()
Date: Tue, 12 Sep 2023 10:28:36 +0400
Message-ID: <20230912062836.1530898-2-marcandre.lureau@redhat.com>
In-Reply-To: <20230912062836.1530898-1-marcandre.lureau@redhat.com>
References: <20230912062836.1530898-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 include/ui/console.h | 2 +-
 ui/console.c         | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 031e5d5194..08c0f0dc70 100644
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
index 0fbec4d0bd..1c710a6d5e 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -803,7 +803,7 @@ static void dpy_set_ui_info_timer(void *opaque)
     con->hw_ops->ui_info(con->hw, head, &con->ui_info);
 }
 
-bool dpy_ui_info_supported(QemuConsole *con)
+bool dpy_ui_info_supported(const QemuConsole *con)
 {
     if (con == NULL) {
         con = active_console;
@@ -817,6 +817,8 @@ bool dpy_ui_info_supported(QemuConsole *con)
 
 const QemuUIInfo *dpy_get_ui_info(const QemuConsole *con)
 {
+    assert(dpy_ui_info_supported(con));
+
     if (con == NULL) {
         con = active_console;
     }
-- 
2.41.0



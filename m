Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A237CC1A9
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 13:17:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsi4E-0004e6-Mn; Tue, 17 Oct 2023 07:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qsi4C-0004bt-6B
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:16:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qsi4A-0005Rw-Gf
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697541409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qWQxmDAysZUEX68bbhvKOyk8KrUEURH8YQjB6HFvPVM=;
 b=M4mS0V26Oo5Rb5Nq6ZA63J7wU9PUfsm2iyqy5KC2xpUD3fROOZEugTAjqO7X/+yB5Gx8Rc
 6+nYiwMILDGpLKQU8+x8dHbUV5Ncye3i/JEkitUE9JkvT+QRcXPfLl2R9qlnlxBlLaCh4C
 BOcpzW5Q56ATrAG0DPtuqV6DhZWToak=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-T648OZ81Nj6HmaRuil5oKQ-1; Tue, 17 Oct 2023 07:16:46 -0400
X-MC-Unique: T648OZ81Nj6HmaRuil5oKQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4DC785A5BA;
 Tue, 17 Oct 2023 11:16:45 +0000 (UTC)
Received: from localhost (unknown [10.39.208.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FBDC2026D6F;
 Tue, 17 Oct 2023 11:16:44 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] gtk: force realization of drawing area
Date: Tue, 17 Oct 2023 15:16:42 +0400
Message-ID: <20231017111642.1155545-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

Fixes the GL context creation from a widget that isn't yet realized (in
a hidden tab for example).

Resolves:
https://gitlab.com/qemu-project/qemu/-/issues/1727

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/gtk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 935de1209b..2a4c9b84ba 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2371,6 +2371,7 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
     GdkDisplay *window_display;
     GtkIconTheme *theme;
     char *dir;
+    int idx;
 
     if (!gtkinit) {
         fprintf(stderr, "gtk initialization failed\n");
@@ -2434,6 +2435,15 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
     gtk_container_add(GTK_CONTAINER(s->window), s->vbox);
 
     gtk_widget_show_all(s->window);
+
+    for (idx = 0;; idx++) {
+        QemuConsole *con = qemu_console_lookup_by_index(idx);
+        if (!con) {
+            break;
+        }
+        gtk_widget_realize(s->vc[idx].gfx.drawing_area);
+    }
+
     if (opts->u.gtk.has_show_menubar &&
         !opts->u.gtk.show_menubar) {
         gtk_widget_hide(s->menu_bar);
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A56837E37E5
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:32:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0IQD-0002b9-FW; Tue, 07 Nov 2023 04:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0IQB-0002ac-H7
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:30:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0IQ4-0003Ys-O4
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:30:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699349447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kdxdOoCSaQu+/7Bb4wz/YIn7qUa7DoGDIkRySobKp2k=;
 b=PL8toOU9KWRhzyGcf/Ut32Nvpc38BX0gqzt9sRocVc2H4vTmCibshd16CCZuTYf8s9uqvT
 Z6kHghqW6KJNTEpb6PhEuUv5xhS6+MHXBGojVdCcVRP0uFamYsLeNSdaM4GcCY34ZIwiJ7
 uMGBFwnnpsewX/RH8nd+ZIjT2rZrjS8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-PznlH73CPviiPD1EFyRPxQ-1; Tue,
 07 Nov 2023 04:30:45 -0500
X-MC-Unique: PznlH73CPviiPD1EFyRPxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0D27380450E;
 Tue,  7 Nov 2023 09:30:44 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12AEB40C6EB9;
 Tue,  7 Nov 2023 09:30:42 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/5] ui/gtk: force realization of drawing area
Date: Tue,  7 Nov 2023 13:30:31 +0400
Message-ID: <20231107093035.2746581-2-marcandre.lureau@redhat.com>
In-Reply-To: <20231107093035.2746581-1-marcandre.lureau@redhat.com>
References: <20231107093035.2746581-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Fixes the GL context creation from a widget that isn't yet realized (in
a hidden tab for example).

Resolves:
https://gitlab.com/qemu-project/qemu/-/issues/1727

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
Message-Id: <20231017111642.1155545-1-marcandre.lureau@redhat.com>
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



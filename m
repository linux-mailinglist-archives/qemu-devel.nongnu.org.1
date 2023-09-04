Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D32FD79169B
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:58:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8AU-0005Mk-Sd; Mon, 04 Sep 2023 07:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8AH-0004Er-OI
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:54:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8A7-0000Aa-Bx
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPvuZR19Ihxm0EeQ6XlDAJ/30KEcKDm1YnEzHyINBQo=;
 b=TQfJvCHMATt41D+k9VhGhebC0KgJBBwUvg49RUdbcpE2v2HEiMreU5Y4x+QrjeLTAvmZvk
 DqBRlvHzCxM/Bd9c7z+W65YRfUzhabMZda+uQu5Sund0EsWu1Th4oPBGvgQhTen3pxPWlH
 4EXsfgz2GzXjj/41g3d/ohTvxNvjpug=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-XqrHCe6CPKO82VhRHy5Qjg-1; Mon, 04 Sep 2023 07:54:32 -0400
X-MC-Unique: XqrHCe6CPKO82VhRHy5Qjg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46F241817904
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:54:32 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E8DF2026D68;
 Mon,  4 Sep 2023 11:54:31 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 25/52] ui/console: allocate ui_timer in QemuConsole
Date: Mon,  4 Sep 2023 15:52:22 +0400
Message-ID: <20230904115251.4161397-26-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Although at this point only QemuGraphicConsole have hw_ops that
implements ui_info() callback, it makes sense to keep the code in the
base QemuConsole, to simplify conditions for the caller.

As of now, the code didn't reach a NULL timer because dpy_set_ui_info()
checks if dpy_ui_info_supported() (hw_ops->ui_info != NULL), which is
false for text_console_ops. This is a bit fragile, let simply allocate
and free the timer in the base class.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-26-marcandre.lureau@redhat.com>
---
 ui/console.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index a9a922b6e3..8c4a2c83fa 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -197,6 +197,7 @@ static bool displaychangelistener_has_dmabuf(DisplayChangeListener *dcl);
 static bool console_compatible_with(QemuConsole *con,
                                     DisplayChangeListener *dcl, Error **errp);
 static QemuConsole *qemu_graphic_console_lookup_unused(void);
+static void dpy_set_ui_info_timer(void *opaque);
 
 static void gui_update(void *opaque)
 {
@@ -1334,6 +1335,9 @@ qemu_console_register(QemuConsole *c)
 static void
 qemu_console_finalize(Object *obj)
 {
+    QemuConsole *c = QEMU_CONSOLE(obj);
+
+    g_clear_pointer(&c->ui_timer, timer_free);
     /* TODO: should unregister from consoles and free itself  */
 }
 
@@ -1367,6 +1371,8 @@ qemu_console_init(Object *obj)
     qemu_co_queue_init(&c->dump_queue);
     c->ds = ds;
     c->window_id = -1;
+    c->ui_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
+                               dpy_set_ui_info_timer, c);
     qemu_console_register(c);
 }
 
@@ -2193,8 +2199,6 @@ QemuConsole *graphic_console_init(DeviceState *dev, uint32_t head,
     } else {
         trace_console_gfx_new();
         s = (QemuConsole *)object_new(TYPE_QEMU_GRAPHIC_CONSOLE);
-        s->ui_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
-                                   dpy_set_ui_info_timer, s);
     }
     s->head = head;
     graphic_console_set_hwops(s, hw_ops, opaque);
-- 
2.41.0



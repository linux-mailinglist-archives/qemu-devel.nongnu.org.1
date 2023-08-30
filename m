Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DE878D4E5
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:47:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHgW-00039k-FE; Wed, 30 Aug 2023 05:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHgU-00031e-SS
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:40:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHgR-0001HO-OD
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2GP6O6o4+gPJ3XyQDd7O4dkYgiHE9UWFU5cb/THrjas=;
 b=CLXXWkAqC2/N5waUYKqOrjBVA4DwG3Ks7dpT/xSoexRxyoZlrqgCL8CklvcsvZp7dV8way
 OpFMWjMm/yptHIB63Tgu7nFqv5XWRxHPnK4dHjdR1782EwMP4CZIG+YFGkz6U1zfn5Pl6F
 LbyFRR4IAKxAEBPOp6I3jB8Gb2fg6A8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-HRm-LVlVM5imNAggX8xjtw-1; Wed, 30 Aug 2023 05:40:17 -0400
X-MC-Unique: HRm-LVlVM5imNAggX8xjtw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A41D1C07595
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:40:17 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63AEF6466B;
 Wed, 30 Aug 2023 09:40:15 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 23/67] ui/console: specialize console_lookup_unused()
Date: Wed, 30 Aug 2023 13:37:57 +0400
Message-ID: <20230830093843.3531473-24-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
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

graphics_console_init() is expected to return a graphic console.

The function doesn't need to be exported.

We are going to specialize further QemuGraphicConsole & QemuTextConsole.
The two will not be interchangeable anymore.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h | 1 -
 ui/console.c         | 7 ++++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 1b08b0f8ad..465f0f93a0 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -484,7 +484,6 @@ QemuConsole *qemu_console_lookup_by_index(unsigned int index);
 QemuConsole *qemu_console_lookup_by_device(DeviceState *dev, uint32_t head);
 QemuConsole *qemu_console_lookup_by_device_name(const char *device_id,
                                                 uint32_t head, Error **errp);
-QemuConsole *qemu_console_lookup_unused(void);
 QEMUCursor *qemu_console_get_cursor(QemuConsole *con);
 bool qemu_console_is_visible(QemuConsole *con);
 bool qemu_console_is_graphic(QemuConsole *con);
diff --git a/ui/console.c b/ui/console.c
index e0e4f980d7..08bed58b80 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -196,6 +196,7 @@ static void text_console_update_cursor(void *opaque);
 static bool displaychangelistener_has_dmabuf(DisplayChangeListener *dcl);
 static bool console_compatible_with(QemuConsole *con,
                                     DisplayChangeListener *dcl, Error **errp);
+static QemuConsole *qemu_graphic_console_lookup_unused(void);
 
 static void gui_update(void *opaque)
 {
@@ -2184,7 +2185,7 @@ QemuConsole *graphic_console_init(DeviceState *dev, uint32_t head,
     QemuConsole *s;
     DisplaySurface *surface;
 
-    s = qemu_console_lookup_unused();
+    s = qemu_graphic_console_lookup_unused();
     if (s) {
         trace_console_gfx_reuse(s->index);
         width = qemu_console_get_width(s, 0);
@@ -2289,13 +2290,13 @@ QemuConsole *qemu_console_lookup_by_device_name(const char *device_id,
     return con;
 }
 
-QemuConsole *qemu_console_lookup_unused(void)
+static QemuConsole *qemu_graphic_console_lookup_unused(void)
 {
     QemuConsole *con;
     Object *obj;
 
     QTAILQ_FOREACH(con, &consoles, next) {
-        if (con->hw_ops != &unused_ops) {
+        if (!QEMU_IS_GRAPHIC_CONSOLE(con) || con->hw_ops != &unused_ops) {
             continue;
         }
         obj = object_property_get_link(OBJECT(con),
-- 
2.41.0



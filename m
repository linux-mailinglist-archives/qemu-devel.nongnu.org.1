Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72037724191
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 14:00:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6VLe-0002N1-7I; Tue, 06 Jun 2023 07:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q6VKf-00020f-5O
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 07:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q6VKd-00064o-Kt
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 07:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686052713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8oqCADlVMj6WzKLvSevtqsvCS6fvUfXcyXStP9ebAZo=;
 b=it6IZNPhzq5SlkygAyP8BrdE+epYb6bzrJ34wY/nDSGngPTfNk80OxhkMGl2+fZw6j8YEw
 4yXpqqkYiFYOvNWEjTMf81khu8s0yGlHT+tYIwZUTxDFnT/BOMtRqR0RnVS7hh9qtyj+DC
 bJKB2e3e249zPNqYjbTu6MGAh4F7ikY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-Xlg-9AhaPe6cykWYQVTkKw-1; Tue, 06 Jun 2023 07:58:31 -0400
X-MC-Unique: Xlg-9AhaPe6cykWYQVTkKw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DE333C025A2
 for <qemu-devel@nongnu.org>; Tue,  6 Jun 2023 11:58:31 +0000 (UTC)
Received: from localhost (unknown [10.39.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E39EC1603B;
 Tue,  6 Jun 2023 11:58:24 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 16/21] ui/dbus: add some GL traces
Date: Tue,  6 Jun 2023 15:56:53 +0400
Message-Id: <20230606115658.677673-17-marcandre.lureau@redhat.com>
In-Reply-To: <20230606115658.677673-1-marcandre.lureau@redhat.com>
References: <20230606115658.677673-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124;
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 6 ++++++
 ui/trace-events    | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index e92eff66e3..8605dffd8a 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -102,6 +102,8 @@ static void dbus_call_update_gl(DisplayChangeListener *dcl,
 {
     DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
 
+    trace_dbus_update_gl(x, y, w, h);
+
     glFlush();
 #ifdef CONFIG_GBM
     graphic_hw_gl_block(ddl->dcl.con, true);
@@ -212,6 +214,8 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
                                  uint32_t x, uint32_t y,
                                  uint32_t w, uint32_t h)
 {
+    trace_dbus_scanout_texture(tex_id, backing_y_0_top,
+                               backing_width, backing_height, x, y, w, h);
 #ifdef CONFIG_GBM
     QemuDmaBuf dmabuf = {
         .width = backing_width,
@@ -421,6 +425,8 @@ static void dbus_gl_gfx_switch(DisplayChangeListener *dcl,
 {
     DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
 
+    trace_dbus_gl_gfx_switch(new_surface);
+
     ddl->ds = new_surface;
     if (ddl->ds) {
         int width = surface_width(ddl->ds);
diff --git a/ui/trace-events b/ui/trace-events
index 712c4b2273..b17c3d7893 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -155,6 +155,9 @@ dbus_mouse_release(unsigned int button) "button %u"
 dbus_mouse_set_pos(unsigned int x, unsigned int y) "x=%u, y=%u"
 dbus_mouse_rel_motion(int dx, int dy) "dx=%d, dy=%d"
 dbus_update(int x, int y, int w, int h) "x=%d, y=%d, w=%d, h=%d"
+dbus_update_gl(int x, int y, int w, int h) "x=%d, y=%d, w=%d, h=%d"
 dbus_clipboard_grab_failed(void) ""
 dbus_clipboard_register(const char *bus_name) "peer %s"
 dbus_clipboard_unregister(const char *bus_name) "peer %s"
+dbus_scanout_texture(uint32_t tex_id, bool backing_y_0_top, uint32_t backing_width, uint32_t backing_height, uint32_t x, uint32_t y, uint32_t w, uint32_t h) "tex_id:%u y0top:%d back:%ux%u %u+%u-%ux%u"
+dbus_gl_gfx_switch(void *p) "surf: %p"
-- 
2.40.1



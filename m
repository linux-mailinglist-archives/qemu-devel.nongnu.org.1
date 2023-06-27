Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF7173FC80
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:10:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8M7-0000B5-Si; Tue, 27 Jun 2023 09:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8M4-000093-TT
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8M3-0007Ee-43
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687871014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uSqTg6AcRmQw7gqzNWcczGKyOs60ANWNuGmq3ajixAE=;
 b=GlHwijGuu/g2OFGyGlbmjtgQcTVjM+sPiZhXOGCyhjDydKmhj/8HV+qZ7M/8xarLngqcDD
 m1jHegS1ZbMyEdjVR3e1zPuFYolBy/SrW/zlJVDNGSyJ4wGb9BV3oE6palUGFph71HHcVD
 L+g9UXbKN65VMWObCGTD58esXbrn37M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-Yzo5pA2aMtKvehTVBiaR0Q-1; Tue, 27 Jun 2023 09:03:32 -0400
X-MC-Unique: Yzo5pA2aMtKvehTVBiaR0Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56038800962;
 Tue, 27 Jun 2023 13:03:30 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9BDA48FB01;
 Tue, 27 Jun 2023 13:03:29 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 28/33] ui/dbus: add some GL traces
Date: Tue, 27 Jun 2023 15:02:25 +0200
Message-ID: <20230627130231.1614896-29-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230606115658.677673-17-marcandre.lureau@redhat.com>
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
index a71895c479..fe58675163 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -156,6 +156,9 @@ dbus_mouse_set_pos(unsigned int x, unsigned int y) "x=%u, y=%u"
 dbus_mouse_rel_motion(int dx, int dy) "dx=%d, dy=%d"
 dbus_touch_send_event(unsigned int kind, uint32_t num_slot, uint32_t x, uint32_t y) "kind=%u, num_slot=%u, x=%d, y=%d"
 dbus_update(int x, int y, int w, int h) "x=%d, y=%d, w=%d, h=%d"
+dbus_update_gl(int x, int y, int w, int h) "x=%d, y=%d, w=%d, h=%d"
 dbus_clipboard_grab_failed(void) ""
 dbus_clipboard_register(const char *bus_name) "peer %s"
 dbus_clipboard_unregister(const char *bus_name) "peer %s"
+dbus_scanout_texture(uint32_t tex_id, bool backing_y_0_top, uint32_t backing_width, uint32_t backing_height, uint32_t x, uint32_t y, uint32_t w, uint32_t h) "tex_id:%u y0top:%d back:%ux%u %u+%u-%ux%u"
+dbus_gl_gfx_switch(void *p) "surf: %p"
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6688F756317
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:48:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNcS-0005u8-99; Mon, 17 Jul 2023 08:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qLNcC-0005dO-2x
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:46:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qLNcA-0008FE-Fq
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689597969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6aHtTIAg4kdv6BfFhRmW/dM6P9zqwKpeITi3mITOFE=;
 b=fkDII0TmB2/rxxmYXwhUQfSRE9phe0M3L82Dtr7mV2ccXW+PkLi74dHngLlJjhEO3Ujvg9
 w2pbXB5juRul/Z3rZEN0rZ0xVlI+BYv+qKJfQQtiukTpvIXCJzvXIPN1zGDbh4V+QRpCSX
 6tm+7U20F4pfFXgv5iXnOi4jFyJzy4g=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-xgEDtM8tMcO0OvLNxFsSMQ-1; Mon, 17 Jul 2023 08:46:06 -0400
X-MC-Unique: xgEDtM8tMcO0OvLNxFsSMQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED3AC1C28CE0;
 Mon, 17 Jul 2023 12:46:05 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE4D64CD0C8;
 Mon, 17 Jul 2023 12:46:04 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, richard.henderson@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Dongwon Kim <dongwon.kim@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PULL 04/19] virtio-gpu: replace the surface with null surface when
 resetting
Date: Mon, 17 Jul 2023 16:45:29 +0400
Message-ID: <20230717124545.177236-5-marcandre.lureau@redhat.com>
In-Reply-To: <20230717124545.177236-1-marcandre.lureau@redhat.com>
References: <20230717124545.177236-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Dongwon Kim <dongwon.kim@intel.com>

The primary guest scanout shows the booting screen right after reboot
but additional guest displays (i.e. max_ouptuts > 1) will keep displaying
the old frames until the guest virtio gpu driver gets initialized, which
could cause some confusion. A better way is to to replace the surface with
a place holder that tells the display is not active during the reset of
virtio-gpu device.

And to immediately update the surface with the place holder image after
the switch, displaychangelistener_gfx_switch needs to be called with
'update == TRUE' in dpy_gfx_replace_surface when the new surface is NULL.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20230627224451.11739-1-dongwon.kim@intel.com>
---
 hw/display/virtio-gpu.c |  5 +++++
 ui/console.c            | 11 ++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index e937c4e348..e8603d78ca 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1397,6 +1397,7 @@ void virtio_gpu_reset(VirtIODevice *vdev)
     VirtIOGPU *g = VIRTIO_GPU(vdev);
     struct virtio_gpu_simple_resource *res, *tmp;
     struct virtio_gpu_ctrl_command *cmd;
+    int i = 0;
 
     QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
         virtio_gpu_resource_destroy(g, res);
@@ -1415,6 +1416,10 @@ void virtio_gpu_reset(VirtIODevice *vdev)
         g_free(cmd);
     }
 
+    for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
+        dpy_gfx_replace_surface(g->parent_obj.scanout[i].con, NULL);
+    }
+
     virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
 }
 
diff --git a/ui/console.c b/ui/console.c
index c1544e0fb8..8da2170a7e 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1898,6 +1898,7 @@ void dpy_gfx_replace_surface(QemuConsole *con,
     static const char placeholder_msg[] = "Display output is not active.";
     DisplayState *s = con->ds;
     DisplaySurface *old_surface = con->surface;
+    DisplaySurface *new_surface = surface;
     DisplayChangeListener *dcl;
     int width;
     int height;
@@ -1911,19 +1912,19 @@ void dpy_gfx_replace_surface(QemuConsole *con,
             height = 480;
         }
 
-        surface = qemu_create_placeholder_surface(width, height, placeholder_msg);
+        new_surface = qemu_create_placeholder_surface(width, height, placeholder_msg);
     }
 
-    assert(old_surface != surface);
+    assert(old_surface != new_surface);
 
     con->scanout.kind = SCANOUT_SURFACE;
-    con->surface = surface;
-    dpy_gfx_create_texture(con, surface);
+    con->surface = new_surface;
+    dpy_gfx_create_texture(con, new_surface);
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (con != (dcl->con ? dcl->con : active_console)) {
             continue;
         }
-        displaychangelistener_gfx_switch(dcl, surface, FALSE);
+        displaychangelistener_gfx_switch(dcl, new_surface, surface ? FALSE : TRUE);
     }
     dpy_gfx_destroy_texture(con, old_surface);
     qemu_free_displaysurface(old_surface);
-- 
2.41.0



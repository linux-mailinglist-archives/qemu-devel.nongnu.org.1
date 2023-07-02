Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B0A744F97
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 20:07:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qG1SN-0000mq-H4; Sun, 02 Jul 2023 14:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qG1Rv-0000dr-IU; Sun, 02 Jul 2023 14:05:29 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qG1Rt-0005N3-DP; Sun, 02 Jul 2023 14:05:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2028510DF4;
 Sun,  2 Jul 2023 21:04:55 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 576D111208;
 Sun,  2 Jul 2023 21:04:53 +0300 (MSK)
Received: (nullmailer pid 2122384 invoked by uid 1000);
 Sun, 02 Jul 2023 18:04:51 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 65/65] ui/gtk: set the area of the scanout texture
 correctly
Date: Sun,  2 Jul 2023 21:04:38 +0300
Message-Id: <20230702180439.2122316-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230702210422@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230702210422@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

x and y offsets and width and height of the scanout texture
is not correctly configured in case guest scanout frame is
dmabuf.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Message-ID: <20230621213150.29573-1-dongwon.kim@intel.com>
(cherry picked from commit 37802a24eb4e535d96d6fe0273505d2b5c6528c2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 19130041bc..e99e3b0d8c 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -257,7 +257,8 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
 
     gd_egl_scanout_texture(dcl, dmabuf->texture,
                            dmabuf->y0_top, dmabuf->width, dmabuf->height,
-                           0, 0, dmabuf->width, dmabuf->height);
+                           dmabuf->x, dmabuf->y, dmabuf->scanout_width,
+                           dmabuf->scanout_height);
 
     if (dmabuf->allow_fences) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index c384a1516b..1605818bd1 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -299,7 +299,8 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
 
     gd_gl_area_scanout_texture(dcl, dmabuf->texture,
                                dmabuf->y0_top, dmabuf->width, dmabuf->height,
-                               0, 0, dmabuf->width, dmabuf->height);
+                               dmabuf->x, dmabuf->y, dmabuf->scanout_width,
+                               dmabuf->scanout_height);
 
     if (dmabuf->allow_fences) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
-- 
2.39.2



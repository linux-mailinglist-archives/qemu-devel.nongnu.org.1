Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C03973EAE9
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 21:09:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrRg-00032o-17; Mon, 26 Jun 2023 15:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrQh-0000pa-EK; Mon, 26 Jun 2023 14:59:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrQg-00073D-2X; Mon, 26 Jun 2023 14:59:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 900F4EFA4;
 Mon, 26 Jun 2023 21:59:07 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 21A6EF7E3;
 Mon, 26 Jun 2023 21:59:06 +0300 (MSK)
Received: (nullmailer pid 1575294 invoked by uid 1000);
 Mon, 26 Jun 2023 18:59:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Erico Nunes <ernunes@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.4 06/43] ui/gtk-egl: fix scaling for cursor position in
 scanout mode
Date: Mon, 26 Jun 2023 21:58:24 +0300
Message-Id: <20230626185902.1575177-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
References: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
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

From: Erico Nunes <ernunes@redhat.com>

vc->gfx.w and vc->gfx.h are not updated appropriately in this code path,
which leads to a different scaling factor for rendering the cursor on
some edge cases (e.g. the focus has left and re-entered the gtk window).
This can be reproduced using vhost-user-gpu with the gtk ui on the x11
backend.
Use the surface dimensions which are already updated accordingly.

Signed-off-by: Erico Nunes <ernunes@redhat.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230320160856.364319-2-ernunes@redhat.com>
(cherry picked from commit f8a951bb951140a585341c700ebeec58d83f7bbc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 557668e418..19130041bc 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -88,8 +88,8 @@ void gd_egl_draw(VirtualConsole *vc)
 #endif
         gd_egl_scanout_flush(&vc->gfx.dcl, 0, 0, vc->gfx.w, vc->gfx.h);
 
-        vc->gfx.scale_x = (double)ww / vc->gfx.w;
-        vc->gfx.scale_y = (double)wh / vc->gfx.h;
+        vc->gfx.scale_x = (double)ww / surface_width(vc->gfx.ds);
+        vc->gfx.scale_y = (double)wh / surface_height(vc->gfx.ds);
 
         glFlush();
 #ifdef CONFIG_GBM
-- 
2.39.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A04E73EA80
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 20:52:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrIZ-00046L-SO; Mon, 26 Jun 2023 14:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrIW-00044q-Jo; Mon, 26 Jun 2023 14:50:49 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrIT-0004qE-Mc; Mon, 26 Jun 2023 14:50:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5B16BEF1B;
 Mon, 26 Jun 2023 21:50:19 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3140BF7AE;
 Mon, 26 Jun 2023 21:50:17 +0300 (MSK)
Received: (nullmailer pid 1573982 invoked by uid 1000);
 Mon, 26 Jun 2023 18:50:15 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bin Meng <bin.meng@windriver.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 08/54] ui/sdl2: fix surface_gl_update_texture:
 Assertion 'gls' failed
Date: Mon, 26 Jun 2023 21:49:15 +0300
Message-Id: <20230626185002.1573836-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Before sdl2_gl_update() is called, sdl2_gl_switch() may decide to
destroy the console window and its associated shaders.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1644
Fixes: c84ab0a500a8 ("ui/console: optionally update after gfx switch")

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Bin Meng <bin.meng@windriver.com>
Message-Id: <20230511074217.4171842-1-marcandre.lureau@redhat.com>
(cherry picked from commit b3a654d82ecf276b59a67b2fd688e11a0d8a0064)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 39cab8cde7..bbfa70eac3 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -67,6 +67,10 @@ void sdl2_gl_update(DisplayChangeListener *dcl,
 
     assert(scon->opengl);
 
+    if (!scon->real_window) {
+        return;
+    }
+
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
     surface_gl_update_texture(scon->gls, scon->surface, x, y, w, h);
     scon->updates++;
-- 
2.39.2



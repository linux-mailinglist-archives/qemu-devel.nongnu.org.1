Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B36973EB00
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 21:12:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrR4-0001PB-7K; Mon, 26 Jun 2023 14:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrQp-0000tV-CO; Mon, 26 Jun 2023 14:59:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrQn-000751-Qk; Mon, 26 Jun 2023 14:59:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8DB21EFAA;
 Mon, 26 Jun 2023 21:59:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D135EF7E7;
 Mon, 26 Jun 2023 21:59:06 +0300 (MSK)
Received: (nullmailer pid 1575306 invoked by uid 1000);
 Mon, 26 Jun 2023 18:59:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.4 10/43] ui/sdl2: disable SDL_HINT_GRAB_KEYBOARD on
 Windows
Date: Mon, 26 Jun 2023 21:58:28 +0300
Message-Id: <20230626185902.1575177-10-mjt@tls.msk.ru>
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

From: Volker Rümelin <vr_qemu@t-online.de>

Windows sends an extra left control key up/down input event for
every right alt key up/down input event for keyboards with
international layout. Since commit 830473455f ("ui/sdl2: fix
handling of AltGr key on Windows") QEMU uses a Windows low level
keyboard hook procedure to reliably filter out the special left
control key and to grab the keyboard on Windows.

The SDL2 version 2.0.16 introduced its own Windows low level
keyboard hook procedure to grab the keyboard. Windows calls this
callback before the QEMU keyboard hook procedure. This disables
the special left control key filter when the keyboard is grabbed.

To fix the problem, disable the SDL2 Windows low level keyboard
hook procedure.

Reported-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20230418062823.5683-1-vr_qemu@t-online.de>
(cherry picked from commit 1dfea3f212e43bfd59d1e1f40b9776db440b211f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/sdl2.c b/ui/sdl2.c
index b483a51fb7..d630459b78 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -849,7 +849,10 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
 #ifdef SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR /* only available since SDL 2.0.8 */
     SDL_SetHint(SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR, "0");
 #endif
+#ifndef CONFIG_WIN32
+    /* QEMU uses its own low level keyboard hook procecure on Windows */
     SDL_SetHint(SDL_HINT_GRAB_KEYBOARD, "1");
+#endif
 #ifdef SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED
     SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
 #endif
-- 
2.39.2



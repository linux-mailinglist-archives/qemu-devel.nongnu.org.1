Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1AC785025
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 07:54:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYgn7-0001Og-G9; Wed, 23 Aug 2023 01:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYgn1-0001MR-T0
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:52:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYgmy-0007K1-N6
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:52:22 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A9B8C1C390
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 08:52:19 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5013821238;
 Wed, 23 Aug 2023 08:52:01 +0300 (MSK)
Received: (nullmailer pid 1917462 invoked by uid 1000);
 Wed, 23 Aug 2023 05:52:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 03/24] ui: spelling fixes
Date: Wed, 23 Aug 2023 08:51:34 +0300
Message-Id: <20230823055155.1917375-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1691405748.git.mjt@tls.msk.ru>
References: <cover.1691405748.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 ui/cocoa.m            | 2 +-
 ui/keymaps.h          | 2 +-
 ui/sdl2-2d.c          | 2 +-
 ui/sdl2.c             | 2 +-
 ui/vnc-enc-zrle.c.inc | 2 +-
 ui/vnc-enc-zywrle.h   | 4 ++--
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 0c2153d17c..4d8989c4eb 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -2046,5 +2046,5 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
     /*
      * Create the menu entries which depend on QEMU state (for consoles
-     * and removeable devices). These make calls back into QEMU functions,
+     * and removable devices). These make calls back into QEMU functions,
      * which is OK because at this point we know that the second thread
      * holds the iothread lock and is synchronously waiting for us to
diff --git a/ui/keymaps.h b/ui/keymaps.h
index 6473405485..3d52c0882a 100644
--- a/ui/keymaps.h
+++ b/ui/keymaps.h
@@ -45,5 +45,5 @@ typedef struct {
 #define SCANCODE_UP     0x80
 
-/* Additional modifiers to use if not catched another way. */
+/* Additional modifiers to use if not caught another way. */
 #define SCANCODE_SHIFT  0x100
 #define SCANCODE_CTRL   0x200
diff --git a/ui/sdl2-2d.c b/ui/sdl2-2d.c
index bfebbdeaea..06468cd493 100644
--- a/ui/sdl2-2d.c
+++ b/ui/sdl2-2d.c
@@ -151,5 +151,5 @@ bool sdl2_2d_check_format(DisplayChangeListener *dcl,
     /*
      * We let SDL convert for us a few more formats than,
-     * the native ones. Thes are the ones I have tested.
+     * the native ones. These are the ones I have tested.
      */
     return (format == PIXMAN_x8r8g8b8 ||
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 0d91b555e3..ea4a92cd36 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -861,5 +861,5 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
 #endif
 #ifndef CONFIG_WIN32
-    /* QEMU uses its own low level keyboard hook procecure on Windows */
+    /* QEMU uses its own low level keyboard hook procedure on Windows */
     SDL_SetHint(SDL_HINT_GRAB_KEYBOARD, "1");
 #endif
diff --git a/ui/vnc-enc-zrle.c.inc b/ui/vnc-enc-zrle.c.inc
index c107d8affc..a8ca37d05e 100644
--- a/ui/vnc-enc-zrle.c.inc
+++ b/ui/vnc-enc-zrle.c.inc
@@ -111,5 +111,5 @@ static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXEL *data, int w, int h,
     *end = ~*(end-1); /* one past the end is different so the while loop ends */
 
-    /* Real limit is 127 but we wan't a way to know if there is more than 127 */
+    /* Real limit is 127 but we want a way to know if there is more than 127 */
     palette_init(palette, 256, ZRLE_BPP);
 
diff --git a/ui/vnc-enc-zywrle.h b/ui/vnc-enc-zywrle.h
index e661ec117d..64fbc90ee7 100644
--- a/ui/vnc-enc-zywrle.h
+++ b/ui/vnc-enc-zywrle.h
@@ -486,5 +486,5 @@ static inline void wavelet(int *buf, int width, int height, int level)
 /*
   RGB <=> YUV conversion stuffs.
-  YUV coversion is explained as following formula in strict meaning:
+  YUV conversion is explained as following formula in strict meaning:
   Y =  0.299R + 0.587G + 0.114B (   0<=Y<=255)
   U = -0.169R - 0.331G + 0.500B (-128<=U<=127)
@@ -540,5 +540,5 @@ static inline void wavelet(int *buf, int width, int height, int level)
 
  So, we must transfer each sub images individually in strict meaning.
- But at least ZRLE meaning, following one decompositon image is same as
+ But at least ZRLE meaning, following one decomposition image is same as
  avobe individual sub image. I use this format.
  (Strictly saying, transfer order is reverse(Hxy->Hy->Hx->L)
-- 
2.39.2



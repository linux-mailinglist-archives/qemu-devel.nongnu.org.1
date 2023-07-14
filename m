Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1C0753A01
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:46:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKH8V-0000Fa-AH; Fri, 14 Jul 2023 07:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH8S-0000Ex-0J; Fri, 14 Jul 2023 07:38:56 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH8Q-00047L-9D; Fri, 14 Jul 2023 07:38:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3600213D8F;
 Fri, 14 Jul 2023 14:38:55 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2CA6814B9E;
 Fri, 14 Jul 2023 14:38:39 +0300 (MSK)
Received: (nullmailer pid 1186204 invoked by uid 1000);
 Fri, 14 Jul 2023 11:38:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH, trivial 03/29] tree-wide spelling fixes in comments and some
 messages: ui
Date: Fri, 14 Jul 2023 14:38:08 +0300
Message-Id: <20230714113834.1186117-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714113834.1186117-1-mjt@tls.msk.ru>
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
MIME-Version: 1.0
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 ui/cocoa.m            | 2 +-
 ui/keymaps.h          | 2 +-
 ui/sdl2-2d.c          | 2 +-
 ui/sdl2.c             | 2 +-
 ui/vnc-enc-tight.c    | 2 +-
 ui/vnc-enc-zrle.c.inc | 2 +-
 ui/vnc-enc-zywrle.h   | 4 ++--
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 0c2153d17c..4d8989c4eb 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -2047,3 +2047,3 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
      * Create the menu entries which depend on QEMU state (for consoles
-     * and removeable devices). These make calls back into QEMU functions,
+     * and removable devices). These make calls back into QEMU functions,
      * which is OK because at this point we know that the second thread
diff --git a/ui/keymaps.h b/ui/keymaps.h
index 6473405485..3d52c0882a 100644
--- a/ui/keymaps.h
+++ b/ui/keymaps.h
@@ -46,3 +46,3 @@ typedef struct {
 
-/* Additional modifiers to use if not catched another way. */
+/* Additional modifiers to use if not caught another way. */
 #define SCANCODE_SHIFT  0x100
diff --git a/ui/sdl2-2d.c b/ui/sdl2-2d.c
index bfebbdeaea..06468cd493 100644
--- a/ui/sdl2-2d.c
+++ b/ui/sdl2-2d.c
@@ -152,3 +152,3 @@ bool sdl2_2d_check_format(DisplayChangeListener *dcl,
      * We let SDL convert for us a few more formats than,
-     * the native ones. Thes are the ones I have tested.
+     * the native ones. These are the ones I have tested.
      */
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 0d91b555e3..ea4a92cd36 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -862,3 +862,3 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
 #ifndef CONFIG_WIN32
-    /* QEMU uses its own low level keyboard hook procecure on Windows */
+    /* QEMU uses its own low level keyboard hook procedure on Windows */
     SDL_SetHint(SDL_HINT_GRAB_KEYBOARD, "1");
diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index 09200d71b8..ee853dcfcb 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -79,3 +79,3 @@ static int tight_send_framebuffer_update(VncState *vs, int x, int y,
 static const struct {
-    double jpeg_freq_min;       /* Don't send JPEG if the freq is bellow */
+    double jpeg_freq_min;       /* Don't send JPEG if the freq is below */
     double jpeg_freq_threshold; /* Always send JPEG if the freq is above */
diff --git a/ui/vnc-enc-zrle.c.inc b/ui/vnc-enc-zrle.c.inc
index c107d8affc..a8ca37d05e 100644
--- a/ui/vnc-enc-zrle.c.inc
+++ b/ui/vnc-enc-zrle.c.inc
@@ -112,3 +112,3 @@ static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXEL *data, int w, int h,
 
-    /* Real limit is 127 but we wan't a way to know if there is more than 127 */
+    /* Real limit is 127 but we want a way to know if there is more than 127 */
     palette_init(palette, 256, ZRLE_BPP);
diff --git a/ui/vnc-enc-zywrle.h b/ui/vnc-enc-zywrle.h
index e661ec117d..64fbc90ee7 100644
--- a/ui/vnc-enc-zywrle.h
+++ b/ui/vnc-enc-zywrle.h
@@ -487,3 +487,3 @@ static inline void wavelet(int *buf, int width, int height, int level)
   RGB <=> YUV conversion stuffs.
-  YUV coversion is explained as following formula in strict meaning:
+  YUV conversion is explained as following formula in strict meaning:
   Y =  0.299R + 0.587G + 0.114B (   0<=Y<=255)
@@ -541,3 +541,3 @@ static inline void wavelet(int *buf, int width, int height, int level)
  So, we must transfer each sub images individually in strict meaning.
- But at least ZRLE meaning, following one decompositon image is same as
+ But at least ZRLE meaning, following one decomposition image is same as
  avobe individual sub image. I use this format.
-- 
2.39.2



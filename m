Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C283678EE62
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:18:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhLP-0008Aa-0S; Thu, 31 Aug 2023 09:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhHp-0006h8-Mg
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:00:38 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhHk-0006jf-Gj
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:00:37 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31dcd553fecso589819f8f.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693486831; x=1694091631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eBc3U04Z410g0QX/hz9VaosKX9rxbbm4KG7R96HSrHc=;
 b=fwIEO7fkbC/qaXVQZcpOWw8L/4oVWJZtCVa6fnlti2EPIes4rT49y1xfGdyV5Abxjq
 58aWjA/uGo+1VIYEWptHTJadiQCjMQo0/QvELQm4p+Jsnoj6waPchU49t0ARg350GQHN
 vstQPvwQOHr4W/9qZxkmR9+iBHcBSDxmmGvbOhDRhz2nvWmNtEE7y/rjI2HeloLGwTxt
 h0NyKLezYFSZUUe3lSSuZWoUsTZQFMwuXr9/0iHTSkht+zpbEIYXk/p+uZchscAm/v04
 HAb9oM/+y+ean1Fv3O7sRooo1yOPVJHiKF5ayXzExAgUwkvQC0WjXls2VSEQswjH742W
 2W/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486831; x=1694091631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eBc3U04Z410g0QX/hz9VaosKX9rxbbm4KG7R96HSrHc=;
 b=Cs5/Pu4X8e62QPQxlQ16WG010pOuSjxkCjS4dsx2kgcR/A+pUS98HThgU7eb7OYkC1
 0mtgap0cKO5lD9V0LcVjzAPtbpxxN4GLeS3zcJqWXlgPnkTvQkPiIcRNKar/DNJTwsRS
 eC0CR/HM3bWgOx2cPrySiDNWyo6vFnsnDyEgyZZIFebEfmu8QDTGOFySHFkxlZXy7h5g
 eNG8es1UJN2L0JpEmM5kugFJzyFwlJd/QRb8AKTtW2rPJMrLKuR7JnqyBhF4j+b9raGI
 98e8ndJTRhVZeC2xXJaMaUPmLbUwbBtFpAZLownIgIIiYIeZ+iRmcSM6Hm7jfugbHl77
 zkyg==
X-Gm-Message-State: AOJu0Yx0xcdgbm2PmvMc6IrSocXrGVxmP/QOxAcQvQnas/1FqnAn7nyy
 tZP8LCVtOfNHBXAyS7aT01l/kEWpH2guquHM/qc=
X-Google-Smtp-Source: AGHT+IFlA+4LBwjUmi9OBhNzgThAD7U46M9OQQNFsPw/2ByT38PA9WuH8p79l69m2NaS0/Yyi+PLVA==
X-Received: by 2002:adf:f6c7:0:b0:31a:c6b2:8c63 with SMTP id
 y7-20020adff6c7000000b0031ac6b28c63mr3695259wrp.21.1693486830391; 
 Thu, 31 Aug 2023 06:00:30 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 e33-20020a5d5961000000b0031433443265sm2162158wri.53.2023.08.31.06.00.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 06:00:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 37/41] ui: spelling fixes
Date: Thu, 31 Aug 2023 14:56:39 +0200
Message-ID: <20230831125646.67855-38-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831125646.67855-1-philmd@linaro.org>
References: <20230831125646.67855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Michael Tokarev <mjt@tls.msk.ru>

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20230823065335.1919380-2-mjt@tls.msk.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/ui/kbd-state.h     | 2 +-
 include/ui/spice-display.h | 2 +-
 ui/keymaps.h               | 2 +-
 ui/vnc-enc-zywrle.h        | 4 ++--
 ui/sdl2-2d.c               | 2 +-
 ui/sdl2.c                  | 2 +-
 ui/vnc-enc-zrle.c.inc      | 2 +-
 ui/cocoa.m                 | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/ui/kbd-state.h b/include/ui/kbd-state.h
index eb9067dd53..fb79776128 100644
--- a/include/ui/kbd-state.h
+++ b/include/ui/kbd-state.h
@@ -65,7 +65,7 @@ void qkbd_state_key_event(QKbdState *kbd, QKeyCode qcode, bool down);
  * using qemu_input_event_send_key_delay().
  *
  * @kbd: state tracker state.
- * @delay_ms: the delay in miliseconds.
+ * @delay_ms: the delay in milliseconds.
  */
 void qkbd_state_set_delay(QKbdState *kbd, int delay_ms);
 
diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index 5aa13664d6..e1a9b36185 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -42,7 +42,7 @@
 #define NUM_MEMSLOTS_GROUPS 2
 
 /*
- * Internal enum to differenciate between options for
+ * Internal enum to differentiate between options for
  * io calls that have a sync (old) version and an _async (new)
  * version:
  *  QXL_SYNC: use the old version
diff --git a/ui/keymaps.h b/ui/keymaps.h
index 6473405485..3d52c0882a 100644
--- a/ui/keymaps.h
+++ b/ui/keymaps.h
@@ -44,7 +44,7 @@ typedef struct {
 /* "up" flag */
 #define SCANCODE_UP     0x80
 
-/* Additional modifiers to use if not catched another way. */
+/* Additional modifiers to use if not caught another way. */
 #define SCANCODE_SHIFT  0x100
 #define SCANCODE_CTRL   0x200
 #define SCANCODE_ALT    0x400
diff --git a/ui/vnc-enc-zywrle.h b/ui/vnc-enc-zywrle.h
index e661ec117d..64fbc90ee7 100644
--- a/ui/vnc-enc-zywrle.h
+++ b/ui/vnc-enc-zywrle.h
@@ -485,7 +485,7 @@ static inline void wavelet(int *buf, int width, int height, int level)
 
 /*
   RGB <=> YUV conversion stuffs.
-  YUV coversion is explained as following formula in strict meaning:
+  YUV conversion is explained as following formula in strict meaning:
   Y =  0.299R + 0.587G + 0.114B (   0<=Y<=255)
   U = -0.169R - 0.331G + 0.500B (-128<=U<=127)
   V =  0.500R - 0.419G - 0.081B (-128<=V<=127)
@@ -539,7 +539,7 @@ static inline void wavelet(int *buf, int width, int height, int level)
    +------+------+
 
  So, we must transfer each sub images individually in strict meaning.
- But at least ZRLE meaning, following one decompositon image is same as
+ But at least ZRLE meaning, following one decomposition image is same as
  avobe individual sub image. I use this format.
  (Strictly saying, transfer order is reverse(Hxy->Hy->Hx->L)
   for simplified procedure for any wavelet level.)
diff --git a/ui/sdl2-2d.c b/ui/sdl2-2d.c
index bfebbdeaea..06468cd493 100644
--- a/ui/sdl2-2d.c
+++ b/ui/sdl2-2d.c
@@ -150,7 +150,7 @@ bool sdl2_2d_check_format(DisplayChangeListener *dcl,
 {
     /*
      * We let SDL convert for us a few more formats than,
-     * the native ones. Thes are the ones I have tested.
+     * the native ones. These are the ones I have tested.
      */
     return (format == PIXMAN_x8r8g8b8 ||
             format == PIXMAN_a8r8g8b8 ||
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 0d91b555e3..ea4a92cd36 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -860,7 +860,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
     SDL_SetHint(SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR, "0");
 #endif
 #ifndef CONFIG_WIN32
-    /* QEMU uses its own low level keyboard hook procecure on Windows */
+    /* QEMU uses its own low level keyboard hook procedure on Windows */
     SDL_SetHint(SDL_HINT_GRAB_KEYBOARD, "1");
 #endif
 #ifdef SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED
diff --git a/ui/vnc-enc-zrle.c.inc b/ui/vnc-enc-zrle.c.inc
index c107d8affc..a8ca37d05e 100644
--- a/ui/vnc-enc-zrle.c.inc
+++ b/ui/vnc-enc-zrle.c.inc
@@ -110,7 +110,7 @@ static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXEL *data, int w, int h,
     ZRLE_PIXEL *end = ptr + h * w;
     *end = ~*(end-1); /* one past the end is different so the while loop ends */
 
-    /* Real limit is 127 but we wan't a way to know if there is more than 127 */
+    /* Real limit is 127 but we want a way to know if there is more than 127 */
     palette_init(palette, 256, ZRLE_BPP);
 
     while (ptr < end) {
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 0c2153d17c..4d8989c4eb 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -2045,7 +2045,7 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 
     /*
      * Create the menu entries which depend on QEMU state (for consoles
-     * and removeable devices). These make calls back into QEMU functions,
+     * and removable devices). These make calls back into QEMU functions,
      * which is OK because at this point we know that the second thread
      * holds the iothread lock and is synchronously waiting for us to
      * finish.
-- 
2.41.0



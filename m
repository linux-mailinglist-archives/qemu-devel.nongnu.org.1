Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6C27063AE
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 11:12:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzDC2-0001N1-JR; Wed, 17 May 2023 05:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDBk-0000wJ-09; Wed, 17 May 2023 05:11:16 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDBh-0006Pb-Tm; Wed, 17 May 2023 05:11:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D6E32683A;
 Wed, 17 May 2023 12:10:45 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 51A865F0B;
 Wed, 17 May 2023 12:10:45 +0300 (MSK)
Received: (nullmailer pid 3626726 invoked by uid 1000);
 Wed, 17 May 2023 09:10:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v7.2.3 20/30] ui: Fix pixel colour channel order for PNG
 screenshots
Date: Wed, 17 May 2023 12:10:32 +0300
Message-Id: <20230517091042.3626593-20-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684310574.git.mjt@msgid.tls.msk.ru>
References: <cover.1684310574.git.mjt@msgid.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

When we take a PNG screenshot the ordering of the colour channels in
the data is not correct, resulting in the image having weird
colouring compared to the actual display.  (Specifically, on a
little-endian host the blue and red channels are swapped; on
big-endian everything is wrong.)

This happens because the pixman idea of the pixel data and the libpng
idea differ.  PIXMAN_a8r8g8b8 defines that pixels are 32-bit values,
with A in bits 24-31, R in bits 16-23, G in bits 8-15 and B in bits
0-7.  This means that on little-endian systems the bytes in memory
are
   B G R A
and on big-endian systems they are
   A R G B

libpng, on the other hand, thinks of pixels as being a series of
values for each channel, so its format PNG_COLOR_TYPE_RGB_ALPHA
always wants bytes in the order
   R G B A

This isn't the same as the pixman order for either big or little
endian hosts.

The alpha channel is also unnecessary bulk in the output PNG file,
because there is no alpha information in a screenshot.

To handle the endianness issue, we already define in ui/qemu-pixman.h
various PIXMAN_BE_* and PIXMAN_LE_* values that give consistent
byte-order pixel channel formats.  So we can use PIXMAN_BE_r8g8b8 and
PNG_COLOR_TYPE_RGB, which both have an in-memory byte order of
    R G B
and 3 bytes per pixel.

(PPM format screenshots get this right; they already use the
PIXMAN_BE_r8g8b8 format.)

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1622
Fixes: 9a0a119a382867 ("Added parameter to take screenshot with screendump as PNG")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20230502135548.2451309-1-peter.maydell@linaro.org
(cherry picked from commit cd22a0f520f471e3bd33bc19cf3b2fa772cdb2a8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 ui/console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 3c0d9b061a..646202214a 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -307,7 +307,7 @@ static bool png_save(int fd, pixman_image_t *image, Error **errp)
     png_struct *png_ptr;
     png_info *info_ptr;
     g_autoptr(pixman_image_t) linebuf =
-                            qemu_pixman_linebuf_create(PIXMAN_a8r8g8b8, width);
+        qemu_pixman_linebuf_create(PIXMAN_BE_r8g8b8, width);
     uint8_t *buf = (uint8_t *)pixman_image_get_data(linebuf);
     FILE *f = fdopen(fd, "wb");
     int y;
@@ -337,7 +337,7 @@ static bool png_save(int fd, pixman_image_t *image, Error **errp)
     png_init_io(png_ptr, f);
 
     png_set_IHDR(png_ptr, info_ptr, width, height, 8,
-                 PNG_COLOR_TYPE_RGB_ALPHA, PNG_INTERLACE_NONE,
+                 PNG_COLOR_TYPE_RGB, PNG_INTERLACE_NONE,
                  PNG_COMPRESSION_TYPE_BASE, PNG_FILTER_TYPE_BASE);
 
     png_write_info(png_ptr, info_ptr);
-- 
2.39.2



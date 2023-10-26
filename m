Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F71D7D7F22
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 10:58:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvwB9-0005kR-2A; Thu, 26 Oct 2023 04:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvwB4-0005j3-Iy
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:57:18 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvwAy-00061H-Ui
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QcgOLGJr8/48S2M46OzOv/0iJYPh4mcebYi3O1KWHpE=; b=FriN8Ng7TyNGtM76v5zRd5C0h5
 j4zJnrbnB2fce6PWUDxI68fhEmEyv0Ugv0OG06m4NORl6rlspf1WbfioAZWdLVsuoyrt4Y3mEESI9
 shOGDAaeicLeL2V25BYYoe5WwP/HVtJLflM5gJyyT9HI17dRKEiBdrAAO0nXt5JIDINXEBR5C0+u8
 8W08OzIUnMT0Dx//Ue+pQ7qnQXbtpMexKNa8DGclhionXU0qgZ1DKYuIFpxtRDs/o6AbUcc9bvkvC
 jPor5HZs706WTYP8lRF+Bevie29qXw0UALs0/cK4Y5+M9owsemjnEo26YFmI6CFLZVA5PZGJkUMnx
 eWHJXAwKp2pyYeDCgpDRUMfhK4woOO8nSGy2Z00OwojnSLeV3lLSUOV4mfwuhtqJ/+qo7IefB7Uai
 icF5G5xSgb2EMQ8ePcGfEEoRKUmpoQ9EGy1HZdnwjt/4Y2cdaIn+YoEBzKzP2hltpJHGOMBqJD2NJ
 oD36x4SPTxYLKREvfoQGG9KiVYSmpCsGZc16EqTVDMhDCunISew2q1UzCZLQsvneKZdSF7tx6QL7m
 GZM6M6qeOTwuyxghiRGv+IFC3hl0frptKcTwK+oIA30i0IncgpQEHh4Zwod9yhL2T0xwO1kp2YSIN
 6MKj6WsBmj0MgCjpukBCJNgzT6GmJfSU6tuS9vvrk=;
Received: from host86-130-37-248.range86-130.btcentralplus.com
 ([86.130.37.248] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvwAn-0000md-9Y; Thu, 26 Oct 2023 09:57:01 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Thu, 26 Oct 2023 09:56:49 +0100
Message-Id: <20231026085650.917663-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231026085650.917663-1-mark.cave-ayland@ilande.co.uk>
References: <20231026085650.917663-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.248
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 3/4] macfb: allow larger write accesses to the DAFB_LUT
 register
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The original tests with MacOS showed that only the bottom 8 bits of the DAFB_LUT
register were used when writing to the LUT, however A/UX performs some of its
writes using 4 byte accesses. Expand the address range for the DAFB_LUT register
so that different size accesses write the correct value to the color_palette
array.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/display/macfb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index eb4ce6b824..4a1c75d572 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -37,7 +37,7 @@
 #define DAFB_INTR_STAT      0x108
 #define DAFB_INTR_CLEAR     0x10c
 #define DAFB_LUT_INDEX      0x200
-#define DAFB_LUT            0x213
+#define DAFB_LUT            0x210
 
 #define DAFB_INTR_VBL   0x4
 
@@ -586,8 +586,8 @@ static void macfb_ctrl_write(void *opaque,
     case DAFB_LUT_INDEX:
         s->palette_current = (val & 0xff) * 3;
         break;
-    case DAFB_LUT:
-        s->color_palette[s->palette_current] = val;
+    case DAFB_LUT ... DAFB_LUT + 3:
+        s->color_palette[s->palette_current] = val & 0xff;
         s->palette_current = (s->palette_current + 1) %
                              ARRAY_SIZE(s->color_palette);
         if (s->palette_current % 3) {
-- 
2.39.2



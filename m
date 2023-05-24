Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8983070FFD5
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:14:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vn1-0004YT-Gm; Wed, 24 May 2023 17:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmt-0003qX-QL
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:12:54 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmr-0002DV-Di
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Etj0Y/r26aMyxSkJBfiWqE18oDsTFfbbtn7h/espvPI=; b=03i7o82CJhL3NZ3L2uF69BbF9O
 GPDdAt1LBDd8JYy7ySIsy57bRoUBnPRvdGCWzVYNRIJbigFeGzUJ5hG5QckWxCoo+8k46eEJxzu55
 LNPMJQOmhKS20kfQn7nNOXs7ETC8PmSuqRl6n4JyrWV2fKCXZUQaKlIl4fbreF2njmlAiMV+ywB3x
 xEkcKeK1jsNJq3Sh3oinKUSvc7EgHnUbBtI8+WlcCpvXwBk+mUG1Qpi0O7r7g5Od3d5WnsmEo6+04
 m57crFBVWFl5bgPu31Rpubu093shNTUy7KDPt1a/f/YJSqU1+d0FwEXHjF39z6q9TbCFGMY2dwQHc
 LRln2vZ6uoM1Fg3Vgeap9H3rk4ETtByoThpLauiyWLNt2aFd86NP2N47w51b855zJVZk/yEDEfsZn
 tYy9V4aGwdeFRc1Ab11wIzjgrNv3CpKUohlkC84DFrKWoxnL37geIQBwniPu9GODZ1eMTnPRX/dIQ
 1TQ30W8OEsRlTgmDplV4yV/VVKrm6zQPO/eAOY2Q0GGSqyXXi5GPNEarjnk7QBSIKlaz0JThddr28
 e8/YrLwCD2GLQO4k5epnObtNHXzQ7JXJt/YMHlW42dNHUW2fe4/XBLtSL0fIi5xAUp4wW0mBA0MkP
 Bb/6X6IgOp2d2nR/zUowRn7CQhs1ygp4SoAETkz9g=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmY-0005XR-HH; Wed, 24 May 2023 22:12:34 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:10:57 +0100
Message-Id: <20230524211104.686087-24-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 23/30] mac_via: fix rtc command decoding for the PRAM seconds
 registers
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Analysis of the MacOS toolbox ROM code shows that on startup it attempts 2
separate reads of the seconds registers with commands 0x9d...0x91 followed by
0x8d..0x81 without resetting the command to its initial value. The PRAM seconds
value is only accepted when the values of the 2 separate reads match.

From this we conclude that bit 4 of the rtc command is not decoded or we don't
care about its value when reading the PRAM seconds registers. Implement this
decoding change so that both reads return successfully which allows the MacOS
toolbox ROM to correctly set the date/time.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/mac_via.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index d7067030db..5d5334b0f6 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -366,10 +366,10 @@ static void pram_update(MOS6522Q800VIA1State *v1s)
  *
  * Command byte    Register addressed by the command
  *
- * z0000001        Seconds register 0 (lowest-order byte)
- * z0000101        Seconds register 1
- * z0001001        Seconds register 2
- * z0001101        Seconds register 3 (highest-order byte)
+ * z00x0001        Seconds register 0 (lowest-order byte)
+ * z00x0101        Seconds register 1
+ * z00x1001        Seconds register 2
+ * z00x1101        Seconds register 3 (highest-order byte)
  * 00110001        Test register (write-only)
  * 00110101        Write-Protect Register (write-only)
  * z010aa01        RAM address 100aa ($10-$13) (first 20 bytes only)
@@ -377,6 +377,7 @@ static void pram_update(MOS6522Q800VIA1State *v1s)
  * z0111aaa        Extended memory designator and sector number
  *
  * For a read request, z=1, for a write z=0
+ * The letter x indicates don't care
  * The letter a indicates bits whose value depend on what parameter
  * RAM byte you want to address
  */
@@ -393,7 +394,7 @@ static int via1_rtc_compact_cmd(uint8_t value)
     }
     if ((value & 0x03) == 0x01) {
         value >>= 2;
-        if ((value & 0x1c) == 0) {
+        if ((value & 0x18) == 0) {
             /* seconds registers */
             return read | (REG_0 + (value & 0x03));
         } else if ((value == 0x0c) && !read) {
-- 
2.30.2



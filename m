Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D7F721749
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 15:16:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5nb6-0006u5-6C; Sun, 04 Jun 2023 09:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nb2-0006U2-7K
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:16:36 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nb0-0003T2-H6
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RZPPecDlHV4Qw2k5yjU6Ai2tqsGrdK9RgBx7NxHeIkY=; b=yX/L/FJb6hYc5phF/Mt5+XnBJg
 UYsX62S4DyzbZH0cC0oUtWesPDWAjVYp8oGasce5jMNO/4amohir5I/ZK/JRHcognE7Wthrg2VwRV
 yS6TnrPFcwkV8HQp/fuHdQqip7a8hykyprAW/3c1MyRb/P9UHT80B4sI6jiZF8eB202PF6zjIpQi6
 6ZytWubfo21bsMxBUCgODyXRCuhjI/sfGT30ejMiJ+qpCdPXd8EouArnyQ29P4FDYoiCaEIkUtJbx
 wPVa4ysrmucQWnMv3X3GD1lsxjXYhPqKQmMEMLpYk7YLR6epYabxWqH8G0ANYRMzJEVs5Ed6BUgd0
 amqMd100WeMyRyyPx1/N0ipyNcZxyqR/TZkFBNi7N/WVuPidFfgih9qth6UYgUmSQfk7ygEwGQnps
 O+8hDOoY1hcBPzdDYaTYPvNQH+DTKojYFnqs7YALScdR3Lze0qb0xwAWXcsKC6YF2tRxYv511bCnv
 ASaDb1omHoO1ICZVtdsLwgqoEtQbchiW18D8fK0bXVLkf6wCRkzz/yD5rWpPNmxUHM2AVgQJT/5XX
 Vqm67u7C955FARSwI8+9AopzP0uX6nvOXjxtkE03YGCfchr2XO9L6CFWQFv61vTTZMS6RBzlpk8n8
 QFnSjLdqvTvsjD/7joXN/OGEVHAztdyK0W+UbxDHM=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5naf-0005pb-DV; Sun, 04 Jun 2023 14:16:17 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  4 Jun 2023 14:14:50 +0100
Message-Id: <20230604131450.428797-24-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 23/23] mac_via: fix rtc command decoding for the PRAM
 seconds registers
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/misc/mac_via.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 85c2e65856..0787a0268d 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -362,10 +362,10 @@ static void pram_update(MOS6522Q800VIA1State *v1s)
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
@@ -373,6 +373,7 @@ static void pram_update(MOS6522Q800VIA1State *v1s)
  * z0111aaa        Extended memory designator and sector number
  *
  * For a read request, z=1, for a write z=0
+ * The letter x indicates don't care
  * The letter a indicates bits whose value depend on what parameter
  * RAM byte you want to address
  */
@@ -389,7 +390,7 @@ static int via1_rtc_compact_cmd(uint8_t value)
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



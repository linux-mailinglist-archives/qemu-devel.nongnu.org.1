Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B65737DEF
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:57:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtd4-0004oC-Vr; Wed, 21 Jun 2023 04:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtcw-0004bK-2R
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:55:47 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtcu-0005Mm-2N
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RZPPecDlHV4Qw2k5yjU6Ai2tqsGrdK9RgBx7NxHeIkY=; b=Ufb+XBFsG2PyS7xGN5yvR8EGdw
 cZvH1zOKsTSRWw4ff4klUYj+Kh5bt5OAf3dAHOqotdN/RaKne3prT83XiSoopkA/3SYSuCemQtLF2
 uquXNKIkjKwSdBEwawLFI666HGihTtbAaUaBaXqSmcj8h3+Zca0eeNmM4v+bLTDP2uSb294/yxvV2
 22lBY4sFKDL/V8ExkQB6nWp2SY5rFWByny6SHMuwyMrZiqXea9OmA7Isq/X4zWbvJi1l3TpbgDCLJ
 8DEB6fcbHPvvGQTPUv+KhIbGIZ7MnTdDwCUh/eJFi6vI6hVBnd3R+dd0jHQJqyT0jzpXX8Tz6tfi8
 04bBgAKxa/clxJHIn5ORzNescmnw3yOgea2hYKv2uogL/ZyhFBW3RXAfC0YWea/et4DOJyoM0z4Pv
 UBQYkTNiFer+BylvXvhQGCI6SngIRLn/cKiYv4WYcQF20iTFnBm+cttknOsJH4H0Zh9nBHq2ry4b4
 eIgml2adeFR6t7M7OCDhS8crHVpEu/7OKQmUkkdXj9vuARHdmExFqLg6SbYRpXfq6VQKMfmX1669Z
 x4gCEUPZQy2lTgJkYV6gAQ4qO6CV9/9CeSRnPl8iWGz844aNfdoeRxGnk/lmBo34yC6L8oUN8B83s
 JTt6vHQ1KJdazIkNS94rAfG2PgXWv0ezDJudQaWd4=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtcV-0001ZB-UU; Wed, 21 Jun 2023 09:55:26 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 21 Jun 2023 09:53:53 +0100
Message-Id: <20230621085353.113233-25-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 24/24] mac_via: fix rtc command decoding for the PRAM
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



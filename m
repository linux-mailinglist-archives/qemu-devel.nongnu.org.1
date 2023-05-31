Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 050817180AB
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:57:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LMj-0001OJ-Dp; Wed, 31 May 2023 08:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LMg-0001B8-RX
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:47 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LMd-0007A1-ML
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mEdEKrn8U4oFpRm6aYVrdum8IY3Swn/ona6HoA0rkf8=; b=gxTnZoQCyDvhewuKUq51erLUnR
 XuyXUefmSXTtl7l1ZXuHUA6Zo4aAEaabYgbeBM6A5gxuX/+77y8zTgGdbjZz6k7UPw8Zc4BJvVQvi
 i4LXWJOOSGzsPnanrzXg4MZ59RtIpK8SFjQRtmdQd8ZyzWwGYONcw8wTR7KiKIGSBUHKBowEwrOQL
 ryw0TVGWKAT/hpsU1/9T6QXRXz+6rd4/BhWsD9+PeIICzpnM1bxQsa0Uw1nF+M35313I7QtKFKxQY
 36E6lvW/2av7dqOBo5HZzneZkFBIQNM2tWvnzLCkAa9iRI5miq6HbMaGGgfnQ7CaOeC3oV1UVLNWm
 Yga4A7yBz/kpt9LJzx+T8vUZMbh5uHQ96q7kc6dQTrOPhmyQDS7NTG0o50cA91bEwNfcQqSRtsLJ1
 AttLlSQPkMtyTrxXr820I/FKlI0GhsRRc/PPEnUoNo4Hz4uFSfGX1AYtGZLwNPjy6W3/xPyFhkvFb
 iWrHSzP3BvojEdXk8r6GmyniWUKoQjW0aoS+fL+yOsLk0Nuka49GyRKYt2/eodyG8ZKZ5VQkT2/FG
 Z5RXmUIox5w8wqYORdpCc1YFzfG9F+Y3K6qRCtIatPeLM9ITpJPUNL65/kYxRlugUlmnKIwG98qoE
 G43RFZ8blbG5dZi7YO52Va0qZssBRydEYykJixnqE=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LMK-0008vd-1Z; Wed, 31 May 2023 13:55:28 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 31 May 2023 13:53:59 +0100
Message-Id: <20230531125400.288917-23-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 22/23] mac_via: fix rtc command decoding from PRAM
 addresses 0x0 to 0xf
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

A comparison between the rtc command table included in the comment and the code
itself shows that the decoding for PRAM addresses 0x0 to 0xf is being done on
the raw command, and not the shifted version held in value.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/misc/mac_via.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 076d18e5fd..85c2e65856 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -399,7 +399,7 @@ static int via1_rtc_compact_cmd(uint8_t value)
         } else if ((value & 0x1c) == 0x08) {
             /* RAM address 0x10 to 0x13 */
             return read | (REG_PRAM_ADDR + 0x10 + (value & 0x03));
-        } else if ((value & 0x43) == 0x41) {
+        } else if ((value & 0x10) == 0x10) {
             /* RAM address 0x00 to 0x0f */
             return read | (REG_PRAM_ADDR + (value & 0x0f));
         }
-- 
2.30.2



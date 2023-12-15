Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF41F815096
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 21:02:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEEMi-0005uI-3S; Fri, 15 Dec 2023 15:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEMI-0005q8-7T
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 15:00:33 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEMC-0002Rp-FG
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 15:00:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KwkcX2p2CggrT+XEVqJqQeqBm3YT5rrIsNgp/IIx1Qw=; b=MqLwy2JLXQyRbEJVxaimv4u96g
 ljZIT9V8SkWSmI46q/qg963GXJW4i8wafpxo0OhY4NT9HM6TpktZK9zRLrgbhcuyZY2bfzX0ENTVR
 sAMR+RaBJxRlHI1CBsfto2i6zmYvVFBI+tXU5prvl35x4QWrRV8InjE+s8E3No3FRsZuyhIb0F3x3
 UJoUg7vRbbMM3o8HKNAvg7CF+4BU0N+GG4UEOeyBPRCgnmkCH8nvF5lzR7/GVU0P9DMYPbWdvhO+V
 zR1iltWKzEO8aFFyW+nwPDwHmwl5VvRaCkCePyqjxMQ7WbaLyA2zIxrwrkkYak89mb+hFXvnrdaL4
 blEiR6KtpfiCOCqnp1vUK+tjtI3bxhTh8SvTAHvURY/C6dLV+0L+5At+hSyfJHASgx5RGlTDYWFjI
 V3D7XY/JEJG/ALSoQg8wgZXQ5XC8PjnFvoqqZoa0X5sfDIsT1CBXRM+71J/Kb2OiXMhUgX/24JcIo
 nvsU1uQKGfT1pRqAQr5LSmEShMenTTHqH39EtNXwP+bpa6n5Bsrj8Ww8L7ga+aCgA8iUXMEUQuS3m
 qyzdnHmBq+NgcIKx00q+z0PbXsFQDcxO8/tjrpaKG3M1qvxIZyDQuROcVNkyPP1DvkjFYQrAoD5Js
 msKkcIxCUtBk3+I2hVKfyYM3FBkOjrRTBANuOmO4A=;
Received: from [2a00:23c4:8bb0:f100:5e2c:460f:a6a7:b066]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEELk-000AEs-9l; Fri, 15 Dec 2023 20:00:00 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Fri, 15 Dec 2023 19:59:58 +0000
Message-Id: <20231215200009.346212-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:f100:5e2c:460f:a6a7:b066
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 01/12] next-cube.c: add dummy Ethernet register to allow
 diagnostic to timeout
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add a dummy register at address 0x6000 in the MMIO memory region to allow the
initial diagnostic test to timeout rather than getting stuck in a loop
continuously writing "en_write: tx not ready" to the console.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index fabd861941..feeda23475 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -429,6 +429,10 @@ static uint32_t scr_readb(NeXTPC *s, hwaddr addr)
         /* Hack: We need to have this change consistently to make it work */
         return 0xFF & clock();
 
+    /* For now return dummy byte to allow the Ethernet test to timeout */
+    case 0x6000:
+        return 0xff;
+
     default:
         DPRINTF("BMAP Read B @ %x\n", (unsigned int)addr);
         return 0;
-- 
2.39.2



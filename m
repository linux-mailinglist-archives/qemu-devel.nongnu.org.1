Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB57E819FAB
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 14:18:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFwRk-0007o9-Q1; Wed, 20 Dec 2023 08:17:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRa-0007nI-FL
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:06 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRW-0002IG-5j
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Pk2e4vQ6ZQ/yBkKcQXjFvAd/v4jSvfkOMv4I/0gFjig=; b=WTP2BLBwkE9bPqmxXUBI976530
 qMAcuqeIY0+CsxmW620OIiqdYiPbViJYn+Wbe02WWOfrKuXvUOIgyBFg1FYz18NqAhSlVGjcGgICk
 sMFJAsawUiqjHBgTK9x5feuQlZfgq1mb/ipueaZO1F/qy8uOLa49wis4KrD3Hoc9NvSXef8pH0rIT
 qVo5dbiyvR5YF7ZNO+2Lg+Y6r3b/DHv0KZ6dI5lNI1k57zkvoC7cY9S+93GkcixrO2dbG0GMMxV/1
 3l2KpbuOf37704Zak8O1q0QNdQ8vx17P03xpFca1A+CuxHwrNJ4Mi9Ee2YrxPXb4JgwQUlMMyo+KG
 mOTKqPUBDbLknE5eCzoZLq3Y0dfA7Rlmado6qbY04GAsnLwNwd4E71dAsWS8pScgCxYcTd7aztcgL
 WwY3WjcDKCyh2maKJRM6IhAGqvsGhqDYi/AJp/3neyOV2G8yWmLp7xTK4xX4t6DHrjCNJHV2H0HZ/
 B+O26ABtYGxwmQYRy9z6R6TEuQovfqhJbp2/QYwZu/Pddj2iI4hLKoC2Z9XzMLskLXInBHqyAf2dE
 KHfV+HX4YPE7CXWD/a/OXI+VJ+HTyUAb/ZSiYeMp0/lQio7MrUiYfgOPQ8pNaJzH9hQirvci0dVHS
 3jz4aE7Z4MhKrlrIcmjEniLk5pKob7svkcU8yEMDo=;
Received: from host86-147-134-9.range86-147.btcentralplus.com ([86.147.134.9]
 helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwQz-0001qt-U7; Wed, 20 Dec 2023 13:16:30 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 20 Dec 2023 13:16:31 +0000
Message-Id: <20231220131641.592826-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
References: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.147.134.9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 01/11] next-cube.c: add dummy Ethernet register to allow
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

Add a dummy register at address 0x6000 in the MMIO memory region to allow the
initial diagnostic test to timeout rather than getting stuck in a loop
continuously writing "en_write: tx not ready" to the console.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Thomas Huth <huth@tuxfamily.org>
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



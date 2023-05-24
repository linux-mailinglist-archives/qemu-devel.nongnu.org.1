Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E9B70FFD6
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:14:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vnA-00061W-8G; Wed, 24 May 2023 17:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vn6-0005Oj-JL
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:13:04 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmy-0002Gx-Ud
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fLAdXF7hBFU36EAoDz3XPbgtNfxOXf//b9bgf2h8ozQ=; b=jkOUrMH8Nx2lLFiQwzCA47vO4U
 4B4p59xwiNFEHdP1mARjLZVxGj8YqSINMxfcmORSL+9ufXKqb8rH0hHJHkpXgKqlUL4oC6V9pjIW6
 wIfH1UqOSOxVJUpvj3GycYqY9m1gUi1Pk7x7MWHwLASqdX3Iv5/OcheeRUPv7yTqbXCVbdWukciL7
 KA8HecuHhexXmCT6T5ETMYx3k/mt4kceNbMXLFvDs0ODGzlOd4jHVnwvdXnHXj7YTpChCtnU1ptsu
 ZParkVJ8MzBw7QNZTiDvg4UbKBC1JBflhnWMHerW/oDLj+w5uDSsGFzxWbfwRts5VExRhSVHLyQJk
 HOelYx9koPv9PaInJ1kJRTIvZEDNbBY/tQ75g5wUlPcwfKunVSEVX8rQd3d5t4xl9uErcj+67xCsG
 j34MBCThOzcE8f7yUhbBI1kP1Sf5HIlgqGktEttS88bsbbezp471NlVyvd1EqiAvjYNxNjTLPC0p+
 Mz0Zkgtkdrt3VZP+e1Rk9yIFggF7Th9e+2NuaEh/oz6tj/sSCYPl47EaiZOp9F5hIjsV/SGbId8hp
 ncuCxqntgeH290434M/s7hXHi9u/6o3k94z9zqep28nl8hOWulzUKpQzG1mPUrVUsB/IxEpKCtfjW
 vhz9yj4TcDSD4hq2fvhGDbeHRwhg4jcvsxH/Nxzn8=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmh-0005XR-1V; Wed, 24 May 2023 22:12:43 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:11:00 +0100
Message-Id: <20230524211104.686087-27-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 26/30] mac_via: always clear ADB interrupt when switching to
 A/UX mode
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

When the NetBSD kernel initialises it can leave the ADB interrupt asserted
depending upon where in the ADB poll cycle the MacOS ADB interrupt handler
is when the NetBSD kernel disables interrupts.

The NetBSD ADB driver uses the ADB interrupt state to determine if the ADB
is busy and refuses to send ADB commands unless it is clear. To ensure that
this doesn't happen, always clear the ADB interrupt when switching to A/UX
mode to ensure that the bus enumeration always occurs.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/mac_via.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index c1d2866ec9..ee44cb4437 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -875,6 +875,15 @@ static void via1_auxmode_update(MOS6522Q800VIA1State *v1s)
     if (irq != oldirq) {
         trace_via1_auxmode(irq);
         qemu_set_irq(v1s->auxmode_irq, irq);
+
+        /*
+         * Clear the ADB interrupt. MacOS can leave VIA1B_vADBInt asserted
+         * (low) if a poll sequence doesn't complete before NetBSD disables
+         * interrupts upon boot. Fortunately NetBSD switches to the so-called
+         * "A/UX" interrupt mode after it initialises, so we can use this as
+         * a convenient place to clear the ADB interrupt for now.
+         */
+        s->b |= VIA1B_vADBInt;
     }
 }
 
-- 
2.30.2



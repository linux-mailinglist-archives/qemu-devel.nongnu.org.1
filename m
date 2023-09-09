Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AFD799725
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 11:50:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeub5-0006xI-9I; Sat, 09 Sep 2023 05:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeub2-0006lr-W5
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:49:45 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuaz-0005L2-Qs
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WdlWOXnFupLCJusB51AeC85924LhF0imZkxuhK469as=; b=IpO5ZmozxXLxb2B4QlYt2QfmQ4
 d9J1VVx4S0UzVQ67meFGV1JpYV1fB4gGjzt0JfxQJtWmyZzQ0nj/1gPQGKseYoHhDRbYXlo5Wdjm3
 Y5UXREbv/S9pzBsixLQoGAqdVMfwOG4e6LnzQe8ZOZzh7R986Gsj78VBneFPjSISrqp4kkk95wiDS
 DRMqQT1OvQJB1j7motly1tKqxma/sJSJedm++HllDSKp0ybwBvCrYM6njxM1XTUWoDZ6SkyG3yHqj
 ryLJ4kDQip9dWLUgJqOrUgFpv5lZEjI4prVAxBggNaLwsbIUGIIfSgXcQTpZ+Qj427SBakQAniZ5M
 5lU5OvjCM7XsdZguHDl56O7+1UYu/hcfU6quN6WkXjCCJpKe5CbwicUrJ2OEQMNJugpb29jI97aoy
 c8JslPl3T87j+O2ybJSeupjsyViqCDinVbkbuAmdWMzBQZEmvg5aiFTn7nZX4zJ2UWz8GRvZ95ZpC
 Ku/eD0ImTWKntd872nm8wHuLuO4jevu8XsELVVKSkIWlSqCZEE612+aL59AR9bWkNZqIw9iW91K27
 52hPuRcpTAXe4VMeS2CCdhBPjUzjZ54btTvIed/q2wLwwgPlBhjyl4JHmacyTNLwBEjUlzsgvWOFU
 hElL+kYE2a5esnP1UkJIYyBdRV4zGS9HvPAb8bZ1g=;
Received: from [2a00:23c4:8baf:5f00:e007:7058:31bc:5be9]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuan-0000uO-II; Sat, 09 Sep 2023 10:49:29 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sat,  9 Sep 2023 10:48:24 +0100
Message-Id: <20230909094827.33871-18-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:e007:7058:31bc:5be9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 17/20] mac_via: always clear ADB interrupt when switching
 to A/UX mode
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
index 398e8d1967..5d1adf5863 100644
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
2.39.2



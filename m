Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FA3744E6A
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 17:50:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFzKw-0006CV-VP; Sun, 02 Jul 2023 11:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzKt-0005yF-7r
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:50:03 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzKq-0007UO-Tx
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z1MwgEclRZQzlxYjqy2P0QF4yLhomVsHfbat/Y44MjE=; b=q+syu6AwytVps80wAva5xKlzI5
 j6rEi5EgzgOtXwzkK1lyctrhuNS7zDy7oq6X5sylbK6sFWH2T1Mg1ENEzR43j4XQg+tuaMMyp7gWm
 mDHmKVuNUSxfJjdkmHIbKGmcr1cFR4WkiHmgxJYRuiCYuP9BPIBrm6uZBwzWdmdcVyOiemj4Nt01s
 iAJIC1LlF/+EuTdslG9mHYjhQcUV7eYP4jbs/48AmKAk+kPP4xmHmAPjKipW3jdNhVe0noA3CXoNJ
 GsHfMqiUCHD5GIhbbniodMkiF1NdlNgLeGjRGnHeYISUlmE8Qftji1WE/SCQYwnYqxJ+cAZwg8V4p
 laYXa3svSCRgMoBXHe9W20xPaB5ffWWeRcFWPQDETcaZXaQQaAYMu1kiyP9OmcaIbRsTCXpQzGCFV
 9UinQquUt5FZkd6/tVgeqtcXfYgNqHx7cMusOdDnIlnYbcIRfe3a7Z6qgl7JrJH1s31f5b1gTom0t
 S8s6ejaID786iusb7QRnmuNVt/7WvOlpWALxiPCuIc2in2gtaUisHUtirIE779PCXyBrEFoUhArqc
 Ji0/EHjhLY/k0vmhmPpvMIHdNkv4R88V8vabKRjbowK1grjY3zeLOllXfjiVbxJvVbhuJcnygOQGd
 VgncSpoRe+/aTPPLXS8PGK9DvxdLFDU4Jt24SGLZU=;
Received: from [2a00:23c4:8bad:df00:f732:dd76:7417:d15b] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzKR-0001Ji-Jd; Sun, 02 Jul 2023 16:49:39 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  2 Jul 2023 16:48:34 +0100
Message-Id: <20230702154838.722809-18-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bad:df00:f732:dd76:7417:d15b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 17/21] mac_via: always clear ADB interrupt when switching to
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
2.30.2



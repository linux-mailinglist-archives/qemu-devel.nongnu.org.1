Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4F27180A7
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:57:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LMi-0001B5-Gt; Wed, 31 May 2023 08:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LMX-0000ZD-QE
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:39 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LMW-00078h-8L
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nkhn94biz/ijNagHmnaKLFeGPYGGzRN+yDLCbkRdx00=; b=rqCkuovg6U7Bdvz6s4dLTv298A
 3pAhFiI/wYH9Ll0lP2fKJN2PNTYhlebfilKYJ5RbRWuykyeaO4c4idkS71Rx3N1lowYPANAec5sbF
 4+1QJaJlk6Vcv1KBnZ0pOBMqWeTu8dNNjffJUW9mgoR4EhkmmDNeSY7Dwl2/1o+vbpiFIt01d2KiZ
 J1Kl82/XFPRVsA5T1NZ1nCiwAL1eQFzIDBPud3CRRb+aq+pu26cCmb8Yz3GXVCkaGJzwZ4dUNg1bE
 Esl1HCRY2XQwlkgEDLZvaugFyQrmlNandL7cvw9y4KwLPrKduW2as3D4mVfyPjqRFfoiJNfD5yGCD
 B6Y85MzkPb5EdBBOspr9oqMDm+3QmNkmy2o7Xa3aLN2OIo7d8Xt+/8KcBLdWdQChAvWS7MxZ1ddz4
 LpyNTRgLC0/nm6W3z9VCDiAGCneibrTfIU8wlUnPZUBcVc3eAGMvvDyPKR90BlS5kn/o7IS2m16ko
 xWF5hRXj1VeeEaDtVgiq0AfdkGxipbgUltcDpX1b0/bB9oOXMdn+/K8Bz1Fb6JeeB9gU3NVxNkNhn
 r2jizWdMJBBh6CFMUrTWz5ALw1+KpPKwcGXYbF9z+QKdfcQs7hDC/MJflIUxv0UmQ1z+Yv0f+Iu60
 eR+MzKURVgcUVWcak3GJqDLG3KCNk7svh7Ek/Pn10=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LMF-0008vd-DX; Wed, 31 May 2023 13:55:19 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 31 May 2023 13:53:57 +0100
Message-Id: <20230531125400.288917-21-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 20/23] q800: don't access Nubus bus directly from the
 mac-nubus-bridge device
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

Instead use the qdev_get_child_bus() function which is intended for this exact
purpose.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index d02a1a7a1f..946cb09e30 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -445,7 +445,7 @@ static void q800_machine_init(MachineState *machine)
                           qdev_get_gpio_in_named(DEVICE(&m->via2), "nubus-irq",
                                                  VIA2_NUBUS_IRQ_9));
 
-    nubus = &NUBUS_BRIDGE(dev)->bus;
+    nubus = NUBUS_BUS(qdev_get_child_bus(dev, "nubus-bus.0"));
 
     /* framebuffer in nubus slot #9 */
 
-- 
2.30.2



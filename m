Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A373D737DEE
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:57:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtd3-0004m3-PQ; Wed, 21 Jun 2023 04:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtck-0004Az-9v
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:55:36 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtch-0005GE-4K
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B3LhSM9tOUVZLir2gQou8hgFdFwVhZHN4ayOtaUGQVU=; b=wJW2W8zoOkeAEowvdZzuXFIRqZ
 aHU70FbCJZp0KP69EG3kVYQaxLWdRVU849SKsSJwGS+QVzSPCIFgBsc3K3ETQlQLuASof9+0MWXZU
 7HlpOMXvJP5nM+K4lVFInl32/BZOa8f1i+L1Ak5Tpx/3/cIjWZHF/ZhpNibACHNolXOpcXMOBQxkU
 gPAj2kM5qWR626q+Fo+XmHQ5K1KuHKiuCkzROvB6CCwZ7o6SrFON0zxc6BZE431yqxX2Xch115B8x
 FbkncUC8DDudytXFCz1JNgrTRZh78SgJBXq6swtjX1bIX4gta8m9sFRJZRLOcPRaJT5T7yt9NdeJs
 3LY8Epo7JBZIpDDV1vYSOGOTsiTQnzRRXQNjM3A78KKJYp+YLzk/WwEorVlDKapteYJIPIDl5gdaZ
 zaRaz+RssQ4CHk2KEH+syAtG8eZsL6N+eBaro3g7g75GcHhL3kanw6bXMApEx6EqJznQRAHB7FrRg
 9u1RfFH/EhdQe4teqnxueDNluW8tBaj883seiWxFqmb3hOcqRjiDV9SlKsy+bcizXulYN1duLtFzl
 Ih6bdr8zBBAYsdcSC3jY2kbDG0jN2ovReiFT4ZNN/pmad2nDylTshNhNJ5isjp5EvDP4u9KS9ravu
 bIe95vE231te/xgADXgkqz6bqzKds1YTbQLT/tucs=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtcL-0001ZB-Ul; Wed, 21 Jun 2023 09:55:13 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 21 Jun 2023 09:53:50 +0100
Message-Id: <20230621085353.113233-22-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 21/24] q800: don't access Nubus bus directly from the
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/q800.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index b22651931a..a32e6fbf8d 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -448,7 +448,7 @@ static void q800_machine_init(MachineState *machine)
                           qdev_get_gpio_in_named(DEVICE(&m->via2), "nubus-irq",
                                                  VIA2_NUBUS_IRQ_9));
 
-    nubus = &NUBUS_BRIDGE(dev)->bus;
+    nubus = NUBUS_BUS(qdev_get_child_bus(dev, "nubus-bus.0"));
 
     /* framebuffer in nubus slot #9 */
 
-- 
2.30.2



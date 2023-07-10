Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0140774E11A
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:30:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzO7-00041b-FL; Mon, 10 Jul 2023 18:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzO5-00041B-FJ
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:29:45 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzO3-0002DA-Tp
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:29:45 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31441bc0092so4956293f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028182; x=1691620182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LuOsTCwPo/F0jCl0d7iU/xlYr9uDvJyyAysToBkVdZo=;
 b=GU3H3QeG0cYxJ6fVuP3tvIek4HiCbsHISQmjv5JnwDuDN8GSTbhqfiPPnkZpN55ikn
 n5WYN+Q/EmV9HIJYYpWPIgc4UQLgJkUdpWR7M2qCHSfVBf9qZ6y38dUGxLAnk2GFJ5ed
 bAxfSvQmL4z0dbm0BxELSCEqr7LpZTM+vht43yu74K6XT8VmxcinWctlUiEOhxrmuJfu
 o5ituDzRGI9HDSmp9q5EMvJu3vWG015O+9zmYaanwkMZDhtNhmTLNSenv4WX/WF339VY
 o0cq3M2uE1awVYmlTvk+im/rDUzOL8TXkHOQTDGJO2JYoCMkFDcrvk6F3p1UxewvMUYb
 0HNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028182; x=1691620182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LuOsTCwPo/F0jCl0d7iU/xlYr9uDvJyyAysToBkVdZo=;
 b=TMChjeeXOkV5AORO5WCcoPP8nJ7QrlbVriIFySkAP7a5sHlCd2URgNsx7buq1KH7u6
 KkKHvQKmooGem8+Kdzfj5HEEWwHzynFlLaCMmMJfYSy1rO6uXCQUTyDuTWHMWWRLjCCz
 3lnsZlWEztAi9f5EQsgYdEmQAGLRdVPTvUjGboJ/fDdb0B8/H07UEmWGCS4YlPIc8/wW
 qYYuG14XDnRm5XP+0zR73/hIKiEDypdmM2IMc7VNMPd7WkNZAFrieUc84jnFwIqpCPBU
 EPJNXTyTT1Q1rsj3Cs6rM97z3RtP7lYZg4mzPQobAnAjx0HQ6RnX28df9uroituxs62X
 ITpw==
X-Gm-Message-State: ABy/qLZNQGSnJrM1gBAWDMqsIDvCIdjxDAXWwliXY1osrFlDBPxgeA6L
 4k71RvzO+X2+0esmlrdOKbF8ngqrHgGxpyP63c1Ymw==
X-Google-Smtp-Source: APBJJlHCTxcRsNLZ7OiTrCPAFTGPuKq5+1rbjmF+r/Y9WySnrTTO7AnIoCgptON0rbA50QhT7JrxnA==
X-Received: by 2002:a5d:526d:0:b0:314:1a63:be9a with SMTP id
 l13-20020a5d526d000000b003141a63be9amr10720254wrc.26.1689028182517; 
 Mon, 10 Jul 2023 15:29:42 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 s15-20020adff80f000000b00313f9a0c521sm512043wrp.107.2023.07.10.15.29.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:29:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 39/44] hw/ide/via: Wire up IDE legacy interrupts in host device
Date: Tue, 11 Jul 2023 00:26:06 +0200
Message-Id: <20230710222611.50978-40-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

Resolves circular depencency between IDE function and south bridge.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20230531211043.41724-3-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/via.c      | 6 ++++--
 hw/isa/vt82c686.c | 5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/ide/via.c b/hw/ide/via.c
index 177baea9a7..0caae52276 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -31,6 +31,7 @@
 #include "sysemu/dma.h"
 #include "hw/isa/vt82c686.h"
 #include "hw/ide/pci.h"
+#include "hw/irq.h"
 #include "trace.h"
 
 static uint64_t bmdma_read(void *opaque, hwaddr addr,
@@ -104,7 +105,8 @@ static void bmdma_setup_bar(PCIIDEState *d)
 
 static void via_ide_set_irq(void *opaque, int n, int level)
 {
-    PCIDevice *d = PCI_DEVICE(opaque);
+    PCIIDEState *s = opaque;
+    PCIDevice *d = PCI_DEVICE(s);
 
     if (level) {
         d->config[0x70 + n * 8] |= 0x80;
@@ -112,7 +114,7 @@ static void via_ide_set_irq(void *opaque, int n, int level)
         d->config[0x70 + n * 8] &= ~0x80;
     }
 
-    via_isa_set_irq(pci_get_function_0(d), 14 + n, level);
+    qemu_set_irq(s->isa_irq[n], level);
 }
 
 static void via_ide_reset(DeviceState *dev)
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index ca89119ce0..8016c71315 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -692,6 +692,10 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
     if (!qdev_realize(DEVICE(&s->ide), BUS(pci_bus), errp)) {
         return;
     }
+    for (i = 0; i < 2; i++) {
+        qdev_connect_gpio_out_named(DEVICE(&s->ide), "isa-irq", i,
+                                    s->isa_irqs_in[14 + i]);
+    }
 
     /* Functions 2-3: USB Ports */
     for (i = 0; i < ARRAY_SIZE(s->uhci); i++) {
@@ -814,6 +818,7 @@ static void vt8231_isa_reset(DeviceState *dev)
                  PCI_COMMAND_MASTER | PCI_COMMAND_SPECIAL);
     pci_set_word(pci_conf + PCI_STATUS, PCI_STATUS_DEVSEL_MEDIUM);
 
+    pci_conf[0x4c] = 0x04; /* IDE interrupt Routing */
     pci_conf[0x58] = 0x40; /* Miscellaneous Control 0 */
     pci_conf[0x67] = 0x08; /* Fast IR Config */
     pci_conf[0x6b] = 0x01; /* Fast IR I/O Base */
-- 
2.38.1



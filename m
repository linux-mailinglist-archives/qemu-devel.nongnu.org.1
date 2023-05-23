Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C4670E602
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 21:51:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Y1P-0001E1-NF; Tue, 23 May 2023 15:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q1Y1D-00019U-OQ; Tue, 23 May 2023 15:50:04 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q1Y0x-00047T-S5; Tue, 23 May 2023 15:50:02 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-96fdc081cb3so466665366b.2; 
 Tue, 23 May 2023 12:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684871382; x=1687463382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NXyLFwm2rmn2QeCZVS6ECm/FY96EsHB3qjSmeztqjk=;
 b=P4GwTqUDV7s7JkmM60C6qVplgcTCNOIt/33TKIxC48SKz1OfAXtVy+F5YANTzbzbtg
 JOkafayydnQKt9nba7XK8rtZWa9rG9/NCI67nuNuLBu9HJS//NAR96Lq+Nsy8oYX5+w2
 X9rPKlbp4jv69OEGC5OUQlud3ggWU1N/rUYjyz4d8VgHG0t6GDeFu8BDB5DUQ98UyBdo
 qen6yV7Z/wkffR1hQjdm2mMhVRb/JYQmdz9vFFctqAE83LfD8IHkM8+mBFN5knc/UWJn
 wiEyZA/s8AfDjGhCdNYO1qW0yhdSc0cRG6G/ZdhkJ9BfRnkwkt1vRaHjfAlwLg8C6z+Q
 MPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684871382; x=1687463382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+NXyLFwm2rmn2QeCZVS6ECm/FY96EsHB3qjSmeztqjk=;
 b=ZPwoM5STVKY4TKZZETOYj7C/cM7LX8wXbckMW/BueG13Wj3Y24Fk4WdRWtKVI4pdKJ
 rcNOyespS6sNh+mit4kRqpMTbF4LGDm1znLu7GfUDhlEdWAokjNvs/1uU4BRy0wbWuky
 dxKCHReXXJeBFmXp39dKmURO+WjxnJ9wx0SKnAB7uRtigIDllr9+sMgls94yFcQ3xwHG
 dJGnH9heJzmzlUX5U5aMICKU2uGxD/vZb0f4F1cbnqOpkmjtRVFEvJ05AzT59/nJz4j5
 yeVXkVi3Qjq6k6gKAHKEhKW1QcGZ07uvfsHG9uVt8bVVAiHX39Phnd12lkn6nCBeD3na
 D7Pw==
X-Gm-Message-State: AC+VfDwj5XCdZ/GenPx74TYtZWoJaVHMb/ItAIcNn3KTd3qb3CTzrE3W
 tM4VqWDOC7yDKBakgoO2Rz2BTMRshH8=
X-Google-Smtp-Source: ACHHUZ7/GiB8nO5ePZ7tnIKCA0iQT/opq5uVapTSsJi84TyaKGpQm7k2CmG5oNRS9Q8ASWSoRGTUVw==
X-Received: by 2002:a17:907:3601:b0:970:161d:595e with SMTP id
 bk1-20020a170907360100b00970161d595emr4992000ejc.39.1684871381576; 
 Tue, 23 May 2023 12:49:41 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-183-025-113.77.183.pool.telefonica.de. [77.183.25.113])
 by smtp.gmail.com with ESMTPSA id
 k17-20020a1709063e1100b0096f641a4c01sm4800593eji.179.2023.05.23.12.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 12:49:41 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, John Snow <jsnow@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v2 2/6] hw/ide/via: Wire up IDE legacy interrupts in host
 device
Date: Tue, 23 May 2023 21:49:26 +0200
Message-Id: <20230523194930.124352-3-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523194930.124352-1-shentey@gmail.com>
References: <20230523194930.124352-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Resolves circular depencency between IDE function and south bridge.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
2.40.1



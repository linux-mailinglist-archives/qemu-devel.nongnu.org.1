Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B1D718BA4
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 23:13:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4T5y-0006Ut-AG; Wed, 31 May 2023 17:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q4T5v-0006T2-W5; Wed, 31 May 2023 17:11:00 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q4T5u-0001EY-5T; Wed, 31 May 2023 17:10:59 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2af20198f20so1864211fa.0; 
 Wed, 31 May 2023 14:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685567455; x=1688159455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NXyLFwm2rmn2QeCZVS6ECm/FY96EsHB3qjSmeztqjk=;
 b=iRvq7Y/B4CX+K24nKnKjBHcR0TeA/irqcEzJs7GKl3OO0A1+R57QGq/fZQI4r5HVN6
 hmc3L9q4EM5D3lJ5IUzcxTrCnXTI/jxCL6GsuCuEZ9qRrojjuWcXOTj62HpcR83wDOov
 1zUZfRBNm4UIIboXczCfwC6cmhy24UWCGD87OawIewyeIqLWql4h6KUkHZTPU2zjjcvV
 72DVMPWGUEjCLFiQt/QVfNzzXGIcNCwSlAxj9YJYCssAB0p/4Sljmvr32o/LHBiREHvg
 9ZSnmbvTwidZHUaZFT3u9DttF+7vlSaNSX6lrQ+UN0vRQv1MDb3J+fjc6Pb4xFFpvWPn
 6QXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685567455; x=1688159455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+NXyLFwm2rmn2QeCZVS6ECm/FY96EsHB3qjSmeztqjk=;
 b=Zak48c+WfuOZLxA9QoXXTiUt6TISKaENA3Q8m1rKMV971m0K+6GJibHtjZRchg244h
 6h6kUzJSDswtWe0JrCjV7EyL7BJjFRKDnoL4SEznUdWGRpS/bEn/LCZoh1XFfLK6CJY8
 LZVscpxRObJyEHC6LKLs2I5xd0DmmTMjRd8H5waLhabmAJMGzHSrm8l8/nkAdrFUoVFv
 U1+Cnh6nhpQLWDRf3EoOMISoZkc4PT8QYVL+SmSQwD9popZblxSrilmjhMkbDlW9lHJL
 yxjgqJOU0d8cTF8LEiUZMT81mpCQnwlnVuDCPyoSrxImCQpux32XsqzgxQHRDavd4F2/
 HtBQ==
X-Gm-Message-State: AC+VfDzbCsXEYuN9h1wIDtmIGUuj3XKcuVeoHo9TieqfdVYHCbsqXM8y
 G+YP+nybcCWZ4Phnckh+JDeUhBC13FU=
X-Google-Smtp-Source: ACHHUZ7fj6Pxb3N7FrxTaWD02WJL7tO3MDHrlh5gl92yPOQa+wEdro+Oec5n260KXvdqGH3fjtRSPQ==
X-Received: by 2002:a2e:83d5:0:b0:2a8:bf74:61cc with SMTP id
 s21-20020a2e83d5000000b002a8bf7461ccmr3109063ljh.26.1685567455053; 
 Wed, 31 May 2023 14:10:55 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-054-159-078.78.54.pool.telefonica.de. [78.54.159.78])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a1709064d4800b00965f31ff894sm9463054ejv.137.2023.05.31.14.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 14:10:54 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, BALATON Zoltan <balaton@eik.bme.hu>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v3 2/7] hw/ide/via: Wire up IDE legacy interrupts in host
 device
Date: Wed, 31 May 2023 23:10:38 +0200
Message-Id: <20230531211043.41724-3-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531211043.41724-1-shentey@gmail.com>
References: <20230531211043.41724-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



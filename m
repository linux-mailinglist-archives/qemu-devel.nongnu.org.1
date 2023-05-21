Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE66470AD92
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 13:17:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0h2V-0000Yj-0d; Sun, 21 May 2023 07:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0h2T-0000Wj-5w; Sun, 21 May 2023 07:15:49 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0h2R-0004jo-58; Sun, 21 May 2023 07:15:48 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-510d9218506so5134771a12.1; 
 Sun, 21 May 2023 04:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684667745; x=1687259745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NXyLFwm2rmn2QeCZVS6ECm/FY96EsHB3qjSmeztqjk=;
 b=q8TvBgIKnQViVU473YF24YsouYO8QcoLJqv3hNZ9pMw+FsvMi6Tvdt00FSLptTsII9
 aWt2c5Z2vZeI0trgROpHWfAms4nG7Xi2G82O/qrTVyt9jdLTivZ/4GR9YboRlSr0mFln
 t0iiA5ZBFZslO3p4Q/6TQ0ya7Klj2/cTKloeOpTLsyX1dvKzgtBUJG4S3gC9wLM5D23c
 gWKKYK2rtPiNjhoaIjU+A0lE8alKtILjoGw2snXq6p/uFK9QXPmWghDtjwCvrQBvaKrG
 UjJAyDX2bTZJLp6aJFP7LI0SUu+daF/tebvWXPZU75lpstncqMZ7YJVD4OOz+Goe+Uv0
 E8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684667745; x=1687259745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+NXyLFwm2rmn2QeCZVS6ECm/FY96EsHB3qjSmeztqjk=;
 b=dxHKqNwR84ql9Na2/UGb0laou5qqMKPmtk3K31sqgHd9MKs1QK5v2fMmhdsjs0ExA7
 FdqkZMYozBqR2keowEJwEQUjCiL1rlzD/G/HjKUMq2l8Nfgom0QQSQ4VJ/hlHl8W5bNF
 DOaKoZq3D86aHcwUgUj9KE/3GJxZLznwtDMH1dudrT+XZfxidJezAFLjqrlAI61/zvyc
 y08biDbJx7MzRBffoiFzkIdY2Ckkx7+FIpgOchNhwhceYRNKKPO00Vl1DXPSnE2PdL0S
 oV7WKgy1WwMst4HMVfdjHaQEXab+fi0hsenODNdy6KA8/bKXBWr3KnZWEQd4kViR1XiE
 Jkbw==
X-Gm-Message-State: AC+VfDyhCxwVd8Rwnz+TNz4lNCZBamAd4TaxGfpdWhYzwJbBMiR8aPsY
 zYZidqSVMxUgT2foRC2ok1fbTpzouDU=
X-Google-Smtp-Source: ACHHUZ61ZKzH2grKKKrIgBAg0GdCsquLkrJHWBczejZ+oFjTEVxZckRuJxCFTIOpj1efrAHiqQUvXw==
X-Received: by 2002:a05:6402:354e:b0:50b:c350:f9ca with SMTP id
 f14-20020a056402354e00b0050bc350f9camr14684666edd.10.1684667744637; 
 Sun, 21 May 2023 04:15:44 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-191-145-122.77.191.pool.telefonica.de. [77.191.145.122])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a056402124500b0050dfb9fc499sm1757123edw.39.2023.05.21.04.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 May 2023 04:15:44 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-ppc@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 2/6] hw/ide/via: Wire up IDE legacy interrupts in host device
Date: Sun, 21 May 2023 13:15:30 +0200
Message-Id: <20230521111534.207973-3-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230521111534.207973-1-shentey@gmail.com>
References: <20230521111534.207973-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52c.google.com
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



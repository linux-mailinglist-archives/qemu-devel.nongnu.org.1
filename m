Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2673F74E11C
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:30:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzOJ-0004go-6Y; Mon, 10 Jul 2023 18:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzOH-0004Wa-K1
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:29:57 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzOF-0002Dr-R0
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:29:57 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3159d75606dso1356320f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028193; x=1691620193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=74d72XaIdb+kCGd1hbNsukTmdt2SOlQTd25zIPi+waM=;
 b=wXuBupMrGmVm+dtkpH7RaYfWL9YMYN0jNlE/kEzde+LTeGnBtMUaCRUFye789juOcw
 ozP4K6eep1/sNSm53mEFFMlWqemXRvu6s412MtGHXAajgBMzyxoA3lt3/Vxm43j+MrUd
 hnECW42whWbyyhXc99beYydKR78eH0SROoN3CANTJY6gj14e9UU/VmP3FzyKx01Me/28
 pVdllTsSoflOEYu1qSxgDyUQ+0BiFMT6zrXkWosySf7dPOxb92jcDJ8M+Xo5IVVuITWR
 gZSNxB3OnKPsAFkVePQwXt/ZSDysD06HUSL3rAZjxCMz9GNy+7n7XJf1sqAjFAlcYXUQ
 g4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028193; x=1691620193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=74d72XaIdb+kCGd1hbNsukTmdt2SOlQTd25zIPi+waM=;
 b=DdRi1DQVlzMsUU1GsG5gnq9VYKg53mlDpJDJcpiXtWML5XHIuxOV+N6zWDCDwbnMiy
 8yhKJ08VQcs3KvEIoH1C3lmWfYahEEFN1yIKkP3jBtVmY6JjCpePf21ZlRElEqK4jNQ5
 VvIw11qzh67ntJZnKwXq5t8IKE2JvHaAtPh3h5a+CYH3cYeKn/D08DaLaeNA27KnZfBz
 jd+jPrDev5SCia9+k1Rkt1IpZgkt0Hv5mlpu3QPQSso7Nwruou9rwwEcXT3Om/7z1q3u
 Mb4G77LV4QcSnq768LmwwoLgokouH38Vjc66A9YWUcBeQzHvrprhm8939zypdYECg0gE
 rF1w==
X-Gm-Message-State: ABy/qLZLxcvCD8POz7EOZimU4EuswX78G7rBB+rUEU4x/lBHsI54Z797
 L3x+dXoJug/IAOhFPUcJvOCkbOe5w4pNnGkuWUYVWw==
X-Google-Smtp-Source: APBJJlFqcW4jV6tjoDLGK8SbowDQoThn+mxJcnNXic0BvFaF1P5GSxlsJhRogo6ekWITQiSj/4ZBLQ==
X-Received: by 2002:a5d:408b:0:b0:314:1ddc:ecbd with SMTP id
 o11-20020a5d408b000000b003141ddcecbdmr12183874wrp.18.1689028193387; 
 Mon, 10 Jul 2023 15:29:53 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 o6-20020adfeac6000000b00314145e6d61sm560200wrn.6.2023.07.10.15.29.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:29:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 41/44] hw/ide: Extract IDEBus assignment into bmdma_init()
Date: Tue, 11 Jul 2023 00:26:08 +0200
Message-Id: <20230710222611.50978-42-philmd@linaro.org>
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

Every invocation of bmdma_init() is followed by `d->bmdma[i].bus = &d->bus[i]`.
Resolve this redundancy by extracting it into bmdma_init().

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20230531211043.41724-5-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/cmd646.c  | 1 -
 hw/ide/pci.c     | 1 +
 hw/ide/piix.c    | 1 -
 hw/ide/sii3112.c | 1 -
 hw/ide/via.c     | 1 -
 5 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index a68357c1c5..a094a6e12a 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -297,7 +297,6 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, Error **errp)
         ide_bus_init_output_irq(&d->bus[i], qdev_get_gpio_in(ds, i));
 
         bmdma_init(&d->bus[i], &d->bmdma[i], d);
-        d->bmdma[i].bus = &d->bus[i];
         ide_bus_register_restart_cb(&d->bus[i]);
     }
 }
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 9a5a7089d4..4cf1e9c679 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -519,6 +519,7 @@ void bmdma_init(IDEBus *bus, BMDMAState *bm, PCIIDEState *d)
     bus->dma = &bm->dma;
     bm->irq = bus->irq;
     bus->irq = qemu_allocate_irq(bmdma_irq, bm, 0);
+    bm->bus = bus;
     bm->pci_dev = d;
 }
 
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index 41d60921e3..a32f7ccece 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -144,7 +144,6 @@ static bool pci_piix_init_bus(PCIIDEState *d, unsigned i, Error **errp)
     ide_bus_init_output_irq(&d->bus[i], isa_get_irq(NULL, port_info[i].isairq));
 
     bmdma_init(&d->bus[i], &d->bmdma[i], d);
-    d->bmdma[i].bus = &d->bus[i];
     ide_bus_register_restart_cb(&d->bus[i]);
 
     return true;
diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index f9becdff8e..5dd3d03c29 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -287,7 +287,6 @@ static void sii3112_pci_realize(PCIDevice *dev, Error **errp)
         ide_bus_init_output_irq(&s->bus[i], qdev_get_gpio_in(ds, i));
 
         bmdma_init(&s->bus[i], &s->bmdma[i], s);
-        s->bmdma[i].bus = &s->bus[i];
         ide_bus_register_restart_cb(&s->bus[i]);
     }
 }
diff --git a/hw/ide/via.c b/hw/ide/via.c
index 0caae52276..91253fa4ef 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -196,7 +196,6 @@ static void via_ide_realize(PCIDevice *dev, Error **errp)
         ide_bus_init_output_irq(&d->bus[i], qdev_get_gpio_in(ds, i));
 
         bmdma_init(&d->bus[i], &d->bmdma[i], d);
-        d->bmdma[i].bus = &d->bus[i];
         ide_bus_register_restart_cb(&d->bus[i]);
     }
 }
-- 
2.38.1



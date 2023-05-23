Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D1970E601
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 21:51:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Y13-00014A-1D; Tue, 23 May 2023 15:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q1Y10-00012I-4C; Tue, 23 May 2023 15:49:50 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q1Y0w-00047z-O6; Tue, 23 May 2023 15:49:49 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-96f818c48fbso2171966b.0; 
 Tue, 23 May 2023 12:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684871383; x=1687463383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P72zQ7woazHMx0qT4VH6jdOKwmBc//e3KdkUSQs+4e0=;
 b=OU5/rOlmPd8KDLdvCYYGlyKmbJ1Cg4rivhxQYipGuuScUCnxS7uNiErTcmdM8CGjPm
 dFSNgRDKBQicn6dpoq+COKXdRIufKTyYg7UeMksVgticR/VquQPovuCfJDSmPdmw/gik
 FXF6SKjpuAiOI0n7WDKDjT/K7AYpgoLPhDJ9pQlx5z0XtnutBB8zK6TyMBVGeBnq4UXD
 821lTCiL7JZKiLUG+idT+UhgeUyAeN5tGXI+KkYtHaQGhGWeQwRJ9jzLqZS3/AxMI2Cn
 es67taLdWtQ88xO0xt45PXxftxSZzrkFLLpx6Bhxd3rf4iWoJGUBx3hVRcyPSTvcHCaP
 sybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684871383; x=1687463383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P72zQ7woazHMx0qT4VH6jdOKwmBc//e3KdkUSQs+4e0=;
 b=EIYD6sZz5e94UGmmYkXB3Ixq5tvIBQZfTnnzwzEkkzr4Igj2PT6GnQ0yIZK+WSW0mp
 OM8YzkowAwJcXWATMzHrDWNRAoKj0o5BRRnCyEqx5RQsTfb7Sz2Oz6vQa+ij/1HuiPH9
 DSxywCk3OSTDwMaoPB7HiOlOg5/GEVYSaH4VSI2KqNAo8uOx2GxHzGX+2EwNyvRJJCce
 XfVGkPj2ef1ul5XgA6dcoQWTkOEXJUt827bjhjB6rJimTzKMn2EmGMplhifZMIiKqxLk
 /FOP3/y8XQxBtbQqmnGxONGKYXXuK/ZVYyD5cskEc+YEyk5XV/TAxUPJe3aCAxjN2Di+
 FLZQ==
X-Gm-Message-State: AC+VfDxEXj5DgjATsd1KO5ltMaMI96g/9za0sv4ytz04PqC3JvOPo5Pf
 tspp5DUmBybAbA77/qI2ox0F9kuWCek=
X-Google-Smtp-Source: ACHHUZ7TC9LzEqi1rD629awTMapc0oUMGPgp/+cbMD7QL5p/kGgnd06N9eEoCzafbZ5Es38wnVsnaA==
X-Received: by 2002:a17:906:dc91:b0:96f:45cd:6c24 with SMTP id
 cs17-20020a170906dc9100b0096f45cd6c24mr15020044ejc.23.1684871383616; 
 Tue, 23 May 2023 12:49:43 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-183-025-113.77.183.pool.telefonica.de. [77.183.25.113])
 by smtp.gmail.com with ESMTPSA id
 k17-20020a1709063e1100b0096f641a4c01sm4800593eji.179.2023.05.23.12.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 12:49:43 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, John Snow <jsnow@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v2 4/6] hw/ide: Extract IDEBus assignment into bmdma_init()
Date: Tue, 23 May 2023 21:49:28 +0200
Message-Id: <20230523194930.124352-5-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523194930.124352-1-shentey@gmail.com>
References: <20230523194930.124352-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
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

Every invocation of bmdma_init() is followed by `d->bmdma[i].bus = &d->bus[i]`.
Resolve this redundancy by extracting it into bmdma_init().

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
2.40.1



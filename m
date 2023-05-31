Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A59AE718B9D
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 23:12:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4T6B-0006cg-2N; Wed, 31 May 2023 17:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q4T69-0006cK-DC; Wed, 31 May 2023 17:11:13 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q4T5v-0001Es-Ch; Wed, 31 May 2023 17:11:13 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-51492ae66a4so307955a12.1; 
 Wed, 31 May 2023 14:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685567457; x=1688159457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P72zQ7woazHMx0qT4VH6jdOKwmBc//e3KdkUSQs+4e0=;
 b=KCg9qUAF+xSbVGRpd8Oc1zO1iiTPSKkvs31+akLII/br9WkSB96rNrP2FnrSpAv2DA
 K/QMjY6BHauRvaCsuoCRG6+pFw7n8d8dRiuBQjY5LTbsfRzRBykDGl3NGgmUqwIivc/s
 kla70b+5Fd2HjIOtT4f0LtcwD+P9ZZrwJWIXOmizkkIRmMTd4MJ3ILmT27y8Ur/VWHqW
 kbkvlTSg1hxs66sw6oRjf2QVbHu9XqQr3DLA76mpGMtFAb++U6JIFzLcoZ/+7sGtljq/
 TRbWNBp8v3+b52dXS2Zp03QSRpRXfmQwJaZnXSQ9dC9Cs4SQIxrJwTzhNZyyN9p7J5R/
 /huQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685567457; x=1688159457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P72zQ7woazHMx0qT4VH6jdOKwmBc//e3KdkUSQs+4e0=;
 b=IQyW1TVD1Vt9eLaEiaZ5rTnOq4OiUpbTYVIT1Pc2I43/I2iPXfL21L5EM5FSPmwmOU
 bQyUR9YPBYUjJji/GtY7MZ4Yww+kyMWYHTA4wZxMTZszqBI9dI8FZJIyL9Q2HKspk8Oj
 zIVpLuLN7THeRtst0MA9241f7s4Se7RlsQ6dRLD73zdbS5Qo4o5Ba1cveRXLdQZYQnBW
 J/4dbKmPAcCizjKYRM5z+9VJ218l+qUzfF9AphZDIlRau0RyvvA5QWKSI/JFYpd4Hptu
 QzbJyz+G9pdjVvAWvNRRyVmtadpUR0BIFI6AlS1Bte2vCfNLH0K72qwtXGBRVmBkZ10U
 ibzQ==
X-Gm-Message-State: AC+VfDx8LT7nrEv9aErPBhqeaGPDz3aIF6mg6v33XSpO6nfuqGpTYUZ3
 cJTTM5ZTP3eO5Oe/SDF5P9ovcwcLdik=
X-Google-Smtp-Source: ACHHUZ6G0KRmJCQbJvMFfKMXNOuzOooIEJqxcUJvMxl8aHHIA9oAOx0L0AOROhEMFeuq1N//S/FBJw==
X-Received: by 2002:a17:907:7b8e:b0:96f:a86f:9d16 with SMTP id
 ne14-20020a1709077b8e00b0096fa86f9d16mr7484741ejc.23.1685567457110; 
 Wed, 31 May 2023 14:10:57 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-054-159-078.78.54.pool.telefonica.de. [78.54.159.78])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a1709064d4800b00965f31ff894sm9463054ejv.137.2023.05.31.14.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 14:10:56 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, BALATON Zoltan <balaton@eik.bme.hu>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v3 4/7] hw/ide: Extract IDEBus assignment into bmdma_init()
Date: Wed, 31 May 2023 23:10:40 +0200
Message-Id: <20230531211043.41724-5-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531211043.41724-1-shentey@gmail.com>
References: <20230531211043.41724-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
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



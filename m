Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2F770AD8F
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 13:16:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0h2Y-0000aw-8d; Sun, 21 May 2023 07:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0h2V-0000Yp-Ca; Sun, 21 May 2023 07:15:51 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0h2T-0004kQ-GM; Sun, 21 May 2023 07:15:50 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-510b4e488e4so9059958a12.3; 
 Sun, 21 May 2023 04:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684667747; x=1687259747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P72zQ7woazHMx0qT4VH6jdOKwmBc//e3KdkUSQs+4e0=;
 b=IkSvhi9TRqCjESXP+NiBcbU/wludHoPKn5PF5QRei1C6QPEMG4SVJNMm5D1hcfhsZb
 9Aopw9fsOAkhhP29ZMdB+a8WOZ0YG0p2xo0H7YdbMTob6D9k1P7Z4NBY+it72VqMpjOV
 +tf+8Qe53DU4enU0e85WKlcHgzSkebozKMZmqPms8+UforGMMzTd6cZKme7FAF+mGF0Q
 GtKnlwG+Db6LGw7ocSOUGLUmGUTUtfZ8eQhjoTkFvcDj5qAZce6zRgbLMiPWGIlZ3mF6
 jKtlXbmJsoF+IZ7lfFCSnsgvUlZIbDtH9Z1SQpAClYpZfWXV2GuB+KONfCz9ALzDOKba
 PT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684667747; x=1687259747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P72zQ7woazHMx0qT4VH6jdOKwmBc//e3KdkUSQs+4e0=;
 b=h1NybzCuWdqlCC7/kdSbvi7HT+4IXQPZ1S4xvEV4mcckELjtwhxBkKsiPnMMKNBTHJ
 rnGsVB03Z2+kjqIWfFUU2lTTDx506dQyr86yJv4oSO2Q6Ut9QfqWvJkzwab3jUjyDMo2
 QhqrITUWwLFU3vaov0jA3ROxSA23LGuwl/MGE9tw6OsL1uFYPBwAbyoidd4HEhEYmwaL
 Kk3Ik4TSNeROPpHj9XWxcLAcStk2E6nM3vCmcJ7zw/wfvaMv4xVoS//llm9+HZQ8tnnw
 AzLIg1f0hlXdRvFgKM+alsvcKXpkizx2st+lkb8HWYE8m8smwXnq751eE19FF8ylzpaW
 p4yw==
X-Gm-Message-State: AC+VfDyBT4S7vTJuiUHq9aUCLkaWAF8QmLzZjOxC7MNXCQJbQD4Tdz+j
 oZ+iJ+UFuIPnVj0Y7KPmMeOwcvhQhKI=
X-Google-Smtp-Source: ACHHUZ5PcXUSedNBEDiGZjCtEsp7uNX4jwX/NXgmA4ks0Udev554tEeaQS8ymWvLVXOsXrns2BmLMw==
X-Received: by 2002:a05:6402:514:b0:50c:d5d:c960 with SMTP id
 m20-20020a056402051400b0050c0d5dc960mr5528401edv.38.1684667747267; 
 Sun, 21 May 2023 04:15:47 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-191-145-122.77.191.pool.telefonica.de. [77.191.145.122])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a056402124500b0050dfb9fc499sm1757123edw.39.2023.05.21.04.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 May 2023 04:15:46 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-ppc@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 4/6] hw/ide: Extract IDEBus assignment into bmdma_init()
Date: Sun, 21 May 2023 13:15:32 +0200
Message-Id: <20230521111534.207973-5-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230521111534.207973-1-shentey@gmail.com>
References: <20230521111534.207973-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
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



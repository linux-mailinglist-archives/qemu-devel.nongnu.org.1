Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59424718E92
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 00:34:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4UON-0002yC-0p; Wed, 31 May 2023 18:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UOL-0002sc-KT
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:34:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UOH-000541-D5
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:34:04 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f60e730bf2so1773465e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 15:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685572440; x=1688164440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=huoGF1vYpA+J+Saxjh1v1lIbOm2BUrExA4kLN7TpUYc=;
 b=XZ/ae1B+AbGLfAiYT+qvhpC/hTbBlAdYbyxYK/eCFXw+MZswDkKYkq7h8JRPg4MLqq
 nODQkjZA6MWrJXbqtmKLuZ3W5hULG8Q9a9PVg0g+/8cB4Dor5CDrhDx9RuNfzDAZWraW
 deMLKuOjI4GOzUBJ7zuPBfZeoDwHqIRwc4VQrHmYzWpilCO0QlQ91HjsaZtHMAtASpDh
 MNsO2KNHEjNqbLXsIBSmM9eC6TMKRvRP4iF678pDHMvkgBeBvE27fVKeO0zoSnWdDXmH
 +CP+I5F55TOQSBaPRg2ZC8uFuToGmDVup7LOjGOOH5Wwv3Rn9DpLDNcdqtMCTkMbNSZ4
 caiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685572440; x=1688164440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=huoGF1vYpA+J+Saxjh1v1lIbOm2BUrExA4kLN7TpUYc=;
 b=YqqvSAgRw+MnPn8Dm16RC1D6FNHPr86DSna76Q9EEkSoMcUwNpHTCv0QgULZ+qtIco
 /9keToLiAzPaBaZskBrHTEd0jQufgBBxmOi3x29kfe7yQ9YaGmBc4eI60UwJvvR/FF4I
 ZxnzqSgjd58zlRevykMnmsbeJwqrxl09EFGcLbwjDYHu4NcA+09ANXBmJky/XGRW4dz9
 XPFvj3eu3iJPjvGAvydgC8bG50RkxNinV3Cz2ZwsDgu4iSzRi777+UY97+PGEVWQd2gN
 FnfItp/JVlh64wYZbKt7GnPosf9Gyw6dEPGSJyuL00gQ7HgRE8og6IkkhVS0UFFJppxq
 Au9Q==
X-Gm-Message-State: AC+VfDxVMtmb3q73z8rxrwvAReTMlLibDZqXzhhhulJJHTqVbaIJNdJ0
 2yoH2CS2ou7MPAkzVldC720eF1Ft7WA38TEIdRM=
X-Google-Smtp-Source: ACHHUZ5mGnanumaW7KPt9mwiynik5qTF/iqDxogXPrviH1DfOIxFOW5uSg4t118Tu/9DQ1Vfb2xV/Q==
X-Received: by 2002:a05:600c:114f:b0:3f5:ce4:6c3f with SMTP id
 z15-20020a05600c114f00b003f50ce46c3fmr611316wmz.7.1685572439802; 
 Wed, 31 May 2023 15:33:59 -0700 (PDT)
Received: from localhost.localdomain ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 b9-20020adfe309000000b003079986fd71sm8325422wrj.88.2023.05.31.15.33.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 May 2023 15:33:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/7] hw/sysbus: Introduce sysbus_init_irqs()
Date: Thu,  1 Jun 2023 00:33:37 +0200
Message-Id: <20230531223341.34827-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531223341.34827-1-philmd@linaro.org>
References: <20230531223341.34827-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The SysBus API currently only provides a method to initialize
a single IRQ: sysbus_init_irq(). When we want to initialize
multiple SysBus IRQs, we have to call this function multiple
times. In order to allow further simplifications, introduce
the sysbus_init_irqs() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sysbus.h | 1 +
 hw/core/sysbus.c    | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 3564b7b6a2..bc174b2dc3 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -70,6 +70,7 @@ typedef void FindSysbusDeviceFunc(SysBusDevice *sbdev, void *opaque);
 void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory);
 MemoryRegion *sysbus_mmio_get_region(SysBusDevice *dev, int n);
 void sysbus_init_irq(SysBusDevice *dev, qemu_irq *p);
+void sysbus_init_irqs(SysBusDevice *dev, qemu_irq *p, unsigned count);
 void sysbus_pass_irq(SysBusDevice *dev, SysBusDevice *target);
 void sysbus_init_ioports(SysBusDevice *dev, uint32_t ioport, uint32_t size);
 
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 35f902b582..a1b4c362c9 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -175,10 +175,15 @@ void sysbus_mmio_map_overlap(SysBusDevice *dev, int n, hwaddr addr,
     sysbus_mmio_map_common(dev, n, addr, true, priority);
 }
 
+void sysbus_init_irqs(SysBusDevice *dev, qemu_irq *p, unsigned count)
+{
+    qdev_init_gpio_out_named(DEVICE(dev), p, SYSBUS_DEVICE_GPIO_IRQ, count);
+}
+
 /* Request an IRQ source.  The actual IRQ object may be populated later.  */
 void sysbus_init_irq(SysBusDevice *dev, qemu_irq *p)
 {
-    qdev_init_gpio_out_named(DEVICE(dev), p, SYSBUS_DEVICE_GPIO_IRQ, 1);
+    sysbus_init_irqs(dev, p, 1);
 }
 
 /* Pass IRQs from a target device.  */
-- 
2.38.1



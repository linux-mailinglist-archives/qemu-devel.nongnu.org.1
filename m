Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE1D7BC7A1
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:41:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6ab-00031L-Oh; Sat, 07 Oct 2023 08:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aO-0002rV-69
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:12 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aJ-0002lH-Vj
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:11 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9b27bc8b65eso509289566b.0
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682343; x=1697287143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5JkvslVPz4zsIxR/uGLWLxe2EOxklyS1JTEVJcwtJQ=;
 b=nS5/y2TXEKvAAZhG7dMyohkI7NA3oZpfnTXM4kE7DNoyma+4r1nNr8SlF5PIu4VUUK
 6kxgYVGO77HQeO8rpcippw5GOddkBaM+4D0XgLga8l13JHktiLQtaT0EK0SEzRQuDvSv
 zG59/6wPc/zQ0IRAq1ZIL4viILSAny5PEZaHf83M2LnHabE4ITkExxIH1q54UN3rn+ai
 BTgb+y9NHUeodV8YX3F+PiZ7jju9KDa0qegzJdDtpf0kHcIGQRf8E/sXCd8wPEql8mq1
 gfyME8+kYdZdBxF+lO4UryLoH+GQEStz7UQLQf/0TGVpB2iVSZTwBLd+ypTq+OTd/gWr
 qm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682343; x=1697287143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k5JkvslVPz4zsIxR/uGLWLxe2EOxklyS1JTEVJcwtJQ=;
 b=eydS+aCZHcF2EVPWC/mASqmOc0kRHtZwo6TTPgD9CHZT41q21kaVi6w7Z9gkZHwQfh
 YWLupnJD3IcILNBD1hbpmk0eVa07FleAP7iPkfoBpWShY8pGRaZC63QiY3s8y7RV7lRC
 uumco/eZpYRyFTYYW6GC5GKdeNszFM5TlD9kfo6LhDRV3+SVHrJCV1dOt0APCYQMH2wl
 kX0D6G7uuDuFPxttbT7NnQswLCD/wl+/k8hfrrej7NJ8mMjmDH8mEAHDCUn0QnHJeE6g
 DOajs9qF2mId76TbRelZjVOOsLyecUZ01z6uBIJVRbBt+NEkuW5K6HsUUE65sRoZ5wkE
 9euw==
X-Gm-Message-State: AOJu0Yw9M6biAd3i6oSQWCH7DccA0Y5HWk/KPogMBWq+iU5sr0YBIk6+
 sRwoeOPZNTu+/pZTztRuCryztXQSQMw=
X-Google-Smtp-Source: AGHT+IG4j2K6WkFyrI8iqWIj91wPP9avnSkj6msymeKTcZ/yz1QRXIf/KMjEO6g9FeKZ+qMvR78AAA==
X-Received: by 2002:a17:906:57:b0:99c:c50f:7fb4 with SMTP id
 23-20020a170906005700b0099cc50f7fb4mr9062061ejg.1.1696682343456; 
 Sat, 07 Oct 2023 05:39:03 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:39:02 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chuck Zmudzinski <brchuckz@aol.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v8 10/29] hw/i386/pc: Wire RTC ISA IRQs in south bridges
Date: Sat,  7 Oct 2023 14:38:18 +0200
Message-ID: <20231007123843.127151-11-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Makes the south bridges a bit more self-contained and aligns PIIX3 more with
PIIX4. The latter is needed for consolidating the PIIX south bridges.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/pc.c      | 7 ++-----
 hw/isa/lpc_ich9.c | 3 +++
 hw/isa/piix3.c    | 3 +++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2fbdff89e0..4e844d02f2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1245,12 +1245,9 @@ void pc_basic_device_init(struct PCMachineState *pcms,
         pit_isa_irq = -1;
         pit_alt_irq = qdev_get_gpio_in(hpet, HPET_LEGACY_PIT_INT);
         rtc_irq = qdev_get_gpio_in(hpet, HPET_LEGACY_RTC_INT);
+
+        /* overwrite connection created by south bridge */
         qdev_connect_gpio_out(DEVICE(rtc_state), 0, rtc_irq);
-    } else {
-        uint32_t irq = object_property_get_uint(OBJECT(rtc_state),
-                                                "irq",
-                                                &error_fatal);
-        isa_connect_gpio_out(rtc_state, 0, irq);
     }
 
     object_property_add_alias(OBJECT(pcms), "rtc-time", OBJECT(rtc_state),
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 3fcefc5a8a..23eba64f22 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -696,6 +696,7 @@ static void ich9_lpc_realize(PCIDevice *d, Error **errp)
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(d);
     PCIBus *pci_bus = pci_get_bus(d);
     ISABus *isa_bus;
+    uint32_t irq;
 
     if ((lpc->smi_host_features & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT)) &&
         !(lpc->smi_host_features & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT))) {
@@ -745,6 +746,8 @@ static void ich9_lpc_realize(PCIDevice *d, Error **errp)
     if (!qdev_realize(DEVICE(&lpc->rtc), BUS(isa_bus), errp)) {
         return;
     }
+    irq = object_property_get_uint(OBJECT(&lpc->rtc), "irq", &error_fatal);
+    isa_connect_gpio_out(ISA_DEVICE(&lpc->rtc), 0, irq);
 
     pci_bus_irqs(pci_bus, ich9_lpc_set_irq, d, ICH9_LPC_NB_PIRQS);
     pci_bus_map_irqs(pci_bus, ich9_lpc_map_irq);
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index 3e7c42fa68..11d72ca2bb 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -266,6 +266,7 @@ static void pci_piix3_realize(PCIDevice *dev, Error **errp)
 {
     PIIX3State *d = PIIX3_PCI_DEVICE(dev);
     ISABus *isa_bus;
+    uint32_t irq;
 
     isa_bus = isa_bus_new(DEVICE(d), pci_address_space(dev),
                           pci_address_space_io(dev), errp);
@@ -287,6 +288,8 @@ static void pci_piix3_realize(PCIDevice *dev, Error **errp)
     if (!qdev_realize(DEVICE(&d->rtc), BUS(isa_bus), errp)) {
         return;
     }
+    irq = object_property_get_uint(OBJECT(&d->rtc), "irq", &error_fatal);
+    isa_connect_gpio_out(ISA_DEVICE(&d->rtc), 0, irq);
 }
 
 static void build_pci_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
-- 
2.42.0



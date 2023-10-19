Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 002087D016C
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:27:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhc-0001El-2I; Thu, 19 Oct 2023 14:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgD-0007Y3-BP
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXg5-0000uY-LP
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fwUMxQ8ncCyAsWqYRxNdCC8jhYTNvx8/arhoeUue154=;
 b=ibMMrwJuLQlOc3hZp+SV8cnuxGl7qjBgezMJaqbK+KTd4ExMXGzOLfcPYWzL06mtAZj7GP
 eiBtcUYm0R5IJB8L/5JYI9KPqfKBPk6CT8t4OHZgkJJisAXA15M7JKiu3/1/XukE0aYNdh
 AKa/8Ac06IL6GezN+dhEmrqreyJ6id0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-I-bHvBf4OuyBjGeNzn7BwQ-1; Thu, 19 Oct 2023 14:23:21 -0400
X-MC-Unique: I-bHvBf4OuyBjGeNzn7BwQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c515541a25so53539741fa.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739798; x=1698344598;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwUMxQ8ncCyAsWqYRxNdCC8jhYTNvx8/arhoeUue154=;
 b=kxJIYnm5Hv+STvZJEYQnanjQFp/n81O9+8HVRnAeOAXY8Mj0n+gH9oLFq9AZA96wYa
 2gR0D+ZPjvtkvMoWgjjPtf7NjHD21u2OlonzAU1vaxEtE5baYSfJ5Ug74rNEo5RzTR3l
 YDwGO0DASOtYPFH4u9FC0TNO+tGupV5rplmDG2cbhlqx3evJnY6sX3I/jQYF/A29W8YA
 Td0zUqTBGldp9SJjcPdYsc2tzgm85JJzhE1iTWIAZ95TMMwgo3vMVUdYW0QZmSPDOU/v
 nzidgX955qYJqF7Hd58fpCG+p5rk21D2MjOJhmHb/RO7giGHces8xpT+55fVUP90UDhh
 e/8Q==
X-Gm-Message-State: AOJu0YwOgQbgQMPp88RkWKuRDj4HC/AgLMiUMp30GInH6yjk09r8wayv
 jttnsfu5APoiUl9p/fu/D6HxklWqBM2n2Yj+T7Cgwkk/kzbl+A4oaGYh8NtT04nZOH9TDolEkvD
 sleNUmi1n5sNjLxu3qI6scV7wKvwpqJq+pz31jdwR/6X7RhyATTQeiQCxAthDs4aYB+Xu
X-Received: by 2002:a2e:97ca:0:b0:2bc:d5f1:b9cf with SMTP id
 m10-20020a2e97ca000000b002bcd5f1b9cfmr2016705ljj.27.1697739798794; 
 Thu, 19 Oct 2023 11:23:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx52khcEtWbu/bN32Tg0cW7SPP8Ea5LvTdJuyHuE1Olj37KuS1Xbd/TDKLzfAzJeCwzes+gA==
X-Received: by 2002:a2e:97ca:0:b0:2bc:d5f1:b9cf with SMTP id
 m10-20020a2e97ca000000b002bcd5f1b9cfmr2016685ljj.27.1697739798508; 
 Thu, 19 Oct 2023 11:23:18 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 az15-20020a05600c600f00b00406447b798bsm5067463wmb.37.2023.10.19.11.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:23:17 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:23:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL v2 47/78] hw/i386/pc: Wire RTC ISA IRQs in south bridges
Message-ID: <fac7dff67c2916740361c478509a62778c6ab35f.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Makes the south bridges a bit more self-contained and aligns PIIX3 more with
PIIX4. The latter is needed for consolidating the PIIX south bridges.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20231007123843.127151-11-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc.c      | 7 ++-----
 hw/isa/lpc_ich9.c | 3 +++
 hw/isa/piix3.c    | 3 +++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7e6c4dc526..355e1b7cf6 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1244,12 +1244,9 @@ void pc_basic_device_init(struct PCMachineState *pcms,
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
MST



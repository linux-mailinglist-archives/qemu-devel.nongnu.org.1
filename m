Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C4F7CE26C
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:12:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8vg-0007P7-JJ; Wed, 18 Oct 2023 11:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8vL-00062b-31
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:57:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8vJ-0007JL-Bj
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fwUMxQ8ncCyAsWqYRxNdCC8jhYTNvx8/arhoeUue154=;
 b=N0LE5CdxthspnbsIds78wqKhvHBeX7ZfmYi/zuwhmaR6ygl/ihqqOA5upIvHJIKe1keNxc
 +KIfafHFo+XjdJVaj2zPp8ee0ngEQWlgrNyull7K2CAmmNMAQiNqc8DVWx+kjiiUwoWDNA
 47mgbsZ5Pfwj37yV7HOQMf2vSbcpvc0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-aTlagBoxNvuDmQifwPFhOw-1; Wed, 18 Oct 2023 11:57:25 -0400
X-MC-Unique: aTlagBoxNvuDmQifwPFhOw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-406de77fb85so44710995e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644643; x=1698249443;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwUMxQ8ncCyAsWqYRxNdCC8jhYTNvx8/arhoeUue154=;
 b=NL0KMuUeFtXEg6caIeuibGpIUwG9ps5UtvtoB7pHvxvZHlAb/pVoyr2KeGHS/Jc8uX
 oDB4+z9KdmGcMe9lKGvVtT889haQ5yS9EW/hKXyvPaTuACbJdP+1yY/5CyiP1xnMTg8C
 +13PHGS6S9jkXi7tdfL13tH8fEJEqJlb2Zisq/3z0BrDddhZLdv2bx50lQB9SFEDnyso
 XBZyFR2r/PHAICgRbVSJf34nKIUkBC/Uy/g2gzIjpf+rMHex+f2FGqUL9p0rdqdpWbi9
 cyM2dPLZ8wQC/E940WSF+353lXuzH2FKBdbUG3ji76J5gNqRD45rRngDZ5WMgUPXAHbj
 lE8Q==
X-Gm-Message-State: AOJu0YzCa5EigZbGr+Mx0Vs8SiorSa+Jyiwv1xxsKlteZQ01Okia7yDT
 nYYE1sDA72WxcXRQ5EbG5AuVwaCh5fCtWBiUaIYzyTI55KhaUFyoK+WfkDJKm4IT/+IEusiW6Nk
 7EhfT2XKf6nodPO5lrEWHwHjoCfr0KSZPDXm3OCVu8Ew77SkyZY7bvwim7tKEA5pHlOFjfxE=
X-Received: by 2002:a05:600c:1393:b0:402:cc9a:31a7 with SMTP id
 u19-20020a05600c139300b00402cc9a31a7mr4575267wmf.19.1697644643504; 
 Wed, 18 Oct 2023 08:57:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9rohLRA6JBGXgDJeX5oGo0An68aqWKUPuiA9NN78phgSbKQ3FZ6z97L2X6dTG3j8FTX0xnA==
X-Received: by 2002:a05:600c:1393:b0:402:cc9a:31a7 with SMTP id
 u19-20020a05600c139300b00402cc9a31a7mr4575249wmf.19.1697644643162; 
 Wed, 18 Oct 2023 08:57:23 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a05600c489100b0040776008abdsm1980675wmp.40.2023.10.18.08.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:57:22 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:57:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 52/83] hw/i386/pc: Wire RTC ISA IRQs in south bridges
Message-ID: <899e94ffd8ecd3b399d466a31928f2eae790829b.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2917CF0F6
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 09:19:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtNI1-0005vn-Sl; Thu, 19 Oct 2023 03:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNHP-0005Ru-UJ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:17:15 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNHM-0003Ea-7R
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:17:15 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4079ed65582so21175955e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 00:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697699829; x=1698304629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cFAMYwhnq3nxNfGtfJVokxRT7cRevtvOipnlNAGOBcc=;
 b=bjkZDZs70Lg43rIIKd5RgCJWeMkiMo3ANIdC+/B0KaAlclb8eo2s3gec8sksInwrBi
 YJC78nlu4kzRTiN+D9rVzXfT800qzg0dGG7w5lMIAnihnKsLaMXoKVbvj7+r+lVDK+wS
 YBewy57shKO+fgPM5ABC+CmWOToL/KAiEov9lk2oV+uHNaSkoHXodnzyzQ1aV+r1uGrn
 1uIjP7F1vyoS/On/gTe6tWkX66EkQhFRDYv2H0pJJxWdlgBKZGU8tsW3lrZx7yEFyQxZ
 IHzslQZRmI0npS5qmVAdRnzUhFqEcx+I1NvHcQVI6Evn+vTVePzCrSVfOHXW0ATWNbd7
 lv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697699829; x=1698304629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cFAMYwhnq3nxNfGtfJVokxRT7cRevtvOipnlNAGOBcc=;
 b=NwvVf81IUWJHKfSYYMBJaA9tbZ6tygu7cF33aIwonNd5nMo2Nl70nbNF9XgO4lUhlz
 gLB7crZl/1fYuAvdh0EvmcjW1h46JYmswYlG1BpmP8zxB39Z7Dt9mPzakqddDLxzsErY
 ZcEbVqPghWhGuzDoLA6OwUxV6uJobBB4Ccyz2JYgV3FJyXCq59KN2vlsWSriUNhNCNXb
 QZqJW4nkKtlVzkaLO4XvdntvQxr289Ce761xtDAeZKpq7hVGMPBNE993bBu9j4X3Gy/d
 HsL8E2vn65AJ41nhZHQ/5vOfos0CfCaPEkPkIBYud+r3uCDXVCT8+Po86U/QjzLEppKv
 QPWg==
X-Gm-Message-State: AOJu0Yxot1nLr54GChYNovwBsMe8CzGG+PH0+w4iwAjtHev9v0EDu2P1
 pjRIU2yVPeY+rQQwlTtsgGzqdlyoIVSpxqFCJ8VSSg==
X-Google-Smtp-Source: AGHT+IHsyT2qR05EFEKypk9Tcgzr9gdn1RyG8DLYedISV8zEDATNNwLD6oOSbNUXcLqD8dfADoFWpA==
X-Received: by 2002:adf:e605:0:b0:32d:8401:404a with SMTP id
 p5-20020adfe605000000b0032d8401404amr986009wrm.10.1697699829535; 
 Thu, 19 Oct 2023 00:17:09 -0700 (PDT)
Received: from localhost.localdomain (92.red-88-28-12.dynamicip.rima-tde.net.
 [88.28.12.92]) by smtp.gmail.com with ESMTPSA id
 b3-20020adff243000000b003258934a4bcsm3776251wrp.42.2023.10.19.00.17.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 00:17:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eric Farman <farman@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-s390x@nongnu.org, Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 05/12] hw/pci-host/bonito: Do not use SysBus API to map
 local MMIO region
Date: Thu, 19 Oct 2023 09:16:03 +0200
Message-ID: <20231019071611.98885-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019071611.98885-1-philmd@linaro.org>
References: <20231019071611.98885-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

There is no point in exposing an internal MMIO region via
SysBus and directly mapping it in the very same device.

Just map it without using the SysBus API.

Transformation done using the following coccinelle script:

  @@
  expression sbdev;
  expression index;
  expression addr;
  expression subregion;
  @@
  -    sysbus_init_mmio(sbdev, subregion);
       ... when != sbdev
  -    sysbus_mmio_map(sbdev, index, addr);
  +    memory_region_add_subregion(get_system_memory(), addr, subregion);

and manually adding the local 'host_mem' variable to
avoid multiple calls to get_system_memory().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/bonito.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index ee6cb85e97..96bd028671 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -654,10 +654,10 @@ static void bonito_host_realize(DeviceState *dev, Error **errp)
 static void bonito_pci_realize(PCIDevice *dev, Error **errp)
 {
     PCIBonitoState *s = PCI_BONITO(dev);
-    SysBusDevice *sysbus = SYS_BUS_DEVICE(s->pcihost);
     PCIHostState *phb = PCI_HOST_BRIDGE(s->pcihost);
     BonitoState *bs = s->pcihost;
     MemoryRegion *pcimem_alias = g_new(MemoryRegion, 1);
+    MemoryRegion *host_mem = get_system_memory();
 
     /*
      * Bonito North Bridge, built on FPGA,
@@ -668,48 +668,48 @@ static void bonito_pci_realize(PCIDevice *dev, Error **errp)
     /* set the north bridge register mapping */
     memory_region_init_io(&s->iomem, OBJECT(s), &bonito_ops, s,
                           "north-bridge-register", BONITO_INTERNAL_REG_SIZE);
-    sysbus_init_mmio(sysbus, &s->iomem);
-    sysbus_mmio_map(sysbus, 0, BONITO_INTERNAL_REG_BASE);
+    memory_region_add_subregion(host_mem, BONITO_INTERNAL_REG_BASE,
+                                &s->iomem);
 
     /* set the north bridge pci configure  mapping */
     memory_region_init_io(&phb->conf_mem, OBJECT(s), &bonito_pciconf_ops, s,
                           "north-bridge-pci-config", BONITO_PCICONFIG_SIZE);
-    sysbus_init_mmio(sysbus, &phb->conf_mem);
-    sysbus_mmio_map(sysbus, 1, BONITO_PCICONFIG_BASE);
+    memory_region_add_subregion(host_mem, BONITO_PCICONFIG_BASE,
+                                &phb->conf_mem);
 
     /* set the south bridge pci configure  mapping */
     memory_region_init_io(&phb->data_mem, OBJECT(s), &bonito_spciconf_ops, s,
                           "south-bridge-pci-config", BONITO_SPCICONFIG_SIZE);
-    sysbus_init_mmio(sysbus, &phb->data_mem);
-    sysbus_mmio_map(sysbus, 2, BONITO_SPCICONFIG_BASE);
+    memory_region_add_subregion(host_mem, BONITO_SPCICONFIG_BASE,
+                                &phb->data_mem);
 
     create_unimplemented_device("bonito", BONITO_REG_BASE, BONITO_REG_SIZE);
 
     memory_region_init_io(&s->iomem_ldma, OBJECT(s), &bonito_ldma_ops, s,
                           "ldma", 0x100);
-    sysbus_init_mmio(sysbus, &s->iomem_ldma);
-    sysbus_mmio_map(sysbus, 3, 0x1fe00200);
+    memory_region_add_subregion(host_mem, 0x1fe00200,
+                                &s->iomem_ldma);
 
     /* PCI copier */
     memory_region_init_io(&s->iomem_cop, OBJECT(s), &bonito_cop_ops, s,
                           "cop", 0x100);
-    sysbus_init_mmio(sysbus, &s->iomem_cop);
-    sysbus_mmio_map(sysbus, 4, 0x1fe00300);
+    memory_region_add_subregion(host_mem, 0x1fe00300,
+                                &s->iomem_cop);
 
     create_unimplemented_device("ROMCS", BONITO_FLASH_BASE, 60 * MiB);
 
     /* Map PCI IO Space  0x1fd0 0000 - 0x1fd1 0000 */
     memory_region_init_alias(&s->bonito_pciio, OBJECT(s), "isa_mmio",
                              get_system_io(), 0, BONITO_PCIIO_SIZE);
-    sysbus_init_mmio(sysbus, &s->bonito_pciio);
-    sysbus_mmio_map(sysbus, 5, BONITO_PCIIO_BASE);
+    memory_region_add_subregion(host_mem, BONITO_PCIIO_BASE,
+                                &s->bonito_pciio);
 
     /* add pci local io mapping */
 
     memory_region_init_alias(&s->bonito_localio, OBJECT(s), "IOCS[0]",
                              get_system_io(), 0, 256 * KiB);
-    sysbus_init_mmio(sysbus, &s->bonito_localio);
-    sysbus_mmio_map(sysbus, 6, BONITO_DEV_BASE);
+    memory_region_add_subregion(host_mem, BONITO_DEV_BASE,
+                                &s->bonito_localio);
     create_unimplemented_device("IOCS[1]", BONITO_DEV_BASE + 1 * 256 * KiB,
                                 256 * KiB);
     create_unimplemented_device("IOCS[2]", BONITO_DEV_BASE + 2 * 256 * KiB,
@@ -719,7 +719,7 @@ static void bonito_pci_realize(PCIDevice *dev, Error **errp)
 
     memory_region_init_alias(pcimem_alias, NULL, "pci.mem.alias",
                              &bs->pci_mem, 0, BONITO_PCIHI_SIZE);
-    memory_region_add_subregion(get_system_memory(),
+    memory_region_add_subregion(host_mem,
                                 BONITO_PCIHI_BASE, pcimem_alias);
     create_unimplemented_device("PCI_2",
                                 (hwaddr)BONITO_PCIHI_BASE + BONITO_PCIHI_SIZE,
-- 
2.41.0



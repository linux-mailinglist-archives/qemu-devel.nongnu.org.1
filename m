Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B587CDE95
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:13:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7Hw-00073o-4W; Wed, 18 Oct 2023 10:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt7Hu-00071c-87
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:12:42 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt7Hp-0004qw-OS
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:12:41 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53e08e439c7so11430535a12.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 07:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697638355; x=1698243155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TSfRH1Mn/Aw6tTtb5T5VxnnMQOYFdF9NNCqc+8Way/E=;
 b=lwkKHYgKKj0R8UF0CI4jj2lGpuPwtI65KpxbY9nc7EUajilR2EB0Laen810Svf6Gw2
 3y6UIcUWXWQGpS5SECHG6MfSwLxtKC3wnNmHRHzcCbDQq+BL6c/AOs28AErfJfl40FlM
 n0ofhmsUjwrqgIJM9Ij1QKtGBzAryr1TmHiqu6+JdNwL5davfNxeKgEq/05ad6HyZo9L
 3rSbLkNO8xVqq+f05SJK0r9QTcy6iB0I50qay7f9tuyp8DGUmjyZVUcNo+dRkVnzLpRz
 /2IOezgw+azmspJJ6GY4/zi8EcDsp+ydrF/dvOx0uXWyUspIVRR3LhQA9j/aKx5+3+S3
 oQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697638355; x=1698243155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TSfRH1Mn/Aw6tTtb5T5VxnnMQOYFdF9NNCqc+8Way/E=;
 b=nwxRM0ZbA9kiy9+3RcamoV7ln3kl9R6tzwq9NkNgxtmGl+dzhWTq2Lp2ASx0yGq1+Z
 jHpNF4KVC6Mvr8tJz4BD82Ug44c1laoTp8wQB7Sh5wTr5aP3Xeer53/BuN8Xo7rOD1vb
 SHx3w1kCVx5pmZIx+J298Q+Y/w0PVTxbx3v+iS9oD/gDE2XlOa3YTqgYC9zkhE8nUUBj
 qq6ejIYayh7kn+m+qQemvX5an/xS4hWmEXA4OIifX4PQ4FiNmP/8b9mj+RO9unjwxPCS
 1tFMKP3S6eOa1dfzqpYuK8Fc4wu72Hy586r1MyBAuUNdl5y+XpBLjjUy1sklh/G7Kf7z
 DswA==
X-Gm-Message-State: AOJu0YxvciUcy9apRAxOXTsgdMfg7Ox5DHlRzdTna9Jw9VNSGm9BE5Pw
 SJ0HX5TnIMjf+VdW64rzUjk0P029K/wDtEhpE8E=
X-Google-Smtp-Source: AGHT+IFzukzia+V0+5Swwm35uF6LdYO7kKDj2x+IJAbYviiJCXXtpuGWVM+k1FIvF4DoJIVA8N4Q8Q==
X-Received: by 2002:a17:907:7211:b0:9ad:df85:97ae with SMTP id
 dr17-20020a170907721100b009addf8597aemr4253962ejc.66.1697638355445; 
 Wed, 18 Oct 2023 07:12:35 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 bo16-20020a170906d05000b00977eec7b7e8sm1789807ejb.68.2023.10.18.07.12.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 07:12:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 05/12] hw/pci-host/bonito: Do not use SysBus API to map local
 MMIO region
Date: Wed, 18 Oct 2023 16:11:43 +0200
Message-ID: <20231018141151.87466-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018141151.87466-1-philmd@linaro.org>
References: <20231018141151.87466-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/bonito.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index ee6cb85e97..3b803bcad3 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -654,7 +654,6 @@ static void bonito_host_realize(DeviceState *dev, Error **errp)
 static void bonito_pci_realize(PCIDevice *dev, Error **errp)
 {
     PCIBonitoState *s = PCI_BONITO(dev);
-    SysBusDevice *sysbus = SYS_BUS_DEVICE(s->pcihost);
     PCIHostState *phb = PCI_HOST_BRIDGE(s->pcihost);
     BonitoState *bs = s->pcihost;
     MemoryRegion *pcimem_alias = g_new(MemoryRegion, 1);
@@ -668,48 +667,48 @@ static void bonito_pci_realize(PCIDevice *dev, Error **errp)
     /* set the north bridge register mapping */
     memory_region_init_io(&s->iomem, OBJECT(s), &bonito_ops, s,
                           "north-bridge-register", BONITO_INTERNAL_REG_SIZE);
-    sysbus_init_mmio(sysbus, &s->iomem);
-    sysbus_mmio_map(sysbus, 0, BONITO_INTERNAL_REG_BASE);
+    memory_region_add_subregion(get_system_memory(), BONITO_INTERNAL_REG_BASE,
+                                &s->iomem);
 
     /* set the north bridge pci configure  mapping */
     memory_region_init_io(&phb->conf_mem, OBJECT(s), &bonito_pciconf_ops, s,
                           "north-bridge-pci-config", BONITO_PCICONFIG_SIZE);
-    sysbus_init_mmio(sysbus, &phb->conf_mem);
-    sysbus_mmio_map(sysbus, 1, BONITO_PCICONFIG_BASE);
+    memory_region_add_subregion(get_system_memory(), BONITO_PCICONFIG_BASE,
+                                &phb->conf_mem);
 
     /* set the south bridge pci configure  mapping */
     memory_region_init_io(&phb->data_mem, OBJECT(s), &bonito_spciconf_ops, s,
                           "south-bridge-pci-config", BONITO_SPCICONFIG_SIZE);
-    sysbus_init_mmio(sysbus, &phb->data_mem);
-    sysbus_mmio_map(sysbus, 2, BONITO_SPCICONFIG_BASE);
+    memory_region_add_subregion(get_system_memory(), BONITO_SPCICONFIG_BASE,
+                                &phb->data_mem);
 
     create_unimplemented_device("bonito", BONITO_REG_BASE, BONITO_REG_SIZE);
 
     memory_region_init_io(&s->iomem_ldma, OBJECT(s), &bonito_ldma_ops, s,
                           "ldma", 0x100);
-    sysbus_init_mmio(sysbus, &s->iomem_ldma);
-    sysbus_mmio_map(sysbus, 3, 0x1fe00200);
+    memory_region_add_subregion(get_system_memory(), 0x1fe00200,
+                                &s->iomem_ldma);
 
     /* PCI copier */
     memory_region_init_io(&s->iomem_cop, OBJECT(s), &bonito_cop_ops, s,
                           "cop", 0x100);
-    sysbus_init_mmio(sysbus, &s->iomem_cop);
-    sysbus_mmio_map(sysbus, 4, 0x1fe00300);
+    memory_region_add_subregion(get_system_memory(), 0x1fe00300,
+                                &s->iomem_cop);
 
     create_unimplemented_device("ROMCS", BONITO_FLASH_BASE, 60 * MiB);
 
     /* Map PCI IO Space  0x1fd0 0000 - 0x1fd1 0000 */
     memory_region_init_alias(&s->bonito_pciio, OBJECT(s), "isa_mmio",
                              get_system_io(), 0, BONITO_PCIIO_SIZE);
-    sysbus_init_mmio(sysbus, &s->bonito_pciio);
-    sysbus_mmio_map(sysbus, 5, BONITO_PCIIO_BASE);
+    memory_region_add_subregion(get_system_memory(), BONITO_PCIIO_BASE,
+                                &s->bonito_pciio);
 
     /* add pci local io mapping */
 
     memory_region_init_alias(&s->bonito_localio, OBJECT(s), "IOCS[0]",
                              get_system_io(), 0, 256 * KiB);
-    sysbus_init_mmio(sysbus, &s->bonito_localio);
-    sysbus_mmio_map(sysbus, 6, BONITO_DEV_BASE);
+    memory_region_add_subregion(get_system_memory(), BONITO_DEV_BASE,
+                                &s->bonito_localio);
     create_unimplemented_device("IOCS[1]", BONITO_DEV_BASE + 1 * 256 * KiB,
                                 256 * KiB);
     create_unimplemented_device("IOCS[2]", BONITO_DEV_BASE + 2 * 256 * KiB,
-- 
2.41.0



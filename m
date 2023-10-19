Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CFC7D03F7
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:25:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaTD-0003Lk-3A; Thu, 19 Oct 2023 17:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaTA-0003FH-Rg
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:22:16 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaT7-0000H7-U2
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:22:16 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c50305c5c4so1819781fa.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750532; x=1698355332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ix2iKalM6rt+N1evpv/75s+6JhZMBmTdvoofTWM57FQ=;
 b=U/syFgfFOrGZgqTuyKRfCwLHBhtCS/USSYDnm/y8vBDBLzsDTURPVxKwEZYcCLnrgf
 tZRhmjLRUBRL+r4rb90gIC4LQr5ifMzZDcjvWSwJqHiI7ZWLHAIFRwCdv4KsZVjzgCF2
 Z2pM7TPOz2ZmagkME0s9iMUC7sZzvQ0jOCJ9Xu+539UqN5BL+uMzqIsJFsfSvinSw7ME
 /v5wyETQXvbDDhIebsuLLHhRP3vM0uybwI5Qf+wuaUcCrigTi7BQecKHrB4OsXJjUZDB
 UVbkZLTgJIWHy+jpMiEab0ngv1vm+Q1H8W5U6CG1GucEQ9AiCtJPL4BOIZOpwWU+yfKK
 LCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750532; x=1698355332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ix2iKalM6rt+N1evpv/75s+6JhZMBmTdvoofTWM57FQ=;
 b=fS6e0VHdqyos+z40VBfzGgMme6uIYJD1bzKlY48Z2C/UjxxFHcq82VFe/ua6NJ4Pl8
 BhDl0LWPWRE/QTIWzZXbXs8r1ubPIs2Xb0QRCzsjvWbYENBvFm1gVNppp+zhudAWJbzW
 Ft8o8aX1fw5CXE8yJ/aSH1mDd7PKuZ26aGxIcZjYuXzSiWI1KmWtSa3TUi2tJuJxow/U
 5TTUSj28FWygzngYwxGJ2zicK3d0SC+32y8MGpwU+VcM/qHLeZ+2KRnnHy34C4nGI7r/
 S936CgeDFWhwlkeWwwko40xQemd1lfcHMVvcdVn01BO7CXhPAd5jpG5yz9RJVRF9hATd
 irDw==
X-Gm-Message-State: AOJu0YxBCfPsYnN20RxlV7YJhmOUaFpny2fXt6paJU9MvKYqarTFwduD
 I90uTBc8q8dY3tEfhTCoXlRXeloVG8MOt/Tk+81bWw==
X-Google-Smtp-Source: AGHT+IF+bVh+TtmYcDBLGChzc/hD5sdSmcCFLkV7beGWMsMB1Lnk7yZZDZmn1fOUkvH5cA1tvCSnPg==
X-Received: by 2002:a05:651c:1409:b0:2c5:1d11:5688 with SMTP id
 u9-20020a05651c140900b002c51d115688mr86982lje.14.1697750531855; 
 Thu, 19 Oct 2023 14:22:11 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 az20-20020a05600c601400b004054dcbf92asm519972wmb.20.2023.10.19.14.22.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:22:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 35/46] hw/pci-host/bonito: Do not use SysBus API to map local
 MMIO region
Date: Thu, 19 Oct 2023 23:18:00 +0200
Message-ID: <20231019211814.30576-36-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231019071611.98885-6-philmd@linaro.org>
---
 hw/pci-host/bonito.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index ee6cb85e97..bab661f3ce 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -654,7 +654,7 @@ static void bonito_host_realize(DeviceState *dev, Error **errp)
 static void bonito_pci_realize(PCIDevice *dev, Error **errp)
 {
     PCIBonitoState *s = PCI_BONITO(dev);
-    SysBusDevice *sysbus = SYS_BUS_DEVICE(s->pcihost);
+    MemoryRegion *host_mem = get_system_memory();
     PCIHostState *phb = PCI_HOST_BRIDGE(s->pcihost);
     BonitoState *bs = s->pcihost;
     MemoryRegion *pcimem_alias = g_new(MemoryRegion, 1);
@@ -668,48 +668,45 @@ static void bonito_pci_realize(PCIDevice *dev, Error **errp)
     /* set the north bridge register mapping */
     memory_region_init_io(&s->iomem, OBJECT(s), &bonito_ops, s,
                           "north-bridge-register", BONITO_INTERNAL_REG_SIZE);
-    sysbus_init_mmio(sysbus, &s->iomem);
-    sysbus_mmio_map(sysbus, 0, BONITO_INTERNAL_REG_BASE);
+    memory_region_add_subregion(host_mem, BONITO_INTERNAL_REG_BASE, &s->iomem);
 
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
+    memory_region_add_subregion(host_mem, 0x1fe00200, &s->iomem_ldma);
 
     /* PCI copier */
     memory_region_init_io(&s->iomem_cop, OBJECT(s), &bonito_cop_ops, s,
                           "cop", 0x100);
-    sysbus_init_mmio(sysbus, &s->iomem_cop);
-    sysbus_mmio_map(sysbus, 4, 0x1fe00300);
+    memory_region_add_subregion(host_mem, 0x1fe00300, &s->iomem_cop);
 
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
@@ -719,8 +716,7 @@ static void bonito_pci_realize(PCIDevice *dev, Error **errp)
 
     memory_region_init_alias(pcimem_alias, NULL, "pci.mem.alias",
                              &bs->pci_mem, 0, BONITO_PCIHI_SIZE);
-    memory_region_add_subregion(get_system_memory(),
-                                BONITO_PCIHI_BASE, pcimem_alias);
+    memory_region_add_subregion(host_mem, BONITO_PCIHI_BASE, pcimem_alias);
     create_unimplemented_device("PCI_2",
                                 (hwaddr)BONITO_PCIHI_BASE + BONITO_PCIHI_SIZE,
                                 2 * GiB);
-- 
2.41.0



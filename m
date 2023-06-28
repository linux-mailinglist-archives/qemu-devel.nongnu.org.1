Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C57741911
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 21:53:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEbDJ-0004jc-HF; Wed, 28 Jun 2023 15:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDC-0004gr-9d
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:22 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDA-0005iO-Mt
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:22 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-991fee3a6b1so25188666b.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 12:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687981939; x=1690573939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fWlnycR5wJyTdbj8DEeaQ9aaDr9hN9D3c5m0fZQj8MU=;
 b=dHQfj8xZfVNPNi67NDDtMr6ztg98xEwGKlej5ZICK/2ijaI9VUqgtDvwatQm/8PcFX
 ekPJZUed90DuG8BX3JfBMhPCv7mBx0WEA9IZjgUEfVMkIaXnIy9wYsEEcAUfGDxbeAqH
 P1X1T411rAucl0HroOvDECsnNMLxQbU+O+6gwPY4Bn9m9lVxsnmO8AUJEmOXr5foXqxi
 rB3iDWdztNBQTkMlcEj1t08i35Okh4PokAl8RgofPO2XnpAuvV7VSx/Q4S9YOjdXXMC1
 6eZka3ep/JIyyukUmwFfOncOtzN27FkmSWDcTyJAn4qW3pcONgvT4dOnRwJdNDOayd/t
 HBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687981939; x=1690573939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fWlnycR5wJyTdbj8DEeaQ9aaDr9hN9D3c5m0fZQj8MU=;
 b=FUgZYwzPKUXIW8B2nkrp75xDyzYQLIWgKLGj2ui3CMwcIlir77FI1BY9ly1cZJ51V5
 gwjhnL6ypOeWyAcd2OTSx2dmuc+NYXKKbjOGoejvRoElqwkIun3vDM2XoKcUqyFstbe+
 djlwE/8GV83IcdJLw2HOKioK5NMa0mcBfOT7e6R5KIWJcPFIzl5+JHLNkRiZ21UViYSd
 IEizs4oEXMguj86qhhAAupR/w06H+DH1zrRDQ4MmdfdeoGjfapk5z5BzQ7hXJ5lVrCGR
 kkvKEiQWOx2Ymhoo5wqkzq6sYGSEGZAyqhSk977pUiZL3814bqbkog9eSwEKI08nYtGY
 h6ig==
X-Gm-Message-State: AC+VfDxsPRDH1mFwkVXX+jCCMPBp8HD3kQ4dC5PGk/W5UxU2pPBM0k8e
 0Mw4beXOfuyen4u54JAa29Xdlcq4k9s=
X-Google-Smtp-Source: ACHHUZ52DBeQ2cjjNsTmbdGi5j4ZEZnDL4RR6VsqkFGnT7bgJOZ6cDIPvUh+lZB6J7vtECx0oS448g==
X-Received: by 2002:a17:907:3e16:b0:978:a186:464f with SMTP id
 hp22-20020a1709073e1600b00978a186464fmr35930860ejc.39.1687981938712; 
 Wed, 28 Jun 2023 12:52:18 -0700 (PDT)
Received: from archlinux.. (dynamic-077-191-074-208.77.191.pool.telefonica.de.
 [77.191.74.208]) by smtp.gmail.com with ESMTPSA id
 ec10-20020a170906b6ca00b00982be08a9besm6142817ejb.172.2023.06.28.12.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 12:52:18 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 06/16] hw/pci-host/q35: Make some property name macros
 reusable by i440fx
Date: Wed, 28 Jun 2023 21:51:54 +0200
Message-ID: <20230628195204.1241-7-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628195204.1241-1-shentey@gmail.com>
References: <20230628195204.1241-1-shentey@gmail.com>
MIME-Version: 1.0
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/pc.h      | 4 ++++
 include/hw/pci-host/q35.h | 5 -----
 hw/i386/pc_q35.c          | 8 ++++----
 hw/pci-host/q35.c         | 8 ++++----
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 6eec0fc51d..c34c698cdd 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -146,6 +146,10 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 
 void pc_guest_info_init(PCMachineState *pcms);
 
+#define PCI_HOST_PROP_RAM_MEM          "ram-mem"
+#define PCI_HOST_PROP_PCI_MEM          "pci-mem"
+#define PCI_HOST_PROP_SYSTEM_MEM       "system-mem"
+#define PCI_HOST_PROP_IO_MEM           "io-mem"
 #define PCI_HOST_PROP_PCI_HOLE_START   "pci-hole-start"
 #define PCI_HOST_PROP_PCI_HOLE_END     "pci-hole-end"
 #define PCI_HOST_PROP_PCI_HOLE64_START "pci-hole64-start"
diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index e89329c51e..1d98bbfe0d 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -74,11 +74,6 @@ struct Q35PCIHost {
  * gmch part
  */
 
-#define MCH_HOST_PROP_RAM_MEM "ram-mem"
-#define MCH_HOST_PROP_PCI_MEM "pci-mem"
-#define MCH_HOST_PROP_SYSTEM_MEM "system-mem"
-#define MCH_HOST_PROP_IO_MEM "io-mem"
-
 /* PCI configuration */
 #define MCH_HOST_BRIDGE                        "MCH"
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 852250e8cb..02dd274276 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -218,13 +218,13 @@ static void pc_q35_init(MachineState *machine)
     pc_memory_init(pcms, system_memory, rom_memory, pci_hole64_size);
 
     object_property_add_child(OBJECT(machine), "q35", phb);
-    object_property_set_link(phb, MCH_HOST_PROP_RAM_MEM,
+    object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
                              OBJECT(machine->ram), NULL);
-    object_property_set_link(phb, MCH_HOST_PROP_PCI_MEM,
+    object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
                              OBJECT(pci_memory), NULL);
-    object_property_set_link(phb, MCH_HOST_PROP_SYSTEM_MEM,
+    object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
                              OBJECT(system_memory), NULL);
-    object_property_set_link(phb, MCH_HOST_PROP_IO_MEM,
+    object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
                              OBJECT(system_io), NULL);
     object_property_set_int(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
                             x86ms->below_4g_mem_size, NULL);
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index d2830cee34..91c46df9ae 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -240,19 +240,19 @@ static void q35_host_initfn(Object *obj)
     object_property_add_uint64_ptr(obj, PCIE_HOST_MCFG_SIZE,
                                    &pehb->size, OBJ_PROP_FLAG_READ);
 
-    object_property_add_link(obj, MCH_HOST_PROP_RAM_MEM, TYPE_MEMORY_REGION,
+    object_property_add_link(obj, PCI_HOST_PROP_RAM_MEM, TYPE_MEMORY_REGION,
                              (Object **) &s->mch.ram_memory,
                              qdev_prop_allow_set_link_before_realize, 0);
 
-    object_property_add_link(obj, MCH_HOST_PROP_PCI_MEM, TYPE_MEMORY_REGION,
+    object_property_add_link(obj, PCI_HOST_PROP_PCI_MEM, TYPE_MEMORY_REGION,
                              (Object **) &s->mch.pci_address_space,
                              qdev_prop_allow_set_link_before_realize, 0);
 
-    object_property_add_link(obj, MCH_HOST_PROP_SYSTEM_MEM, TYPE_MEMORY_REGION,
+    object_property_add_link(obj, PCI_HOST_PROP_SYSTEM_MEM, TYPE_MEMORY_REGION,
                              (Object **) &s->mch.system_memory,
                              qdev_prop_allow_set_link_before_realize, 0);
 
-    object_property_add_link(obj, MCH_HOST_PROP_IO_MEM, TYPE_MEMORY_REGION,
+    object_property_add_link(obj, PCI_HOST_PROP_IO_MEM, TYPE_MEMORY_REGION,
                              (Object **) &s->mch.address_space_io,
                              qdev_prop_allow_set_link_before_realize, 0);
 }
-- 
2.41.0



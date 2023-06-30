Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A28D7435EA
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:38:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8hQ-000246-4K; Fri, 30 Jun 2023 03:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hG-00023O-T7
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:38 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hE-0005Pp-Ip
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:38 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-98e1d3be004so179879466b.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 00:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688110655; x=1690702655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fWlnycR5wJyTdbj8DEeaQ9aaDr9hN9D3c5m0fZQj8MU=;
 b=hRhmVuC8Dvp7v47ZZe4b/4JlPQE4gg5OxvhtdnhyZSErQ4AJ2OBNoOCYy3B1RlukzR
 rgCTDI3Nt2qHYG87MDE5FQwzNpm+GKdbrbHpdk7NjQCvdlfdxfMBRrfzixJ48kVt5GUj
 k/beSQwnrHuTKD9CO4dZo2En5yWC4KM8AvaVlzqUOrLYjec95wiQsjjHBxIDBI7EVdiw
 WxiGXx6i6+6xQyOZAfnEwURfkTEgSHm2H9JT+Cxj57ONSXQOJcadQEgcdlKhcAy6rFxo
 9eAP1U/tzuNYA+Ln56OuNDiK6YAVsrgdHtc8ZWBPS/8SxN+HJpZPp0Bl2lL/mJoVOh8R
 8Ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688110655; x=1690702655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fWlnycR5wJyTdbj8DEeaQ9aaDr9hN9D3c5m0fZQj8MU=;
 b=US+wzdKNlqZAtfcRZDUzcgxr3+QQfNygEEpp9GFSvl0IY6Fk3ZSS3NcnhGpnWOsqtR
 JICA7VbZXsfgPE9qjnOMNXQn4snfgZRlxAEXbBw0Z+Z1VEtDQCF13h3P/zT+sRXQVvab
 4fejXGs/yHTVme2yWGv00XJBS6Xjn6FaXLJd4teoztQKOwVEi3NQv6YPFDoKImXEhoBL
 SI2TmioeBDvnALSq9K57MCCxS4cPHDdApA5V5Dss0yunm8VIvkdnMfph+t19W7WWU1cC
 weaQ9fx/Y9hxaGFXy7qYoA/rilEbGuyliHoxqvRFLPNfabqu4nBJQROKz1PMI45m02J0
 Gv/A==
X-Gm-Message-State: ABy/qLaK+PSFtSx/H/eHx6b7AKg75JyunRXvGPMGREv4vt91SFSHn/g5
 q5+L3vNKhyfQm1NluFbdo6cWnydlZjs=
X-Google-Smtp-Source: APBJJlFgWdsFvmiH6e8hwj3zyJR6A/ulgGjwW4deyE3aexofYRhuCLtL45uumGjb2uYNCU8t3/gZmg==
X-Received: by 2002:a17:906:348f:b0:98e:26ae:9b08 with SMTP id
 g15-20020a170906348f00b0098e26ae9b08mr1191832ejb.58.1688110654754; 
 Fri, 30 Jun 2023 00:37:34 -0700 (PDT)
Received: from archlinux.. (dynamic-089-012-131-254.89.12.pool.telefonica.de.
 [89.12.131.254]) by smtp.gmail.com with ESMTPSA id
 k19-20020a1709061c1300b00988b32160dfsm7625578ejg.222.2023.06.30.00.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 00:37:34 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 06/17] hw/pci-host/q35: Make some property name macros
 reusable by i440fx
Date: Fri, 30 Jun 2023 09:37:09 +0200
Message-ID: <20230630073720.21297-7-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630073720.21297-1-shentey@gmail.com>
References: <20230630073720.21297-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
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



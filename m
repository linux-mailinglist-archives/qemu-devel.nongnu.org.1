Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C086972B166
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 12:36:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8IP0-0006Rx-JI; Sun, 11 Jun 2023 06:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IOz-0006Ro-E1
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:29 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IOx-0008Ie-Px
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:29 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-977e0fbd742so484139466b.2
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 03:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686479666; x=1689071666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7T0pLqowBSVTN/lU1DOL5X7uMjLvrnQzaN8qvhbCP9w=;
 b=LTFU61W3AgeqwikH/xZekmgG7w3++vIV7iSi7TgpqA+B4Bo+BOf9RJT1h4F6djAwxE
 esXsMy8Rhr7OSCjeh7gyx4DaRPyH1jptlolpJzMcyKWSDack/+vE3eRTvB/RMOIk7Rfp
 wKGswFLKdhXFFAkjhz+HApqHX3ZWf5dWQJ0CK8mbEOvM/3SaSbu9Ze17VLFf/6F9FeYl
 UfsFmIrzCncZvRgkog4qfULWhbIuFbK3YVXa3HnuCfSPZGHsnroir/skTyBtV5K0THmQ
 LpQnC6pdl0gHWlkF0BwTansMm91HKWNKrGqoT2cOHf9aLTO7nw04GbAxVUGTUUFzCVTI
 Gskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686479666; x=1689071666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7T0pLqowBSVTN/lU1DOL5X7uMjLvrnQzaN8qvhbCP9w=;
 b=ShsWLZxDovfrivC6dXN3rhxjy8QfKwrpBTDXKRETkQt09olDJPJKhLe32ZfJ6bKHun
 rLj54PrCE9aEYTVw+D1qPS3m16ouQHA05hCQ2aP7uTWl7lFl3qv027cC9vfCeGHXQEO5
 0u7MU0cPwz73FgMDhmgKsaNbVJB3pfv53iJKdnAg9KnXH0yssL6ugdi/CwHizoMqATHo
 av5EmYVw9hw7Ys4CTlvvtBvdHZRyTKJBi2VON0z8i+3jwTJrAtjk+KsCeJUcSK5IoM76
 HWPFtyGMFDd4Gg5L/iamQ00d8BYzTcHXczYaC2qtglagBZW/izpOnIrV4W/K4bbjtm6M
 ji7g==
X-Gm-Message-State: AC+VfDy3PD5HZCyEyCYTONERToKdNjHXUYyc3Y4tz559mOwTSpnouj8w
 ViGczI9hWBGa4nVI7Af73hV20tYeOyY=
X-Google-Smtp-Source: ACHHUZ7kI8TGKWmf1RicfYO93dvbez/o+EGsjRVd6AVI9H9IRpLwcxsP0PcbK+9HYkTGZyhGdhqTTw==
X-Received: by 2002:a17:907:985:b0:94e:e5fe:b54f with SMTP id
 bf5-20020a170907098500b0094ee5feb54fmr6730393ejc.23.1686479666200; 
 Sun, 11 Jun 2023 03:34:26 -0700 (PDT)
Received: from archlinux.. (ip5f5bd7c0.dynamic.kabel-deutschland.de.
 [95.91.215.192]) by smtp.gmail.com with ESMTPSA id
 m8-20020a056402050800b005149cb5ee2dsm3794314edv.82.2023.06.11.03.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 03:34:25 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 06/15] hw/pci-host/q35: Make some property name macros
 reusable by i440fx
Date: Sun, 11 Jun 2023 12:34:03 +0200
Message-ID: <20230611103412.12109-7-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230611103412.12109-1-shentey@gmail.com>
References: <20230611103412.12109-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
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
index c661e9cc80..812613cc07 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -145,6 +145,10 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 
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
index 5220b535b2..8bfe388c9e 100644
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
index 7980ddde69..ded3f6e4f4 100644
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



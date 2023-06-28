Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D37741912
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 21:54:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEbDC-0004g9-O9; Wed, 28 Jun 2023 15:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbD6-0004fJ-T2
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:16 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbD4-0005hC-Bq
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:16 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso24032566b.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 12:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687981933; x=1690573933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M94ZWqJV1AdEsj9l0Iz5HDYh7/xoEBsvE14jtmH7TGk=;
 b=PMhIEjcWSQaKxngW7erYnsqP4eoUN2FzRTQFLPHhyqbrLHLC6wJ0Rj1UYQpynC050g
 PI8/gpSXFvWRpIhFimBBmwcvyWBLiMegQ9p/WtGQoSFMxv2wi6zIp66gd/a+G+M8fPEB
 fvI+KQVeBsbIFHF9q6f+3e1Neqbg+h/MncU3pDrOCXPXgdBM4V0nvG+zTcFfL+EtKh5E
 hvbPv58evSIsoo06LzY/NWJpdvHHRag0JzvCJtUVT+Wzi7cEIU6HLOcKLru4diA9vIY6
 0wnKvHO43dIuQ2QieYNkduS9OTHMvmzCYvB98dqxGka9ETAMJG+VJpc6OC1jH4URUz+z
 IbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687981933; x=1690573933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M94ZWqJV1AdEsj9l0Iz5HDYh7/xoEBsvE14jtmH7TGk=;
 b=fhaq/h+mqVy/4PhFWHmM8so05/J+X91621op3p3/AEmF5GgEy2N+zVdfRMTw74YFQG
 YHMIsS2p3pM8s1aDu37FBY1Wl9g0hjsjJl7YKSrmlzzfqg3Q4G6NdmdqRaRdMkhBmWjz
 0/JKEz9LKOHIdLCeaNw+919Hn+DVkdpM2NQ7QHLDiQjG+HDG317s+4/pozn2WSW+hlB7
 0frLedf/lba0XWiEEfZhb/ELmCWASorQWAg5m+ulc7PmzrYJAHZWiA2Z7A8qOiRqevzg
 LAUU8VtiLR6+vGvHrR6vO+HcrV5M+PVOVqnl7r9AlX3TChZbYM/uQwz8rSwvHaPsNQMF
 WhRw==
X-Gm-Message-State: AC+VfDyJwyYHWEwnm3NRKF8TbIlmsbyVaAWWE65xUHXFlrvn4sy79Fda
 g6vlJKHokO8sFhzvY4prgONI3fUfCgo=
X-Google-Smtp-Source: ACHHUZ5X1HYhYsphrE3SUH6424wDcfmaK8oN2BWAhYRzaqzfc5ulHxUBkz8aYh13TV5mJe/RvJrmow==
X-Received: by 2002:a17:907:7b96:b0:969:7739:2eb7 with SMTP id
 ne22-20020a1709077b9600b0096977392eb7mr34639607ejc.4.1687981932554; 
 Wed, 28 Jun 2023 12:52:12 -0700 (PDT)
Received: from archlinux.. (dynamic-077-191-074-208.77.191.pool.telefonica.de.
 [77.191.74.208]) by smtp.gmail.com with ESMTPSA id
 ec10-20020a170906b6ca00b00982be08a9besm6142817ejb.172.2023.06.28.12.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 12:52:12 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 01/16] hw/i386/pc_q35: Resolve redundant q35_host variable
Date: Wed, 28 Jun 2023 21:51:49 +0200
Message-ID: <20230628195204.1241-2-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628195204.1241-1-shentey@gmail.com>
References: <20230628195204.1241-1-shentey@gmail.com>
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

The variable is redundant to "phb" and is never used by its real type.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/pc_q35.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 11a7084ea1..d9f3764184 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -120,8 +120,7 @@ static void pc_q35_init(MachineState *machine)
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(machine);
-    Q35PCIHost *q35_host;
-    PCIHostState *phb;
+    Object *phb;
     PCIBus *host_bus;
     PCIDevice *lpc;
     DeviceState *lpc_dev;
@@ -207,10 +206,10 @@ static void pc_q35_init(MachineState *machine)
     }
 
     /* create pci host bus */
-    q35_host = Q35_HOST_DEVICE(qdev_new(TYPE_Q35_HOST_DEVICE));
+    phb = OBJECT(qdev_new(TYPE_Q35_HOST_DEVICE));
 
     if (pcmc->pci_enabled) {
-        pci_hole64_size = object_property_get_uint(OBJECT(q35_host),
+        pci_hole64_size = object_property_get_uint(phb,
                                                    PCI_HOST_PROP_PCI_HOLE64_SIZE,
                                                    &error_abort);
     }
@@ -218,23 +217,23 @@ static void pc_q35_init(MachineState *machine)
     /* allocate ram and load rom/bios */
     pc_memory_init(pcms, system_memory, rom_memory, pci_hole64_size);
 
-    object_property_add_child(OBJECT(machine), "q35", OBJECT(q35_host));
-    object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_RAM_MEM,
+    object_property_add_child(OBJECT(machine), "q35", phb);
+    object_property_set_link(phb, MCH_HOST_PROP_RAM_MEM,
                              OBJECT(machine->ram), NULL);
-    object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_PCI_MEM,
+    object_property_set_link(phb, MCH_HOST_PROP_PCI_MEM,
                              OBJECT(pci_memory), NULL);
-    object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_SYSTEM_MEM,
+    object_property_set_link(phb, MCH_HOST_PROP_SYSTEM_MEM,
                              OBJECT(system_memory), NULL);
-    object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_IO_MEM,
+    object_property_set_link(phb, MCH_HOST_PROP_IO_MEM,
                              OBJECT(system_io), NULL);
-    object_property_set_int(OBJECT(q35_host), PCI_HOST_BELOW_4G_MEM_SIZE,
+    object_property_set_int(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
                             x86ms->below_4g_mem_size, NULL);
-    object_property_set_int(OBJECT(q35_host), PCI_HOST_ABOVE_4G_MEM_SIZE,
+    object_property_set_int(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
                             x86ms->above_4g_mem_size, NULL);
+
     /* pci */
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(q35_host), &error_fatal);
-    phb = PCI_HOST_BRIDGE(q35_host);
-    host_bus = phb->bus;
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
+    host_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pcie.0"));
     /* create ISA bus */
     lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC), true,
                                 TYPE_ICH9_LPC_DEVICE);
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC8B7435E5
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:38:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8hF-00022Z-BN; Fri, 30 Jun 2023 03:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hB-00021p-A2
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:33 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8h9-0005Oy-MA
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:33 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-98e0c1d5289so179347166b.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 00:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688110649; x=1690702649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scUO39qFpFyGdXPS7MAJnaZv6OMhNhlBVyg/wILuYRw=;
 b=Ewh8dJWz70BaKtNgEmV637gkQGL0ml6xjF5ndgqI8bMJIgfWN5wVOByhGPbUyYw8XZ
 Ktnq7DRFGobZ0RtSUEDzLEZ3tTooXSRyVHECPQFHbdWCpXjxnrWdsenhx4/XwwTNc4bI
 eSU/yvwNDL7usCQFnWk4qj7Iu4kUgGCbJ1MOpzpNBGNP2lBGbONeavfwYnZ4M5cDWG3q
 YyL1dCiHfUBCDWLi2II/vzgayM9JZ8HC3/KJ3AT0iY/B6wFrmM0mbI73ouC2AOzoMGlf
 zijkBCBraEQHwzv9CMh/RNGpKAjLeo5XqWFLvtKLTiJ8NzkauxObn9vOV2cnl1128NcR
 akqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688110649; x=1690702649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scUO39qFpFyGdXPS7MAJnaZv6OMhNhlBVyg/wILuYRw=;
 b=OSxvLBLHDvtebt6AfPqAFh4iIJ4gicDluLujYBXvmMCjOu9VsKZ3+zysL3zb3DCPHf
 XnBOrPmh0zG/PGKMUYVzSOAs9nKERZTq646+chnZsNR6i/vS3+ee8JdiLrRZGwunz2+q
 RnRWZ/E0ELv4s6VVwkgcjXvkiiBn79v4lzqox53qSbBW4JGqrt+M0uVLUgwd4JKdDPBg
 i8POLnyQ9nZXLt+CApbwR0Kv6U7LD/ifjH3BHhzEGOpDrz0Kto6aiXzWnql323dtpfUT
 GB6W/hEbzuvTVTyF9pdXUyhUbv+DXVXpPgJm3PS63yFNzzgSoluknCQc/L6M4ujq/odF
 +KVQ==
X-Gm-Message-State: ABy/qLaaVcjfjK0SxrcJ8lXjsRBE0PXpPptoSecmFGQinSuJyP9q4c8P
 90NwQPymr+WH7NJBq7h5/scDDW1PwD0=
X-Google-Smtp-Source: ACHHUZ7dnjB6lA4TJE7J8VSehqhdQPuddttF5UyiJglqx49BVBvz0cdz/xTivvgU1XqNz4it63/Tsw==
X-Received: by 2002:a17:906:81d8:b0:96f:afe9:25c7 with SMTP id
 e24-20020a17090681d800b0096fafe925c7mr1219175ejx.10.1688110649245; 
 Fri, 30 Jun 2023 00:37:29 -0700 (PDT)
Received: from archlinux.. (dynamic-089-012-131-254.89.12.pool.telefonica.de.
 [89.12.131.254]) by smtp.gmail.com with ESMTPSA id
 k19-20020a1709061c1300b00988b32160dfsm7625578ejg.222.2023.06.30.00.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 00:37:28 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/17] hw/i386/pc_q35: Resolve redundant q35_host variable
Date: Fri, 30 Jun 2023 09:37:04 +0200
Message-ID: <20230630073720.21297-2-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630073720.21297-1-shentey@gmail.com>
References: <20230630073720.21297-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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



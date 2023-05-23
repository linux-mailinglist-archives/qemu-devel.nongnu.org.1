Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3D770DB23
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 13:06:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1PpC-0004Wn-Vp; Tue, 23 May 2023 07:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1PpB-0004W5-7i
 for qemu-devel@nongnu.org; Tue, 23 May 2023 07:05:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1Pp9-0002iW-Lg
 for qemu-devel@nongnu.org; Tue, 23 May 2023 07:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684839902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jz3fW1+WBRLn1C7pO/CSsoBecMk3HqTr1LVKHm8D5/o=;
 b=Ry3NLJAn2NAsB0tbPUYtlc2M4c7cuRPT3fh/yPao21hizcSmLYo1R/Iiu3hFcJ3o0yIbYP
 R9RnYFF9ZZr/fCZbd6bEVK3TfSabaCtdS2jPaWSRmuoL32y4HceVfANqME6X1pJNtad3cL
 go4Y+FzIvsMRGCEwrY83NHbfoMNLvMM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-kFORMggVPWanh5RQJ4ZFaQ-1; Tue, 23 May 2023 07:04:59 -0400
X-MC-Unique: kFORMggVPWanh5RQJ4ZFaQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1193E2A59574;
 Tue, 23 May 2023 11:04:59 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.186])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26CE07AF5;
 Tue, 23 May 2023 11:04:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Max Filippov <jcmvbkbc@gmail.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH 5/5] hw/xtensa: Use MachineClass->default_nic in the virt
 machine
Date: Tue, 23 May 2023 13:04:35 +0200
Message-Id: <20230523110435.1375774-6-thuth@redhat.com>
In-Reply-To: <20230523110435.1375774-1-thuth@redhat.com>
References: <20230523110435.1375774-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Mark the default NIC via the new MachineClass->default_nic setting
so that the machine-defaults code in vl.c can decide whether the
default NIC is usable or not (for example when compiling with the
"--without-default-devices" configure switch).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/xtensa/virt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index a18e3fc910..b87f842e74 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -38,7 +38,8 @@
 #include "xtensa_memory.h"
 #include "xtensa_sim.h"
 
-static void create_pcie(CPUXtensaState *env, int irq_base, hwaddr addr_base)
+static void create_pcie(MachineState *ms, CPUXtensaState *env, int irq_base,
+                        hwaddr addr_base)
 {
     hwaddr base_ecam = addr_base + 0x00100000;
     hwaddr size_ecam =             0x03f00000;
@@ -54,6 +55,7 @@ static void create_pcie(CPUXtensaState *env, int irq_base, hwaddr addr_base)
     MemoryRegion *mmio_alias;
     MemoryRegion *mmio_reg;
 
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
     DeviceState *dev;
     PCIHostState *pci;
     qemu_irq *extints;
@@ -104,7 +106,7 @@ static void create_pcie(CPUXtensaState *env, int irq_base, hwaddr addr_base)
             NICInfo *nd = &nd_table[i];
 
             if (!nd->model) {
-                nd->model = g_strdup("virtio");
+                nd->model = g_strdup(mc->default_nic);
             }
 
             pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
@@ -117,7 +119,7 @@ static void xtensa_virt_init(MachineState *machine)
     XtensaCPU *cpu = xtensa_sim_common_init(machine);
     CPUXtensaState *env = &cpu->env;
 
-    create_pcie(env, 0, 0xf0000000);
+    create_pcie(machine, env, 0, 0xf0000000);
     xtensa_sim_load_kernel(cpu, machine);
 }
 
@@ -127,6 +129,7 @@ static void xtensa_virt_machine_init(MachineClass *mc)
     mc->init = xtensa_virt_init;
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_nic = "virtio-net-pci";
 }
 
 DEFINE_MACHINE("virt", xtensa_virt_machine_init)
-- 
2.31.1



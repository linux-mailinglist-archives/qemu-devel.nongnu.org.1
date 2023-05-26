Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9F971231B
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 11:11:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2TRR-0002yo-UH; Fri, 26 May 2023 05:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2TRP-0002wY-KQ
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:08:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2TRO-0000iN-4f
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685092133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jQZcidCD9FXsEpzsaTAYOMpwzI84iEJUxvi1todzSl8=;
 b=ZHelkXEGmkiRQJiSd6fVo77Jw/NuUATle5LAgSQe1SL2rngnEhsIYGfFU5yG/OubY8vR7l
 I7jb83TnkP4Njw5DfIHVAF1O9phY5dGdg8umCeQRm6kd7J1cLaN7UNlaQpV2fdbZ3X8mBp
 2ZScRUGg7WLNchcNJGGhhoikQfkzTfg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-1LZsr1lDNb2lCHh3zfeyxw-1; Fri, 26 May 2023 05:08:48 -0400
X-MC-Unique: 1LZsr1lDNb2lCHh3zfeyxw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 211388032F5;
 Fri, 26 May 2023 09:08:48 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55AA3C0448E;
 Fri, 26 May 2023 09:08:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/15] hw/xtensa: Use MachineClass->default_nic in the virt
 machine
Date: Fri, 26 May 2023 11:08:30 +0200
Message-Id: <20230526090840.2225958-6-thuth@redhat.com>
In-Reply-To: <20230526090840.2225958-1-thuth@redhat.com>
References: <20230526090840.2225958-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Mark the default NIC via the new MachineClass->default_nic setting
so that the machine-defaults code in vl.c can decide whether the
default NIC is usable or not (for example when compiling with the
"--without-default-devices" configure switch).

Message-Id: <20230523110435.1375774-6-thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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



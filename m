Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C537FCDE6
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 05:23:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8C54-0002iE-Dv; Tue, 28 Nov 2023 23:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r8C51-0002VQ-An
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 23:21:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r8C4z-0007QB-Ky
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 23:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701231700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:mime-version: content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i8Sp/8SK4743lQGwgH+4VWrbTnWzFB9u/QLRM/j3xU8=;
 b=DAcTAfNzuMWFOtBq7obGzdW4dGvLPLMnsvnhlmhAgUPdcqD4t5Y2VVDlvGEZhLMtZT59M+
 fUrmYfo00hkO6VdSpceNwuhR1cGjxLuS+hGLgVfZrnArMGt2s/ju/S6lMXIlX3EsUvX4O7
 76hO6RtqRy4pDAMVdcFcIOmEs6TMnto=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-YrfAMrQbOtCOEnDL7r6jiA-1; Tue,
 28 Nov 2023 23:21:35 -0500
X-MC-Unique: YrfAMrQbOtCOEnDL7r6jiA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 284F53C02772;
 Wed, 29 Nov 2023 04:21:34 +0000 (UTC)
Received: from gshan.redhat.com (unknown [10.64.136.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 49F2A492BE0;
 Wed, 29 Nov 2023 04:21:26 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, b.galvani@gmail.com, strahinja.p.jankovic@gmail.com,
 sundeep.lkml@gmail.com, kfting@nuvoton.com, wuhaotsh@google.com,
 nieklinnenbank@gmail.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 vijai@behindbytes.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, shan.gavin@gmail.com
Subject: [PATCH v8 7/9] hw/arm/sbsa-ref: Check CPU type in
 machine_run_board_init()
Date: Wed, 29 Nov 2023 14:20:10 +1000
Message-ID: <20231129042012.277831-8-gshan@redhat.com>
In-Reply-To: <20231129042012.277831-1-gshan@redhat.com>
References: <20231129042012.277831-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Set mc->valid_cpu_types so that the user specified CPU type can
be validated in machine_run_board_init(). We needn't to do it
by ourselves.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/sbsa-ref.c | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index f3c9704693..477dca0637 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -145,27 +145,6 @@ static const int sbsa_ref_irqmap[] = {
     [SBSA_GWDT_WS0] = 16,
 };
 
-static const char * const valid_cpus[] = {
-    ARM_CPU_TYPE_NAME("cortex-a57"),
-    ARM_CPU_TYPE_NAME("cortex-a72"),
-    ARM_CPU_TYPE_NAME("neoverse-n1"),
-    ARM_CPU_TYPE_NAME("neoverse-v1"),
-    ARM_CPU_TYPE_NAME("neoverse-n2"),
-    ARM_CPU_TYPE_NAME("max"),
-};
-
-static bool cpu_type_valid(const char *cpu)
-{
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(valid_cpus); i++) {
-        if (strcmp(cpu, valid_cpus[i]) == 0) {
-            return true;
-        }
-    }
-    return false;
-}
-
 static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
 {
     uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
@@ -733,11 +712,6 @@ static void sbsa_ref_init(MachineState *machine)
     const CPUArchIdList *possible_cpus;
     int n, sbsa_max_cpus;
 
-    if (!cpu_type_valid(machine->cpu_type)) {
-        error_report("sbsa-ref: CPU type %s not supported", machine->cpu_type);
-        exit(1);
-    }
-
     if (kvm_enabled()) {
         error_report("sbsa-ref: KVM is not supported for this machine");
         exit(1);
@@ -898,10 +872,20 @@ static void sbsa_ref_instance_init(Object *obj)
 static void sbsa_ref_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a57"),
+        ARM_CPU_TYPE_NAME("cortex-a72"),
+        ARM_CPU_TYPE_NAME("neoverse-n1"),
+        ARM_CPU_TYPE_NAME("neoverse-v1"),
+        ARM_CPU_TYPE_NAME("neoverse-n2"),
+        ARM_CPU_TYPE_NAME("max"),
+        NULL,
+    };
 
     mc->init = sbsa_ref_init;
     mc->desc = "QEMU 'SBSA Reference' ARM Virtual Machine";
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("neoverse-n1");
+    mc->valid_cpu_types = valid_cpu_types;
     mc->max_cpus = 512;
     mc->pci_allow_0_address = true;
     mc->minimum_page_bits = 12;
-- 
2.42.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9038E831B78
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:36:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTUR-0000mG-W2; Thu, 18 Jan 2024 09:35:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTUN-0000lb-Me; Thu, 18 Jan 2024 09:35:28 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTUL-0002lN-Sn; Thu, 18 Jan 2024 09:35:27 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d5f252411aso20125295ad.2; 
 Thu, 18 Jan 2024 06:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705588524; x=1706193324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2SiDlfSpv/xIYQQlc/t25+KSlNBDOqQls9PCpLJRNA=;
 b=A+lBC+BU13fQoEOpLRHACsgIZpHNNAzMYbIBW10P+WuOyn13kLud50xAh2+qGGSfsn
 +ElhvcZV1CSpVp1mhTkrO5j0Dpv0wYFM7DSS6yvgV1/ft/5yk4tu/2Pysc25K3WiD1xH
 5sIugazGJtYEQCV322RfSYoX3vR9NqwMGB+mx4VC+oT5dNxN6dd1Yf6gGyDmtg4wnc+X
 S4a3wZDdzdDP0i4J2WRml4C/0+faKIjnyz8adNaabSSPMIzbjXWOI/yXQKB2vBa6uWYg
 Q3vGz06qljQfvoPllFpPIS/rQQ/utvIUhZDf1B05ZKBTqrSwiwBUGKlk0raeEn4xTKHK
 2BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705588524; x=1706193324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t2SiDlfSpv/xIYQQlc/t25+KSlNBDOqQls9PCpLJRNA=;
 b=Rc33SyLoufwzUzKlfM17cqy+gH457fXOSXuTE3xy4ue8KmAUKXlTTAMjGDHDXcaUWt
 4EJ2ET1/sI7z/PH0S3m0dleQ9ho0kVHLCZnzn9m5nqJkfP23WUZPfsmNMXAA6FufEBEf
 qyhTiyeYacSCnuFYUqU4FbfUNz1FlywUG7X5dIam3beUfbvVfWN4Ki6crT5GJPipIIWF
 JI+OoeYfWlF9C3Y9UBspADsWv1+RWzvr4JFGwxmBQwekO42izqrU51A5dy0qwwpIhhnY
 zjAbXFhhq+PLjq/dGASTZkR0s/T+FlIqg6lmuuK5uYm1YAVRx1eHu76hD7PLvzDIrC/H
 BzHg==
X-Gm-Message-State: AOJu0YzBYUeGdZmLSsQIJNoAfaqZ2BlG9evcVI9TnTghDhfKhMFx8VUl
 AXcZSMV4NaQKRrts5K1hL/90BvVKljqaRxroGAw2oYFLvdo7I4bStU/1Gzl+
X-Google-Smtp-Source: AGHT+IGUHwIqQwWh7xFh9ZYKAGBsTXc+l2RNacUJU01jjfL1TTi/dyPYZ94h+X3ueiGMKwQ4ieNJXg==
X-Received: by 2002:a17:903:1207:b0:1d4:e04b:3eea with SMTP id
 l7-20020a170903120700b001d4e04b3eeamr1116173plh.31.1705588523959; 
 Thu, 18 Jan 2024 06:35:23 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 la11-20020a170902fa0b00b001d4ac461a6fsm1484371plb.86.2024.01.18.06.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:35:23 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 4/4] ppc/pnv: Implement mce injection
Date: Fri, 19 Jan 2024 00:34:59 +1000
Message-ID: <20240118143459.166994-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118143459.166994-1-npiggin@gmail.com>
References: <20240118143459.166994-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

This implements mce injection for pnv.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h |  1 +
 hw/ppc/pnv.c     | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index aa22523316..b046a12f8c 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1593,6 +1593,7 @@ void ppc_maybe_interrupt(CPUPPCState *env);
 void ppc_cpu_do_interrupt(CPUState *cpu);
 bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void ppc_cpu_do_system_reset(CPUState *cs);
+void ppc_cpu_do_machine_check(CPUState *cs);
 void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector);
 extern const VMStateDescription vmstate_ppc_cpu;
 #endif
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 427013fd60..2d18190aeb 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -38,6 +38,7 @@
 #include "hw/loader.h"
 #include "hw/nmi.h"
 #include "qapi/visitor.h"
+#include "qapi/qmp/qdict.h"
 #include "monitor/monitor.h"
 #include "hw/intc/intc.h"
 #include "hw/ipmi/ipmi.h"
@@ -2461,11 +2462,63 @@ static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
+typedef struct MCEInjectionParams {
+    uint64_t srr1_mask;
+    uint32_t dsisr;
+    uint64_t dar;
+    bool recovered;
+} MCEInjectionParams;
+
+static void pnv_do_mce_on_cpu(CPUState *cs, run_on_cpu_data data)
+{
+    MCEInjectionParams *params = data.host_ptr;
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+    uint64_t srr1_mce_bits = PPC_BITMASK(42, 45) | PPC_BIT(36);
+
+    cpu_synchronize_state(cs);
+    ppc_cpu_do_machine_check(cs);
+
+    env->spr[SPR_SRR1] |= (params->srr1_mask & srr1_mce_bits);
+    if (params->dsisr) {
+        env->spr[SPR_DSISR] = params->dsisr;
+        env->spr[SPR_DAR] = params->dar;
+    }
+
+    if (!params->recovered) {
+        env->msr &= ~MSR_RI;
+    }
+}
+
+static void pnv_mce(MCEState *m, const QDict *qdict, Error **errp)
+{
+    int cpu_index = qdict_get_int(qdict, "cpu_index");
+    uint64_t srr1_mask = qdict_get_int(qdict, "srr1_mask");
+    uint32_t dsisr = qdict_get_int(qdict, "dsisr");
+    uint64_t dar = qdict_get_int(qdict, "dar");
+    bool recovered = qdict_get_int(qdict, "recovered");
+    CPUState *cs;
+
+    cs = qemu_get_cpu(cpu_index);
+
+    if (cs != NULL) {
+        MCEInjectionParams params = {
+            .srr1_mask = srr1_mask,
+            .dsisr = dsisr,
+            .dar = dar,
+            .recovered = recovered,
+        };
+
+        run_on_cpu(cs, pnv_do_mce_on_cpu, RUN_ON_CPU_HOST_PTR(&params));
+    }
+}
+
 static void pnv_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     InterruptStatsProviderClass *ispc = INTERRUPT_STATS_PROVIDER_CLASS(oc);
     NMIClass *nc = NMI_CLASS(oc);
+    MCEClass *mcec = MCE_CLASS(oc);
 
     mc->desc = "IBM PowerNV (Non-Virtualized)";
     mc->init = pnv_init;
@@ -2483,6 +2536,7 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_id = "pnv.ram";
     ispc->print_info = pnv_pic_print_info;
     nc->nmi_monitor_handler = pnv_nmi;
+    mcec->mce_monitor_handler = pnv_mce;
 
     object_class_property_add_bool(oc, "hb-mode",
                                    pnv_machine_get_hb, pnv_machine_set_hb);
@@ -2549,6 +2603,7 @@ static const TypeInfo types[] = {
         .interfaces = (InterfaceInfo[]) {
             { TYPE_INTERRUPT_STATS_PROVIDER },
             { TYPE_NMI },
+            { TYPE_MCE },
             { },
         },
     },
-- 
2.42.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9546D831B79
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:36:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTUH-0000iJ-Gz; Thu, 18 Jan 2024 09:35:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTUF-0000hI-Ik; Thu, 18 Jan 2024 09:35:19 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTUD-0002hD-JW; Thu, 18 Jan 2024 09:35:19 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d542701796so71715125ad.1; 
 Thu, 18 Jan 2024 06:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705588515; x=1706193315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0PMar5WLxiz8HCDxfpKJnPx5DoYzCuY0jWLEgpLUHWo=;
 b=Zu7kirK2xpUCupzq3r7BY/4UX5LfbFWJYM/O+jztU8R5VZN75ZU6PhUfwAYUge1QqZ
 rmRlgcqzAOE4qF5HRIf4BvxSAHT37+Q0o4Txlp4lwXe7cQal2fCd+CnsmGekgwPo9Ggn
 QhtIHSbFDlhLb2VhCGZeDJILOeC5boCUS8ZSwWEF4HjHez3VOxURscxosRoNznCousyn
 yvoW9OFOOH5PZxuobf/GIMMmZ5Yx+EgpSLgX80zOi2y8mV5yS3tcsFM0CcqPDElLpLBu
 hgbGNgQuXVX4oakDAkZ4zr465+s+x9gyyZcbfznK/gad0TuORT2nEChRdJln9a633bif
 GsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705588515; x=1706193315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0PMar5WLxiz8HCDxfpKJnPx5DoYzCuY0jWLEgpLUHWo=;
 b=nYIc/jvnRaRUcCHodOctwYapRIIdiidSVm7xwoy1AjrgVjce1h5lzNIEkRWK/31qU/
 HNZcImKIbs6xQ/CBw3H2TTPht9W4Wfxd9wl2MDqdOiWUZKCvVq7IqYqjNK4Yni0875MM
 ny7iipMDNDVdY8ABf5NjuphO+6YusTsARS5GkLGe49cMFnHCVYgwfFFYO8B5cCEtSxZr
 SNHoGpnpSrD33Ur9s1Ebjnw4FZDBDr4g0YMR/zWLnIBqWWt7El9rKaAxfz2q2MD2Mcdz
 Jk/4SX2hwRA0qq6jmM0kRfibwMh8D96kYQa0rSRZLHWa5Smao1KvhjI9xTCudlOGoKHK
 3Cxw==
X-Gm-Message-State: AOJu0YyScJkxQoNFSI9VK8rowCIZMJZ3yIvXP1etG49GLkkk/LYSiEYb
 o3Ms53faWE/fbBeOw0Pgmp7dH9RtNtdUigyVC5SAjPcsJOiX1tatemFKiKo5
X-Google-Smtp-Source: AGHT+IHwZBnQY8IMjJFX1S5g+cjmWbvyyHAhx/VMtVLiKQxOHtxMdqYPShbs6/1aWY5bNA/Z65UaRw==
X-Received: by 2002:a17:902:bb97:b0:1d4:7863:7580 with SMTP id
 m23-20020a170902bb9700b001d478637580mr771676pls.109.1705588515565; 
 Thu, 18 Jan 2024 06:35:15 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 la11-20020a170902fa0b00b001d4ac461a6fsm1484371plb.86.2024.01.18.06.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:35:15 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 2/4] ppc/spapr: Implement mce injection
Date: Fri, 19 Jan 2024 00:34:57 +1000
Message-ID: <20240118143459.166994-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118143459.166994-1-npiggin@gmail.com>
References: <20240118143459.166994-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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

This implements mce injection for spapr.

  (qemu) mce 0 0x200000 0x80 0xdeadbeef 0

    Disabling lock debugging due to kernel taint
    MCE: CPU0: machine check (Severe) Host SLB Multihit DAR: 00000000deadbeef [Recovered]
    MCE: CPU0: machine check (Severe) Host SLB Multihit [Recovered]
    MCE: CPU0: PID: 495 Comm: a NIP: [0000000130ee07c8]
    MCE: CPU0: Initiator CPU
    MCE: CPU0: Unknown
[   71.567193] MCE: CPU0: NIP: [c0000000000d7f6c] plpar_hcall_norets+0x1c/0x28
[   71.567249] MCE: CPU0: Initiator CPU
[   71.567308] MCE: CPU0: Unknown

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/spapr.h |  3 +++
 hw/ppc/spapr.c         | 54 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 5b5ba9ef77..d8f925a391 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -1015,6 +1015,9 @@ void spapr_init_all_lpcrs(target_ulong value, target_ulong mask);
 hwaddr spapr_get_rtas_addr(void);
 bool spapr_memory_hot_unplug_supported(SpaprMachineState *spapr);
 
+void spapr_mce_inject(CPUState *cs, uint64_t srr1_mask, uint32_t dsisr,
+                      uint64_t dar, bool recovered);
+
 void spapr_vof_reset(SpaprMachineState *spapr, void *fdt, Error **errp);
 void spapr_vof_quiesce(MachineState *ms);
 bool spapr_vof_setprop(MachineState *ms, const char *path, const char *propname,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 40fdbd5d12..641b763836 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -89,6 +89,7 @@
 #include "hw/ppc/pef.h"
 
 #include "monitor/monitor.h"
+#include "qapi/qmp/qdict.h"
 
 #include <libfdt.h>
 
@@ -3584,6 +3585,56 @@ static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
+typedef struct MCEInjectionParams {
+    uint64_t srr1_mask;
+    uint32_t dsisr;
+    uint64_t dar;
+    bool recovered;
+} MCEInjectionParams;
+
+static void spapr_do_mce_on_cpu(CPUState *cs, run_on_cpu_data data)
+{
+    MCEInjectionParams *params = data.host_ptr;
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+    uint64_t srr1_mce_bits = PPC_BITMASK(42, 45) | PPC_BIT(36);
+
+    cpu_synchronize_state(cs);
+
+    env->spr[SPR_SRR0] = env->nip;
+    env->spr[SPR_SRR1] = (env->msr & ~srr1_mce_bits) |
+                         (params->srr1_mask & srr1_mce_bits);
+    if (params->dsisr) {
+        env->spr[SPR_DSISR] = params->dsisr;
+        env->spr[SPR_DAR] = params->dar;
+    }
+
+    spapr_mce_req_event(cpu, params->recovered);
+}
+
+static void spapr_mce(MCEState *m, const QDict *qdict, Error **errp)
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
+        run_on_cpu(cs, spapr_do_mce_on_cpu, RUN_ON_CPU_HOST_PTR(&params));
+    }
+}
+
 int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp)
 {
@@ -4689,6 +4740,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(oc);
     FWPathProviderClass *fwc = FW_PATH_PROVIDER_CLASS(oc);
     NMIClass *nc = NMI_CLASS(oc);
+    MCEClass *mcec = MCE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
     PPCVirtualHypervisorClass *vhc = PPC_VIRTUAL_HYPERVISOR_CLASS(oc);
     XICSFabricClass *xic = XICS_FABRIC_CLASS(oc);
@@ -4743,6 +4795,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path = spapr_get_fw_dev_path;
     nc->nmi_monitor_handler = spapr_nmi;
+    mcec->mce_monitor_handler = spapr_mce;
     smc->phb_placement = spapr_phb_placement;
     vhc->cpu_in_nested = spapr_cpu_in_nested;
     vhc->deliver_hv_excp = spapr_exit_nested;
@@ -4810,6 +4863,7 @@ static const TypeInfo spapr_machine_info = {
     .interfaces = (InterfaceInfo[]) {
         { TYPE_FW_PATH_PROVIDER },
         { TYPE_NMI },
+        { TYPE_MCE },
         { TYPE_HOTPLUG_HANDLER },
         { TYPE_PPC_VIRTUAL_HYPERVISOR },
         { TYPE_XICS_FABRIC },
-- 
2.42.0



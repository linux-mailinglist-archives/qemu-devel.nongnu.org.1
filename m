Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5208201CD
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:31:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKPa-00062N-84; Fri, 29 Dec 2023 16:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPT-0005Wb-Jg
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:28:52 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPP-0000Ko-T6
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:28:51 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so1264772b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885325; x=1704490125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2rrd/F1ImYw18auyJ1KscVM7i5UnYGijSL1Y+QDJUm0=;
 b=Mnp02gDtQlZNjsRarSqh0wU3mLPrOVFA7AE5DsXCUm5ugS0eoCLJowP5w7BwbJe1bP
 Cds7sZgIrdVUpS7OGQ5PuFG1vuv6RcsdJtRy4Lv4fPWnv2fqQPmWW0zOoa2ek+w7JKaP
 UkyhnafMmwbAyv57JxDQgnRQnBe6SXNdWBpc3kTK9jvrI11fXRo49X9skaNXtCCRQrQv
 Kzk4SAJCFNamz3U+Jtk4rX+MjSTUrRZkTWNjQnE71AA1TYVtjZLKDtoQv/YZQdK7g+L2
 dj8IWgZSpcAkWtF+HTGoAXBaf2wF1QaL9FhAj+70M/pLnigVCj8l9/oIF562Srf5wzt6
 Ks9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885325; x=1704490125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2rrd/F1ImYw18auyJ1KscVM7i5UnYGijSL1Y+QDJUm0=;
 b=SrXOL89HPf3PLgKheKnavHUSLIeZ08fEnrkVAKgesLSeAfQ5UyqiaTzOBshJ645WM6
 G3dQPMFGlgLK1TsW+WTjfHOYtES64opeMH92clTEUxbUPeWF0CrTBfL35bHu8IB+jeJQ
 yWvfXH6mB6Ab434ekWJdkmg3uy8DMV9dwhbFFiLL7VkObQEJY0cnyFbopZuq7+cj2CAK
 /k2o0LlzByP4Dep/HZt7DClpG1M08OAB3mLpbCeUCCCkDqdZ5nBhMYerAJFuJ/BKC3r2
 p/LJMaBVsQ13Wh4K0H3+Iz6sWs3m67/ogpjfnhXoqYBrTxLqQ2/LACnzyfB4bFngsJrU
 ZAUQ==
X-Gm-Message-State: AOJu0YzY3HurKQ/WOQXzp+IgHrsEohVh8n/U/MLPjlpJXwuVZnW6Bwl4
 i1TQKQC0xMaUyaMLZdMiIPrLqwWAvMTMTVsNQi9hKkMI1FlzmA==
X-Google-Smtp-Source: AGHT+IEYOKIY1KxAMDgeHLE2kjX1KJBeDVrM2b9eLgVtx1fFhZzIcFqZwA7a+lFG/iFiaA1skY92+A==
X-Received: by 2002:a05:6a20:1447:b0:195:edf4:b086 with SMTP id
 a7-20020a056a20144700b00195edf4b086mr8033929pzi.83.1703885325312; 
 Fri, 29 Dec 2023 13:28:45 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.28.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:28:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/71] hw/ppc: Constify VMState
Date: Sat, 30 Dec 2023 08:23:22 +1100
Message-Id: <20231229212346.147149-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231221031652.119827-48-richard.henderson@linaro.org>
---
 hw/ppc/ppc.c            |  2 +-
 hw/ppc/ppc4xx_pci.c     |  6 +++---
 hw/ppc/prep_systemio.c  |  2 +-
 hw/ppc/rs6000_mc.c      |  2 +-
 hw/ppc/spapr.c          | 20 ++++++++++----------
 hw/ppc/spapr_caps.c     |  2 +-
 hw/ppc/spapr_cpu_core.c | 12 ++++++------
 hw/ppc/spapr_drc.c      |  8 ++++----
 hw/ppc/spapr_iommu.c    |  6 +++---
 hw/ppc/spapr_nvdimm.c   |  4 ++--
 hw/ppc/spapr_ovec.c     |  2 +-
 hw/ppc/spapr_pci.c      |  6 +++---
 hw/ppc/spapr_rtc.c      |  2 +-
 hw/ppc/spapr_vio.c      |  2 +-
 14 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index be167710a3..c532d79f0e 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1066,7 +1066,7 @@ const VMStateDescription vmstate_ppc_timebase = {
     .version_id = 1,
     .minimum_version_id = 1,
     .pre_save = timebase_pre_save,
-    .fields      = (VMStateField []) {
+    .fields = (const VMStateField []) {
         VMSTATE_UINT64(guest_timebase, PPCTimebase),
         VMSTATE_INT64(time_of_the_day_ns, PPCTimebase),
         VMSTATE_END_OF_LIST()
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index 6652119008..0a07aab5d1 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -276,7 +276,7 @@ static const VMStateDescription vmstate_pci_master_map = {
     .name = "pci_master_map",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(la, struct PCIMasterMap),
         VMSTATE_UINT32(ma, struct PCIMasterMap),
         VMSTATE_UINT32(pcila, struct PCIMasterMap),
@@ -289,7 +289,7 @@ static const VMStateDescription vmstate_pci_target_map = {
     .name = "pci_target_map",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(ms, struct PCITargetMap),
         VMSTATE_UINT32(la, struct PCITargetMap),
         VMSTATE_END_OF_LIST()
@@ -300,7 +300,7 @@ static const VMStateDescription vmstate_ppc4xx_pci = {
     .name = "ppc4xx_pci",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(pmm, PPC4xxPCIState, PPC4xx_PCI_NR_PMMS, 1,
                              vmstate_pci_master_map,
                              struct PCIMasterMap),
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index c96cefb13d..4d3a251ed8 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -277,7 +277,7 @@ static const VMStateDescription vmstate_prep_systemio = {
     .name = "prep_systemio",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(sreset, PrepSystemIoState),
         VMSTATE_UINT8(system_control, PrepSystemIoState),
         VMSTATE_UINT8(iomap_type, PrepSystemIoState),
diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
index c0bc212e92..b35f8ba112 100644
--- a/hw/ppc/rs6000_mc.c
+++ b/hw/ppc/rs6000_mc.c
@@ -202,7 +202,7 @@ static const VMStateDescription vmstate_rs6000mc = {
     .name = "rs6000-mc",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(port0820_index, RS6000MCState),
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9b6c1c129f..4997aa4f1d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -152,7 +152,7 @@ static const VMStateDescription pre_2_10_vmstate_dummy_icp = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = pre_2_10_vmstate_dummy_icp_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UNUSED(4), /* uint32_t xirr */
         VMSTATE_UNUSED(1), /* uint8_t pending_priority */
         VMSTATE_UNUSED(1), /* uint8_t mfrr */
@@ -1919,7 +1919,7 @@ static const VMStateDescription vmstate_spapr_event_entry = {
     .name = "spapr_event_log_entry",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(summary, SpaprEventLogEntry),
         VMSTATE_UINT32(extended_length, SpaprEventLogEntry),
         VMSTATE_VBUFFER_ALLOC_UINT32(extended_log, SpaprEventLogEntry, 0,
@@ -1933,7 +1933,7 @@ static const VMStateDescription vmstate_spapr_pending_events = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = spapr_pending_events_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_QTAILQ_V(pending_events, SpaprMachineState, 1,
                          vmstate_spapr_event_entry, SpaprEventLogEntry, next),
         VMSTATE_END_OF_LIST()
@@ -1989,7 +1989,7 @@ static const VMStateDescription vmstate_spapr_ov5_cas = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = spapr_ov5_cas_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_POINTER_V(ov5_cas, SpaprMachineState, 1,
                                  vmstate_spapr_ovec, SpaprOptionVector),
         VMSTATE_END_OF_LIST()
@@ -2008,7 +2008,7 @@ static const VMStateDescription vmstate_spapr_patb_entry = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = spapr_patb_entry_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(patb_entry, SpaprMachineState),
         VMSTATE_END_OF_LIST()
     },
@@ -2026,7 +2026,7 @@ static const VMStateDescription vmstate_spapr_irq_map = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = spapr_irq_map_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BITMAP(irq_map, SpaprMachineState, 0, irq_map_nr),
         VMSTATE_END_OF_LIST()
     },
@@ -2056,7 +2056,7 @@ static const VMStateDescription vmstate_spapr_dtb = {
     .minimum_version_id = 1,
     .needed = spapr_dtb_needed,
     .pre_load = spapr_dtb_pre_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(fdt_initial_size, SpaprMachineState),
         VMSTATE_UINT32(fdt_size, SpaprMachineState),
         VMSTATE_VBUFFER_ALLOC_UINT32(fdt_blob, SpaprMachineState, 0, NULL,
@@ -2094,7 +2094,7 @@ static const VMStateDescription vmstate_spapr_fwnmi = {
     .minimum_version_id = 1,
     .needed = spapr_fwnmi_needed,
     .pre_save = spapr_fwnmi_pre_save,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(fwnmi_system_reset_addr, SpaprMachineState),
         VMSTATE_UINT64(fwnmi_machine_check_addr, SpaprMachineState),
         VMSTATE_INT32(fwnmi_machine_check_interlock, SpaprMachineState),
@@ -2109,7 +2109,7 @@ static const VMStateDescription vmstate_spapr = {
     .pre_load = spapr_pre_load,
     .post_load = spapr_post_load,
     .pre_save = spapr_pre_save,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         /* used to be @next_irq */
         VMSTATE_UNUSED_BUFFER(version_before_3, 0, 4),
 
@@ -2119,7 +2119,7 @@ static const VMStateDescription vmstate_spapr = {
         VMSTATE_PPC_TIMEBASE_V(tb, SpaprMachineState, 2),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_spapr_ov5_cas,
         &vmstate_spapr_patb_entry,
         &vmstate_spapr_pending_events,
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 5a0755d34f..e889244e52 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -904,7 +904,7 @@ const VMStateDescription vmstate_spapr_cap_##sname = {  \
     .version_id = 1,                                    \
     .minimum_version_id = 1,                            \
     .needed = spapr_cap_##sname##_needed,               \
-    .fields = (VMStateField[]) {                        \
+    .fields = (const VMStateField[]) {                  \
         VMSTATE_UINT8(mig.caps[cap],                    \
                       SpaprMachineState),               \
         VMSTATE_END_OF_LIST()                           \
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 91fae56573..710078e9f7 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -127,7 +127,7 @@ static const VMStateDescription vmstate_spapr_cpu_slb_shadow = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = slb_shadow_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(slb_shadow_addr, SpaprCpuState),
         VMSTATE_UINT64(slb_shadow_size, SpaprCpuState),
         VMSTATE_END_OF_LIST()
@@ -146,7 +146,7 @@ static const VMStateDescription vmstate_spapr_cpu_dtl = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = dtl_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(dtl_addr, SpaprCpuState),
         VMSTATE_UINT64(dtl_size, SpaprCpuState),
         VMSTATE_END_OF_LIST()
@@ -165,11 +165,11 @@ static const VMStateDescription vmstate_spapr_cpu_vpa = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vpa_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(vpa_addr, SpaprCpuState),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_spapr_cpu_slb_shadow,
         &vmstate_spapr_cpu_dtl,
         NULL
@@ -180,10 +180,10 @@ static const VMStateDescription vmstate_spapr_cpu_state = {
     .name = "spapr_cpu",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_spapr_cpu_vpa,
         NULL
     }
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 2b99d3b4b1..1484e3209d 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -471,7 +471,7 @@ static const VMStateDescription vmstate_spapr_drc_unplug_requested = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = spapr_drc_unplug_requested_needed,
-    .fields  = (VMStateField []) {
+    .fields  = (const VMStateField []) {
         VMSTATE_BOOL(unplug_requested, SpaprDrc),
         VMSTATE_END_OF_LIST()
     }
@@ -504,11 +504,11 @@ static const VMStateDescription vmstate_spapr_drc = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = spapr_drc_needed,
-    .fields  = (VMStateField []) {
+    .fields  = (const VMStateField []) {
         VMSTATE_UINT32(state, SpaprDrc),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_spapr_drc_unplug_requested,
         NULL
     }
@@ -611,7 +611,7 @@ static const VMStateDescription vmstate_spapr_drc_physical = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = drc_physical_needed,
-    .fields  = (VMStateField []) {
+    .fields  = (const VMStateField []) {
         VMSTATE_UINT32(dr_indicator, SpaprDrcPhysical),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 5e3973fc5f..e3c01ef44f 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -270,7 +270,7 @@ static const VMStateDescription vmstate_spapr_tce_table_ex = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = spapr_tce_table_ex_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(bus_offset, SpaprTceTable),
         VMSTATE_UINT32(page_shift, SpaprTceTable),
         VMSTATE_END_OF_LIST()
@@ -283,7 +283,7 @@ static const VMStateDescription vmstate_spapr_tce_table = {
     .minimum_version_id = 2,
     .pre_save = spapr_tce_table_pre_save,
     .post_load = spapr_tce_table_post_load,
-    .fields      = (VMStateField []) {
+    .fields = (const VMStateField []) {
         /* Sanity check */
         VMSTATE_UINT32_EQUAL(liobn, SpaprTceTable, NULL),
 
@@ -296,7 +296,7 @@ static const VMStateDescription vmstate_spapr_tce_table = {
 
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_spapr_tce_table_ex,
         NULL
     }
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index ad7afe7544..7d2dfe5e3d 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -528,7 +528,7 @@ static const VMStateDescription vmstate_spapr_nvdimm_flush_state = {
      .name = "spapr_nvdimm_flush_state",
      .version_id = 1,
      .minimum_version_id = 1,
-     .fields = (VMStateField[]) {
+     .fields = (const VMStateField[]) {
          VMSTATE_UINT64(continue_token, SpaprNVDIMMDeviceFlushState),
          VMSTATE_INT64(hcall_ret, SpaprNVDIMMDeviceFlushState),
          VMSTATE_UINT32(drcidx, SpaprNVDIMMDeviceFlushState),
@@ -541,7 +541,7 @@ const VMStateDescription vmstate_spapr_nvdimm_states = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = spapr_nvdimm_flush_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(hcall_flush_required, SpaprNVDIMMDevice),
         VMSTATE_UINT64(nvdimm_flush_token, SpaprNVDIMMDevice),
         VMSTATE_QLIST_V(completed_nvdimm_flush_states, SpaprNVDIMMDevice, 1,
diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
index b2567caa5c..88e29536aa 100644
--- a/hw/ppc/spapr_ovec.c
+++ b/hw/ppc/spapr_ovec.c
@@ -36,7 +36,7 @@ const VMStateDescription vmstate_spapr_ovec = {
     .name = "spapr_option_vector",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BITMAP(bitmap, SpaprOptionVector, 1, bitmap_size),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 6760823e13..25e0295d6f 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2115,7 +2115,7 @@ static const VMStateDescription vmstate_spapr_pci_lsi = {
     .name = "spapr_pci/lsi",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_EQUAL(irq, SpaprPciLsi, NULL),
 
         VMSTATE_END_OF_LIST()
@@ -2126,7 +2126,7 @@ static const VMStateDescription vmstate_spapr_pci_msi = {
     .name = "spapr_pci/msi",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField []) {
+    .fields = (const VMStateField []) {
         VMSTATE_UINT32(key, SpaprPciMsiMig),
         VMSTATE_UINT32(value.first_irq, SpaprPciMsiMig),
         VMSTATE_UINT32(value.num, SpaprPciMsiMig),
@@ -2216,7 +2216,7 @@ static const VMStateDescription vmstate_spapr_pci = {
     .pre_save = spapr_pci_pre_save,
     .post_save = spapr_pci_post_save,
     .post_load = spapr_pci_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64_EQUAL(buid, SpaprPhbState, NULL),
         VMSTATE_UINT32_TEST(mig_liobn, SpaprPhbState, pre_2_8_migration),
         VMSTATE_UINT64_TEST(mig_mem_win_addr, SpaprPhbState, pre_2_8_migration),
diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
index d55b4b0c50..deb3ea4e49 100644
--- a/hw/ppc/spapr_rtc.c
+++ b/hw/ppc/spapr_rtc.c
@@ -157,7 +157,7 @@ static const VMStateDescription vmstate_spapr_rtc = {
     .name = "spapr/rtc",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT64(ns_offset, SpaprRtcState),
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index f8ef2b6fa8..3221874848 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -616,7 +616,7 @@ const VMStateDescription vmstate_spapr_vio = {
     .name = "spapr_vio",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         /* Sanity check */
         VMSTATE_UINT32_EQUAL(reg, SpaprVioDevice, NULL),
         VMSTATE_UINT32_EQUAL(irq, SpaprVioDevice, NULL),
-- 
2.34.1



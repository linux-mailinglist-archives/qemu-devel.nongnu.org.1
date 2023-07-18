Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFA77577C9
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 11:24:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLgvE-0006Ja-0p; Tue, 18 Jul 2023 05:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qLgv9-0006J6-Vp; Tue, 18 Jul 2023 05:23:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qLgv7-00011m-5H; Tue, 18 Jul 2023 05:23:03 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36I9M8d6017345; Tue, 18 Jul 2023 09:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7BhUjHxKSV1BzNASbe7FbgzzxEii8s3OwswFL8X0phk=;
 b=V8h/+4Ta2qFOAwY3wb6IUFTa0mW/HZ9an59/DyyrO0JQNfSIwRi8S1GKWY5EQDd2FReh
 N5nMLwFOXT1jaYlSXxjlL89gsgkrL3L+PiEr8EJlQp5xYd7OKsG/QjThBmYiTVOt6Svn
 uuR2xYWblBD/2vkcyKwYc3uYdD2dL2j4XuHlQonL34npxun2RSUVBRCWYsKIePrqoFuO
 nj70fZeKw5nvoZNlDNqXDe5Roo99HqGZEJ8adGhzSW+j3miGwWHNMoxkjNMTusnFGyS3
 hn3DMSamowVwuPpOh53yAI99nsSXncPirQXeGHTFcSLWKwAzp7n79TzOmjFgVvwOSyVo zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwr1yr0hm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:57 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36I9MVoA018415;
 Tue, 18 Jul 2023 09:22:56 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwr1yr0hc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:56 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36I6uUhv029129; Tue, 18 Jul 2023 09:22:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv6smcm8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:55 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36I9MqBB37618192
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jul 2023 09:22:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C9C720040;
 Tue, 18 Jul 2023 09:22:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3756020043;
 Tue, 18 Jul 2023 09:22:50 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Jul 2023 09:22:50 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: mikey@neuling.org, vaibhav@linux.ibm.com, jniethe5@gmail.com,
 sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com,
 dbarboza@ventanamicro.com, npiggin@gmail.com
Subject: [PATCH 10/15] ppc: spapr: Initialize the GSB Elements lookup table.
Date: Tue, 18 Jul 2023 14:52:16 +0530
Message-Id: <20230718092221.1053686-11-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230718092221.1053686-1-harshpb@linux.ibm.com>
References: <20230718092221.1053686-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: h66ILCCrExR-Rj9JPIXcH7Vf9lkjM8Ek
X-Proofpoint-GUID: ClPq0NMhbcbbvSU-lkX52XCmXLNaVLy5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180082
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This is a first step towards enabling support for nested PAPR hcalls for
providing the get/set of various Guest State Buffer (GSB) elements via
h_guest_[g|s]et_state hcalls. This enables for identifying correct
callbacks for get/set for each of the elements supported via
h_guest_[g|s]et_state hcalls, support for which is added in next patch.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr_hcall.c          |   1 +
 hw/ppc/spapr_nested.c         | 487 ++++++++++++++++++++++++++++++++++
 include/hw/ppc/ppc.h          |   2 +
 include/hw/ppc/spapr_nested.h | 102 +++++++
 4 files changed, 592 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 9b1f225d4a..ca609cb5a4 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1580,6 +1580,7 @@ static void hypercall_register_types(void)
     spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
 
     spapr_register_nested();
+    init_nested();
 }
 
 type_init(hypercall_register_types)
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index e7956685af..6fbb1bcb02 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -7,6 +7,7 @@
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/spapr_nested.h"
 #include "cpu-models.h"
+#include "mmu-book3s-v3.h"
 
 #ifdef CONFIG_TCG
 #define PRTS_MASK      0x1f
@@ -417,6 +418,486 @@ static bool vcpu_check(SpaprMachineStateNestedGuest *guest,
     return false;
 }
 
+static void *get_vcpu_env_ptr(SpaprMachineStateNestedGuest *guest,
+                              target_ulong vcpuid)
+{
+    assert(vcpu_check(guest, vcpuid, false));
+    return &guest->vcpu[vcpuid].env;
+}
+
+static void *get_vcpu_ptr(SpaprMachineStateNestedGuest *guest,
+                                   target_ulong vcpuid)
+{
+    assert(vcpu_check(guest, vcpuid, false));
+    return &guest->vcpu[vcpuid];
+}
+
+static void *get_guest_ptr(SpaprMachineStateNestedGuest *guest,
+                           target_ulong vcpuid)
+{
+    return guest;
+}
+
+/*
+ * set=1 means the L1 is trying to set some state
+ * set=0 means the L1 is trying to get some state
+ */
+static void copy_state_8to8(void *a, void *b, bool set)
+{
+    /* set takes from the Big endian element_buf and sets internal buffer */
+
+    if (set) {
+        *(uint64_t *)a = be64_to_cpu(*(uint64_t *)b);
+    } else {
+        *(uint64_t *)b = cpu_to_be64(*(uint64_t *)a);
+    }
+}
+
+static void copy_state_16to16(void *a, void *b, bool set)
+{
+    uint64_t *src, *dst;
+
+    if (set) {
+        src = b;
+        dst = a;
+
+        dst[1] = be64_to_cpu(src[0]);
+        dst[0] = be64_to_cpu(src[1]);
+    } else {
+        src = a;
+        dst = b;
+
+        dst[1] = cpu_to_be64(src[0]);
+        dst[0] = cpu_to_be64(src[1]);
+    }
+}
+
+static void copy_state_4to8(void *a, void *b, bool set)
+{
+    if (set) {
+        *(uint64_t *)a  = (uint64_t) be32_to_cpu(*(uint32_t *)b);
+    } else {
+        *(uint32_t *)b = cpu_to_be32((uint32_t) (*((uint64_t *)a)));
+    }
+}
+
+static void copy_state_pagetbl(void *a, void *b, bool set)
+{
+    uint64_t *pagetbl;
+    uint64_t *buf; /* 3 double words */
+    uint64_t rts;
+
+    assert(set);
+
+    pagetbl = a;
+    buf = b;
+
+    *pagetbl = be64_to_cpu(buf[0]);
+    /* as per ISA section 6.7.6.1 */
+    *pagetbl |= PATE0_HR; /* Host Radix bit is 1 */
+
+    /* RTS */
+    rts = be64_to_cpu(buf[1]);
+    assert(rts == 52);
+    rts = rts - 31; /* since radix tree size = 2^(RTS+31) */
+    *pagetbl |=  ((rts & 0x7) << 5); /* RTS2 is bit 56:58 */
+    *pagetbl |=  (((rts >> 3) & 0x3) << 61); /* RTS1 is bit 1:2 */
+
+    /* RPDS {Size = 2^(RPDS+3) , RPDS >=5} */
+    *pagetbl |= 63 - clz64(be64_to_cpu(buf[2])) - 3;
+}
+
+static void copy_state_proctbl(void *a, void *b, bool set)
+{
+    uint64_t *proctbl;
+    uint64_t *buf; /* 2 double words */
+
+    assert(set);
+
+    proctbl = a;
+    buf = b;
+    /* PRTB: Process Table Base */
+    *proctbl = be64_to_cpu(buf[0]);
+    /* PRTS: Process Table Size = 2^(12+PRTS) */
+    if (be64_to_cpu(buf[1]) == (1ULL << 12)) {
+            *proctbl |= 0;
+    } else if (be64_to_cpu(buf[1]) == (1ULL << 24)) {
+            *proctbl |= 12;
+    } else {
+        g_assert_not_reached();
+    }
+}
+
+static void copy_state_runbuf(void *a, void *b, bool set)
+{
+    uint64_t *buf; /* 2 double words */
+    struct SpaprMachineStateNestedGuestVcpuRunBuf *runbuf;
+
+    assert(set);
+
+    runbuf = a;
+    buf = b;
+
+    runbuf->addr = be64_to_cpu(buf[0]);
+    assert(runbuf->addr);
+
+    /* per spec */
+    assert(be64_to_cpu(buf[1]) <= 16384);
+
+    /*
+     * This will also hit in the input buffer but should be fine for
+     * now. If not we can split this function.
+     */
+    assert(be64_to_cpu(buf[1]) >= VCPU_OUT_BUF_MIN_SZ);
+
+    runbuf->size = be64_to_cpu(buf[1]);
+}
+
+/* tell the L1 how big we want the output vcpu run buffer */
+static void out_buf_min_size(void *a, void *b, bool set)
+{
+    uint64_t *buf; /* 1 double word */
+
+    assert(!set);
+
+    buf = b;
+
+    buf[0] = cpu_to_be64(VCPU_OUT_BUF_MIN_SZ);
+}
+
+static void copy_logical_pvr(void *a, void *b, bool set)
+{
+    uint32_t *buf; /* 1 word */
+    uint32_t *pvr_logical_ptr;
+    uint32_t pvr_logical;
+
+    pvr_logical_ptr = a;
+    buf = b;
+
+    if (!set) {
+        buf[0] = cpu_to_be32(*pvr_logical_ptr);
+        return;
+    }
+
+    pvr_logical = be32_to_cpu(buf[0]);
+    /* don't change the major version */
+    assert((pvr_logical & CPU_POWERPC_POWER_SERVER_MASK) ==
+           (*pvr_logical_ptr & CPU_POWERPC_POWER_SERVER_MASK));
+
+    *pvr_logical_ptr = pvr_logical;
+}
+
+static void copy_tb_offset(void *a, void *b, bool set)
+{
+    SpaprMachineStateNestedGuest *guest;
+    uint64_t *buf; /* 1 double word */
+    uint64_t *tb_offset_ptr;
+    uint64_t tb_offset;
+
+    tb_offset_ptr = a;
+    buf = b;
+
+    if (!set) {
+        buf[0] = cpu_to_be64(*tb_offset_ptr);
+        return;
+    }
+
+    tb_offset = be64_to_cpu(buf[0]);
+    /* need to copy this to the individual tb_offset for each vcpu */
+    guest = container_of(tb_offset_ptr,
+                         struct SpaprMachineStateNestedGuest,
+                         tb_offset);
+    for (int i = 0; i < guest->vcpus; i++) {
+        guest->vcpu[i].tb_offset = tb_offset;
+    }
+}
+
+static void copy_state_dec_expire_tb(void *a, void *b, bool set)
+{
+    int64_t *dec_expiry_tb;
+    uint64_t *buf; /* 1 double word */
+
+    dec_expiry_tb = a;
+    buf = b;
+
+    if (!set) {
+        buf[0] = cpu_to_be64(*dec_expiry_tb);
+        return;
+    }
+
+    *dec_expiry_tb = be64_to_cpu(buf[0]);
+}
+
+static void copy_state_hdecr(void *a, void *b, bool set)
+{
+    uint64_t *buf; /* 1 double word */
+    CPUPPCState *env;
+
+    env = a;
+    buf = b;
+
+    if (!set) {
+        buf[0] = cpu_to_be64(env->tb_env->hdecr_expiry_tb);
+        return;
+    }
+
+    env->tb_env->hdecr_expiry_tb = be64_to_cpu(buf[0]);
+}
+
+static void copy_state_vscr(void *a, void *b, bool set)
+{
+    uint32_t *buf; /* 1 word */
+    CPUPPCState *env;
+
+    env = a;
+    buf = b;
+
+    if (!set) {
+        buf[0] = cpu_to_be32(ppc_get_vscr(env));
+        return;
+    }
+
+    ppc_store_vscr(env, be32_to_cpu(buf[0]));
+}
+
+static void copy_state_fpscr(void *a, void *b, bool set)
+{
+    uint64_t *buf; /* 1 double word */
+    CPUPPCState *env;
+
+    env = a;
+    buf = b;
+
+    if (!set) {
+        buf[0] = cpu_to_be64(env->fpscr);
+        return;
+    }
+
+    ppc_store_fpscr(env, be64_to_cpu(buf[0]));
+}
+
+static void copy_state_cr(void *a, void *b, bool set)
+{
+    uint32_t *buf; /* 1 word */
+    CPUPPCState *env;
+    uint64_t cr; /* api v1 uses uint64_t but papr acr v2 mentions 4 bytes */
+    env = a;
+    buf = b;
+
+    if (!set) {
+        buf[0] = cpu_to_be32((uint32_t)ppc_get_cr(env));
+        return;
+    }
+    cr = be32_to_cpu(buf[0]);
+    ppc_set_cr(env, cr);
+}
+
+struct guest_state_element_type guest_state_element_types[] = {
+    GUEST_STATE_ELEMENT_NOP(GSB_HV_VCPU_IGNORED_ID, 0),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR0,  gpr[0]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR1,  gpr[1]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR2,  gpr[2]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR3,  gpr[3]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR4,  gpr[4]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR5,  gpr[5]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR6,  gpr[6]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR7,  gpr[7]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR8,  gpr[8]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR9,  gpr[9]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR10, gpr[10]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR11, gpr[11]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR12, gpr[12]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR13, gpr[13]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR14, gpr[14]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR15, gpr[15]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR16, gpr[16]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR17, gpr[17]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR18, gpr[18]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR19, gpr[19]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR20, gpr[20]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR21, gpr[21]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR22, gpr[22]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR23, gpr[23]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR24, gpr[24]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR25, gpr[25]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR26, gpr[26]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR27, gpr[27]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR28, gpr[28]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR29, gpr[29]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR30, gpr[30]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_GPR31, gpr[31]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_NIA, nip),
+    GSE_ENV_DWM(GSB_VCPU_SPR_MSR, msr, HVMASK_MSR),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_CTR, ctr),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_LR, lr),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_XER, xer),
+    GUEST_STATE_ELEMENT_ENV_BASE(GSB_VCPU_SPR_CR, 4, copy_state_cr),
+    GUEST_STATE_ELEMENT_NOP_DW(GSB_VCPU_SPR_MMCR3),
+    GUEST_STATE_ELEMENT_NOP_DW(GSB_VCPU_SPR_SIER2),
+    GUEST_STATE_ELEMENT_NOP_DW(GSB_VCPU_SPR_SIER3),
+    GUEST_STATE_ELEMENT_NOP_W(GSB_VCPU_SPR_WORT),
+    GSE_ENV_DWM(GSB_VCPU_SPR_LPCR, spr[SPR_LPCR], HVMASK_LPCR),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_AMOR, spr[SPR_AMOR]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_HFSCR, spr[SPR_HFSCR]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_DAWR0, spr[SPR_DAWR0]),
+    GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_DAWRX0, spr[SPR_DAWRX0]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_CIABR, spr[SPR_CIABR]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_PURR,  spr[SPR_PURR]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_SPURR, spr[SPR_SPURR]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_IC,    spr[SPR_IC]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_VTB,   spr[SPR_VTB]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_HDAR,  spr[SPR_HDAR]),
+    GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_HDSISR, spr[SPR_HDSISR]),
+    GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_HEIR,   spr[SPR_HEIR]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_ASDR,  spr[SPR_ASDR]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_SRR0, spr[SPR_SRR0]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_SRR1, spr[SPR_SRR1]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_SPRG0, spr[SPR_SPRG0]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_SPRG1, spr[SPR_SPRG1]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_SPRG2, spr[SPR_SPRG2]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_SPRG3, spr[SPR_SPRG3]),
+    GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_PIDR,   spr[SPR_BOOKS_PID]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_CFAR, cfar),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_PPR, spr[SPR_PPR]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_DAWR1, spr[SPR_DAWR1]),
+    GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_DAWRX1, spr[SPR_DAWRX1]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_DEXCR, spr[SPR_DEXCR]),
+    GSE_ENV_DWM(GSB_VCPU_SPR_HDEXCR, spr[SPR_HDEXCR], HVMASK_HDEXCR),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_HASHKEYR,  spr[SPR_HASHKEYR]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_HASHPKEYR, spr[SPR_HASHPKEYR]),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR0, 16, vsr[0], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR1, 16, vsr[1], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR2, 16, vsr[2], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR3, 16, vsr[3], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR4, 16, vsr[4], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR5, 16, vsr[5], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR6, 16, vsr[6], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR7, 16, vsr[7], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR8, 16, vsr[8], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR9, 16, vsr[9], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR10, 16, vsr[10], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR11, 16, vsr[11], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR12, 16, vsr[12], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR13, 16, vsr[13], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR14, 16, vsr[14], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR15, 16, vsr[15], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR16, 16, vsr[16], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR17, 16, vsr[17], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR18, 16, vsr[18], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR19, 16, vsr[19], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR20, 16, vsr[20], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR21, 16, vsr[21], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR22, 16, vsr[22], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR23, 16, vsr[23], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR24, 16, vsr[24], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR25, 16, vsr[25], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR26, 16, vsr[26], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR27, 16, vsr[27], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR28, 16, vsr[28], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR29, 16, vsr[29], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR30, 16, vsr[30], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR31, 16, vsr[31], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR32, 16, vsr[32], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR33, 16, vsr[33], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR34, 16, vsr[34], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR35, 16, vsr[35], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR36, 16, vsr[36], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR37, 16, vsr[37], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR38, 16, vsr[38], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR39, 16, vsr[39], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR40, 16, vsr[40], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR41, 16, vsr[41], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR42, 16, vsr[42], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR43, 16, vsr[43], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR44, 16, vsr[44], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR45, 16, vsr[45], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR46, 16, vsr[46], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR47, 16, vsr[47], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR48, 16, vsr[48], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR49, 16, vsr[49], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR50, 16, vsr[50], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR51, 16, vsr[51], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR52, 16, vsr[52], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR53, 16, vsr[53], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR54, 16, vsr[54], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR55, 16, vsr[55], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR56, 16, vsr[56], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR57, 16, vsr[57], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR58, 16, vsr[58], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR59, 16, vsr[59], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR60, 16, vsr[60], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR61, 16, vsr[61], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR62, 16, vsr[62], copy_state_16to16),
+    GUEST_STATE_ELEMENT_ENV(GSB_VCPU_SPR_VSR63, 16, vsr[63], copy_state_16to16),
+    GSBE_NESTED(GSB_PART_SCOPED_PAGETBL, 0x18, parttbl[0],  copy_state_pagetbl),
+    GSBE_NESTED(GSB_PROCESS_TBL,         0x10, parttbl[1],  copy_state_proctbl),
+    GSBE_NESTED(GSB_VCPU_LPVR,           0x4,  pvr_logical, copy_logical_pvr),
+    GSBE_NESTED_MSK(GSB_TB_OFFSET, 0x8, tb_offset, copy_tb_offset,
+                    HVMASK_TB_OFFSET),
+    GSBE_NESTED_VCPU(GSB_VCPU_IN_BUFFER, 0x10, runbufin,    copy_state_runbuf),
+    GSBE_NESTED_VCPU(GSB_VCPU_OUT_BUFFER, 0x10, runbufout,   copy_state_runbuf),
+    GSBE_NESTED_VCPU(GSB_VCPU_OUT_BUF_MIN_SZ, 0x8, runbufout, out_buf_min_size),
+    GSBE_NESTED_VCPU(GSB_VCPU_DEC_EXPIRE_TB, 0x8, dec_expiry_tb,
+                     copy_state_dec_expire_tb),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_EBBHR, spr[SPR_EBBHR]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_TAR,   spr[SPR_TAR]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_EBBRR, spr[SPR_EBBRR]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_BESCR, spr[SPR_BESCR]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_IAMR , spr[SPR_IAMR]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_AMR  , spr[SPR_AMR]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_UAMOR, spr[SPR_UAMOR]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_DSCR , spr[SPR_DSCR]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_FSCR , spr[SPR_FSCR]),
+    GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_PSPB , spr[SPR_PSPB]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_CTRL , spr[SPR_CTRL]),
+    GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_VRSAVE, spr[SPR_VRSAVE]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_DAR , spr[SPR_DAR]),
+    GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_DSISR , spr[SPR_DSISR]),
+    GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_PMC1, spr[SPR_POWER_PMC1]),
+    GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_PMC2, spr[SPR_POWER_PMC2]),
+    GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_PMC3, spr[SPR_POWER_PMC3]),
+    GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_PMC4, spr[SPR_POWER_PMC4]),
+    GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_PMC5, spr[SPR_POWER_PMC5]),
+    GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_PMC6, spr[SPR_POWER_PMC6]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_MMCR0, spr[SPR_POWER_MMCR0]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_MMCR1, spr[SPR_POWER_MMCR1]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_MMCR2, spr[SPR_POWER_MMCR2]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_MMCRA, spr[SPR_POWER_MMCRA]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_SDAR , spr[SPR_POWER_SDAR]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_SIAR , spr[SPR_POWER_SIAR]),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_SIER , spr[SPR_POWER_SIER]),
+    GUEST_STATE_ELEMENT_ENV_BASE(GSB_VCPU_HDEC_EXPIRY_TB, 8, copy_state_hdecr),
+    GUEST_STATE_ELEMENT_ENV_BASE(GSB_VCPU_SPR_VSCR,  4, copy_state_vscr),
+    GUEST_STATE_ELEMENT_ENV_BASE(GSB_VCPU_SPR_FPSCR, 8, copy_state_fpscr)
+};
+
+void init_nested(void)
+{
+    struct guest_state_element_type *type;
+    int i;
+
+    /* Init the guest state elements lookup table, flags for now */
+    for (i = 0; i < ARRAY_SIZE(guest_state_element_types); i++) {
+        type = &guest_state_element_types[i];
+
+        assert(type->id <= GSB_LAST);
+        if (type->id >= GSB_VCPU_SPR_HDAR)
+            /* 0xf000 - 0xf005 Thread + RO */
+            type->flags = GUEST_STATE_ELEMENT_TYPE_FLAG_READ_ONLY;
+        else if (type->id >= GSB_VCPU_IN_BUFFER)
+            /* 0x0c00 - 0xf000 Thread + RW */
+            type->flags = 0;
+        else if (type->id >= GSB_VCPU_LPVR)
+            /* 0x0003 - 0x0bff Guest + RW */
+            type->flags = GUEST_STATE_ELEMENT_TYPE_FLAG_GUEST_WIDE;
+        else if (type->id >= GSB_HV_VCPU_STATE_SIZE)
+            /* 0x0001 - 0x0002 Guest + RO */
+            type->flags = GUEST_STATE_ELEMENT_TYPE_FLAG_READ_ONLY |
+                          GUEST_STATE_ELEMENT_TYPE_FLAG_GUEST_WIDE;
+    }
+}
+
+
 static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
                                              SpaprMachineState *spapr,
                                              target_ulong opcode,
@@ -658,4 +1139,10 @@ void spapr_register_nested_phyp(void)
 {
     /* DO NOTHING */
 }
+
+void init_nested(void)
+{
+    /* DO NOTHING */
+}
+
 #endif
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index e095c002dc..d7acc28d17 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -33,6 +33,8 @@ struct ppc_tb_t {
     QEMUTimer *decr_timer;
     /* Hypervisor decrementer management */
     uint64_t hdecr_next;    /* Tick for next hdecr interrupt  */
+    /* TB that HDEC should fire and return ctrl back to the Host partition */
+    uint64_t hdecr_expiry_tb;
     QEMUTimer *hdecr_timer;
     int64_t purr_offset;
     void *opaque;
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 2e8c6ba1ca..3c0d6a486e 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -200,6 +200,95 @@
 /* Nested PAPR API macros */
 #define NESTED_GUEST_MAX 4096
 #define NESTED_GUEST_VCPU_MAX 2048
+#define VCPU_OUT_BUF_MIN_SZ   0x80ULL
+#define HVMASK_DEFAULT        0xffffffffffffffff
+#define HVMASK_LPCR           0x0070000003820800 /* BE format */
+#define HVMASK_MSR            0xEBFFFFFFFFBFEFFF
+#define HVMASK_HDEXCR         0x00000000FFFFFFFF
+#define HVMASK_TB_OFFSET      0x000000FFFFFFFFFF
+
+#define GUEST_STATE_ELEMENT(i, sz, s, f, ptr, c) { \
+    .id = (i),                                     \
+    .size = (sz),                                  \
+    .location = ptr,                               \
+    .offset = offsetof(struct s, f),               \
+    .copy = (c)                                    \
+}
+
+#define GSBE_NESTED(i, sz, f, c) {                             \
+    .id = (i),                                                 \
+    .size = (sz),                                              \
+    .location = get_guest_ptr,                                 \
+    .offset = offsetof(struct SpaprMachineStateNestedGuest, f),\
+    .copy = (c),                                               \
+    .mask = HVMASK_DEFAULT                                     \
+}
+
+#define GSBE_NESTED_MSK(i, sz, f, c, m) {                      \
+    .id = (i),                                                 \
+    .size = (sz),                                              \
+    .location = get_guest_ptr,                                 \
+    .offset = offsetof(struct SpaprMachineStateNestedGuest, f),\
+    .copy = (c),                                               \
+    .mask = (m)                                                \
+}
+
+#define GSBE_NESTED_VCPU(i, sz, f, c) {                            \
+    .id = (i),                                                     \
+    .size = (sz),                                                  \
+    .location = get_vcpu_ptr,                                      \
+    .offset = offsetof(struct SpaprMachineStateNestedGuestVcpu, f),\
+    .copy = (c),                                                   \
+    .mask = HVMASK_DEFAULT                                         \
+}
+
+#define GUEST_STATE_ELEMENT_NOP(i, sz) { \
+    .id = (i),                             \
+    .size = (sz),                          \
+    .location = NULL,                      \
+    .offset = 0,                           \
+    .copy = NULL,                          \
+    .mask = HVMASK_DEFAULT                 \
+}
+
+#define GUEST_STATE_ELEMENT_NOP_DW(i)   \
+        GUEST_STATE_ELEMENT_NOP(i, 8)
+#define GUEST_STATE_ELEMENT_NOP_W(i) \
+        GUEST_STATE_ELEMENT_NOP(i, 4)
+
+#define GUEST_STATE_ELEMENT_ENV_BASE(i, s, c) {  \
+            .id = (i),                           \
+            .size = (s),                         \
+            .location = get_vcpu_env_ptr,        \
+            .offset = 0,                         \
+            .copy = (c),                         \
+            .mask = HVMASK_DEFAULT               \
+    }
+
+#define GUEST_STATE_ELEMENT_ENV(i, s, f, c) {    \
+            .id = (i),                           \
+            .size = (s),                         \
+            .location = get_vcpu_env_ptr,        \
+            .offset = offsetof(CPUPPCState, f),  \
+            .copy = (c),                         \
+            .mask = HVMASK_DEFAULT               \
+    }
+
+#define GUEST_STATE_ELEMENT_MSK(i, s, f, c, m) { \
+            .id = (i),                           \
+            .size = (s),                         \
+            .location = get_vcpu_env_ptr,        \
+            .offset = offsetof(CPUPPCState, f),  \
+            .copy = (c),                         \
+            .mask = (m)                          \
+    }
+
+#define GUEST_STATE_ELEMENT_ENV_DW(i, f) \
+    GUEST_STATE_ELEMENT_ENV(i, 8, f, copy_state_8to8)
+#define GUEST_STATE_ELEMENT_ENV_W(i, f) \
+    GUEST_STATE_ELEMENT_ENV(i, 4, f, copy_state_4to8)
+#define GSE_ENV_DWM(i, f, m) \
+    GUEST_STATE_ELEMENT_MSK(i, 8, f, copy_state_8to8, m)
 
 typedef struct SpaprMachineStateNestedGuest {
     unsigned long vcpus;
@@ -235,6 +324,18 @@ typedef struct SpaprMachineStateNestedGuestVcpu {
     int64_t dec_expiry_tb;
 } SpaprMachineStateNestedGuestVcpu;
 
+struct guest_state_element_type {
+    uint16_t id;
+    int size;
+#define GUEST_STATE_ELEMENT_TYPE_FLAG_GUEST_WIDE 0x1
+#define GUEST_STATE_ELEMENT_TYPE_FLAG_READ_ONLY  0x2
+   uint16_t flags;
+    void *(*location)(SpaprMachineStateNestedGuest *, target_ulong);
+    size_t offset;
+    void (*copy)(void *, void *, bool);
+    uint64_t mask;
+};
+
 /*
  * Register state for entering a nested guest with H_ENTER_NESTED.
  * New member must be added at the end.
@@ -345,5 +446,6 @@ struct nested_ppc_state {
 void spapr_register_nested(void);
 void spapr_register_nested_phyp(void);
 void spapr_exit_nested(PowerPCCPU *cpu, int excp);
+void init_nested(void);
 
 #endif /* HW_SPAPR_NESTED_H */
-- 
2.39.3



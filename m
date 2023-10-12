Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8866C7C6B7B
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 12:51:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqtHG-0001GR-FM; Thu, 12 Oct 2023 06:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtH8-00018h-BE; Thu, 12 Oct 2023 06:50:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtH2-00051t-MJ; Thu, 12 Oct 2023 06:50:41 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CAlLmW003553; Thu, 12 Oct 2023 10:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=iIjqhAEBB6RIPV2ENe74SdPxcmID8RIFxIvO/OK9Xyk=;
 b=GywCirrWo9aVVWh8+KqXYz+dDiWKFEwwPIViItXHhZcARviUrSq6VfnieuLU30F3nUIX
 F4AMoaN+dtePmaRFOw/EIzfutFEoiBLt/l3MK65jq43ri942qnwUGPkwU+a98XXo7ylL
 InQNDbpQxwRBCfvbHnGQ+p0F77tjAdHL7iIrqPPRa75bi6OviCjTPZgZfxwbV9yxqgHl
 6hWsGB0PRlTyNgH/1//yGkMQXR5VzkKJjOFdYIqF47adyxr283Rh/QBNc5s7JvtmsvPT
 /kGUwvgH8ed+tXh13inFJSLvTWsaUrbr4mjlD+qhIWu3LXeeSMN3ln1LD9ID5B8asdLm DA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpfbqr2q4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:32 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CAoTqe016772;
 Thu, 12 Oct 2023 10:50:32 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpfbqr2p5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:32 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39C9sfla025927; Thu, 12 Oct 2023 10:50:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkjnnpx9c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CAoQU344892538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 10:50:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80FB02004B;
 Thu, 12 Oct 2023 10:50:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1662120040;
 Thu, 12 Oct 2023 10:50:24 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 10:50:23 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, qemu-devel@nongnu.org, mikey@neuling.org,
 vaibhav@linux.ibm.com, jniethe5@gmail.com, sbhat@linux.ibm.com,
 kconsul@linux.vnet.ibm.com, danielhb413@gmail.com
Subject: [PATCH v2 09/14] spapr: nested: Initialize the GSB elements lookup
 table.
Date: Thu, 12 Oct 2023 16:19:46 +0530
Message-Id: <20231012104951.194876-10-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231012104951.194876-1-harshpb@linux.ibm.com>
References: <20231012104951.194876-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8dw7TZ05Z5qpQ1ZKJZxR1qimystziYbz
X-Proofpoint-ORIG-GUID: VWrpiTZX78mOtVc5kj6QZpV_RV4t1seg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120088
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Nested PAPR API provides a standard Guest State Buffer (GSB) format
with unique IDs for each guest state element for which get/set state is
supported by the API. Some of the elements are read-only and/or guest-wide.
Introducing helper routines for state exchange of each of the nested guest
state elements for which get/set state should be supported by the API.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr_caps.c           |   1 +
 hw/ppc/spapr_nested.c         | 500 +++++++++++++++++++++++++++++++++-
 include/hw/ppc/spapr_nested.h | 299 ++++++++++++++++++++
 target/ppc/cpu.h              |   2 +
 4 files changed, 799 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index ed3e638334..1d57d1b7c8 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -514,6 +514,7 @@ static void cap_nested_papr_apply(SpaprMachineState *spapr,
     if (!spapr->nested.api) {
         spapr->nested.api = NESTED_API_PAPR;
         spapr_register_nested_papr();
+        spapr_nested_gsb_init();
     } else {
         error_setg(errp, "Nested-HV APIs are mutually exclusive/incompatible");
         error_append_hint(errp, "Please use either cap-nested-hv or "
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index b38116b7c3..8f4152bd54 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -422,7 +422,7 @@ SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
 }
 
 static bool spapr_nested_vcpu_check(SpaprMachineStateNestedGuest *guest,
-                                    target_ulong vcpuid)
+                                    target_ulong vcpuid, bool inoutbuf)
 {
     struct SpaprMachineStateNestedGuestVcpu *vcpu;
     /*
@@ -443,7 +443,495 @@ static bool spapr_nested_vcpu_check(SpaprMachineStateNestedGuest *guest,
         return false;
     }
 
-    return true;
+    if (!inoutbuf) {
+        return true;
+    }
+
+    /* Check to see if the in/out buffers are registered */
+    if (vcpu->runbufin.addr && vcpu->runbufout.addr) {
+        return true;
+    }
+
+    return false;
+}
+
+static void *get_vcpu_env_ptr(SpaprMachineStateNestedGuest *guest,
+                              target_ulong vcpuid)
+{
+    assert(spapr_nested_vcpu_check(guest, vcpuid, false));
+    return &guest->vcpu[vcpuid].env;
+}
+
+static void *get_vcpu_ptr(SpaprMachineStateNestedGuest *guest,
+                                   target_ulong vcpuid)
+{
+    assert(spapr_nested_vcpu_check(guest, vcpuid, false));
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
+    uint64_t *hdecr_expiry_tb;
+
+    hdecr_expiry_tb = a;
+    buf = b;
+
+    if (!set) {
+        buf[0] = cpu_to_be64(*hdecr_expiry_tb);
+        return;
+    }
+
+    *hdecr_expiry_tb = be64_to_cpu(buf[0]);
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
+    GSBE_NESTED_VCPU(GSB_VCPU_HDEC_EXPIRY_TB, 0x8, hdecr_expiry_tb,
+                     copy_state_hdecr),
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
+    GUEST_STATE_ELEMENT_ENV_BASE(GSB_VCPU_SPR_VSCR,  4, copy_state_vscr),
+    GUEST_STATE_ELEMENT_ENV_BASE(GSB_VCPU_SPR_FPSCR, 8, copy_state_fpscr)
+};
+
+void spapr_nested_gsb_init(void)
+{
+    struct guest_state_element_type *type;
+
+    /* Init the guest state elements lookup table, flags for now */
+    for (int i = 0; i < ARRAY_SIZE(guest_state_element_types); i++) {
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
 }
 
 static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
@@ -669,7 +1157,7 @@ static target_ulong h_guest_create_vcpu(PowerPCCPU *cpu,
     cpu_ppc_tb_init(l2env, SPAPR_TIMEBASE_FREQ);
     guest->vcpu[vcpuid].enabled = true;
 
-    if (!spapr_nested_vcpu_check(guest, vcpuid)) {
+    if (!spapr_nested_vcpu_check(guest, vcpuid, false)) {
         return H_PARAMETER;
     }
     return H_SUCCESS;
@@ -707,4 +1195,10 @@ void spapr_register_nested_papr(void)
 {
     /* DO NOTHING */
 }
+
+void spapr_nested_gsb_init(void)
+{
+    /* DO NOTHING */
+}
+
 #endif
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 91cb744a5b..9b647c0389 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -4,6 +4,191 @@
 #include "qemu/osdep.h"
 #include "target/ppc/cpu.h"
 
+/* Guest State Buffer Element IDs */
+#define GSB_HV_VCPU_IGNORED_ID  0x0000 /* An element whose value is ignored */
+#define GSB_HV_VCPU_STATE_SIZE  0x0001 /* HV internal format VCPU state size */
+#define GSB_VCPU_OUT_BUF_MIN_SZ 0x0002 /* Min size of the Run VCPU o/p buffer */
+#define GSB_VCPU_LPVR           0x0003 /* Logical PVR */
+#define GSB_TB_OFFSET           0x0004 /* Timebase Offset */
+#define GSB_PART_SCOPED_PAGETBL 0x0005 /* Partition Scoped Page Table */
+#define GSB_PROCESS_TBL         0x0006 /* Process Table */
+                    /* RESERVED 0x0007 - 0x0BFF */
+#define GSB_VCPU_IN_BUFFER      0x0C00 /* Run VCPU Input Buffer */
+#define GSB_VCPU_OUT_BUFFER     0x0C01 /* Run VCPU Out Buffer */
+#define GSB_VCPU_VPA            0x0C02 /* HRA to Guest VCPU VPA */
+                    /* RESERVED 0x0C03 - 0x0FFF */
+#define GSB_VCPU_GPR0           0x1000
+#define GSB_VCPU_GPR1           0x1001
+#define GSB_VCPU_GPR2           0x1002
+#define GSB_VCPU_GPR3           0x1003
+#define GSB_VCPU_GPR4           0x1004
+#define GSB_VCPU_GPR5           0x1005
+#define GSB_VCPU_GPR6           0x1006
+#define GSB_VCPU_GPR7           0x1007
+#define GSB_VCPU_GPR8           0x1008
+#define GSB_VCPU_GPR9           0x1009
+#define GSB_VCPU_GPR10          0x100A
+#define GSB_VCPU_GPR11          0x100B
+#define GSB_VCPU_GPR12          0x100C
+#define GSB_VCPU_GPR13          0x100D
+#define GSB_VCPU_GPR14          0x100E
+#define GSB_VCPU_GPR15          0x100F
+#define GSB_VCPU_GPR16          0x1010
+#define GSB_VCPU_GPR17          0x1011
+#define GSB_VCPU_GPR18          0x1012
+#define GSB_VCPU_GPR19          0x1013
+#define GSB_VCPU_GPR20          0x1014
+#define GSB_VCPU_GPR21          0x1015
+#define GSB_VCPU_GPR22          0x1016
+#define GSB_VCPU_GPR23          0x1017
+#define GSB_VCPU_GPR24          0x1018
+#define GSB_VCPU_GPR25          0x1019
+#define GSB_VCPU_GPR26          0x101A
+#define GSB_VCPU_GPR27          0x101B
+#define GSB_VCPU_GPR28          0x101C
+#define GSB_VCPU_GPR29          0x101D
+#define GSB_VCPU_GPR30          0x101E
+#define GSB_VCPU_GPR31          0x101F
+#define GSB_VCPU_HDEC_EXPIRY_TB 0x1020
+#define GSB_VCPU_SPR_NIA        0x1021
+#define GSB_VCPU_SPR_MSR        0x1022
+#define GSB_VCPU_SPR_LR         0x1023
+#define GSB_VCPU_SPR_XER        0x1024
+#define GSB_VCPU_SPR_CTR        0x1025
+#define GSB_VCPU_SPR_CFAR       0x1026
+#define GSB_VCPU_SPR_SRR0       0x1027
+#define GSB_VCPU_SPR_SRR1       0x1028
+#define GSB_VCPU_SPR_DAR        0x1029
+#define GSB_VCPU_DEC_EXPIRE_TB  0x102A
+#define GSB_VCPU_SPR_VTB        0x102B
+#define GSB_VCPU_SPR_LPCR       0x102C
+#define GSB_VCPU_SPR_HFSCR      0x102D
+#define GSB_VCPU_SPR_FSCR       0x102E
+#define GSB_VCPU_SPR_FPSCR      0x102F
+#define GSB_VCPU_SPR_DAWR0      0x1030
+#define GSB_VCPU_SPR_DAWR1      0x1031
+#define GSB_VCPU_SPR_CIABR      0x1032
+#define GSB_VCPU_SPR_PURR       0x1033
+#define GSB_VCPU_SPR_SPURR      0x1034
+#define GSB_VCPU_SPR_IC         0x1035
+#define GSB_VCPU_SPR_SPRG0      0x1036
+#define GSB_VCPU_SPR_SPRG1      0x1037
+#define GSB_VCPU_SPR_SPRG2      0x1038
+#define GSB_VCPU_SPR_SPRG3      0x1039
+#define GSB_VCPU_SPR_PPR        0x103A
+#define GSB_VCPU_SPR_MMCR0      0x103B
+#define GSB_VCPU_SPR_MMCR1      0x103C
+#define GSB_VCPU_SPR_MMCR2      0x103D
+#define GSB_VCPU_SPR_MMCR3      0x103E
+#define GSB_VCPU_SPR_MMCRA      0x103F
+#define GSB_VCPU_SPR_SIER       0x1040
+#define GSB_VCPU_SPR_SIER2      0x1041
+#define GSB_VCPU_SPR_SIER3      0x1042
+#define GSB_VCPU_SPR_BESCR      0x1043
+#define GSB_VCPU_SPR_EBBHR      0x1044
+#define GSB_VCPU_SPR_EBBRR      0x1045
+#define GSB_VCPU_SPR_AMR        0x1046
+#define GSB_VCPU_SPR_IAMR       0x1047
+#define GSB_VCPU_SPR_AMOR       0x1048
+#define GSB_VCPU_SPR_UAMOR      0x1049
+#define GSB_VCPU_SPR_SDAR       0x104A
+#define GSB_VCPU_SPR_SIAR       0x104B
+#define GSB_VCPU_SPR_DSCR       0x104C
+#define GSB_VCPU_SPR_TAR        0x104D
+#define GSB_VCPU_SPR_DEXCR      0x104E
+#define GSB_VCPU_SPR_HDEXCR     0x104F
+#define GSB_VCPU_SPR_HASHKEYR   0x1050
+#define GSB_VCPU_SPR_HASHPKEYR  0x1051
+#define GSB_VCPU_SPR_CTRL       0x1052
+                    /* RESERVED 0x1053 - 0x1FFF */
+#define GSB_VCPU_SPR_CR         0x2000
+#define GSB_VCPU_SPR_PIDR       0x2001
+#define GSB_VCPU_SPR_DSISR      0x2002
+#define GSB_VCPU_SPR_VSCR       0x2003
+#define GSB_VCPU_SPR_VRSAVE     0x2004
+#define GSB_VCPU_SPR_DAWRX0     0x2005
+#define GSB_VCPU_SPR_DAWRX1     0x2006
+#define GSB_VCPU_SPR_PMC1       0x2007
+#define GSB_VCPU_SPR_PMC2       0x2008
+#define GSB_VCPU_SPR_PMC3       0x2009
+#define GSB_VCPU_SPR_PMC4       0x200A
+#define GSB_VCPU_SPR_PMC5       0x200B
+#define GSB_VCPU_SPR_PMC6       0x200C
+#define GSB_VCPU_SPR_WORT       0x200D
+#define GSB_VCPU_SPR_PSPB       0x200E
+                    /* RESERVED 0x200F - 0x2FFF */
+#define GSB_VCPU_SPR_VSR0       0x3000
+#define GSB_VCPU_SPR_VSR1       0x3001
+#define GSB_VCPU_SPR_VSR2       0x3002
+#define GSB_VCPU_SPR_VSR3       0x3003
+#define GSB_VCPU_SPR_VSR4       0x3004
+#define GSB_VCPU_SPR_VSR5       0x3005
+#define GSB_VCPU_SPR_VSR6       0x3006
+#define GSB_VCPU_SPR_VSR7       0x3007
+#define GSB_VCPU_SPR_VSR8       0x3008
+#define GSB_VCPU_SPR_VSR9       0x3009
+#define GSB_VCPU_SPR_VSR10      0x300A
+#define GSB_VCPU_SPR_VSR11      0x300B
+#define GSB_VCPU_SPR_VSR12      0x300C
+#define GSB_VCPU_SPR_VSR13      0x300D
+#define GSB_VCPU_SPR_VSR14      0x300E
+#define GSB_VCPU_SPR_VSR15      0x300F
+#define GSB_VCPU_SPR_VSR16      0x3010
+#define GSB_VCPU_SPR_VSR17      0x3011
+#define GSB_VCPU_SPR_VSR18      0x3012
+#define GSB_VCPU_SPR_VSR19      0x3013
+#define GSB_VCPU_SPR_VSR20      0x3014
+#define GSB_VCPU_SPR_VSR21      0x3015
+#define GSB_VCPU_SPR_VSR22      0x3016
+#define GSB_VCPU_SPR_VSR23      0x3017
+#define GSB_VCPU_SPR_VSR24      0x3018
+#define GSB_VCPU_SPR_VSR25      0x3019
+#define GSB_VCPU_SPR_VSR26      0x301A
+#define GSB_VCPU_SPR_VSR27      0x301B
+#define GSB_VCPU_SPR_VSR28      0x301C
+#define GSB_VCPU_SPR_VSR29      0x301D
+#define GSB_VCPU_SPR_VSR30      0x301E
+#define GSB_VCPU_SPR_VSR31      0x301F
+#define GSB_VCPU_SPR_VSR32      0x3020
+#define GSB_VCPU_SPR_VSR33      0x3021
+#define GSB_VCPU_SPR_VSR34      0x3022
+#define GSB_VCPU_SPR_VSR35      0x3023
+#define GSB_VCPU_SPR_VSR36      0x3024
+#define GSB_VCPU_SPR_VSR37      0x3025
+#define GSB_VCPU_SPR_VSR38      0x3026
+#define GSB_VCPU_SPR_VSR39      0x3027
+#define GSB_VCPU_SPR_VSR40      0x3028
+#define GSB_VCPU_SPR_VSR41      0x3029
+#define GSB_VCPU_SPR_VSR42      0x302A
+#define GSB_VCPU_SPR_VSR43      0x302B
+#define GSB_VCPU_SPR_VSR44      0x302C
+#define GSB_VCPU_SPR_VSR45      0x302D
+#define GSB_VCPU_SPR_VSR46      0x302E
+#define GSB_VCPU_SPR_VSR47      0x302F
+#define GSB_VCPU_SPR_VSR48      0x3030
+#define GSB_VCPU_SPR_VSR49      0x3031
+#define GSB_VCPU_SPR_VSR50      0x3032
+#define GSB_VCPU_SPR_VSR51      0x3033
+#define GSB_VCPU_SPR_VSR52      0x3034
+#define GSB_VCPU_SPR_VSR53      0x3035
+#define GSB_VCPU_SPR_VSR54      0x3036
+#define GSB_VCPU_SPR_VSR55      0x3037
+#define GSB_VCPU_SPR_VSR56      0x3038
+#define GSB_VCPU_SPR_VSR57      0x3039
+#define GSB_VCPU_SPR_VSR58      0x303A
+#define GSB_VCPU_SPR_VSR59      0x303B
+#define GSB_VCPU_SPR_VSR60      0x303C
+#define GSB_VCPU_SPR_VSR61      0x303D
+#define GSB_VCPU_SPR_VSR62      0x303E
+#define GSB_VCPU_SPR_VSR63      0x303F
+                    /* RESERVED 0x3040 - 0xEFFF */
+#define GSB_VCPU_SPR_HDAR       0xF000
+#define GSB_VCPU_SPR_HDSISR     0xF001
+#define GSB_VCPU_SPR_HEIR       0xF002
+#define GSB_VCPU_SPR_ASDR       0xF003
+/* End of list of Guest State Buffer Element IDs */
+#define GSB_LAST                GSB_VCPU_SPR_ASDR
+
 typedef struct SpaprMachineStateNested {
     uint64_t ptcr;
     uint8_t api;
@@ -17,14 +202,38 @@ typedef struct SpaprMachineStateNested {
 typedef struct SpaprMachineStateNestedGuest {
     uint32_t pvr_logical;
     unsigned long vcpus;
+    uint64_t parttbl[2];
+    uint64_t tb_offset;
     struct SpaprMachineStateNestedGuestVcpu *vcpu;
 } SpaprMachineStateNestedGuest;
 
+struct SpaprMachineStateNestedGuestVcpuRunBuf {
+    uint64_t addr;
+    uint64_t size;
+};
+
 typedef struct SpaprMachineStateNestedGuestVcpu {
     bool enabled;
+    struct SpaprMachineStateNestedGuestVcpuRunBuf runbufin;
+    struct SpaprMachineStateNestedGuestVcpuRunBuf runbufout;
     CPUPPCState env;
+    int64_t tb_offset;
+    int64_t dec_expiry_tb;
+    uint64_t hdecr_expiry_tb;
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
 /* Nested PAPR API related macros */
 #define H_GUEST_CAPABILITIES_COPY_MEM 0x8000000000000000
 #define H_GUEST_CAPABILITIES_P9_MODE  0x4000000000000000
@@ -35,6 +244,95 @@ typedef struct SpaprMachineStateNestedGuestVcpu {
 #define PAPR_NESTED_GUEST_MAX         4096
 #define H_GUEST_DELETE_ALL_FLAG       0x8000000000000000ULL
 #define PAPR_NESTED_GUEST_VCPU_MAX    2048
+#define VCPU_OUT_BUF_MIN_SZ           0x80ULL
+#define HVMASK_DEFAULT                0xffffffffffffffff
+#define HVMASK_LPCR                   0x0070000003820800
+#define HVMASK_MSR                    0xEBFFFFFFFFBFEFFF
+#define HVMASK_HDEXCR                 0x00000000FFFFFFFF
+#define HVMASK_TB_OFFSET              0x000000FFFFFFFFFF
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
 
 /*
  * Register state for entering a nested guest with H_ENTER_NESTED.
@@ -135,4 +433,5 @@ bool spapr_get_pate_nested(SpaprMachineState *spapr, PowerPCCPU *cpu,
                            target_ulong lpid, ppc_v3_pate_t *entry);
 void spapr_register_nested_papr(void);
 void spapr_nested_init(SpaprMachineState *spapr);
+void spapr_nested_gsb_init(void);
 #endif /* HW_SPAPR_NESTED_H */
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 30392ebeee..e3f0bca573 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1596,9 +1596,11 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_PSPB              (0x09F)
 #define SPR_DPDES             (0x0B0)
 #define SPR_DAWR0             (0x0B4)
+#define SPR_DAWR1             (0x0B5)
 #define SPR_RPR               (0x0BA)
 #define SPR_CIABR             (0x0BB)
 #define SPR_DAWRX0            (0x0BC)
+#define SPR_DAWRX1            (0x0BD)
 #define SPR_HFSCR             (0x0BE)
 #define SPR_VRSAVE            (0x100)
 #define SPR_USPRG0            (0x100)
-- 
2.39.3



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4B5748BF8
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 20:35:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH7Kw-0007Xt-Tz; Wed, 05 Jul 2023 14:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1qH7Kr-0007UY-9j
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 14:34:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1qH7Kp-000539-05
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 14:34:41 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 365HxvlV001158; Wed, 5 Jul 2023 18:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=qcppdkim1; bh=ap39a9nRuE6+vvU0U6bWmjvuMjuR8aKrNtil6rIYeGw=;
 b=WNw6uNDo22KG7Vtu1hmOuhWNKdbVh5Gwf+HFtlXXbI0TijsI45woc560pj4wC+1mPMoH
 0IdSVwFfhhsKgGnkpRuhrfuuFuGLabtILTlGpLKZlxumnAMody83XOOzcv9ORNNNe3ak
 WMaENWNJ8BrB3MxaustahOkAIi4fQb+P/ODVP8mY+GX3BfYgaNz2lD+48BUJkK5ysPvR
 66TzuWVsiJmHlEw8VU+XR2mI+DCBK2GMbR/Lmpi9bJ6LeqTsnw9sGXs1Adn3geISMgFK
 HYg/0REe3JNWLeZF3EBDCWsAWJjKq74Ztx3iRmbVz489WxP8polw22Nxur/It6S7KDJA BA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rmxy91yy6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 18:34:33 +0000
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 365IYWux005348; 
 Wed, 5 Jul 2023 18:34:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rjd7my3jj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 18:34:32 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 365IYWns005342;
 Wed, 5 Jul 2023 18:34:32 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-mathbern-lv.qualcomm.com
 [10.47.235.147])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 365IYVcA005340
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 18:34:32 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 4229910)
 id C8E86780D; Wed,  5 Jul 2023 15:34:31 -0300 (-03)
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: qemu-devel@nongnu.org
Cc: quic_mathbern@quicinc.com, bcain@quicinc.com, ltaylorsimpson@gmail.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org
Subject: [PATCH v2] Hexagon: move GETPC() calls to top level helpers
Date: Wed,  5 Jul 2023 15:34:30 -0300
Message-Id: <93a2ca786530cbc8a94f7c7a6451f4f1f47c8a9b.1688581908.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 0np-aZ5WGbdaehNOWNK-zONFEcoRbwik
X-Proofpoint-ORIG-GUID: 0np-aZ5WGbdaehNOWNK-zONFEcoRbwik
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_09,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307050169
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mathbern@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

As docs/devel/loads-stores.rst states:

  ``GETPC()`` should be used with great care: calling
  it in other functions that are *not* the top level
  ``HELPER(foo)`` will cause unexpected behavior. Instead, the
  value of ``GETPC()`` should be read from the helper and passed
  if needed to the functions that the helper calls.

Let's fix the GETPC() usage in Hexagon, making sure it's always called
from top level helpers and passed down to the places where it's
needed. There are two snippets where that is not currently the case:

- probe_store(), which is only called from two helpers, so it's easy to
  move GETPC() up.

- mem_load*() functions, which are also called directly from helpers,
  but through the MEM_LOAD*() set of macros. Note that this are only
  used when compiling with --disable-hexagon-idef-parser.

  In this case, we also take this opportunity to simplify the code,
  unifying the mem_load*() functions.

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
---
v1: d40fabcf9d6e92e4cd8d6a144e9b2a9acf4580dc.1688420966.git.quic_mathbern@quicinc.com

Changes in v2:
- Fixed wrong cpu_ld* unification from previous version.
- Passed retaddr down to check_noshuf() and further, as Taylor
  suggested.
- Reorganized macros for simplification.

 target/hexagon/macros.h    | 19 ++++++------
 target/hexagon/op_helper.h | 11 ++-----
 target/hexagon/op_helper.c | 62 +++++++++++---------------------------
 3 files changed, 29 insertions(+), 63 deletions(-)

diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index 5451b061ee..e44a932434 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -173,15 +173,6 @@
 #define MEM_STORE8(VA, DATA, SLOT) \
     MEM_STORE8_FUNC(DATA)(cpu_env, VA, DATA, SLOT)
 #else
-#define MEM_LOAD1s(VA) ((int8_t)mem_load1(env, pkt_has_store_s1, slot, VA))
-#define MEM_LOAD1u(VA) ((uint8_t)mem_load1(env, pkt_has_store_s1, slot, VA))
-#define MEM_LOAD2s(VA) ((int16_t)mem_load2(env, pkt_has_store_s1, slot, VA))
-#define MEM_LOAD2u(VA) ((uint16_t)mem_load2(env, pkt_has_store_s1, slot, VA))
-#define MEM_LOAD4s(VA) ((int32_t)mem_load4(env, pkt_has_store_s1, slot, VA))
-#define MEM_LOAD4u(VA) ((uint32_t)mem_load4(env, pkt_has_store_s1, slot, VA))
-#define MEM_LOAD8s(VA) ((int64_t)mem_load8(env, pkt_has_store_s1, slot, VA))
-#define MEM_LOAD8u(VA) ((uint64_t)mem_load8(env, pkt_has_store_s1, slot, VA))
-
 #define MEM_STORE1(VA, DATA, SLOT) log_store32(env, VA, DATA, 1, SLOT)
 #define MEM_STORE2(VA, DATA, SLOT) log_store32(env, VA, DATA, 2, SLOT)
 #define MEM_STORE4(VA, DATA, SLOT) log_store32(env, VA, DATA, 4, SLOT)
@@ -530,8 +521,16 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
 #ifdef QEMU_GENERATE
 #define fLOAD(NUM, SIZE, SIGN, EA, DST) MEM_LOAD##SIZE##SIGN(DST, EA)
 #else
+#define MEM_LOAD1 cpu_ldub_data_ra
+#define MEM_LOAD2 cpu_lduw_data_ra
+#define MEM_LOAD4 cpu_ldl_data_ra
+#define MEM_LOAD8 cpu_ldq_data_ra
+
 #define fLOAD(NUM, SIZE, SIGN, EA, DST) \
-    DST = (size##SIZE##SIGN##_t)MEM_LOAD##SIZE##SIGN(EA)
+    DST =  (size##SIZE##SIGN##_t)({ \
+        check_noshuf(env, pkt_has_store_s1, slot, EA, SIZE, GETPC()); \
+        MEM_LOAD##SIZE(env, EA, GETPC()); \
+    })
 #endif
 
 #define fMEMOP(NUM, SIZE, SIGN, EA, FNTYPE, VALUE)
diff --git a/target/hexagon/op_helper.h b/target/hexagon/op_helper.h
index 8f3764d15e..7744e819ef 100644
--- a/target/hexagon/op_helper.h
+++ b/target/hexagon/op_helper.h
@@ -19,15 +19,8 @@
 #define HEXAGON_OP_HELPER_H
 
 /* Misc functions */
-uint8_t mem_load1(CPUHexagonState *env, bool pkt_has_store_s1,
-                  uint32_t slot, target_ulong vaddr);
-uint16_t mem_load2(CPUHexagonState *env, bool pkt_has_store_s1,
-                   uint32_t slot, target_ulong vaddr);
-uint32_t mem_load4(CPUHexagonState *env, bool pkt_has_store_s1,
-                   uint32_t slot, target_ulong vaddr);
-uint64_t mem_load8(CPUHexagonState *env, bool pkt_has_store_s1,
-                   uint32_t slot, target_ulong vaddr);
-
+void check_noshuf(CPUHexagonState *env, bool pkt_has_store_s1,
+                  uint32_t slot, target_ulong vaddr, int size, uintptr_t ra);
 void log_store64(CPUHexagonState *env, target_ulong addr,
                  int64_t val, int width, int slot);
 void log_store32(CPUHexagonState *env, target_ulong addr,
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 12967ac21e..abc9fc4724 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -95,9 +95,8 @@ void HELPER(debug_check_store_width)(CPUHexagonState *env, int slot, int check)
     }
 }
 
-void HELPER(commit_store)(CPUHexagonState *env, int slot_num)
+static void commit_store(CPUHexagonState *env, int slot_num, uintptr_t ra)
 {
-    uintptr_t ra = GETPC();
     uint8_t width = env->mem_log_stores[slot_num].width;
     target_ulong va = env->mem_log_stores[slot_num].va;
 
@@ -119,6 +118,12 @@ void HELPER(commit_store)(CPUHexagonState *env, int slot_num)
     }
 }
 
+void HELPER(commit_store)(CPUHexagonState *env, int slot_num)
+{
+    uintptr_t ra = GETPC();
+    commit_store(env, slot_num, ra);
+}
+
 void HELPER(gather_store)(CPUHexagonState *env, uint32_t addr, int slot)
 {
     mem_gather_store(env, addr, slot);
@@ -467,13 +472,12 @@ int32_t HELPER(cabacdecbin_pred)(int64_t RssV, int64_t RttV)
 }
 
 static void probe_store(CPUHexagonState *env, int slot, int mmu_idx,
-                        bool is_predicated)
+                        bool is_predicated, uintptr_t retaddr)
 {
     if (!is_predicated || !(env->slot_cancelled & (1 << slot))) {
         size1u_t width = env->mem_log_stores[slot].width;
         target_ulong va = env->mem_log_stores[slot].va;
-        uintptr_t ra = GETPC();
-        probe_write(env, va, width, mmu_idx, ra);
+        probe_write(env, va, width, mmu_idx, retaddr);
     }
 }
 
@@ -494,7 +498,8 @@ void HELPER(probe_pkt_scalar_store_s0)(CPUHexagonState *env, int args)
     int mmu_idx = FIELD_EX32(args, PROBE_PKT_SCALAR_STORE_S0, MMU_IDX);
     bool is_predicated =
         FIELD_EX32(args, PROBE_PKT_SCALAR_STORE_S0, IS_PREDICATED);
-    probe_store(env, 0, mmu_idx, is_predicated);
+    uintptr_t ra = GETPC();
+    probe_store(env, 0, mmu_idx, is_predicated, ra);
 }
 
 void HELPER(probe_hvx_stores)(CPUHexagonState *env, int mmu_idx)
@@ -547,12 +552,13 @@ void HELPER(probe_pkt_scalar_hvx_stores)(CPUHexagonState *env, int mask)
     bool s0_is_pred = FIELD_EX32(mask, PROBE_PKT_SCALAR_HVX_STORES, S0_IS_PRED);
     bool s1_is_pred = FIELD_EX32(mask, PROBE_PKT_SCALAR_HVX_STORES, S1_IS_PRED);
     int mmu_idx = FIELD_EX32(mask, PROBE_PKT_SCALAR_HVX_STORES, MMU_IDX);
+    uintptr_t ra = GETPC();
 
     if (has_st0) {
-        probe_store(env, 0, mmu_idx, s0_is_pred);
+        probe_store(env, 0, mmu_idx, s0_is_pred, ra);
     }
     if (has_st1) {
-        probe_store(env, 1, mmu_idx, s1_is_pred);
+        probe_store(env, 1, mmu_idx, s1_is_pred, ra);
     }
     if (has_hvx_stores) {
         HELPER(probe_hvx_stores)(env, mmu_idx);
@@ -566,48 +572,16 @@ void HELPER(probe_pkt_scalar_hvx_stores)(CPUHexagonState *env, int mask)
  * If the load is in slot 0 and there is a store in slot1 (that
  * wasn't cancelled), we have to do the store first.
  */
-static void check_noshuf(CPUHexagonState *env, bool pkt_has_store_s1,
-                         uint32_t slot, target_ulong vaddr, int size)
+void check_noshuf(CPUHexagonState *env, bool pkt_has_store_s1,
+                  uint32_t slot, target_ulong vaddr, int size, uintptr_t ra)
 {
     if (slot == 0 && pkt_has_store_s1 &&
         ((env->slot_cancelled & (1 << 1)) == 0)) {
-        HELPER(probe_noshuf_load)(env, vaddr, size, MMU_USER_IDX);
-        HELPER(commit_store)(env, 1);
+        probe_read(env, vaddr, size, MMU_USER_IDX, ra);
+        commit_store(env, 1, ra);
     }
 }
 
-uint8_t mem_load1(CPUHexagonState *env, bool pkt_has_store_s1,
-                  uint32_t slot, target_ulong vaddr)
-{
-    uintptr_t ra = GETPC();
-    check_noshuf(env, pkt_has_store_s1, slot, vaddr, 1);
-    return cpu_ldub_data_ra(env, vaddr, ra);
-}
-
-uint16_t mem_load2(CPUHexagonState *env, bool pkt_has_store_s1,
-                   uint32_t slot, target_ulong vaddr)
-{
-    uintptr_t ra = GETPC();
-    check_noshuf(env, pkt_has_store_s1, slot, vaddr, 2);
-    return cpu_lduw_data_ra(env, vaddr, ra);
-}
-
-uint32_t mem_load4(CPUHexagonState *env, bool pkt_has_store_s1,
-                   uint32_t slot, target_ulong vaddr)
-{
-    uintptr_t ra = GETPC();
-    check_noshuf(env, pkt_has_store_s1, slot, vaddr, 4);
-    return cpu_ldl_data_ra(env, vaddr, ra);
-}
-
-uint64_t mem_load8(CPUHexagonState *env, bool pkt_has_store_s1,
-                   uint32_t slot, target_ulong vaddr)
-{
-    uintptr_t ra = GETPC();
-    check_noshuf(env, pkt_has_store_s1, slot, vaddr, 8);
-    return cpu_ldq_data_ra(env, vaddr, ra);
-}
-
 /* Floating point */
 float64 HELPER(conv_sf2df)(CPUHexagonState *env, float32 RsV)
 {
-- 
2.37.2



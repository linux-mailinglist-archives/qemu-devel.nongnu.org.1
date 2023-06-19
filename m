Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3B873596F
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:25:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFnK-0004FN-T7; Mon, 19 Jun 2023 10:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBFnH-0004ED-I5
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:23:47 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBFnF-0000lV-78
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:23:47 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f9b4a71623so3163855e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184623; x=1689776623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wYaXVLSy7te17IjoR6ZeNkrXoDozUSIUDyj3cihp+Jg=;
 b=GsMASvLtD8hdEgx+CsONDgKpyFnqmLl7DO3hlnrlkAPsJvr+yz8cwY3pQEzpF5xUg6
 KkAMdgHaeA6+9M8d94G2SSDBZMsQVyXk5JMQrA0cGFJYMO999wCQuVxQj0XBrzybaXxq
 XvyymparhakZzXWSYPcjM0yYCAfsy+lOiL7NCkJ149tdIWx6+5krMAJuiBlVjHAQHLkm
 hhDya6PFg2DcKo5xZ2EX39tr/brnwB5jtt0mKfacqV6Ijg/U85jTW3/9FT1G6IESmmIo
 Dfvqz8xOPYDSFoZcvwggxl/luMOPTVKZzID/cqKZd9WLxdUiKxZjj7V9x202RAHrQ9EK
 d6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184623; x=1689776623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wYaXVLSy7te17IjoR6ZeNkrXoDozUSIUDyj3cihp+Jg=;
 b=DomWEa1batAHo7yy458omcnOfpabpiQTK2nKeAcYyDL3hiocSZOmOMjGwYfUoWBp/M
 CCG/WS5Y+sSXHJbFOaxzBtJrE/jv8pSQvntv3uNifZW4tXp813CstTPfUdbmq4abAXy1
 LWoGCHeEEp+Pt6ZKexi0N7dk94kNjwYG9+wvkCxdCpI2Q7PkmiYBT5jgjk+NR/HXNbAO
 NTy7tAUSVT805/zWwKvwA5WGXn+5J3JA7xVEoQBbab5JFTlyoli+ndy2fN4d4cGj2DHN
 6rr95gMiyK4QnhknGF1Ec8yd5TTeLfT+ISI9YeD3Rpy7IPv+3v9rdvPFbboAAdt5jzPm
 IuGw==
X-Gm-Message-State: AC+VfDzpWf63MWFPfl5vrUwlRb+NZkUe71s14LzfJ7S1iu+Xi6KhWpBY
 MriEDPZ17jqYozaO4A8APiMkwxxV1zwBQMhZ3FxQ4uhD
X-Google-Smtp-Source: ACHHUZ5/xZLckgN4FrC9FX8SaOY2YjVLu6gT2sCmJHS1OvXMQ9oVZOm1LUAwFaeBepkUTNZ3aFP3Ow==
X-Received: by 2002:a05:600c:203:b0:3f7:f24b:b2ed with SMTP id
 3-20020a05600c020300b003f7f24bb2edmr6990245wmi.19.1687184622904; 
 Mon, 19 Jun 2023 07:23:42 -0700 (PDT)
Received: from stoup.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 k25-20020a7bc419000000b003f96d10eafbsm4143467wmi.12.2023.06.19.07.23.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:23:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/5] tcg: Add host memory barriers to cpu_ldst.h interfaces
Date: Mon, 19 Jun 2023 16:23:32 +0200
Message-Id: <20230619142333.429028-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142333.429028-1-richard.henderson@linaro.org>
References: <20230619142333.429028-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

Bring the helpers into line with the rest of tcg in respecting
guest memory ordering.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal.h  | 34 ++++++++++++++++++++++++++++++++++
 accel/tcg/cputlb.c    | 10 ++++++++++
 accel/tcg/user-exec.c | 10 ++++++++++
 3 files changed, 54 insertions(+)

diff --git a/accel/tcg/internal.h b/accel/tcg/internal.h
index 24f225cac7..be0c7753fb 100644
--- a/accel/tcg/internal.h
+++ b/accel/tcg/internal.h
@@ -78,4 +78,38 @@ extern int64_t max_advance;
 
 extern bool one_insn_per_tb;
 
+/**
+ * tcg_req_mo:
+ * @type: TCGBar
+ *
+ * Filter @type to the barrier that is required for the guest
+ * memory ordering vs the host memory ordering.  A non-zero
+ * result indicates that some barrier is required.
+ *
+ * If TCG_GUEST_DEFAULT_MO is not defined, assume that the
+ * guest requires strict ordering.
+ *
+ * This is a macro so that it's constant even without optimization.
+ */
+#ifdef TCG_GUEST_DEFAULT_MO
+# define tcg_req_mo(type) \
+    ((type) & TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO)
+#else
+# define tcg_req_mo(type) ((type) & ~TCG_TARGET_DEFAULT_MO)
+#endif
+
+/**
+ * cpu_req_mo:
+ * @type: TCGBar
+ *
+ * If tcg_req_mo indicates a barrier for @type is required
+ * for the guest memory model, issue a host memory barrier.
+ */
+#define cpu_req_mo(type)          \
+    do {                          \
+        if (tcg_req_mo(type)) {   \
+            smp_mb();             \
+        }                         \
+    } while (0)
+
 #endif /* ACCEL_TCG_INTERNAL_H */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5e2ca47243..a48e1c9693 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2342,6 +2342,7 @@ static uint8_t do_ld1_mmu(CPUArchState *env, target_ulong addr, MemOpIdx oi,
     MMULookupLocals l;
     bool crosspage;
 
+    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(env, addr, oi, ra, access_type, &l);
     tcg_debug_assert(!crosspage);
 
@@ -2363,6 +2364,7 @@ static uint16_t do_ld2_mmu(CPUArchState *env, target_ulong addr, MemOpIdx oi,
     uint16_t ret;
     uint8_t a, b;
 
+    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(env, addr, oi, ra, access_type, &l);
     if (likely(!crosspage)) {
         return do_ld_2(env, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
@@ -2393,6 +2395,7 @@ static uint32_t do_ld4_mmu(CPUArchState *env, target_ulong addr, MemOpIdx oi,
     bool crosspage;
     uint32_t ret;
 
+    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(env, addr, oi, ra, access_type, &l);
     if (likely(!crosspage)) {
         return do_ld_4(env, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
@@ -2420,6 +2423,7 @@ static uint64_t do_ld8_mmu(CPUArchState *env, target_ulong addr, MemOpIdx oi,
     bool crosspage;
     uint64_t ret;
 
+    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(env, addr, oi, ra, access_type, &l);
     if (likely(!crosspage)) {
         return do_ld_8(env, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
@@ -2472,6 +2476,7 @@ static Int128 do_ld16_mmu(CPUArchState *env, target_ulong addr,
     Int128 ret;
     int first;
 
+    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_LOAD, &l);
     if (likely(!crosspage)) {
         /* Perform the load host endian. */
@@ -2804,6 +2809,7 @@ void helper_stb_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
     bool crosspage;
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_8);
+    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE, &l);
     tcg_debug_assert(!crosspage);
 
@@ -2817,6 +2823,7 @@ static void do_st2_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
     bool crosspage;
     uint8_t a, b;
 
+    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
         do_st_2(env, &l.page[0], val, l.mmu_idx, l.memop, ra);
@@ -2845,6 +2852,7 @@ static void do_st4_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
     MMULookupLocals l;
     bool crosspage;
 
+    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
         do_st_4(env, &l.page[0], val, l.mmu_idx, l.memop, ra);
@@ -2872,6 +2880,7 @@ static void do_st8_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
     MMULookupLocals l;
     bool crosspage;
 
+    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
         do_st_8(env, &l.page[0], val, l.mmu_idx, l.memop, ra);
@@ -2901,6 +2910,7 @@ static void do_st16_mmu(CPUArchState *env, target_ulong addr, Int128 val,
     uint64_t a, b;
     int first;
 
+    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
         /* Swap to host endian if necessary, then store. */
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index dc8d6b5d40..ce65021cd4 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -914,6 +914,7 @@ static uint8_t do_ld1_mmu(CPUArchState *env, abi_ptr addr,
     uint8_t ret;
 
     tcg_debug_assert((mop & MO_SIZE) == MO_8);
+    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_LOAD);
     ret = ldub_p(haddr);
     clear_helper_retaddr();
@@ -947,6 +948,7 @@ static uint16_t do_ld2_mmu(CPUArchState *env, abi_ptr addr,
     uint16_t ret;
 
     tcg_debug_assert((mop & MO_SIZE) == MO_16);
+    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_LOAD);
     ret = load_atom_2(env, ra, haddr, mop);
     clear_helper_retaddr();
@@ -984,6 +986,7 @@ static uint32_t do_ld4_mmu(CPUArchState *env, abi_ptr addr,
     uint32_t ret;
 
     tcg_debug_assert((mop & MO_SIZE) == MO_32);
+    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_LOAD);
     ret = load_atom_4(env, ra, haddr, mop);
     clear_helper_retaddr();
@@ -1021,6 +1024,7 @@ static uint64_t do_ld8_mmu(CPUArchState *env, abi_ptr addr,
     uint64_t ret;
 
     tcg_debug_assert((mop & MO_SIZE) == MO_64);
+    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_LOAD);
     ret = load_atom_8(env, ra, haddr, mop);
     clear_helper_retaddr();
@@ -1052,6 +1056,7 @@ static Int128 do_ld16_mmu(CPUArchState *env, abi_ptr addr,
     Int128 ret;
 
     tcg_debug_assert((mop & MO_SIZE) == MO_128);
+    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_LOAD);
     ret = load_atom_16(env, ra, haddr, mop);
     clear_helper_retaddr();
@@ -1087,6 +1092,7 @@ static void do_st1_mmu(CPUArchState *env, abi_ptr addr, uint8_t val,
     void *haddr;
 
     tcg_debug_assert((mop & MO_SIZE) == MO_8);
+    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_STORE);
     stb_p(haddr, val);
     clear_helper_retaddr();
@@ -1111,6 +1117,7 @@ static void do_st2_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
     void *haddr;
 
     tcg_debug_assert((mop & MO_SIZE) == MO_16);
+    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_STORE);
 
     if (mop & MO_BSWAP) {
@@ -1139,6 +1146,7 @@ static void do_st4_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
     void *haddr;
 
     tcg_debug_assert((mop & MO_SIZE) == MO_32);
+    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_STORE);
 
     if (mop & MO_BSWAP) {
@@ -1167,6 +1175,7 @@ static void do_st8_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
     void *haddr;
 
     tcg_debug_assert((mop & MO_SIZE) == MO_64);
+    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_STORE);
 
     if (mop & MO_BSWAP) {
@@ -1195,6 +1204,7 @@ static void do_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
     void *haddr;
 
     tcg_debug_assert((mop & MO_SIZE) == MO_128);
+    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_STORE);
 
     if (mop & MO_BSWAP) {
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B55C573E39E
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:41:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoKg-0001F9-B4; Mon, 26 Jun 2023 11:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJx-0000KO-AZ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:40:08 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJr-0002sK-9f
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:40:01 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31114b46d62so4142560f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793998; x=1690385998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJ4JXVPpV5JMJ4Uyr7bGyKUomU9uIl5XSXsCTUgoIKc=;
 b=uDA3aVf94tqh9a8fgrFOq4KX2Dc1vDHxbYHITOIgRgOQV6bydyEluO+Ie4R1Wo0LAy
 GQH3FHrHpd9C0Qpn4t0z6yszOhE7rBkGyGyDw/TyqQMgWoNn30qmGA6awh7wh6ekhnAa
 pBiuyYXvpJdfkkBs2z/HcgMPhEUsPrbWbBI6PC6df7363f6QUB6uXeUOTbQVNA1DIAOc
 V4600iQweuGXcSZYElqtZ1FIgZJiAihePeWMr0nUYne1S1qa5CYO8AzeGNuHqEyeshnR
 y3e3KaIOwHju/4i8O1AznN/K9Gme/wJNuAYFF09L+/jXZKhXZuS6FCpFe219mrcZ4jSi
 SDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793998; x=1690385998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cJ4JXVPpV5JMJ4Uyr7bGyKUomU9uIl5XSXsCTUgoIKc=;
 b=PLw2ygc188IS2rVXJ0jwJ6NSWjMq2dG0BocHy3R/bchn7l7vNaRqJOtSx9YzWZplTB
 8WnuBAj8B6W2EsbK/CJu9cna7SS9Ijj3kzMhDByu03GoEOVo1fjTwbIqAee+I/uPQOgu
 kchTDvZbnzpDe1QbI+fnb5H6yW6Nvz40Ly6Lq1fsJeiJ6xMeUrirwngOu4TE/8AGkEwQ
 oD9r3wAYZTZOGz9gbLMn2IPUyW4JmbLq+1jYnayhMa+/x3THM/Tb0fDgX0+QZG/HgPXG
 Oglria1k6c7X09FrzYsoZo9dsPzEdUqAhGFdJp72r/OkUBuwMixOP6AdEL213Y5DfsCh
 zb7g==
X-Gm-Message-State: AC+VfDxIM/pvTYNV0kO3girySTzVZcpMPEWEIk4LNBbvEd/iz3BtdvIW
 tp91TCTps5bcYsAX8wuvZmYT8QnTspkFwlKHcviSAbrH
X-Google-Smtp-Source: ACHHUZ4rA+Wyvwsn+tu/H78xdFg5U5pOaAAW1xHywEQ0QAEvC52/3AbFNnWpRV8bjo5/uSt42tQdyg==
X-Received: by 2002:adf:e903:0:b0:313:e2dd:e6ad with SMTP id
 f3-20020adfe903000000b00313e2dde6admr5226189wrm.69.1687793997999; 
 Mon, 26 Jun 2023 08:39:57 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:39:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/22] tcg: Add host memory barriers to cpu_ldst.h interfaces
Date: Mon, 26 Jun 2023 17:39:41 +0200
Message-Id: <20230626153945.76180-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
References: <20230626153945.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal.h  | 34 ++++++++++++++++++++++++++++++++++
 accel/tcg/cputlb.c    | 10 ++++++++++
 accel/tcg/user-exec.c | 10 ++++++++++
 3 files changed, 54 insertions(+)

diff --git a/accel/tcg/internal.h b/accel/tcg/internal.h
index 91f308bdfa..650c3ac53f 100644
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
index e02cfc550e..5666a8e23a 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2339,6 +2339,7 @@ static uint8_t do_ld1_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi,
     MMULookupLocals l;
     bool crosspage;
 
+    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(env, addr, oi, ra, access_type, &l);
     tcg_debug_assert(!crosspage);
 
@@ -2360,6 +2361,7 @@ static uint16_t do_ld2_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi,
     uint16_t ret;
     uint8_t a, b;
 
+    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(env, addr, oi, ra, access_type, &l);
     if (likely(!crosspage)) {
         return do_ld_2(env, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
@@ -2390,6 +2392,7 @@ static uint32_t do_ld4_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi,
     bool crosspage;
     uint32_t ret;
 
+    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(env, addr, oi, ra, access_type, &l);
     if (likely(!crosspage)) {
         return do_ld_4(env, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
@@ -2417,6 +2420,7 @@ static uint64_t do_ld8_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi,
     bool crosspage;
     uint64_t ret;
 
+    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(env, addr, oi, ra, access_type, &l);
     if (likely(!crosspage)) {
         return do_ld_8(env, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
@@ -2469,6 +2473,7 @@ static Int128 do_ld16_mmu(CPUArchState *env, vaddr addr,
     Int128 ret;
     int first;
 
+    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_LOAD, &l);
     if (likely(!crosspage)) {
         /* Perform the load host endian. */
@@ -2802,6 +2807,7 @@ void helper_stb_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
     bool crosspage;
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_8);
+    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE, &l);
     tcg_debug_assert(!crosspage);
 
@@ -2815,6 +2821,7 @@ static void do_st2_mmu(CPUArchState *env, vaddr addr, uint16_t val,
     bool crosspage;
     uint8_t a, b;
 
+    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
         do_st_2(env, &l.page[0], val, l.mmu_idx, l.memop, ra);
@@ -2843,6 +2850,7 @@ static void do_st4_mmu(CPUArchState *env, vaddr addr, uint32_t val,
     MMULookupLocals l;
     bool crosspage;
 
+    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
         do_st_4(env, &l.page[0], val, l.mmu_idx, l.memop, ra);
@@ -2870,6 +2878,7 @@ static void do_st8_mmu(CPUArchState *env, vaddr addr, uint64_t val,
     MMULookupLocals l;
     bool crosspage;
 
+    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
         do_st_8(env, &l.page[0], val, l.mmu_idx, l.memop, ra);
@@ -2899,6 +2908,7 @@ static void do_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
     uint64_t a, b;
     int first;
 
+    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
         /* Swap to host endian if necessary, then store. */
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index f8b16d6ab8..8fbcbf9771 100644
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



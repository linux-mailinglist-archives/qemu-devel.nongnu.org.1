Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 369CB78617C
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:27:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOg-0000DX-7D; Wed, 23 Aug 2023 16:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOb-0008RJ-93
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:05 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOU-0005Ti-TQ
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:03 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bf078d5fb7so41364005ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822213; x=1693427013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tQQXOQ1CSwcHY3EnS8b54xsDdXhUgB6voqkuM0gz8A=;
 b=WJCUKIFAqqRCp4VCb0owXwJu6BCFQZciZcTeOHxNZBVepGFsJt5XaPHUVR6ckIu7RO
 1gnG+l2q/L0647NNqYNors2g9/tW47HSq1QJeB5PQQV0OFmeRrC9SqN5FXd1d/j0zb/i
 9QEjMKHhpuUDO+LRet80i0hITqSC0858+LxzSJIE3xt0nbzytGgRL0V10h9yUFEgvMf4
 zFg1f+lmVaj5AF+4tybhbzUNs2oB5H7MxKScmbMn5wMxVksu8dv4EuHKPoZ0pC4ubIsb
 cXMwGcE8mWGi96kNdkpMYAs+NCpp3Y+iUBOmpha++q4fD5/q05OrbW67r2e68XlLRdwG
 6Baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822213; x=1693427013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9tQQXOQ1CSwcHY3EnS8b54xsDdXhUgB6voqkuM0gz8A=;
 b=PGJHLYluj34p+3kbmQkaAGbEq6ZzpqjeNrODVuGdeRXjXLqZtN4R2MhiGL3kfstJPb
 ayDFL8ByeSGv6UmGELUzwIaLXC737YP39pw2kz1zjmg7mUxV62AdrVwwxlHWBU+ePO55
 6bEj+1kqePil49l1/EXsoeW/DrqXVTKagHyIv2dr2smNI5a09itnrDPB/Rj0wLCfLxqt
 DyabjiqTgN7kYFwgKV6dZkS33D5b3vYZQM53X8G2qZv1NcO81gXoigYdICOF5za2/n6K
 OJ64PSVHBnjSpamoovvS4zd+3foIwKiWVVtLrqmCV1vFe0g6mmNo8AaW4kAzeqhWa3Ih
 0Cwg==
X-Gm-Message-State: AOJu0YxUp0T0g3HPX0nvJNWsm6o5HvKoO3iw4EgKLPcXEQ5mdqc/skyZ
 hV8lrRIC1quwaFzp4Zf9rrkIrfg2yFIeXbUTcpM=
X-Google-Smtp-Source: AGHT+IG8x/je+rDTdx2qqOAcQzYXsgXqi5kg+tDXa9pxj94zmWGK6By96+nEXXaANXlDreOKafN5Jg==
X-Received: by 2002:a17:902:b782:b0:1bf:22b7:86d with SMTP id
 e2-20020a170902b78200b001bf22b7086dmr10823721pls.3.1692822212824; 
 Wed, 23 Aug 2023 13:23:32 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 05/48] include/exec: Replace target_ulong with abi_ptr in
 cpu_[st|ld]*()
Date: Wed, 23 Aug 2023 13:22:43 -0700
Message-Id: <20230823202326.1353645-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Anton Johansson via <qemu-devel@nongnu.org>

Changes the address type of the guest memory read/write functions from
target_ulong to abi_ptr. (abi_ptr is currently typedef'd to target_ulong
but that will change in a following commit.) This will reduce the
coupling between accel/ and target/.

Note: Function pointers that point to cpu_[st|ld]*() in target/riscv and
target/rx are also updated in this commit.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230807155706.9580-6-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/atomic_template.h  | 16 ++++++++--------
 include/exec/cpu_ldst.h      | 24 ++++++++++++------------
 accel/tcg/cputlb.c           | 10 +++++-----
 target/riscv/vector_helper.c |  2 +-
 target/rx/op_helper.c        |  6 +++---
 5 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index e312acd16d..84c08b1425 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -69,7 +69,7 @@
 # define END  _le
 #endif
 
-ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
+ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
                               ABI_TYPE cmpv, ABI_TYPE newv,
                               MemOpIdx oi, uintptr_t retaddr)
 {
@@ -87,7 +87,7 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
 }
 
 #if DATA_SIZE < 16
-ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr, ABI_TYPE val,
+ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, abi_ptr addr, ABI_TYPE val,
                            MemOpIdx oi, uintptr_t retaddr)
 {
     DATA_TYPE *haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE, retaddr);
@@ -100,7 +100,7 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr, ABI_TYPE val,
 }
 
 #define GEN_ATOMIC_HELPER(X)                                        \
-ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
+ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
                         ABI_TYPE val, MemOpIdx oi, uintptr_t retaddr) \
 {                                                                   \
     DATA_TYPE *haddr, ret;                                          \
@@ -131,7 +131,7 @@ GEN_ATOMIC_HELPER(xor_fetch)
  * of CF_PARALLEL's value, we'll trace just a read and a write.
  */
 #define GEN_ATOMIC_HELPER_FN(X, FN, XDATA_TYPE, RET)                \
-ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
+ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
                         ABI_TYPE xval, MemOpIdx oi, uintptr_t retaddr) \
 {                                                                   \
     XDATA_TYPE *haddr, cmp, old, new, val = xval;                   \
@@ -172,7 +172,7 @@ GEN_ATOMIC_HELPER_FN(umax_fetch, MAX,  DATA_TYPE, new)
 # define END  _be
 #endif
 
-ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
+ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
                               ABI_TYPE cmpv, ABI_TYPE newv,
                               MemOpIdx oi, uintptr_t retaddr)
 {
@@ -190,7 +190,7 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
 }
 
 #if DATA_SIZE < 16
-ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr, ABI_TYPE val,
+ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, abi_ptr addr, ABI_TYPE val,
                            MemOpIdx oi, uintptr_t retaddr)
 {
     DATA_TYPE *haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE, retaddr);
@@ -203,7 +203,7 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr, ABI_TYPE val,
 }
 
 #define GEN_ATOMIC_HELPER(X)                                        \
-ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
+ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
                         ABI_TYPE val, MemOpIdx oi, uintptr_t retaddr) \
 {                                                                   \
     DATA_TYPE *haddr, ret;                                          \
@@ -231,7 +231,7 @@ GEN_ATOMIC_HELPER(xor_fetch)
  * of CF_PARALLEL's value, we'll trace just a read and a write.
  */
 #define GEN_ATOMIC_HELPER_FN(X, FN, XDATA_TYPE, RET)                \
-ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
+ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
                         ABI_TYPE xval, MemOpIdx oi, uintptr_t retaddr) \
 {                                                                   \
     XDATA_TYPE *haddr, ldo, ldn, old, new, val = xval;              \
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 645476f0e5..da10ba1433 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -223,31 +223,31 @@ void cpu_stq_mmu(CPUArchState *env, abi_ptr ptr, uint64_t val,
 void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
                   MemOpIdx oi, uintptr_t ra);
 
-uint32_t cpu_atomic_cmpxchgb_mmu(CPUArchState *env, target_ulong addr,
+uint32_t cpu_atomic_cmpxchgb_mmu(CPUArchState *env, abi_ptr addr,
                                  uint32_t cmpv, uint32_t newv,
                                  MemOpIdx oi, uintptr_t retaddr);
-uint32_t cpu_atomic_cmpxchgw_le_mmu(CPUArchState *env, target_ulong addr,
+uint32_t cpu_atomic_cmpxchgw_le_mmu(CPUArchState *env, abi_ptr addr,
                                     uint32_t cmpv, uint32_t newv,
                                     MemOpIdx oi, uintptr_t retaddr);
-uint32_t cpu_atomic_cmpxchgl_le_mmu(CPUArchState *env, target_ulong addr,
+uint32_t cpu_atomic_cmpxchgl_le_mmu(CPUArchState *env, abi_ptr addr,
                                     uint32_t cmpv, uint32_t newv,
                                     MemOpIdx oi, uintptr_t retaddr);
-uint64_t cpu_atomic_cmpxchgq_le_mmu(CPUArchState *env, target_ulong addr,
+uint64_t cpu_atomic_cmpxchgq_le_mmu(CPUArchState *env, abi_ptr addr,
                                     uint64_t cmpv, uint64_t newv,
                                     MemOpIdx oi, uintptr_t retaddr);
-uint32_t cpu_atomic_cmpxchgw_be_mmu(CPUArchState *env, target_ulong addr,
+uint32_t cpu_atomic_cmpxchgw_be_mmu(CPUArchState *env, abi_ptr addr,
                                     uint32_t cmpv, uint32_t newv,
                                     MemOpIdx oi, uintptr_t retaddr);
-uint32_t cpu_atomic_cmpxchgl_be_mmu(CPUArchState *env, target_ulong addr,
+uint32_t cpu_atomic_cmpxchgl_be_mmu(CPUArchState *env, abi_ptr addr,
                                     uint32_t cmpv, uint32_t newv,
                                     MemOpIdx oi, uintptr_t retaddr);
-uint64_t cpu_atomic_cmpxchgq_be_mmu(CPUArchState *env, target_ulong addr,
+uint64_t cpu_atomic_cmpxchgq_be_mmu(CPUArchState *env, abi_ptr addr,
                                     uint64_t cmpv, uint64_t newv,
                                     MemOpIdx oi, uintptr_t retaddr);
 
-#define GEN_ATOMIC_HELPER(NAME, TYPE, SUFFIX)         \
-TYPE cpu_atomic_ ## NAME ## SUFFIX ## _mmu            \
-    (CPUArchState *env, target_ulong addr, TYPE val,  \
+#define GEN_ATOMIC_HELPER(NAME, TYPE, SUFFIX)   \
+TYPE cpu_atomic_ ## NAME ## SUFFIX ## _mmu      \
+    (CPUArchState *env, abi_ptr addr, TYPE val, \
      MemOpIdx oi, uintptr_t retaddr);
 
 #ifdef CONFIG_ATOMIC64
@@ -293,10 +293,10 @@ GEN_ATOMIC_HELPER_ALL(xchg)
 #undef GEN_ATOMIC_HELPER_ALL
 #undef GEN_ATOMIC_HELPER
 
-Int128 cpu_atomic_cmpxchgo_le_mmu(CPUArchState *env, target_ulong addr,
+Int128 cpu_atomic_cmpxchgo_le_mmu(CPUArchState *env, abi_ptr addr,
                                   Int128 cmpv, Int128 newv,
                                   MemOpIdx oi, uintptr_t retaddr);
-Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, target_ulong addr,
+Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, abi_ptr addr,
                                   Int128 cmpv, Int128 newv,
                                   MemOpIdx oi, uintptr_t retaddr);
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d68fa6867c..11095c4f5f 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -3133,14 +3133,14 @@ static void plugin_store_cb(CPUArchState *env, abi_ptr addr, MemOpIdx oi)
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
 }
 
-void cpu_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
+void cpu_stb_mmu(CPUArchState *env, abi_ptr addr, uint8_t val,
                  MemOpIdx oi, uintptr_t retaddr)
 {
     helper_stb_mmu(env, addr, val, oi, retaddr);
     plugin_store_cb(env, addr, oi);
 }
 
-void cpu_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
+void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
                  MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
@@ -3148,7 +3148,7 @@ void cpu_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
     plugin_store_cb(env, addr, oi);
 }
 
-void cpu_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
+void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
                     MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
@@ -3156,7 +3156,7 @@ void cpu_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
     plugin_store_cb(env, addr, oi);
 }
 
-void cpu_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
+void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
                  MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
@@ -3164,7 +3164,7 @@ void cpu_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
     plugin_store_cb(env, addr, oi);
 }
 
-void cpu_st16_mmu(CPUArchState *env, target_ulong addr, Int128 val,
+void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
                   MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 4d06754826..bf7e0029a1 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -235,7 +235,7 @@ static inline int vext_elem_mask(void *v0, int index)
 }
 
 /* elements operations for load and store */
-typedef void vext_ldst_elem_fn(CPURISCVState *env, target_ulong addr,
+typedef void vext_ldst_elem_fn(CPURISCVState *env, abi_ptr addr,
                                uint32_t idx, void *vd, uintptr_t retaddr);
 
 #define GEN_VEXT_LD_ELEM(NAME, ETYPE, H, LDSUF)            \
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index dc0092ca99..691a12b2be 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -216,19 +216,19 @@ void helper_scmpu(CPURXState *env)
 }
 
 static uint32_t (* const cpu_ldufn[])(CPUArchState *env,
-                                     target_ulong ptr,
+                                     abi_ptr ptr,
                                      uintptr_t retaddr) = {
     cpu_ldub_data_ra, cpu_lduw_data_ra, cpu_ldl_data_ra,
 };
 
 static uint32_t (* const cpu_ldfn[])(CPUArchState *env,
-                                     target_ulong ptr,
+                                     abi_ptr ptr,
                                      uintptr_t retaddr) = {
     cpu_ldub_data_ra, cpu_lduw_data_ra, cpu_ldl_data_ra,
 };
 
 static void (* const cpu_stfn[])(CPUArchState *env,
-                                 target_ulong ptr,
+                                 abi_ptr ptr,
                                  uint32_t val,
                                  uintptr_t retaddr) = {
     cpu_stb_data_ra, cpu_stw_data_ra, cpu_stl_data_ra,
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A04929514
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jul 2024 21:15:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQAr2-0002CX-1b; Sat, 06 Jul 2024 15:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sQAqz-0002CD-3x
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 15:13:49 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sQAqw-00044S-IC
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 15:13:48 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fb222a8eaeso19598135ad.3
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 12:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720293224; x=1720898024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oSCkw14FBoeGNGjUHnHe2Vob0BsAYcgrTpSqhp2ESss=;
 b=Sm6bPoTbz8GvIpEh9LfzCiPtJj++aw5ENiwmfKpIEGwZeCBI1Rvn1ZQ38I1nGDwg+j
 JFzXabeSMx+NA+b5XakqdsgdiVqHIBZXt2goHukq5uGOVhchzxJXiBYmyORCjX80z1fU
 hIxJHPoE0dJMoVVuCa+AYsxjLqq2xHWtIjyGKr9zG+hfZ9kAejamTUfIXYwKcM5FqHBe
 8kYZn7IdRL8l2HpWGU+WIyMD3sHvp/gu6rjIcNVD+tAw4B3gugRNzHH9Z9roOKbz7E99
 /BxN07TdgKP5ZRAbBL2RsIl+zXc/C2VdFXkvb/eR3Hfv7FWrBFdnZkgtMiEhcinDitGN
 wbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720293224; x=1720898024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oSCkw14FBoeGNGjUHnHe2Vob0BsAYcgrTpSqhp2ESss=;
 b=DVw1sW1BXFkgz+6EfCOKjPCw01JlZDV/JX7IDppY5n4K0+nUm88fNZQSB9GO+4GhG8
 c9nH0DJIBrSYwYQBdUVG8h4ph64BuXdJzsvIzqiUwD7wD/0hJPuxW5cFPxz0bBAD/QwP
 9XbeODfj3+I1Y75NtmrLOzLLXpu+SslzD5tR4AKgMZpWnWn0dus10UjJWlthastCRMN7
 TLQ4fpIYZLLYHUsdqvtsEIjMd3gCPupzHp3b+NGscxUdf9vqnjgYcsZ3ecx+l3JAVq/6
 BXe2aY6cFnR7vS2v7jLVHgfIk8RApA9QBP1QWX5HIp8nfkiGrjM6PQCOplsyeh/61fWC
 gCig==
X-Gm-Message-State: AOJu0YxP2ug8ZAoSzaoNGqxH8zvyxg7Jnj+0Z+3f5FfBsAFTg9Q/If2M
 7k1FpFZiFqRanVfFg95JuURJNHq6eNgVSQGT35FX5QdLRkbKu+WZvtgU4MdNW34Ud26syT36EuX
 VTe8=
X-Google-Smtp-Source: AGHT+IHgNnqQjfaOyUP6+EBIMko4NoXEsg7mo4M9Njb6EMNMoCcrrC8b+7MuapA6VJjf0rmdss2hlg==
X-Received: by 2002:a17:902:e74c:b0:1fb:715d:df83 with SMTP id
 d9443c01a7336-1fb715de31amr13225355ad.13.1720293224144; 
 Sat, 06 Jul 2024 12:13:44 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb6153cb3bsm17304305ad.129.2024.07.06.12.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jul 2024 12:13:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 2/7] plugins: save value during memory accesses
Date: Sat,  6 Jul 2024 12:13:30 -0700
Message-Id: <20240706191335.878142-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
References: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

Different code paths handle memory accesses:
- tcg generated code
- load/store helpers
- atomic helpers

This value is saved in cpu->neg.plugin_mem_value_{high,low}. Values are
written only for accessed word size (upper bits are not set).

Atomic operations are doing read/write at the same time, so we generate
two memory callbacks instead of one, to allow plugins to access distinct
values.

For now, we can have access only up to 128 bits, thus split this in two
64 bits words. When QEMU will support wider operations, we'll be able to
reconsider this.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/atomic_template.h   | 66 ++++++++++++++++++++++++++++++-----
 include/hw/core/cpu.h         |  4 +++
 include/qemu/plugin.h         |  4 +++
 plugins/core.c                |  6 ++++
 tcg/tcg-op-ldst.c             | 66 +++++++++++++++++++++++++++++++----
 accel/tcg/atomic_common.c.inc | 13 ++++++-
 accel/tcg/ldst_common.c.inc   | 38 ++++++++++++--------
 7 files changed, 167 insertions(+), 30 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 1dc2151dafd..89593b2502f 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -53,6 +53,14 @@
 # error unsupported data size
 #endif
 
+#if DATA_SIZE == 16
+# define VALUE_LOW(val) int128_getlo(val)
+# define VALUE_HIGH(val) int128_gethi(val)
+#else
+# define VALUE_LOW(val) val
+# define VALUE_HIGH(val) 0
+#endif
+
 #if DATA_SIZE >= 4
 # define ABI_TYPE  DATA_TYPE
 #else
@@ -83,7 +91,12 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
     ret = qatomic_cmpxchg__nocheck(haddr, cmpv, newv);
 #endif
     ATOMIC_MMU_CLEANUP;
-    atomic_trace_rmw_post(env, addr, oi);
+    atomic_trace_rmw_post(env, addr,
+                          VALUE_LOW(ret),
+                          VALUE_HIGH(ret),
+                          VALUE_LOW(newv),
+                          VALUE_HIGH(newv),
+                          oi);
     return ret;
 }
 
@@ -97,7 +110,12 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, abi_ptr addr, ABI_TYPE val,
 
     ret = qatomic_xchg__nocheck(haddr, val);
     ATOMIC_MMU_CLEANUP;
-    atomic_trace_rmw_post(env, addr, oi);
+    atomic_trace_rmw_post(env, addr,
+                          VALUE_LOW(ret),
+                          VALUE_HIGH(ret),
+                          VALUE_LOW(val),
+                          VALUE_HIGH(val),
+                          oi);
     return ret;
 }
 
@@ -109,7 +127,12 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
     haddr = atomic_mmu_lookup(env_cpu(env), addr, oi, DATA_SIZE, retaddr);   \
     ret = qatomic_##X(haddr, val);                                  \
     ATOMIC_MMU_CLEANUP;                                             \
-    atomic_trace_rmw_post(env, addr, oi);                           \
+    atomic_trace_rmw_post(env, addr,                                \
+                          VALUE_LOW(ret),                           \
+                          VALUE_HIGH(ret),                          \
+                          VALUE_LOW(val),                           \
+                          VALUE_HIGH(val),                          \
+                          oi);                                      \
     return ret;                                                     \
 }
 
@@ -145,7 +168,12 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
         cmp = qatomic_cmpxchg__nocheck(haddr, old, new);            \
     } while (cmp != old);                                           \
     ATOMIC_MMU_CLEANUP;                                             \
-    atomic_trace_rmw_post(env, addr, oi);                           \
+    atomic_trace_rmw_post(env, addr,                                \
+                          VALUE_LOW(old),                           \
+                          VALUE_HIGH(old),                          \
+                          VALUE_LOW(xval),                          \
+                          VALUE_HIGH(xval),                         \
+                          oi);                                      \
     return RET;                                                     \
 }
 
@@ -188,7 +216,12 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
     ret = qatomic_cmpxchg__nocheck(haddr, BSWAP(cmpv), BSWAP(newv));
 #endif
     ATOMIC_MMU_CLEANUP;
-    atomic_trace_rmw_post(env, addr, oi);
+    atomic_trace_rmw_post(env, addr,
+                          VALUE_LOW(ret),
+                          VALUE_HIGH(ret),
+                          VALUE_LOW(newv),
+                          VALUE_HIGH(newv),
+                          oi);
     return BSWAP(ret);
 }
 
@@ -202,7 +235,12 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, abi_ptr addr, ABI_TYPE val,
 
     ret = qatomic_xchg__nocheck(haddr, BSWAP(val));
     ATOMIC_MMU_CLEANUP;
-    atomic_trace_rmw_post(env, addr, oi);
+    atomic_trace_rmw_post(env, addr,
+                          VALUE_LOW(ret),
+                          VALUE_HIGH(ret),
+                          VALUE_LOW(val),
+                          VALUE_HIGH(val),
+                          oi);
     return BSWAP(ret);
 }
 
@@ -214,7 +252,12 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
     haddr = atomic_mmu_lookup(env_cpu(env), addr, oi, DATA_SIZE, retaddr);   \
     ret = qatomic_##X(haddr, BSWAP(val));                           \
     ATOMIC_MMU_CLEANUP;                                             \
-    atomic_trace_rmw_post(env, addr, oi);                           \
+    atomic_trace_rmw_post(env, addr,                                \
+                          VALUE_LOW(ret),                           \
+                          VALUE_HIGH(ret),                          \
+                          VALUE_LOW(val),                           \
+                          VALUE_HIGH(val),                          \
+                          oi);                                      \
     return BSWAP(ret);                                              \
 }
 
@@ -247,7 +290,12 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
         ldn = qatomic_cmpxchg__nocheck(haddr, ldo, BSWAP(new));     \
     } while (ldo != ldn);                                           \
     ATOMIC_MMU_CLEANUP;                                             \
-    atomic_trace_rmw_post(env, addr, oi);                           \
+    atomic_trace_rmw_post(env, addr,                                \
+                          VALUE_LOW(old),                           \
+                          VALUE_HIGH(old),                          \
+                          VALUE_LOW(xval),                          \
+                          VALUE_HIGH(xval),                         \
+                          oi);                                      \
     return RET;                                                     \
 }
 
@@ -281,3 +329,5 @@ GEN_ATOMIC_HELPER_FN(add_fetch, ADD, DATA_TYPE, new)
 #undef SUFFIX
 #undef DATA_SIZE
 #undef SHIFT
+#undef VALUE_LOW
+#undef VALUE_HIGH
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index a2c8536943f..e92cba049fd 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -350,6 +350,8 @@ typedef union IcountDecr {
  *                         from CPUArchState, via small negative offsets.
  * @can_do_io: True if memory-mapped IO is allowed.
  * @plugin_mem_cbs: active plugin memory callbacks
+ * @plugin_mem_value_low: 64 lower bits of latest accessed mem value.
+ * @plugin_mem_value_high: 64 higher bits of latest accessed mem value.
  */
 typedef struct CPUNegativeOffsetState {
     CPUTLB tlb;
@@ -358,6 +360,8 @@ typedef struct CPUNegativeOffsetState {
      * The callback pointer are accessed via TCG (see gen_empty_mem_helper).
      */
     GArray *plugin_mem_cbs;
+    uint64_t plugin_mem_value_low;
+    uint64_t plugin_mem_value_high;
 #endif
     IcountDecr icount_decr;
     bool can_do_io;
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index af5f9db4692..9726a9ebf36 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -167,6 +167,8 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1,
 void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret);
 
 void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
+                             uint64_t value_low,
+                             uint64_t value_high,
                              MemOpIdx oi, enum qemu_plugin_mem_rw rw);
 
 void qemu_plugin_flush_cb(void);
@@ -251,6 +253,8 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
 { }
 
 static inline void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
+                                           uint64_t value_low,
+                                           uint64_t value_high,
                                            MemOpIdx oi,
                                            enum qemu_plugin_mem_rw rw)
 { }
diff --git a/plugins/core.c b/plugins/core.c
index 12c67b4b4eb..d353d38b8da 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -583,6 +583,8 @@ void exec_inline_op(enum plugin_dyn_cb_type type,
 }
 
 void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
+                             uint64_t value_low,
+                             uint64_t value_high,
                              MemOpIdx oi, enum qemu_plugin_mem_rw rw)
 {
     GArray *arr = cpu->neg.plugin_mem_cbs;
@@ -591,6 +593,10 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
     if (arr == NULL) {
         return;
     }
+
+    cpu->neg.plugin_mem_value_low = value_low;
+    cpu->neg.plugin_mem_value_high = value_high;
+
     for (i = 0; i < arr->len; i++) {
         struct qemu_plugin_dyn_cb *cb =
             &g_array_index(arr, struct qemu_plugin_dyn_cb, i);
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 85101602581..23dc807f119 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -148,11 +148,11 @@ static TCGv_i64 plugin_maybe_preserve_addr(TCGTemp *addr)
     return NULL;
 }
 
+#ifdef CONFIG_PLUGIN
 static void
 plugin_gen_mem_callbacks(TCGv_i64 copy_addr, TCGTemp *orig_addr, MemOpIdx oi,
                          enum qemu_plugin_mem_rw rw)
 {
-#ifdef CONFIG_PLUGIN
     if (tcg_ctx->plugin_insn != NULL) {
         qemu_plugin_meminfo_t info = make_plugin_meminfo(oi, rw);
 
@@ -172,6 +172,54 @@ plugin_gen_mem_callbacks(TCGv_i64 copy_addr, TCGTemp *orig_addr, MemOpIdx oi,
             }
         }
     }
+}
+#endif
+
+static void
+plugin_gen_mem_callbacks_i32(TCGv_i32 val,
+                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
+                             MemOpIdx oi, enum qemu_plugin_mem_rw rw)
+{
+#ifdef CONFIG_PLUGIN
+    if (tcg_ctx->plugin_insn != NULL) {
+        tcg_gen_st_i32(val, tcg_env,
+                       offsetof(CPUState, neg.plugin_mem_value_low) -
+                       sizeof(CPUState) + (HOST_BIG_ENDIAN * 4));
+        plugin_gen_mem_callbacks(copy_addr, orig_addr, oi, rw);
+    }
+#endif
+}
+
+static void
+plugin_gen_mem_callbacks_i64(TCGv_i64 val,
+                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
+                             MemOpIdx oi, enum qemu_plugin_mem_rw rw)
+{
+#ifdef CONFIG_PLUGIN
+    if (tcg_ctx->plugin_insn != NULL) {
+        tcg_gen_st_i64(val, tcg_env,
+                       offsetof(CPUState, neg.plugin_mem_value_low) -
+                       sizeof(CPUState));
+        plugin_gen_mem_callbacks(copy_addr, orig_addr, oi, rw);
+    }
+#endif
+}
+
+static void
+plugin_gen_mem_callbacks_i128(TCGv_i128 val,
+                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
+                             MemOpIdx oi, enum qemu_plugin_mem_rw rw)
+{
+#ifdef CONFIG_PLUGIN
+    if (tcg_ctx->plugin_insn != NULL) {
+        tcg_gen_st_i64(TCGV128_LOW(val), tcg_env,
+                       offsetof(CPUState, neg.plugin_mem_value_low) -
+                       sizeof(CPUState));
+        tcg_gen_st_i64(TCGV128_HIGH(val), tcg_env,
+                       offsetof(CPUState, neg.plugin_mem_value_high) -
+                       sizeof(CPUState));
+        plugin_gen_mem_callbacks(copy_addr, orig_addr, oi, rw);
+    }
 #endif
 }
 
@@ -203,7 +251,8 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
         opc = INDEX_op_qemu_ld_a64_i32;
     }
     gen_ldst(opc, tcgv_i32_temp(val), NULL, addr, oi);
-    plugin_gen_mem_callbacks(copy_addr, addr, orig_oi, QEMU_PLUGIN_MEM_R);
+    plugin_gen_mem_callbacks_i32(val, copy_addr, addr, orig_oi,
+                                 QEMU_PLUGIN_MEM_R);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         switch (orig_memop & MO_SIZE) {
@@ -271,7 +320,7 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
         }
     }
     gen_ldst(opc, tcgv_i32_temp(val), NULL, addr, oi);
-    plugin_gen_mem_callbacks(NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
+    plugin_gen_mem_callbacks_i32(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
 
     if (swap) {
         tcg_temp_free_i32(swap);
@@ -324,7 +373,8 @@ static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
         opc = INDEX_op_qemu_ld_a64_i64;
     }
     gen_ldst_i64(opc, val, addr, oi);
-    plugin_gen_mem_callbacks(copy_addr, addr, orig_oi, QEMU_PLUGIN_MEM_R);
+    plugin_gen_mem_callbacks_i64(val, copy_addr, addr, orig_oi,
+                                 QEMU_PLUGIN_MEM_R);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         int flags = (orig_memop & MO_SIGN
@@ -396,7 +446,7 @@ static void tcg_gen_qemu_st_i64_int(TCGv_i64 val, TCGTemp *addr,
         opc = INDEX_op_qemu_st_a64_i64;
     }
     gen_ldst_i64(opc, val, addr, oi);
-    plugin_gen_mem_callbacks(NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
+    plugin_gen_mem_callbacks_i64(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
 
     if (swap) {
         tcg_temp_free_i64(swap);
@@ -606,7 +656,8 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
                            tcg_constant_i32(orig_oi));
     }
 
-    plugin_gen_mem_callbacks(ext_addr, addr, orig_oi, QEMU_PLUGIN_MEM_R);
+    plugin_gen_mem_callbacks_i128(val, ext_addr, addr, orig_oi,
+                                  QEMU_PLUGIN_MEM_R);
 }
 
 void tcg_gen_qemu_ld_i128_chk(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
@@ -722,7 +773,8 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
                            tcg_constant_i32(orig_oi));
     }
 
-    plugin_gen_mem_callbacks(ext_addr, addr, orig_oi, QEMU_PLUGIN_MEM_W);
+    plugin_gen_mem_callbacks_i128(val, ext_addr, addr, orig_oi,
+                                  QEMU_PLUGIN_MEM_W);
 }
 
 void tcg_gen_qemu_st_i128_chk(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
diff --git a/accel/tcg/atomic_common.c.inc b/accel/tcg/atomic_common.c.inc
index 95a5c5ff12d..6056598c23d 100644
--- a/accel/tcg/atomic_common.c.inc
+++ b/accel/tcg/atomic_common.c.inc
@@ -14,9 +14,20 @@
  */
 
 static void atomic_trace_rmw_post(CPUArchState *env, uint64_t addr,
+                                  uint64_t read_value_low,
+                                  uint64_t read_value_high,
+                                  uint64_t write_value_low,
+                                  uint64_t write_value_high,
                                   MemOpIdx oi)
 {
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_RW);
+    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
+        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr,
+                                read_value_low, read_value_high,
+                                oi, QEMU_PLUGIN_MEM_R);
+        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr,
+                                write_value_low, write_value_high,
+                                oi, QEMU_PLUGIN_MEM_W);
+    }
 }
 
 /*
diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
index 87ceb954873..ebbf380d767 100644
--- a/accel/tcg/ldst_common.c.inc
+++ b/accel/tcg/ldst_common.c.inc
@@ -123,10 +123,15 @@ void helper_st_i128(CPUArchState *env, uint64_t addr, Int128 val, MemOpIdx oi)
  * Load helpers for cpu_ldst.h
  */
 
-static void plugin_load_cb(CPUArchState *env, abi_ptr addr, MemOpIdx oi)
+static void plugin_load_cb(CPUArchState *env, abi_ptr addr,
+                           uint64_t value_low,
+                           uint64_t value_high,
+                           MemOpIdx oi)
 {
     if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
-        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
+        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr,
+                                value_low, value_high,
+                                oi, QEMU_PLUGIN_MEM_R);
     }
 }
 
@@ -136,7 +141,7 @@ uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr addr, MemOpIdx oi, uintptr_t ra)
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_UB);
     ret = do_ld1_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
+    plugin_load_cb(env, addr, ret, 0, oi);
     return ret;
 }
 
@@ -147,7 +152,7 @@ uint16_t cpu_ldw_mmu(CPUArchState *env, abi_ptr addr,
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
     ret = do_ld2_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
+    plugin_load_cb(env, addr, ret, 0, oi);
     return ret;
 }
 
@@ -158,7 +163,7 @@ uint32_t cpu_ldl_mmu(CPUArchState *env, abi_ptr addr,
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
     ret = do_ld4_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
+    plugin_load_cb(env, addr, ret, 0, oi);
     return ret;
 }
 
@@ -169,7 +174,7 @@ uint64_t cpu_ldq_mmu(CPUArchState *env, abi_ptr addr,
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
     ret = do_ld8_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
+    plugin_load_cb(env, addr, ret, 0, oi);
     return ret;
 }
 
@@ -180,7 +185,7 @@ Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
     ret = do_ld16_mmu(env_cpu(env), addr, oi, ra);
-    plugin_load_cb(env, addr, oi);
+    plugin_load_cb(env, addr, int128_getlo(ret), int128_gethi(ret), oi);
     return ret;
 }
 
@@ -188,10 +193,15 @@ Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
  * Store helpers for cpu_ldst.h
  */
 
-static void plugin_store_cb(CPUArchState *env, abi_ptr addr, MemOpIdx oi)
+static void plugin_store_cb(CPUArchState *env, abi_ptr addr,
+                            uint64_t value_low,
+                            uint64_t value_high,
+                            MemOpIdx oi)
 {
     if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
-        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
+        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr,
+                                value_low, value_high,
+                                oi, QEMU_PLUGIN_MEM_W);
     }
 }
 
@@ -199,7 +209,7 @@ void cpu_stb_mmu(CPUArchState *env, abi_ptr addr, uint8_t val,
                  MemOpIdx oi, uintptr_t retaddr)
 {
     helper_stb_mmu(env, addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
+    plugin_store_cb(env, addr, val, 0, oi);
 }
 
 void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
@@ -207,7 +217,7 @@ void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
     do_st2_mmu(env_cpu(env), addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
+    plugin_store_cb(env, addr, val, 0, oi);
 }
 
 void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
@@ -215,7 +225,7 @@ void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
     do_st4_mmu(env_cpu(env), addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
+    plugin_store_cb(env, addr, val, 0, oi);
 }
 
 void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
@@ -223,7 +233,7 @@ void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
     do_st8_mmu(env_cpu(env), addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
+    plugin_store_cb(env, addr, val, 0, oi);
 }
 
 void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
@@ -231,7 +241,7 @@ void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
     do_st16_mmu(env_cpu(env), addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
+    plugin_store_cb(env, addr, int128_getlo(val), int128_gethi(val), oi);
 }
 
 /*
-- 
2.39.2



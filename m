Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D95227B7024
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:43:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjFI-0000EC-Cq; Tue, 03 Oct 2023 13:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjF8-0008UZ-0n
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:34 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjF3-0007Wp-Jd
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:33 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-690ba63891dso912084b3a.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354287; x=1696959087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALHZpOh+PiaOrsMQhqrSyZ+8WveMTk1XpR5VgM7Envk=;
 b=sKfhlKw47yMHg5cX/iDf7u0PHeRKBI04CFSN47KprIwAYcURUCzrD+DUxyCdynGklB
 5T3SbpdOgKFjh0etT3txeIkLPU8jISEmj8y28jHfCDNxXohwGzXZ/1G1wq0ueD7zsDKg
 /qppVjE8KWlo62zQ58cfGx/jQvqbgLN2cXuaqyDOQPE8+TLizP1/zvjBakrD8sAJs1oU
 sQh43n9MvriVff5/b84BaVWW17THAveGQxluOmdGcUKvoepz5tXCg1fCsG+D8qwRv7rT
 6QtkvH72e6ovKYmyZm7OGU5lnkrGucKy8zqTFFteD1cE6LfAa0r/dAxqi0xnFYJAxpVH
 wuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354287; x=1696959087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ALHZpOh+PiaOrsMQhqrSyZ+8WveMTk1XpR5VgM7Envk=;
 b=B5akKJ9BFBIjcOqBC98BU/Z0aCLDFPQ2zySAyvsylkAcIhlIglfgU5OgObnIo1IeZT
 J9OsLUDktACGH4pKvWzOetjUtkQQGAJ72d2okNuulPmN3eGaS7xh37aHExM/cqJ1YCkG
 zNdgk0gCV25pj5hFLfUEAquuaxJYn4H92HxX8b6VNOwBIbiqkNKYzHGfPU1pHSNfSkp+
 oLSL2GY63rcgdmsJq6MjDEP+QLDgOuH4BSNtVUaB3zFYGHUcq0SFuziE7DZ/4dg2FJsU
 qfMkpTP/BS7KjaMREHxwytWhdwPUN09aAjh+aOc0UfdU6M+wOwCbNoZ6X0SIwJ7gMUt1
 aMpg==
X-Gm-Message-State: AOJu0Yxv373xiafoknCxyxHsOxJ099RrUm3di6KZLVDCjPMH21KsyfdT
 TGbrmG/Q6EFb5lvueRMQ1RBdOtklNfl6kVnqQoU=
X-Google-Smtp-Source: AGHT+IHLkXVm5AbsUam9jVprLirZVkqZdv3ntqx4e6jJ9GhbaINRF8ULPM8lMx/0mB5tje5BHhtS8g==
X-Received: by 2002:a05:6a00:2e89:b0:693:3851:bd98 with SMTP id
 fd9-20020a056a002e8900b006933851bd98mr292114pfb.2.1696354287185; 
 Tue, 03 Oct 2023 10:31:27 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 30/47] accel/tcg: move ld/st helpers to ldst_common.c.inc
Date: Tue,  3 Oct 2023 10:30:35 -0700
Message-Id: <20231003173052.1601813-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

From: Anton Johansson <anjo@rev.ng>

A large chunk of ld/st functions are moved from cputlb.c and user-exec.c
to ldst_common.c.inc as their implementation is the same between both
modes.

Eventually, ldst_common.c.inc could be compiled into a separate
target-specific compilation unit, and be linked in with the targets.
Keeping CPUArchState usage out of cputlb.c (CPUArchState is primarily
used to access the mmu index in these functions).

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230912153428.17816-12-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c          | 214 ----------------------------------
 accel/tcg/user-exec.c       | 193 -------------------------------
 accel/tcg/ldst_common.c.inc | 225 ++++++++++++++++++++++++++++++++++++
 3 files changed, 225 insertions(+), 407 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index dc43839f87..c53f434c88 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2390,13 +2390,6 @@ static uint8_t do_ld1_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     return do_ld_1(cpu, &l.page[0], l.mmu_idx, access_type, ra);
 }
 
-tcg_target_ulong helper_ldub_mmu(CPUArchState *env, uint64_t addr,
-                                 MemOpIdx oi, uintptr_t retaddr)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_8);
-    return do_ld1_mmu(env_cpu(env), addr, oi, retaddr, MMU_DATA_LOAD);
-}
-
 static uint16_t do_ld2_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
                            uintptr_t ra, MMUAccessType access_type)
 {
@@ -2422,13 +2415,6 @@ static uint16_t do_ld2_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     return ret;
 }
 
-tcg_target_ulong helper_lduw_mmu(CPUArchState *env, uint64_t addr,
-                                 MemOpIdx oi, uintptr_t retaddr)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
-    return do_ld2_mmu(env_cpu(env), addr, oi, retaddr, MMU_DATA_LOAD);
-}
-
 static uint32_t do_ld4_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
                            uintptr_t ra, MMUAccessType access_type)
 {
@@ -2450,13 +2436,6 @@ static uint32_t do_ld4_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     return ret;
 }
 
-tcg_target_ulong helper_ldul_mmu(CPUArchState *env, uint64_t addr,
-                                 MemOpIdx oi, uintptr_t retaddr)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
-    return do_ld4_mmu(env_cpu(env), addr, oi, retaddr, MMU_DATA_LOAD);
-}
-
 static uint64_t do_ld8_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
                            uintptr_t ra, MMUAccessType access_type)
 {
@@ -2478,36 +2457,6 @@ static uint64_t do_ld8_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     return ret;
 }
 
-uint64_t helper_ldq_mmu(CPUArchState *env, uint64_t addr,
-                        MemOpIdx oi, uintptr_t retaddr)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
-    return do_ld8_mmu(env_cpu(env), addr, oi, retaddr, MMU_DATA_LOAD);
-}
-
-/*
- * Provide signed versions of the load routines as well.  We can of course
- * avoid this for 64-bit data, or for 32-bit data on 32-bit host.
- */
-
-tcg_target_ulong helper_ldsb_mmu(CPUArchState *env, uint64_t addr,
-                                 MemOpIdx oi, uintptr_t retaddr)
-{
-    return (int8_t)helper_ldub_mmu(env, addr, oi, retaddr);
-}
-
-tcg_target_ulong helper_ldsw_mmu(CPUArchState *env, uint64_t addr,
-                                 MemOpIdx oi, uintptr_t retaddr)
-{
-    return (int16_t)helper_lduw_mmu(env, addr, oi, retaddr);
-}
-
-tcg_target_ulong helper_ldsl_mmu(CPUArchState *env, uint64_t addr,
-                                 MemOpIdx oi, uintptr_t retaddr)
-{
-    return (int32_t)helper_ldul_mmu(env, addr, oi, retaddr);
-}
-
 static Int128 do_ld16_mmu(CPUState *cpu, vaddr addr,
                           MemOpIdx oi, uintptr_t ra)
 {
@@ -2569,81 +2518,6 @@ static Int128 do_ld16_mmu(CPUState *cpu, vaddr addr,
     return ret;
 }
 
-Int128 helper_ld16_mmu(CPUArchState *env, uint64_t addr,
-                       uint32_t oi, uintptr_t retaddr)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
-    return do_ld16_mmu(env_cpu(env), addr, oi, retaddr);
-}
-
-Int128 helper_ld_i128(CPUArchState *env, uint64_t addr, uint32_t oi)
-{
-    return helper_ld16_mmu(env, addr, oi, GETPC());
-}
-
-/*
- * Load helpers for cpu_ldst.h.
- */
-
-static void plugin_load_cb(CPUArchState *env, abi_ptr addr, MemOpIdx oi)
-{
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
-}
-
-uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr addr, MemOpIdx oi, uintptr_t ra)
-{
-    uint8_t ret;
-
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_UB);
-    ret = do_ld1_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
-    return ret;
-}
-
-uint16_t cpu_ldw_mmu(CPUArchState *env, abi_ptr addr,
-                     MemOpIdx oi, uintptr_t ra)
-{
-    uint16_t ret;
-
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
-    ret = do_ld2_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
-    return ret;
-}
-
-uint32_t cpu_ldl_mmu(CPUArchState *env, abi_ptr addr,
-                     MemOpIdx oi, uintptr_t ra)
-{
-    uint32_t ret;
-
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
-    ret = do_ld4_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
-    return ret;
-}
-
-uint64_t cpu_ldq_mmu(CPUArchState *env, abi_ptr addr,
-                     MemOpIdx oi, uintptr_t ra)
-{
-    uint64_t ret;
-
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
-    ret = do_ld8_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
-    return ret;
-}
-
-Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
-                    MemOpIdx oi, uintptr_t ra)
-{
-    Int128 ret;
-
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
-    ret = do_ld16_mmu(env_cpu(env), addr, oi, ra);
-    plugin_load_cb(env, addr, oi);
-    return ret;
-}
-
 /*
  * Store Helpers
  */
@@ -2935,13 +2809,6 @@ static void do_st1_mmu(CPUState *cpu, vaddr addr, uint8_t val,
     do_st_1(cpu, &l.page[0], val, l.mmu_idx, ra);
 }
 
-void helper_stb_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
-                    MemOpIdx oi, uintptr_t ra)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_8);
-    do_st1_mmu(env_cpu(env), addr, val, oi, ra);
-}
-
 static void do_st2_mmu(CPUState *cpu, vaddr addr, uint16_t val,
                        MemOpIdx oi, uintptr_t ra)
 {
@@ -2965,13 +2832,6 @@ static void do_st2_mmu(CPUState *cpu, vaddr addr, uint16_t val,
     do_st_1(cpu, &l.page[1], b, l.mmu_idx, ra);
 }
 
-void helper_stw_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
-                    MemOpIdx oi, uintptr_t retaddr)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
-    do_st2_mmu(env_cpu(env), addr, val, oi, retaddr);
-}
-
 static void do_st4_mmu(CPUState *cpu, vaddr addr, uint32_t val,
                        MemOpIdx oi, uintptr_t ra)
 {
@@ -2993,13 +2853,6 @@ static void do_st4_mmu(CPUState *cpu, vaddr addr, uint32_t val,
     (void) do_st_leN(cpu, &l.page[1], val, l.mmu_idx, l.memop, ra);
 }
 
-void helper_stl_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
-                    MemOpIdx oi, uintptr_t retaddr)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
-    do_st4_mmu(env_cpu(env), addr, val, oi, retaddr);
-}
-
 static void do_st8_mmu(CPUState *cpu, vaddr addr, uint64_t val,
                        MemOpIdx oi, uintptr_t ra)
 {
@@ -3021,13 +2874,6 @@ static void do_st8_mmu(CPUState *cpu, vaddr addr, uint64_t val,
     (void) do_st_leN(cpu, &l.page[1], val, l.mmu_idx, l.memop, ra);
 }
 
-void helper_stq_mmu(CPUArchState *env, uint64_t addr, uint64_t val,
-                    MemOpIdx oi, uintptr_t retaddr)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
-    do_st8_mmu(env_cpu(env), addr, val, oi, retaddr);
-}
-
 static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
                         MemOpIdx oi, uintptr_t ra)
 {
@@ -3086,66 +2932,6 @@ static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
     }
 }
 
-void helper_st16_mmu(CPUArchState *env, uint64_t addr, Int128 val,
-                     MemOpIdx oi, uintptr_t retaddr)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
-    do_st16_mmu(env_cpu(env), addr, val, oi, retaddr);
-}
-
-void helper_st_i128(CPUArchState *env, uint64_t addr, Int128 val, MemOpIdx oi)
-{
-    helper_st16_mmu(env, addr, val, oi, GETPC());
-}
-
-/*
- * Store Helpers for cpu_ldst.h
- */
-
-static void plugin_store_cb(CPUArchState *env, abi_ptr addr, MemOpIdx oi)
-{
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
-}
-
-void cpu_stb_mmu(CPUArchState *env, abi_ptr addr, uint8_t val,
-                 MemOpIdx oi, uintptr_t retaddr)
-{
-    helper_stb_mmu(env, addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
-}
-
-void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
-                 MemOpIdx oi, uintptr_t retaddr)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
-    do_st2_mmu(env_cpu(env), addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
-}
-
-void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
-                    MemOpIdx oi, uintptr_t retaddr)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
-    do_st4_mmu(env_cpu(env), addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
-}
-
-void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
-                 MemOpIdx oi, uintptr_t retaddr)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
-    do_st8_mmu(env_cpu(env), addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
-}
-
-void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
-                  MemOpIdx oi, uintptr_t retaddr)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
-    do_st16_mmu(env_cpu(env), addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
-}
-
 #include "ldst_common.c.inc"
 
 /*
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index a6593d0e0f..17f9aff0cf 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -972,31 +972,6 @@ static uint8_t do_ld1_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     return ret;
 }
 
-tcg_target_ulong helper_ldub_mmu(CPUArchState *env, uint64_t addr,
-                                 MemOpIdx oi, uintptr_t ra)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_8);
-    return do_ld1_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-}
-
-tcg_target_ulong helper_ldsb_mmu(CPUArchState *env, uint64_t addr,
-                                 MemOpIdx oi, uintptr_t ra)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_8);
-    return (int8_t)do_ld1_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-}
-
-uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr addr,
-                    MemOpIdx oi, uintptr_t ra)
-{
-    uint8_t ret;
-
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_8);
-    ret = do_ld1_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
-    return ret;
-}
-
 static uint16_t do_ld2_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
                            uintptr_t ra, MMUAccessType access_type)
 {
@@ -1015,31 +990,6 @@ static uint16_t do_ld2_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     return ret;
 }
 
-tcg_target_ulong helper_lduw_mmu(CPUArchState *env, uint64_t addr,
-                                 MemOpIdx oi, uintptr_t ra)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
-    return do_ld2_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-}
-
-tcg_target_ulong helper_ldsw_mmu(CPUArchState *env, uint64_t addr,
-                                 MemOpIdx oi, uintptr_t ra)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
-    return (int16_t)do_ld2_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-}
-
-uint16_t cpu_ldw_mmu(CPUArchState *env, abi_ptr addr,
-                     MemOpIdx oi, uintptr_t ra)
-{
-    uint16_t ret;
-
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
-    ret = do_ld2_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
-    return ret;
-}
-
 static uint32_t do_ld4_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
                            uintptr_t ra, MMUAccessType access_type)
 {
@@ -1058,31 +1008,6 @@ static uint32_t do_ld4_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     return ret;
 }
 
-tcg_target_ulong helper_ldul_mmu(CPUArchState *env, uint64_t addr,
-                                 MemOpIdx oi, uintptr_t ra)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
-    return do_ld4_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-}
-
-tcg_target_ulong helper_ldsl_mmu(CPUArchState *env, uint64_t addr,
-                                 MemOpIdx oi, uintptr_t ra)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
-    return (int32_t)do_ld4_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-}
-
-uint32_t cpu_ldl_mmu(CPUArchState *env, abi_ptr addr,
-                     MemOpIdx oi, uintptr_t ra)
-{
-    uint32_t ret;
-
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
-    ret = do_ld4_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
-    return ret;
-}
-
 static uint64_t do_ld8_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
                            uintptr_t ra, MMUAccessType access_type)
 {
@@ -1101,24 +1026,6 @@ static uint64_t do_ld8_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     return ret;
 }
 
-uint64_t helper_ldq_mmu(CPUArchState *env, uint64_t addr,
-                        MemOpIdx oi, uintptr_t ra)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
-    return do_ld8_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-}
-
-uint64_t cpu_ldq_mmu(CPUArchState *env, abi_ptr addr,
-                     MemOpIdx oi, uintptr_t ra)
-{
-    uint64_t ret;
-
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
-    ret = do_ld8_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
-    return ret;
-}
-
 static Int128 do_ld16_mmu(CPUState *cpu, abi_ptr addr,
                           MemOpIdx oi, uintptr_t ra)
 {
@@ -1138,25 +1045,6 @@ static Int128 do_ld16_mmu(CPUState *cpu, abi_ptr addr,
     return ret;
 }
 
-Int128 helper_ld16_mmu(CPUArchState *env, uint64_t addr,
-                       MemOpIdx oi, uintptr_t ra)
-{
-    return do_ld16_mmu(env_cpu(env), addr, get_memop(oi), ra);
-}
-
-Int128 helper_ld_i128(CPUArchState *env, uint64_t addr, MemOpIdx oi)
-{
-    return helper_ld16_mmu(env, addr, oi, GETPC());
-}
-
-Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
-                    MemOpIdx oi, uintptr_t ra)
-{
-    Int128 ret = do_ld16_mmu(env_cpu(env), addr, get_memop(oi), ra);
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
-    return ret;
-}
-
 static void do_st1_mmu(CPUState *cpu, vaddr addr, uint8_t val,
                        MemOpIdx oi, uintptr_t ra)
 {
@@ -1168,21 +1056,6 @@ static void do_st1_mmu(CPUState *cpu, vaddr addr, uint8_t val,
     clear_helper_retaddr();
 }
 
-void helper_stb_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
-                    MemOpIdx oi, uintptr_t ra)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_8);
-    do_st1_mmu(env_cpu(env), addr, val, oi, ra);
-}
-
-void cpu_stb_mmu(CPUArchState *env, abi_ptr addr, uint8_t val,
-                 MemOpIdx oi, uintptr_t ra)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_8);
-    do_st1_mmu(env_cpu(env), addr, val, oi, ra);
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
-}
-
 static void do_st2_mmu(CPUState *cpu, vaddr addr, uint16_t val,
                        MemOpIdx oi, uintptr_t ra)
 {
@@ -1199,21 +1072,6 @@ static void do_st2_mmu(CPUState *cpu, vaddr addr, uint16_t val,
     clear_helper_retaddr();
 }
 
-void helper_stw_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
-                    MemOpIdx oi, uintptr_t ra)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
-    do_st2_mmu(env_cpu(env), addr, val, oi, ra);
-}
-
-void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
-                    MemOpIdx oi, uintptr_t ra)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
-    do_st2_mmu(env_cpu(env), addr, val, oi, ra);
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
-}
-
 static void do_st4_mmu(CPUState *cpu, vaddr addr, uint32_t val,
                        MemOpIdx oi, uintptr_t ra)
 {
@@ -1230,21 +1088,6 @@ static void do_st4_mmu(CPUState *cpu, vaddr addr, uint32_t val,
     clear_helper_retaddr();
 }
 
-void helper_stl_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
-                    MemOpIdx oi, uintptr_t ra)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
-    do_st4_mmu(env_cpu(env), addr, val, oi, ra);
-}
-
-void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
-                 MemOpIdx oi, uintptr_t ra)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
-    do_st4_mmu(env_cpu(env), addr, val, oi, ra);
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
-}
-
 static void do_st8_mmu(CPUState *cpu, vaddr addr, uint64_t val,
                        MemOpIdx oi, uintptr_t ra)
 {
@@ -1261,21 +1104,6 @@ static void do_st8_mmu(CPUState *cpu, vaddr addr, uint64_t val,
     clear_helper_retaddr();
 }
 
-void helper_stq_mmu(CPUArchState *env, uint64_t addr, uint64_t val,
-                    MemOpIdx oi, uintptr_t ra)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
-    do_st8_mmu(env_cpu(env), addr, val, oi, ra);
-}
-
-void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
-                    MemOpIdx oi, uintptr_t ra)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
-    do_st8_mmu(env_cpu(env), addr, val, oi, ra);
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
-}
-
 static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
                         MemOpIdx oi, uintptr_t ra)
 {
@@ -1292,27 +1120,6 @@ static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
     clear_helper_retaddr();
 }
 
-void helper_st16_mmu(CPUArchState *env, uint64_t addr, Int128 val,
-                     MemOpIdx oi, uintptr_t ra)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
-    do_st16_mmu(env_cpu(env), addr, val, oi, ra);
-}
-
-void helper_st_i128(CPUArchState *env, uint64_t addr, Int128 val, MemOpIdx oi)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
-    helper_st16_mmu(env, addr, val, oi, GETPC());
-}
-
-void cpu_st16_mmu(CPUArchState *env, abi_ptr addr,
-                  Int128 val, MemOpIdx oi, uintptr_t ra)
-{
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
-    do_st16_mmu(env_cpu(env), addr, val, oi, ra);
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
-}
-
 uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr ptr)
 {
     uint32_t ret;
diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
index 5f8144b33a..44833513fb 100644
--- a/accel/tcg/ldst_common.c.inc
+++ b/accel/tcg/ldst_common.c.inc
@@ -8,6 +8,231 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
+/*
+ * Load helpers for tcg-ldst.h
+ */
+
+tcg_target_ulong helper_ldub_mmu(CPUArchState *env, uint64_t addr,
+                                 MemOpIdx oi, uintptr_t retaddr)
+{
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_8);
+    return do_ld1_mmu(env_cpu(env), addr, oi, retaddr, MMU_DATA_LOAD);
+}
+
+tcg_target_ulong helper_lduw_mmu(CPUArchState *env, uint64_t addr,
+                                 MemOpIdx oi, uintptr_t retaddr)
+{
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
+    return do_ld2_mmu(env_cpu(env), addr, oi, retaddr, MMU_DATA_LOAD);
+}
+
+tcg_target_ulong helper_ldul_mmu(CPUArchState *env, uint64_t addr,
+                                 MemOpIdx oi, uintptr_t retaddr)
+{
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
+    return do_ld4_mmu(env_cpu(env), addr, oi, retaddr, MMU_DATA_LOAD);
+}
+
+uint64_t helper_ldq_mmu(CPUArchState *env, uint64_t addr,
+                        MemOpIdx oi, uintptr_t retaddr)
+{
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
+    return do_ld8_mmu(env_cpu(env), addr, oi, retaddr, MMU_DATA_LOAD);
+}
+
+/*
+ * Provide signed versions of the load routines as well.  We can of course
+ * avoid this for 64-bit data, or for 32-bit data on 32-bit host.
+ */
+
+tcg_target_ulong helper_ldsb_mmu(CPUArchState *env, uint64_t addr,
+                                 MemOpIdx oi, uintptr_t retaddr)
+{
+    return (int8_t)helper_ldub_mmu(env, addr, oi, retaddr);
+}
+
+tcg_target_ulong helper_ldsw_mmu(CPUArchState *env, uint64_t addr,
+                                 MemOpIdx oi, uintptr_t retaddr)
+{
+    return (int16_t)helper_lduw_mmu(env, addr, oi, retaddr);
+}
+
+tcg_target_ulong helper_ldsl_mmu(CPUArchState *env, uint64_t addr,
+                                 MemOpIdx oi, uintptr_t retaddr)
+{
+    return (int32_t)helper_ldul_mmu(env, addr, oi, retaddr);
+}
+
+Int128 helper_ld16_mmu(CPUArchState *env, uint64_t addr,
+                       MemOpIdx oi, uintptr_t retaddr)
+{
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
+    return do_ld16_mmu(env_cpu(env), addr, oi, retaddr);
+}
+
+Int128 helper_ld_i128(CPUArchState *env, uint64_t addr, uint32_t oi)
+{
+    return helper_ld16_mmu(env, addr, oi, GETPC());
+}
+
+/*
+ * Store helpers for tcg-ldst.h
+ */
+
+void helper_stb_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
+                    MemOpIdx oi, uintptr_t ra)
+{
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_8);
+    do_st1_mmu(env_cpu(env), addr, val, oi, ra);
+}
+
+void helper_stw_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
+                    MemOpIdx oi, uintptr_t retaddr)
+{
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
+    do_st2_mmu(env_cpu(env), addr, val, oi, retaddr);
+}
+
+void helper_stl_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
+                    MemOpIdx oi, uintptr_t retaddr)
+{
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
+    do_st4_mmu(env_cpu(env), addr, val, oi, retaddr);
+}
+
+void helper_stq_mmu(CPUArchState *env, uint64_t addr, uint64_t val,
+                    MemOpIdx oi, uintptr_t retaddr)
+{
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
+    do_st8_mmu(env_cpu(env), addr, val, oi, retaddr);
+}
+
+void helper_st16_mmu(CPUArchState *env, uint64_t addr, Int128 val,
+                     MemOpIdx oi, uintptr_t retaddr)
+{
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
+    do_st16_mmu(env_cpu(env), addr, val, oi, retaddr);
+}
+
+void helper_st_i128(CPUArchState *env, uint64_t addr, Int128 val, MemOpIdx oi)
+{
+    helper_st16_mmu(env, addr, val, oi, GETPC());
+}
+
+/*
+ * Load helpers for cpu_ldst.h
+ */
+
+static void plugin_load_cb(CPUArchState *env, abi_ptr addr, MemOpIdx oi)
+{
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
+}
+
+uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr addr, MemOpIdx oi, uintptr_t ra)
+{
+    uint8_t ret;
+
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_UB);
+    ret = do_ld1_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
+    plugin_load_cb(env, addr, oi);
+    return ret;
+}
+
+uint16_t cpu_ldw_mmu(CPUArchState *env, abi_ptr addr,
+                     MemOpIdx oi, uintptr_t ra)
+{
+    uint16_t ret;
+
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
+    ret = do_ld2_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
+    plugin_load_cb(env, addr, oi);
+    return ret;
+}
+
+uint32_t cpu_ldl_mmu(CPUArchState *env, abi_ptr addr,
+                     MemOpIdx oi, uintptr_t ra)
+{
+    uint32_t ret;
+
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
+    ret = do_ld4_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
+    plugin_load_cb(env, addr, oi);
+    return ret;
+}
+
+uint64_t cpu_ldq_mmu(CPUArchState *env, abi_ptr addr,
+                     MemOpIdx oi, uintptr_t ra)
+{
+    uint64_t ret;
+
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
+    ret = do_ld8_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
+    plugin_load_cb(env, addr, oi);
+    return ret;
+}
+
+Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
+                    MemOpIdx oi, uintptr_t ra)
+{
+    Int128 ret;
+
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
+    ret = do_ld16_mmu(env_cpu(env), addr, oi, ra);
+    plugin_load_cb(env, addr, oi);
+    return ret;
+}
+
+/*
+ * Store helpers for cpu_ldst.h
+ */
+
+static void plugin_store_cb(CPUArchState *env, abi_ptr addr, MemOpIdx oi)
+{
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
+}
+
+void cpu_stb_mmu(CPUArchState *env, abi_ptr addr, uint8_t val,
+                 MemOpIdx oi, uintptr_t retaddr)
+{
+    helper_stb_mmu(env, addr, val, oi, retaddr);
+    plugin_store_cb(env, addr, oi);
+}
+
+void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
+                 MemOpIdx oi, uintptr_t retaddr)
+{
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
+    do_st2_mmu(env_cpu(env), addr, val, oi, retaddr);
+    plugin_store_cb(env, addr, oi);
+}
+
+void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
+                    MemOpIdx oi, uintptr_t retaddr)
+{
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
+    do_st4_mmu(env_cpu(env), addr, val, oi, retaddr);
+    plugin_store_cb(env, addr, oi);
+}
+
+void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
+                 MemOpIdx oi, uintptr_t retaddr)
+{
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
+    do_st8_mmu(env_cpu(env), addr, val, oi, retaddr);
+    plugin_store_cb(env, addr, oi);
+}
+
+void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
+                  MemOpIdx oi, uintptr_t retaddr)
+{
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
+    do_st16_mmu(env_cpu(env), addr, val, oi, retaddr);
+    plugin_store_cb(env, addr, oi);
+}
+
+/*
+ * Wrappers of the above
+ */
 
 uint32_t cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr,
                             int mmu_idx, uintptr_t ra)
-- 
2.34.1



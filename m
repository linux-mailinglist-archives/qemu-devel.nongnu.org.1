Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5A17B6FC6
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:32:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjFE-00007z-VA; Tue, 03 Oct 2023 13:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjF7-0008TV-3V
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:33 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjF1-0007Wj-Nf
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:31 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-57bab8676f9so692422eaf.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354286; x=1696959086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FLoclqklTYtdXUp0chTqVPswhpdSmhtE7w0yYQS8LHQ=;
 b=zfEiqHro+Sdnkoxc71sqPSXTTFYaDnHQJVmum7DozI/9aVd8gqNYAFwwynzYYMuEmy
 Ky7EjXY3Edt+2Tdglrz1rKQYg5t6geCwJ2GxLWF3nh0gMVOjr12Mcu8ioqbW6znpZrQ+
 JSPknQuylW4GlvLEnXNyjP5+3EmMtDJqXSMOTUL1iP8Am2lhRYa13Mxced4+6+2bYW3a
 mn6gBC7vOUr0p2sMNXPto7xkzE/GV4Jyo7lQXg2pAzFgfoHfVClpb8BAbRVqw8+0CyHY
 jb3/6W8o8vhyfa0c63YB3BrazJ+QuO3wpXhVEDHs5rcRZAFp3kRArPWRerSDbvNukHft
 OKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354286; x=1696959086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FLoclqklTYtdXUp0chTqVPswhpdSmhtE7w0yYQS8LHQ=;
 b=EgdtYOr9IG+wrk6G/arxj/guM9AlYP7VdcflhZUZ41C+98je59XNTIBpG/Lv69NtKp
 bCcrzto8KJYqzT6vnGfzzbQB7lboT7P0NR2p4TfL6Z36wp8qSj6F6ni1mkMCj8P3RhcO
 E638klhSuo+yalJgpu+t0bVaTfJfYVhXp6FH4sbfiOVHLdUCU7WavtM/RTtvbocQSDbu
 wT054qscjOyJWjuxgMIPnNkzB/YymsjD6w+db3n5zSiNuo3Pvmmnf54lGjx1XlK8mach
 k2snrFqnOmniX4VicVI0D4cS5oNDkyBVd+ZlhnsdVnwy5919cueVGy8g47a8tznkxDhN
 sNCg==
X-Gm-Message-State: AOJu0YwvZuALuc8T5s3d0VlWrpJVk5TV5LpNdKENAwRSa8NFWkFFDikd
 njfHSuV+JxrB+sDK9EyrwRKGj8MbM6dOC+UJddI=
X-Google-Smtp-Source: AGHT+IHnr0nzDHFdbuaxmCakpeRqyuo4R1vQ5BYL2XRZU+IviZFZG12of4iMQ9KDdgLz6ltIA3B46g==
X-Received: by 2002:a05:6358:5e0a:b0:139:9fc3:eade with SMTP id
 q10-20020a0563585e0a00b001399fc3eademr90657rwn.29.1696354286102; 
 Tue, 03 Oct 2023 10:31:26 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 29/47] accel/tcg: Unify user and softmmu do_[st|ld]*_mmu()
Date: Tue,  3 Oct 2023 10:30:34 -0700
Message-Id: <20231003173052.1601813-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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

The prototype of do_[st|ld]*_mmu() is unified between system- and
user-mode allowing a large chunk of helper_[st|ld]*() and cpu_[st|ld]*()
functions to be expressed in same manner between both modes. These
functions will be moved to ldst_common.c.inc in a following commit.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230912153428.17816-11-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c    |  16 ++--
 accel/tcg/user-exec.c | 183 ++++++++++++++++++++++++------------------
 2 files changed, 117 insertions(+), 82 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 17fa7a514c..dc43839f87 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2922,18 +2922,24 @@ static void do_st_8(CPUState *cpu, MMULookupPageData *p, uint64_t val,
     }
 }
 
-void helper_stb_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
-                    MemOpIdx oi, uintptr_t ra)
+static void do_st1_mmu(CPUState *cpu, vaddr addr, uint8_t val,
+                       MemOpIdx oi, uintptr_t ra)
 {
     MMULookupLocals l;
     bool crosspage;
 
-    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_8);
     cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
-    crosspage = mmu_lookup(env_cpu(env), addr, oi, ra, MMU_DATA_STORE, &l);
+    crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_STORE, &l);
     tcg_debug_assert(!crosspage);
 
-    do_st_1(env_cpu(env), &l.page[0], val, l.mmu_idx, ra);
+    do_st_1(cpu, &l.page[0], val, l.mmu_idx, ra);
+}
+
+void helper_stb_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
+                    MemOpIdx oi, uintptr_t ra)
+{
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_8);
+    do_st1_mmu(env_cpu(env), addr, val, oi, ra);
 }
 
 static void do_st2_mmu(CPUState *cpu, vaddr addr, uint16_t val,
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index f9f5cd1770..a6593d0e0f 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -941,7 +941,7 @@ void page_reset_target_data(target_ulong start, target_ulong last) { }
 
 /* The softmmu versions of these helpers are in cputlb.c.  */
 
-static void *cpu_mmu_lookup(CPUArchState *env, vaddr addr,
+static void *cpu_mmu_lookup(CPUState *cpu, vaddr addr,
                             MemOp mop, uintptr_t ra, MMUAccessType type)
 {
     int a_bits = get_alignment_bits(mop);
@@ -949,25 +949,24 @@ static void *cpu_mmu_lookup(CPUArchState *env, vaddr addr,
 
     /* Enforce guest required alignment.  */
     if (unlikely(addr & ((1 << a_bits) - 1))) {
-        cpu_loop_exit_sigbus(env_cpu(env), addr, type, ra);
+        cpu_loop_exit_sigbus(cpu, addr, type, ra);
     }
 
-    ret = g2h(env_cpu(env), addr);
+    ret = g2h(cpu, addr);
     set_helper_retaddr(ra);
     return ret;
 }
 
 #include "ldst_atomicity.c.inc"
 
-static uint8_t do_ld1_mmu(CPUArchState *env, abi_ptr addr,
-                          MemOp mop, uintptr_t ra)
+static uint8_t do_ld1_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
+                          uintptr_t ra, MMUAccessType access_type)
 {
     void *haddr;
     uint8_t ret;
 
-    tcg_debug_assert((mop & MO_SIZE) == MO_8);
     cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
-    haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_LOAD);
+    haddr = cpu_mmu_lookup(cpu, addr, get_memop(oi), ra, access_type);
     ret = ldub_p(haddr);
     clear_helper_retaddr();
     return ret;
@@ -976,33 +975,38 @@ static uint8_t do_ld1_mmu(CPUArchState *env, abi_ptr addr,
 tcg_target_ulong helper_ldub_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t ra)
 {
-    return do_ld1_mmu(env, addr, get_memop(oi), ra);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_8);
+    return do_ld1_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
 }
 
 tcg_target_ulong helper_ldsb_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t ra)
 {
-    return (int8_t)do_ld1_mmu(env, addr, get_memop(oi), ra);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_8);
+    return (int8_t)do_ld1_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
 }
 
 uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr addr,
                     MemOpIdx oi, uintptr_t ra)
 {
-    uint8_t ret = do_ld1_mmu(env, addr, get_memop(oi), ra);
+    uint8_t ret;
+
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_8);
+    ret = do_ld1_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
     return ret;
 }
 
-static uint16_t do_ld2_mmu(CPUArchState *env, abi_ptr addr,
-                           MemOp mop, uintptr_t ra)
+static uint16_t do_ld2_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
+                           uintptr_t ra, MMUAccessType access_type)
 {
     void *haddr;
     uint16_t ret;
+    MemOp mop = get_memop(oi);
 
-    tcg_debug_assert((mop & MO_SIZE) == MO_16);
     cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
-    haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_LOAD);
-    ret = load_atom_2(env_cpu(env), ra, haddr, mop);
+    haddr = cpu_mmu_lookup(cpu, addr, mop, ra, access_type);
+    ret = load_atom_2(cpu, ra, haddr, mop);
     clear_helper_retaddr();
 
     if (mop & MO_BSWAP) {
@@ -1014,33 +1018,38 @@ static uint16_t do_ld2_mmu(CPUArchState *env, abi_ptr addr,
 tcg_target_ulong helper_lduw_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t ra)
 {
-    return do_ld2_mmu(env, addr, get_memop(oi), ra);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
+    return do_ld2_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
 }
 
 tcg_target_ulong helper_ldsw_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t ra)
 {
-    return (int16_t)do_ld2_mmu(env, addr, get_memop(oi), ra);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
+    return (int16_t)do_ld2_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
 }
 
 uint16_t cpu_ldw_mmu(CPUArchState *env, abi_ptr addr,
                      MemOpIdx oi, uintptr_t ra)
 {
-    uint16_t ret = do_ld2_mmu(env, addr, get_memop(oi), ra);
+    uint16_t ret;
+
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
+    ret = do_ld2_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
     return ret;
 }
 
-static uint32_t do_ld4_mmu(CPUArchState *env, abi_ptr addr,
-                           MemOp mop, uintptr_t ra)
+static uint32_t do_ld4_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
+                           uintptr_t ra, MMUAccessType access_type)
 {
     void *haddr;
     uint32_t ret;
+    MemOp mop = get_memop(oi);
 
-    tcg_debug_assert((mop & MO_SIZE) == MO_32);
     cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
-    haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_LOAD);
-    ret = load_atom_4(env_cpu(env), ra, haddr, mop);
+    haddr = cpu_mmu_lookup(cpu, addr, mop, ra, access_type);
+    ret = load_atom_4(cpu, ra, haddr, mop);
     clear_helper_retaddr();
 
     if (mop & MO_BSWAP) {
@@ -1052,33 +1061,38 @@ static uint32_t do_ld4_mmu(CPUArchState *env, abi_ptr addr,
 tcg_target_ulong helper_ldul_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t ra)
 {
-    return do_ld4_mmu(env, addr, get_memop(oi), ra);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
+    return do_ld4_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
 }
 
 tcg_target_ulong helper_ldsl_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t ra)
 {
-    return (int32_t)do_ld4_mmu(env, addr, get_memop(oi), ra);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
+    return (int32_t)do_ld4_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
 }
 
 uint32_t cpu_ldl_mmu(CPUArchState *env, abi_ptr addr,
                      MemOpIdx oi, uintptr_t ra)
 {
-    uint32_t ret = do_ld4_mmu(env, addr, get_memop(oi), ra);
+    uint32_t ret;
+
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
+    ret = do_ld4_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
     return ret;
 }
 
-static uint64_t do_ld8_mmu(CPUArchState *env, abi_ptr addr,
-                           MemOp mop, uintptr_t ra)
+static uint64_t do_ld8_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
+                           uintptr_t ra, MMUAccessType access_type)
 {
     void *haddr;
     uint64_t ret;
+    MemOp mop = get_memop(oi);
 
-    tcg_debug_assert((mop & MO_SIZE) == MO_64);
     cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
-    haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_LOAD);
-    ret = load_atom_8(env_cpu(env), ra, haddr, mop);
+    haddr = cpu_mmu_lookup(cpu, addr, mop, ra, access_type);
+    ret = load_atom_8(cpu, ra, haddr, mop);
     clear_helper_retaddr();
 
     if (mop & MO_BSWAP) {
@@ -1090,27 +1104,32 @@ static uint64_t do_ld8_mmu(CPUArchState *env, abi_ptr addr,
 uint64_t helper_ldq_mmu(CPUArchState *env, uint64_t addr,
                         MemOpIdx oi, uintptr_t ra)
 {
-    return do_ld8_mmu(env, addr, get_memop(oi), ra);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
+    return do_ld8_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
 }
 
 uint64_t cpu_ldq_mmu(CPUArchState *env, abi_ptr addr,
                      MemOpIdx oi, uintptr_t ra)
 {
-    uint64_t ret = do_ld8_mmu(env, addr, get_memop(oi), ra);
+    uint64_t ret;
+
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
+    ret = do_ld8_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
     return ret;
 }
 
-static Int128 do_ld16_mmu(CPUArchState *env, abi_ptr addr,
-                          MemOp mop, uintptr_t ra)
+static Int128 do_ld16_mmu(CPUState *cpu, abi_ptr addr,
+                          MemOpIdx oi, uintptr_t ra)
 {
     void *haddr;
     Int128 ret;
+    MemOp mop = get_memop(oi);
 
     tcg_debug_assert((mop & MO_SIZE) == MO_128);
     cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
-    haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_LOAD);
-    ret = load_atom_16(env_cpu(env), ra, haddr, mop);
+    haddr = cpu_mmu_lookup(cpu, addr, mop, ra, MMU_DATA_LOAD);
+    ret = load_atom_16(cpu, ra, haddr, mop);
     clear_helper_retaddr();
 
     if (mop & MO_BSWAP) {
@@ -1122,7 +1141,7 @@ static Int128 do_ld16_mmu(CPUArchState *env, abi_ptr addr,
 Int128 helper_ld16_mmu(CPUArchState *env, uint64_t addr,
                        MemOpIdx oi, uintptr_t ra)
 {
-    return do_ld16_mmu(env, addr, get_memop(oi), ra);
+    return do_ld16_mmu(env_cpu(env), addr, get_memop(oi), ra);
 }
 
 Int128 helper_ld_i128(CPUArchState *env, uint64_t addr, MemOpIdx oi)
@@ -1133,19 +1152,18 @@ Int128 helper_ld_i128(CPUArchState *env, uint64_t addr, MemOpIdx oi)
 Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
                     MemOpIdx oi, uintptr_t ra)
 {
-    Int128 ret = do_ld16_mmu(env, addr, get_memop(oi), ra);
+    Int128 ret = do_ld16_mmu(env_cpu(env), addr, get_memop(oi), ra);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
     return ret;
 }
 
-static void do_st1_mmu(CPUArchState *env, abi_ptr addr, uint8_t val,
-                       MemOp mop, uintptr_t ra)
+static void do_st1_mmu(CPUState *cpu, vaddr addr, uint8_t val,
+                       MemOpIdx oi, uintptr_t ra)
 {
     void *haddr;
 
-    tcg_debug_assert((mop & MO_SIZE) == MO_8);
     cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
-    haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_STORE);
+    haddr = cpu_mmu_lookup(cpu, addr, get_memop(oi), ra, MMU_DATA_STORE);
     stb_p(haddr, val);
     clear_helper_retaddr();
 }
@@ -1153,134 +1171,145 @@ static void do_st1_mmu(CPUArchState *env, abi_ptr addr, uint8_t val,
 void helper_stb_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
                     MemOpIdx oi, uintptr_t ra)
 {
-    do_st1_mmu(env, addr, val, get_memop(oi), ra);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_8);
+    do_st1_mmu(env_cpu(env), addr, val, oi, ra);
 }
 
 void cpu_stb_mmu(CPUArchState *env, abi_ptr addr, uint8_t val,
                  MemOpIdx oi, uintptr_t ra)
 {
-    do_st1_mmu(env, addr, val, get_memop(oi), ra);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_8);
+    do_st1_mmu(env_cpu(env), addr, val, oi, ra);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
 }
 
-static void do_st2_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
-                       MemOp mop, uintptr_t ra)
+static void do_st2_mmu(CPUState *cpu, vaddr addr, uint16_t val,
+                       MemOpIdx oi, uintptr_t ra)
 {
     void *haddr;
+    MemOp mop = get_memop(oi);
 
-    tcg_debug_assert((mop & MO_SIZE) == MO_16);
     cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
-    haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_STORE);
+    haddr = cpu_mmu_lookup(cpu, addr, mop, ra, MMU_DATA_STORE);
 
     if (mop & MO_BSWAP) {
         val = bswap16(val);
     }
-    store_atom_2(env_cpu(env), ra, haddr, mop, val);
+    store_atom_2(cpu, ra, haddr, mop, val);
     clear_helper_retaddr();
 }
 
 void helper_stw_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
                     MemOpIdx oi, uintptr_t ra)
 {
-    do_st2_mmu(env, addr, val, get_memop(oi), ra);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
+    do_st2_mmu(env_cpu(env), addr, val, oi, ra);
 }
 
 void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
                     MemOpIdx oi, uintptr_t ra)
 {
-    do_st2_mmu(env, addr, val, get_memop(oi), ra);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
+    do_st2_mmu(env_cpu(env), addr, val, oi, ra);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
 }
 
-static void do_st4_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
-                       MemOp mop, uintptr_t ra)
+static void do_st4_mmu(CPUState *cpu, vaddr addr, uint32_t val,
+                       MemOpIdx oi, uintptr_t ra)
 {
     void *haddr;
+    MemOp mop = get_memop(oi);
 
-    tcg_debug_assert((mop & MO_SIZE) == MO_32);
     cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
-    haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_STORE);
+    haddr = cpu_mmu_lookup(cpu, addr, mop, ra, MMU_DATA_STORE);
 
     if (mop & MO_BSWAP) {
         val = bswap32(val);
     }
-    store_atom_4(env_cpu(env), ra, haddr, mop, val);
+    store_atom_4(cpu, ra, haddr, mop, val);
     clear_helper_retaddr();
 }
 
 void helper_stl_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
                     MemOpIdx oi, uintptr_t ra)
 {
-    do_st4_mmu(env, addr, val, get_memop(oi), ra);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
+    do_st4_mmu(env_cpu(env), addr, val, oi, ra);
 }
 
 void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
                  MemOpIdx oi, uintptr_t ra)
 {
-    do_st4_mmu(env, addr, val, get_memop(oi), ra);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
+    do_st4_mmu(env_cpu(env), addr, val, oi, ra);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
 }
 
-static void do_st8_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
-                       MemOp mop, uintptr_t ra)
+static void do_st8_mmu(CPUState *cpu, vaddr addr, uint64_t val,
+                       MemOpIdx oi, uintptr_t ra)
 {
     void *haddr;
+    MemOp mop = get_memop(oi);
 
-    tcg_debug_assert((mop & MO_SIZE) == MO_64);
     cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
-    haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_STORE);
+    haddr = cpu_mmu_lookup(cpu, addr, mop, ra, MMU_DATA_STORE);
 
     if (mop & MO_BSWAP) {
         val = bswap64(val);
     }
-    store_atom_8(env_cpu(env), ra, haddr, mop, val);
+    store_atom_8(cpu, ra, haddr, mop, val);
     clear_helper_retaddr();
 }
 
 void helper_stq_mmu(CPUArchState *env, uint64_t addr, uint64_t val,
                     MemOpIdx oi, uintptr_t ra)
 {
-    do_st8_mmu(env, addr, val, get_memop(oi), ra);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
+    do_st8_mmu(env_cpu(env), addr, val, oi, ra);
 }
 
 void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
                     MemOpIdx oi, uintptr_t ra)
 {
-    do_st8_mmu(env, addr, val, get_memop(oi), ra);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
+    do_st8_mmu(env_cpu(env), addr, val, oi, ra);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
 }
 
-static void do_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
-                        MemOp mop, uintptr_t ra)
+static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
+                        MemOpIdx oi, uintptr_t ra)
 {
     void *haddr;
+    MemOpIdx mop = get_memop(oi);
 
-    tcg_debug_assert((mop & MO_SIZE) == MO_128);
     cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
-    haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_STORE);
+    haddr = cpu_mmu_lookup(cpu, addr, mop, ra, MMU_DATA_STORE);
 
     if (mop & MO_BSWAP) {
         val = bswap128(val);
     }
-    store_atom_16(env_cpu(env), ra, haddr, mop, val);
+    store_atom_16(cpu, ra, haddr, mop, val);
     clear_helper_retaddr();
 }
 
 void helper_st16_mmu(CPUArchState *env, uint64_t addr, Int128 val,
                      MemOpIdx oi, uintptr_t ra)
 {
-    do_st16_mmu(env, addr, val, get_memop(oi), ra);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
+    do_st16_mmu(env_cpu(env), addr, val, oi, ra);
 }
 
 void helper_st_i128(CPUArchState *env, uint64_t addr, Int128 val, MemOpIdx oi)
 {
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
     helper_st16_mmu(env, addr, val, oi, GETPC());
 }
 
 void cpu_st16_mmu(CPUArchState *env, abi_ptr addr,
                   Int128 val, MemOpIdx oi, uintptr_t ra)
 {
-    do_st16_mmu(env, addr, val, get_memop(oi), ra);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
+    do_st16_mmu(env_cpu(env), addr, val, oi, ra);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
 }
 
@@ -1330,7 +1359,7 @@ uint8_t cpu_ldb_code_mmu(CPUArchState *env, abi_ptr addr,
     void *haddr;
     uint8_t ret;
 
-    haddr = cpu_mmu_lookup(env, addr, oi, ra, MMU_INST_FETCH);
+    haddr = cpu_mmu_lookup(env_cpu(env), addr, oi, ra, MMU_INST_FETCH);
     ret = ldub_p(haddr);
     clear_helper_retaddr();
     return ret;
@@ -1342,7 +1371,7 @@ uint16_t cpu_ldw_code_mmu(CPUArchState *env, abi_ptr addr,
     void *haddr;
     uint16_t ret;
 
-    haddr = cpu_mmu_lookup(env, addr, oi, ra, MMU_INST_FETCH);
+    haddr = cpu_mmu_lookup(env_cpu(env), addr, oi, ra, MMU_INST_FETCH);
     ret = lduw_p(haddr);
     clear_helper_retaddr();
     if (get_memop(oi) & MO_BSWAP) {
@@ -1357,7 +1386,7 @@ uint32_t cpu_ldl_code_mmu(CPUArchState *env, abi_ptr addr,
     void *haddr;
     uint32_t ret;
 
-    haddr = cpu_mmu_lookup(env, addr, oi, ra, MMU_INST_FETCH);
+    haddr = cpu_mmu_lookup(env_cpu(env), addr, oi, ra, MMU_INST_FETCH);
     ret = ldl_p(haddr);
     clear_helper_retaddr();
     if (get_memop(oi) & MO_BSWAP) {
@@ -1372,7 +1401,7 @@ uint64_t cpu_ldq_code_mmu(CPUArchState *env, abi_ptr addr,
     void *haddr;
     uint64_t ret;
 
-    haddr = cpu_mmu_lookup(env, addr, oi, ra, MMU_DATA_LOAD);
+    haddr = cpu_mmu_lookup(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
     ret = ldq_p(haddr);
     clear_helper_retaddr();
     if (get_memop(oi) & MO_BSWAP) {
-- 
2.34.1



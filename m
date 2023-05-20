Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF53770A92C
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 18:30:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0PQc-000412-BJ; Sat, 20 May 2023 12:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQG-0003je-S2
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:27:12 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQ8-0003AF-On
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:27:12 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-64d2467d640so3202291b3a.1
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 09:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684600020; x=1687192020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ol9f0HLEAIGA8FowB6n0ZN2fTDIRFVUsiNSJUMVLzsQ=;
 b=sJMTFE3YKF6ehj2VDFrYCYffF1mmvmh44k/t2htIoR8bmDQHHD3bTMLLbg1v7PP2ce
 LV2BxW2xTX8dPzsVbScDYJ+6dVAwFlfGDLWO2pmQOxZMm64NoYc7xLqJaH7JPAeykubN
 hNeaxg5/JmFB04AGglbksViWp3uhyGNgL3D706zRCdUuTCjMX/eAwIT5IML+a3WuiSUN
 Ud0dSsP9e4evmcoxoUnpAGl8H9SRo5Ml5AdaWodKx3BUkeDSlpk6GPSJPpyWRS63ZQNT
 2V1CsMkAiWSX/eO2G/snYnAax09RHGb0mxU30NgeSCAgce95K8b9nApAfagAkeKJCqsk
 QT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684600020; x=1687192020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ol9f0HLEAIGA8FowB6n0ZN2fTDIRFVUsiNSJUMVLzsQ=;
 b=eUdTYehocqS8YigUemJb2+eNvI5ltS5i0f9zdGhM4sXVuuwSImy/G1fLc+Nal42pDg
 pa/z6d54qOTdK5ZkTO2d664PDSN3J6XpXxC2APPZu0UlCFzEQFE/X4Mtw7TIYtfMDOgC
 JyPdqSwSnjOLJHzqcItl0QAZ9CCc3cNt5IKbBxmmAtPsbhcTM+f7IUE7yJDyHKrjrqG9
 VNfCx8oKYsiMiIwqnzsA6BMbr/9NFJL6VyME0nnzS/PmGBaHshwI7yvl0xO4gS229wco
 ezjnh4acPVRnIRpIXzRzPo3ibdBrHj1DqZebAbF+YdDkEYbiP/YInsFZ+hqL6ZqIfuws
 DZ9w==
X-Gm-Message-State: AC+VfDw2kS0hbuDPUFBDtOGzjncqgHVK4aIN5I0ZBOSXwLaodECV4vUF
 skd1qr51rGrXkL+qwSBu3ZhuC+zneZ+efGdZn7A=
X-Google-Smtp-Source: ACHHUZ7r21oRjLc7UMjxkNEme8BgR6ryKO4mRP5NHJuryTUUmZjbGbklES7IawKUqHbHEI4euHe+8w==
X-Received: by 2002:a17:903:32c7:b0:1ac:43ea:7882 with SMTP id
 i7-20020a17090332c700b001ac43ea7882mr7700810plr.29.1684600020328; 
 Sat, 20 May 2023 09:27:00 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:d078:d94e:cb2b:a055])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a170903230c00b001a5260a6e6csm1697104plh.206.2023.05.20.09.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 09:26:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 16/27] accel/tcg: Unify cpu_{ld,st}*_{be,le}_mmu
Date: Sat, 20 May 2023 09:26:23 -0700
Message-Id: <20230520162634.3991009-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230520162634.3991009-1-richard.henderson@linaro.org>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

With the current structure of cputlb.c, there is no difference
between the little-endian and big-endian entry points, aside
from the assert.  Unify the pairs of functions.

The only use of the functions with explicit endianness was in
target/sparc64, and that was only to satisfy the assert.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h     |  58 ++-----
 accel/tcg/cputlb.c          | 122 +++-----------
 accel/tcg/user-exec.c       | 322 ++++++++++--------------------------
 target/arm/tcg/m_helper.c   |   4 +-
 target/sparc/ldst_helper.c  |  18 +-
 accel/tcg/ldst_common.c.inc |  24 +--
 6 files changed, 137 insertions(+), 411 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 7c867c94c3..fc1d3d9301 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -207,43 +207,21 @@ void cpu_stq_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr, uint64_t val,
                           int mmu_idx, uintptr_t ra);
 
 uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr ptr, MemOpIdx oi, uintptr_t ra);
-uint16_t cpu_ldw_be_mmu(CPUArchState *env, abi_ptr ptr,
-                        MemOpIdx oi, uintptr_t ra);
-uint32_t cpu_ldl_be_mmu(CPUArchState *env, abi_ptr ptr,
-                        MemOpIdx oi, uintptr_t ra);
-uint64_t cpu_ldq_be_mmu(CPUArchState *env, abi_ptr ptr,
-                        MemOpIdx oi, uintptr_t ra);
-uint16_t cpu_ldw_le_mmu(CPUArchState *env, abi_ptr ptr,
-                        MemOpIdx oi, uintptr_t ra);
-uint32_t cpu_ldl_le_mmu(CPUArchState *env, abi_ptr ptr,
-                        MemOpIdx oi, uintptr_t ra);
-uint64_t cpu_ldq_le_mmu(CPUArchState *env, abi_ptr ptr,
-                        MemOpIdx oi, uintptr_t ra);
-
-Int128 cpu_ld16_be_mmu(CPUArchState *env, abi_ptr addr,
-                       MemOpIdx oi, uintptr_t ra);
-Int128 cpu_ld16_le_mmu(CPUArchState *env, abi_ptr addr,
-                       MemOpIdx oi, uintptr_t ra);
+uint16_t cpu_ldw_mmu(CPUArchState *env, abi_ptr ptr, MemOpIdx oi, uintptr_t ra);
+uint32_t cpu_ldl_mmu(CPUArchState *env, abi_ptr ptr, MemOpIdx oi, uintptr_t ra);
+uint64_t cpu_ldq_mmu(CPUArchState *env, abi_ptr ptr, MemOpIdx oi, uintptr_t ra);
+Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr, MemOpIdx oi, uintptr_t ra);
 
 void cpu_stb_mmu(CPUArchState *env, abi_ptr ptr, uint8_t val,
                  MemOpIdx oi, uintptr_t ra);
-void cpu_stw_be_mmu(CPUArchState *env, abi_ptr ptr, uint16_t val,
-                    MemOpIdx oi, uintptr_t ra);
-void cpu_stl_be_mmu(CPUArchState *env, abi_ptr ptr, uint32_t val,
-                    MemOpIdx oi, uintptr_t ra);
-void cpu_stq_be_mmu(CPUArchState *env, abi_ptr ptr, uint64_t val,
-                    MemOpIdx oi, uintptr_t ra);
-void cpu_stw_le_mmu(CPUArchState *env, abi_ptr ptr, uint16_t val,
-                    MemOpIdx oi, uintptr_t ra);
-void cpu_stl_le_mmu(CPUArchState *env, abi_ptr ptr, uint32_t val,
-                    MemOpIdx oi, uintptr_t ra);
-void cpu_stq_le_mmu(CPUArchState *env, abi_ptr ptr, uint64_t val,
-                    MemOpIdx oi, uintptr_t ra);
-
-void cpu_st16_be_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
-                     MemOpIdx oi, uintptr_t ra);
-void cpu_st16_le_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
-                     MemOpIdx oi, uintptr_t ra);
+void cpu_stw_mmu(CPUArchState *env, abi_ptr ptr, uint16_t val,
+                 MemOpIdx oi, uintptr_t ra);
+void cpu_stl_mmu(CPUArchState *env, abi_ptr ptr, uint32_t val,
+                 MemOpIdx oi, uintptr_t ra);
+void cpu_stq_mmu(CPUArchState *env, abi_ptr ptr, uint64_t val,
+                 MemOpIdx oi, uintptr_t ra);
+void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
+                  MemOpIdx oi, uintptr_t ra);
 
 uint32_t cpu_atomic_cmpxchgb_mmu(CPUArchState *env, target_ulong addr,
                                  uint32_t cmpv, uint32_t newv,
@@ -416,9 +394,6 @@ static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
 # define cpu_ldsw_mmuidx_ra   cpu_ldsw_be_mmuidx_ra
 # define cpu_ldl_mmuidx_ra    cpu_ldl_be_mmuidx_ra
 # define cpu_ldq_mmuidx_ra    cpu_ldq_be_mmuidx_ra
-# define cpu_ldw_mmu          cpu_ldw_be_mmu
-# define cpu_ldl_mmu          cpu_ldl_be_mmu
-# define cpu_ldq_mmu          cpu_ldq_be_mmu
 # define cpu_stw_data         cpu_stw_be_data
 # define cpu_stl_data         cpu_stl_be_data
 # define cpu_stq_data         cpu_stq_be_data
@@ -428,9 +403,6 @@ static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
 # define cpu_stw_mmuidx_ra    cpu_stw_be_mmuidx_ra
 # define cpu_stl_mmuidx_ra    cpu_stl_be_mmuidx_ra
 # define cpu_stq_mmuidx_ra    cpu_stq_be_mmuidx_ra
-# define cpu_stw_mmu          cpu_stw_be_mmu
-# define cpu_stl_mmu          cpu_stl_be_mmu
-# define cpu_stq_mmu          cpu_stq_be_mmu
 #else
 # define cpu_lduw_data        cpu_lduw_le_data
 # define cpu_ldsw_data        cpu_ldsw_le_data
@@ -444,9 +416,6 @@ static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
 # define cpu_ldsw_mmuidx_ra   cpu_ldsw_le_mmuidx_ra
 # define cpu_ldl_mmuidx_ra    cpu_ldl_le_mmuidx_ra
 # define cpu_ldq_mmuidx_ra    cpu_ldq_le_mmuidx_ra
-# define cpu_ldw_mmu          cpu_ldw_le_mmu
-# define cpu_ldl_mmu          cpu_ldl_le_mmu
-# define cpu_ldq_mmu          cpu_ldq_le_mmu
 # define cpu_stw_data         cpu_stw_le_data
 # define cpu_stl_data         cpu_stl_le_data
 # define cpu_stq_data         cpu_stq_le_data
@@ -456,9 +425,6 @@ static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
 # define cpu_stw_mmuidx_ra    cpu_stw_le_mmuidx_ra
 # define cpu_stl_mmuidx_ra    cpu_stl_le_mmuidx_ra
 # define cpu_stq_mmuidx_ra    cpu_stq_le_mmuidx_ra
-# define cpu_stw_mmu          cpu_stw_le_mmu
-# define cpu_stl_mmu          cpu_stl_le_mmu
-# define cpu_stq_mmu          cpu_stq_le_mmu
 #endif
 
 uint8_t cpu_ldb_code_mmu(CPUArchState *env, abi_ptr addr,
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ae0fbcdee2..b1e13d165c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2575,89 +2575,45 @@ uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr addr, MemOpIdx oi, uintptr_t ra)
     return ret;
 }
 
-uint16_t cpu_ldw_be_mmu(CPUArchState *env, abi_ptr addr,
-                        MemOpIdx oi, uintptr_t ra)
+uint16_t cpu_ldw_mmu(CPUArchState *env, abi_ptr addr,
+                     MemOpIdx oi, uintptr_t ra)
 {
     uint16_t ret;
 
-    tcg_debug_assert((get_memop(oi) & (MO_BSWAP | MO_SIZE)) == MO_BEUW);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
     ret = do_ld2_mmu(env, addr, oi, ra, MMU_DATA_LOAD);
     plugin_load_cb(env, addr, oi);
     return ret;
 }
 
-uint32_t cpu_ldl_be_mmu(CPUArchState *env, abi_ptr addr,
-                        MemOpIdx oi, uintptr_t ra)
+uint32_t cpu_ldl_mmu(CPUArchState *env, abi_ptr addr,
+                     MemOpIdx oi, uintptr_t ra)
 {
     uint32_t ret;
 
-    tcg_debug_assert((get_memop(oi) & (MO_BSWAP | MO_SIZE)) == MO_BEUL);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
     ret = do_ld4_mmu(env, addr, oi, ra, MMU_DATA_LOAD);
     plugin_load_cb(env, addr, oi);
     return ret;
 }
 
-uint64_t cpu_ldq_be_mmu(CPUArchState *env, abi_ptr addr,
-                        MemOpIdx oi, uintptr_t ra)
+uint64_t cpu_ldq_mmu(CPUArchState *env, abi_ptr addr,
+                     MemOpIdx oi, uintptr_t ra)
 {
     uint64_t ret;
 
-    tcg_debug_assert((get_memop(oi) & (MO_BSWAP | MO_SIZE)) == MO_BEUQ);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
     ret = do_ld8_mmu(env, addr, oi, ra, MMU_DATA_LOAD);
     plugin_load_cb(env, addr, oi);
     return ret;
 }
 
-uint16_t cpu_ldw_le_mmu(CPUArchState *env, abi_ptr addr,
-                        MemOpIdx oi, uintptr_t ra)
-{
-    uint16_t ret;
-
-    tcg_debug_assert((get_memop(oi) & (MO_BSWAP | MO_SIZE)) == MO_LEUW);
-    ret = do_ld2_mmu(env, addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
-    return ret;
-}
-
-uint32_t cpu_ldl_le_mmu(CPUArchState *env, abi_ptr addr,
-                        MemOpIdx oi, uintptr_t ra)
-{
-    uint32_t ret;
-
-    tcg_debug_assert((get_memop(oi) & (MO_BSWAP | MO_SIZE)) == MO_LEUL);
-    ret = do_ld4_mmu(env, addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
-    return ret;
-}
-
-uint64_t cpu_ldq_le_mmu(CPUArchState *env, abi_ptr addr,
-                        MemOpIdx oi, uintptr_t ra)
-{
-    uint64_t ret;
-
-    tcg_debug_assert((get_memop(oi) & (MO_BSWAP | MO_SIZE)) == MO_LEUQ);
-    ret = do_ld8_mmu(env, addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
-    return ret;
-}
-
-Int128 cpu_ld16_be_mmu(CPUArchState *env, abi_ptr addr,
-                       MemOpIdx oi, uintptr_t ra)
+Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
+                    MemOpIdx oi, uintptr_t ra)
 {
     Int128 ret;
 
-    tcg_debug_assert((get_memop(oi) & (MO_BSWAP|MO_SIZE)) == (MO_BE|MO_128));
-    ret = do_ld16_mmu(env, addr, oi, ra);
-    plugin_load_cb(env, addr, oi);
-    return ret;
-}
-
-Int128 cpu_ld16_le_mmu(CPUArchState *env, abi_ptr addr,
-                       MemOpIdx oi, uintptr_t ra)
-{
-    Int128 ret;
-
-    tcg_debug_assert((get_memop(oi) & (MO_BSWAP|MO_SIZE)) == (MO_LE|MO_128));
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
     ret = do_ld16_mmu(env, addr, oi, ra);
     plugin_load_cb(env, addr, oi);
     return ret;
@@ -3045,66 +3001,34 @@ void cpu_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
     plugin_store_cb(env, addr, oi);
 }
 
-void cpu_stw_be_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
-                    MemOpIdx oi, uintptr_t retaddr)
+void cpu_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
+                 MemOpIdx oi, uintptr_t retaddr)
 {
-    tcg_debug_assert((get_memop(oi) & (MO_BSWAP | MO_SIZE)) == MO_BEUW);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
     do_st2_mmu(env, addr, val, oi, retaddr);
     plugin_store_cb(env, addr, oi);
 }
 
-void cpu_stl_be_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
+void cpu_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
                     MemOpIdx oi, uintptr_t retaddr)
 {
-    tcg_debug_assert((get_memop(oi) & (MO_BSWAP | MO_SIZE)) == MO_BEUL);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
     do_st4_mmu(env, addr, val, oi, retaddr);
     plugin_store_cb(env, addr, oi);
 }
 
-void cpu_stq_be_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
-                    MemOpIdx oi, uintptr_t retaddr)
+void cpu_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
+                 MemOpIdx oi, uintptr_t retaddr)
 {
-    tcg_debug_assert((get_memop(oi) & (MO_BSWAP | MO_SIZE)) == MO_BEUQ);
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
     do_st8_mmu(env, addr, val, oi, retaddr);
     plugin_store_cb(env, addr, oi);
 }
 
-void cpu_stw_le_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
-                    MemOpIdx oi, uintptr_t retaddr)
+void cpu_st16_mmu(CPUArchState *env, target_ulong addr, Int128 val,
+                  MemOpIdx oi, uintptr_t retaddr)
 {
-    tcg_debug_assert((get_memop(oi) & (MO_BSWAP | MO_SIZE)) == MO_LEUW);
-    do_st2_mmu(env, addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
-}
-
-void cpu_stl_le_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
-                    MemOpIdx oi, uintptr_t retaddr)
-{
-    tcg_debug_assert((get_memop(oi) & (MO_BSWAP | MO_SIZE)) == MO_LEUL);
-    do_st4_mmu(env, addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
-}
-
-void cpu_stq_le_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
-                    MemOpIdx oi, uintptr_t retaddr)
-{
-    tcg_debug_assert((get_memop(oi) & (MO_BSWAP | MO_SIZE)) == MO_LEUQ);
-    do_st8_mmu(env, addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
-}
-
-void cpu_st16_be_mmu(CPUArchState *env, target_ulong addr, Int128 val,
-                     MemOpIdx oi, uintptr_t retaddr)
-{
-    tcg_debug_assert((get_memop(oi) & (MO_BSWAP|MO_SIZE)) == (MO_BE|MO_128));
-    do_st16_mmu(env, addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
-}
-
-void cpu_st16_le_mmu(CPUArchState *env, target_ulong addr, Int128 val,
-                     MemOpIdx oi, uintptr_t retaddr)
-{
-    tcg_debug_assert((get_memop(oi) & (MO_BSWAP|MO_SIZE)) == (MO_LE|MO_128));
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
     do_st16_mmu(env, addr, val, oi, retaddr);
     plugin_store_cb(env, addr, oi);
 }
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 36ad8284a5..19c2849c21 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -940,8 +940,8 @@ uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr addr,
     return ret;
 }
 
-static uint16_t do_ld2_he_mmu(CPUArchState *env, abi_ptr addr,
-                              MemOp mop, uintptr_t ra)
+static uint16_t do_ld2_mmu(CPUArchState *env, abi_ptr addr,
+                           MemOp mop, uintptr_t ra)
 {
     void *haddr;
     uint16_t ret;
@@ -950,59 +950,35 @@ static uint16_t do_ld2_he_mmu(CPUArchState *env, abi_ptr addr,
     haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_LOAD);
     ret = load_atom_2(env, ra, haddr, mop);
     clear_helper_retaddr();
+
+    if (mop & MO_BSWAP) {
+        ret = bswap16(ret);
+    }
     return ret;
 }
 
 tcg_target_ulong helper_lduw_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t ra)
 {
-    MemOp mop = get_memop(oi);
-    uint16_t ret = do_ld2_he_mmu(env, addr, mop, ra);
-
-    if (mop & MO_BSWAP) {
-        ret = bswap16(ret);
-    }
-    return ret;
+    return do_ld2_mmu(env, addr, get_memop(oi), ra);
 }
 
 tcg_target_ulong helper_ldsw_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t ra)
 {
-    MemOp mop = get_memop(oi);
-    int16_t ret = do_ld2_he_mmu(env, addr, mop, ra);
+    return (int16_t)do_ld2_mmu(env, addr, get_memop(oi), ra);
+}
 
-    if (mop & MO_BSWAP) {
-        ret = bswap16(ret);
-    }
+uint16_t cpu_ldw_mmu(CPUArchState *env, abi_ptr addr,
+                     MemOpIdx oi, uintptr_t ra)
+{
+    uint16_t ret = do_ld2_mmu(env, addr, get_memop(oi), ra);
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
     return ret;
 }
 
-uint16_t cpu_ldw_be_mmu(CPUArchState *env, abi_ptr addr,
-                        MemOpIdx oi, uintptr_t ra)
-{
-    MemOp mop = get_memop(oi);
-    uint16_t ret;
-
-    tcg_debug_assert((mop & MO_BSWAP) == MO_BE);
-    ret = do_ld2_he_mmu(env, addr, mop, ra);
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
-    return cpu_to_be16(ret);
-}
-
-uint16_t cpu_ldw_le_mmu(CPUArchState *env, abi_ptr addr,
-                        MemOpIdx oi, uintptr_t ra)
-{
-    MemOp mop = get_memop(oi);
-    uint16_t ret;
-
-    tcg_debug_assert((mop & MO_BSWAP) == MO_LE);
-    ret = do_ld2_he_mmu(env, addr, mop, ra);
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
-    return cpu_to_le16(ret);
-}
-
-static uint32_t do_ld4_he_mmu(CPUArchState *env, abi_ptr addr,
-                              MemOp mop, uintptr_t ra)
+static uint32_t do_ld4_mmu(CPUArchState *env, abi_ptr addr,
+                           MemOp mop, uintptr_t ra)
 {
     void *haddr;
     uint32_t ret;
@@ -1011,59 +987,35 @@ static uint32_t do_ld4_he_mmu(CPUArchState *env, abi_ptr addr,
     haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_LOAD);
     ret = load_atom_4(env, ra, haddr, mop);
     clear_helper_retaddr();
+
+    if (mop & MO_BSWAP) {
+        ret = bswap32(ret);
+    }
     return ret;
 }
 
 tcg_target_ulong helper_ldul_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t ra)
 {
-    MemOp mop = get_memop(oi);
-    uint32_t ret = do_ld4_he_mmu(env, addr, mop, ra);
-
-    if (mop & MO_BSWAP) {
-        ret = bswap32(ret);
-    }
-    return ret;
+    return do_ld4_mmu(env, addr, get_memop(oi), ra);
 }
 
 tcg_target_ulong helper_ldsl_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t ra)
 {
-    MemOp mop = get_memop(oi);
-    int32_t ret = do_ld4_he_mmu(env, addr, mop, ra);
+    return (int32_t)do_ld4_mmu(env, addr, get_memop(oi), ra);
+}
 
-    if (mop & MO_BSWAP) {
-        ret = bswap32(ret);
-    }
+uint32_t cpu_ldl_mmu(CPUArchState *env, abi_ptr addr,
+                     MemOpIdx oi, uintptr_t ra)
+{
+    uint32_t ret = do_ld4_mmu(env, addr, get_memop(oi), ra);
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
     return ret;
 }
 
-uint32_t cpu_ldl_be_mmu(CPUArchState *env, abi_ptr addr,
-                        MemOpIdx oi, uintptr_t ra)
-{
-    MemOp mop = get_memop(oi);
-    uint32_t ret;
-
-    tcg_debug_assert((mop & MO_BSWAP) == MO_BE);
-    ret = do_ld4_he_mmu(env, addr, mop, ra);
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
-    return cpu_to_be32(ret);
-}
-
-uint32_t cpu_ldl_le_mmu(CPUArchState *env, abi_ptr addr,
-                        MemOpIdx oi, uintptr_t ra)
-{
-    MemOp mop = get_memop(oi);
-    uint32_t ret;
-
-    tcg_debug_assert((mop & MO_BSWAP) == MO_LE);
-    ret = do_ld4_he_mmu(env, addr, mop, ra);
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
-    return cpu_to_le32(ret);
-}
-
-static uint64_t do_ld8_he_mmu(CPUArchState *env, abi_ptr addr,
-                              MemOp mop, uintptr_t ra)
+static uint64_t do_ld8_mmu(CPUArchState *env, abi_ptr addr,
+                           MemOp mop, uintptr_t ra)
 {
     void *haddr;
     uint64_t ret;
@@ -1072,14 +1024,6 @@ static uint64_t do_ld8_he_mmu(CPUArchState *env, abi_ptr addr,
     haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_LOAD);
     ret = load_atom_8(env, ra, haddr, mop);
     clear_helper_retaddr();
-    return ret;
-}
-
-uint64_t helper_ldq_mmu(CPUArchState *env, uint64_t addr,
-                        MemOpIdx oi, uintptr_t ra)
-{
-    MemOp mop = get_memop(oi);
-    uint64_t ret = do_ld8_he_mmu(env, addr, mop, ra);
 
     if (mop & MO_BSWAP) {
         ret = bswap64(ret);
@@ -1087,32 +1031,22 @@ uint64_t helper_ldq_mmu(CPUArchState *env, uint64_t addr,
     return ret;
 }
 
-uint64_t cpu_ldq_be_mmu(CPUArchState *env, abi_ptr addr,
+uint64_t helper_ldq_mmu(CPUArchState *env, uint64_t addr,
                         MemOpIdx oi, uintptr_t ra)
 {
-    MemOp mop = get_memop(oi);
-    uint64_t ret;
-
-    tcg_debug_assert((mop & MO_BSWAP) == MO_BE);
-    ret = do_ld8_he_mmu(env, addr, mop, ra);
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
-    return cpu_to_be64(ret);
+    return do_ld8_mmu(env, addr, get_memop(oi), ra);
 }
 
-uint64_t cpu_ldq_le_mmu(CPUArchState *env, abi_ptr addr,
-                        MemOpIdx oi, uintptr_t ra)
+uint64_t cpu_ldq_mmu(CPUArchState *env, abi_ptr addr,
+                     MemOpIdx oi, uintptr_t ra)
 {
-    MemOp mop = get_memop(oi);
-    uint64_t ret;
-
-    tcg_debug_assert((mop & MO_BSWAP) == MO_LE);
-    ret = do_ld8_he_mmu(env, addr, mop, ra);
+    uint64_t ret = do_ld8_mmu(env, addr, get_memop(oi), ra);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
-    return cpu_to_le64(ret);
+    return ret;
 }
 
-static Int128 do_ld16_he_mmu(CPUArchState *env, abi_ptr addr,
-                             MemOp mop, uintptr_t ra)
+static Int128 do_ld16_mmu(CPUArchState *env, abi_ptr addr,
+                          MemOp mop, uintptr_t ra)
 {
     void *haddr;
     Int128 ret;
@@ -1121,14 +1055,6 @@ static Int128 do_ld16_he_mmu(CPUArchState *env, abi_ptr addr,
     haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_LOAD);
     ret = load_atom_16(env, ra, haddr, mop);
     clear_helper_retaddr();
-    return ret;
-}
-
-Int128 helper_ld16_mmu(CPUArchState *env, uint64_t addr,
-                       MemOpIdx oi, uintptr_t ra)
-{
-    MemOp mop = get_memop(oi);
-    Int128 ret = do_ld16_he_mmu(env, addr, mop, ra);
 
     if (mop & MO_BSWAP) {
         ret = bswap128(ret);
@@ -1136,38 +1062,22 @@ Int128 helper_ld16_mmu(CPUArchState *env, uint64_t addr,
     return ret;
 }
 
+Int128 helper_ld16_mmu(CPUArchState *env, uint64_t addr,
+                       MemOpIdx oi, uintptr_t ra)
+{
+    return do_ld16_mmu(env, addr, get_memop(oi), ra);
+}
+
 Int128 helper_ld_i128(CPUArchState *env, uint64_t addr, MemOpIdx oi)
 {
     return helper_ld16_mmu(env, addr, oi, GETPC());
 }
 
-Int128 cpu_ld16_be_mmu(CPUArchState *env, abi_ptr addr,
-                       MemOpIdx oi, uintptr_t ra)
+Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
+                    MemOpIdx oi, uintptr_t ra)
 {
-    MemOp mop = get_memop(oi);
-    Int128 ret;
-
-    tcg_debug_assert((mop & MO_BSWAP) == MO_BE);
-    ret = do_ld16_he_mmu(env, addr, mop, ra);
+    Int128 ret = do_ld16_mmu(env, addr, get_memop(oi), ra);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
-    if (!HOST_BIG_ENDIAN) {
-        ret = bswap128(ret);
-    }
-    return ret;
-}
-
-Int128 cpu_ld16_le_mmu(CPUArchState *env, abi_ptr addr,
-                       MemOpIdx oi, uintptr_t ra)
-{
-    MemOp mop = get_memop(oi);
-    Int128 ret;
-
-    tcg_debug_assert((mop & MO_BSWAP) == MO_LE);
-    ret = do_ld16_he_mmu(env, addr, mop, ra);
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
-    if (HOST_BIG_ENDIAN) {
-        ret = bswap128(ret);
-    }
     return ret;
 }
 
@@ -1195,13 +1105,17 @@ void cpu_stb_mmu(CPUArchState *env, abi_ptr addr, uint8_t val,
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
 }
 
-static void do_st2_he_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
-                          MemOp mop, uintptr_t ra)
+static void do_st2_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
+                       MemOp mop, uintptr_t ra)
 {
     void *haddr;
 
     tcg_debug_assert((mop & MO_SIZE) == MO_16);
     haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_STORE);
+
+    if (mop & MO_BSWAP) {
+        val = bswap16(val);
+    }
     store_atom_2(env, ra, haddr, mop, val);
     clear_helper_retaddr();
 }
@@ -1209,41 +1123,27 @@ static void do_st2_he_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
 void helper_stw_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
                     MemOpIdx oi, uintptr_t ra)
 {
-    MemOp mop = get_memop(oi);
-
-    if (mop & MO_BSWAP) {
-        val = bswap16(val);
-    }
-    do_st2_he_mmu(env, addr, val, mop, ra);
+    do_st2_mmu(env, addr, val, get_memop(oi), ra);
 }
 
-void cpu_stw_be_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
+void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
                     MemOpIdx oi, uintptr_t ra)
 {
-    MemOp mop = get_memop(oi);
-
-    tcg_debug_assert((mop & MO_BSWAP) == MO_BE);
-    do_st2_he_mmu(env, addr, be16_to_cpu(val), mop, ra);
+    do_st2_mmu(env, addr, val, get_memop(oi), ra);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
 }
 
-void cpu_stw_le_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
-                    MemOpIdx oi, uintptr_t ra)
-{
-    MemOp mop = get_memop(oi);
-
-    tcg_debug_assert((mop & MO_BSWAP) == MO_LE);
-    do_st2_he_mmu(env, addr, le16_to_cpu(val), mop, ra);
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
-}
-
-static void do_st4_he_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
-                          MemOp mop, uintptr_t ra)
+static void do_st4_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
+                       MemOp mop, uintptr_t ra)
 {
     void *haddr;
 
     tcg_debug_assert((mop & MO_SIZE) == MO_32);
     haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_STORE);
+
+    if (mop & MO_BSWAP) {
+        val = bswap32(val);
+    }
     store_atom_4(env, ra, haddr, mop, val);
     clear_helper_retaddr();
 }
@@ -1251,41 +1151,27 @@ static void do_st4_he_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
 void helper_stl_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
                     MemOpIdx oi, uintptr_t ra)
 {
-    MemOp mop = get_memop(oi);
-
-    if (mop & MO_BSWAP) {
-        val = bswap32(val);
-    }
-    do_st4_he_mmu(env, addr, val, mop, ra);
+    do_st4_mmu(env, addr, val, get_memop(oi), ra);
 }
 
-void cpu_stl_be_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
-                    MemOpIdx oi, uintptr_t ra)
+void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
+                 MemOpIdx oi, uintptr_t ra)
 {
-    MemOp mop = get_memop(oi);
-
-    tcg_debug_assert((mop & MO_BSWAP) == MO_BE);
-    do_st4_he_mmu(env, addr, be32_to_cpu(val), mop, ra);
+    do_st4_mmu(env, addr, val, get_memop(oi), ra);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
 }
 
-void cpu_stl_le_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
-                    MemOpIdx oi, uintptr_t ra)
-{
-    MemOp mop = get_memop(oi);
-
-    tcg_debug_assert((mop & MO_BSWAP) == MO_LE);
-    do_st4_he_mmu(env, addr, le32_to_cpu(val), mop, ra);
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
-}
-
-static void do_st8_he_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
-                          MemOp mop, uintptr_t ra)
+static void do_st8_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
+                       MemOp mop, uintptr_t ra)
 {
     void *haddr;
 
     tcg_debug_assert((mop & MO_SIZE) == MO_64);
     haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_STORE);
+
+    if (mop & MO_BSWAP) {
+        val = bswap64(val);
+    }
     store_atom_8(env, ra, haddr, mop, val);
     clear_helper_retaddr();
 }
@@ -1293,41 +1179,27 @@ static void do_st8_he_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
 void helper_stq_mmu(CPUArchState *env, uint64_t addr, uint64_t val,
                     MemOpIdx oi, uintptr_t ra)
 {
-    MemOp mop = get_memop(oi);
-
-    if (mop & MO_BSWAP) {
-        val = bswap64(val);
-    }
-    do_st8_he_mmu(env, addr, val, mop, ra);
+    do_st8_mmu(env, addr, val, get_memop(oi), ra);
 }
 
-void cpu_stq_be_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
+void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
                     MemOpIdx oi, uintptr_t ra)
 {
-    MemOp mop = get_memop(oi);
-
-    tcg_debug_assert((mop & MO_BSWAP) == MO_BE);
-    do_st8_he_mmu(env, addr, cpu_to_be64(val), mop, ra);
+    do_st8_mmu(env, addr, val, get_memop(oi), ra);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
 }
 
-void cpu_stq_le_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
-                    MemOpIdx oi, uintptr_t ra)
-{
-    MemOp mop = get_memop(oi);
-
-    tcg_debug_assert((mop & MO_BSWAP) == MO_LE);
-    do_st8_he_mmu(env, addr, cpu_to_le64(val), mop, ra);
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
-}
-
-static void do_st16_he_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
-                           MemOp mop, uintptr_t ra)
+static void do_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
+                        MemOp mop, uintptr_t ra)
 {
     void *haddr;
 
     tcg_debug_assert((mop & MO_SIZE) == MO_128);
     haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_STORE);
+
+    if (mop & MO_BSWAP) {
+        val = bswap128(val);
+    }
     store_atom_16(env, ra, haddr, mop, val);
     clear_helper_retaddr();
 }
@@ -1335,12 +1207,7 @@ static void do_st16_he_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
 void helper_st16_mmu(CPUArchState *env, uint64_t addr, Int128 val,
                      MemOpIdx oi, uintptr_t ra)
 {
-    MemOp mop = get_memop(oi);
-
-    if (mop & MO_BSWAP) {
-        val = bswap128(val);
-    }
-    do_st16_he_mmu(env, addr, val, mop, ra);
+    do_st16_mmu(env, addr, val, get_memop(oi), ra);
 }
 
 void helper_st_i128(CPUArchState *env, uint64_t addr, Int128 val, MemOpIdx oi)
@@ -1348,29 +1215,10 @@ void helper_st_i128(CPUArchState *env, uint64_t addr, Int128 val, MemOpIdx oi)
     helper_st16_mmu(env, addr, val, oi, GETPC());
 }
 
-void cpu_st16_be_mmu(CPUArchState *env, abi_ptr addr,
-                     Int128 val, MemOpIdx oi, uintptr_t ra)
+void cpu_st16_mmu(CPUArchState *env, abi_ptr addr,
+                  Int128 val, MemOpIdx oi, uintptr_t ra)
 {
-    MemOp mop = get_memop(oi);
-
-    tcg_debug_assert((mop & MO_BSWAP) == MO_BE);
-    if (!HOST_BIG_ENDIAN) {
-        val = bswap128(val);
-    }
-    do_st16_he_mmu(env, addr, val, mop, ra);
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
-}
-
-void cpu_st16_le_mmu(CPUArchState *env, abi_ptr addr,
-                     Int128 val, MemOpIdx oi, uintptr_t ra)
-{
-    MemOp mop = get_memop(oi);
-
-    tcg_debug_assert((mop & MO_BSWAP) == MO_LE);
-    if (HOST_BIG_ENDIAN) {
-        val = bswap128(val);
-    }
-    do_st16_he_mmu(env, addr, val, mop, ra);
+    do_st16_mmu(env, addr, val, get_memop(oi), ra);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
 }
 
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 9758f225d6..9cef70e5c9 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -1937,8 +1937,8 @@ static bool do_v7m_function_return(ARMCPU *cpu)
          */
         mmu_idx = arm_v7m_mmu_idx_for_secstate(env, true);
         oi = make_memop_idx(MO_LEUL, arm_to_core_mmu_idx(mmu_idx));
-        newpc = cpu_ldl_le_mmu(env, frameptr, oi, 0);
-        newpsr = cpu_ldl_le_mmu(env, frameptr + 4, oi, 0);
+        newpc = cpu_ldl_mmu(env, frameptr, oi, 0);
+        newpsr = cpu_ldl_mmu(env, frameptr + 4, oi, 0);
 
         /* Consistency checks on new IPSR */
         newpsr_exc = newpsr & XPSR_EXCP;
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 7972d56a72..981a47d8bb 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1334,25 +1334,13 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
                 ret = cpu_ldb_mmu(env, addr, oi, GETPC());
                 break;
             case 2:
-                if (asi & 8) {
-                    ret = cpu_ldw_le_mmu(env, addr, oi, GETPC());
-                } else {
-                    ret = cpu_ldw_be_mmu(env, addr, oi, GETPC());
-                }
+                ret = cpu_ldw_mmu(env, addr, oi, GETPC());
                 break;
             case 4:
-                if (asi & 8) {
-                    ret = cpu_ldl_le_mmu(env, addr, oi, GETPC());
-                } else {
-                    ret = cpu_ldl_be_mmu(env, addr, oi, GETPC());
-                }
+                ret = cpu_ldl_mmu(env, addr, oi, GETPC());
                 break;
             case 8:
-                if (asi & 8) {
-                    ret = cpu_ldq_le_mmu(env, addr, oi, GETPC());
-                } else {
-                    ret = cpu_ldq_be_mmu(env, addr, oi, GETPC());
-                }
+                ret = cpu_ldq_mmu(env, addr, oi, GETPC());
                 break;
             default:
                 g_assert_not_reached();
diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
index 6ac8d871a3..5f8144b33a 100644
--- a/accel/tcg/ldst_common.c.inc
+++ b/accel/tcg/ldst_common.c.inc
@@ -26,7 +26,7 @@ uint32_t cpu_lduw_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
                                int mmu_idx, uintptr_t ra)
 {
     MemOpIdx oi = make_memop_idx(MO_BEUW | MO_UNALN, mmu_idx);
-    return cpu_ldw_be_mmu(env, addr, oi, ra);
+    return cpu_ldw_mmu(env, addr, oi, ra);
 }
 
 int cpu_ldsw_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
@@ -39,21 +39,21 @@ uint32_t cpu_ldl_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
                               int mmu_idx, uintptr_t ra)
 {
     MemOpIdx oi = make_memop_idx(MO_BEUL | MO_UNALN, mmu_idx);
-    return cpu_ldl_be_mmu(env, addr, oi, ra);
+    return cpu_ldl_mmu(env, addr, oi, ra);
 }
 
 uint64_t cpu_ldq_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
                               int mmu_idx, uintptr_t ra)
 {
     MemOpIdx oi = make_memop_idx(MO_BEUQ | MO_UNALN, mmu_idx);
-    return cpu_ldq_be_mmu(env, addr, oi, ra);
+    return cpu_ldq_mmu(env, addr, oi, ra);
 }
 
 uint32_t cpu_lduw_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
                                int mmu_idx, uintptr_t ra)
 {
     MemOpIdx oi = make_memop_idx(MO_LEUW | MO_UNALN, mmu_idx);
-    return cpu_ldw_le_mmu(env, addr, oi, ra);
+    return cpu_ldw_mmu(env, addr, oi, ra);
 }
 
 int cpu_ldsw_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
@@ -66,14 +66,14 @@ uint32_t cpu_ldl_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
                               int mmu_idx, uintptr_t ra)
 {
     MemOpIdx oi = make_memop_idx(MO_LEUL | MO_UNALN, mmu_idx);
-    return cpu_ldl_le_mmu(env, addr, oi, ra);
+    return cpu_ldl_mmu(env, addr, oi, ra);
 }
 
 uint64_t cpu_ldq_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
                               int mmu_idx, uintptr_t ra)
 {
     MemOpIdx oi = make_memop_idx(MO_LEUQ | MO_UNALN, mmu_idx);
-    return cpu_ldq_le_mmu(env, addr, oi, ra);
+    return cpu_ldq_mmu(env, addr, oi, ra);
 }
 
 void cpu_stb_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
@@ -87,42 +87,42 @@ void cpu_stw_be_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
                           int mmu_idx, uintptr_t ra)
 {
     MemOpIdx oi = make_memop_idx(MO_BEUW | MO_UNALN, mmu_idx);
-    cpu_stw_be_mmu(env, addr, val, oi, ra);
+    cpu_stw_mmu(env, addr, val, oi, ra);
 }
 
 void cpu_stl_be_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
                           int mmu_idx, uintptr_t ra)
 {
     MemOpIdx oi = make_memop_idx(MO_BEUL | MO_UNALN, mmu_idx);
-    cpu_stl_be_mmu(env, addr, val, oi, ra);
+    cpu_stl_mmu(env, addr, val, oi, ra);
 }
 
 void cpu_stq_be_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
                           int mmu_idx, uintptr_t ra)
 {
     MemOpIdx oi = make_memop_idx(MO_BEUQ | MO_UNALN, mmu_idx);
-    cpu_stq_be_mmu(env, addr, val, oi, ra);
+    cpu_stq_mmu(env, addr, val, oi, ra);
 }
 
 void cpu_stw_le_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
                           int mmu_idx, uintptr_t ra)
 {
     MemOpIdx oi = make_memop_idx(MO_LEUW | MO_UNALN, mmu_idx);
-    cpu_stw_le_mmu(env, addr, val, oi, ra);
+    cpu_stw_mmu(env, addr, val, oi, ra);
 }
 
 void cpu_stl_le_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
                           int mmu_idx, uintptr_t ra)
 {
     MemOpIdx oi = make_memop_idx(MO_LEUL | MO_UNALN, mmu_idx);
-    cpu_stl_le_mmu(env, addr, val, oi, ra);
+    cpu_stl_mmu(env, addr, val, oi, ra);
 }
 
 void cpu_stq_le_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
                           int mmu_idx, uintptr_t ra)
 {
     MemOpIdx oi = make_memop_idx(MO_LEUQ | MO_UNALN, mmu_idx);
-    cpu_stq_le_mmu(env, addr, val, oi, ra);
+    cpu_stq_mmu(env, addr, val, oi, ra);
 }
 
 /*--------------------------*/
-- 
2.34.1



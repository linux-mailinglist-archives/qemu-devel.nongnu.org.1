Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA08705819
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:57:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0ca-0000qG-4k; Tue, 16 May 2023 15:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cC-0000F7-Nd
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:46 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0c6-0003hm-Jq
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:42 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-24decf5cc03so54291a91.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266336; x=1686858336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x76Mg4C5wSL1+atXcZvGeh9IH9ky2HxmUhpgDLdcbeQ=;
 b=WJ3d9XmsBt3SvUaJVMpcs4QM8Gc/hfgfIRhz9O3B9fmMSuLW6DkFbHR1S9k/+WQC8B
 ICDc2icNqTDIOdmAwO4bxAs6qZRhIFJJLk9HRNB20aX+1i4n27bbMqZa/+r62968AhbU
 0Y23TJnLRbtFoUWNgnuwn8ca0djGIs+IO1XbDYGHwwpsouZBjCedWk9Q5Kln46c6F9YN
 vSysJPGkDfVAbghp5rsJHH4Lsjc+SFgJHYtyLEB1sUqQ1BMKITwjHT1Ae8zdm8Lt4boC
 xI3wJ/pO3hu6vQrLoaV5taTj8qhiZMm4q3wTnZH/oAPxq/dihsoqpEMYmVEcRhDyAuBC
 6wOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266336; x=1686858336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x76Mg4C5wSL1+atXcZvGeh9IH9ky2HxmUhpgDLdcbeQ=;
 b=C8mvpM3mDFC5pmcHfUIATAb3McZhJn/3vZyDXlKLzXFF7iyjH529Mxj4/d1J/3ObMK
 IAcLh8gJkFy77A0YhO3qo6lHAp4ertlZK9Ftsas42D5uRQo8imzFLBK39At726TMfyUu
 s8+kA7EkzhcJ83Dx9GWm+kHrAkdctPJuEQlF5pMB+L4mOGl6u8r6mvvKMtQu/DIRSlH8
 ErlVjtpg3wnZA5aaS21LdAcZkerSqIR/TmqNqWlnvgEfgWhiB2pZhCdzp+znOcG3iGsv
 k5vVQzz2xOlChsyrxACWvIBuJdpDiS6TcuKGxfMylrKsF6ihEHMQz6lovEfnQ4x1u2An
 SvGA==
X-Gm-Message-State: AC+VfDyHD8ipDcyPkSOboMqFnAPIDpLXRSC84cm7bJYtajVJSAq54WOF
 X5G67JwedSx5KTXUqHImS9j4hgCfuOaBtyQz7R8=
X-Google-Smtp-Source: ACHHUZ4ocFKf3uHeQ/uJ1o00+jGn/V/sybRcn+0WX2y9RStoBSIVFwbFTvQwSx60LVEp69sr2slLhg==
X-Received: by 2002:a17:90a:b897:b0:253:38bf:9757 with SMTP id
 o23-20020a17090ab89700b0025338bf9757mr1232850pjr.43.1684266336432; 
 Tue, 16 May 2023 12:45:36 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 55/80] accel/tcg: Widen tcg-ldst.h addresses to uint64_t
Date: Tue, 16 May 2023 12:41:20 -0700
Message-Id: <20230516194145.1749305-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Always pass the target address as uint64_t.
Adjust tcg_out_{ld,st}_helper_args to match.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-ldst.h | 26 +++++++++---------
 accel/tcg/cputlb.c     | 26 +++++++++---------
 accel/tcg/user-exec.c  | 26 +++++++++---------
 tcg/tcg.c              | 62 ++++++++++++++++++++++++++++++++----------
 4 files changed, 87 insertions(+), 53 deletions(-)

diff --git a/include/tcg/tcg-ldst.h b/include/tcg/tcg-ldst.h
index 7dd57013e9..6ccfe9131d 100644
--- a/include/tcg/tcg-ldst.h
+++ b/include/tcg/tcg-ldst.h
@@ -26,38 +26,38 @@
 #define TCG_LDST_H
 
 /* Value zero-extended to tcg register size.  */
-tcg_target_ulong helper_ldub_mmu(CPUArchState *env, target_ulong addr,
+tcg_target_ulong helper_ldub_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t retaddr);
-tcg_target_ulong helper_lduw_mmu(CPUArchState *env, target_ulong addr,
+tcg_target_ulong helper_lduw_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t retaddr);
-tcg_target_ulong helper_ldul_mmu(CPUArchState *env, target_ulong addr,
+tcg_target_ulong helper_ldul_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t retaddr);
-uint64_t helper_ldq_mmu(CPUArchState *env, target_ulong addr,
+uint64_t helper_ldq_mmu(CPUArchState *env, uint64_t addr,
                         MemOpIdx oi, uintptr_t retaddr);
-Int128 helper_ld16_mmu(CPUArchState *env, target_ulong addr,
+Int128 helper_ld16_mmu(CPUArchState *env, uint64_t addr,
                        MemOpIdx oi, uintptr_t retaddr);
 
 /* Value sign-extended to tcg register size.  */
-tcg_target_ulong helper_ldsb_mmu(CPUArchState *env, target_ulong addr,
+tcg_target_ulong helper_ldsb_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t retaddr);
-tcg_target_ulong helper_ldsw_mmu(CPUArchState *env, target_ulong addr,
+tcg_target_ulong helper_ldsw_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t retaddr);
-tcg_target_ulong helper_ldsl_mmu(CPUArchState *env, target_ulong addr,
+tcg_target_ulong helper_ldsl_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t retaddr);
 
 /*
  * Value extended to at least uint32_t, so that some ABIs do not require
  * zero-extension from uint8_t or uint16_t.
  */
-void helper_stb_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
+void helper_stb_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
                     MemOpIdx oi, uintptr_t retaddr);
-void helper_stw_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
+void helper_stw_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
                     MemOpIdx oi, uintptr_t retaddr);
-void helper_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
+void helper_stl_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
                     MemOpIdx oi, uintptr_t retaddr);
-void helper_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
+void helper_stq_mmu(CPUArchState *env, uint64_t addr, uint64_t val,
                     MemOpIdx oi, uintptr_t retaddr);
-void helper_st16_mmu(CPUArchState *env, target_ulong addr, Int128 val,
+void helper_st16_mmu(CPUArchState *env, uint64_t addr, Int128 val,
                      MemOpIdx oi, uintptr_t retaddr);
 
 #endif /* TCG_LDST_H */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 49e49f75a4..5440f68deb 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2367,7 +2367,7 @@ static uint8_t do_ld1_mmu(CPUArchState *env, target_ulong addr, MemOpIdx oi,
     return do_ld_1(env, &l.page[0], l.mmu_idx, access_type, ra);
 }
 
-tcg_target_ulong helper_ldub_mmu(CPUArchState *env, target_ulong addr,
+tcg_target_ulong helper_ldub_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_8);
@@ -2398,7 +2398,7 @@ static uint16_t do_ld2_mmu(CPUArchState *env, target_ulong addr, MemOpIdx oi,
     return ret;
 }
 
-tcg_target_ulong helper_lduw_mmu(CPUArchState *env, target_ulong addr,
+tcg_target_ulong helper_lduw_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
@@ -2425,7 +2425,7 @@ static uint32_t do_ld4_mmu(CPUArchState *env, target_ulong addr, MemOpIdx oi,
     return ret;
 }
 
-tcg_target_ulong helper_ldul_mmu(CPUArchState *env, target_ulong addr,
+tcg_target_ulong helper_ldul_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
@@ -2452,7 +2452,7 @@ static uint64_t do_ld8_mmu(CPUArchState *env, target_ulong addr, MemOpIdx oi,
     return ret;
 }
 
-uint64_t helper_ldq_mmu(CPUArchState *env, target_ulong addr,
+uint64_t helper_ldq_mmu(CPUArchState *env, uint64_t addr,
                         MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
@@ -2464,19 +2464,19 @@ uint64_t helper_ldq_mmu(CPUArchState *env, target_ulong addr,
  * avoid this for 64-bit data, or for 32-bit data on 32-bit host.
  */
 
-tcg_target_ulong helper_ldsb_mmu(CPUArchState *env, target_ulong addr,
+tcg_target_ulong helper_ldsb_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t retaddr)
 {
     return (int8_t)helper_ldub_mmu(env, addr, oi, retaddr);
 }
 
-tcg_target_ulong helper_ldsw_mmu(CPUArchState *env, target_ulong addr,
+tcg_target_ulong helper_ldsw_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t retaddr)
 {
     return (int16_t)helper_lduw_mmu(env, addr, oi, retaddr);
 }
 
-tcg_target_ulong helper_ldsl_mmu(CPUArchState *env, target_ulong addr,
+tcg_target_ulong helper_ldsl_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t retaddr)
 {
     return (int32_t)helper_ldul_mmu(env, addr, oi, retaddr);
@@ -2544,7 +2544,7 @@ static Int128 do_ld16_mmu(CPUArchState *env, target_ulong addr,
     return ret;
 }
 
-Int128 helper_ld16_mmu(CPUArchState *env, target_ulong addr,
+Int128 helper_ld16_mmu(CPUArchState *env, uint64_t addr,
                        uint32_t oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
@@ -2860,7 +2860,7 @@ static void do_st_8(CPUArchState *env, MMULookupPageData *p, uint64_t val,
     }
 }
 
-void helper_stb_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
+void helper_stb_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
                     MemOpIdx oi, uintptr_t ra)
 {
     MMULookupLocals l;
@@ -2895,7 +2895,7 @@ static void do_st2_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
     do_st_1(env, &l.page[1], b, l.mmu_idx, ra);
 }
 
-void helper_stw_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
+void helper_stw_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
                     MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
@@ -2922,7 +2922,7 @@ static void do_st4_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
     (void) do_st_leN(env, &l.page[1], val, l.mmu_idx, l.memop, ra);
 }
 
-void helper_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
+void helper_stl_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
                     MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
@@ -2949,7 +2949,7 @@ static void do_st8_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
     (void) do_st_leN(env, &l.page[1], val, l.mmu_idx, l.memop, ra);
 }
 
-void helper_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
+void helper_stq_mmu(CPUArchState *env, uint64_t addr, uint64_t val,
                     MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
@@ -3017,7 +3017,7 @@ static void do_st16_mmu(CPUArchState *env, target_ulong addr, Int128 val,
     }
 }
 
-void helper_st16_mmu(CPUArchState *env, target_ulong addr, Int128 val,
+void helper_st16_mmu(CPUArchState *env, uint64_t addr, Int128 val,
                      MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 7b824dcde8..9a7afb6f78 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -920,13 +920,13 @@ static uint8_t do_ld1_mmu(CPUArchState *env, abi_ptr addr,
     return ret;
 }
 
-tcg_target_ulong helper_ldub_mmu(CPUArchState *env, target_ulong addr,
+tcg_target_ulong helper_ldub_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t ra)
 {
     return do_ld1_mmu(env, addr, get_memop(oi), ra);
 }
 
-tcg_target_ulong helper_ldsb_mmu(CPUArchState *env, target_ulong addr,
+tcg_target_ulong helper_ldsb_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t ra)
 {
     return (int8_t)do_ld1_mmu(env, addr, get_memop(oi), ra);
@@ -953,7 +953,7 @@ static uint16_t do_ld2_he_mmu(CPUArchState *env, abi_ptr addr,
     return ret;
 }
 
-tcg_target_ulong helper_lduw_mmu(CPUArchState *env, target_ulong addr,
+tcg_target_ulong helper_lduw_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t ra)
 {
     MemOp mop = get_memop(oi);
@@ -965,7 +965,7 @@ tcg_target_ulong helper_lduw_mmu(CPUArchState *env, target_ulong addr,
     return ret;
 }
 
-tcg_target_ulong helper_ldsw_mmu(CPUArchState *env, target_ulong addr,
+tcg_target_ulong helper_ldsw_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t ra)
 {
     MemOp mop = get_memop(oi);
@@ -1014,7 +1014,7 @@ static uint32_t do_ld4_he_mmu(CPUArchState *env, abi_ptr addr,
     return ret;
 }
 
-tcg_target_ulong helper_ldul_mmu(CPUArchState *env, target_ulong addr,
+tcg_target_ulong helper_ldul_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t ra)
 {
     MemOp mop = get_memop(oi);
@@ -1026,7 +1026,7 @@ tcg_target_ulong helper_ldul_mmu(CPUArchState *env, target_ulong addr,
     return ret;
 }
 
-tcg_target_ulong helper_ldsl_mmu(CPUArchState *env, target_ulong addr,
+tcg_target_ulong helper_ldsl_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t ra)
 {
     MemOp mop = get_memop(oi);
@@ -1075,7 +1075,7 @@ static uint64_t do_ld8_he_mmu(CPUArchState *env, abi_ptr addr,
     return ret;
 }
 
-uint64_t helper_ldq_mmu(CPUArchState *env, target_ulong addr,
+uint64_t helper_ldq_mmu(CPUArchState *env, uint64_t addr,
                         MemOpIdx oi, uintptr_t ra)
 {
     MemOp mop = get_memop(oi);
@@ -1124,7 +1124,7 @@ static Int128 do_ld16_he_mmu(CPUArchState *env, abi_ptr addr,
     return ret;
 }
 
-Int128 helper_ld16_mmu(CPUArchState *env, target_ulong addr,
+Int128 helper_ld16_mmu(CPUArchState *env, uint64_t addr,
                        MemOpIdx oi, uintptr_t ra)
 {
     MemOp mop = get_memop(oi);
@@ -1182,7 +1182,7 @@ static void do_st1_mmu(CPUArchState *env, abi_ptr addr, uint8_t val,
     clear_helper_retaddr();
 }
 
-void helper_stb_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
+void helper_stb_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
                     MemOpIdx oi, uintptr_t ra)
 {
     do_st1_mmu(env, addr, val, get_memop(oi), ra);
@@ -1206,7 +1206,7 @@ static void do_st2_he_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
     clear_helper_retaddr();
 }
 
-void helper_stw_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
+void helper_stw_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
                     MemOpIdx oi, uintptr_t ra)
 {
     MemOp mop = get_memop(oi);
@@ -1248,7 +1248,7 @@ static void do_st4_he_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
     clear_helper_retaddr();
 }
 
-void helper_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
+void helper_stl_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
                     MemOpIdx oi, uintptr_t ra)
 {
     MemOp mop = get_memop(oi);
@@ -1290,7 +1290,7 @@ static void do_st8_he_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
     clear_helper_retaddr();
 }
 
-void helper_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
+void helper_stq_mmu(CPUArchState *env, uint64_t addr, uint64_t val,
                     MemOpIdx oi, uintptr_t ra)
 {
     MemOp mop = get_memop(oi);
@@ -1332,7 +1332,7 @@ static void do_st16_he_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
     clear_helper_retaddr();
 }
 
-void helper_st16_mmu(CPUArchState *env, target_ulong addr, Int128 val,
+void helper_st16_mmu(CPUArchState *env, uint64_t addr, Int128 val,
                      MemOpIdx oi, uintptr_t ra)
 {
     MemOp mop = get_memop(oi);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index da34e5ab22..cdd194639e 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -865,7 +865,7 @@ static TCGHelperInfo info_helper_ld32_mmu = {
     .flags = TCG_CALL_NO_WG,
     .typemask = dh_typemask(ttl, 0)  /* return tcg_target_ulong */
               | dh_typemask(env, 1)
-              | dh_typemask(tl, 2)   /* target_ulong addr */
+              | dh_typemask(i64, 2)  /* uint64_t addr */
               | dh_typemask(i32, 3)  /* unsigned oi */
               | dh_typemask(ptr, 4)  /* uintptr_t ra */
 };
@@ -874,7 +874,7 @@ static TCGHelperInfo info_helper_ld64_mmu = {
     .flags = TCG_CALL_NO_WG,
     .typemask = dh_typemask(i64, 0)  /* return uint64_t */
               | dh_typemask(env, 1)
-              | dh_typemask(tl, 2)   /* target_ulong addr */
+              | dh_typemask(i64, 2)  /* uint64_t addr */
               | dh_typemask(i32, 3)  /* unsigned oi */
               | dh_typemask(ptr, 4)  /* uintptr_t ra */
 };
@@ -883,7 +883,7 @@ static TCGHelperInfo info_helper_ld128_mmu = {
     .flags = TCG_CALL_NO_WG,
     .typemask = dh_typemask(i128, 0) /* return Int128 */
               | dh_typemask(env, 1)
-              | dh_typemask(tl, 2)   /* target_ulong addr */
+              | dh_typemask(i64, 2)  /* uint64_t addr */
               | dh_typemask(i32, 3)  /* unsigned oi */
               | dh_typemask(ptr, 4)  /* uintptr_t ra */
 };
@@ -892,7 +892,7 @@ static TCGHelperInfo info_helper_st32_mmu = {
     .flags = TCG_CALL_NO_WG,
     .typemask = dh_typemask(void, 0)
               | dh_typemask(env, 1)
-              | dh_typemask(tl, 2)   /* target_ulong addr */
+              | dh_typemask(i64, 2)  /* uint64_t addr */
               | dh_typemask(i32, 3)  /* uint32_t data */
               | dh_typemask(i32, 4)  /* unsigned oi */
               | dh_typemask(ptr, 5)  /* uintptr_t ra */
@@ -902,7 +902,7 @@ static TCGHelperInfo info_helper_st64_mmu = {
     .flags = TCG_CALL_NO_WG,
     .typemask = dh_typemask(void, 0)
               | dh_typemask(env, 1)
-              | dh_typemask(tl, 2)   /* target_ulong addr */
+              | dh_typemask(i64, 2)  /* uint64_t addr */
               | dh_typemask(i64, 3)  /* uint64_t data */
               | dh_typemask(i32, 4)  /* unsigned oi */
               | dh_typemask(ptr, 5)  /* uintptr_t ra */
@@ -912,7 +912,7 @@ static TCGHelperInfo info_helper_st128_mmu = {
     .flags = TCG_CALL_NO_WG,
     .typemask = dh_typemask(void, 0)
               | dh_typemask(env, 1)
-              | dh_typemask(tl, 2)   /* target_ulong addr */
+              | dh_typemask(i64, 2)  /* uint64_t addr */
               | dh_typemask(i128, 3) /* Int128 data */
               | dh_typemask(i32, 4)  /* unsigned oi */
               | dh_typemask(ptr, 5)  /* uintptr_t ra */
@@ -5595,11 +5595,26 @@ static void tcg_out_ld_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
     next_arg = 1;
 
     loc = &info->in[next_arg];
-    nmov = tcg_out_helper_add_mov(mov, loc, TCG_TYPE_TL, TCG_TYPE_TL,
-                                  ldst->addrlo_reg, ldst->addrhi_reg);
-    next_arg += nmov;
+    if (TCG_TARGET_REG_BITS == 64 || TARGET_LONG_BITS == 64) {
+        nmov = tcg_out_helper_add_mov(mov, loc, TCG_TYPE_I64, TCG_TYPE_TL,
+                                      ldst->addrlo_reg, ldst->addrhi_reg);
+        tcg_out_helper_load_slots(s, nmov, mov, parm);
+        next_arg += nmov;
+    } else {
+        /*
+         * 32-bit host with 32-bit guest: zero-extend the guest address
+         * to 64-bits for the helper by storing the low part, then
+         * load a zero for the high part.
+         */
+        tcg_out_helper_add_mov(mov, loc + HOST_BIG_ENDIAN,
+                               TCG_TYPE_I32, TCG_TYPE_I32,
+                               ldst->addrlo_reg, -1);
+        tcg_out_helper_load_slots(s, 1, mov, parm);
 
-    tcg_out_helper_load_slots(s, nmov, mov, parm);
+        tcg_out_helper_load_imm(s, loc[!HOST_BIG_ENDIAN].arg_slot,
+                                TCG_TYPE_I32, 0, parm);
+        next_arg += 2;
+    }
 
     switch (info->out_kind) {
     case TCG_CALL_RET_NORMAL:
@@ -5753,10 +5768,24 @@ static void tcg_out_st_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
 
     /* Handle addr argument. */
     loc = &info->in[next_arg];
-    n = tcg_out_helper_add_mov(mov, loc, TCG_TYPE_TL, TCG_TYPE_TL,
-                               ldst->addrlo_reg, ldst->addrhi_reg);
-    next_arg += n;
-    nmov += n;
+    if (TCG_TARGET_REG_BITS == 64 || TARGET_LONG_BITS == 64) {
+        n = tcg_out_helper_add_mov(mov, loc, TCG_TYPE_I64, TCG_TYPE_TL,
+                                   ldst->addrlo_reg, ldst->addrhi_reg);
+        next_arg += n;
+        nmov += n;
+    } else {
+        /*
+         * 32-bit host with 32-bit guest: zero-extend the guest address
+         * to 64-bits for the helper by storing the low part.  Later,
+         * after we have processed the register inputs, we will load a
+         * zero for the high part.
+         */
+        tcg_out_helper_add_mov(mov, loc + HOST_BIG_ENDIAN,
+                               TCG_TYPE_I32, TCG_TYPE_I32,
+                               ldst->addrlo_reg, -1);
+        next_arg += 2;
+        nmov += 1;
+    }
 
     /* Handle data argument. */
     loc = &info->in[next_arg];
@@ -5801,6 +5830,11 @@ static void tcg_out_st_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
         g_assert_not_reached();
     }
 
+    if (TCG_TARGET_REG_BITS == 32 && TARGET_LONG_BITS == 32) {
+        loc = &info->in[1 + !HOST_BIG_ENDIAN];
+        tcg_out_helper_load_imm(s, loc->arg_slot, TCG_TYPE_I32, 0, parm);
+    }
+
     tcg_out_helper_load_common_args(s, ldst, parm, info, next_arg);
 }
 
-- 
2.34.1



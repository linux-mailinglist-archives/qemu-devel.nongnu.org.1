Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 146E0705823
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:59:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0cX-0000le-M8; Tue, 16 May 2023 15:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cC-0000F8-Nm
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:46 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0c8-0003kD-Fj
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:43 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ae3f6e5d70so476295ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266337; x=1686858337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fSOV4jl3j5hzwAPTwI3x2Fzdh0+s6tsMA+VJ/6oh0dE=;
 b=TNURn/+wcOw0pA0vz/YDrAomaGJWsv0oCwqbpP5XUAh3dSj4sYkyXia8NZdzffQhE0
 ObzTonhoU8vCoMc2nEYxZlCWzkQMbvzsGf+USr4QNm1+5HWUm2bxIrqmGx1o/PVPNKLs
 IEbJMQpSSw1FyRG/cSwWl82vWLeuWP8nnLfzsxmRCph3zdevQRbhIXCREjaAp50Yy7qL
 cqvF7vaKHd80kbBEZLOtCivqrUkkEuNzOjHKX5jJkDNgX0eS8Hc/LaZRQyqO3eO9DDIX
 eMNo08bcZWXWJ+C8nJiN/SzULs1sjMKWSAVtcCvED//VD8cGnznPU5ubDvDP1bK+Q1hg
 BxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266337; x=1686858337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fSOV4jl3j5hzwAPTwI3x2Fzdh0+s6tsMA+VJ/6oh0dE=;
 b=d7P8Ievak273/ZRnKt6+DxdhQdfPxMg9qO1xFA+ELXo8Mnx8P1e1hoV30EJM+f6gOo
 5iDNwfuH2KrPLZPY0TEgU4dDwNQdENT0qjp1Q13NH10ty/nKXIO0RnJEF3Qw02kh6AUT
 BW2nRKnR/eXe9rQodzoVgkPqfemwgiOyhFkUpszHjEUzZqHCB7sZ2ZWEsSpkuM+EvGDB
 YkMrCTZ9yaiWiWUHfCn5G46Xq+gpymnjRW74VNTtJjWVl9SZTs+gTvK+z1OvCEo93mBP
 cK6QyZqf9i0jTJnbKdB7enMm0kArZA6Z0aPB2Ths+XnulIgiOA0Mq1iOJtQOqM7zOOhs
 IlrA==
X-Gm-Message-State: AC+VfDyioKkfwshSR3HTjr7zWRiKqwx1qguKhsmGcDwEYwRhK8wagm0c
 vWHvEFGpTrwL2qHga5sf6zILImoKkBon3yKPSpE=
X-Google-Smtp-Source: ACHHUZ5+jlIp3reNo3m8ajDxBOueA2UPAQQeGSlM5xc/+bla15m9Sg1a1dBTMg7g14PGHpgp4Z9TAQ==
X-Received: by 2002:a17:902:eccc:b0:1ac:b449:3528 with SMTP id
 a12-20020a170902eccc00b001acb4493528mr28624229plh.46.1684266337204; 
 Tue, 16 May 2023 12:45:37 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 56/80] tcg: Widen helper_{ld,st}_i128 addresses to uint64_t
Date: Tue, 16 May 2023 12:41:21 -0700
Message-Id: <20230516194145.1749305-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h |  4 ++--
 accel/tcg/cputlb.c      |  5 ++---
 accel/tcg/user-exec.c   |  5 ++---
 tcg/tcg-op-ldst.c       | 26 ++++++++++++++++++++++++--
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index d9adc646c1..0e6c5f55fd 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -39,8 +39,8 @@ DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
 DEF_HELPER_FLAGS_3(memset, TCG_CALL_NO_RWG, ptr, ptr, int, ptr)
 #endif /* IN_HELPER_PROTO */
 
-DEF_HELPER_FLAGS_3(ld_i128, TCG_CALL_NO_WG, i128, env, tl, i32)
-DEF_HELPER_FLAGS_4(st_i128, TCG_CALL_NO_WG, void, env, tl, i128, i32)
+DEF_HELPER_FLAGS_3(ld_i128, TCG_CALL_NO_WG, i128, env, i64, i32)
+DEF_HELPER_FLAGS_4(st_i128, TCG_CALL_NO_WG, void, env, i64, i128, i32)
 
 DEF_HELPER_FLAGS_5(atomic_cmpxchgb, TCG_CALL_NO_WG,
                    i32, env, tl, i32, i32, i32)
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5440f68deb..ae0fbcdee2 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2551,7 +2551,7 @@ Int128 helper_ld16_mmu(CPUArchState *env, uint64_t addr,
     return do_ld16_mmu(env, addr, oi, retaddr);
 }
 
-Int128 helper_ld_i128(CPUArchState *env, target_ulong addr, uint32_t oi)
+Int128 helper_ld_i128(CPUArchState *env, uint64_t addr, uint32_t oi)
 {
     return helper_ld16_mmu(env, addr, oi, GETPC());
 }
@@ -3024,8 +3024,7 @@ void helper_st16_mmu(CPUArchState *env, uint64_t addr, Int128 val,
     do_st16_mmu(env, addr, val, oi, retaddr);
 }
 
-void helper_st_i128(CPUArchState *env, target_ulong addr, Int128 val,
-                    MemOpIdx oi)
+void helper_st_i128(CPUArchState *env, uint64_t addr, Int128 val, MemOpIdx oi)
 {
     helper_st16_mmu(env, addr, val, oi, GETPC());
 }
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 9a7afb6f78..36ad8284a5 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1136,7 +1136,7 @@ Int128 helper_ld16_mmu(CPUArchState *env, uint64_t addr,
     return ret;
 }
 
-Int128 helper_ld_i128(CPUArchState *env, target_ulong addr, MemOpIdx oi)
+Int128 helper_ld_i128(CPUArchState *env, uint64_t addr, MemOpIdx oi)
 {
     return helper_ld16_mmu(env, addr, oi, GETPC());
 }
@@ -1343,8 +1343,7 @@ void helper_st16_mmu(CPUArchState *env, uint64_t addr, Int128 val,
     do_st16_he_mmu(env, addr, val, mop, ra);
 }
 
-void helper_st_i128(CPUArchState *env, target_ulong addr,
-                    Int128 val, MemOpIdx oi)
+void helper_st_i128(CPUArchState *env, uint64_t addr, Int128 val, MemOpIdx oi)
 {
     helper_st16_mmu(env, addr, val, oi, GETPC());
 }
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index d8503d7da4..aab6dda454 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -393,6 +393,24 @@ static void canonicalize_memop_i128_as_i64(MemOp ret[2], MemOp orig)
 #define tcg_temp_ebb_new  tcg_temp_ebb_new_i32
 #endif
 
+static TCGv_i64 maybe_extend_addr64(TCGv addr)
+{
+#if TARGET_LONG_BITS == 32
+    TCGv_i64 a64 = tcg_temp_ebb_new_i64();
+    tcg_gen_extu_i32_i64(a64, addr);
+    return a64;
+#else
+    return addr;
+#endif
+}
+
+static void maybe_free_addr64(TCGv_i64 a64)
+{
+#if TARGET_LONG_BITS == 32
+    tcg_temp_free_i64(a64);
+#endif
+}
+
 void tcg_gen_qemu_ld_i128(TCGv_i128 val, TCGv addr, TCGArg idx, MemOp memop)
 {
     const MemOpIdx oi = make_memop_idx(memop, idx);
@@ -467,7 +485,9 @@ void tcg_gen_qemu_ld_i128(TCGv_i128 val, TCGv addr, TCGArg idx, MemOp memop)
             tcg_gen_bswap64_i64(y, y);
         }
     } else {
-        gen_helper_ld_i128(val, cpu_env, addr, tcg_constant_i32(oi));
+        TCGv_i64 a64 = maybe_extend_addr64(addr);
+        gen_helper_ld_i128(val, cpu_env, a64, tcg_constant_i32(oi));
+        maybe_free_addr64(a64);
     }
 
     plugin_gen_mem_callbacks(addr, oi, QEMU_PLUGIN_MEM_R);
@@ -547,7 +567,9 @@ void tcg_gen_qemu_st_i128(TCGv_i128 val, TCGv addr, TCGArg idx, MemOp memop)
         }
         tcg_temp_free(addr_p8);
     } else {
-        gen_helper_st_i128(cpu_env, addr, val, tcg_constant_i32(oi));
+        TCGv_i64 a64 = maybe_extend_addr64(addr);
+        gen_helper_st_i128(cpu_env, a64, val, tcg_constant_i32(oi));
+        maybe_free_addr64(a64);
     }
 
     plugin_gen_mem_callbacks(addr, oi, QEMU_PLUGIN_MEM_W);
-- 
2.34.1



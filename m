Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E165F7D1776
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:50:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwOw-0001pO-Re; Fri, 20 Oct 2023 16:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOu-0001oe-SP
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:20 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOq-0001B0-VP
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:20 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5b5354da665so842065a12.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834835; x=1698439635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kpdf7cOB1galYRUWIQJoZgm3BMmx0l8/le6WtehZMVk=;
 b=y5D79em5XkqR6Pqq7M00OM3UtGT4sd/u3Lte0Ss4t67kQgzdKIhmDP5MO86kivV6zc
 kJtUKFcSed9NfvuG+1K9q/X9gmHLp9m48ohyOt0YTKuY//3MYLUH98CAHGX+WT5YWgKd
 O3mEpACUyWXawB9CYM3iICFHFoveUWGCYgNEC4IvDdqZu1pBVSnWlLXg/0gbW7aG04a0
 RScrCWGx3v4sttdMTjpYQz5eqCrPjz6vN11gsu32kxoThxJ6osM8Hh27FX7QZmxVrRlF
 QrXOeuhr5wYrmUYKJKG8sNM+M5cljqspFAQhni0nQcrmVEz6Gy+HlPTYEgNH/eqNdCxI
 SPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834835; x=1698439635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kpdf7cOB1galYRUWIQJoZgm3BMmx0l8/le6WtehZMVk=;
 b=J1iMCIwNeS6Nqzq/IDVHMdtgWnfGBgF4X8+SRbaQeDZzf4nli+E7Ju1oFEORiGh9q9
 YahRWFIW2UbOPfBVnD4p9bDaX4tT5n126L21NiYyB9wsp+EZQXG9C0Ehdp5KRklUaTeR
 GuBkxmuIqRpQwpnQMqQwadRsjmd6EN+OYApMthmF8Xxda8rB3YXkCBly9tU+r7oVyPJO
 gTpJ9Cq1x1J1KuERDy4iueGKoQ//yvq0VctGYx2orxq1NWMgGH+NuNO5g+rKM/+lGEHr
 tQS1HBiJaIo1UcvCHUe2fa2mFQo5nCZpFvf9zLvIQCtfEMFfjaQyHp3f77+QtyQBzGGQ
 +9pg==
X-Gm-Message-State: AOJu0YzwbajKHRwdReTtjDGfxWHOKlXTtjxhLKIo5dM1HFKGBtOfIKgu
 DgYbZsHeCg/C46YKx2h63wQRiY50d5zdoOaQeVM=
X-Google-Smtp-Source: AGHT+IEsjPWP6gp2sXDfpigvu7xb01lmv0fHtIBUoXPjX0kare8Tg/rh0kihdckmNn+soTVQQbl1UA==
X-Received: by 2002:a05:6a20:7489:b0:161:ffbf:d949 with SMTP id
 p9-20020a056a20748900b00161ffbfd949mr3132410pzd.3.1697834835271; 
 Fri, 20 Oct 2023 13:47:15 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u7-20020aa78487000000b00694fee1011asm1946775pfn.208.2023.10.20.13.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:47:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 47/65] target/hppa: Remove TARGET_REGISTER_BITS
Date: Fri, 20 Oct 2023 13:43:13 -0700
Message-Id: <20231020204331.139847-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Rely only on TARGET_LONG_BITS, fixed at 64, and hppa_is_pa20.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu-param.h  |   1 -
 target/hppa/cpu.h        |  50 ++++-------
 target/hppa/helper.h     |  49 +++++------
 target/hppa/cpu.c        |   2 +-
 target/hppa/helper.c     |  34 +++-----
 target/hppa/int_helper.c |  17 ++--
 target/hppa/machine.c    |   9 --
 target/hppa/mem_helper.c |  10 +--
 target/hppa/op_helper.c  |  30 +++----
 target/hppa/sys_helper.c |   4 +-
 target/hppa/translate.c  | 184 ++++++++-------------------------------
 11 files changed, 119 insertions(+), 271 deletions(-)

diff --git a/target/hppa/cpu-param.h b/target/hppa/cpu-param.h
index 2fb8e7924b..6746869a3b 100644
--- a/target/hppa/cpu-param.h
+++ b/target/hppa/cpu-param.h
@@ -9,7 +9,6 @@
 #define HPPA_CPU_PARAM_H
 
 #define TARGET_LONG_BITS              64
-#define TARGET_REGISTER_BITS          64
 
 #if defined(CONFIG_USER_ONLY) && defined(TARGET_ABI32)
 # define TARGET_PHYS_ADDR_SPACE_BITS  32
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 8320f82464..c9a9b9d3be 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -141,22 +141,10 @@
 #define CR_IPSW          22
 #define CR_EIRR          23
 
-#if TARGET_REGISTER_BITS == 32
-typedef uint32_t target_ureg;
-typedef int32_t  target_sreg;
-#define TREG_FMT_lx   "%08"PRIx32
-#define TREG_FMT_ld   "%"PRId32
-#else
-typedef uint64_t target_ureg;
-typedef int64_t  target_sreg;
-#define TREG_FMT_lx   "%016"PRIx64
-#define TREG_FMT_ld   "%"PRId64
-#endif
-
 typedef struct {
     uint64_t va_b;
     uint64_t va_e;
-    target_ureg pa;
+    target_ulong pa;
     unsigned u : 1;
     unsigned t : 1;
     unsigned d : 1;
@@ -170,16 +158,16 @@ typedef struct {
 } hppa_tlb_entry;
 
 typedef struct CPUArchState {
-    target_ureg iaoq_f;      /* front */
-    target_ureg iaoq_b;      /* back, aka next instruction */
+    target_ulong iaoq_f;     /* front */
+    target_ulong iaoq_b;     /* back, aka next instruction */
 
-    target_ureg gr[32];
+    target_ulong gr[32];
     uint64_t fr[32];
     uint64_t sr[8];          /* stored shifted into place for gva */
 
-    target_ureg psw;         /* All psw bits except the following:  */
-    target_ureg psw_n;       /* boolean */
-    target_sreg psw_v;       /* in most significant bit */
+    target_ulong psw;        /* All psw bits except the following:  */
+    target_ulong psw_n;      /* boolean */
+    target_long psw_v;       /* in most significant bit */
 
     /* Splitting the carry-borrow field into the MSB and "the rest", allows
      * for "the rest" to be deleted when it is unused, but the MSB is in use.
@@ -188,8 +176,8 @@ typedef struct CPUArchState {
      * host has the appropriate add-with-carry insn to compute the msb).
      * Therefore the carry bits are stored as: cb_msb : cb & 0x11111110.
      */
-    target_ureg psw_cb;      /* in least significant bit of next nibble */
-    target_ureg psw_cb_msb;  /* boolean */
+    target_ulong psw_cb;     /* in least significant bit of next nibble */
+    target_ulong psw_cb_msb; /* boolean */
 
     uint64_t iasq_f;
     uint64_t iasq_b;
@@ -197,9 +185,9 @@ typedef struct CPUArchState {
     uint32_t fr0_shadow;     /* flags, c, ca/cq, rm, d, enables */
     float_status fp_status;
 
-    target_ureg cr[32];      /* control registers */
-    target_ureg cr_back[2];  /* back of cr17/cr18 */
-    target_ureg shadow[7];   /* shadow registers */
+    target_ulong cr[32];     /* control registers */
+    target_ulong cr_back[2]; /* back of cr17/cr18 */
+    target_ulong shadow[7];  /* shadow registers */
 
     /*
      * ??? The number of entries isn't specified by the architecture.
@@ -258,8 +246,8 @@ void hppa_translate_init(void);
 
 #define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
 
-static inline target_ulong hppa_form_gva_psw(target_ureg psw, uint64_t spc,
-                                             target_ureg off)
+static inline target_ulong hppa_form_gva_psw(target_ulong psw, uint64_t spc,
+                                             target_ulong off)
 {
 #ifdef CONFIG_USER_ONLY
     return off;
@@ -270,7 +258,7 @@ static inline target_ulong hppa_form_gva_psw(target_ureg psw, uint64_t spc,
 }
 
 static inline target_ulong hppa_form_gva(CPUHPPAState *env, uint64_t spc,
-                                         target_ureg off)
+                                         target_ulong off)
 {
     return hppa_form_gva_psw(env->psw, spc, off);
 }
@@ -314,8 +302,8 @@ static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
        which is the primary case we care about -- using goto_tb within a page.
        Failure is indicated by a zero difference.  */
     if (env->iasq_f == env->iasq_b) {
-        target_sreg diff = env->iaoq_b - env->iaoq_f;
-        if (TARGET_REGISTER_BITS == 32 || diff == (int32_t)diff) {
+        target_long diff = env->iaoq_b - env->iaoq_f;
+        if (diff == (int32_t)diff) {
             *cs_base |= (uint32_t)diff;
         }
     }
@@ -329,8 +317,8 @@ static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
     *pflags = flags;
 }
 
-target_ureg cpu_hppa_get_psw(CPUHPPAState *env);
-void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg);
+target_ulong cpu_hppa_get_psw(CPUHPPAState *env);
+void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong);
 void cpu_hppa_loaded_fr0(CPUHPPAState *env);
 
 #ifdef CONFIG_USER_ONLY
diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 58b6754dbe..4b2c66316f 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -1,29 +1,20 @@
-#if TARGET_REGISTER_BITS == 64
-# define dh_alias_tr     i64
-# define dh_typecode_tr  dh_typecode_i64
-#else
-# define dh_alias_tr     i32
-# define dh_typecode_tr  dh_typecode_i32
-#endif
-#define dh_ctype_tr      target_ureg
-
 DEF_HELPER_2(excp, noreturn, env, int)
-DEF_HELPER_FLAGS_2(tsv, TCG_CALL_NO_WG, void, env, tr)
-DEF_HELPER_FLAGS_2(tcond, TCG_CALL_NO_WG, void, env, tr)
+DEF_HELPER_FLAGS_2(tsv, TCG_CALL_NO_WG, void, env, tl)
+DEF_HELPER_FLAGS_2(tcond, TCG_CALL_NO_WG, void, env, tl)
 
-DEF_HELPER_FLAGS_3(stby_b, TCG_CALL_NO_WG, void, env, tl, tr)
-DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tr)
-DEF_HELPER_FLAGS_3(stby_e, TCG_CALL_NO_WG, void, env, tl, tr)
-DEF_HELPER_FLAGS_3(stby_e_parallel, TCG_CALL_NO_WG, void, env, tl, tr)
+DEF_HELPER_FLAGS_3(stby_b, TCG_CALL_NO_WG, void, env, tl, tl)
+DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
+DEF_HELPER_FLAGS_3(stby_e, TCG_CALL_NO_WG, void, env, tl, tl)
+DEF_HELPER_FLAGS_3(stby_e_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
 
-DEF_HELPER_FLAGS_3(stdby_b, TCG_CALL_NO_WG, void, env, tl, tr)
-DEF_HELPER_FLAGS_3(stdby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tr)
-DEF_HELPER_FLAGS_3(stdby_e, TCG_CALL_NO_WG, void, env, tl, tr)
-DEF_HELPER_FLAGS_3(stdby_e_parallel, TCG_CALL_NO_WG, void, env, tl, tr)
+DEF_HELPER_FLAGS_3(stdby_b, TCG_CALL_NO_WG, void, env, tl, tl)
+DEF_HELPER_FLAGS_3(stdby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
+DEF_HELPER_FLAGS_3(stdby_e, TCG_CALL_NO_WG, void, env, tl, tl)
+DEF_HELPER_FLAGS_3(stdby_e_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
 
 DEF_HELPER_FLAGS_1(ldc_check, TCG_CALL_NO_RWG, void, tl)
 
-DEF_HELPER_FLAGS_4(probe, TCG_CALL_NO_WG, tr, env, tl, i32, i32)
+DEF_HELPER_FLAGS_4(probe, TCG_CALL_NO_WG, tl, env, tl, i32, i32)
 
 DEF_HELPER_FLAGS_1(loaded_fr0, TCG_CALL_NO_RWG, void, env)
 
@@ -82,7 +73,7 @@ DEF_HELPER_FLAGS_4(fmpynfadd_s, TCG_CALL_NO_RWG, i32, env, i32, i32, i32)
 DEF_HELPER_FLAGS_4(fmpyfadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(fmpynfadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 
-DEF_HELPER_FLAGS_0(read_interval_timer, TCG_CALL_NO_RWG, tr)
+DEF_HELPER_FLAGS_0(read_interval_timer, TCG_CALL_NO_RWG, tl)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(halt, noreturn, env)
@@ -90,16 +81,16 @@ DEF_HELPER_1(reset, noreturn, env)
 DEF_HELPER_1(getshadowregs, void, env)
 DEF_HELPER_1(rfi, void, env)
 DEF_HELPER_1(rfi_r, void, env)
-DEF_HELPER_FLAGS_2(write_interval_timer, TCG_CALL_NO_RWG, void, env, tr)
-DEF_HELPER_FLAGS_2(write_eirr, TCG_CALL_NO_RWG, void, env, tr)
-DEF_HELPER_FLAGS_2(write_eiem, TCG_CALL_NO_RWG, void, env, tr)
-DEF_HELPER_FLAGS_2(swap_system_mask, TCG_CALL_NO_RWG, tr, env, tr)
-DEF_HELPER_FLAGS_3(itlba_pa11, TCG_CALL_NO_RWG, void, env, tl, tr)
-DEF_HELPER_FLAGS_3(itlbp_pa11, TCG_CALL_NO_RWG, void, env, tl, tr)
-DEF_HELPER_FLAGS_3(itlbt_pa20, TCG_CALL_NO_RWG, void, env, tr, tr)
+DEF_HELPER_FLAGS_2(write_interval_timer, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_2(write_eirr, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_2(write_eiem, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_2(swap_system_mask, TCG_CALL_NO_RWG, tl, env, tl)
+DEF_HELPER_FLAGS_3(itlba_pa11, TCG_CALL_NO_RWG, void, env, tl, tl)
+DEF_HELPER_FLAGS_3(itlbp_pa11, TCG_CALL_NO_RWG, void, env, tl, tl)
+DEF_HELPER_FLAGS_3(itlbt_pa20, TCG_CALL_NO_RWG, void, env, tl, tl)
 DEF_HELPER_FLAGS_2(ptlb, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_1(ptlbe, TCG_CALL_NO_RWG, void, env)
-DEF_HELPER_FLAGS_2(lpa, TCG_CALL_NO_WG, tr, env, tl)
+DEF_HELPER_FLAGS_2(lpa, TCG_CALL_NO_WG, tl, env, tl)
 DEF_HELPER_FLAGS_1(change_prot_id, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_1(diag_btlb, void, env)
 #endif
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 36875a6a1a..95abe1ff17 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -77,7 +77,7 @@ static void hppa_restore_state_to_opc(CPUState *cs,
     HPPACPU *cpu = HPPA_CPU(cs);
 
     cpu->env.iaoq_f = data[0];
-    if (data[1] != (target_ureg)-1) {
+    if (data[1] != (target_ulong)-1) {
         cpu->env.iaoq_b = data[1];
     }
     /*
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index a2ae7aca30..fe7d8c2664 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -25,31 +25,25 @@
 #include "exec/helper-proto.h"
 #include "qemu/qemu-print.h"
 
-target_ureg cpu_hppa_get_psw(CPUHPPAState *env)
+target_ulong cpu_hppa_get_psw(CPUHPPAState *env)
 {
-    target_ureg psw;
-    target_ureg mask1 = (target_ureg)-1 / 0xf;
-    target_ureg maskf = (target_ureg)-1 / 0xffff * 0xf;
+    target_ulong psw;
+    target_ulong mask1 = (target_ulong)-1 / 0xf;
+    target_ulong maskf = (target_ulong)-1 / 0xffff * 0xf;
 
     /* Fold carry bits down to 8 consecutive bits.  */
     /* ^^^b^^^c^^^d^^^e^^^f^^^g^^^h^^^i^^^j^^^k^^^l^^^m^^^n^^^o^^^p^^^^ */
-    /*                                 ^^^b^^^c^^^d^^^e^^^f^^^g^^^h^^^^ */
     psw = (env->psw_cb >> 4) & mask1;
     /* .......b...c...d...e...f...g...h...i...j...k...l...m...n...o...p */
-    /*                                 .......b...c...d...e...f...g...h */
     psw |= psw >> 3;
     /* .......b..bc..cd..de..ef..fg..gh..hi..ij..jk..kl..lm..mn..no..op */
-    /*                                 .......b..bc..cd..de..ef..fg..gh */
     psw |= psw >> 6;
     psw &= maskf;
     /* .............bcd............efgh............ijkl............mnop */
-    /*                                 .............bcd............efgh */
     psw |= psw >> 12;
     /* .............bcd.........bcdefgh........efghijkl........ijklmnop */
-    /*                                 .............bcd.........bcdefgh */
-    psw |= env->psw_cb_msb << (TARGET_REGISTER_BITS == 64 ? 39 : 7);
+    psw |= env->psw_cb_msb << 39;
     /* .............bcd........abcdefgh........efghijkl........ijklmnop */
-    /*                                 .............bcd........abcdefgh */
 
     /* For hppa64, the two 8-bit fields are discontiguous. */
     if (hppa_is_pa20(env)) {
@@ -65,11 +59,11 @@ target_ureg cpu_hppa_get_psw(CPUHPPAState *env)
     return psw;
 }
 
-void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg psw)
+void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong psw)
 {
     uint64_t reserved;
-    target_ureg old_psw = env->psw;
-    target_ureg cb = 0;
+    target_ulong old_psw = env->psw;
+    target_ulong cb = 0;
 
     /* Do not allow reserved bits to be set. */
     if (hppa_is_pa20(env)) {
@@ -87,9 +81,6 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg psw)
     env->psw_n = (psw / PSW_N) & 1;
     env->psw_v = -((psw / PSW_V) & 1);
 
-#if TARGET_REGISTER_BITS == 32
-    env->psw_cb_msb = (psw >> 15) & 1;
-#else
     env->psw_cb_msb = (psw >> 39) & 1;
     cb |= ((psw >> 38) & 1) << 60;
     cb |= ((psw >> 37) & 1) << 56;
@@ -99,7 +90,6 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg psw)
     cb |= ((psw >> 33) & 1) << 40;
     cb |= ((psw >> 32) & 1) << 36;
     cb |= ((psw >> 15) & 1) << 32;
-#endif
     cb |= ((psw >> 14) & 1) << 28;
     cb |= ((psw >> 13) & 1) << 24;
     cb |= ((psw >> 12) & 1) << 20;
@@ -120,8 +110,8 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg psw)
 void hppa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     CPUHPPAState *env = cpu_env(cs);
-    target_ureg psw = cpu_hppa_get_psw(env);
-    target_ureg psw_cb;
+    target_ulong psw = cpu_hppa_get_psw(env);
+    target_ulong psw_cb;
     char psw_c[20];
     int i, w;
     uint64_t m;
@@ -159,8 +149,8 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     psw_c[16] = (psw & PSW_D ? 'D' : '-');
     psw_c[17] = (psw & PSW_I ? 'I' : '-');
     psw_c[18] = '\0';
-    psw_cb = ((env->psw_cb >> 4) & ((target_ureg)-1 / 0xf))
-           | (env->psw_cb_msb << (TARGET_REGISTER_BITS - 4));
+    psw_cb = ((env->psw_cb >> 4) & 0x1111111111111111ull)
+           | (env->psw_cb_msb << 60);
 
     qemu_fprintf(f, "PSW  %0*" PRIx64 " CB   %0*" PRIx64 " %s\n",
                  w, m & psw, w, m & psw_cb, psw_c);
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 3ab9934a1d..f355c4c76b 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -52,9 +52,9 @@ static void io_eir_write(void *opaque, hwaddr addr,
                          uint64_t data, unsigned size)
 {
     HPPACPU *cpu = opaque;
-    int le_bit = ~data & (TARGET_REGISTER_BITS - 1);
+    int le_bit = ~data & 31;
 
-    cpu->env.cr[CR_EIRR] |= (target_ureg)1 << le_bit;
+    cpu->env.cr[CR_EIRR] |= (target_ulong)1 << le_bit;
     eval_interrupt(cpu);
 }
 
@@ -73,7 +73,7 @@ void hppa_cpu_alarm_timer(void *opaque)
     io_eir_write(opaque, 0, 0, 4);
 }
 
-void HELPER(write_eirr)(CPUHPPAState *env, target_ureg val)
+void HELPER(write_eirr)(CPUHPPAState *env, target_ulong val)
 {
     env->cr[CR_EIRR] &= ~val;
     qemu_mutex_lock_iothread();
@@ -81,7 +81,7 @@ void HELPER(write_eirr)(CPUHPPAState *env, target_ureg val)
     qemu_mutex_unlock_iothread();
 }
 
-void HELPER(write_eiem)(CPUHPPAState *env, target_ureg val)
+void HELPER(write_eiem)(CPUHPPAState *env, target_ulong val)
 {
     env->cr[CR_EIEM] = val;
     qemu_mutex_lock_iothread();
@@ -94,12 +94,11 @@ void hppa_cpu_do_interrupt(CPUState *cs)
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
     int i = cs->exception_index;
-    target_ureg iaoq_f = env->iaoq_f;
-    target_ureg iaoq_b = env->iaoq_b;
+    target_ulong iaoq_f = env->iaoq_f;
+    target_ulong iaoq_b = env->iaoq_b;
     uint64_t iasq_f = env->iasq_f;
     uint64_t iasq_b = env->iasq_b;
-
-    target_ureg old_psw;
+    target_ulong old_psw;
 
     /* As documented in pa2.0 -- interruption handling.  */
     /* step 1 */
@@ -240,7 +239,7 @@ void hppa_cpu_do_interrupt(CPUState *cs)
             name = unknown;
         }
         qemu_log("INT %6d: %s @ " TARGET_FMT_lx "," TARGET_FMT_lx
-                 " -> " TREG_FMT_lx " " TARGET_FMT_lx "\n",
+                 " -> " TARGET_FMT_lx " " TARGET_FMT_lx "\n",
                  ++count, name,
                  hppa_form_gva(env, iasq_f, iaoq_f),
                  hppa_form_gva(env, iasq_b, iaoq_b),
diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 0c0bba68c0..ab34b72910 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -21,21 +21,12 @@
 #include "cpu.h"
 #include "migration/cpu.h"
 
-#if TARGET_REGISTER_BITS == 64
 #define qemu_put_betr   qemu_put_be64
 #define qemu_get_betr   qemu_get_be64
 #define VMSTATE_UINTTR_V(_f, _s, _v) \
     VMSTATE_UINT64_V(_f, _s, _v)
 #define VMSTATE_UINTTR_ARRAY_V(_f, _s, _n, _v) \
     VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
-#else
-#define qemu_put_betr   qemu_put_be32
-#define qemu_get_betr   qemu_get_be32
-#define VMSTATE_UINTTR_V(_f, _s, _v) \
-    VMSTATE_UINT32_V(_f, _s, _v)
-#define VMSTATE_UINTTR_ARRAY_V(_f, _s, _n, _v) \
-    VMSTATE_UINT32_ARRAY_V(_f, _s, _n, _v)
-#endif
 
 #define VMSTATE_UINTTR(_f, _s) \
     VMSTATE_UINTTR_V(_f, _s, 0)
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 356746654c..8aa94bb266 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -312,7 +312,7 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
 }
 
 /* Insert (Insn/Data) TLB Address.  Note this is PA 1.1 only.  */
-void HELPER(itlba_pa11)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
+void HELPER(itlba_pa11)(CPUHPPAState *env, target_ulong addr, target_ulong reg)
 {
     hppa_tlb_entry *empty = NULL;
     int i;
@@ -343,7 +343,7 @@ void HELPER(itlba_pa11)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
 }
 
 static void set_access_bits_pa11(CPUHPPAState *env, hppa_tlb_entry *ent,
-                                 target_ureg reg)
+                                 target_ulong reg)
 {
     ent->access_id = extract32(reg, 1, 18);
     ent->u = extract32(reg, 19, 1);
@@ -359,7 +359,7 @@ static void set_access_bits_pa11(CPUHPPAState *env, hppa_tlb_entry *ent,
 }
 
 /* Insert (Insn/Data) TLB Protection.  Note this is PA 1.1 only.  */
-void HELPER(itlbp_pa11)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
+void HELPER(itlbp_pa11)(CPUHPPAState *env, target_ulong addr, target_ulong reg)
 {
     hppa_tlb_entry *ent = hppa_find_tlb(env, addr);
 
@@ -370,7 +370,7 @@ void HELPER(itlbp_pa11)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
     set_access_bits_pa11(env, ent, reg);
 }
 
-void HELPER(itlbt_pa20)(CPUHPPAState *env, target_ureg r1, target_ureg r2)
+void HELPER(itlbt_pa20)(CPUHPPAState *env, target_ulong r1, target_ulong r2)
 {
     hppa_tlb_entry *ent, *empty = NULL;
     vaddr va_b, va_e;
@@ -471,7 +471,7 @@ void HELPER(change_prot_id)(CPUHPPAState *env)
     cpu_hppa_change_prot_id(env);
 }
 
-target_ureg HELPER(lpa)(CPUHPPAState *env, target_ulong addr)
+target_ulong HELPER(lpa)(CPUHPPAState *env, target_ulong addr)
 {
     hwaddr phys;
     int prot, excp;
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 94c9ca5858..0bccca1e11 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -42,14 +42,14 @@ G_NORETURN void hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra)
     cpu_loop_exit_restore(cs, ra);
 }
 
-void HELPER(tsv)(CPUHPPAState *env, target_ureg cond)
+void HELPER(tsv)(CPUHPPAState *env, target_ulong cond)
 {
-    if (unlikely((target_sreg)cond < 0)) {
+    if (unlikely((target_long)cond < 0)) {
         hppa_dynamic_excp(env, EXCP_OVERFLOW, GETPC());
     }
 }
 
-void HELPER(tcond)(CPUHPPAState *env, target_ureg cond)
+void HELPER(tcond)(CPUHPPAState *env, target_ulong cond)
 {
     if (unlikely(cond)) {
         hppa_dynamic_excp(env, EXCP_COND, GETPC());
@@ -110,7 +110,7 @@ static void atomic_store_mask64(CPUHPPAState *env, target_ulong addr,
 #endif
 }
 
-static void do_stby_b(CPUHPPAState *env, target_ulong addr, target_ureg val,
+static void do_stby_b(CPUHPPAState *env, target_ulong addr, target_ulong val,
                       bool parallel, uintptr_t ra)
 {
     switch (addr & 3) {
@@ -191,29 +191,29 @@ static void do_stdby_b(CPUHPPAState *env, target_ulong addr, uint64_t val,
     }
 }
 
-void HELPER(stby_b)(CPUHPPAState *env, target_ulong addr, target_ureg val)
+void HELPER(stby_b)(CPUHPPAState *env, target_ulong addr, target_ulong val)
 {
     do_stby_b(env, addr, val, false, GETPC());
 }
 
 void HELPER(stby_b_parallel)(CPUHPPAState *env, target_ulong addr,
-                             target_ureg val)
+                             target_ulong val)
 {
     do_stby_b(env, addr, val, true, GETPC());
 }
 
-void HELPER(stdby_b)(CPUHPPAState *env, target_ulong addr, target_ureg val)
+void HELPER(stdby_b)(CPUHPPAState *env, target_ulong addr, target_ulong val)
 {
     do_stdby_b(env, addr, val, false, GETPC());
 }
 
 void HELPER(stdby_b_parallel)(CPUHPPAState *env, target_ulong addr,
-                              target_ureg val)
+                              target_ulong val)
 {
     do_stdby_b(env, addr, val, true, GETPC());
 }
 
-static void do_stby_e(CPUHPPAState *env, target_ulong addr, target_ureg val,
+static void do_stby_e(CPUHPPAState *env, target_ulong addr, target_ulong val,
                       bool parallel, uintptr_t ra)
 {
     switch (addr & 3) {
@@ -301,24 +301,24 @@ static void do_stdby_e(CPUHPPAState *env, target_ulong addr, uint64_t val,
     }
 }
 
-void HELPER(stby_e)(CPUHPPAState *env, target_ulong addr, target_ureg val)
+void HELPER(stby_e)(CPUHPPAState *env, target_ulong addr, target_ulong val)
 {
     do_stby_e(env, addr, val, false, GETPC());
 }
 
 void HELPER(stby_e_parallel)(CPUHPPAState *env, target_ulong addr,
-                             target_ureg val)
+                             target_ulong val)
 {
     do_stby_e(env, addr, val, true, GETPC());
 }
 
-void HELPER(stdby_e)(CPUHPPAState *env, target_ulong addr, target_ureg val)
+void HELPER(stdby_e)(CPUHPPAState *env, target_ulong addr, target_ulong val)
 {
     do_stdby_e(env, addr, val, false, GETPC());
 }
 
 void HELPER(stdby_e_parallel)(CPUHPPAState *env, target_ulong addr,
-                              target_ureg val)
+                              target_ulong val)
 {
     do_stdby_e(env, addr, val, true, GETPC());
 }
@@ -332,7 +332,7 @@ void HELPER(ldc_check)(target_ulong addr)
     }
 }
 
-target_ureg HELPER(probe)(CPUHPPAState *env, target_ulong addr,
+target_ulong HELPER(probe)(CPUHPPAState *env, target_ulong addr,
                           uint32_t level, uint32_t want)
 {
 #ifdef CONFIG_USER_ONLY
@@ -364,7 +364,7 @@ target_ureg HELPER(probe)(CPUHPPAState *env, target_ulong addr,
 #endif
 }
 
-target_ureg HELPER(read_interval_timer)(void)
+target_ulong HELPER(read_interval_timer)(void)
 {
 #ifdef CONFIG_USER_ONLY
     /* In user-mode, QEMU_CLOCK_VIRTUAL doesn't exist.
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index f0dd5a08e7..bb57413199 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -24,7 +24,7 @@
 #include "qemu/timer.h"
 #include "sysemu/runstate.h"
 
-void HELPER(write_interval_timer)(CPUHPPAState *env, target_ureg val)
+void HELPER(write_interval_timer)(CPUHPPAState *env, target_ulong val)
 {
     HPPACPU *cpu = env_archcpu(env);
     uint64_t current = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
@@ -58,7 +58,7 @@ void HELPER(reset)(CPUHPPAState *env)
     helper_excp(env, EXCP_HLT);
 }
 
-target_ureg HELPER(swap_system_mask)(CPUHPPAState *env, target_ureg nsm)
+target_ulong HELPER(swap_system_mask)(CPUHPPAState *env, target_ulong nsm)
 {
     target_ulong psw = env->psw;
     /*
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 2a09e1cdad..96082d1a9c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -40,21 +40,10 @@
 #undef tcg_temp_new
 #undef tcg_global_mem_new
 
-#if TARGET_LONG_BITS == 64
 #define TCGv_tl              TCGv_i64
 #define tcg_temp_new_tl      tcg_temp_new_i64
-#if TARGET_REGISTER_BITS == 64
 #define tcg_gen_extu_reg_tl  tcg_gen_mov_i64
-#else
-#define tcg_gen_extu_reg_tl  tcg_gen_extu_i32_i64
-#endif
-#else
-#define TCGv_tl              TCGv_i32
-#define tcg_temp_new_tl      tcg_temp_new_i32
-#define tcg_gen_extu_reg_tl  tcg_gen_mov_i32
-#endif
 
-#if TARGET_REGISTER_BITS == 64
 #define TCGv_reg             TCGv_i64
 
 #define tcg_temp_new         tcg_temp_new_i64
@@ -147,98 +136,6 @@
 #define tcg_gen_qemu_st_reg  tcg_gen_qemu_st_i64
 #define tcg_gen_atomic_xchg_reg tcg_gen_atomic_xchg_i64
 #define tcg_gen_trunc_reg_ptr   tcg_gen_trunc_i64_ptr
-#else
-#define TCGv_reg             TCGv_i32
-#define tcg_temp_new         tcg_temp_new_i32
-#define tcg_global_mem_new   tcg_global_mem_new_i32
-
-#define tcg_gen_movi_reg     tcg_gen_movi_i32
-#define tcg_gen_mov_reg      tcg_gen_mov_i32
-#define tcg_gen_ld8u_reg     tcg_gen_ld8u_i32
-#define tcg_gen_ld8s_reg     tcg_gen_ld8s_i32
-#define tcg_gen_ld16u_reg    tcg_gen_ld16u_i32
-#define tcg_gen_ld16s_reg    tcg_gen_ld16s_i32
-#define tcg_gen_ld32u_reg    tcg_gen_ld_i32
-#define tcg_gen_ld32s_reg    tcg_gen_ld_i32
-#define tcg_gen_ld_reg       tcg_gen_ld_i32
-#define tcg_gen_st8_reg      tcg_gen_st8_i32
-#define tcg_gen_st16_reg     tcg_gen_st16_i32
-#define tcg_gen_st32_reg     tcg_gen_st32_i32
-#define tcg_gen_st_reg       tcg_gen_st_i32
-#define tcg_gen_add_reg      tcg_gen_add_i32
-#define tcg_gen_addi_reg     tcg_gen_addi_i32
-#define tcg_gen_sub_reg      tcg_gen_sub_i32
-#define tcg_gen_neg_reg      tcg_gen_neg_i32
-#define tcg_gen_subfi_reg    tcg_gen_subfi_i32
-#define tcg_gen_subi_reg     tcg_gen_subi_i32
-#define tcg_gen_and_reg      tcg_gen_and_i32
-#define tcg_gen_andi_reg     tcg_gen_andi_i32
-#define tcg_gen_or_reg       tcg_gen_or_i32
-#define tcg_gen_ori_reg      tcg_gen_ori_i32
-#define tcg_gen_xor_reg      tcg_gen_xor_i32
-#define tcg_gen_xori_reg     tcg_gen_xori_i32
-#define tcg_gen_not_reg      tcg_gen_not_i32
-#define tcg_gen_shl_reg      tcg_gen_shl_i32
-#define tcg_gen_shli_reg     tcg_gen_shli_i32
-#define tcg_gen_shr_reg      tcg_gen_shr_i32
-#define tcg_gen_shri_reg     tcg_gen_shri_i32
-#define tcg_gen_sar_reg      tcg_gen_sar_i32
-#define tcg_gen_sari_reg     tcg_gen_sari_i32
-#define tcg_gen_brcond_reg   tcg_gen_brcond_i32
-#define tcg_gen_brcondi_reg  tcg_gen_brcondi_i32
-#define tcg_gen_setcond_reg  tcg_gen_setcond_i32
-#define tcg_gen_setcondi_reg tcg_gen_setcondi_i32
-#define tcg_gen_mul_reg      tcg_gen_mul_i32
-#define tcg_gen_muli_reg     tcg_gen_muli_i32
-#define tcg_gen_div_reg      tcg_gen_div_i32
-#define tcg_gen_rem_reg      tcg_gen_rem_i32
-#define tcg_gen_divu_reg     tcg_gen_divu_i32
-#define tcg_gen_remu_reg     tcg_gen_remu_i32
-#define tcg_gen_discard_reg  tcg_gen_discard_i32
-#define tcg_gen_trunc_reg_i32 tcg_gen_mov_i32
-#define tcg_gen_trunc_i64_reg tcg_gen_extrl_i64_i32
-#define tcg_gen_extu_i32_reg tcg_gen_mov_i32
-#define tcg_gen_ext_i32_reg  tcg_gen_mov_i32
-#define tcg_gen_extu_reg_i64 tcg_gen_extu_i32_i64
-#define tcg_gen_ext_reg_i64  tcg_gen_ext_i32_i64
-#define tcg_gen_ext8u_reg    tcg_gen_ext8u_i32
-#define tcg_gen_ext8s_reg    tcg_gen_ext8s_i32
-#define tcg_gen_ext16u_reg   tcg_gen_ext16u_i32
-#define tcg_gen_ext16s_reg   tcg_gen_ext16s_i32
-#define tcg_gen_ext32u_reg   tcg_gen_mov_i32
-#define tcg_gen_ext32s_reg   tcg_gen_mov_i32
-#define tcg_gen_bswap16_reg  tcg_gen_bswap16_i32
-#define tcg_gen_bswap32_reg  tcg_gen_bswap32_i32
-#define tcg_gen_concat_reg_i64 tcg_gen_concat_i32_i64
-#define tcg_gen_andc_reg     tcg_gen_andc_i32
-#define tcg_gen_eqv_reg      tcg_gen_eqv_i32
-#define tcg_gen_nand_reg     tcg_gen_nand_i32
-#define tcg_gen_nor_reg      tcg_gen_nor_i32
-#define tcg_gen_orc_reg      tcg_gen_orc_i32
-#define tcg_gen_clz_reg      tcg_gen_clz_i32
-#define tcg_gen_ctz_reg      tcg_gen_ctz_i32
-#define tcg_gen_clzi_reg     tcg_gen_clzi_i32
-#define tcg_gen_ctzi_reg     tcg_gen_ctzi_i32
-#define tcg_gen_clrsb_reg    tcg_gen_clrsb_i32
-#define tcg_gen_ctpop_reg    tcg_gen_ctpop_i32
-#define tcg_gen_rotl_reg     tcg_gen_rotl_i32
-#define tcg_gen_rotli_reg    tcg_gen_rotli_i32
-#define tcg_gen_rotr_reg     tcg_gen_rotr_i32
-#define tcg_gen_rotri_reg    tcg_gen_rotri_i32
-#define tcg_gen_deposit_reg  tcg_gen_deposit_i32
-#define tcg_gen_deposit_z_reg tcg_gen_deposit_z_i32
-#define tcg_gen_extract_reg  tcg_gen_extract_i32
-#define tcg_gen_sextract_reg tcg_gen_sextract_i32
-#define tcg_gen_extract2_reg tcg_gen_extract2_i32
-#define tcg_constant_reg     tcg_constant_i32
-#define tcg_gen_movcond_reg  tcg_gen_movcond_i32
-#define tcg_gen_add2_reg     tcg_gen_add2_i32
-#define tcg_gen_sub2_reg     tcg_gen_sub2_i32
-#define tcg_gen_qemu_ld_reg  tcg_gen_qemu_ld_i32
-#define tcg_gen_qemu_st_reg  tcg_gen_qemu_st_i32
-#define tcg_gen_atomic_xchg_reg tcg_gen_atomic_xchg_i32
-#define tcg_gen_trunc_reg_ptr   tcg_gen_ext_i32_ptr
-#endif /* TARGET_REGISTER_BITS */
 
 typedef struct DisasCond {
     TCGCond c;
@@ -249,9 +146,9 @@ typedef struct DisasContext {
     DisasContextBase base;
     CPUState *cs;
 
-    target_ureg iaoq_f;
-    target_ureg iaoq_b;
-    target_ureg iaoq_n;
+    uint64_t iaoq_f;
+    uint64_t iaoq_b;
+    uint64_t iaoq_n;
     TCGv_reg iaoq_n_var;
 
     DisasCond null_cond;
@@ -727,7 +624,7 @@ static bool nullify_end(DisasContext *ctx)
     return true;
 }
 
-static void copy_iaoq_entry(TCGv_reg dest, target_ureg ival, TCGv_reg vval)
+static void copy_iaoq_entry(TCGv_reg dest, uint64_t ival, TCGv_reg vval)
 {
     if (unlikely(ival == -1)) {
         tcg_gen_mov_reg(dest, vval);
@@ -736,7 +633,7 @@ static void copy_iaoq_entry(TCGv_reg dest, target_ureg ival, TCGv_reg vval)
     }
 }
 
-static inline target_ureg iaoq_dest(DisasContext *ctx, target_sreg disp)
+static inline uint64_t iaoq_dest(DisasContext *ctx, int64_t disp)
 {
     return ctx->iaoq_f + disp + 8;
 }
@@ -781,14 +678,14 @@ static bool gen_illegal(DisasContext *ctx)
     } while (0)
 #endif
 
-static target_ureg gva_offset_mask(DisasContext *ctx)
+static uint64_t gva_offset_mask(DisasContext *ctx)
 {
     return (ctx->tb_flags & PSW_W
             ? MAKE_64BIT_MASK(0, 62)
             : MAKE_64BIT_MASK(0, 32));
 }
 
-static bool use_goto_tb(DisasContext *ctx, target_ureg dest)
+static bool use_goto_tb(DisasContext *ctx, uint64_t dest)
 {
     return translator_use_goto_tb(&ctx->base, dest);
 }
@@ -804,7 +701,7 @@ static bool use_nullify_skip(DisasContext *ctx)
 }
 
 static void gen_goto_tb(DisasContext *ctx, int which,
-                        target_ureg f, target_ureg b)
+                        uint64_t f, uint64_t b)
 {
     if (f != -1 && b != -1 && use_goto_tb(ctx, f)) {
         tcg_gen_goto_tb(which);
@@ -831,7 +728,7 @@ static bool cond_need_cb(int c)
 /* Need extensions from TCGv_i32 to TCGv_reg. */
 static bool cond_need_ext(DisasContext *ctx, bool d)
 {
-    return TARGET_REGISTER_BITS == 64 && !(ctx->is_pa20 && d);
+    return !(ctx->is_pa20 && d);
 }
 
 /*
@@ -882,7 +779,7 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
             tcg_gen_and_reg(tmp, tmp, res);
             tcg_gen_ext32u_reg(tmp, tmp);
         } else {
-            tcg_gen_sari_reg(tmp, tmp, TARGET_REGISTER_BITS - 1);
+            tcg_gen_sari_reg(tmp, tmp, 63);
             tcg_gen_and_reg(tmp, tmp, res);
         }
         cond = cond_make_0_tmp(TCG_COND_EQ, tmp);
@@ -1078,7 +975,7 @@ static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_reg res,
 {
     DisasCond cond;
     TCGv_reg tmp, cb = NULL;
-    target_ureg d_repl = d ? 0x0000000100000001ull : 1;
+    uint64_t d_repl = d ? 0x0000000100000001ull : 1;
 
     if (cf & 8) {
         /* Since we want to test lots of carry-out bits all at once, do not
@@ -1509,7 +1406,7 @@ static TCGv_i64 space_select(DisasContext *ctx, int sp, TCGv_reg base)
 #endif
 
 static void form_gva(DisasContext *ctx, TCGv_tl *pgva, TCGv_reg *pofs,
-                     unsigned rb, unsigned rx, int scale, target_sreg disp,
+                     unsigned rb, unsigned rx, int scale, int64_t disp,
                      unsigned sp, int modify, bool is_phys)
 {
     TCGv_reg base = load_gpr(ctx, rb);
@@ -1545,7 +1442,7 @@ static void form_gva(DisasContext *ctx, TCGv_tl *pgva, TCGv_reg *pofs,
  * = 0 for no base register update.
  */
 static void do_load_32(DisasContext *ctx, TCGv_i32 dest, unsigned rb,
-                       unsigned rx, int scale, target_sreg disp,
+                       unsigned rx, int scale, int64_t disp,
                        unsigned sp, int modify, MemOp mop)
 {
     TCGv_reg ofs;
@@ -1563,7 +1460,7 @@ static void do_load_32(DisasContext *ctx, TCGv_i32 dest, unsigned rb,
 }
 
 static void do_load_64(DisasContext *ctx, TCGv_i64 dest, unsigned rb,
-                       unsigned rx, int scale, target_sreg disp,
+                       unsigned rx, int scale, int64_t disp,
                        unsigned sp, int modify, MemOp mop)
 {
     TCGv_reg ofs;
@@ -1581,7 +1478,7 @@ static void do_load_64(DisasContext *ctx, TCGv_i64 dest, unsigned rb,
 }
 
 static void do_store_32(DisasContext *ctx, TCGv_i32 src, unsigned rb,
-                        unsigned rx, int scale, target_sreg disp,
+                        unsigned rx, int scale, int64_t disp,
                         unsigned sp, int modify, MemOp mop)
 {
     TCGv_reg ofs;
@@ -1599,7 +1496,7 @@ static void do_store_32(DisasContext *ctx, TCGv_i32 src, unsigned rb,
 }
 
 static void do_store_64(DisasContext *ctx, TCGv_i64 src, unsigned rb,
-                        unsigned rx, int scale, target_sreg disp,
+                        unsigned rx, int scale, int64_t disp,
                         unsigned sp, int modify, MemOp mop)
 {
     TCGv_reg ofs;
@@ -1616,16 +1513,11 @@ static void do_store_64(DisasContext *ctx, TCGv_i64 src, unsigned rb,
     }
 }
 
-#if TARGET_REGISTER_BITS == 64
 #define do_load_reg   do_load_64
 #define do_store_reg  do_store_64
-#else
-#define do_load_reg   do_load_32
-#define do_store_reg  do_store_32
-#endif
 
 static bool do_load(DisasContext *ctx, unsigned rt, unsigned rb,
-                    unsigned rx, int scale, target_sreg disp,
+                    unsigned rx, int scale, int64_t disp,
                     unsigned sp, int modify, MemOp mop)
 {
     TCGv_reg dest;
@@ -1646,7 +1538,7 @@ static bool do_load(DisasContext *ctx, unsigned rt, unsigned rb,
 }
 
 static bool do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
-                      unsigned rx, int scale, target_sreg disp,
+                      unsigned rx, int scale, int64_t disp,
                       unsigned sp, int modify)
 {
     TCGv_i32 tmp;
@@ -1671,7 +1563,7 @@ static bool trans_fldw(DisasContext *ctx, arg_ldst *a)
 }
 
 static bool do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
-                      unsigned rx, int scale, target_sreg disp,
+                      unsigned rx, int scale, int64_t disp,
                       unsigned sp, int modify)
 {
     TCGv_i64 tmp;
@@ -1696,7 +1588,7 @@ static bool trans_fldd(DisasContext *ctx, arg_ldst *a)
 }
 
 static bool do_store(DisasContext *ctx, unsigned rt, unsigned rb,
-                     target_sreg disp, unsigned sp,
+                     int64_t disp, unsigned sp,
                      int modify, MemOp mop)
 {
     nullify_over(ctx);
@@ -1705,7 +1597,7 @@ static bool do_store(DisasContext *ctx, unsigned rt, unsigned rb,
 }
 
 static bool do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
-                       unsigned rx, int scale, target_sreg disp,
+                       unsigned rx, int scale, int64_t disp,
                        unsigned sp, int modify)
 {
     TCGv_i32 tmp;
@@ -1725,7 +1617,7 @@ static bool trans_fstw(DisasContext *ctx, arg_ldst *a)
 }
 
 static bool do_fstored(DisasContext *ctx, unsigned rt, unsigned rb,
-                       unsigned rx, int scale, target_sreg disp,
+                       unsigned rx, int scale, int64_t disp,
                        unsigned sp, int modify)
 {
     TCGv_i64 tmp;
@@ -1838,7 +1730,7 @@ static bool do_fop_dedd(DisasContext *ctx, unsigned rt,
 
 /* Emit an unconditional branch to a direct target, which may or may not
    have already had nullification handled.  */
-static bool do_dbranch(DisasContext *ctx, target_ureg dest,
+static bool do_dbranch(DisasContext *ctx, uint64_t dest,
                        unsigned link, bool is_n)
 {
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
@@ -1875,10 +1767,10 @@ static bool do_dbranch(DisasContext *ctx, target_ureg dest,
 
 /* Emit a conditional branch to a direct target.  If the branch itself
    is nullified, we should have already used nullify_over.  */
-static bool do_cbranch(DisasContext *ctx, target_sreg disp, bool is_n,
+static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
                        DisasCond *cond)
 {
-    target_ureg dest = iaoq_dest(ctx, disp);
+    uint64_t dest = iaoq_dest(ctx, disp);
     TCGLabel *taken = NULL;
     TCGCond c = cond->c;
     bool n;
@@ -2839,7 +2731,7 @@ static bool do_dcor(DisasContext *ctx, arg_rr_cf_d *a, bool is_i)
     if (!is_i) {
         tcg_gen_not_reg(tmp, tmp);
     }
-    tcg_gen_andi_reg(tmp, tmp, (target_ureg)0x1111111111111111ull);
+    tcg_gen_andi_reg(tmp, tmp, (uint64_t)0x1111111111111111ull);
     tcg_gen_muli_reg(tmp, tmp, 6);
     do_unit(ctx, a->t, load_gpr(ctx, a->r), tmp, a->cf, a->d, false,
             is_i ? tcg_gen_add_reg : tcg_gen_sub_reg);
@@ -2961,22 +2853,20 @@ static bool trans_cmpiclr(DisasContext *ctx, arg_rri_cf_d *a)
 
 static bool trans_ld(DisasContext *ctx, arg_ldst *a)
 {
-    if (unlikely(TARGET_REGISTER_BITS == 32 && a->size > MO_32)) {
+    if (!ctx->is_pa20 && a->size > MO_32) {
         return gen_illegal(ctx);
-    } else {
-        return do_load(ctx, a->t, a->b, a->x, a->scale ? a->size : 0,
-                   a->disp, a->sp, a->m, a->size | MO_TE);
     }
+    return do_load(ctx, a->t, a->b, a->x, a->scale ? a->size : 0,
+                   a->disp, a->sp, a->m, a->size | MO_TE);
 }
 
 static bool trans_st(DisasContext *ctx, arg_ldst *a)
 {
     assert(a->x == 0 && a->scale == 0);
-    if (unlikely(TARGET_REGISTER_BITS == 32 && a->size > MO_32)) {
+    if (!ctx->is_pa20 && a->size > MO_32) {
         return gen_illegal(ctx);
-    } else {
-        return do_store(ctx, a->t, a->b, a->disp, a->sp, a->m, a->size | MO_TE);
     }
+    return do_store(ctx, a->t, a->b, a->disp, a->sp, a->m, a->size | MO_TE);
 }
 
 static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
@@ -2985,7 +2875,7 @@ static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
     TCGv_reg zero, dest, ofs;
     TCGv_tl addr;
 
-    if (unlikely(TARGET_REGISTER_BITS == 32 && a->size > MO_32)) {
+    if (!ctx->is_pa20 && a->size > MO_32) {
         return gen_illegal(ctx);
     }
 
@@ -3394,7 +3284,7 @@ static bool trans_shrp_imm(DisasContext *ctx, arg_shrp_imm *a)
     t2 = load_gpr(ctx, a->r2);
     if (a->r1 == 0) {
         tcg_gen_extract_reg(dest, t2, sa, width - sa);
-    } else if (width == TARGET_REGISTER_BITS) {
+    } else if (width == TARGET_LONG_BITS) {
         tcg_gen_extract2_reg(dest, t2, cpu_gr[a->r1], sa);
     } else {
         assert(!a->d);
@@ -3496,7 +3386,7 @@ static bool trans_extr_imm(DisasContext *ctx, arg_extr_imm *a)
 static bool trans_depi_imm(DisasContext *ctx, arg_depi_imm *a)
 {
     unsigned len, width;
-    target_sreg mask0, mask1;
+    uint64_t mask0, mask1;
     TCGv_reg dest;
 
     if (!ctx->is_pa20 && a->d) {
@@ -3575,7 +3465,7 @@ static bool do_dep_sar(DisasContext *ctx, unsigned rt, unsigned c,
     unsigned rs = nz ? rt : 0;
     unsigned widthm1 = d ? 63 : 31;
     TCGv_reg mask, tmp, shift, dest;
-    target_ureg msb = 1ULL << (len - 1);
+    uint64_t msb = 1ULL << (len - 1);
 
     dest = dest_gpr(ctx, rt);
     shift = tcg_temp_new();
@@ -3691,7 +3581,7 @@ static bool trans_bl(DisasContext *ctx, arg_bl *a)
 
 static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
 {
-    target_ureg dest = iaoq_dest(ctx, a->disp);
+    uint64_t dest = iaoq_dest(ctx, a->disp);
 
     nullify_over(ctx);
 
@@ -3819,7 +3709,7 @@ static bool trans_fid_f(DisasContext *ctx, arg_fid_f *a)
 {
     uint64_t ret;
 
-    if (TARGET_REGISTER_BITS == 64) {
+    if (ctx->is_pa20) {
         ret = 0x13080000000000ULL; /* PA8700 (PCX-W2) */
     } else {
         ret = 0x0f080000000000ULL; /* PA7300LC (PCX-L2) */
-- 
2.34.1



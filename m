Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A266BC7FF8
	for <lists+qemu-devel@lfdr.de>; Thu, 09 Oct 2025 10:20:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lsg-00065b-KF; Thu, 09 Oct 2025 04:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6lsd-0005r1-4Y
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:20:07 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6lsR-0008AI-MA
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:20:06 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-46e6a6a5e42so3266235e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 01:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759997991; x=1760602791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JaSYGgkgX+R2IJrfYhVP8/WE0zeH/Eps5eAYrdnS5dM=;
 b=eMa9p9V8BtG3ROlnWu8wGeN5FOBZCnvqyZtfx7VEmtmjoqH+OxDzya7x1IWTM/AnPy
 Zc/sBQR1Dq5L9sFxuBw+aQ+iKJtpwbEjv9/IBIeB+0PXS+xpFgu5BZWAE4zgwBASxmO6
 eVbW6BM8dyB/IvBK4mpRqCp5Hzv1TgnOAELwcJK/jHrdf586sCy9WAVNKMqHlOykL6kq
 fvXVK3KkvbRl4P1hx6xZz0oWpkwGl7FhWzYQTIrSzmmuoD9noSdyih0PdW5ux89FEfpr
 8KXZygj97qRdEtifumICdk0STMFZoXgzqZk2ZtC0XhtMViAek4XYjoogMi8c0hl9BQeY
 rzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759997991; x=1760602791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JaSYGgkgX+R2IJrfYhVP8/WE0zeH/Eps5eAYrdnS5dM=;
 b=OTgt3J6OWwcwV2x8YgcldgzdWo+R+UOiQKemLe1kkIotN63v9Sjji5z3W80gZbZyh3
 CpHt4jS1IrI+4PNlViePvzwzc1xZb/oB5T1RLeJmO11ZnU0n3H68YEzECGnNxnLBXNi8
 /wMg/bXj5SER/ur+Py0W3O/fWP0J6Wl2zY21yqw2jlRtAoLlTheIOd9ix3leyId9ddmw
 rZk6f7ut/Q3cpasl/vvuHADzdD3iYNRlJzmB+8xKL63t6IfqgzMjluWQwfnYDdNvmMIC
 vLYjqGw1a6xpSUftdeyZ5GujnRVlmk0viQzDB/Q5B8NuudJaXr1pq5GIduiIdife96E3
 eVrA==
X-Gm-Message-State: AOJu0YzyxG4Pr5/bBOvvLs0HRB3i8yzxyXknoG31TK02mfw37Nq8OXUl
 UapKYecY6g2YCEXqzc90Bc5otol1sPVc5CgdsY/6Kco/c8HyasS7zYyufdvk+v8/vsxfyyLyKjh
 4VMI7PkxReuBe
X-Gm-Gg: ASbGncvM80ixhX8O6GcYjb6UdF4rpkXBMcNjKaX9BIwuzuOrSnMyYW028k4BoA4/8bC
 B4kz1tuIUU0Pg7Eyxyj1lJ7V7BzPP2rS7cr5ZaNYryep2a+bOWo8rmszkDd7nhwYhLmfpkLH+ec
 RFHVktZZlTbC6eCdJESm99A34gViesX1owmTmXjYva1nBLq4Zl4E5Yr0iJNMOuX1qS9J2zca0NM
 WapDzjO5ui+gkszaQ8YErMI9ZZVGWzKZrsa6tfaOKG1snhUoPkaxGYCVew/0IewuoYKRjquFDmB
 iTxtkW3+l0hWEnRMkU6dbUFa3ki4nqCq3AKbp2cHHqzHVIYTTi34oO2/EJ33WV1zLxMejGgBWoJ
 DROModKgsgidPL/0yyxbPmcg4YIKdiKF6c3ey3oM1SvpYZBrBfDPZWB4/APxfjQXYpYEBcISVQN
 zNq+B34eUQvVYCvwupMw/wOQpD
X-Google-Smtp-Source: AGHT+IFKjeBQD/A9Cy0YVDMNl51XYjnNMDgoMCx8tOZYlOjGYopYbSKgs02N5DwIQ1nJyG/1Tg773Q==
X-Received: by 2002:a05:600c:810b:b0:468:4350:c84d with SMTP id
 5b1f17b1804b1-46fa9a8657fmr44206655e9.7.1759997991300; 
 Thu, 09 Oct 2025 01:19:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9724sm33291858f8f.28.2025.10.09.01.19.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 01:19:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/10] target/openrisc: Replace target_ulong -> uint32_t
Date: Thu,  9 Oct 2025 10:19:02 +0200
Message-ID: <20251009081903.13426-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009081903.13426-1-philmd@linaro.org>
References: <20251009081903.13426-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

The OpenRISC targets are only built as 32-bit:

  $ git grep TARGET_LONG_BITS configs/targets/or1k-*
  configs/targets/or1k-linux-user.mak:5:TARGET_LONG_BITS=32
  configs/targets/or1k-softmmu.mak:5:TARGET_LONG_BITS=32

Therefore target_ulong always expands to uint32_t. Replace and
adapt the API uses mechanically:

  target_ulong -> uint32_t
  target_long -> int32_t
  tl -> i32
  TCGv -> TCGv_i32
  tcg_temp_new -> tcg_temp_new_i32
  tcg_global_mem_new -> tcg_global_mem_new_i32
  VMSTATE_UINTTL -> VMSTATE_UINT32

There is no functional change (the migration stream is not modified).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 target/openrisc/cpu.h        |  22 +-
 target/openrisc/helper.h     |   8 +-
 target/openrisc/fpu_helper.c |   8 +-
 target/openrisc/machine.c    |  16 +-
 target/openrisc/sys_helper.c |   5 +-
 target/openrisc/translate.c  | 382 +++++++++++++++++------------------
 6 files changed, 220 insertions(+), 221 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 87201365a91..c8e2827930b 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -224,20 +224,20 @@ typedef struct CPUOpenRISCTLBContext {
 #endif
 
 typedef struct CPUArchState {
-    target_ulong shadow_gpr[16][32]; /* Shadow registers */
+    uint32_t shadow_gpr[16][32]; /* Shadow registers */
 
-    target_ulong pc;          /* Program counter */
-    target_ulong ppc;         /* Prev PC */
-    target_ulong jmp_pc;      /* Jump PC */
+    uint32_t pc;              /* Program counter */
+    uint32_t ppc;             /* Prev PC */
+    uint32_t jmp_pc;          /* Jump PC */
 
     uint64_t mac;             /* Multiply registers MACHI:MACLO */
 
-    target_ulong epcr;        /* Exception PC register */
-    target_ulong eear;        /* Exception EA register */
+    uint32_t epcr;            /* Exception PC register */
+    uint32_t eear;            /* Exception EA register */
 
-    target_ulong sr_f;        /* the SR_F bit, values 0, 1.  */
-    target_ulong sr_cy;       /* the SR_CY bit, values 0, 1.  */
-    target_long  sr_ov;       /* the SR_OV bit (in the sign bit only) */
+    uint32_t sr_f;            /* the SR_F bit, values 0, 1.  */
+    uint32_t sr_cy;           /* the SR_CY bit, values 0, 1.  */
+    int32_t  sr_ov;           /* the SR_OV bit (in the sign bit only) */
     uint32_t sr;              /* Supervisor register, without SR_{F,CY,OV} */
     uint32_t esr;             /* Exception supervisor register */
     uint32_t evbar;           /* Exception vector base address register */
@@ -245,8 +245,8 @@ typedef struct CPUArchState {
     uint32_t fpcsr;           /* Float register */
     float_status fp_status;
 
-    target_ulong lock_addr;
-    target_ulong lock_value;
+    uint32_t lock_addr;
+    uint32_t lock_value;
 
     uint32_t dflag;           /* In delay slot (boolean) */
 
diff --git a/target/openrisc/helper.h b/target/openrisc/helper.h
index d847814a28d..e0a8d402271 100644
--- a/target/openrisc/helper.h
+++ b/target/openrisc/helper.h
@@ -47,8 +47,8 @@ FOP_CALC(rem)
 #undef FOP_CALC
 
 #define FOP_CMP(op)                                              \
-DEF_HELPER_FLAGS_3(float_ ## op ## _s, TCG_CALL_NO_RWG, tl, env, i32, i32) \
-DEF_HELPER_FLAGS_3(float_ ## op ## _d, TCG_CALL_NO_RWG, tl, env, i64, i64)
+DEF_HELPER_FLAGS_3(float_ ## op ## _s, TCG_CALL_NO_RWG, i32, env, i32, i32) \
+DEF_HELPER_FLAGS_3(float_ ## op ## _d, TCG_CALL_NO_RWG, i32, env, i64, i64)
 FOP_CMP(eq)
 FOP_CMP(lt)
 FOP_CMP(le)
@@ -62,5 +62,5 @@ FOP_CMP(ult)
 DEF_HELPER_FLAGS_1(rfe, 0, void, env)
 
 /* sys */
-DEF_HELPER_FLAGS_3(mtspr, 0, void, env, tl, tl)
-DEF_HELPER_FLAGS_3(mfspr, TCG_CALL_NO_WG, tl, env, tl, tl)
+DEF_HELPER_FLAGS_3(mtspr, 0, void, env, i32, i32)
+DEF_HELPER_FLAGS_3(mfspr, TCG_CALL_NO_WG, i32, env, i32, i32)
diff --git a/target/openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
index dba997255c6..39b6195dd7d 100644
--- a/target/openrisc/fpu_helper.c
+++ b/target/openrisc/fpu_helper.c
@@ -146,10 +146,10 @@ uint32_t helper_float_madd_s(CPUOpenRISCState *env, uint32_t a,
 
 
 #define FLOAT_CMP(name, impl)                                             \
-target_ulong helper_float_ ## name ## _d(CPUOpenRISCState *env,           \
+uint32_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
                                          uint64_t fdt0, uint64_t fdt1)    \
 { return float64_ ## impl(fdt0, fdt1, &env->fp_status); }                 \
-target_ulong helper_float_ ## name ## _s(CPUOpenRISCState *env,           \
+uint32_t helper_float_ ## name ## _s(CPUOpenRISCState *env,               \
                                          uint32_t fdt0, uint32_t fdt1)    \
 { return float32_ ## impl(fdt0, fdt1, &env->fp_status); }
 
@@ -160,13 +160,13 @@ FLOAT_CMP(un, unordered_quiet)
 #undef FLOAT_CMP
 
 #define FLOAT_UCMP(name, expr) \
-target_ulong helper_float_ ## name ## _d(CPUOpenRISCState *env,           \
+uint32_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
                                          uint64_t fdt0, uint64_t fdt1)    \
 {                                                                         \
     FloatRelation r = float64_compare_quiet(fdt0, fdt1, &env->fp_status); \
     return expr;                                                          \
 }                                                                         \
-target_ulong helper_float_ ## name ## _s(CPUOpenRISCState *env,           \
+uint32_t helper_float_ ## name ## _s(CPUOpenRISCState *env,               \
                                          uint32_t fdt0, uint32_t fdt1)    \
 {                                                                         \
     FloatRelation r = float32_compare_quiet(fdt0, fdt1, &env->fp_status); \
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index fa054e528bd..f2853674f0f 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -72,14 +72,14 @@ static const VMStateDescription vmstate_env = {
     .version_id = 6,
     .minimum_version_id = 6,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL_2DARRAY(shadow_gpr, CPUOpenRISCState, 16, 32),
-        VMSTATE_UINTTL(pc, CPUOpenRISCState),
-        VMSTATE_UINTTL(ppc, CPUOpenRISCState),
-        VMSTATE_UINTTL(jmp_pc, CPUOpenRISCState),
-        VMSTATE_UINTTL(lock_addr, CPUOpenRISCState),
-        VMSTATE_UINTTL(lock_value, CPUOpenRISCState),
-        VMSTATE_UINTTL(epcr, CPUOpenRISCState),
-        VMSTATE_UINTTL(eear, CPUOpenRISCState),
+        VMSTATE_UINT32_2DARRAY(shadow_gpr, CPUOpenRISCState, 16, 32),
+        VMSTATE_UINT32(pc, CPUOpenRISCState),
+        VMSTATE_UINT32(ppc, CPUOpenRISCState),
+        VMSTATE_UINT32(jmp_pc, CPUOpenRISCState),
+        VMSTATE_UINT32(lock_addr, CPUOpenRISCState),
+        VMSTATE_UINT32(lock_value, CPUOpenRISCState),
+        VMSTATE_UINT32(epcr, CPUOpenRISCState),
+        VMSTATE_UINT32(eear, CPUOpenRISCState),
 
         /* Save the architecture value of the SR, not the internally
            expanded version.  Since this architecture value does not
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index ad59939db3b..7ad908b6322 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -40,7 +40,7 @@ static inline bool is_user(CPUOpenRISCState *env)
 #endif
 }
 
-void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
+void HELPER(mtspr)(CPUOpenRISCState *env, uint32_t spr, uint32_t rb)
 {
     OpenRISCCPU *cpu = env_archcpu(env);
 #ifndef CONFIG_USER_ONLY
@@ -213,8 +213,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
 #endif
 }
 
-target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
-                           target_ulong spr)
+uint32_t HELPER(mfspr)(CPUOpenRISCState *env, uint32_t rd, uint32_t spr)
 {
     OpenRISCCPU *cpu = env_archcpu(env);
 #ifndef CONFIG_USER_ONLY
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 7cb4152e357..960438e1626 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -54,9 +54,9 @@ typedef struct DisasContext {
     vaddr jmp_pc_imm;
 
     /* The temporary corresponding to register 0 for this compilation.  */
-    TCGv R0;
+    TCGv_i32 R0;
     /* The constant zero. */
-    TCGv zero;
+    TCGv_i32 zero;
 } DisasContext;
 
 static inline bool is_user(DisasContext *dc)
@@ -71,16 +71,16 @@ static inline bool is_user(DisasContext *dc)
 /* Include the auto-generated decoder.  */
 #include "decode-insns.c.inc"
 
-static TCGv cpu_sr;
-static TCGv cpu_regs[32];
-static TCGv cpu_pc;
-static TCGv jmp_pc;            /* l.jr/l.jalr temp pc */
-static TCGv cpu_ppc;
-static TCGv cpu_sr_f;           /* bf/bnf, F flag taken */
-static TCGv cpu_sr_cy;          /* carry (unsigned overflow) */
-static TCGv cpu_sr_ov;          /* signed overflow */
-static TCGv cpu_lock_addr;
-static TCGv cpu_lock_value;
+static TCGv_i32 cpu_sr;
+static TCGv_i32 cpu_regs[32];
+static TCGv_i32 cpu_pc;
+static TCGv_i32 jmp_pc;         /* l.jr/l.jalr temp pc */
+static TCGv_i32 cpu_ppc;
+static TCGv_i32 cpu_sr_f;       /* bf/bnf, F flag taken */
+static TCGv_i32 cpu_sr_cy;      /* carry (unsigned overflow) */
+static TCGv_i32 cpu_sr_ov;      /* signed overflow */
+static TCGv_i32 cpu_lock_addr;
+static TCGv_i32 cpu_lock_value;
 static TCGv_i32 fpcsr;
 static TCGv_i64 cpu_mac;        /* MACHI:MACLO */
 static TCGv_i32 cpu_dflag;
@@ -95,27 +95,27 @@ void openrisc_translate_init(void)
     };
     int i;
 
-    cpu_sr = tcg_global_mem_new(tcg_env,
+    cpu_sr = tcg_global_mem_new_i32(tcg_env,
                                 offsetof(CPUOpenRISCState, sr), "sr");
     cpu_dflag = tcg_global_mem_new_i32(tcg_env,
                                        offsetof(CPUOpenRISCState, dflag),
                                        "dflag");
-    cpu_pc = tcg_global_mem_new(tcg_env,
+    cpu_pc = tcg_global_mem_new_i32(tcg_env,
                                 offsetof(CPUOpenRISCState, pc), "pc");
-    cpu_ppc = tcg_global_mem_new(tcg_env,
+    cpu_ppc = tcg_global_mem_new_i32(tcg_env,
                                  offsetof(CPUOpenRISCState, ppc), "ppc");
-    jmp_pc = tcg_global_mem_new(tcg_env,
+    jmp_pc = tcg_global_mem_new_i32(tcg_env,
                                 offsetof(CPUOpenRISCState, jmp_pc), "jmp_pc");
-    cpu_sr_f = tcg_global_mem_new(tcg_env,
+    cpu_sr_f = tcg_global_mem_new_i32(tcg_env,
                                   offsetof(CPUOpenRISCState, sr_f), "sr_f");
-    cpu_sr_cy = tcg_global_mem_new(tcg_env,
+    cpu_sr_cy = tcg_global_mem_new_i32(tcg_env,
                                    offsetof(CPUOpenRISCState, sr_cy), "sr_cy");
-    cpu_sr_ov = tcg_global_mem_new(tcg_env,
+    cpu_sr_ov = tcg_global_mem_new_i32(tcg_env,
                                    offsetof(CPUOpenRISCState, sr_ov), "sr_ov");
-    cpu_lock_addr = tcg_global_mem_new(tcg_env,
+    cpu_lock_addr = tcg_global_mem_new_i32(tcg_env,
                                        offsetof(CPUOpenRISCState, lock_addr),
                                        "lock_addr");
-    cpu_lock_value = tcg_global_mem_new(tcg_env,
+    cpu_lock_value = tcg_global_mem_new_i32(tcg_env,
                                         offsetof(CPUOpenRISCState, lock_value),
                                         "lock_value");
     fpcsr = tcg_global_mem_new_i32(tcg_env,
@@ -125,7 +125,7 @@ void openrisc_translate_init(void)
                                      offsetof(CPUOpenRISCState, mac),
                                      "mac");
     for (i = 0; i < 32; i++) {
-        cpu_regs[i] = tcg_global_mem_new(tcg_env,
+        cpu_regs[i] = tcg_global_mem_new_i32(tcg_env,
                                          offsetof(CPUOpenRISCState,
                                                   shadow_gpr[0][i]),
                                          regnames[i]);
@@ -139,7 +139,7 @@ static void gen_exception(DisasContext *dc, unsigned int excp)
 
 static void gen_illegal_exception(DisasContext *dc)
 {
-    tcg_gen_movi_tl(cpu_pc, dc->base.pc_next);
+    tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
     gen_exception(dc, EXCP_ILLEGAL);
     dc->base.is_jmp = DISAS_NORETURN;
 }
@@ -159,7 +159,7 @@ static bool check_of64a32s(DisasContext *dc)
     return dc->cpucfgr & CPUCFGR_OF64A32S;
 }
 
-static TCGv cpu_R(DisasContext *dc, int reg)
+static TCGv_i32 cpu_R(DisasContext *dc, int reg)
 {
     if (reg == 0) {
         return dc->R0;
@@ -200,126 +200,126 @@ static void gen_ove_cyov(DisasContext *dc)
     }
 }
 
-static void gen_add(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
+static void gen_add(DisasContext *dc, TCGv_i32 dest, TCGv_i32 srca, TCGv_i32 srcb)
 {
-    TCGv t0 = tcg_temp_new();
-    TCGv res = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 res = tcg_temp_new_i32();
 
-    tcg_gen_add2_tl(res, cpu_sr_cy, srca, dc->zero, srcb, dc->zero);
-    tcg_gen_xor_tl(cpu_sr_ov, srca, srcb);
-    tcg_gen_xor_tl(t0, res, srcb);
-    tcg_gen_andc_tl(cpu_sr_ov, t0, cpu_sr_ov);
+    tcg_gen_add2_i32(res, cpu_sr_cy, srca, dc->zero, srcb, dc->zero);
+    tcg_gen_xor_i32(cpu_sr_ov, srca, srcb);
+    tcg_gen_xor_i32(t0, res, srcb);
+    tcg_gen_andc_i32(cpu_sr_ov, t0, cpu_sr_ov);
 
-    tcg_gen_mov_tl(dest, res);
+    tcg_gen_mov_i32(dest, res);
 
     gen_ove_cyov(dc);
 }
 
-static void gen_addc(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
+static void gen_addc(DisasContext *dc, TCGv_i32 dest, TCGv_i32 srca, TCGv_i32 srcb)
 {
-    TCGv t0 = tcg_temp_new();
-    TCGv res = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 res = tcg_temp_new_i32();
 
-    tcg_gen_addcio_tl(res, cpu_sr_cy, srca, srcb, cpu_sr_cy);
-    tcg_gen_xor_tl(cpu_sr_ov, srca, srcb);
-    tcg_gen_xor_tl(t0, res, srcb);
-    tcg_gen_andc_tl(cpu_sr_ov, t0, cpu_sr_ov);
+    tcg_gen_addcio_i32(res, cpu_sr_cy, srca, srcb, cpu_sr_cy);
+    tcg_gen_xor_i32(cpu_sr_ov, srca, srcb);
+    tcg_gen_xor_i32(t0, res, srcb);
+    tcg_gen_andc_i32(cpu_sr_ov, t0, cpu_sr_ov);
 
-    tcg_gen_mov_tl(dest, res);
+    tcg_gen_mov_i32(dest, res);
 
     gen_ove_cyov(dc);
 }
 
-static void gen_sub(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
+static void gen_sub(DisasContext *dc, TCGv_i32 dest, TCGv_i32 srca, TCGv_i32 srcb)
 {
-    TCGv res = tcg_temp_new();
+    TCGv_i32 res = tcg_temp_new_i32();
 
-    tcg_gen_sub_tl(res, srca, srcb);
-    tcg_gen_xor_tl(cpu_sr_cy, srca, srcb);
-    tcg_gen_xor_tl(cpu_sr_ov, res, srcb);
-    tcg_gen_and_tl(cpu_sr_ov, cpu_sr_ov, cpu_sr_cy);
-    tcg_gen_setcond_tl(TCG_COND_LTU, cpu_sr_cy, srca, srcb);
+    tcg_gen_sub_i32(res, srca, srcb);
+    tcg_gen_xor_i32(cpu_sr_cy, srca, srcb);
+    tcg_gen_xor_i32(cpu_sr_ov, res, srcb);
+    tcg_gen_and_i32(cpu_sr_ov, cpu_sr_ov, cpu_sr_cy);
+    tcg_gen_setcond_i32(TCG_COND_LTU, cpu_sr_cy, srca, srcb);
 
-    tcg_gen_mov_tl(dest, res);
+    tcg_gen_mov_i32(dest, res);
 
     gen_ove_cyov(dc);
 }
 
-static void gen_mul(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
+static void gen_mul(DisasContext *dc, TCGv_i32 dest, TCGv_i32 srca, TCGv_i32 srcb)
 {
-    TCGv t0 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
 
-    tcg_gen_muls2_tl(dest, cpu_sr_ov, srca, srcb);
-    tcg_gen_sari_tl(t0, dest, TARGET_LONG_BITS - 1);
-    tcg_gen_negsetcond_tl(TCG_COND_NE, cpu_sr_ov, cpu_sr_ov, t0);
+    tcg_gen_muls2_i32(dest, cpu_sr_ov, srca, srcb);
+    tcg_gen_sari_i32(t0, dest, TARGET_LONG_BITS - 1);
+    tcg_gen_negsetcond_i32(TCG_COND_NE, cpu_sr_ov, cpu_sr_ov, t0);
 
     gen_ove_ov(dc);
 }
 
-static void gen_mulu(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
+static void gen_mulu(DisasContext *dc, TCGv_i32 dest, TCGv_i32 srca, TCGv_i32 srcb)
 {
-    tcg_gen_muls2_tl(dest, cpu_sr_cy, srca, srcb);
-    tcg_gen_setcondi_tl(TCG_COND_NE, cpu_sr_cy, cpu_sr_cy, 0);
+    tcg_gen_muls2_i32(dest, cpu_sr_cy, srca, srcb);
+    tcg_gen_setcondi_i32(TCG_COND_NE, cpu_sr_cy, cpu_sr_cy, 0);
 
     gen_ove_cy(dc);
 }
 
-static void gen_div(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
+static void gen_div(DisasContext *dc, TCGv_i32 dest, TCGv_i32 srca, TCGv_i32 srcb)
 {
-    TCGv t0 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
 
-    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_sr_ov, srcb, 0);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_sr_ov, srcb, 0);
     /* The result of divide-by-zero is undefined.
        Suppress the host-side exception by dividing by 1. */
-    tcg_gen_or_tl(t0, srcb, cpu_sr_ov);
-    tcg_gen_div_tl(dest, srca, t0);
+    tcg_gen_or_i32(t0, srcb, cpu_sr_ov);
+    tcg_gen_div_i32(dest, srca, t0);
 
-    tcg_gen_neg_tl(cpu_sr_ov, cpu_sr_ov);
+    tcg_gen_neg_i32(cpu_sr_ov, cpu_sr_ov);
     gen_ove_ov(dc);
 }
 
-static void gen_divu(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
+static void gen_divu(DisasContext *dc, TCGv_i32 dest, TCGv_i32 srca, TCGv_i32 srcb)
 {
-    TCGv t0 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
 
-    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_sr_cy, srcb, 0);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_sr_cy, srcb, 0);
     /* The result of divide-by-zero is undefined.
        Suppress the host-side exception by dividing by 1. */
-    tcg_gen_or_tl(t0, srcb, cpu_sr_cy);
-    tcg_gen_divu_tl(dest, srca, t0);
+    tcg_gen_or_i32(t0, srcb, cpu_sr_cy);
+    tcg_gen_divu_i32(dest, srca, t0);
 
     gen_ove_cy(dc);
 }
 
-static void gen_muld(DisasContext *dc, TCGv srca, TCGv srcb)
+static void gen_muld(DisasContext *dc, TCGv_i32 srca, TCGv_i32 srcb)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
 
-    tcg_gen_ext_tl_i64(t1, srca);
-    tcg_gen_ext_tl_i64(t2, srcb);
+    tcg_gen_ext_i32_i64(t1, srca);
+    tcg_gen_ext_i32_i64(t2, srcb);
     tcg_gen_mul_i64(cpu_mac, t1, t2);
-    tcg_gen_movi_tl(cpu_sr_ov, 0);
+    tcg_gen_movi_i32(cpu_sr_ov, 0);
 }
 
-static void gen_muldu(DisasContext *dc, TCGv srca, TCGv srcb)
+static void gen_muldu(DisasContext *dc, TCGv_i32 srca, TCGv_i32 srcb)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
 
-    tcg_gen_extu_tl_i64(t1, srca);
-    tcg_gen_extu_tl_i64(t2, srcb);
+    tcg_gen_extu_i32_i64(t1, srca);
+    tcg_gen_extu_i32_i64(t2, srcb);
     tcg_gen_mul_i64(cpu_mac, t1, t2);
-    tcg_gen_movi_tl(cpu_sr_cy, 0);
+    tcg_gen_movi_i32(cpu_sr_cy, 0);
 }
 
-static void gen_mac(DisasContext *dc, TCGv srca, TCGv srcb)
+static void gen_mac(DisasContext *dc, TCGv_i32 srca, TCGv_i32 srcb)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
 
-    tcg_gen_ext_tl_i64(t1, srca);
-    tcg_gen_ext_tl_i64(t2, srcb);
+    tcg_gen_ext_i32_i64(t1, srca);
+    tcg_gen_ext_i32_i64(t2, srcb);
     tcg_gen_mul_i64(t1, t1, t2);
 
     /* Note that overflow is only computed during addition stage.  */
@@ -333,13 +333,13 @@ static void gen_mac(DisasContext *dc, TCGv srca, TCGv srcb)
     gen_ove_ov(dc);
 }
 
-static void gen_macu(DisasContext *dc, TCGv srca, TCGv srcb)
+static void gen_macu(DisasContext *dc, TCGv_i32 srca, TCGv_i32 srcb)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
 
-    tcg_gen_extu_tl_i64(t1, srca);
-    tcg_gen_extu_tl_i64(t2, srcb);
+    tcg_gen_extu_i32_i64(t1, srca);
+    tcg_gen_extu_i32_i64(t2, srcb);
     tcg_gen_mul_i64(t1, t1, t2);
 
     /* Note that overflow is only computed during addition stage.  */
@@ -350,13 +350,13 @@ static void gen_macu(DisasContext *dc, TCGv srca, TCGv srcb)
     gen_ove_cy(dc);
 }
 
-static void gen_msb(DisasContext *dc, TCGv srca, TCGv srcb)
+static void gen_msb(DisasContext *dc, TCGv_i32 srca, TCGv_i32 srcb)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
 
-    tcg_gen_ext_tl_i64(t1, srca);
-    tcg_gen_ext_tl_i64(t2, srcb);
+    tcg_gen_ext_i32_i64(t1, srca);
+    tcg_gen_ext_i32_i64(t2, srcb);
     tcg_gen_mul_i64(t1, t1, t2);
 
     /* Note that overflow is only computed during subtraction stage.  */
@@ -374,13 +374,13 @@ static void gen_msb(DisasContext *dc, TCGv srca, TCGv srcb)
     gen_ove_ov(dc);
 }
 
-static void gen_msbu(DisasContext *dc, TCGv srca, TCGv srcb)
+static void gen_msbu(DisasContext *dc, TCGv_i32 srca, TCGv_i32 srcb)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
 
-    tcg_gen_extu_tl_i64(t1, srca);
-    tcg_gen_extu_tl_i64(t2, srcb);
+    tcg_gen_extu_i32_i64(t1, srca);
+    tcg_gen_extu_i32_i64(t2, srcb);
     tcg_gen_mul_i64(t1, t1, t2);
 
     /* Note that overflow is only computed during subtraction stage.  */
@@ -415,84 +415,84 @@ static bool trans_l_sub(DisasContext *dc, arg_dab *a)
 static bool trans_l_and(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_and_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
+    tcg_gen_and_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_or(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_or_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
+    tcg_gen_or_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_xor(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_xor_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
+    tcg_gen_xor_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sll(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_shl_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
+    tcg_gen_shl_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_srl(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_shr_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
+    tcg_gen_shr_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sra(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_sar_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
+    tcg_gen_sar_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_ror(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_rotr_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
+    tcg_gen_rotr_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_exths(DisasContext *dc, arg_da *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_ext16s_tl(cpu_R(dc, a->d), cpu_R(dc, a->a));
+    tcg_gen_ext16s_i32(cpu_R(dc, a->d), cpu_R(dc, a->a));
     return true;
 }
 
 static bool trans_l_extbs(DisasContext *dc, arg_da *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_ext8s_tl(cpu_R(dc, a->d), cpu_R(dc, a->a));
+    tcg_gen_ext8s_i32(cpu_R(dc, a->d), cpu_R(dc, a->a));
     return true;
 }
 
 static bool trans_l_exthz(DisasContext *dc, arg_da *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_ext16u_tl(cpu_R(dc, a->d), cpu_R(dc, a->a));
+    tcg_gen_ext16u_i32(cpu_R(dc, a->d), cpu_R(dc, a->a));
     return true;
 }
 
 static bool trans_l_extbz(DisasContext *dc, arg_da *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_ext8u_tl(cpu_R(dc, a->d), cpu_R(dc, a->a));
+    tcg_gen_ext8u_i32(cpu_R(dc, a->d), cpu_R(dc, a->a));
     return true;
 }
 
 static bool trans_l_cmov(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_movcond_tl(TCG_COND_NE, cpu_R(dc, a->d), cpu_sr_f, dc->zero,
+    tcg_gen_movcond_i32(TCG_COND_NE, cpu_R(dc, a->d), cpu_sr_f, dc->zero,
                        cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
@@ -500,16 +500,16 @@ static bool trans_l_cmov(DisasContext *dc, arg_dab *a)
 static bool trans_l_ff1(DisasContext *dc, arg_da *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_ctzi_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), -1);
-    tcg_gen_addi_tl(cpu_R(dc, a->d), cpu_R(dc, a->d), 1);
+    tcg_gen_ctzi_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), -1);
+    tcg_gen_addi_i32(cpu_R(dc, a->d), cpu_R(dc, a->d), 1);
     return true;
 }
 
 static bool trans_l_fl1(DisasContext *dc, arg_da *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_clzi_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), TARGET_LONG_BITS);
-    tcg_gen_subfi_tl(cpu_R(dc, a->d), TARGET_LONG_BITS, cpu_R(dc, a->d));
+    tcg_gen_clzi_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), TARGET_LONG_BITS);
+    tcg_gen_subfi_i32(cpu_R(dc, a->d), TARGET_LONG_BITS, cpu_R(dc, a->d));
     return true;
 }
 
@@ -557,7 +557,7 @@ static bool trans_l_j(DisasContext *dc, arg_l_j *a)
 {
     vaddr tmp_pc = dc->base.pc_next + a->n * 4;
 
-    tcg_gen_movi_tl(jmp_pc, tmp_pc);
+    tcg_gen_movi_i32(jmp_pc, tmp_pc);
     dc->jmp_pc_imm = tmp_pc;
     dc->delayed_branch = 2;
     return true;
@@ -568,10 +568,10 @@ static bool trans_l_jal(DisasContext *dc, arg_l_jal *a)
     vaddr tmp_pc = dc->base.pc_next + a->n * 4;
     vaddr ret_pc = dc->base.pc_next + 8;
 
-    tcg_gen_movi_tl(cpu_regs[9], ret_pc);
+    tcg_gen_movi_i32(cpu_regs[9], ret_pc);
     /* Optimize jal being used to load the PC for PIC.  */
     if (tmp_pc != ret_pc) {
-        tcg_gen_movi_tl(jmp_pc, tmp_pc);
+        tcg_gen_movi_i32(jmp_pc, tmp_pc);
         dc->jmp_pc_imm = tmp_pc;
         dc->delayed_branch = 2;
     }
@@ -581,10 +581,10 @@ static bool trans_l_jal(DisasContext *dc, arg_l_jal *a)
 static void do_bf(DisasContext *dc, arg_l_bf *a, TCGCond cond)
 {
     vaddr tmp_pc = dc->base.pc_next + a->n * 4;
-    TCGv t_next = tcg_constant_tl(dc->base.pc_next + 8);
-    TCGv t_true = tcg_constant_tl(tmp_pc);
+    TCGv_i32 t_next = tcg_constant_i32(dc->base.pc_next + 8);
+    TCGv_i32 t_true = tcg_constant_i32(tmp_pc);
 
-    tcg_gen_movcond_tl(cond, jmp_pc, cpu_sr_f, dc->zero, t_true, t_next);
+    tcg_gen_movcond_i32(cond, jmp_pc, cpu_sr_f, dc->zero, t_true, t_next);
     dc->delayed_branch = 2;
 }
 
@@ -602,40 +602,40 @@ static bool trans_l_bnf(DisasContext *dc, arg_l_bf *a)
 
 static bool trans_l_jr(DisasContext *dc, arg_l_jr *a)
 {
-    tcg_gen_mov_tl(jmp_pc, cpu_R(dc, a->b));
+    tcg_gen_mov_i32(jmp_pc, cpu_R(dc, a->b));
     dc->delayed_branch = 2;
     return true;
 }
 
 static bool trans_l_jalr(DisasContext *dc, arg_l_jalr *a)
 {
-    tcg_gen_mov_tl(jmp_pc, cpu_R(dc, a->b));
-    tcg_gen_movi_tl(cpu_regs[9], dc->base.pc_next + 8);
+    tcg_gen_mov_i32(jmp_pc, cpu_R(dc, a->b));
+    tcg_gen_movi_i32(cpu_regs[9], dc->base.pc_next + 8);
     dc->delayed_branch = 2;
     return true;
 }
 
 static bool trans_l_lwa(DisasContext *dc, arg_load *a)
 {
-    TCGv ea;
+    TCGv_i32 ea;
 
     check_r0_write(dc, a->d);
-    ea = tcg_temp_new();
-    tcg_gen_addi_tl(ea, cpu_R(dc, a->a), a->i);
-    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, MO_BE | MO_UL);
-    tcg_gen_mov_tl(cpu_lock_addr, ea);
-    tcg_gen_mov_tl(cpu_lock_value, cpu_R(dc, a->d));
+    ea = tcg_temp_new_i32();
+    tcg_gen_addi_i32(ea, cpu_R(dc, a->a), a->i);
+    tcg_gen_qemu_ld_i32(cpu_R(dc, a->d), ea, dc->mem_idx, MO_BE | MO_UL);
+    tcg_gen_mov_i32(cpu_lock_addr, ea);
+    tcg_gen_mov_i32(cpu_lock_value, cpu_R(dc, a->d));
     return true;
 }
 
 static void do_load(DisasContext *dc, arg_load *a, MemOp mop)
 {
-    TCGv ea;
+    TCGv_i32 ea;
 
     check_r0_write(dc, a->d);
-    ea = tcg_temp_new();
-    tcg_gen_addi_tl(ea, cpu_R(dc, a->a), a->i);
-    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, mop);
+    ea = tcg_temp_new_i32();
+    tcg_gen_addi_i32(ea, cpu_R(dc, a->a), a->i);
+    tcg_gen_qemu_ld_i32(cpu_R(dc, a->d), ea, dc->mem_idx, mop);
 }
 
 static bool trans_l_lwz(DisasContext *dc, arg_load *a)
@@ -676,36 +676,36 @@ static bool trans_l_lhs(DisasContext *dc, arg_load *a)
 
 static bool trans_l_swa(DisasContext *dc, arg_store *a)
 {
-    TCGv ea, val;
+    TCGv_i32 ea, val;
     TCGLabel *lab_fail, *lab_done;
 
-    ea = tcg_temp_new();
-    tcg_gen_addi_tl(ea, cpu_R(dc, a->a), a->i);
+    ea = tcg_temp_new_i32();
+    tcg_gen_addi_i32(ea, cpu_R(dc, a->a), a->i);
 
     lab_fail = gen_new_label();
     lab_done = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_NE, ea, cpu_lock_addr, lab_fail);
+    tcg_gen_brcond_i32(TCG_COND_NE, ea, cpu_lock_addr, lab_fail);
 
-    val = tcg_temp_new();
-    tcg_gen_atomic_cmpxchg_tl(val, cpu_lock_addr, cpu_lock_value,
+    val = tcg_temp_new_i32();
+    tcg_gen_atomic_cmpxchg_i32(val, cpu_lock_addr, cpu_lock_value,
                               cpu_R(dc, a->b), dc->mem_idx, MO_BE | MO_UL);
-    tcg_gen_setcond_tl(TCG_COND_EQ, cpu_sr_f, val, cpu_lock_value);
+    tcg_gen_setcond_i32(TCG_COND_EQ, cpu_sr_f, val, cpu_lock_value);
 
     tcg_gen_br(lab_done);
 
     gen_set_label(lab_fail);
-    tcg_gen_movi_tl(cpu_sr_f, 0);
+    tcg_gen_movi_i32(cpu_sr_f, 0);
 
     gen_set_label(lab_done);
-    tcg_gen_movi_tl(cpu_lock_addr, -1);
+    tcg_gen_movi_i32(cpu_lock_addr, -1);
     return true;
 }
 
 static void do_store(DisasContext *dc, arg_store *a, MemOp mop)
 {
-    TCGv t0 = tcg_temp_new();
-    tcg_gen_addi_tl(t0, cpu_R(dc, a->a), a->i);
-    tcg_gen_qemu_st_tl(cpu_R(dc, a->b), t0, dc->mem_idx, mop);
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    tcg_gen_addi_i32(t0, cpu_R(dc, a->a), a->i);
+    tcg_gen_qemu_st_i32(cpu_R(dc, a->b), t0, dc->mem_idx, mop);
 }
 
 static bool trans_l_sw(DisasContext *dc, arg_store *a)
@@ -747,75 +747,75 @@ static bool trans_l_adrp(DisasContext *dc, arg_l_adrp *a)
 static bool trans_l_addi(DisasContext *dc, arg_rri *a)
 {
     check_r0_write(dc, a->d);
-    gen_add(dc, cpu_R(dc, a->d), cpu_R(dc, a->a), tcg_constant_tl(a->i));
+    gen_add(dc, cpu_R(dc, a->d), cpu_R(dc, a->a), tcg_constant_i32(a->i));
     return true;
 }
 
 static bool trans_l_addic(DisasContext *dc, arg_rri *a)
 {
     check_r0_write(dc, a->d);
-    gen_addc(dc, cpu_R(dc, a->d), cpu_R(dc, a->a), tcg_constant_tl(a->i));
+    gen_addc(dc, cpu_R(dc, a->d), cpu_R(dc, a->a), tcg_constant_i32(a->i));
     return true;
 }
 
 static bool trans_l_muli(DisasContext *dc, arg_rri *a)
 {
     check_r0_write(dc, a->d);
-    gen_mul(dc, cpu_R(dc, a->d), cpu_R(dc, a->a), tcg_constant_tl(a->i));
+    gen_mul(dc, cpu_R(dc, a->d), cpu_R(dc, a->a), tcg_constant_i32(a->i));
     return true;
 }
 
 static bool trans_l_maci(DisasContext *dc, arg_l_maci *a)
 {
-    gen_mac(dc, cpu_R(dc, a->a), tcg_constant_tl(a->i));
+    gen_mac(dc, cpu_R(dc, a->a), tcg_constant_i32(a->i));
     return true;
 }
 
 static bool trans_l_andi(DisasContext *dc, arg_rrk *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_andi_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), a->k);
+    tcg_gen_andi_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), a->k);
     return true;
 }
 
 static bool trans_l_ori(DisasContext *dc, arg_rrk *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_ori_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), a->k);
+    tcg_gen_ori_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), a->k);
     return true;
 }
 
 static bool trans_l_xori(DisasContext *dc, arg_rri *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_xori_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), a->i);
+    tcg_gen_xori_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_mfspr(DisasContext *dc, arg_l_mfspr *a)
 {
-    TCGv spr = tcg_temp_new();
+    TCGv_i32 spr = tcg_temp_new_i32();
 
     check_r0_write(dc, a->d);
 
     if (translator_io_start(&dc->base)) {
         if (dc->delayed_branch) {
-            tcg_gen_mov_tl(cpu_pc, jmp_pc);
-            tcg_gen_discard_tl(jmp_pc);
+            tcg_gen_mov_i32(cpu_pc, jmp_pc);
+            tcg_gen_discard_i32(jmp_pc);
         } else {
-            tcg_gen_movi_tl(cpu_pc, dc->base.pc_next + 4);
+            tcg_gen_movi_i32(cpu_pc, dc->base.pc_next + 4);
         }
         dc->base.is_jmp = DISAS_EXIT;
     }
 
-    tcg_gen_ori_tl(spr, cpu_R(dc, a->a), a->k);
+    tcg_gen_ori_i32(spr, cpu_R(dc, a->a), a->k);
     gen_helper_mfspr(cpu_R(dc, a->d), tcg_env, cpu_R(dc, a->d), spr);
     return true;
 }
 
 static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a)
 {
-    TCGv spr = tcg_temp_new();
+    TCGv_i32 spr = tcg_temp_new_i32();
 
     translator_io_start(&dc->base);
 
@@ -826,14 +826,14 @@ static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a)
      * of the cpu state first, allowing it to be overwritten.
      */
     if (dc->delayed_branch) {
-        tcg_gen_mov_tl(cpu_pc, jmp_pc);
-        tcg_gen_discard_tl(jmp_pc);
+        tcg_gen_mov_i32(cpu_pc, jmp_pc);
+        tcg_gen_discard_i32(jmp_pc);
     } else {
-        tcg_gen_movi_tl(cpu_pc, dc->base.pc_next + 4);
+        tcg_gen_movi_i32(cpu_pc, dc->base.pc_next + 4);
     }
     dc->base.is_jmp = DISAS_EXIT;
 
-    tcg_gen_ori_tl(spr, cpu_R(dc, a->a), a->k);
+    tcg_gen_ori_i32(spr, cpu_R(dc, a->a), a->k);
     gen_helper_mtspr(tcg_env, spr, cpu_R(dc, a->b));
     return true;
 }
@@ -865,7 +865,7 @@ static bool trans_l_msbu(DisasContext *dc, arg_ab *a)
 static bool trans_l_slli(DisasContext *dc, arg_dal *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_shli_tl(cpu_R(dc, a->d), cpu_R(dc, a->a),
+    tcg_gen_shli_i32(cpu_R(dc, a->d), cpu_R(dc, a->a),
                     a->l & (TARGET_LONG_BITS - 1));
     return true;
 }
@@ -873,7 +873,7 @@ static bool trans_l_slli(DisasContext *dc, arg_dal *a)
 static bool trans_l_srli(DisasContext *dc, arg_dal *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_shri_tl(cpu_R(dc, a->d), cpu_R(dc, a->a),
+    tcg_gen_shri_i32(cpu_R(dc, a->d), cpu_R(dc, a->a),
                     a->l & (TARGET_LONG_BITS - 1));
     return true;
 }
@@ -881,7 +881,7 @@ static bool trans_l_srli(DisasContext *dc, arg_dal *a)
 static bool trans_l_srai(DisasContext *dc, arg_dal *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_sari_tl(cpu_R(dc, a->d), cpu_R(dc, a->a),
+    tcg_gen_sari_i32(cpu_R(dc, a->d), cpu_R(dc, a->a),
                     a->l & (TARGET_LONG_BITS - 1));
     return true;
 }
@@ -889,7 +889,7 @@ static bool trans_l_srai(DisasContext *dc, arg_dal *a)
 static bool trans_l_rori(DisasContext *dc, arg_dal *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_rotri_tl(cpu_R(dc, a->d), cpu_R(dc, a->a),
+    tcg_gen_rotri_i32(cpu_R(dc, a->d), cpu_R(dc, a->a),
                      a->l & (TARGET_LONG_BITS - 1));
     return true;
 }
@@ -897,7 +897,7 @@ static bool trans_l_rori(DisasContext *dc, arg_dal *a)
 static bool trans_l_movhi(DisasContext *dc, arg_l_movhi *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_movi_tl(cpu_R(dc, a->d), a->k << 16);
+    tcg_gen_movi_i32(cpu_R(dc, a->d), a->k << 16);
     return true;
 }
 
@@ -911,137 +911,137 @@ static bool trans_l_macrc(DisasContext *dc, arg_l_macrc *a)
 
 static bool trans_l_sfeq(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_EQ, cpu_sr_f,
+    tcg_gen_setcond_i32(TCG_COND_EQ, cpu_sr_f,
                        cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfne(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_NE, cpu_sr_f,
+    tcg_gen_setcond_i32(TCG_COND_NE, cpu_sr_f,
                        cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfgtu(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_GTU, cpu_sr_f,
+    tcg_gen_setcond_i32(TCG_COND_GTU, cpu_sr_f,
                        cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfgeu(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_GEU, cpu_sr_f,
+    tcg_gen_setcond_i32(TCG_COND_GEU, cpu_sr_f,
                        cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfltu(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_LTU, cpu_sr_f,
+    tcg_gen_setcond_i32(TCG_COND_LTU, cpu_sr_f,
                        cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfleu(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_LEU, cpu_sr_f,
+    tcg_gen_setcond_i32(TCG_COND_LEU, cpu_sr_f,
                        cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfgts(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_GT, cpu_sr_f,
+    tcg_gen_setcond_i32(TCG_COND_GT, cpu_sr_f,
                        cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfges(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_GE, cpu_sr_f,
+    tcg_gen_setcond_i32(TCG_COND_GE, cpu_sr_f,
                        cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sflts(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_LT, cpu_sr_f,
+    tcg_gen_setcond_i32(TCG_COND_LT, cpu_sr_f,
                        cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfles(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_LE,
+    tcg_gen_setcond_i32(TCG_COND_LE,
                        cpu_sr_f, cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfeqi(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_sr_f, cpu_R(dc, a->a), a->i);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfnei(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_NE, cpu_sr_f, cpu_R(dc, a->a), a->i);
+    tcg_gen_setcondi_i32(TCG_COND_NE, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfgtui(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_GTU, cpu_sr_f, cpu_R(dc, a->a), a->i);
+    tcg_gen_setcondi_i32(TCG_COND_GTU, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfgeui(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_GEU, cpu_sr_f, cpu_R(dc, a->a), a->i);
+    tcg_gen_setcondi_i32(TCG_COND_GEU, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfltui(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_LTU, cpu_sr_f, cpu_R(dc, a->a), a->i);
+    tcg_gen_setcondi_i32(TCG_COND_LTU, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfleui(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_LEU, cpu_sr_f, cpu_R(dc, a->a), a->i);
+    tcg_gen_setcondi_i32(TCG_COND_LEU, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfgtsi(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_GT, cpu_sr_f, cpu_R(dc, a->a), a->i);
+    tcg_gen_setcondi_i32(TCG_COND_GT, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfgesi(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_GE, cpu_sr_f, cpu_R(dc, a->a), a->i);
+    tcg_gen_setcondi_i32(TCG_COND_GE, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfltsi(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_LT, cpu_sr_f, cpu_R(dc, a->a), a->i);
+    tcg_gen_setcondi_i32(TCG_COND_LT, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sflesi(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_LE, cpu_sr_f, cpu_R(dc, a->a), a->i);
+    tcg_gen_setcondi_i32(TCG_COND_LE, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sys(DisasContext *dc, arg_l_sys *a)
 {
-    tcg_gen_movi_tl(cpu_pc, dc->base.pc_next);
+    tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
     gen_exception(dc, EXCP_SYSCALL);
     dc->base.is_jmp = DISAS_NORETURN;
     return true;
@@ -1049,7 +1049,7 @@ static bool trans_l_sys(DisasContext *dc, arg_l_sys *a)
 
 static bool trans_l_trap(DisasContext *dc, arg_l_trap *a)
 {
-    tcg_gen_movi_tl(cpu_pc, dc->base.pc_next);
+    tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
     gen_exception(dc, EXCP_TRAP);
     dc->base.is_jmp = DISAS_NORETURN;
     return true;
@@ -1083,7 +1083,7 @@ static bool trans_l_rfe(DisasContext *dc, arg_l_rfe *a)
 }
 
 static bool do_fp2(DisasContext *dc, arg_da *a,
-                   void (*fn)(TCGv, TCGv_env, TCGv))
+                   void (*fn)(TCGv_i32, TCGv_env, TCGv_i32))
 {
     if (!check_of32s(dc)) {
         return false;
@@ -1095,7 +1095,7 @@ static bool do_fp2(DisasContext *dc, arg_da *a,
 }
 
 static bool do_fp3(DisasContext *dc, arg_dab *a,
-                   void (*fn)(TCGv, TCGv_env, TCGv, TCGv))
+                   void (*fn)(TCGv_i32, TCGv_env, TCGv_i32, TCGv_i32))
 {
     if (!check_of32s(dc)) {
         return false;
@@ -1107,7 +1107,7 @@ static bool do_fp3(DisasContext *dc, arg_dab *a,
 }
 
 static bool do_fpcmp(DisasContext *dc, arg_ab *a,
-                     void (*fn)(TCGv, TCGv_env, TCGv, TCGv),
+                     void (*fn)(TCGv_i32, TCGv_env, TCGv_i32, TCGv_i32),
                      bool inv, bool swap)
 {
     if (!check_of32s(dc)) {
@@ -1119,7 +1119,7 @@ static bool do_fpcmp(DisasContext *dc, arg_ab *a,
         fn(cpu_sr_f, tcg_env, cpu_R(dc, a->a), cpu_R(dc, a->b));
     }
     if (inv) {
-        tcg_gen_xori_tl(cpu_sr_f, cpu_sr_f, 1);
+        tcg_gen_xori_i32(cpu_sr_f, cpu_sr_f, 1);
     }
     gen_helper_update_fpcsr(tcg_env);
     return true;
@@ -1312,7 +1312,7 @@ static bool do_dp2(DisasContext *dc, arg_da_pair *a,
 }
 
 static bool do_dpcmp(DisasContext *dc, arg_ab_pair *a,
-                     void (*fn)(TCGv, TCGv_env, TCGv_i64, TCGv_i64),
+                     void (*fn)(TCGv_i32, TCGv_env, TCGv_i64, TCGv_i64),
                      bool inv, bool swap)
 {
     TCGv_i64 t0, t1;
@@ -1334,7 +1334,7 @@ static bool do_dpcmp(DisasContext *dc, arg_ab_pair *a,
     }
 
     if (inv) {
-        tcg_gen_xori_tl(cpu_sr_f, cpu_sr_f, 1);
+        tcg_gen_xori_i32(cpu_sr_f, cpu_sr_f, 1);
     }
     gen_helper_update_fpcsr(tcg_env);
     return true;
@@ -1519,7 +1519,7 @@ static void openrisc_tr_tb_start(DisasContextBase *db, CPUState *cs)
 
     /* Allow the TCG optimizer to see that R0 == 0,
        when it's true, which is the common case.  */
-    dc->zero = tcg_constant_tl(0);
+    dc->zero = tcg_constant_i32(0);
     if (dc->tb_flags & TB_FLAGS_R0_0) {
         dc->R0 = dc->zero;
     } else {
@@ -1575,32 +1575,32 @@ static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 
     /* For DISAS_TOO_MANY, jump to the next insn.  */
     jmp_dest = dc->base.pc_next;
-    tcg_gen_movi_tl(cpu_ppc, jmp_dest - 4);
+    tcg_gen_movi_i32(cpu_ppc, jmp_dest - 4);
 
     switch (dc->base.is_jmp) {
     case DISAS_JUMP:
         jmp_dest = dc->jmp_pc_imm;
         if (jmp_dest == -1) {
             /* The jump destination is indirect/computed; use jmp_pc.  */
-            tcg_gen_mov_tl(cpu_pc, jmp_pc);
-            tcg_gen_discard_tl(jmp_pc);
+            tcg_gen_mov_i32(cpu_pc, jmp_pc);
+            tcg_gen_discard_i32(jmp_pc);
             tcg_gen_lookup_and_goto_ptr();
             break;
         }
         /* The jump destination is direct; use jmp_pc_imm.
            However, we will have stored into jmp_pc as well;
            we know now that it wasn't needed.  */
-        tcg_gen_discard_tl(jmp_pc);
+        tcg_gen_discard_i32(jmp_pc);
         /* fallthru */
 
     case DISAS_TOO_MANY:
         if (translator_use_goto_tb(&dc->base, jmp_dest)) {
             tcg_gen_goto_tb(0);
-            tcg_gen_movi_tl(cpu_pc, jmp_dest);
+            tcg_gen_movi_i32(cpu_pc, jmp_dest);
             tcg_gen_exit_tb(dc->base.tb, 0);
             break;
         }
-        tcg_gen_movi_tl(cpu_pc, jmp_dest);
+        tcg_gen_movi_i32(cpu_pc, jmp_dest);
         tcg_gen_lookup_and_goto_ptr();
         break;
 
-- 
2.51.0



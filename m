Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAD28369EF
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 17:14:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRwtv-0006bx-5x; Mon, 22 Jan 2024 11:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rRwtt-0006bH-73
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:11:53 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rRwtr-0005Mm-Id
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:11:52 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d50d0c98c3so34335955ad.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 08:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705939910; x=1706544710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IVS89ICN4mvwyaEKJcyMUTMk1Ho3XQmzlZwO2q1EX0I=;
 b=VlmMgvyIo2WoAfi1CNocuVP4FqhHV4zrWv4r4ECXerODmJPCT/VJJZ7WwZl4mjjBd9
 ch7r49PogdLjV/S7TZfb4uT4Thpny+W9trptXerXcIA+IVt0tEafhatHparuW/HtM012
 t0tm0qRSLilx68M6Q2F2VZl2xmYACjN/N2ppVxsWeLo77bzo0KuOyRMV/nTTDbMdXolc
 kDRfuJxTOj/Pt4lsy70NcbWDb2Kr+dVAbqqIjMmT38f8zMfENbbB4lZQzrq32xjIDErL
 ICd9RPDozV3ptbQkNmYfFvi84laCNVH3sjUaqLRWsSj9KkHUyRtM3abDWM/ObLsxWNuZ
 wxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705939910; x=1706544710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IVS89ICN4mvwyaEKJcyMUTMk1Ho3XQmzlZwO2q1EX0I=;
 b=HI025tj3F0NCefurN2+85EOg98SVhBoCSy4fuvb4hbDNApulWd/3XybDoxf1aE8Tts
 +LDghn4nb3oCzee7u304IbyvTl/6YMGRZdArt8+5aJH7+rmxegeDKQ6+KSo5DG3+0KlL
 5i13n7x8Yl9IN/3c4dOw7bUblVI8KD5y+E/OJVn8vLgny80HfEEC0CySb45HlzIX9EAB
 IGbsycUjGPZ4NjQbc7uaRiyhQ60a07Zg4Iveh4XTZNRtjF3WXyRjtPirfU85Z6ocpEOt
 gziKDZ44rwRIeCRfT7fgtFdzttWU4ZMZn+GNM3R80JCqSAkQlVZa0zoYWK7E7AHKxlUu
 jaHw==
X-Gm-Message-State: AOJu0YzeRKN4Ua2Dl5kNUaB2IqJ43VPXagqX8Rkf1iK7XWej53Gjrpg1
 QlMeivaCvkOs4nLCIxcb2CzhmQjt40cMzkcvNBLEi/sbr2m/Wog00901yttQAAiQo199PtUh49A
 k
X-Google-Smtp-Source: AGHT+IFyWpht4S308kv2amz6crFcbhYRRfBka7/dPVJ0UsUjROAJ8IUcnqtWObqLsqt77XZG/prvfg==
X-Received: by 2002:a17:90a:8ca:b0:290:4b14:3638 with SMTP id
 10-20020a17090a08ca00b002904b143638mr5115290pjn.12.1705939909860; 
 Mon, 22 Jan 2024 08:11:49 -0800 (PST)
Received: from grind.. ([152.234.127.94]) by smtp.gmail.com with ESMTPSA id
 db3-20020a17090ad64300b0028e245501e7sm9866446pjb.4.2024.01.22.08.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 08:11:49 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 11/13] target/riscv: change vext_get_vlmax() arguments
Date: Mon, 22 Jan 2024 13:11:05 -0300
Message-ID: <20240122161107.26737-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122161107.26737-1-dbarboza@ventanamicro.com>
References: <20240122161107.26737-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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

We'll re-use the logic froim vext_get_vlmax() in 2 other occurrences in
the next patch, but first we need to make it independent of both 'cpu'
and 'vtype'. To do that, add 'vlenb', 'vsew' and 'lmul' as parameters
instead.

Adapt the two existing callers. In cpu_get_tb_cpu_state(), rename 'sew'
to 'vsew' to be less ambiguous about what we're encoding into *pflags.

In HELPER(vsetvl) the following changes were made:

- add a 'vsew' var to store vsew. Use it in the shift to get 'sew';
- the existing 'lmul' var was renamed to 'vlmul';
- add a new 'lmul' var to store 'lmul' encoded like DisasContext:lmul.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h           |  7 +++----
 target/riscv/cpu_helper.c    | 11 +++++++----
 target/riscv/vector_helper.c | 16 ++++++++++------
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 71696762e3..5138187727 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -690,11 +690,10 @@ static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
  *               = 256 >> 7
  *               = 2
  */
-static inline uint32_t vext_get_vlmax(RISCVCPU *cpu, target_ulong vtype)
+static inline uint32_t vext_get_vlmax(uint32_t vlenb, uint32_t vsew,
+                                      int8_t lmul)
 {
-    uint8_t vsew = FIELD_EX64(vtype, VTYPE, VSEW);
-    int8_t lmul = sextract32(FIELD_EX64(vtype, VTYPE, VLMUL), 0, 3);
-    uint32_t vlen = cpu->cfg.vlenb << 3;
+    uint32_t vlen = vlenb << 3;
 
     /*
      * We need to use 'vlen' instead of 'vlenb' to
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c7cc7eb423..8da9104da4 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -81,13 +81,16 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
          * which is not supported by GVEC. So we set vl_eq_vlmax flag to true
          * only when maxsz >= 8 bytes.
          */
-        uint32_t vlmax = vext_get_vlmax(cpu, env->vtype);
-        uint32_t sew = FIELD_EX64(env->vtype, VTYPE, VSEW);
-        uint32_t maxsz = vlmax << sew;
+
+        /* lmul encoded as in DisasContext::lmul */
+        int8_t lmul = sextract32(FIELD_EX64(env->vtype, VTYPE, VLMUL), 0, 3);
+        uint32_t vsew = FIELD_EX64(env->vtype, VTYPE, VSEW);
+        uint32_t vlmax = vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
+        uint32_t maxsz = vlmax << vsew;
         bool vl_eq_vlmax = (env->vstart == 0) && (vlmax == env->vl) &&
                            (maxsz >= 8);
         flags = FIELD_DP32(flags, TB_FLAGS, VILL, env->vill);
-        flags = FIELD_DP32(flags, TB_FLAGS, SEW, sew);
+        flags = FIELD_DP32(flags, TB_FLAGS, SEW, vsew);
         flags = FIELD_DP32(flags, TB_FLAGS, LMUL,
                            FIELD_EX64(env->vtype, VTYPE, VLMUL));
         flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index b13be1541a..718a0c711a 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -35,16 +35,18 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
 {
     int vlmax, vl;
     RISCVCPU *cpu = env_archcpu(env);
-    uint64_t lmul = FIELD_EX64(s2, VTYPE, VLMUL);
-    uint16_t sew = 8 << FIELD_EX64(s2, VTYPE, VSEW);
+    uint64_t vlmul = FIELD_EX64(s2, VTYPE, VLMUL);
+    uint8_t vsew = FIELD_EX64(s2, VTYPE, VSEW);
+    uint16_t sew = 8 << vsew;
     uint8_t ediv = FIELD_EX64(s2, VTYPE, VEDIV);
     int xlen = riscv_cpu_xlen(env);
     bool vill = (s2 >> (xlen - 1)) & 0x1;
     target_ulong reserved = s2 &
                             MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
                                             xlen - 1 - R_VTYPE_RESERVED_SHIFT);
+    int8_t lmul;
 
-    if (lmul & 4) {
+    if (vlmul & 4) {
         /*
          * Fractional LMUL, check:
          *
@@ -53,8 +55,8 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
          * (vlenb << 3) >> (8 - lmul) >= sew
          * vlenb >> (8 - 3 - lmul) >= sew
          */
-        if (lmul == 4 ||
-            cpu->cfg.vlenb >> (8 - 3 - lmul) < sew) {
+        if (vlmul == 4 ||
+            cpu->cfg.vlenb >> (8 - 3 - vlmul) < sew) {
             vill = true;
         }
     }
@@ -68,7 +70,9 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
         return 0;
     }
 
-    vlmax = vext_get_vlmax(cpu, s2);
+    /* lmul encoded as in DisasContext::lmul */
+    lmul = sextract32(FIELD_EX64(s2, VTYPE, VLMUL), 0, 3);
+    vlmax = vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
     if (s1 <= vlmax) {
         vl = s1;
     } else {
-- 
2.43.0



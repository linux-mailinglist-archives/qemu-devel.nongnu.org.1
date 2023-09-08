Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C587981E7
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:09:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUeC-0005cb-Pd; Fri, 08 Sep 2023 02:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUeA-0005UK-Cj
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:14 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUe7-00074k-L1
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:13 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c0bae4da38so12131415ad.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153230; x=1694758030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2zKj+0PvJXMdpPtyy+4HtEgZTt3YDZpe426jZ7MOFzA=;
 b=VlS45unhTKTu+Rs/sCyYDcGAEh9IwZ25SXnyhOrnJ2DrhZ3KaLz5D8ieq6O2hDR3tW
 LdeTzYQwj1TeNmYw9SpK5Kfo+SQDSrLzC7hmUtIrv2F+A/LDhYqtxt4JsmKohSxTNzjm
 Nre0jilFSACBMytJOmV0y2Hxv8YRogEOH3lYLORwItmvqiDTXs2xPIf+oXxJTQvu+l+l
 6yV5ozeJma2jc2tPTv6osHIKQvCBk8UpF56/yv4XjDZEr57wuxM0Mx1yGzPwMtl/9/YE
 XHSqlJRkwJ0in/EEjjgNCGAncPNLpJFSLwKN3Cwl5n81fl0QByfpVCm7zzawVbMn+5Se
 L3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153230; x=1694758030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2zKj+0PvJXMdpPtyy+4HtEgZTt3YDZpe426jZ7MOFzA=;
 b=MAoJ2n3FOvgTYD8+1EB4D2SFh9QFwaG9Kn0/C6E9MJF7hplnJRVfyBMnS2VbeCUAX+
 iVN02H3bKJu3MtZHy/4UBio2kRZi7NUS1/TvdbzFYoG8hLzoKBWbStdrD7+JE+fnpPKV
 hWmhA41jBOX9MaIz6MjuDNag/4Wzcfcn8+lmFKPkQ34QAleSyBHrQLN2wi0t/lZxsiQi
 MIV/DDwM9g7PcuoWnWRj4H6ImM8YmBfoCiRnXyhixskRznqIo6xPVEgH9+8dsDl6rqyN
 BxNigUinI2FdJfC/Jsy0SoEuHKlobCdBSHADRJTEsY8wI42sn4AtkLpL2WQ4RCB3zNFY
 KLSw==
X-Gm-Message-State: AOJu0Yznjo1kdWGatJO/W9Jx83xKxijetPLJiYlUAS+4IsmKmKOcwJmq
 WzKhUYwdrpfDyTVoqCpCrS3KVJz8MMGEz24c
X-Google-Smtp-Source: AGHT+IGKkn03rcItxatgAflNKsWdNY8X0+bYQ71IFR6rBKb7l4j5fQvxYoYu6i/eLNbQGBgw8hAcFA==
X-Received: by 2002:a17:902:8ec2:b0:1bb:85cd:9190 with SMTP id
 x2-20020a1709028ec200b001bb85cd9190mr1722333plo.18.1694153229792; 
 Thu, 07 Sep 2023 23:07:09 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:07:08 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 35/65] target/riscv: Update CSR bits name for svadu extension
Date: Fri,  8 Sep 2023 16:04:01 +1000
Message-ID: <20230908060431.1903919-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Weiwei Li <liweiwei@iscas.ac.cn>

The Svadu specification updated the name of the *envcfg bit from
HADE to ADUE.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20230816141916.66898-1-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h   |  8 ++++----
 target/riscv/cpu.c        |  4 ++--
 target/riscv/cpu_helper.c |  6 +++---
 target/riscv/csr.c        | 12 ++++++------
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 59f0ffd9e1..1c2ffae883 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -745,12 +745,12 @@ typedef enum RISCVException {
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
-#define MENVCFG_HADE                       (1ULL << 61)
+#define MENVCFG_ADUE                       (1ULL << 61)
 #define MENVCFG_PBMTE                      (1ULL << 62)
 #define MENVCFG_STCE                       (1ULL << 63)
 
 /* For RV32 */
-#define MENVCFGH_HADE                      BIT(29)
+#define MENVCFGH_ADUE                      BIT(29)
 #define MENVCFGH_PBMTE                     BIT(30)
 #define MENVCFGH_STCE                      BIT(31)
 
@@ -763,12 +763,12 @@ typedef enum RISCVException {
 #define HENVCFG_CBIE                       MENVCFG_CBIE
 #define HENVCFG_CBCFE                      MENVCFG_CBCFE
 #define HENVCFG_CBZE                       MENVCFG_CBZE
-#define HENVCFG_HADE                       MENVCFG_HADE
+#define HENVCFG_ADUE                       MENVCFG_ADUE
 #define HENVCFG_PBMTE                      MENVCFG_PBMTE
 #define HENVCFG_STCE                       MENVCFG_STCE
 
 /* For RV32 */
-#define HENVCFGH_HADE                       MENVCFGH_HADE
+#define HENVCFGH_ADUE                       MENVCFGH_ADUE
 #define HENVCFGH_PBMTE                      MENVCFGH_PBMTE
 #define HENVCFGH_STCE                       MENVCFGH_STCE
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fae1c92c5c..8071f05f15 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -886,9 +886,9 @@ static void riscv_cpu_reset_hold(Object *obj)
     env->two_stage_lookup = false;
 
     env->menvcfg = (cpu->cfg.ext_svpbmt ? MENVCFG_PBMTE : 0) |
-                   (cpu->cfg.ext_svadu ? MENVCFG_HADE : 0);
+                   (cpu->cfg.ext_svadu ? MENVCFG_ADUE : 0);
     env->henvcfg = (cpu->cfg.ext_svpbmt ? HENVCFG_PBMTE : 0) |
-                   (cpu->cfg.ext_svadu ? HENVCFG_HADE : 0);
+                   (cpu->cfg.ext_svadu ? HENVCFG_ADUE : 0);
 
     /* Initialized default priorities of local interrupts. */
     for (i = 0; i < ARRAY_SIZE(env->miprio); i++) {
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 9f611d89bb..3a02079290 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -861,11 +861,11 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     }
 
     bool pbmte = env->menvcfg & MENVCFG_PBMTE;
-    bool hade = env->menvcfg & MENVCFG_HADE;
+    bool adue = env->menvcfg & MENVCFG_ADUE;
 
     if (first_stage && two_stage && env->virt_enabled) {
         pbmte = pbmte && (env->henvcfg & HENVCFG_PBMTE);
-        hade = hade && (env->henvcfg & HENVCFG_HADE);
+        adue = adue && (env->henvcfg & HENVCFG_ADUE);
     }
 
     int ptshift = (levels - 1) * ptidxbits;
@@ -1026,7 +1026,7 @@ restart:
 
     /* Page table updates need to be atomic with MTTCG enabled */
     if (updated_pte != pte && !is_debug) {
-        if (!hade) {
+        if (!adue) {
             return TRANSLATE_FAIL;
         }
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e4490d5bed..b8e0d0cb4c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1957,7 +1957,7 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                 (cfg->ext_sstc ? MENVCFG_STCE : 0) |
-                (cfg->ext_svadu ? MENVCFG_HADE : 0);
+                (cfg->ext_svadu ? MENVCFG_ADUE : 0);
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
 
@@ -1977,7 +1977,7 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                     (cfg->ext_sstc ? MENVCFG_STCE : 0) |
-                    (cfg->ext_svadu ? MENVCFG_HADE : 0);
+                    (cfg->ext_svadu ? MENVCFG_ADUE : 0);
     uint64_t valh = (uint64_t)val << 32;
 
     env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
@@ -2029,7 +2029,7 @@ static RISCVException read_henvcfg(CPURISCVState *env, int csrno,
      * henvcfg.stce is read_only 0 when menvcfg.stce = 0
      * henvcfg.hade is read_only 0 when menvcfg.hade = 0
      */
-    *val = env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_HADE) |
+    *val = env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE) |
                            env->menvcfg);
     return RISCV_EXCP_NONE;
 }
@@ -2046,7 +2046,7 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
     }
 
     if (riscv_cpu_mxl(env) == MXL_RV64) {
-        mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_HADE);
+        mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
     }
 
     env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
@@ -2064,7 +2064,7 @@ static RISCVException read_henvcfgh(CPURISCVState *env, int csrno,
         return ret;
     }
 
-    *val = (env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_HADE) |
+    *val = (env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE) |
                             env->menvcfg)) >> 32;
     return RISCV_EXCP_NONE;
 }
@@ -2073,7 +2073,7 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
                                      target_ulong val)
 {
     uint64_t mask = env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
-                                    HENVCFG_HADE);
+                                    HENVCFG_ADUE);
     uint64_t valh = (uint64_t)val << 32;
     RISCVException ret;
 
-- 
2.41.0



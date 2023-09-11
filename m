Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA2979A3B7
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:46:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfagd-0004FW-G0; Mon, 11 Sep 2023 02:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfagI-00030W-6Q
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:45:59 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfagE-0005EZ-V7
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:45:57 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3aa1443858eso3190901b6e.3
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414753; x=1695019553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAOZAeFSdxVr60MLt73fKHVsOxnw3vFeX18pOb0w86I=;
 b=mATEwFpcp1VpSenP1xRb9Iy7TZf1KZLtv8NY2TwadFldFeZQQWy82F9k6LL1kmH0Gh
 pix6jc9PePLYqI1j9RAWuU4yRRhGAvnV3AFdFPqReUX9WAxqUnOxZi6QjWLzQcVcoDzH
 tbRch1mQyas9JT0E4XMHcB2Xi7Rhkd4V1iP7dafaEZxx6EzWgpGWwG9y87Q2zK1CUe0M
 GOtobu8BACA7a8DV8C6lDix4lBi8zUnU0oP9WHxcJwGJOGpWZx0j45EdJiojA0fupkxu
 5DchroDJibINOy6B9CNk8uGNUAyWmDjRi+0ydhEkeIHF5fDjriv3+lQz4sX2ok3g/XM3
 82Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414753; x=1695019553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAOZAeFSdxVr60MLt73fKHVsOxnw3vFeX18pOb0w86I=;
 b=KEE6icHmNWbIcHM5thyurTcLle1L+Yp9v7nGuALXNqi3gcb6dYaIYy6Wc9M6W6mWVh
 ADTWlPpjin3ZmYal6G7MOvzsVWJDDtXn+HEuQkVtcbmy8CDceAEloX0bsPZZ7pYL9NDt
 Oq2CMYPgTZacOjq/rj7c6fr5O23UHRdfJjE5FvvnrXp8B0+r6/99fjucyf36H1vvVqVU
 3lELVDfqoxcG7ADkiXEL8zOI+00gvGf0kXhUAya4ie+0onFhZEzqHERo6PEY0z9Ic7ld
 AqnAbQv0oN01iAoBJ4n9tfszmY8CFE3aMKEza2MvRYU7wmW7dHpetKjBYVa9xef/HNXd
 bo3Q==
X-Gm-Message-State: AOJu0YzSongtZALZhDrfse87FolLuad5PVDEzpm5TcnsVbnUjAOboiDa
 1MLMe5hSrxuwdTWtBj9ZyCo1ylqphMEzLw==
X-Google-Smtp-Source: AGHT+IGMOLzk6K/zLSLFAcTFgpyZWD2Oe2hv+v9dcqELrqMGclttOnOj5EwHzTXSiF0/RUqFyeJ3gQ==
X-Received: by 2002:a05:6808:f07:b0:3a9:7634:23f9 with SMTP id
 m7-20020a0568080f0700b003a9763423f9mr11853008oiw.12.1694414753638; 
 Sun, 10 Sep 2023 23:45:53 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:45:52 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 35/45] target/riscv: Update CSR bits name for svadu extension
Date: Mon, 11 Sep 2023 16:43:10 +1000
Message-ID: <20230911064320.939791-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x230.google.com
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
index 31a8d80990..3d6ffaabc7 100644
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
index 661744e6d4..63c3b0d9fc 100644
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



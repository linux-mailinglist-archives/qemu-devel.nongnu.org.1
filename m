Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E94B881D7DE
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Dec 2023 05:49:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHGPn-0002cj-3g; Sat, 23 Dec 2023 23:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rHGPk-0002bz-Ll; Sat, 23 Dec 2023 23:48:37 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rHGPi-0000hb-RI; Sat, 23 Dec 2023 23:48:36 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40c3ceded81so32280565e9.1; 
 Sat, 23 Dec 2023 20:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703393313; x=1703998113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iIwoM4vO0k49agOYoe2ighuS+OSbTKBks6BP+HYYuV0=;
 b=SmnPt1Ymrk4g90iml0fAf5pbDAc0twls6u3+X2a9csdcYvTwXh7aOveWZxlW92cAz/
 OVcj6SlqAj6CrUNXrHhMcUJKHvD9seCZtBrbpIpTdgnRiDZir9lSG6FaU0Se0YQetS7N
 50cl1k0mbxc5NpOf8XjtJ+po9iAwrENcT9V/41wkETILAyqGV3QF+EJbLVNkMm3BaFDI
 0Nke+XhyqA/Gd+oDoJwy1aoijD9sj2ipdJGcRN7SS7VdN9KOAHhuMdltPloA2G7MWHm/
 oK3qx+3MVeZyBMW49rMZ4gflN+UI1deYgdYbgoO2tWk7/1NSk+W3psxaIgnGQ+zfrnfO
 Tp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703393313; x=1703998113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iIwoM4vO0k49agOYoe2ighuS+OSbTKBks6BP+HYYuV0=;
 b=U4V/ldS+dhunZKzGloz4UFGlIp2YAaItDx2Db2RFt+WC1ujQE1Bt+DWT3Vc8JFNufU
 ht21Jg5O+kgaXVKUC5a752YnZJaycWEWShSWXGMb/TO+1Vgg92NsIA4zBgKhkETbE/+1
 XxPJ+WfF9jAqg+kZq7Zlce8RsPklyJBGprYexZmai4no8HMXHCAi39b4R7HE4KVc36hR
 ua4/c8XM32CSEWq72L/zhtwgQmyInsQpaSShz/nHudyeeOQxee8CtgmT4w8KrzMEHwYT
 dZ6NJGiJGWoXDs8hU3GMZGrkyFJ3eO/OGQq7JLSYvMkH9z01rm7LMxgH0ImQIi3+0Jsk
 +S3g==
X-Gm-Message-State: AOJu0Yx1DoFXtFxJ7KVHRcEKg34u85dnTpR71Yl7sJFnTc+Rl1Uw5KNJ
 XzvCl0eLEFLbCKgJFkSIlpA=
X-Google-Smtp-Source: AGHT+IGqNLPXyatLP/BWj72EVsMtMwgInVr1JUnWDHSlgDGmdsnCucTWmmW8pUg7GGwq5JEY520jHA==
X-Received: by 2002:a7b:c393:0:b0:40c:3d90:49f1 with SMTP id
 s19-20020a7bc393000000b0040c3d9049f1mr2095290wmj.125.1703393312883; 
 Sat, 23 Dec 2023 20:48:32 -0800 (PST)
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 e14-20020a5d530e000000b0033668ac65ddsm7639513wrv.25.2023.12.23.20.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Dec 2023 20:48:31 -0800 (PST)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v2 2/6] target/riscv: Add new CSR fields for S{sn, mn,
 m}pm extensions as part of Zjpm v0.8
Date: Sun, 24 Dec 2023 04:48:08 +0000
Message-Id: <20231224044812.2072140-3-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231224044812.2072140-1-me@deliversmonkey.space>
References: <20231224044812.2072140-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=baturo.alexey@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
---
 target/riscv/cpu.h      |  8 ++++++++
 target/riscv/cpu_bits.h |  3 +++
 target/riscv/cpu_cfg.h  |  3 +++
 target/riscv/csr.c      | 11 +++++++++++
 target/riscv/machine.c  |  6 ++++--
 target/riscv/pmp.c      | 13 ++++++++++---
 target/riscv/pmp.h      | 11 ++++++-----
 7 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 73f7004936..bd379ee653 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -102,6 +102,14 @@ typedef enum {
     EXT_STATUS_DIRTY,
 } RISCVExtStatus;
 
+/* Enum holds PMM field values for Zjpm v0.8 extension */
+typedef enum {
+    PMM_FIELD_DISABLED = 0,
+    PMM_FIELD_RESERVED = 1,
+    PMM_FIELD_PMLEN7   = 2,
+    PMM_FIELD_PMLEN16  = 3,
+} RISCVPmPmm;
+
 #define MMU_USER_IDX 3
 
 #define MAX_RISCV_PMPS (16)
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 1c92458a01..7cf1049bf4 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -715,6 +715,7 @@ typedef enum RISCVException {
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
+#define MENVCFG_PMM                        (3ULL << 32)
 #define MENVCFG_ADUE                       (1ULL << 61)
 #define MENVCFG_PBMTE                      (1ULL << 62)
 #define MENVCFG_STCE                       (1ULL << 63)
@@ -728,11 +729,13 @@ typedef enum RISCVException {
 #define SENVCFG_CBIE                       MENVCFG_CBIE
 #define SENVCFG_CBCFE                      MENVCFG_CBCFE
 #define SENVCFG_CBZE                       MENVCFG_CBZE
+#define SENVCFG_PMM                        MENVCFG_PMM
 
 #define HENVCFG_FIOM                       MENVCFG_FIOM
 #define HENVCFG_CBIE                       MENVCFG_CBIE
 #define HENVCFG_CBCFE                      MENVCFG_CBCFE
 #define HENVCFG_CBZE                       MENVCFG_CBZE
+#define HENVCFG_PMM                        MENVCFG_PMM
 #define HENVCFG_ADUE                       MENVCFG_ADUE
 #define HENVCFG_PBMTE                      MENVCFG_PBMTE
 #define HENVCFG_STCE                       MENVCFG_STCE
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index f4605fb190..201f8af6ae 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -113,6 +113,9 @@ struct RISCVCPUConfig {
     bool ext_ssaia;
     bool ext_sscofpmf;
     bool ext_smepmp;
+    bool ext_ssnpm;
+    bool ext_smnpm;
+    bool ext_smmpm;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ea4e1ac6ef..a67ba30494 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -527,6 +527,9 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
     if (riscv_cpu_cfg(env)->ext_zkr) {
         return RISCV_EXCP_NONE;
     }
+    if (riscv_cpu_cfg(env)->ext_smmpm) {
+        return RISCV_EXCP_NONE;
+    }
 
     return RISCV_EXCP_ILLEGAL_INST;
 }
@@ -2030,6 +2033,10 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                 (cfg->ext_sstc ? MENVCFG_STCE : 0) |
                 (cfg->ext_svadu ? MENVCFG_ADUE : 0);
     }
+    /* Update PMM field only if the value is valid according to Zjpm v0.8 */
+    if (((val & MENVCFG_PMM) >> 32) != PMM_FIELD_RESERVED) {
+        mask |= MENVCFG_PMM;
+    }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
 
     return RISCV_EXCP_NONE;
@@ -2074,6 +2081,10 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
     uint64_t mask = SENVCFG_FIOM | SENVCFG_CBIE | SENVCFG_CBCFE | SENVCFG_CBZE;
+    /* Update PMM field only if the value is valid according to Zjpm v0.8 */
+    if (((val & SENVCFG_PMM) >> 32) != PMM_FIELD_RESERVED) {
+        mask |= SENVCFG_PMM;
+    }
     RISCVException ret;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 860fe56d43..5e9c5b43ab 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -153,9 +153,8 @@ static const VMStateDescription vmstate_vector = {
 static bool pointermasking_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
-    CPURISCVState *env = &cpu->env;
 
-    return riscv_has_ext(env, RVJ);
+    return cpu->cfg.ext_ssnpm || cpu->cfg.ext_smnpm || cpu->cfg.ext_smmpm;
 }
 
 static const VMStateDescription vmstate_pointermasking = {
@@ -164,6 +163,9 @@ static const VMStateDescription vmstate_pointermasking = {
     .minimum_version_id = 1,
     .needed = pointermasking_needed,
     .fields = (VMStateField[]) {
+        VMSTATE_UINTTL(env.mseccfg, RISCVCPU),
+        VMSTATE_UINTTL(env.senvcfg, RISCVCPU),
+        VMSTATE_UINTTL(env.menvcfg, RISCVCPU),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 162e88a90a..893ccd58d8 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -576,6 +576,12 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
 void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
 {
     int i;
+    uint64_t mask = MSECCFG_MMWP | MSECCFG_MML;
+
+    /* Update PMM field only if the value is valid according to Zjpm v0.8 */
+    if (((val & MSECCFG_PMM) >> 32) != PMM_FIELD_RESERVED) {
+        mask |= MSECCFG_PMM;
+    }
 
     trace_mseccfg_csr_write(env->mhartid, val);
 
@@ -591,12 +597,13 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
 
     if (riscv_cpu_cfg(env)->ext_smepmp) {
         /* Sticky bits */
-        val |= (env->mseccfg & (MSECCFG_MMWP | MSECCFG_MML));
-        if ((val ^ env->mseccfg) & (MSECCFG_MMWP | MSECCFG_MML)) {
+        val |= (env->mseccfg & mask);
+        if ((val ^ env->mseccfg) & mask) {
             tlb_flush(env_cpu(env));
         }
     } else {
-        val &= ~(MSECCFG_MMWP | MSECCFG_MML | MSECCFG_RLB);
+        mask |= MSECCFG_RLB;
+        val &= ~(mask);
     }
 
     env->mseccfg = val;
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index 9af8614cd4..b3ca51c26d 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -40,11 +40,12 @@ typedef enum {
 } pmp_am_t;
 
 typedef enum {
-    MSECCFG_MML   = 1 << 0,
-    MSECCFG_MMWP  = 1 << 1,
-    MSECCFG_RLB   = 1 << 2,
-    MSECCFG_USEED = 1 << 8,
-    MSECCFG_SSEED = 1 << 9
+    MSECCFG_MML       = 1 << 0,
+    MSECCFG_MMWP      = 1 << 1,
+    MSECCFG_RLB       = 1 << 2,
+    MSECCFG_USEED     = 1 << 8,
+    MSECCFG_SSEED     = 1 << 9,
+    MSECCFG_PMM       = 3UL << 32,
 } mseccfg_field_t;
 
 typedef struct {
-- 
2.34.1



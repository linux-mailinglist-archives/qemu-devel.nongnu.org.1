Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5B29E2FB5
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Dec 2024 00:17:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIc6i-0001PZ-Pn; Tue, 03 Dec 2024 18:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIc6c-0001Kz-IC
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 18:14:58 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIc6a-0001Kp-3h
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 18:14:58 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-724e14b90cfso6138394b3a.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 15:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733267694; x=1733872494;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XRhB3NOg6WFytSRkGTDAssg6WaUaHQdukH6It54foGQ=;
 b=jXmUofXEdVR9ZrQINggmdUTZJq2UuDBK0VmwSgAo1BA7E5zn7M1meuT2XxyN0O+ZNr
 slwYUbUNPEeUVc6H+3I7IKDFMZNrByIjkUnQCjzIbw+/9IpjA3eNXVj/j9/g1UM0+qFD
 2/4b/mb1x28Z8pdjXrD3q+qEBu1n+aE8nUlWq4EkCpXSsXL2RK9V+8O/cnN1Qa5YL+4l
 qeSvjcagcMrDV/qdlRoNXoi3k3A5t8vuFDZgvwnhrjRJ7RizRHZFOoU4rXnbOI/NmF5o
 AQGG4NbGPMjlErO1vIZT0KAT9RK+sca6VtugZDQWgux7xkOtcNagMnf0pxpdALO+NI4M
 8XUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733267694; x=1733872494;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XRhB3NOg6WFytSRkGTDAssg6WaUaHQdukH6It54foGQ=;
 b=OtzHsXZZaoHTMQBpb1519esvqHe+DXiJU2kS7iMsLmr6aO+6qyU0Qi0ufI27WTvgKL
 0rGbLDOjGecYDGqjxUSQPIHPKvMFegUDHbUijLRTOI8MnurG0DtpJEb7VHJEwvKSkwgz
 6vyZFkcZGypF7iyJWQvvDQBfWeVqbrxi1mgcSPre9d7LVBngWdp+A8OA1+jXkc/kwqAQ
 oHl0VvxEMf+/XSdto4FQTnrOExa+TUsjBauXbbFghm4Cl3CuhzLCKrDB9eztWCsZgnQM
 DZKvnGVdaGzq4TxW2y5mSPprwUecmZdyNlF4KDNxLFUjHCnA+cN519BUMkcNIDC9uRmm
 2dqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWUwpLtemzw+1GPSQXiUrDxR/MLup485cHkYiO3+3LLziCKEJJ5cpDNd7J2ZI7PI3Yf3V/YmvhEfnF@nongnu.org
X-Gm-Message-State: AOJu0Yz9mJjAyJ72yefsQ6uTmO8fJpdasp7QMKvbaot/wS/S42Iqo0LB
 8JLPuEJZOBV1hH8SKLp+n9G6jhDeAtIOUl54o+ojv/R/mQqjt3e3nwtuhinTs8M=
X-Gm-Gg: ASbGncsTJLwdrf8w/Y1CfJ4loHoUtkgbeLRkwpMn36WuZ0E6xvakSvY/dZ4NE9no4O9
 89Va84LBXwkYnobYFhZPvRv1pLK4PVYplH5BM+yaMdvEcytjueICPLsIObAdbIZ8mt1fY/Aa2rZ
 TOvlmD2qwbkuDY74aG9A+5JXTNqaR8+nzl9Gd1o7/U1bt510cV888jCK1oaGbH0UQFB+SZ3QsZf
 pwZxDqh1JeQw5Z2IZ8G49C77TOgsOLpKtJQg2tHC1FkI1voyO3NpkjSa1RN24A=
X-Google-Smtp-Source: AGHT+IEQ72ZChzEml7gPJrIzVb5lQs+Libj5HRyer8Pi1ZIc9aasy24IKJiw3gNq+V3tAYmOqRNRow==
X-Received: by 2002:a05:6a00:3c8a:b0:71e:1722:d02c with SMTP id
 d2e1a72fcca58-7257fa3a16cmr6074854b3a.3.1733267694566; 
 Tue, 03 Dec 2024 15:14:54 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254180f78asm11032133b3a.133.2024.12.03.15.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:14:54 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 03 Dec 2024 15:14:46 -0800
Subject: [PATCH v4 08/11] target/riscv: Add counter
 delegation/configuration support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-counter_delegation-v4-8-c12a89baed86@rivosinc.com>
References: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
In-Reply-To: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

The Smcdeleg/Ssccfg adds the support for counter delegation via
S*indcsr and Ssccfg.

It also adds a new shadow CSR scountinhibit and menvcfg enable bit (CDE)
to enable this extension and scountovf virtualization.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Co-developed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/csr.c | 304 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 292 insertions(+), 12 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 0985dbdca76d..a77b6ed4c9f3 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -383,6 +383,21 @@ static RISCVException aia_smode32(CPURISCVState *env, int csrno)
     return smode32(env, csrno);
 }
 
+static RISCVException scountinhibit_pred(CPURISCVState *env, int csrno)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+
+    if (!cpu->cfg.ext_ssccfg || !cpu->cfg.ext_smcdeleg) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    if (env->virt_enabled) {
+        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+    }
+
+    return smode(env, csrno);
+}
+
 static bool csrind_extensions_present(CPURISCVState *env)
 {
     return riscv_cpu_cfg(env)->ext_smcsrind || riscv_cpu_cfg(env)->ext_sscsrind;
@@ -1220,10 +1235,9 @@ done:
     return result;
 }
 
-static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
-                                        target_ulong val)
+static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
+                                          uint32_t ctr_idx)
 {
-    int ctr_idx = csrno - CSR_MCYCLE;
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
     uint64_t mhpmctr_val = val;
 
@@ -1248,10 +1262,9 @@ static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
-                                         target_ulong val)
+static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
+                                          uint32_t ctr_idx)
 {
-    int ctr_idx = csrno - CSR_MCYCLEH;
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
     uint64_t mhpmctr_val = counter->mhpmcounter_val;
     uint64_t mhpmctrh_val = val;
@@ -1273,6 +1286,20 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static int write_mhpmcounter(CPURISCVState *env, int csrno, target_ulong val)
+{
+    int ctr_idx = csrno - CSR_MCYCLE;
+
+    return riscv_pmu_write_ctr(env, val, ctr_idx);
+}
+
+static int write_mhpmcounterh(CPURISCVState *env, int csrno, target_ulong val)
+{
+    int ctr_idx = csrno - CSR_MCYCLEH;
+
+    return riscv_pmu_write_ctrh(env, val, ctr_idx);
+}
+
 RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
                                          bool upper_half, uint32_t ctr_idx)
 {
@@ -1338,6 +1365,167 @@ static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
     return riscv_pmu_read_ctr(env, val, true, ctr_index);
 }
 
+static int rmw_cd_mhpmcounter(CPURISCVState *env, int ctr_idx,
+                              target_ulong *val, target_ulong new_val,
+                              target_ulong wr_mask)
+{
+    if (wr_mask != 0 && wr_mask != -1) {
+        return -EINVAL;
+    }
+
+    if (!wr_mask && val) {
+        riscv_pmu_read_ctr(env, val, false, ctr_idx);
+    } else if (wr_mask) {
+        riscv_pmu_write_ctr(env, new_val, ctr_idx);
+    } else {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int rmw_cd_mhpmcounterh(CPURISCVState *env, int ctr_idx,
+                               target_ulong *val, target_ulong new_val,
+                               target_ulong wr_mask)
+{
+    if (wr_mask != 0 && wr_mask != -1) {
+        return -EINVAL;
+    }
+
+    if (!wr_mask && val) {
+        riscv_pmu_read_ctr(env, val, true, ctr_idx);
+    } else if (wr_mask) {
+        riscv_pmu_write_ctrh(env, new_val, ctr_idx);
+    } else {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
+                            target_ulong *val, target_ulong new_val,
+                            target_ulong wr_mask)
+{
+    uint64_t mhpmevt_val = new_val;
+
+    if (wr_mask != 0 && wr_mask != -1) {
+        return -EINVAL;
+    }
+
+    if (!wr_mask && val) {
+        *val = env->mhpmevent_val[evt_index];
+        if (riscv_cpu_cfg(env)->ext_sscofpmf) {
+            *val &= ~MHPMEVENT_BIT_MINH;
+        }
+    } else if (wr_mask) {
+        wr_mask &= ~MHPMEVENT_BIT_MINH;
+        mhpmevt_val = (new_val & wr_mask) |
+                      (env->mhpmevent_val[evt_index] & ~wr_mask);
+        if (riscv_cpu_mxl(env) == MXL_RV32) {
+            mhpmevt_val = mhpmevt_val |
+                          ((uint64_t)env->mhpmeventh_val[evt_index] << 32);
+        }
+        env->mhpmevent_val[evt_index] = mhpmevt_val;
+        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
+    } else {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
+                             target_ulong *val, target_ulong new_val,
+                             target_ulong wr_mask)
+{
+    uint64_t mhpmevth_val;
+    uint64_t mhpmevt_val = env->mhpmevent_val[evt_index];
+
+    if (wr_mask != 0 && wr_mask != -1) {
+        return -EINVAL;
+    }
+
+    if (!wr_mask && val) {
+        *val = env->mhpmeventh_val[evt_index];
+        if (riscv_cpu_cfg(env)->ext_sscofpmf) {
+            *val &= ~MHPMEVENTH_BIT_MINH;
+        }
+    } else if (wr_mask) {
+        wr_mask &= ~MHPMEVENTH_BIT_MINH;
+        env->mhpmeventh_val[evt_index] =
+            (new_val & wr_mask) | (env->mhpmeventh_val[evt_index] & ~wr_mask);
+        mhpmevth_val = env->mhpmeventh_val[evt_index];
+        mhpmevt_val = mhpmevt_val | (mhpmevth_val << 32);
+        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
+    } else {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
+                            target_ulong new_val, target_ulong wr_mask)
+{
+    switch (cfg_index) {
+    case 0:             /* CYCLECFG */
+        if (wr_mask) {
+            wr_mask &= ~MCYCLECFG_BIT_MINH;
+            env->mcyclecfg = (new_val & wr_mask) | (env->mcyclecfg & ~wr_mask);
+        } else {
+            *val = env->mcyclecfg &= ~MHPMEVENTH_BIT_MINH;
+        }
+        break;
+    case 2:             /* INSTRETCFG */
+        if (wr_mask) {
+            wr_mask &= ~MINSTRETCFG_BIT_MINH;
+            env->minstretcfg = (new_val & wr_mask) |
+                               (env->minstretcfg & ~wr_mask);
+        } else {
+            *val = env->minstretcfg &= ~MHPMEVENTH_BIT_MINH;
+        }
+        break;
+    default:
+        return -EINVAL;
+    }
+    return 0;
+}
+
+static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
+                            target_ulong new_val, target_ulong wr_mask)
+{
+
+    if (riscv_cpu_mxl(env) != MXL_RV32) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    switch (cfg_index) {
+    case 0:         /* CYCLECFGH */
+        if (wr_mask) {
+            wr_mask &= ~MCYCLECFGH_BIT_MINH;
+            env->mcyclecfgh = (new_val & wr_mask) |
+                              (env->mcyclecfgh & ~wr_mask);
+        } else {
+            *val = env->mcyclecfgh;
+        }
+        break;
+    case 2:          /* INSTRETCFGH */
+        if (wr_mask) {
+            wr_mask &= ~MINSTRETCFGH_BIT_MINH;
+            env->minstretcfgh = (new_val & wr_mask) |
+                                (env->minstretcfgh & ~wr_mask);
+        } else {
+            *val = env->minstretcfgh;
+        }
+        break;
+    default:
+        return -EINVAL;
+    }
+    return 0;
+}
+
+
 static RISCVException read_scountovf(CPURISCVState *env, int csrno,
                                      target_ulong *val)
 {
@@ -1347,6 +1535,14 @@ static RISCVException read_scountovf(CPURISCVState *env, int csrno,
     target_ulong *mhpm_evt_val;
     uint64_t of_bit_mask;
 
+    /* Virtualize scountovf for counter delegation */
+    if (riscv_cpu_cfg(env)->ext_sscofpmf &&
+        riscv_cpu_cfg(env)->ext_ssccfg &&
+        get_field(env->menvcfg, MENVCFG_CDE) &&
+        env->virt_enabled) {
+        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+    }
+
     if (riscv_cpu_mxl(env) == MXL_RV32) {
         mhpm_evt_val = env->mhpmeventh_val;
         of_bit_mask = MHPMEVENTH_BIT_OF;
@@ -2290,11 +2486,72 @@ static int rmw_xireg_cd(CPURISCVState *env, int csrno,
                         target_ulong isel, target_ulong *val,
                         target_ulong new_val, target_ulong wr_mask)
 {
-    if (!riscv_cpu_cfg(env)->ext_smcdeleg) {
-        return RISCV_EXCP_ILLEGAL_INST;
+    int ret = -EINVAL;
+    int ctr_index = isel - ISELECT_CD_FIRST;
+    int isel_hpm_start = ISELECT_CD_FIRST + 3;
+
+    if (!riscv_cpu_cfg(env)->ext_smcdeleg || !riscv_cpu_cfg(env)->ext_ssccfg) {
+        ret = RISCV_EXCP_ILLEGAL_INST;
+        goto done;
     }
-    /* TODO: Implement the functionality later */
-    return RISCV_EXCP_NONE;
+
+    /* Invalid siselect value for reserved */
+    if (ctr_index == 1) {
+        goto done;
+    }
+
+    /* sireg4 and sireg5 provides access RV32 only CSRs */
+    if (((csrno == CSR_SIREG5) || (csrno == CSR_SIREG4)) &&
+        (riscv_cpu_mxl(env) != MXL_RV32)) {
+        ret = RISCV_EXCP_ILLEGAL_INST;
+        goto done;
+    }
+
+    /* Check Sscofpmf dependancy */
+    if (!riscv_cpu_cfg(env)->ext_sscofpmf && csrno == CSR_SIREG5 &&
+        (isel_hpm_start <= isel && isel <= ISELECT_CD_LAST)) {
+        goto done;
+    }
+
+    /* Check smcntrpmf dependancy */
+    if (!riscv_cpu_cfg(env)->ext_smcntrpmf &&
+        (csrno == CSR_SIREG2 || csrno == CSR_SIREG5) &&
+        (ISELECT_CD_FIRST <= isel && isel < isel_hpm_start)) {
+        goto done;
+    }
+
+    if (!get_field(env->mcounteren, BIT(ctr_index)) ||
+        !get_field(env->menvcfg, MENVCFG_CDE)) {
+        goto done;
+    }
+
+    switch (csrno) {
+    case CSR_SIREG:
+        ret = rmw_cd_mhpmcounter(env, ctr_index, val, new_val, wr_mask);
+        break;
+    case CSR_SIREG4:
+        ret = rmw_cd_mhpmcounterh(env, ctr_index, val, new_val, wr_mask);
+        break;
+    case CSR_SIREG2:
+        if (ctr_index <= 2) {
+            ret = rmw_cd_ctr_cfg(env, ctr_index, val, new_val, wr_mask);
+        } else {
+            ret = rmw_cd_mhpmevent(env, ctr_index, val, new_val, wr_mask);
+        }
+        break;
+    case CSR_SIREG5:
+        if (ctr_index <= 2) {
+            ret = rmw_cd_ctr_cfgh(env, ctr_index, val, new_val, wr_mask);
+        } else {
+            ret = rmw_cd_mhpmeventh(env, ctr_index, val, new_val, wr_mask);
+        }
+        break;
+    default:
+        goto done;
+    }
+
+done:
+    return ret;
 }
 
 /*
@@ -2573,6 +2830,21 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException read_scountinhibit(CPURISCVState *env, int csrno,
+                                         target_ulong *val)
+{
+    /* S-mode can only access the bits delegated by M-mode */
+    *val = env->mcountinhibit & env->mcounteren;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_scountinhibit(CPURISCVState *env, int csrno,
+                                          target_ulong val)
+{
+    write_mcountinhibit(env, csrno, val & env->mcounteren);
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException read_mcounteren(CPURISCVState *env, int csrno,
                                       target_ulong *val)
 {
@@ -2675,11 +2947,13 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
-    uint64_t mask = MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE | MENVCFG_CBZE;
+    uint64_t mask = MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
+                    MENVCFG_CBZE | MENVCFG_CDE;
 
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                 (cfg->ext_sstc ? MENVCFG_STCE : 0) |
+                (cfg->ext_smcdeleg ? MENVCFG_CDE : 0) |
                 (cfg->ext_svadu ? MENVCFG_ADUE : 0);
 
         if (env_archcpu(env)->cfg.ext_zicfilp) {
@@ -2708,7 +2982,8 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                     (cfg->ext_sstc ? MENVCFG_STCE : 0) |
-                    (cfg->ext_svadu ? MENVCFG_ADUE : 0);
+                    (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
+                    (cfg->ext_smcdeleg ? MENVCFG_CDE : 0);
     uint64_t valh = (uint64_t)val << 32;
 
     env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
@@ -5493,6 +5768,11 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
                         write_sstateen_1_3,
                         .min_priv_ver = PRIV_VERSION_1_12_0 },
 
+    /* Supervisor Counter Delegation */
+    [CSR_SCOUNTINHIBIT] = {"scountinhibit", scountinhibit_pred,
+                            read_scountinhibit, write_scountinhibit,
+                           .min_priv_ver = PRIV_VERSION_1_12_0 },
+
     /* Supervisor Trap Setup */
     [CSR_SSTATUS]    = { "sstatus",    smode, read_sstatus,    write_sstatus,
                          NULL,                read_sstatus_i128              },

-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3719827BF9
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 01:28:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMzxM-0001Wi-Vx; Mon, 08 Jan 2024 19:27:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rMzxI-0001Tf-S8
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 19:26:56 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rMzxF-0001bj-FV
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 19:26:56 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2045542eec3so424662fac.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 16:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704760012; x=1705364812;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Db9uecXqut1xHar9Jl0gk/7nQ58Xq7K8BAWHOme98A=;
 b=jxR/ZtVTQGE+A7C3CRzCvQQ9+PjAVYeRhtM7uzo9h6COJPABC3x7qTPVGOrMY9x3Nt
 n+8vAx5xMuoKYLDnHnC2bvpVbscp7gWTx3Hely0WvA4luXag+wuMjXWJ61m343km+pZY
 /v3K676ek0XIs3IzsMI69J+KA/ccicTacTfGWwx2JQSSa64cUngrZaKTvY/nobbXeeYr
 7ZWTfDG1qE0lPJ1mFWIq15Dq0IhHBit9v50mi8LLR+KruOai+rMhoaqKf0ekHC4+xOp2
 PgbWIRhDN2LwW0M+IX8OobjGIWzeOK3YAjf3x+//ihcnyG4VFK723y+3HSFNC0RGSIMv
 VFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704760012; x=1705364812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Db9uecXqut1xHar9Jl0gk/7nQ58Xq7K8BAWHOme98A=;
 b=iKmKCHEGOMB3GdULfmdLqGkhjWZfaDQ0oqs48Y3eJaJbdiRv+iKSf/gQIBTaoaVsf3
 Kt4Xe+B/viXx0lyDdMZRyDZSG0I6tA9SGnbYfBdG1QXUUrrzEMJTLV5pY5WmR0pKMNRE
 1tsnJecxPfKuJ4hif39bZYwPeKHQ7ZQjm6HoeCQZBUMBoPZh2qvU6Xu9iI7icj1kFEf9
 euPLj+i2hJ1W0Bvx13lAvzljV2zsNtpiI3w+4YR63P+xg7B4aly6GoZBLYnYMxItUtdt
 77uGkpctJFjStOTAx7+TmKGoTGQxA5p0MuULdR3IuuRI+Q2xMtzuo2KHZK/Khe+BuqLb
 oUmg==
X-Gm-Message-State: AOJu0Yy29bz62hFdNeh2CcwOHkGQroUhYezSebjw77ZQjAO9h+aluUVS
 pSfeejSF9ipX6dPQqrf2gb1rYU7Aq7REXg==
X-Google-Smtp-Source: AGHT+IEhlnGfOeQRhODwZwASo2+rr5PI2FcknttnFfEbc2Qqan6cxgjoSUq4D3E9b0vJGLz0bmRGyw==
X-Received: by 2002:a05:6870:32ce:b0:203:85cc:5da4 with SMTP id
 r14-20020a05687032ce00b0020385cc5da4mr2088343oac.88.1704760011938; 
 Mon, 08 Jan 2024 16:26:51 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 wp12-20020a056871a9cc00b002042cafdc52sm219917oab.2.2024.01.08.16.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 16:26:51 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: 
Cc: Kaiwen Xue <kaiwenx@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 kaiwenxue1@gmail.com
Subject: [PATCH v4 4/5] target/riscv: Add cycle & instret privilege mode
 filtering support
Date: Mon,  8 Jan 2024 16:25:53 -0800
Message-Id: <20240109002554.646572-5-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240109002554.646572-1-atishp@rivosinc.com>
References: <20240109002554.646572-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=atishp@rivosinc.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

QEMU only calculates dummy cycles and instructions, so there is no
actual means to stop the icount in QEMU. Hence this patch merely adds
the functionality of accessing the cfg registers, and cause no actual
effects on the counting of cycle and instret counters.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
---
 target/riscv/csr.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 283468bbc652..3bd4aa22374f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -233,6 +233,24 @@ static RISCVException sscofpmf_32(CPURISCVState *env, int csrno)
     return sscofpmf(env, csrno);
 }
 
+static RISCVException smcntrpmf(CPURISCVState *env, int csrno)
+{
+    if (!riscv_cpu_cfg(env)->ext_smcntrpmf) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException smcntrpmf_32(CPURISCVState *env, int csrno)
+{
+    if (riscv_cpu_mxl(env) != MXL_RV32) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return smcntrpmf(env, csrno);
+}
+
 static RISCVException any(CPURISCVState *env, int csrno)
 {
     return RISCV_EXCP_NONE;
@@ -818,6 +836,54 @@ static int read_hpmcounterh(CPURISCVState *env, int csrno, target_ulong *val)
 
 #else /* CONFIG_USER_ONLY */
 
+static int read_mcyclecfg(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mcyclecfg;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_mcyclecfg(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mcyclecfg = val;
+    return RISCV_EXCP_NONE;
+}
+
+static int read_mcyclecfgh(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mcyclecfgh;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_mcyclecfgh(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mcyclecfgh = val;
+    return RISCV_EXCP_NONE;
+}
+
+static int read_minstretcfg(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->minstretcfg;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_minstretcfg(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->minstretcfg = val;
+    return RISCV_EXCP_NONE;
+}
+
+static int read_minstretcfgh(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->minstretcfgh;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_minstretcfgh(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->minstretcfgh = val;
+    return RISCV_EXCP_NONE;
+}
+
 static int read_mhpmevent(CPURISCVState *env, int csrno, target_ulong *val)
 {
     int evt_index = csrno - CSR_MCOUNTINHIBIT;
@@ -4922,6 +4988,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
                              write_mcountinhibit,
                              .min_priv_ver = PRIV_VERSION_1_11_0       },
 
+    [CSR_MCYCLECFG]      = { "mcyclecfg",   smcntrpmf, read_mcyclecfg,
+                             write_mcyclecfg,
+                             .min_priv_ver = PRIV_VERSION_1_12_0       },
+    [CSR_MINSTRETCFG]    = { "minstretcfg", smcntrpmf, read_minstretcfg,
+                             write_minstretcfg,
+                             .min_priv_ver = PRIV_VERSION_1_12_0       },
+
     [CSR_MHPMEVENT3]     = { "mhpmevent3",     any,    read_mhpmevent,
                              write_mhpmevent                           },
     [CSR_MHPMEVENT4]     = { "mhpmevent4",     any,    read_mhpmevent,
@@ -4981,6 +5054,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MHPMEVENT31]    = { "mhpmevent31",    any,    read_mhpmevent,
                              write_mhpmevent                           },
 
+    [CSR_MCYCLECFGH]     = { "mcyclecfgh",   smcntrpmf_32, read_mcyclecfgh,
+                             write_mcyclecfgh,
+                             .min_priv_ver = PRIV_VERSION_1_12_0        },
+    [CSR_MINSTRETCFGH]   = { "minstretcfgh", smcntrpmf_32, read_minstretcfgh,
+                             write_minstretcfgh,
+                             .min_priv_ver = PRIV_VERSION_1_12_0        },
+
     [CSR_MHPMEVENT3H]    = { "mhpmevent3h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-- 
2.34.1



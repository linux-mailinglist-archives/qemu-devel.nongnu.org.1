Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F05758AD2
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 03:24:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLvuV-0004S0-QL; Tue, 18 Jul 2023 21:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kaiwenx@rivosinc.com>)
 id 1qLtV7-0003R9-R4
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 18:49:01 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kaiwenx@rivosinc.com>)
 id 1qLtUs-0004yz-DW
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 18:49:01 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-666ecf9a081so6258644b3a.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 15:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689720524; x=1692312524; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/5KRXSS3DUc7aMWMTPL8fRz80+vQ74aVXKA6ZvPBjS4=;
 b=fALrsQcNnnBKxMa4sbcYmfQd5zTE1NbL+z+UqQ5IJAo4KzrPcimSOuz/tP94VpOOY5
 hsoUqZCTHIzad8j4PcnAneX7EyXuJfxdrGoO+cA3n/rFLVgGdcyToHJwtDpRgcopARaR
 3fWmu/YpMJuF2lXaxe1zQvXIJWqzTlqKjwDVCds8K+N7JD8onveGD2B7rk6jGEkKBVW2
 otVQxZG/nFhp3BdFVNcvQn8B+u7TwJ1GhM2jBr/NjlCxIb6+Ys6p0jr/P1bs5yoGXeGE
 5/TN3eqXJ49P4X+Lw0jtfZEtA4hyWmpdXdP2dnKh2J/hhAfEfJGFrfCgIIHcco3qkko0
 u5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689720524; x=1692312524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/5KRXSS3DUc7aMWMTPL8fRz80+vQ74aVXKA6ZvPBjS4=;
 b=VoPkK0jJ3cSaCPpzYAgOM1FqnpWXnjlYciVH2z1lIXojz2EJCXaFhWPb3EsL6dgTB+
 hKbn/fNQ+HPFnyV0UQPVS6kBD0UeviWTDc3zuNffrBOLWlZx92om297HokJdLawJTdRy
 1gGv8d5GnRmFkYuiBSsNKLjEEHpyXiERLXamgAIm+OZe3c1rxut13Qa3bQxe8wA7msFZ
 1OzFbRaF1tDT5DLsmorX2VO2rCKmk4hzeA7xYK2VlPSAQgof1IDDZz9+E0fxKW8E3Y8Y
 oTUCNFRxutq2n6g4L/Tw5foHchPOeUF3A8WEW2V2EGseZpU4BE0VTjy2uBtyWd1ohJaq
 8Pxg==
X-Gm-Message-State: ABy/qLZAmgMLzMzMuIlDadCh9hgSG9Aa9xOJ+XO5ji0MvSLDr+pOCz1I
 JnXBIfiaCjBDMe5G82IExBadAg==
X-Google-Smtp-Source: APBJJlFI85vVQT7ZBtXatmEU3BItJ8q4D64KA1l423YRA3QoGbXKSlzUAHK7rlYUtaMs9k1xnHtZig==
X-Received: by 2002:a05:6a21:33a6:b0:12d:10b6:98f9 with SMTP id
 yy38-20020a056a2133a600b0012d10b698f9mr20088339pzb.56.1689720524305; 
 Tue, 18 Jul 2023 15:48:44 -0700 (PDT)
Received: from kaiwenx.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 i14-20020aa787ce000000b00682669dc19bsm1983312pfo.201.2023.07.18.15.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 15:48:44 -0700 (PDT)
From: Kaiwen Xue <kaiwenx@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kaiwen Xue <kaiwenx@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Atish Kumar Patra <atishp@atishpatra.org>,
 Kaiwen Xue <kaiwenx@andrew.cmu.edu>
Subject: [PATCH 3/3] target/riscv: Add cycle & instret privilege mode
 filtering support
Date: Tue, 18 Jul 2023 15:47:45 -0700
Message-ID: <3ed71e9812a806b98dd519594af52b9525ec459c.1689631639.git.kaiwenx@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689631639.git.kaiwenx@rivosinc.com>
References: <cover.1689631639.git.kaiwenx@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=kaiwenx@rivosinc.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 18 Jul 2023 21:23:14 -0400
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

QEMU only calculates dummy cycles and instructions, so there is no
actual means to stop the icount in QEMU. Hence this patch merely adds
the functionality of accessing the cfg registers, and cause no actual
effects on the counting of cycle and instret counters.

Signed-off-by: Kaiwen Xue <kaiwenx@andrew.cmu.edu>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
---
 target/riscv/csr.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ea7585329e..b1d5e85a79 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -218,6 +218,17 @@ static RISCVException sscofpmf(CPURISCVState *env, int csrno)
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException smcntrpmf(CPURISCVState *env, int csrno)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+
+    if (!cpu->cfg.ext_smcntrpmf) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException any(CPURISCVState *env, int csrno)
 {
     return RISCV_EXCP_NONE;
@@ -800,6 +811,54 @@ static int read_hpmcounterh(CPURISCVState *env, int csrno, target_ulong *val)
 
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
@@ -4506,6 +4565,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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
@@ -4565,6 +4631,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MHPMEVENT31]    = { "mhpmevent31",    any,    read_mhpmevent,
                              write_mhpmevent                           },
 
+    [CSR_MCYCLECFGH]     = { "mcyclecfgh",   smcntrpmf, read_mcyclecfgh,
+                             write_mcyclecfgh,
+                             .min_priv_ver = PRIV_VERSION_1_12_0        },
+    [CSR_MINSTRETCFGH]   = { "minstretcfgh", smcntrpmf, read_minstretcfgh,
+                             write_minstretcfgh,
+                             .min_priv_ver = PRIV_VERSION_1_12_0        },
+
     [CSR_MHPMEVENT3H]    = { "mhpmevent3h",    sscofpmf,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-- 
2.34.1



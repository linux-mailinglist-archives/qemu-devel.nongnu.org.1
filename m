Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D03281FC3D
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 01:48:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJ12N-0003Rs-VJ; Thu, 28 Dec 2023 19:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rJ12M-0003RM-Bu
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 19:47:42 -0500
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rJ12K-0002zZ-Hh
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 19:47:42 -0500
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-35fe9a6609eso43429115ab.2
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 16:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703810858; x=1704415658;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RMkfNrfu3BNKw2loqhAx42IyUfatsJHkamEf6PqwbN8=;
 b=U6uerYm9jUzsKRDU1J3w8riVnJsuiDpMss8P14eEZmunBIlZ3VsrA2g7kQeQHIrPGq
 C3gEH9LSDJwbCwvV/Z7okqtbQ5EAjklQiHxtF4llXQcY/HTBs5an/51cYf+afoBuMkzi
 VLYdx/3/EZTb9LnG44IS/sxYPHfJgxe59Nb3E3kfJF/7/jZb/7W9486h2A1UasdfX2n3
 3xKqOg7hulq9ELsC2Y/U87+N0xIDnpTYEJJKX5nyEfw/NWvF9Nos/bIr9KLuDOvz7Uyx
 Tr/nDVeKud7MzMeTM9IO9fBzM+pZdNIeez/xuQm1jeSYi3JY6cz9wUrDBfCqfMxKnlv4
 jkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703810858; x=1704415658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RMkfNrfu3BNKw2loqhAx42IyUfatsJHkamEf6PqwbN8=;
 b=aXlL155MVnEN3x5qV9Y3jt05/OuPCJbMY39FwUmAocdVLHLBkpEcx+plrZP7f6LUWM
 jytNxv9FP0Bm2KWvdhJgNzot+ZzzPQWieJLarN99XcTBgOQZ1mskohpwqvAjwTMkAfy4
 wrch1BPKXQPrJxQ/x5IuyMLMoffiV1ICxKxmNM7kSwjGyIfPYZXgz1ln+NaTXJg9tl64
 id9qTFuqUVIgiEf+597TCozkjvP4VbR9T6xbjL5e/bPEhyAS1hLAGx0C11z8FOojluP5
 80b+XapNJ9f45ORtwhQz0PhsuXQa4XuhXkLOCwYMf2u0s+wDveriuoKwJ7jfKvGQXIlU
 5hqw==
X-Gm-Message-State: AOJu0YxA9YD+5ilkXgMfQmGRnQKeENagHvNEqwPtmjiHW1L/pKt2zPJz
 RegSQIrsFBM7AOoma2Z4vdQPZ7YabDgfyrVap5aAh3GtNU8=
X-Google-Smtp-Source: AGHT+IF60Kep03IMceK5E6GmPRnrkUbQ/IfjVTwBk0h1H8MmGRpWCBwrRQPmCV6ReOqHZ8DvWNeMBQ==
X-Received: by 2002:a05:6e02:1446:b0:360:c7:72a4 with SMTP id
 p6-20020a056e02144600b0036000c772a4mr9977070ilo.72.1703810858618; 
 Thu, 28 Dec 2023 16:47:38 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 z3-20020a170902ee0300b001d3561680aasm14393949plb.82.2023.12.28.16.47.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 16:47:38 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: qemu-devel@nongnu.org
Subject: [v2 4/5] target/riscv: Add cycle & instret privilege mode filtering
 support
Date: Thu, 28 Dec 2023 16:47:30 -0800
Message-Id: <20231229004731.3841550-5-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229004731.3841550-1-atishp@rivosinc.com>
References: <20231229004731.3841550-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=atishp@rivosinc.com; helo=mail-il1-x12e.google.com
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
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
---
 target/riscv/cpu.c |  1 +
 target/riscv/csr.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 54395f95b299..d24f7ff8b55b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1297,6 +1297,7 @@ const char *riscv_get_misa_ext_description(uint32_t bit)
 const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
+    MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 283468bbc652..618e801a7612 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -233,6 +233,27 @@ static RISCVException sscofpmf_32(CPURISCVState *env, int csrno)
     return sscofpmf(env, csrno);
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
+static RISCVException smcntrpmf_32(CPURISCVState *env, int csrno)
+{
+    if (riscv_cpu_mxl(env) != MXL_RV32) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return smcntrpmf(env, csrno);
+}
+
+
 static RISCVException any(CPURISCVState *env, int csrno)
 {
     return RISCV_EXCP_NONE;
@@ -818,6 +839,54 @@ static int read_hpmcounterh(CPURISCVState *env, int csrno, target_ulong *val)
 
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
@@ -4922,6 +4991,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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
@@ -4981,6 +5057,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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



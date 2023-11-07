Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 226B27E32F3
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:32:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0BsC-0003uI-9B; Mon, 06 Nov 2023 21:31:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BsA-0003nb-Aa
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:22 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bs8-0002s5-Kc
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:22 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6b5cac99cfdso4251524b3a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324278; x=1699929078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ws4oYNOD7hDMtrTyE3v76h4KxrvpnTS/DHBvUoc8dQc=;
 b=iW5D926+rh+Jw9zm09lYCX05Wq2u752ALXSuTsvOkn6N0pwuK1KI0fs7PgCHH4JbxT
 9xHpc6nnnWRT7QRXKRs3biaQc9/rZQi8S8mX79KSfRCySWuaD9M3uQXfLM9F4YK8IVrE
 9U1leGuSLBjRLqHZyAj+KDiLHrA8n2e6KcgCPFkHmw1i4hHJR2cdpwQCatNFXp+YEt23
 jz9ciUQyot4Mkwa1QISC/aoZy6DIQaEnr2ZqxV0iUDghBrPKMsfxFUMzOHyckNCnILLa
 gyJsAGzYw8QXZf8F9ox81YlqIzG3rgkVmi3jl8qCqJzoIZtlUirh1lON0RqZTGtr7pzq
 bqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324278; x=1699929078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ws4oYNOD7hDMtrTyE3v76h4KxrvpnTS/DHBvUoc8dQc=;
 b=oqWxybc/tKOMo0IO21xo91E2KYEooHcfyei1Mwx0GuVqL7oYbZSIEDwchOqv6HdN5V
 OMPKGa2RH4ezTgRKaCmo8rhW9KEhuFfAJFQWLs2cmtkHU0k5hIVJzGXuOo8CruYXn5z+
 xvoOVQoTxNcAxdYABC6DZXQx6b2QAqA6vuqDnm6eULCdHy5Exb0q5ZyDd2fo1yXPqunT
 JYYdio5sWBLhfNYFIgYrmz0rnKfu8JcJ3I/u8EYNC6WjimgEWW3u1x8fpVB1U+IUWBr6
 hY+MC/GbMxYNQQTGL+V+wX0KbVj6OTRktvtqvgA1ZXHKUd4+zyxNwb3Jv/pVry5bAbiF
 9B1w==
X-Gm-Message-State: AOJu0YwtDliUqMkajubZTeu+dmItNzDtXc/CHJJr9rzzqkDo54sKB/py
 W2r6hj6D7+lhPYmG4YLkYo0QLvlf9JRNsw==
X-Google-Smtp-Source: AGHT+IFGpXEt1kaoXUp+/oQyqbaUHjdhj2EBOV/V4ER5KZ4CsXYsnm72CNNfDq9ISKCXnAYLVkcLqg==
X-Received: by 2002:a05:6a20:3d85:b0:181:78ef:dc90 with SMTP id
 s5-20020a056a203d8500b0018178efdc90mr14289651pzi.13.1699324278593; 
 Mon, 06 Nov 2023 18:31:18 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:31:17 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/49] target/riscv: add zihpm extension flag for TCG
Date: Tue,  7 Nov 2023 12:29:20 +1000
Message-ID: <20231107022946.1055027-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

zihpm is the Hardware Performance Counters extension described in
chapter 12 of the unprivileged spec. It describes support for 29
unprivileged performance counters, hpmcounter3-hpmcounter31.

As with zicntr, QEMU already implements zihpm before it was even an
extension. zihpm is also part of the RVA22 profile, so add it to QEMU
to complement the future profile implementation. Default it to 'true'
for all existing CPUs since it was always present in the code.

As for disabling it, there is already code in place in
target/riscv/csr.c in all predicates for these counters (ctr() and
mctr()) that disables them if cpu->cfg.pmu_num is zero. Thus, setting
cpu->cfg.pmu_num to zero if 'zihpm=false' is enough to disable the
extension.

Set cpu->pmu_avail_ctrs mask to zero as well since this is also checked
to verify if the counters exist.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231023153927.435083-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/cpu.c         |  3 +++
 target/riscv/tcg/tcg-cpu.c | 13 +++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 73fd4b3231..6eef4a51ea 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -69,6 +69,7 @@ struct RISCVCPUConfig {
     bool ext_zicond;
     bool ext_zihintntl;
     bool ext_zihintpause;
+    bool ext_zihpm;
     bool ext_smstateen;
     bool ext_sstc;
     bool ext_svadu;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 69d64ec4ca..f40da4c661 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -85,6 +85,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zifencei, PRIV_VERSION_1_10_0, ext_zifencei),
     ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
+    ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
     ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
@@ -1218,6 +1219,7 @@ static void riscv_cpu_init(Object *obj)
      * users disable them.
      */
     RISCV_CPU(obj)->cfg.ext_zicntr = true;
+    RISCV_CPU(obj)->cfg.ext_zihpm = true;
 }
 
 typedef struct misa_ext_info {
@@ -1308,6 +1310,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
 
     MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
+    MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
 
     MULTI_EXT_CFG_BOOL("zba", ext_zba, true),
     MULTI_EXT_CFG_BOOL("zbb", ext_zbb, true),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index a1e4ed2e24..093bda2e75 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -549,6 +549,19 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu->cfg.ext_zicntr = false;
     }
 
+    if (cpu->cfg.ext_zihpm && !cpu->cfg.ext_zicsr) {
+        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zihpm))) {
+            error_setg(errp, "zihpm requires zicsr");
+            return;
+        }
+        cpu->cfg.ext_zihpm = false;
+    }
+
+    if (!cpu->cfg.ext_zihpm) {
+        cpu->cfg.pmu_num = 0;
+        cpu->pmu_avail_ctrs = 0;
+    }
+
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
-- 
2.41.0



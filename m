Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A242A8FE82C
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jun 2024 15:51:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFDV8-0000qE-BQ; Thu, 06 Jun 2024 09:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sFDV6-0000pA-Ox
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 09:49:56 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sFDV4-0008UH-Ez
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 09:49:56 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7023b6d810bso811942b3a.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 06:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717681793; x=1718286593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cEG1fPkJ+g/jXimIp5Gy6n7CLs83yHdB825jkzDzPOg=;
 b=ahTAZAZ8Vsy1cibU2EqGF9r9grVd1frTGBu2oHtowTum6mjrBpkRs/6FbzgjQQ4DiF
 jFSfF0I3aufsEVE3V/+bvtnzTi5rQkArWezH8SXMot0tTYVtjGD8pQPRD51zkW3hfs3K
 TAHqlQZBH0PGsVF8X867P4y1nGCvZhq7KsRhA+sKCbp2XtHmrsJ20LNq3edBRR37+djp
 vGNtimVtfF9jELL12xBvR6ztTVJM3MSVkja+/PV7V/OQS+y73jHfkr+AWJI6DwxfRKur
 R174Ov6DFYDGqcG2bflexDOGTkJgtd0CLzKLP+0b7IIrXDuqaxk5NXTQ5wWNlPwvRAH9
 MG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717681793; x=1718286593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cEG1fPkJ+g/jXimIp5Gy6n7CLs83yHdB825jkzDzPOg=;
 b=ptIIquJknF+mj6uvfGyZ+714eY/doe2KEHDIAcMdjg66uhsaXeJ2+HnqKKE2aM3rh6
 oeFNUGPr9AWGfjAJEQtCl3SU5DWZYRikKFDwzopiYo0VUUk+ZY8wcEGOGOq1D2WnMLOu
 kfL8Xc23NECXHkzFZAaCYN6OMMp7FJbldT23JwP9gecxSyIPHpBFwVp8aTm8P5RG/1+b
 JZ2SKGv0fYuELTfE5mr+kRknhj8lQv37OhFxjlsGIRib/riZzVptqIWeTwpVnyO0fZnS
 gePs5X1w9M1mtOgrMM7bFuWoaAlL46UeygtwIUoIOP2JSLK5iPqhJifRVLHlY+QLv91w
 4PjQ==
X-Gm-Message-State: AOJu0Yz0yfpDpzZWiwD7l01SvAdQYMUxyChn6x0W3g2t/DQMJYiqV1/u
 c52cWhqkSPhwGc4z5w/0p0d2/nsfo9pTHT9+26RvNLhrNPZUDof4gesl1V+cHY9/bPTN559pghv
 6GyomntdI5StG18WnAM61Q4otSOxpM26Js/EkFp9j0uabPINexffKJPJRz7N6PuPK5KLhW6FJVG
 RmqAmh2hlr5Y2Kv2tvs9yKcBL40/pQcyPvYrs=
X-Google-Smtp-Source: AGHT+IHdKISYxbIDFt7eqi9B3TUfLTHowMV9NWWnXgAGoNuJH6r/6Pn0q/CLElQptWDdrCUqcIbEcQ==
X-Received: by 2002:a05:6a20:8423:b0:1a9:d9bb:acdc with SMTP id
 adf61e73a8af0-1b2b6ff70bfmr6534936637.28.1717681792576; 
 Thu, 06 Jun 2024 06:49:52 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703fd50bc86sm1150919b3a.175.2024.06.06.06.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 06:49:52 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v4 4/6] target/riscv: Add MEDELEGH, HEDELEGH csrs for RV32
Date: Thu,  6 Jun 2024 21:54:52 +0800
Message-Id: <20240606135454.119186-5-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606135454.119186-1-fea.wang@sifive.com>
References: <20240606135454.119186-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=fea.wang@sifive.com; helo=mail-pf1-x429.google.com
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

Based on privileged spec 1.13, the RV32 needs to implement MEDELEGH
and HEDELEGH for exception codes 32-47 for reserving and exception codes
48-63 for custom use. Add the CSR number though the implementation is
just reading zero and writing ignore. Besides, for accessing HEDELEGH, it
should be controlled by mstateen0 'P1P13' bit.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h |  2 ++
 target/riscv/csr.c      | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index c895aa0334..096a51b331 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -156,6 +156,8 @@
 
 /* 32-bit only */
 #define CSR_MSTATUSH        0x310
+#define CSR_MEDELEGH        0x312
+#define CSR_HEDELEGH        0x612
 
 /* Machine Trap Handling */
 #define CSR_MSCRATCH        0x340
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a19e1afa1f..6f15612e76 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3229,6 +3229,33 @@ static RISCVException write_hedeleg(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException read_hedelegh(CPURISCVState *env, int csrno,
+                                   target_ulong *val)
+{
+    RISCVException ret;
+    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_P1P13);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    /* Reserved, now read zero */
+    *val = 0;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_hedelegh(CPURISCVState *env, int csrno,
+                                    target_ulong val)
+{
+    RISCVException ret;
+    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_P1P13);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    /* Reserved, now write ignore */
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException rmw_hvien64(CPURISCVState *env, int csrno,
                                     uint64_t *ret_val,
                                     uint64_t new_val, uint64_t wr_mask)
@@ -4633,6 +4660,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
 
     [CSR_MSTATUSH]    = { "mstatush",   any32, read_mstatush,
                           write_mstatush                                   },
+    [CSR_MEDELEGH]    = { "medelegh",   any32, read_zero, write_ignore,
+                          .min_priv_ver = PRIV_VERSION_1_13_0              },
+    [CSR_HEDELEGH]    = { "hedelegh",   hmode32, read_hedelegh, write_hedelegh,
+                          .min_priv_ver = PRIV_VERSION_1_13_0              },
 
     /* Machine Trap Handling */
     [CSR_MSCRATCH] = { "mscratch", any,  read_mscratch, write_mscratch,
-- 
2.34.1



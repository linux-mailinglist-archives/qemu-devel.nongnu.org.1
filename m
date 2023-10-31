Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C687DD0BC
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:41:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxqr7-0002V2-3K; Tue, 31 Oct 2023 11:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qxqr1-0002PD-HZ
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:40:31 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qxqqx-0003hr-SA
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:40:31 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4083dbc43cfso38357835e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698766816; x=1699371616;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vh+QEBCjkyXH9IgFpqikPF3gTU5EDn0tlkDzD7Euts4=;
 b=aMUFt+Ykz44yM1R8dx79EQFMKAXCGioGqTjtGI3uwgp0hrt5pmXXpEgsFOAt/SSeyc
 ynMRAoWJ+Weatcqob2sTP4lgYn7/P5hUMWrPrE94Uiz4iVt3C1ELUgH6WmM0oXf8GPqI
 0lw6TVik0Y0oYPuJFf6BcFptMWcFiqOwCKRTOhY13NG/4oXPDkLjbrIOCMHNBgjFiX+I
 j5Gg08WleAeIwXUBfucSveqPcoJY/lCDSXyYP3Wf8AQRXFp6SPI+Otn4vXN0i7ZRMtjL
 Uq41G/aFioR+0DMPwUKfeqF+c4L9Oeey1cXQYnFliUyyuQwILdKuBblJsL+/jWFTGXvY
 TIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698766816; x=1699371616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vh+QEBCjkyXH9IgFpqikPF3gTU5EDn0tlkDzD7Euts4=;
 b=H9nHIcx/K5goKRMyVTI5ENi1b+SpUP9c56mU9aXhXDDtz4VNKDh72vq5PMoNF9+XJE
 UqdeoDft4fMIJQ4R/wFt8s204cWOjv1GCE2rRnJ/NkRtKSJmqy6BNUqskrJDinj7OWpV
 MpXchSKKiG5uDutOmo1oTuzDLhH8P9Ej3Z8Gqy3BSTvy2kDRohzvWa8OwVki/h+3tBZM
 ynwHMbSG8Y+in/2lOrilPUx1Iq0NRlcLXEzPtHYmzknCW2HexB4KMEs5sxREnaM3aomn
 1u2d/NpfOche7UprklR7a7KlpK0blcvk/yd3t7sIBP1Mu6Pfn0L5lYdBjtUyi0RfRmui
 D2ug==
X-Gm-Message-State: AOJu0Yz7y57uPvHl88PC4kcK+MyyUzosOZl68C/avq1vIh1XQ5ktIZLE
 eB5j59d8PqM29Hwlf2RqkVQ3vjeveIlsQK5fVKTgvw==
X-Google-Smtp-Source: AGHT+IGCaH9KKwLZHtoZs8eYO4DkqjA1yaBwdJCKCvhEw7MCzEMFMI8yh0Pie/RFO4EGoPebjOiHrQ==
X-Received: by 2002:a05:600c:acc:b0:401:bdd7:49ae with SMTP id
 c12-20020a05600c0acc00b00401bdd749aemr11430470wmr.18.1698766815824; 
 Tue, 31 Oct 2023 08:40:15 -0700 (PDT)
Received: from rockhopper.. (214.11.169.217.in-addr.arpa. [217.169.11.214])
 by smtp.gmail.com with ESMTPSA id
 r12-20020a05600c458c00b003fbe4cecc3bsm2094613wmo.16.2023.10.31.08.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 08:40:15 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>, Weiwei Li <liweiwei@iscas.ac.cn>
Subject: [PATCH v5 2/5] target/riscv: Don't assume PMU counters are continuous
Date: Tue, 31 Oct 2023 15:37:14 +0000
Message-ID: <20231031154000.18134-3-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031154000.18134-1-rbradford@rivosinc.com>
References: <20231031154000.18134-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=rbradford@rivosinc.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

Check the PMU available bitmask when checking if a counter is valid
rather than comparing the index against the number of PMUs.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/csr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 4b4ab56c40..a6ea38e0ba 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -183,7 +183,8 @@ static RISCVException zcmt(CPURISCVState *env, int csrno)
 #if !defined(CONFIG_USER_ONLY)
 static RISCVException mctr(CPURISCVState *env, int csrno)
 {
-    int pmu_num = riscv_cpu_cfg(env)->pmu_num;
+    RISCVCPU *cpu = env_archcpu(env);
+    uint32_t pmu_avail_ctrs = cpu->pmu_avail_ctrs;
     int ctr_index;
     int base_csrno = CSR_MHPMCOUNTER3;
 
@@ -192,7 +193,7 @@ static RISCVException mctr(CPURISCVState *env, int csrno)
         base_csrno += 0x80;
     }
     ctr_index = csrno - base_csrno;
-    if (!pmu_num || ctr_index >= pmu_num) {
+    if ((BIT(ctr_index) & pmu_avail_ctrs >> 3) == 0) {
         /* The PMU is not enabled or counter is out of range */
         return RISCV_EXCP_ILLEGAL_INST;
     }
-- 
2.41.0



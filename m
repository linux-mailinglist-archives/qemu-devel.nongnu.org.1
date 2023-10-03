Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 218097B6976
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:53:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnesK-0007fi-OL; Tue, 03 Oct 2023 08:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qnesI-0007ej-Ns
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:51:42 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qnesF-00049k-Lv
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:51:42 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4066241289bso8604615e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 05:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696337497; x=1696942297;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sxGT1Wl6J3xowqZP+oPYuTY8pg3VyoUcjhFPxfi6Z1A=;
 b=U22Eg+HK4m9Z2VsLfPNSNKLmKRp815/qG/que8XxdgAbrHkquZf9jSkgNaJLAPgvhu
 5bHG7zmvpQWog6bqfgqHasIKEDOeCLHdnqO4R8SG0vWYjvmMVOhb4RFVZqHzXbLx59NP
 Lfxr5QAfcFlOv9JRAS1vOjXilyBhZEu/Djsn2vC3KufGn/34KFqLRO4OE1mLixglaWDF
 MD0ba8hpetZMqdeyyx7JKku+HtDCBI+TdA6fzePqFImuddExLu9gn2XsH0ZYsbdtQZYJ
 o2w6ZZ+oZ/NvMqmxmv9elyffKDaLtGK2J7SQfS8GZKaaKibZIkXkvjjkRsXBxHTGEhjl
 XImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696337497; x=1696942297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sxGT1Wl6J3xowqZP+oPYuTY8pg3VyoUcjhFPxfi6Z1A=;
 b=ATDCAH0wxu/xWUbKy50OpnLIgD2D3dvziNydA/dYsBsoupUtvcHNRmehU1sFIr4h+8
 qRo67Li8bzyVtwvGr6iKky8LZC15eiMo3grY89TbA0EvMh/o0dvTXEO/gRCcY1Tw9ypX
 Hw3rYE1rL+ZA6/sJLwMU1TkbraNkDMiJ7YzF3duXf7eLc5daxmPcs1usHEPStA0zm2hA
 w0KxNuHq1MN8eYfjzqqSu6MhS5jlx5SjNyT9GyM/xx1JtW2kx7w25p9YlEC3yzV+MV84
 k7cWNTjOSJF3P+XXin7p7pa6cjtJt7vjaiF/eniANBZSZ3ZeQNACStyNpuPryxO7dCc+
 LEVA==
X-Gm-Message-State: AOJu0Yz6g0ZbsKhTjrunqzkjB07YyXwvnr5omIQE316j4Ch4jyftM0av
 ueCO4lUx+GaCiNZFkaezDB3thvKF0MlLtJPtvvu/sQ==
X-Google-Smtp-Source: AGHT+IFIQzKQOxT7BKOJyykQ09+ozYYXUA4EYFSwLz3/m2DmpqcQrF14+nBe+omb9QdgExVQH1DfAQ==
X-Received: by 2002:a7b:cbc9:0:b0:406:3f62:e591 with SMTP id
 n9-20020a7bcbc9000000b004063f62e591mr12315479wmi.41.1696337497593; 
 Tue, 03 Oct 2023 05:51:37 -0700 (PDT)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 l21-20020a7bc455000000b0040531f5c51asm1240335wmi.5.2023.10.03.05.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 05:51:37 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH 3/3] target/riscv: Don't assume PMU counters are continuous
Date: Tue,  3 Oct 2023 13:49:37 +0100
Message-ID: <20231003125107.34859-4-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003125107.34859-1-rbradford@rivosinc.com>
References: <20231003125107.34859-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=rbradford@rivosinc.com; helo=mail-wm1-x334.google.com
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

Check the PMU available bitmask when checking if a counter is valid
rather than comparing the index against the number of PMUs.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
---
 target/riscv/csr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 85a31dc420..3e126219ba 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -182,7 +182,8 @@ static RISCVException zcmt(CPURISCVState *env, int csrno)
 #if !defined(CONFIG_USER_ONLY)
 static RISCVException mctr(CPURISCVState *env, int csrno)
 {
-    int pmu_num = riscv_cpu_cfg(env)->pmu_num;
+    RISCVCPU *cpu = RISCV_CPU(env_cpu(env));
+    uint32_t pmu_avail_ctrs = cpu->pmu_avail_ctrs;
     int ctr_index;
     int base_csrno = CSR_MHPMCOUNTER3;
 
@@ -191,7 +192,7 @@ static RISCVException mctr(CPURISCVState *env, int csrno)
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



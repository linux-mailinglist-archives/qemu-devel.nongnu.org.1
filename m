Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC187C5764
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:51:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaYD-0000Cz-M9; Wed, 11 Oct 2023 10:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qqaY9-0008S7-4M
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:51:01 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qqaY7-0000V7-Gv
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:51:00 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40566f89f6eso70913365e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697035857; x=1697640657;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sxGT1Wl6J3xowqZP+oPYuTY8pg3VyoUcjhFPxfi6Z1A=;
 b=AmzmyBk/4qj1oq+z0zWK2OJ724Dot1kVhSnkvSSejZhxMNBB/NqQm80dA+X1ka2ANF
 SjK1ETxg12OErS+Nqd3U+5SdCKQQvhOIFerWqTlV7U2yxv58GpLBin4zYQjKq9SoL0lp
 aFZf8lffxGg3NIt+72kTbmFTxr4v1sG6IjSCXtW39i44+d0vmEeMRRURaWdwi++O/X1N
 xwmxaabJy45OavMkHiyHlm9hacQgv1DPSB7TsdoJOeB/DL/8/pOotw6AChW3C8mkH/n0
 uvzqnZKoHeYTWQS5gsVrKkZkC5I5PnE10SU5u48V05UdJRHqCEEyB98MV1UpJBOQNrZb
 3o3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697035857; x=1697640657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sxGT1Wl6J3xowqZP+oPYuTY8pg3VyoUcjhFPxfi6Z1A=;
 b=UzZSMdjDPPQPumfmYfR+CKCBOW+w71o7buzPqIezcmfLwaQN3Y7zi3G52CFgKN0N9w
 Uum6uxJZCDk6wAB7gYM2DwpA2xAtJxT6ftfhbHP9KM5xj+9gfMgTANglvMQha5jgr8MX
 8qHeoLRvWppHSus4Fz7DfYShHWq2t6djskn/nq0961tUq5pwzUd+0d8oK/ym4Tx+SWOQ
 VoLlIff2H4hUJD+0iS34/htWywsQQGWK8zNhNg4/1kxLPHQ4nyoqeVacYaPkfqUt8qA5
 CcvN0R/+oZkx+pBOig3tT7qrNMLmQqYIOXVJ2Pv8u1M+FLeplCgSCsckLN3tHzOtiwEU
 LKmw==
X-Gm-Message-State: AOJu0YxZDtzANJiBHr1Rr7WaE9SQ9ilA7fKmniGzKvQKu/kWw0b6LsEn
 8hrvTgrOCrRXB2mTgMMQ0MQDHyv+S5YGabn+gGCCoA==
X-Google-Smtp-Source: AGHT+IH2K9/khvdw8Eg8/MLpYQz5ObAzHtknnFzm1LzmCutq9Lpybu/IXHGtFcNIKfCTEgD8W8T71Q==
X-Received: by 2002:a05:600c:3799:b0:402:e68f:888e with SMTP id
 o25-20020a05600c379900b00402e68f888emr19929702wmr.4.1697035857353; 
 Wed, 11 Oct 2023 07:50:57 -0700 (PDT)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 n16-20020a05600c3b9000b0040684abb623sm19709208wms.24.2023.10.11.07.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:50:57 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH v2 2/6] target/riscv: Don't assume PMU counters are continuous
Date: Wed, 11 Oct 2023 15:45:50 +0100
Message-ID: <20231011145032.81509-3-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011145032.81509-1-rbradford@rivosinc.com>
References: <20231011145032.81509-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=rbradford@rivosinc.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9887CE184
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:46:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8j2-0001Yz-NT; Wed, 18 Oct 2023 11:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qt8j0-0001Xt-Cd
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:44:46 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qt8iy-0004wL-Da
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:44:46 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40839807e82so7549945e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697643883; x=1698248683;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hy67743SOTB6vmc2gQJUpfeM8wwdmqA5BXHH8tQxkYo=;
 b=BSrfF4+HtDhrXUCW/1F10szZ0wZj5d+P1xXzSrN5Buuz4dbut3AyhE4VxVjaJPgiBa
 25ntay0GuO39JrUD2gf4lLwgml9GbN8H27beeTDJxqAm8aBAWWwGYLcTPz2z8K8tEWDj
 Yjxy8sV8p43XsgaGKCl/c4HoPjPQrpoorE3iOQp4XV9W7ybYBPVo9t6zoDxUiDm4SZP2
 FN33IoVNO3sgUuts81O2MCK/cxVh6p/te7FWtTw8m0KcxdTGCCI6uJZtwGMBZlZuMMOp
 gUWFC63aL08DgtqepcvYKVg+NTvn9UkLMs5iPdemg7cI+WCY6+095upLpKa2ocPKq1Xv
 9BCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697643883; x=1698248683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hy67743SOTB6vmc2gQJUpfeM8wwdmqA5BXHH8tQxkYo=;
 b=op7zhghKt6iGLHFUf0oCjBEFoiJykqq6qdnTqD2yrxYD4u66iIsUeqfazY1hkKIuE9
 I1mFu0LZ1cWM+U9Ny7OzU/yaH17h7gFc5TQHoEV9WiJKg44bZ/ThfmNQE9rjkQ2wdfNO
 VrTDnAS0UYC6x/3COzFojhMpZ02aLgGYCwLIR1AXBvgvFn+D57EP+GtlmHq/mRsvwNl4
 BTMEwjoaO9a2cPjoeg0YfFazUsWNKFyHe0iEahoCCiCvqHqiFl/KaA4+yhPc5KdPXWqt
 JX9gqKdSjwcCm38gQf+GS3JD4Ulp7ImIudpjVt1RIQ48O5OQyBcYdhPZoTaDVmMO8gej
 BtYg==
X-Gm-Message-State: AOJu0YwydNNAVNK90NRwOYTdrw4dmexLMN4PaTIimOpqzV5s8pXr5O9w
 BVMCeA9OS2BQFCwuNA9Qbhv8z3r8viiDceacHd7suw==
X-Google-Smtp-Source: AGHT+IGugm27JyfK66rf94jZjaGXlC7jgkzURMXA+CP+g4YFw7U4SSP2rC3TvhPQwui9pfFeSkOGdQ==
X-Received: by 2002:a05:600c:a47:b0:401:b92f:eec5 with SMTP id
 c7-20020a05600c0a4700b00401b92feec5mr5116877wmq.9.1697643882925; 
 Wed, 18 Oct 2023 08:44:42 -0700 (PDT)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 b14-20020a05600c4e0e00b0040607da271asm1963580wmq.31.2023.10.18.08.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:44:42 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH v4 2/6] target/riscv: Don't assume PMU counters are continuous
Date: Wed, 18 Oct 2023 16:39:10 +0100
Message-ID: <20231018154434.17367-3-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018154434.17367-1-rbradford@rivosinc.com>
References: <20231018154434.17367-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=rbradford@rivosinc.com; helo=mail-wm1-x336.google.com
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
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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



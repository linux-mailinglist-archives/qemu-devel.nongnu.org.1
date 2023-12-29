Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C45C81FC45
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 01:50:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJ14Q-00076C-Hs; Thu, 28 Dec 2023 19:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rJ14L-00074w-RS
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 19:49:46 -0500
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rJ14K-0003Yi-4m
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 19:49:45 -0500
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2045bedb806so4080210fac.3
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 16:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703810982; x=1704415782;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KT0dgX+fbfi05uQpO/YMpPX7vZZAzvk8bOn5ql7e53k=;
 b=BeKO9ybVjI3l6LyD2DiLSbIL+D3suc+kOooLMHNFkZNn+yTzxioJ/+rl6Vtb9LKAyP
 tvvrhbQtyCs4tOc/2xtJCLnGy/7oDNdPJPRIJMNfe1VPabji9whItjuMavfVY7c6RDRL
 wqOVKiJVkZWfe7u/QlPpmf8xBeZ5QYSCNpowr/hi4sCX35BGsnyVZL/Ks7bbs0sujl65
 0LbO7SNnlVZLR52KqNZOgJ/MqSzhmCqQ9yi9i3CvZoEDEnIcvdYOXwjLDTnOOj0BiwE9
 SwyQUXkv5fQeROSJcORtY4sM5hDSqWqnHc5wCjORGrZvXJZw/PRcJjkAZUh0yVeGy1VD
 M82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703810982; x=1704415782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KT0dgX+fbfi05uQpO/YMpPX7vZZAzvk8bOn5ql7e53k=;
 b=fNzkMYHVBh02Mapl2ovN5SkqFe1d6aff/j9h8XuXcmRSzs/GXxGgs5ZkGUnI6+77PH
 WzApVSvJNeFQnuth5JSEYv3EXMfn5O44jGlHvdpTdq8FVrDIF3rIRxMuQEiE3mqRXsAT
 8WUiQ5n3viCAHmUrPrAoU9CxMcrOF5I1e3FSJwiv/LxMPI6BQVmSM7XovI7lWdBd94+D
 hFJGgjVGMskx+BepkYjKOpINlPcfHUJUIaxYCjH3+1WxIRCxDg5bf9wkbRWJMYXjRPiJ
 pZxJzyPEreg5dAJt2kelLybkU/PrxeXf8oRu8n3DdHIX9+lHhUbhHxBvKE7iWL2scqiy
 DkQQ==
X-Gm-Message-State: AOJu0Yzkf4iDm+SBui4CRov27My8t+yWmjSACQLYLopp/LftrTlvVZKR
 XGJaoLo5nkxy0elD6zPs7tO/KCvcKoU3OOw75clSH1BDh94=
X-Google-Smtp-Source: AGHT+IGuJBgIb+xz0IuSlCHEXrPH9cKohwEw83Nglfm6DcxukFAULjuQTxBfIOpmbZDfw9rgq9M78Q==
X-Received: by 2002:a05:6870:1683:b0:204:2721:7dd4 with SMTP id
 j3-20020a056870168300b0020427217dd4mr14028941oae.108.1703810982062; 
 Thu, 28 Dec 2023 16:49:42 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 ms25-20020a0568706b9900b0020463640518sm2636007oab.14.2023.12.28.16.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 16:49:41 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
Subject: [v2 3/5] target/riscv: Add cycle & instret privilege mode filtering
 definitions
Date: Thu, 28 Dec 2023 16:49:27 -0800
Message-Id: <20231229004929.3842055-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229004929.3842055-1-atishp@rivosinc.com>
References: <20231229004929.3842055-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=atishp@rivosinc.com; helo=mail-oa1-x32.google.com
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds the definitions for ISA extension smcntrpmf.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.c      |  1 -
 target/riscv/cpu.h      |  6 ++++++
 target/riscv/cpu_bits.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index da3f05cd5373..54395f95b299 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1297,7 +1297,6 @@ const char *riscv_get_misa_ext_description(uint32_t bit)
 const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
-    DEFINE_PROP_BOOL("smcntrpmf", RISCVCPU, cfg.ext_smcntrpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d74b361be641..34617c4c4bab 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -319,6 +319,12 @@ struct CPUArchState {
 
     target_ulong mcountinhibit;
 
+    /* PMU cycle & instret privilege mode filtering */
+    target_ulong mcyclecfg;
+    target_ulong mcyclecfgh;
+    target_ulong minstretcfg;
+    target_ulong minstretcfgh;
+
     /* PMU counter state */
     PMUCTRState pmu_ctrs[RV_MAX_MHPMCOUNTERS];
 
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index ebd7917d490a..0ee91e502e8f 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -401,6 +401,10 @@
 /* Machine counter-inhibit register */
 #define CSR_MCOUNTINHIBIT   0x320
 
+/* Machine counter configuration registers */
+#define CSR_MCYCLECFG       0x321
+#define CSR_MINSTRETCFG     0x322
+
 #define CSR_MHPMEVENT3      0x323
 #define CSR_MHPMEVENT4      0x324
 #define CSR_MHPMEVENT5      0x325
@@ -431,6 +435,9 @@
 #define CSR_MHPMEVENT30     0x33e
 #define CSR_MHPMEVENT31     0x33f
 
+#define CSR_MCYCLECFGH      0x721
+#define CSR_MINSTRETCFGH    0x722
+
 #define CSR_MHPMEVENT3H     0x723
 #define CSR_MHPMEVENT4H     0x724
 #define CSR_MHPMEVENT5H     0x725
@@ -885,6 +892,28 @@ typedef enum RISCVException {
 /* PMU related bits */
 #define MIE_LCOFIE                         (1 << IRQ_PMU_OVF)
 
+#define MCYCLECFG_BIT_MINH                 BIT_ULL(62)
+#define MCYCLECFGH_BIT_MINH                BIT(30)
+#define MCYCLECFG_BIT_SINH                 BIT_ULL(61)
+#define MCYCLECFGH_BIT_SINH                BIT(29)
+#define MCYCLECFG_BIT_UINH                 BIT_ULL(60)
+#define MCYCLECFGH_BIT_UINH                BIT(28)
+#define MCYCLECFG_BIT_VSINH                BIT_ULL(59)
+#define MCYCLECFGH_BIT_VSINH               BIT(27)
+#define MCYCLECFG_BIT_VUINH                BIT_ULL(58)
+#define MCYCLECFGH_BIT_VUINH               BIT(26)
+
+#define MINSTRETCFG_BIT_MINH               BIT_ULL(62)
+#define MINSTRETCFGH_BIT_MINH              BIT(30)
+#define MINSTRETCFG_BIT_SINH               BIT_ULL(61)
+#define MINSTRETCFGH_BIT_SINH              BIT(29)
+#define MINSTRETCFG_BIT_UINH               BIT_ULL(60)
+#define MINSTRETCFGH_BIT_UINH              BIT(28)
+#define MINSTRETCFG_BIT_VSINH              BIT_ULL(59)
+#define MINSTRETCFGH_BIT_VSINH             BIT(27)
+#define MINSTRETCFG_BIT_VUINH              BIT_ULL(58)
+#define MINSTRETCFGH_BIT_VUINH             BIT(26)
+
 #define MHPMEVENT_BIT_OF                   BIT_ULL(63)
 #define MHPMEVENTH_BIT_OF                  BIT(31)
 #define MHPMEVENT_BIT_MINH                 BIT_ULL(62)
-- 
2.34.1



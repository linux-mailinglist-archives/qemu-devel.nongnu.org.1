Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8831B825C68
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 23:14:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLsRn-0007PK-4W; Fri, 05 Jan 2024 17:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rLsRk-0007No-F6
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 17:13:44 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rLsRi-00010O-8y
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 17:13:44 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d3e6c86868so157085ad.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 14:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704492821; x=1705097621;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rMJVTM/OJQ3D+48PDiP3nmkHnu6Md2qHwda7zuLI03Y=;
 b=gFIw+7pC0PBKtcLCK2Wl0ScxquNc89TnM8QvVkGCK39Xi1kI/DU7vWb7Guw9utoHwu
 4WSLlJt0dOQibhWMTDS9dT5aL49YGSMMf5Fy6qEmhV3v6RXDFtGwnyaEeTHMEVlSW61d
 taX/2JFuebpoDc4g5SUilmPIuaxdzCC4IX5XDSzq98dk0AI52rfZdxdQxWk0GxUQvNvf
 WUQLP8EZzVFVO1+2WwFLqaiI7jnVy4co26pLhe9qljFlNXhHnoJDLIKmd7j8LPs1Zltw
 rcgWCr1LxHHhEAcGuiBXmWJYlMJhG3yG/OwFVS/xbKSEVonaMksGIx2RSwMavSRUynPx
 FjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704492821; x=1705097621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rMJVTM/OJQ3D+48PDiP3nmkHnu6Md2qHwda7zuLI03Y=;
 b=WtXhIByScEBQPaktQIyHRQPbBmPfnv2PK62OJVVOdz8adH1boodIUWlCu8LaBZFfjH
 rxvbE9EoSWbuS+Tq6nbSiLEbIrE9BUp+3q4ks27Hm2Uq0VsfH5ggw2AJ4/eq2S6hMq9O
 lJywQHkjh4SDl10WQAmx1+9PpGvdBmQJ/1hJyq45Khaf3TXshu0Ch9eJyfZWeQd7vyij
 +XMA5dCpeQcHoP2blQityo+fnUOIFI79l3eq5Rmwz8ur/RQGvx8QOEHdbbwxU/Gz39RR
 9D+Fm8cvPiwJbXM8aeb6Symt9ye6mCS78t/cii6fwaFk7NyiuAde5Dua+7FTdkTrV2h6
 D/YQ==
X-Gm-Message-State: AOJu0YyKQzdnmA4X+KCOBsfdNxTy8wDZy3pHr4r0WfBK/e4dNamHw4q/
 w8bjK1o+qpHabIFNDF8N76sx3N8EFqE0Lw==
X-Google-Smtp-Source: AGHT+IFLTct98VFQuRTDWFJ9OcZlVou00HzDMCJrKIxFdKPpdFWIYwouyOSJCLaAL6FicIJau2LeVQ==
X-Received: by 2002:a17:903:22ce:b0:1d3:c21b:db5a with SMTP id
 y14-20020a17090322ce00b001d3c21bdb5amr156680plg.34.1704492820915; 
 Fri, 05 Jan 2024 14:13:40 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a1709029a9600b001d35223d0besm1850524plp.251.2024.01.05.14.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 14:13:40 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: 
Cc: Kaiwen Xue <kaiwenx@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 kaiwenxue1@gmail.com
Subject: [PATCH v3 3/5] target/riscv: Add cycle & instret privilege mode
 filtering definitions
Date: Fri,  5 Jan 2024 14:13:25 -0800
Message-Id: <20240105221327.176764-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105221327.176764-1-atishp@rivosinc.com>
References: <20240105221327.176764-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x635.google.com
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

This adds the definitions for ISA extension smcntrpmf.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.h      |  6 ++++++
 target/riscv/cpu_bits.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AFD758AD1
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 03:24:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLvuR-0004RW-Ak; Tue, 18 Jul 2023 21:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kaiwenx@rivosinc.com>)
 id 1qLtUs-0003Og-G6
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 18:48:46 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kaiwenx@rivosinc.com>)
 id 1qLtUp-0004yO-LJ
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 18:48:46 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-666ecf9a0ceso4245810b3a.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 15:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689720522; x=1692312522; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8DUPikPAfjyyKt79jlbtqMzW7aLfCUXGDXyALVvO2zM=;
 b=mxSU+RY0if2ZuFXTWK98FMdRUXkCtb9rKbev13klIzE+YCMBGWuQOG83vRDc7P/ah+
 ILZT8MaDge8Y8sngt1i3zTciW9KcUoM4ArE1WXLRtgKkEiwAYWgxzehh2ZMYRbk4S/L5
 XdqPkYhbhxhrgN8RP66kKtQuR374khqqRvVYQcIF0nR7MfDcAG/K5EKRxjrE4K/H5pT1
 2z356IaFm7VsEfLXs1MU6iAiLCZCHsQnh/mZga+b6z2mS+wmDwPKK2TcpktLNas5iCtH
 ovHHzXrE5sHwUezdT1Pm2utNL871v4rqGGn4u9ADt+ybFZqkdqCbe5lUJAqIz7D3V5FK
 hItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689720522; x=1692312522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8DUPikPAfjyyKt79jlbtqMzW7aLfCUXGDXyALVvO2zM=;
 b=VAlnUy53YSLk4fkB5Inp+Co6Spot27bBRgfjJI733HS/3u8DVySEsMGMlukN1ODEfE
 T4fn2HmKys7tB7H0q7Zzw9IvFEMVG07aqqi0B53zYRyxGK9W9Qw1dcyQn2mJC/T7+cWz
 lzKHl+GWCBCXEDtXi0Pm2kRn+jGFCpDohI2wQ6h6uJiZ/zBot6srfkKlV/rcltj8mmbX
 1+h2dLh8r0aCxj1HiKSiwQTsNlA9fR2WPfP20p0v6CcXQoEYj+dn5ffVce6Z1U6JTQ7V
 bWtoCqzvzaOB20gM1hHRMD8+2o/r2Hp6supj7y4mTMLeFKpwPDPFlRE+oRZZX2C0fQYd
 IqEQ==
X-Gm-Message-State: ABy/qLYBXbPhmScfFiaEKLxZYaJiZiCSDL0Fy7oBk+XAeBySD2AaUioc
 D5+9KsLR7mUO486Ceecm4gGTmA==
X-Google-Smtp-Source: APBJJlFN+Yy78NtHgoB6z+cK6L/q5wLZBfmlLmVL/i14jbTGvutA0QSRM3kxAo94XTPVn8/WZ9D65Q==
X-Received: by 2002:a05:6a20:9484:b0:12c:9518:7899 with SMTP id
 hs4-20020a056a20948400b0012c95187899mr421317pzb.24.1689720522505; 
 Tue, 18 Jul 2023 15:48:42 -0700 (PDT)
Received: from kaiwenx.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 i14-20020aa787ce000000b00682669dc19bsm1983312pfo.201.2023.07.18.15.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 15:48:42 -0700 (PDT)
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
Subject: [PATCH 2/3] target/riscv: Add cycle & instret privilege mode
 filtering definitions
Date: Tue, 18 Jul 2023 15:47:44 -0700
Message-ID: <f6e3e17cdaffb2fbd580792d98ab254bfa93ef71.1689631639.git.kaiwenx@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689631639.git.kaiwenx@rivosinc.com>
References: <cover.1689631639.git.kaiwenx@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=kaiwenx@rivosinc.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This adds the definitions for ISA extension smcntrpmf.

Signed-off-by: Kaiwen Xue <kaiwenx@andrew.cmu.edu>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
---
 target/riscv/cpu.h      |  6 ++++++
 target/riscv/cpu_bits.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6ea22e0eea..3cdf5d09f7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -283,6 +283,12 @@ struct CPUArchState {
 
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
index 59f0ffd9e1..0a25fb276b 100644
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
@@ -879,6 +886,28 @@ typedef enum RISCVException {
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



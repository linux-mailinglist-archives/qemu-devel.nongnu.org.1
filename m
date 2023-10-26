Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB507D85D7
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 17:21:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw29k-0006dE-4h; Thu, 26 Oct 2023 11:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qw29g-0006bT-NR
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:20:16 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qw29U-00069k-Bz
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:20:16 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-564b6276941so905756a12.3
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1698333603; x=1698938403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=61ZMS3NPRFqHZKTu/SPe5ruHdrWMd68xp2LyStvCuls=;
 b=VnQyuzKpC9xXTyM1anfE9iRWDYQ481tfizwqLFD2MEj5D4xrDmqWsslcVdHR9784TG
 DvS1LKELJJll9g2MgO8qbUDguTwuztznaaPBdebpzPEDQDIlieDqfH9fA3jyNAj9gSWS
 RIKcE6REjbN5gslJTV/RWCmooz9eNPz89DNDH+io8e6VPIGnuX3MfMKMpSlCjZii047C
 2DvamSlXsyBrdDv0yigvN33va6IIbNL1pRvX3+u9A/nmE8uozd3r0sikbEemZ58DygjS
 RYcOVcFof4HJurZFBuC3QuJDpcUOXrfuAmjIH83CxqCjugWFNRs24KeV0/wVGzItQF/O
 puCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698333603; x=1698938403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=61ZMS3NPRFqHZKTu/SPe5ruHdrWMd68xp2LyStvCuls=;
 b=WhIlUbd277MFbzj+VJihh0j5pJBo3+fUXo+DmZKMXcDWOXpcw41ISoA5dWTvqX6ffN
 S/Tx+d3WTUizOhf10tP1Y4jjfQjUy6rlgZ8w2aGGByRlUZ8VdvvhzUMZ+G1P/plbVsX2
 ib5rjGvFBedWe3oJsRdjXB99ATb4lhBqEC2Fa6v4c9myhaFEHonqhKBNQWlGp0pfPRSC
 Qq6LK0nCnWyqRnciE79Y/0j5C0U2c4x8dpBx33Zyb5ugtRTpZTpsahPI9IXYS2Ygck3Y
 Uepp26rg8BB85x/0F1jpLVz8LNCwTdqgRr1oYa5Td9E1dgs0M1NgRzaCrBepnr8V+aqR
 i8/g==
X-Gm-Message-State: AOJu0Yy/QMCCJSn9R5dUMcCXdLW0nFWcRxLSqN1YW1fq72xQsbnpkLmA
 34Kgt58qPItDXgaaKdx/wK+32bKyBbyocN6KRAVaWrPTPivRJoNdFMS0KpnasiTA0R2lxPuEo6H
 QAUMkfoQwz4jHSosiTWvJO0k8Onrk7WPShXwQm2YM+xA10jR+oXjkNOaACt40fWA+ChK5XEP5g0
 2c
X-Google-Smtp-Source: AGHT+IEeVHfjDBLY5iEjxJwKst5gRDIxFyZXSKeyLLnOGRmcoXDsjzALxqZ+kAXLNG39/8GR3MH0yw==
X-Received: by 2002:a17:90a:d50d:b0:27c:f20d:841f with SMTP id
 t13-20020a17090ad50d00b0027cf20d841fmr18498756pju.8.1698333602446; 
 Thu, 26 Oct 2023 08:20:02 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 nv18-20020a17090b1b5200b0027fee011cebsm1326061pjb.10.2023.10.26.08.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 08:20:02 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v2 01/14] target/riscv: Add cfg property for Zvkt extension
Date: Thu, 26 Oct 2023 23:18:08 +0800
Message-Id: <20231026151828.754279-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026151828.754279-1-max.chou@sifive.com>
References: <20231026151828.754279-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Vector crypto spec defines the Zvkt extension that included all of the
instructions of Zvbb & Zvbc extensions and some vector instructions.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/tcg/tcg-cpu.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e7ce977189c..d8d17dedeed 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -94,6 +94,7 @@ struct RISCVCPUConfig {
     bool ext_zvknhb;
     bool ext_zvksed;
     bool ext_zvksh;
+    bool ext_zvkt;
     bool ext_zmmul;
     bool ext_zvfbfmin;
     bool ext_zvfbfwma;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c5ff03efce9..b9eaecb699c 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -499,6 +499,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvkt) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbb), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
+    }
+
     /*
      * In principle Zve*x would also suffice here, were they supported
      * in qemu
-- 
2.34.1



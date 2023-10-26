Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A50E07D85E5
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 17:22:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw2AX-00085T-NS; Thu, 26 Oct 2023 11:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qw2AH-000717-0a
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:20:55 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qw2A0-0006LX-KE
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:20:52 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-27e4e41a4fcso845823a91.3
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 08:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1698333635; x=1698938435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yll/HCAgAasXHziGOZUTxy4IGz750BTJcwVTSBRQH9g=;
 b=GgtgDIfZXwQyXNJpY3JKrTbyGo6FF9tx5aXmaT2sz2C0c0CBeGAF0afmRJnaxpEHGe
 DS2rRPj2WVNyqOrZHMqT4BDnflCTb9xtZ/okYMj31kM1tawnm5jo1DoOAogWLafE2KSk
 HX9biVox6hGfpA6E3w3zehnnkJ/N/qW+9WdAbBQXv5x+jbdw5Co533g2HBYV9+2VMq6i
 VS0Anr9wzF1LccUvtU25kjAzTOJwbn7Mgc1ttK3DVbYHSDSJ+4hfLJY/m3WDeiHPYJuB
 u+EkYAKFJoypu2Po1aJbjRqTSJFoYdBLyXwIu8XPRflYB+btRHeyOaFcpi5Vw5fzZGNI
 w9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698333635; x=1698938435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yll/HCAgAasXHziGOZUTxy4IGz750BTJcwVTSBRQH9g=;
 b=szeWwXTJqW5OEY4PkRjVi0PfA/fDrPRzrrbHB/MN53uDGkUlXJiB2mJgD8FzJ4Z0ch
 mK2PQDetRF0hAS6uOw44eoHi4z/1IMLbJpTVlBGTkm1kWxq0AbWhDgydj8111r/C2LPa
 KLE/DU7yAFtetrU5NQf3Rmq/oDzVJHbMN9Ubd/kShLTjTJKO6/Rdmy4A4Ffc2IcIcjHN
 OjLGOKxL/6nOM/UxOqelbBRidYSrvX/zBSRDXfBbT0g392Yu2Age9rtAITbpbRmGFi1p
 eqGrVR8AU+YppPuwIjIfiAL/nuvE/jbA27SA/2eGOuAC6tmrjla2FaFec33HO5mGEUmI
 ozUA==
X-Gm-Message-State: AOJu0Yw0nNxoyc1xbk8GI/zLHUvyhYMrElnuQUuNNxhnlRlsjBk2QiyP
 CgBxouXD9rlN31kGA8jneaIdgVTooikllAvBm+eMlFFfzjYpr9y9/DQ0q4/6tHanA1OBtZWBcuY
 98JZlrjQd/yI0qVhA6kW1/8PBEQdMu2JDfdfR8tKm9Cp+Dv5iA59ca+IWLNMmgkFuXAKVdTBnCa
 Er
X-Google-Smtp-Source: AGHT+IFPqd6cgQ/nvEoAKsET3snSUJQPq/tkLHTRsZGfkxzzE8w6nr/EndE5jj//p6KJmfh7cEXbdg==
X-Received: by 2002:a17:90a:ba0e:b0:27f:f7e9:cad9 with SMTP id
 s14-20020a17090aba0e00b0027ff7e9cad9mr1746613pjr.36.1698333634779; 
 Thu, 26 Oct 2023 08:20:34 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 nv18-20020a17090b1b5200b0027fee011cebsm1326061pjb.10.2023.10.26.08.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 08:20:34 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v2 06/14] target/riscv: Add cfg properties for Zvkn[c|g]
 extensions
Date: Thu, 26 Oct 2023 23:18:13 +0800
Message-Id: <20231026151828.754279-7-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026151828.754279-1-max.chou@sifive.com>
References: <20231026151828.754279-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1035.google.com
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

Vector crypto spec defines the NIST algorithm suite related extensions
(Zvkn, Zvknc, Zvkng) combined by several vector crypto extensions.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu_cfg.h     |  3 +++
 target/riscv/tcg/tcg-cpu.c | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 935335e5721..fd07aa96a27 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -96,6 +96,9 @@ struct RISCVCPUConfig {
     bool ext_zvksed;
     bool ext_zvksh;
     bool ext_zvkt;
+    bool ext_zvkn;
+    bool ext_zvknc;
+    bool ext_zvkng;
     bool ext_zmmul;
     bool ext_zvfbfmin;
     bool ext_zvfbfwma;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 1b08f27eee4..e460701a13c 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -499,6 +499,26 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    /*
+     * Shorthand vector crypto extensions
+     */
+    if (cpu->cfg.ext_zvknc) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkn), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
+    }
+
+    if (cpu->cfg.ext_zvkng) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkn), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkg), true);
+    }
+
+    if (cpu->cfg.ext_zvkn) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkned), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvknhb), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkb), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkt), true);
+    }
+
     if (cpu->cfg.ext_zvkt) {
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbb), true);
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
-- 
2.34.1



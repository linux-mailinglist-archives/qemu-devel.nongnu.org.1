Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DFE7D7088
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 17:15:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvfah-0005FV-Et; Wed, 25 Oct 2023 11:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qvfaf-0005F6-97
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:14:37 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qvfac-0003dh-RI
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:14:37 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c9d3a21f7aso49426485ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 08:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1698246873; x=1698851673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yll/HCAgAasXHziGOZUTxy4IGz750BTJcwVTSBRQH9g=;
 b=R7r65tKkpchCSJL2QHa+D7IiMAy5SMvdTFzroM6cOpfw/Li49U0PT3rurr8GABb9xf
 sTYHmJrtTTEwUuNfBA0HlQm+8OPejX9FIL8sio/HvGIUQtHBDHpUfdhBvye/v5Q6aX14
 IHLhKtHIaagO5N8GcxsW+6wJsfClTPK1Wqt6gse/TE3DQgHcwlvt3xkHoUeN1b2lWAY8
 s64zilvecCKeaMTXuk5lDyWX576npc/5J9bvnP3l7+0AWCXH8oCtYOZ2KYXn3iFHoZmM
 fQ7aCawLgA++7Cbriq52uZIpSleA4YZCGfhkCme2bpPl3wQZx1pTbZHXQ/PzEuPHObh/
 GGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698246873; x=1698851673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yll/HCAgAasXHziGOZUTxy4IGz750BTJcwVTSBRQH9g=;
 b=iC00c7N4qijWfAbv5wMyJFn3kmym+Nb6vxdr8hpdBQAWkioRfa8RnjyhnE/2NZZy0H
 oPw217Iva/ZHo1BLKAWDyMkxUzWhRnFZsb6EgmgisUIU85F2bGJpMFfTsbRMah7SW/6v
 cOAv5xlhoWFozuk2h4OWYsLl9oa/mJRqngKs6oQi57AaJqPJJjXmMX1DVsdmKJAdv9KN
 ywV93gABwrVyD+hmA05m2RkMIq9GnQNbSStIqsPmOZyzpjUDNfTL22uWpplMyBrqebul
 zaEfsZpIpx4H8hcBLgqt1P373QAR0babl96vbo0pASKiLI6iSMoCy2owL0tBC9wXO9s+
 mJ2Q==
X-Gm-Message-State: AOJu0YyDyHfkytuy7448jgeiwA44bJG7V26We5mcQ2vIYqoNZrPMSdsO
 s6Ty2F+9Rw5i1TT2m8Dz/A8StpMJ65zHdmUh+G05IKmLhFLbA+cR8tY66STSN5Uc/IwrdYEJU1P
 42tdM/lBKN5qTDAZrECsw3THOxnRq02dVo2hTVN7mt/lh56Hr6gLFUup7t3R/4zUltlonNnrY0G
 x4
X-Google-Smtp-Source: AGHT+IH/2q4oPfBdO/WuHzppvItA4ILwt7aaTzQtNlc6pE2V6xXidBnrmAWozG4aLU0nC9YY5lzmqQ==
X-Received: by 2002:a17:903:27ce:b0:1c1:f6d1:3118 with SMTP id
 km14-20020a17090327ce00b001c1f6d13118mr14114852plb.27.1698246873098; 
 Wed, 25 Oct 2023 08:14:33 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 w14-20020a63160e000000b005b8ebef9fa0sm2677807pgl.83.2023.10.25.08.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 08:14:32 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH 06/14] target/riscv: Add cfg properties for Zvkn[c|g]
 extensions
Date: Wed, 25 Oct 2023 23:13:30 +0800
Message-Id: <20231025151341.725477-7-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025151341.725477-1-max.chou@sifive.com>
References: <20231025151341.725477-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



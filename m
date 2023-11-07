Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 004297E3308
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:34:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bsn-000747-F2; Mon, 06 Nov 2023 21:32:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bsk-0006rb-PW
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:58 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bsi-0002xP-0o
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:58 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cc0e78ec92so33996235ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324314; x=1699929114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WF18xcaevK6XnxPJKLI8XDdsaLIWSgDBnxRtMMtRjZo=;
 b=EhhDr1Q9G1K6b9y8Hcw68WduNa9cO1kDWLvQmAe/vCqbOh0xvouchN5Enj8+y4Rsns
 bPPoACe7TEg+wBGAo3ni6l9N86MMSvnRlv2DNaaKhXxTkf1LThXrAeFEWftLDIP3i5R2
 AaAEcxYxYwzQUyCKbm1k/5rq8J55qSLQ9rOLtBr3m2+5ZmDgqNmsKe0W3hBb9YnlQ2rB
 EahEnQuJk6FMQ/nBgxsGyx8ylrP36NLlK+2Sli7q8glHKjXOm6YdONzH4saiWGojLvUW
 TyHqNBQTyhrdgIc9sMSTNFDofOldsTSXSLvXzpaTbyPmRWpZv3KPnv3KsJ3Snb9VtVIj
 CgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324314; x=1699929114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WF18xcaevK6XnxPJKLI8XDdsaLIWSgDBnxRtMMtRjZo=;
 b=ikzxfQ3IdUC6O92yr7CQK517p70pJVzC0L0Co828ssuCO5PuhZhUxFb4tHQPQ7tAia
 xWJr9btvNshs878ae9uUlRpLOzebIDvf37V2GwEncnX1J0hG2XVQyA5LPCKruFJFAYrq
 BBYRSwAMFFBqCAjDnhjplPtgh182E3PCNMdzUnBKUoNHz13Ru+RUavBBahIlg6aqMbjP
 GgCv3ZPThaG0pb9fvpZylOhwRmj6tWRzGsMkJeEvBhLnIJGpU6J89kJbhp2Nuzv3nlEa
 ql2V31MZVGFKVpT1I7mefkORjyCK4+QyU8gQA0cD91ZthX+7Ynp98KgIB/HmoFn6ShZI
 ZNjA==
X-Gm-Message-State: AOJu0YwXLp55EcUPgrDR3R3hOSXMNJh/8jC2+hoVPUFf986EG68ubG1W
 KD2NQTVC2vmXuZmvvUpRG/RtxEX+fq61Dg==
X-Google-Smtp-Source: AGHT+IGkQJxskyjMK4R8wBSO9BTqp3eKzM6MjJWkIFWgUOYR4KjgWGqrwYchkaZ/cfq+v+QDHJ2eGA==
X-Received: by 2002:a17:902:f213:b0:1c9:da1a:8b14 with SMTP id
 m19-20020a170902f21300b001c9da1a8b14mr23891813plc.1.1699324314143; 
 Mon, 06 Nov 2023 18:31:54 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:31:53 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 34/49] target/riscv: Add cfg properties for Zvkn[c|g] extensions
Date: Tue,  7 Nov 2023 12:29:30 +1000
Message-ID: <20231107022946.1055027-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Max Chou <max.chou@sifive.com>

Vector crypto spec defines the NIST algorithm suite related extensions
(Zvkn, Zvknc, Zvkng) combined by several vector crypto extensions.

Signed-off-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231026151828.754279-7-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h     |  3 +++
 target/riscv/tcg/tcg-cpu.c | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index c4b2fec024..08733002a7 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -98,6 +98,9 @@ struct RISCVCPUConfig {
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
index ad7a183a74..9540d1df4e 100644
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
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D84E57E3426
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:18:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CUn-0006IS-KC; Mon, 06 Nov 2023 22:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CUm-0006F9-3B
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:11:16 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CUk-00025U-Cp
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:11:15 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-28035cf6a30so4117220a91.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326672; x=1699931472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LIgodu9H6MNqcm2FpnHbkFw215Q/P+nlqcEfUhnn984=;
 b=HXKkFgSrg39K5jYVas47N+8NU0G+f56K1yVh44niKPYfloEUucWSvb4YCyYjFHOR37
 hCcsEQKi0fu4kWmLoju4zVeBhLG//fOp16Ik51nKZw/58DoYayB6GYWLV6c0+ckmPbvA
 kxlR4cSiE6AT89Hkhv27kzrrVStfBVpHByNWY0Y6U6L3HTxbKBysMbBsRCGzRepajpG9
 no1OVPPkqwcrEgwctC2blqiX4uqmRqB1LHdmHpzed9lAHaT9O8AnyAwnpms9bOtNV4QF
 aE+XiphdgLtXB8KH2k7B3yCkOxPFWixkaj6putMLpsP0bQMjT9JYhiDdU91UJ0CNKXk9
 iyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326672; x=1699931472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LIgodu9H6MNqcm2FpnHbkFw215Q/P+nlqcEfUhnn984=;
 b=p10FJaOZBjYcdm0gYL8/+nAqDQAmxrL5SBtw+3ckNjD5neuRZUn3b3XHikyzPl0qMD
 ryaQGKQfZgDRa6z3scXQXDpi7SSxWAk/96atWM2v/k4hKKnlRonJ8aR+yjn6bbNR5wCE
 8pgcYrSlAelvKJkby6oJZ0FqWNLRtrpZlLnuyzYXEPG9WrCE/xyWL7NrSmdzxNgGua24
 X+S9zVUz6A+miXWkCFhykhkdlzqTCjgHu1aR5sF9jo8yOuTlFnhGcgzt6EhGgwPHiD0A
 j97RWx8DS1ZAwifPWWlQShfen5v0bTikyPES4Q/Y04oLrldLY6kS/dxZz/LClYeb9j3T
 XcGw==
X-Gm-Message-State: AOJu0YwbTdmzFoUYTcOhYpS68EJ78iP/ykA+9yOMlBHlQjRsTcESOPdY
 Vy82gSrxRqOdmaGROBpUPzUW3yVTxbpztRjvY1Q=
X-Google-Smtp-Source: AGHT+IFscywutQgfnOiY9aKmd3HyqmSkdQtOvxN0072uiQZa18y0w5f/aBgSxk2dsRWNZn77WnJ61g==
X-Received: by 2002:a17:90a:1997:b0:280:6d53:f5d2 with SMTP id
 23-20020a17090a199700b002806d53f5d2mr18696284pji.11.1699326672052; 
 Mon, 06 Nov 2023 19:11:12 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 gw13-20020a17090b0a4d00b0026f4bb8b2casm6246253pjb.6.2023.11.06.19.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:11:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 85/85] hw/hppa: Allow C3700 with 64-bit and B160L with 32-bit
 CPU only
Date: Mon,  6 Nov 2023 19:04:07 -0800
Message-Id: <20231107030407.8979-86-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Helge Deller <deller@gmx.de>

Prevent that users try to boot a 64-bit only C3700 machine with a 32-bit
CPU, and to boot a 32-bit only B160L machine with a 64-bit CPU.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index da9ca85806..a3222d3a96 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -528,6 +528,12 @@ static void machine_HP_B160L_init(MachineState *machine)
     /* Create CPUs and RAM.  */
     translate = machine_HP_common_init_cpus(machine);
 
+    if (hppa_is_pa20(&cpu[0]->env)) {
+        error_report("The HP B160L workstation requires a 32-bit "
+                     "CPU. Use '-machine C3700' instead.");
+        exit(1);
+    }
+
     /* Init Lasi chip */
     lasi_dev = DEVICE(lasi_init());
     memory_region_add_subregion(addr_space, translate(NULL, LASI_HPA),
@@ -602,6 +608,12 @@ static void machine_HP_C3700_init(MachineState *machine)
     /* Create CPUs and RAM.  */
     translate = machine_HP_common_init_cpus(machine);
 
+    if (!hppa_is_pa20(&cpu[0]->env)) {
+        error_report("The HP C3000 workstation requires a 64-bit CPU. "
+                     "Use '-machine B160L' instead.");
+        exit(1);
+    }
+
     /* Init Astro and the Elroys (PCI host bus chips).  */
     astro = astro_init();
     astro_dev = DEVICE(astro);
@@ -659,6 +671,11 @@ static void hppa_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
+static const char *HP_B160L_machine_valid_cpu_types[] = {
+    TYPE_HPPA_CPU,
+    NULL
+};
+
 static void HP_B160L_machine_init_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -666,6 +683,7 @@ static void HP_B160L_machine_init_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "HP B160L workstation";
     mc->default_cpu_type = TYPE_HPPA_CPU;
+    mc->valid_cpu_types = HP_B160L_machine_valid_cpu_types;
     mc->init = machine_HP_B160L_init;
     mc->reset = hppa_machine_reset;
     mc->block_default_type = IF_SCSI;
@@ -690,6 +708,11 @@ static const TypeInfo HP_B160L_machine_init_typeinfo = {
     },
 };
 
+static const char *HP_C3700_machine_valid_cpu_types[] = {
+    TYPE_HPPA64_CPU,
+    NULL
+};
+
 static void HP_C3700_machine_init_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -697,6 +720,7 @@ static void HP_C3700_machine_init_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "HP C3700 workstation";
     mc->default_cpu_type = TYPE_HPPA64_CPU;
+    mc->valid_cpu_types = HP_C3700_machine_valid_cpu_types;
     mc->init = machine_HP_C3700_init;
     mc->reset = hppa_machine_reset;
     mc->block_default_type = IF_SCSI;
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E55567DEA6C
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:51:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMeV-00076f-CF; Wed, 01 Nov 2023 21:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMeO-0006U5-D8
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:37:36 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMeM-0004MV-67
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:37:36 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3b2f28caab9so262958b6e.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698889051; x=1699493851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LIgodu9H6MNqcm2FpnHbkFw215Q/P+nlqcEfUhnn984=;
 b=n2mceh4asuF27q/XfGBMLcAaZTPockRpNdCAXXKJR+S5GnF8DFiPUBorrYzTgspWI3
 igH0OI/xqE0dzNNw9o2Bnd5r2MsPCgYy0z/2NhzmYJP1jRQhUdHg1oUP+mzu+fWrMhU8
 kcjl48Qtq1/q4+7kRXTngJJPKjZoZuQsJayMPEQQR87r0T9mN6JUiQDJTyHC5E4XBaS1
 U70YONDs2qo0+J3RK/JHv9kODodHhT8sJFesRs9ujPMR1EIIjeHzEelWfd1qSC7rhmUN
 cwj2IZgaUJDeyOfcafvDds8O4h1eKAklI29TZfoYI0zoV1iPp7lWXgy+YyqBOoUtRQiG
 JiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698889051; x=1699493851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LIgodu9H6MNqcm2FpnHbkFw215Q/P+nlqcEfUhnn984=;
 b=Nv6m3TUIJsbSWn3LCex/5HGVcKsArdnqAJiKgInsedQMWDgW2F/SGZaA0rYtCW+4ZE
 aEzlstNi6MvYYeX/Ys2P2+PqQ/PJjQuIPYKIH99gXaNjMGP8rZ6kdHYdD3adqadZ7/ey
 VjBgLlWgHqa1dqcTEkg4W+UKH+Pd7AmjTayG4s7ZTgPTBFAbSyUTHL6POpKghY8QHOw0
 2KD+L+Eyia5q5jHXGfjS0SBVCIjjIDdSvznx2hF4MppiSEl7ooMEkPDAfsebB7MA6Ql4
 nlpP6FpKIeOf5jpuWn+L/qE6ic4FP29p6+0pI2edNTrmihTtxzopWM0alduv3i3CdY1Q
 LKBQ==
X-Gm-Message-State: AOJu0YzWlF4Wr/rdiy+HDO6ClPGIXEHVtZjkBt1h9S0Ui/87i4/lXGLj
 UwnbMtlcSCdRz8GiZ07s+9CAI+RoZNvayvlMSz0=
X-Google-Smtp-Source: AGHT+IFAgYtEP8tWL6mzdIhgFd5IkmuUa7A0E4/rwAU4QCQ4grivv+N27Xst0NzZXm10e35FvFo3Xw==
X-Received: by 2002:a05:6808:10c8:b0:3ae:251b:5552 with SMTP id
 s8-20020a05680810c800b003ae251b5552mr23179902ois.12.1698889051341; 
 Wed, 01 Nov 2023 18:37:31 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v20-20020aa78514000000b006934e7ceb79sm1800230pfn.32.2023.11.01.18.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:37:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 87/88] hw/hppa: Allow C3700 with 64-bit and B160L with
 32-bit CPU only
Date: Wed,  1 Nov 2023 18:30:15 -0700
Message-Id: <20231102013016.369010-88-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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



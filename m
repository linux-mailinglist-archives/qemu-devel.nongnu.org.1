Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 060B47F2A4F
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 11:25:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Nw6-0004Lw-QX; Tue, 21 Nov 2023 05:24:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5Nw1-0004Il-TZ
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:24:49 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5Nvz-0007Em-0z
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:24:49 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4083ac51d8aso24019515e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 02:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700562285; x=1701167085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DFKuHjN+ndUlQFTqRBZjDt9iBODNYrCuBl0JQxBqPME=;
 b=TPXj3r9ueDfXtQDyIuWUFvdMPjoqBf6MZQp33VXNKzOYVGdh4q9JSZULgZYJtEV0K2
 Q6+u2/DRYTzyDmPZtJy23tIZesRqYnadAGJVvN3OzfhpQkeuG2OVzE+QJPSw48n+zkuH
 mq1j/P6Ek7QsVVsHWGU0yGPqfHpFbXI8AgPAbjkQhUIC4nH/YQ3JVwROa7qFiP3CpHKH
 wV1cS0FL5rMAASCzkNKcUGuSIbSHzshnOVBxGaVMlbxorFwkB+I71QxhNXYlaR+2nIZX
 K+CyOan+hZX2njH5rY+9BmDwnUvDnUp/itHFpRVeVts0h+eh3TdLJJhvIac2wxfCAPOM
 I5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700562285; x=1701167085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DFKuHjN+ndUlQFTqRBZjDt9iBODNYrCuBl0JQxBqPME=;
 b=DMelyUGDo871MzFys5BYcLanxT1E8Synhzj+QCEmuhKNwqOchR9G9iwXWRk30uFbvF
 pyvhIMYpY5SuFzbt3K6Sk3fX10Xs2ZopHEEpeYV8czYjYKjg1uaKhrjkEGqJziERE0kF
 ClZUj/mJu/Z4/GAp+lPtm5ieP2jF7tvmNrn0NLQt400yXNii7ZhhKsRX79D7b5yl20af
 vX2L46tYhP+527cE90oA0in5Sv+U4RDSOcyE5AT0meMHtZQq8UDQMw86abj3C9DL1jfM
 PC53kFQzgmHiw35L4KZJnpOpJjblgWz6ZD0hlxxH/sGvuqcY/cFtPVBLwd6rVZWBSzbO
 chNA==
X-Gm-Message-State: AOJu0YxYv4ftL5Bg7nX8GqwDe7Mwgx6rNFxe9JXkEaKcCZXsM99wP17C
 TTxO8ELbJ1H9zKE1W+V8GKmBTammOGjMnnrrHcU=
X-Google-Smtp-Source: AGHT+IHDe4bzKtVWfo7+7Vw51BGUaLqj/+w2fVVpgJw5pAybW5CU1ClQk2HoOyQ6doUkD1BmIKQZAw==
X-Received: by 2002:a05:600c:3b84:b0:40b:2b86:c886 with SMTP id
 n4-20020a05600c3b8400b0040b2b86c886mr442704wms.31.1700562285364; 
 Tue, 21 Nov 2023 02:24:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n25-20020a05600c181900b00405442edc69sm20450835wmp.14.2023.11.21.02.24.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 02:24:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/8] hw/core/machine: Constify MachineClass::valid_cpu_types[]
Date: Tue, 21 Nov 2023 10:24:37 +0000
Message-Id: <20231121102441.3872902-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121102441.3872902-1-peter.maydell@linaro.org>
References: <20231121102441.3872902-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Gavin Shan <gshan@redhat.com>

Constify MachineClass::valid_cpu_types[i], as suggested by Richard
Henderson.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231117071704.35040-2-philmd@linaro.org
[PMD: Constify HPPA machines,
      restrict valid_cpu_types to machine_class_init() handlers]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/boards.h |  2 +-
 hw/hppa/machine.c   | 22 ++++++++++------------
 hw/m68k/q800.c      | 11 +++++------
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index a7359992980..da85f86efb9 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -273,7 +273,7 @@ struct MachineClass {
     bool has_hotpluggable_cpus;
     bool ignore_memory_transaction_failures;
     int numa_mem_align_shift;
-    const char **valid_cpu_types;
+    const char * const *valid_cpu_types;
     strList *allowed_dynamic_sysbus_devices;
     bool auto_enable_numa_with_memhp;
     bool auto_enable_numa_with_memdev;
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 9d08f39490e..c8da7c18d53 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -672,19 +672,18 @@ static void hppa_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
-static const char *HP_B160L_machine_valid_cpu_types[] = {
-    TYPE_HPPA_CPU,
-    NULL
-};
-
 static void HP_B160L_machine_init_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        TYPE_HPPA_CPU,
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
     NMIClass *nc = NMI_CLASS(oc);
 
     mc->desc = "HP B160L workstation";
     mc->default_cpu_type = TYPE_HPPA_CPU;
-    mc->valid_cpu_types = HP_B160L_machine_valid_cpu_types;
+    mc->valid_cpu_types = valid_cpu_types;
     mc->init = machine_HP_B160L_init;
     mc->reset = hppa_machine_reset;
     mc->block_default_type = IF_SCSI;
@@ -709,19 +708,18 @@ static const TypeInfo HP_B160L_machine_init_typeinfo = {
     },
 };
 
-static const char *HP_C3700_machine_valid_cpu_types[] = {
-    TYPE_HPPA64_CPU,
-    NULL
-};
-
 static void HP_C3700_machine_init_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        TYPE_HPPA64_CPU,
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
     NMIClass *nc = NMI_CLASS(oc);
 
     mc->desc = "HP C3700 workstation";
     mc->default_cpu_type = TYPE_HPPA64_CPU;
-    mc->valid_cpu_types = HP_C3700_machine_valid_cpu_types;
+    mc->valid_cpu_types = valid_cpu_types;
     mc->init = machine_HP_C3700_init;
     mc->reset = hppa_machine_reset;
     mc->block_default_type = IF_SCSI;
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 1d7cd5ff1c3..83d1571d02f 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -726,19 +726,18 @@ static GlobalProperty hw_compat_q800[] = {
 };
 static const size_t hw_compat_q800_len = G_N_ELEMENTS(hw_compat_q800);
 
-static const char *q800_machine_valid_cpu_types[] = {
-    M68K_CPU_TYPE_NAME("m68040"),
-    NULL
-};
-
 static void q800_machine_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        M68K_CPU_TYPE_NAME("m68040"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Macintosh Quadra 800";
     mc->init = q800_machine_init;
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
-    mc->valid_cpu_types = q800_machine_valid_cpu_types;
+    mc->valid_cpu_types = valid_cpu_types;
     mc->max_cpus = 1;
     mc->block_default_type = IF_SCSI;
     mc->default_ram_id = "m68k_mac.ram";
-- 
2.34.1



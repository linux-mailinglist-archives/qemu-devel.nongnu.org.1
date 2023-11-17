Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C137EEC8B
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 08:19:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3t6X-0005Ld-NU; Fri, 17 Nov 2023 02:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3t6O-0005JT-3q
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 02:17:20 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3t6M-0004Gd-CB
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 02:17:19 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40839652b97so12751025e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 23:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700205434; x=1700810234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CHdKGB9IdVR9xVcd4O1PYbu10XnVv29sfGXQ2wqVVus=;
 b=e9nVJquOed/Ba0IwNQX3PJV6LcyTUTvHAcMVSpuD6aNC+TYgCF8MbxxyPG4Oa2iAUg
 06kZt8uk+BNestrxVb7w14BClgTF28d5G00EIfN48BePlxBqjJvVBSj9wEUfgSeg5sgw
 modZvWAEJok1h1g7MBvgxT3nUpI9nXgQpZkNUBqMm+ZF266k9LfC2PB6AVsv5UltvvBF
 FB09qYD/t5pmOhr3eqHDfDsS0V6GwfuYxicMW3l9+ANQ4oIsfDlTtYsi5MAyWK4JVwXl
 pso+WqVWBEYkneCZ6HAdi33kD77YwO+6fGwflm7QDgCEQDYZdJY5a6VHQbDEN0W7l8Yn
 iWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700205434; x=1700810234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CHdKGB9IdVR9xVcd4O1PYbu10XnVv29sfGXQ2wqVVus=;
 b=XkRtJ+3mZv3sZaWGZQdpD2/MOdYTl8CFz2uhcb1lLUf5ct6JRr4ZSG1H7xr5Ht13uj
 Rj1wdVwodAs9JhVT9rPSv76ZTpMeHokvOUx/ywNxe+wwQoodqnAdh29K6Nb3jtOoUExt
 nmyp7XWVBLHa+8pA1riLgSwyiNKbjbNmAqWhA2rO0vUmc0s8jxQRjZiGeJSKXATZ1vev
 eCjmOmxMeAzTrsMjR24P10L87yC2Imo+E/w7iJSPouovxABfYLA1+91XQVQQIc4+m2nD
 YMnuOxVPnCI95s7k7QxG7Un+6ojmW9rXKXN7Uk65QfLaesKStLEUkPElwyMybB+hMZxi
 HM+g==
X-Gm-Message-State: AOJu0YxXNakQJXao2L6/L+CH3V9pyjJSIl9kmNnvUWzw5zydaRCqaaYw
 NpSIs+jLlpQk/hIo/f/DfoH18+H13uIf2BJCmrs=
X-Google-Smtp-Source: AGHT+IFoL/Sqk6vInR+mOwkIJLAoc7daE5Ior/xfLIcnmoWupbL27htsqN3E2aPHpGfH64dWS31JhA==
X-Received: by 2002:a1c:7206:0:b0:3fe:4cbc:c345 with SMTP id
 n6-20020a1c7206000000b003fe4cbcc345mr14096613wmc.41.1700205434169; 
 Thu, 16 Nov 2023 23:17:14 -0800 (PST)
Received: from m1x-phil.lan (bd137-h02-176-184-46-187.dsl.sta.abo.bbox.fr.
 [176.184.46.187]) by smtp.gmail.com with ESMTPSA id
 u3-20020a05600c00c300b0040648217f4fsm5905684wmm.39.2023.11.16.23.17.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Nov 2023 23:17:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Felipe Balbi <balbi@kernel.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Subbaraya Sundeep <sbhatta@marvell.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Gavin Shan <gshan@redhat.com>
Subject: [PATCH-for-8.2? v2 1/4] hw/core/machine: Constify
 MachineClass::valid_cpu_types[]
Date: Fri, 17 Nov 2023 08:17:01 +0100
Message-ID: <20231117071704.35040-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231117071704.35040-1-philmd@linaro.org>
References: <20231117071704.35040-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Gavin Shan <gshan@redhat.com>

Constify MachineClass::valid_cpu_types[i], as suggested by Richard
Henderson.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[PMD: Constify HPPA machines,
      restrict valid_cpu_types to machine_class_init() handlers]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h |  2 +-
 hw/hppa/machine.c   | 22 ++++++++++------------
 hw/m68k/q800.c      | 11 +++++------
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index a735999298..da85f86efb 100644
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
index 9d08f39490..c8da7c18d5 100644
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
index 1d7cd5ff1c..83d1571d02 100644
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
2.41.0



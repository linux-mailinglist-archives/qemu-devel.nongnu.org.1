Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7DA70D43B
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 08:45:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Lkw-0001sk-Eb; Tue, 23 May 2023 02:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Lkq-0001mD-Sd
 for qemu-devel@nongnu.org; Tue, 23 May 2023 02:44:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Lkp-0002e5-3K
 for qemu-devel@nongnu.org; Tue, 23 May 2023 02:44:20 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f6042d605dso14563095e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 23:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684824257; x=1687416257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e9m7RKGJ9iCFi/ZsgwgInII18OX7f8aQ/TJysalxieQ=;
 b=I/dSFSNyur6SGDbO6vWwdOPySUGPt/5pEwS5msmLZOoDO7LcM7yc3zlNLJZ+xeEtst
 ouK0vHpZVHfmehaMtDOvEHcip7M5It1/z6THMk8eGHHjpj2wOGUtlMpIfgLtvKr+jqql
 q0WdKhyuVwOE3YTRzx1g5zIxenIs2Hlpz6lf4fVLP7m/DUWTpAp3K2SKXy8dmEI1VsI9
 svMTtgiuIxzKn/BNny0700OHS36SWFSD5Qh7k0MILbvp0gQIXofbOJdu9CPcBAK02HM/
 WbPzO3FTbVpEEAL4RtNRGNm89ExpD9nv2KYA3cAARgp9DbfhKsWGqkvtgM3FeG8Ok7ms
 EYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684824257; x=1687416257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e9m7RKGJ9iCFi/ZsgwgInII18OX7f8aQ/TJysalxieQ=;
 b=jAo4jKAdTLkur0r8f5nK9CiaKoix7oo83X5m3uuZQ/ny+HpQk1HgcjSi3buV3/TqhL
 HzAdwoVmYYOArCdj6UfKmGOKmcBk2qm1EfI/URIUm6GaOBtP0juHholRLesYqZMeWA+9
 GV3UsdnJaT9cHqcJlMKifbu2Z4NUsL3mcAr/wzai3EAoRqHmvhNQsmAbeNeZMs0bPesw
 v4712WHVsavXspCPg+1gN+ZJ9109tTbyzOD0VZIyovWDyuwK2gwX6M9vqhWYsNCch6Z5
 1VgKva49/Jk+zqO5vO92wwy8jWIkTZIQZSj1jwZJPlMDouNusvKjIHG6k7eND7rwCrsV
 JxLw==
X-Gm-Message-State: AC+VfDykQMl2KyLKB07axzRwDcCw5zvqc6BOiKPXe9VsTcgd5pQm0l/y
 TWWDw2qkjAiXVH633IggzaqVIDI32BVCRr29nho=
X-Google-Smtp-Source: ACHHUZ5ruophSw+tEwgqpIGHmU1Sb7BNY7Z/zF+pNWN27iDp8w6xakDTsU+Em3zCUDgmjab5syfHwA==
X-Received: by 2002:a05:600c:209:b0:3f6:464:4b32 with SMTP id
 9-20020a05600c020900b003f604644b32mr3708300wmi.13.1684824257319; 
 Mon, 22 May 2023 23:44:17 -0700 (PDT)
Received: from localhost.localdomain
 (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr. [176.184.48.94])
 by smtp.gmail.com with ESMTPSA id
 n1-20020a05600c294100b003ee74c25f12sm13828813wmd.35.2023.05.22.23.44.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 May 2023 23:44:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Titus Rwantare <titusr@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/3] hw/mips/jazz: Fix modifying QOM class internal state from
 instance
Date: Tue, 23 May 2023 08:44:06 +0200
Message-Id: <20230523064408.57941-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230523064408.57941-1-philmd@linaro.org>
References: <20230523064408.57941-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

QOM object instance should not modify its class state (because
all other objects instanciated from this class get affected).

Instead of modifying the MIPSCPUClass 'no_data_aborts' field
in the instance machine_init() handler, set it in the machine
class_init handler. Since 2 machines require this, share the
common code in a new machine_class_ignore_data_abort() helper.

Inspired-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/jazz.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index ca4426a92c..de2e827bf8 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -128,7 +128,6 @@ static void mips_jazz_init(MachineState *machine,
     int bios_size, n, big_endian;
     Clock *cpuclk;
     MIPSCPU *cpu;
-    MIPSCPUClass *mcc;
     CPUMIPSState *env;
     qemu_irq *i8259;
     rc4030_dma *dmas;
@@ -177,23 +176,6 @@ static void mips_jazz_init(MachineState *machine,
     env = &cpu->env;
     qemu_register_reset(main_cpu_reset, cpu);
 
-    /*
-     * Chipset returns 0 in invalid reads and do not raise data exceptions.
-     * However, we can't simply add a global memory region to catch
-     * everything, as this would make all accesses including instruction
-     * accesses be ignored and not raise exceptions.
-     *
-     * NOTE: this behaviour of raising exceptions for bad instruction
-     * fetches but not bad data accesses was added in commit 54e755588cf1e9
-     * to restore behaviour broken by c658b94f6e8c206, but it is not clear
-     * whether the real hardware behaves this way. It is possible that
-     * real hardware ignores bad instruction fetches as well -- if so then
-     * we could replace this hijacking of CPU methods with a simple global
-     * memory region that catches all memory accesses, as we do on Malta.
-     */
-    mcc = MIPS_CPU_GET_CLASS(cpu);
-    mcc->no_data_aborts = true;
-
     /* allocate RAM */
     memory_region_add_subregion(address_space, 0, machine->ram);
 
@@ -414,6 +396,27 @@ void mips_pica61_init(MachineState *machine)
     mips_jazz_init(machine, JAZZ_PICA61);
 }
 
+static void machine_class_ignore_data_abort(MachineClass *mc)
+{
+    MIPSCPUClass *mcc = MIPS_CPU_CLASS(mc);
+
+    /*
+     * Chipset returns 0 in invalid reads and do not raise data exceptions.
+     * However, we can't simply add a global memory region to catch
+     * everything, as this would make all accesses including instruction
+     * accesses be ignored and not raise exceptions.
+     *
+     * NOTE: this behaviour of raising exceptions for bad instruction
+     * fetches but not bad data accesses was added in commit 54e755588cf1e9
+     * to restore behaviour broken by c658b94f6e8c206, but it is not clear
+     * whether the real hardware behaves this way. It is possible that
+     * real hardware ignores bad instruction fetches as well -- if so then
+     * we could replace this hijacking of CPU methods with a simple global
+     * memory region that catches all memory accesses, as we do on Malta.
+     */
+    mcc->no_data_aborts = true;
+}
+
 static void mips_magnum_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -423,6 +426,7 @@ static void mips_magnum_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
     mc->default_ram_id = "mips_jazz.ram";
+    machine_class_ignore_data_abort(mc);
 }
 
 static const TypeInfo mips_magnum_type = {
@@ -440,6 +444,7 @@ static void mips_pica61_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
     mc->default_ram_id = "mips_jazz.ram";
+    machine_class_ignore_data_abort(mc);
 }
 
 static const TypeInfo mips_pica61_type = {
-- 
2.38.1



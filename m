Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA5D82338A
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:40:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL5Di-0008RS-2e; Wed, 03 Jan 2024 12:39:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL5DY-00081K-D6
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:39:48 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL5D4-0000nh-Rv
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:39:48 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40d2376db79so95820565e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704303557; x=1704908357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j5PGmkkL/PhNktzCzA9/ck6zIPH9FB5CIkJrjOgUxHc=;
 b=D9fdY4Pmx0GB21XuLqoROjFjhLY1P20xbr2dlZYHzMflvvD9eU3H3u4ZA7vT5r0Mm7
 ZPjQDVQ5JWSkClAEMMgcU4EEv/gm9ApdtgAsTThMTcgrvzeB+IWnxd+UTgdmBchZ1xEF
 Lmjamrc0B4RiJc/HCMR+HdOLMFIIES6VDJH22J6Zkrh8VnXEM5/Xk92Hx9lSY+i3SuQq
 UtQaOQta91yex4ZhvJByTKthdQ/xqZTqMTc6Dar0BL99Ci/HUqF9BGC/7MPwXW0zBLKa
 a1/696zJ6vZPOYRRHN7qHmi1onFdvkr+dRVXu2Eqn5vMtJBPb6C11ZBeWVUmeSfdYl4E
 a34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704303557; x=1704908357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j5PGmkkL/PhNktzCzA9/ck6zIPH9FB5CIkJrjOgUxHc=;
 b=YudGEwlRxlROCeZSGscJBPnl7nYU7eN8EnsCsWIs34jF6ERTCS7R9b85D5vvbk/kNz
 VjG4mo9JsWr4h1iGRYl30thIQZY09FR4rU4RHZIXnMNSVnkuvgP8tBCklUhsAIy28iYz
 DqwWlaznrU1YS/XTLIIr5+YqcXBruJ//SwC09jaL1X7x3jqrL+DLLGLOo/96lDoi1OAs
 84+2prIvW7B+k1mzNGdzQh4p8qoAVEDT1UsskYnbVhUY7IX2ZRBrlyuTpu3+O2+LZWvz
 g68vUpjuvM2VVv+BnNHFwqz0VUrxwNUkLdqjmLx6iJDATwxtP8JUfrK79V/UOHFAEmlJ
 equA==
X-Gm-Message-State: AOJu0Yx806EsCDD3hiNBQBBMC73dFn/Oi9zmzX/M/LrqWA8+z4OTxYXB
 0GSXPU8/HVuLalT35XVFtwRJ1lE7Ft+u/w==
X-Google-Smtp-Source: AGHT+IEjSIN4KOfZL2Hae3jDnOn2qYxJ4pBqF3j1XMHgZtnZoCV6fYm1BvSmWkqZgw9WmJyd0kj8Ig==
X-Received: by 2002:a05:600c:1992:b0:40d:5fed:eecf with SMTP id
 t18-20020a05600c199200b0040d5fedeecfmr6209855wmq.101.1704303556896; 
 Wed, 03 Jan 2024 09:39:16 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bl13-20020adfe24d000000b003365fcc1846sm31132628wrb.52.2024.01.03.09.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 09:39:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C478B5F9D0;
 Wed,  3 Jan 2024 17:33:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Bin Meng <bin.meng@windriver.com>,
 Laurent Vivier <lvivier@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, David Woodhouse <dwmw2@infradead.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <bcain@quicinc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Beraldo Leal <bleal@redhat.com>, Paul Durrant <paul@xen.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Cleber Rosa <crosa@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 34/43] hw/core/cpu: Remove gdb_get_dynamic_xml member
Date: Wed,  3 Jan 2024 17:33:40 +0000
Message-Id: <20240103173349.398526-35-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240103173349.398526-1-alex.bennee@linaro.org>
References: <20240103173349.398526-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

This function is no longer used.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231213-gdb-v17-9-777047380591@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/core/cpu.h |  4 ----
 target/arm/cpu.h      |  6 ------
 target/ppc/cpu.h      |  1 -
 target/arm/cpu.c      |  1 -
 target/arm/gdbstub.c  | 18 ------------------
 target/ppc/cpu_init.c |  3 ---
 target/ppc/gdbstub.c  | 10 ----------
 target/riscv/cpu.c    | 14 --------------
 8 files changed, 57 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index a6214610603..17f99adc0f4 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -134,9 +134,6 @@ struct SysemuCPUOps;
  *           before the insn which triggers a watchpoint rather than after it.
  * @gdb_arch_name: Optional callback that returns the architecture name known
  * to GDB. The caller must free the returned string with g_free.
- * @gdb_get_dynamic_xml: Callback to return dynamically generated XML for the
- *   gdb stub. Returns a pointer to the XML contents for the specified XML file
- *   or NULL if the CPU doesn't have a dynamically generated content for it.
  * @disas_set_info: Setup architecture specific components of disassembly info
  * @adjust_watchpoint_address: Perform a target-specific adjustment to an
  * address before attempting to match it against watchpoints.
@@ -167,7 +164,6 @@ struct CPUClass {
 
     const char *gdb_core_xml_file;
     const gchar * (*gdb_arch_name)(CPUState *cpu);
-    const char * (*gdb_get_dynamic_xml)(CPUState *cpu, const char *xmlname);
 
     void (*disas_set_info)(CPUState *cpu, disassemble_info *info);
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b2f8ac81f06..c8e77440f0f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1182,12 +1182,6 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
 int arm_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
-/* Returns the dynamically generated XML for the gdb stub.
- * Returns a pointer to the XML contents for the specified XML file or NULL
- * if the XML name doesn't match the predefined one.
- */
-const char *arm_gdb_get_dynamic_xml(CPUState *cpu, const char *xmlname);
-
 int arm_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                              int cpuid, DumpState *s);
 int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index f87c26f98a6..9f94282e13e 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1524,7 +1524,6 @@ int ppc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 int ppc_cpu_gdb_write_register_apple(CPUState *cpu, uint8_t *buf, int reg);
 #ifndef CONFIG_USER_ONLY
 hwaddr ppc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-const char *ppc_gdb_get_dynamic_xml(CPUState *cs, const char *xml_name);
 #endif
 int ppc64_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, DumpState *s);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 0a02d16220b..9514edaf041 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2499,7 +2499,6 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->sysemu_ops = &arm_sysemu_ops;
 #endif
     cc->gdb_arch_name = arm_gdb_arch_name;
-    cc->gdb_get_dynamic_xml = arm_gdb_get_dynamic_xml;
     cc->gdb_stop_before_watchpoint = true;
     cc->disas_set_info = arm_disas_set_info;
 
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 059d84f98e5..a3bb73cfa7c 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -474,24 +474,6 @@ static GDBFeature *arm_gen_dynamic_m_secextreg_feature(CPUState *cs,
 #endif
 #endif /* CONFIG_TCG */
 
-const char *arm_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname)
-{
-    ARMCPU *cpu = ARM_CPU(cs);
-
-    if (strcmp(xmlname, "system-registers.xml") == 0) {
-        return cpu->dyn_sysreg_feature.desc.xml;
-    } else if (strcmp(xmlname, "sve-registers.xml") == 0) {
-        return cpu->dyn_svereg_feature.desc.xml;
-    } else if (strcmp(xmlname, "arm-m-system.xml") == 0) {
-        return cpu->dyn_m_systemreg_feature.desc.xml;
-#ifndef CONFIG_USER_ONLY
-    } else if (strcmp(xmlname, "arm-m-secext.xml") == 0) {
-        return cpu->dyn_m_secextreg_feature.desc.xml;
-#endif
-    }
-    return NULL;
-}
-
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
 {
     CPUState *cs = CPU(cpu);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index a0178c3ce80..909d753b022 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7380,9 +7380,6 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
 #endif
 
     cc->gdb_num_core_regs = 71;
-#ifndef CONFIG_USER_ONLY
-    cc->gdb_get_dynamic_xml = ppc_gdb_get_dynamic_xml;
-#endif
 #ifdef USE_APPLE_GDB
     cc->gdb_read_register = ppc_cpu_gdb_read_register_apple;
     cc->gdb_write_register = ppc_cpu_gdb_write_register_apple;
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 8ca37b6bf95..f47878a67bd 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -342,16 +342,6 @@ static void gdb_gen_spr_feature(CPUState *cs)
 
     gdb_feature_builder_end(&builder);
 }
-
-const char *ppc_gdb_get_dynamic_xml(CPUState *cs, const char *xml_name)
-{
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
-
-    if (strcmp(xml_name, "power-spr.xml") == 0) {
-        return pcc->gdb_spr.xml;
-    }
-    return NULL;
-}
 #endif
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a3a98230ca8..1e3ac556b33 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1529,19 +1529,6 @@ static const gchar *riscv_gdb_arch_name(CPUState *cs)
     }
 }
 
-static const char *riscv_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname)
-{
-    RISCVCPU *cpu = RISCV_CPU(cs);
-
-    if (strcmp(xmlname, "riscv-csr.xml") == 0) {
-        return cpu->dyn_csr_feature.xml;
-    } else if (strcmp(xmlname, "riscv-vector.xml") == 0) {
-        return cpu->dyn_vreg_feature.xml;
-    }
-
-    return NULL;
-}
-
 #ifndef CONFIG_USER_ONLY
 static int64_t riscv_get_arch_id(CPUState *cs)
 {
@@ -1695,7 +1682,6 @@ static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
     cc->get_arch_id = riscv_get_arch_id;
 #endif
     cc->gdb_arch_name = riscv_gdb_arch_name;
-    cc->gdb_get_dynamic_xml = riscv_gdb_get_dynamic_xml;
 
     object_class_property_add(c, "mvendorid", "uint32", cpu_get_mvendorid,
                               cpu_set_mvendorid, NULL, NULL);
-- 
2.39.2



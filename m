Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4AD781197
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:21:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX3AD-0007sb-8m; Fri, 18 Aug 2023 13:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX39w-0007VX-7g
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:21:16 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX39s-0001ur-QY
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:21:15 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fe389d6f19so1553439e87.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692379271; x=1692984071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H2Fkk9ynZ3VBGOLEApNmPZej9m7TD3tkTeJS3zvlq3E=;
 b=GOphnewwFZStjeXzZW+e56mkMSIPCps0URPpllO+w64WvAbusLh3sSEfMDa7ND/9M5
 Wbbc4L0nIFMJKeK2rmyWRR9S1Xm4bhpf0AgtApp0UnLMTnaPYvFuvtEklcm7hQn+hliG
 rZ/qZ+kcrFdTGcvWqGV4IV2QtS7h3nGr9WVjbeXoQFWAUN9DnPbwNeZ53nTQnOpAdqux
 JYjvoyiyJzyf1mL/rfEJ9zaQpngDbG1sXoetbg9yqm+KlatYHd2VmEzEil6DXeq178HO
 riaMjmkcCz4GqAtaANPelLhjx1os3VqCXu4WB4S2aq66vRotWYT+Y/uX/sp6abVw9LHm
 0WSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692379271; x=1692984071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H2Fkk9ynZ3VBGOLEApNmPZej9m7TD3tkTeJS3zvlq3E=;
 b=EUwvaV9GUXGfnE0F5GGrBCjrYb0Q9fGDyqnfFVduVpJOLyjiJtKeZeO7cT+RgSUa+i
 jg8K2uBqs1BQXm9SQAlF9HQIsPHptntJ/r+ebN0ZthXnuUqwYnnnhkzOM22CWOtoERws
 m3M49qitpqSYY4Zz4YEYpX+F+9CGj9Z5bxpmftgA3Zy4/NwzKwOC+EAAC09URYJuePZQ
 cvZGtN1QsD5+GTu296J676TXU1AFls7YyiW2kPYzClDrmmDVZAiyNi+VKIENmtDWE6Qi
 u76UznRZ/hTpT0UvOgxMXyTJdwg7vaUM3g7BdE3B8VljEMJOyAPzgATz1KdMPlIAHU+Q
 Uhtg==
X-Gm-Message-State: AOJu0Yx942WmdgPRLQchBtehkxO5fPUznKaCA+yy0GxH8pid+qmSKE+8
 tTMGjWMj8KP9kjS6fEyRX7CLcPogJ0ZJuxzkkvc=
X-Google-Smtp-Source: AGHT+IHLeh8Nsum5fRrW/DxPhzkb0NOc62cZ3QyEYYBH84oQ2NFByIZAiDjhWNbbtf1SePekRAQxVQ==
X-Received: by 2002:a05:6512:3f0a:b0:4fe:181f:2736 with SMTP id
 y10-20020a0565123f0a00b004fe181f2736mr3090125lfa.33.1692379270913; 
 Fri, 18 Aug 2023 10:21:10 -0700 (PDT)
Received: from m1x-phil.lan (cnf78-h01-176-184-27-79.dsl.sta.abo.bbox.fr.
 [176.184.27.79]) by smtp.gmail.com with ESMTPSA id
 c4-20020aa7df04000000b00523b1335618sm1269391edy.97.2023.08.18.10.21.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Aug 2023 10:21:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jiajie Chen <c@jia.je>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 8/8] target/loongarch: Add GDB support for loongarch32 mode
Date: Fri, 18 Aug 2023 19:20:16 +0200
Message-ID: <20230818172016.24504-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818172016.24504-1-philmd@linaro.org>
References: <20230818172016.24504-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jiajie Chen <c@jia.je>

GPRs and PC are 32-bit wide in loongarch32 mode.

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20230817093121.1053890-4-gaosong@loongson.cn>
[PMD: Rebased, set gdb_num_core_regs]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/loongarch64-softmmu.mak |  2 +-
 target/loongarch/cpu.c                  | 10 ++++++
 target/loongarch/gdbstub.c              | 32 ++++++++++++++----
 gdb-xml/loongarch-base32.xml            | 45 +++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 8 deletions(-)
 create mode 100644 gdb-xml/loongarch-base32.xml

diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/loongarch64-softmmu.mak
index 9abc99056f..f23780fdd8 100644
--- a/configs/targets/loongarch64-softmmu.mak
+++ b/configs/targets/loongarch64-softmmu.mak
@@ -1,5 +1,5 @@
 TARGET_ARCH=loongarch64
 TARGET_BASE_ARCH=loongarch
 TARGET_SUPPORTS_MTTCG=y
-TARGET_XML_FILES= gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml
+TARGET_XML_FILES= gdb-xml/loongarch-base32.xml gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml
 TARGET_NEED_FDT=y
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 5082506f10..f42e8497d6 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -726,8 +726,18 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
 #endif
 }
 
+static gchar *loongarch32_gdb_arch_name(CPUState *cs)
+{
+    return g_strdup("loongarch32");
+}
+
 static void loongarch32_cpu_class_init(ObjectClass *c, void *data)
 {
+    CPUClass *cc = CPU_CLASS(c);
+
+    cc->gdb_num_core_regs = 35;
+    cc->gdb_core_xml_file = "loongarch-base32.xml";
+    cc->gdb_arch_name = loongarch32_gdb_arch_name;
 }
 
 static gchar *loongarch64_gdb_arch_name(CPUState *cs)
diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
index 0752fff924..a462e25737 100644
--- a/target/loongarch/gdbstub.c
+++ b/target/loongarch/gdbstub.c
@@ -34,16 +34,25 @@ int loongarch_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
     CPULoongArchState *env = &cpu->env;
+    uint64_t val;
 
     if (0 <= n && n < 32) {
-        return gdb_get_regl(mem_buf, env->gpr[n]);
+        val = env->gpr[n];
     } else if (n == 32) {
         /* orig_a0 */
-        return gdb_get_regl(mem_buf, 0);
+        val = 0;
     } else if (n == 33) {
-        return gdb_get_regl(mem_buf, env->pc);
+        val = env->pc;
     } else if (n == 34) {
-        return gdb_get_regl(mem_buf, env->CSR_BADV);
+        val = env->CSR_BADV;
+    }
+
+    if (0 <= n && n <= 34) {
+        if (is_la64(env)) {
+            return gdb_get_reg64(mem_buf, val);
+        } else {
+            return gdb_get_reg32(mem_buf, val);
+        }
     }
     return 0;
 }
@@ -52,15 +61,24 @@ int loongarch_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
     CPULoongArchState *env = &cpu->env;
-    target_ulong tmp = ldtul_p(mem_buf);
+    target_ulong tmp;
+    int read_length;
     int length = 0;
 
+    if (is_la64(env)) {
+        tmp = ldq_p(mem_buf);
+        read_length = 8;
+    } else {
+        tmp = ldl_p(mem_buf);
+        read_length = 4;
+    }
+
     if (0 <= n && n < 32) {
         env->gpr[n] = tmp;
-        length = sizeof(target_ulong);
+        length = read_length;
     } else if (n == 33) {
         env->pc = tmp;
-        length = sizeof(target_ulong);
+        length = read_length;
     }
     return length;
 }
diff --git a/gdb-xml/loongarch-base32.xml b/gdb-xml/loongarch-base32.xml
new file mode 100644
index 0000000000..af47bbd3da
--- /dev/null
+++ b/gdb-xml/loongarch-base32.xml
@@ -0,0 +1,45 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2022 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.loongarch.base">
+  <reg name="r0" bitsize="32" type="uint32" group="general"/>
+  <reg name="r1" bitsize="32" type="code_ptr" group="general"/>
+  <reg name="r2" bitsize="32" type="data_ptr" group="general"/>
+  <reg name="r3" bitsize="32" type="data_ptr" group="general"/>
+  <reg name="r4" bitsize="32" type="uint32" group="general"/>
+  <reg name="r5" bitsize="32" type="uint32" group="general"/>
+  <reg name="r6" bitsize="32" type="uint32" group="general"/>
+  <reg name="r7" bitsize="32" type="uint32" group="general"/>
+  <reg name="r8" bitsize="32" type="uint32" group="general"/>
+  <reg name="r9" bitsize="32" type="uint32" group="general"/>
+  <reg name="r10" bitsize="32" type="uint32" group="general"/>
+  <reg name="r11" bitsize="32" type="uint32" group="general"/>
+  <reg name="r12" bitsize="32" type="uint32" group="general"/>
+  <reg name="r13" bitsize="32" type="uint32" group="general"/>
+  <reg name="r14" bitsize="32" type="uint32" group="general"/>
+  <reg name="r15" bitsize="32" type="uint32" group="general"/>
+  <reg name="r16" bitsize="32" type="uint32" group="general"/>
+  <reg name="r17" bitsize="32" type="uint32" group="general"/>
+  <reg name="r18" bitsize="32" type="uint32" group="general"/>
+  <reg name="r19" bitsize="32" type="uint32" group="general"/>
+  <reg name="r20" bitsize="32" type="uint32" group="general"/>
+  <reg name="r21" bitsize="32" type="uint32" group="general"/>
+  <reg name="r22" bitsize="32" type="data_ptr" group="general"/>
+  <reg name="r23" bitsize="32" type="uint32" group="general"/>
+  <reg name="r24" bitsize="32" type="uint32" group="general"/>
+  <reg name="r25" bitsize="32" type="uint32" group="general"/>
+  <reg name="r26" bitsize="32" type="uint32" group="general"/>
+  <reg name="r27" bitsize="32" type="uint32" group="general"/>
+  <reg name="r28" bitsize="32" type="uint32" group="general"/>
+  <reg name="r29" bitsize="32" type="uint32" group="general"/>
+  <reg name="r30" bitsize="32" type="uint32" group="general"/>
+  <reg name="r31" bitsize="32" type="uint32" group="general"/>
+  <reg name="orig_a0" bitsize="32" type="uint32" group="general"/>
+  <reg name="pc" bitsize="32" type="code_ptr" group="general"/>
+  <reg name="badv" bitsize="32" type="code_ptr" group="general"/>
+</feature>
-- 
2.41.0



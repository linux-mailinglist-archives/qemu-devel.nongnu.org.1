Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D61117D0E31
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 13:13:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtnQG-0007Gc-6d; Fri, 20 Oct 2023 07:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtnQ9-0007DB-LD
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 07:12:04 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtnQ7-0002ak-UP
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 07:12:01 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507bd644a96so941838e87.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 04:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697800318; x=1698405118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dKz6RVZSJf4qXCa2lKtHPOtLSVsJlJBrb9RFA879h2M=;
 b=sgHS3uTrI754IYwy/y5qPdrWANY+c52p+vbifdoOLzu23WyoRgkSER/xKTGcz6ySw1
 qGJzjIzBEy6/EQWSwsscaXeo7Ggp9eKCs3IP8Yl6uzuKgsVskR4BtqVuMrtOEotjx5E4
 W+zU7NveojfVGT46YcUQBiqGDkuCDUOQxZmXT9zJFTMrRNYomROwheFPVIfOhQunkm0N
 rHGOC9Vkh+GgbTSOL7SHl3dEHeKUs1SYgKcHsz1SGmirvFBAE34osQ/DAfn3T9ZDbXyo
 hzDvO8s1YEeYgk+GNIDu0GA0racPKFCupp4JD+JQwosIvlaHZMZ4snPOv5HXetTQ+74J
 zImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697800318; x=1698405118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dKz6RVZSJf4qXCa2lKtHPOtLSVsJlJBrb9RFA879h2M=;
 b=EfFXQEtXlYlcOkuiuIYk5u9kgmdfjkvM8l/mPxkugc4+WbEDbLlLrjRqy3PZzaqcJN
 TRMQFts9HGXaO0PgJom4GavKxrFq1GbiFnBoHfmw/oUt+SJ/vbz8pvg2oJjmH+fABqYs
 E0wwWSc8ZwrYE0fOurSqemZvhgzNIuzNxC97j5FrR+WuAxDmLgjoF0P+tU9BcVTFRHZA
 vAtn12QJ3IbovjXU1Br8CIQXyrqmJ9endJL1x2vpvAxgg2uiB/h6IxFF2uo3lKDsNDE0
 vcDZH65p0Hw5wbXVbmjL2HBlQpkbJ3dmoABe/dVyzEt5NpF9OpmHV8wJXVvKtd4ts/n9
 ZKYQ==
X-Gm-Message-State: AOJu0YyZ7VHrr8dTMkRX/tyvh4q+nLS1vbH2SndzjuSkr3nVDfCj+4nv
 1WDhMQd7ADfPUTJfmRJFWes8PlS01dJO1mLq1hU=
X-Google-Smtp-Source: AGHT+IHNLM9MIE9dmLCIwoICNvPyf4JrGzR6QfbWSDiHVe8pEbEX4mxFs0iqqH1vAgczLrKpCDoNwg==
X-Received: by 2002:ac2:5233:0:b0:506:899d:1994 with SMTP id
 i19-20020ac25233000000b00506899d1994mr977816lfl.52.1697800317978; 
 Fri, 20 Oct 2023 04:11:57 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 w10-20020adfec4a000000b0032d2f09d991sm1461745wrn.33.2023.10.20.04.11.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 04:11:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] target/i386/hvf: Rename 'X86CPU *x86_cpu' variable as
 'cpu'
Date: Fri, 20 Oct 2023 13:11:36 +0200
Message-ID: <20231020111136.44401-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020111136.44401-1-philmd@linaro.org>
References: <20231020111136.44401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

Follow the naming used by other files in target/i386/.

No functional changes.

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/hvf/x86_emu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 5b82e84778..3a3f0a50d0 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -665,7 +665,7 @@ static void exec_lods(CPUX86State *env, struct x86_decode *decode)
 
 void simulate_rdmsr(CPUX86State *env)
 {
-    X86CPU *x86_cpu = env_archcpu(env);
+    X86CPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
     uint32_t msr = ECX(env);
     uint64_t val = 0;
@@ -675,10 +675,10 @@ void simulate_rdmsr(CPUX86State *env)
         val = rdtscp() + rvmcs(cs->accel->fd, VMCS_TSC_OFFSET);
         break;
     case MSR_IA32_APICBASE:
-        val = cpu_get_apic_base(x86_cpu->apic_state);
+        val = cpu_get_apic_base(cpu->apic_state);
         break;
     case MSR_IA32_UCODE_REV:
-        val = x86_cpu->ucode_rev;
+        val = cpu->ucode_rev;
         break;
     case MSR_EFER:
         val = rvmcs(cs->accel->fd, VMCS_GUEST_IA32_EFER);
@@ -766,7 +766,7 @@ static void exec_rdmsr(CPUX86State *env, struct x86_decode *decode)
 
 void simulate_wrmsr(CPUX86State *env)
 {
-    X86CPU *x86_cpu = env_archcpu(env);
+    X86CPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
     uint32_t msr = ECX(env);
     uint64_t data = ((uint64_t)EDX(env) << 32) | EAX(env);
@@ -775,7 +775,7 @@ void simulate_wrmsr(CPUX86State *env)
     case MSR_IA32_TSC:
         break;
     case MSR_IA32_APICBASE:
-        cpu_set_apic_base(x86_cpu->apic_state, data);
+        cpu_set_apic_base(cpu->apic_state, data);
         break;
     case MSR_FSBASE:
         wvmcs(cs->accel->fd, VMCS_GUEST_FS_BASE, data);
@@ -1419,8 +1419,8 @@ static void init_cmd_handler()
 
 void load_regs(CPUState *cs)
 {
-    X86CPU *x86_cpu = X86_CPU(cs);
-    CPUX86State *env = &x86_cpu->env;
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
 
     int i = 0;
     RRX(env, R_EAX) = rreg(cs->accel->fd, HV_X86_RAX);
@@ -1442,8 +1442,8 @@ void load_regs(CPUState *cs)
 
 void store_regs(CPUState *cs)
 {
-    X86CPU *x86_cpu = X86_CPU(cs);
-    CPUX86State *env = &x86_cpu->env;
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
 
     int i = 0;
     wreg(cs->accel->fd, HV_X86_RAX, RAX(env));
-- 
2.41.0



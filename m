Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B307A4E33
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 18:08:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiGjl-0000na-2n; Mon, 18 Sep 2023 12:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGjh-0000TD-KR
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:04:33 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGjf-0004Na-Cg
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:04:33 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50300141a64so3659406e87.0
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 09:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695053069; x=1695657869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZP1Jq5UriapAIWJmFwmSYSQUUVqpdEGdHuUn9UNvH2c=;
 b=ZKLc/fxbpSXbO+PDkSIWvR+8G/jSlAt0bM/Ebv9SVCilWsrxXEanHEjgSt2WaHmhfN
 9g/u6aE1ruuDI+QSCJxWhUBVnMLkCu4ortTppx0/LSAa0lZ3GUOungu1DALAMip18V5I
 BQo5aVf4fasV5WO1nmDt9Isn+Yeo76T1x8twn4mOTdOm1incJyl9KRpNBYfaj9OlPhXY
 e/+KjtmnKW8D8oNLDi5LWJ0cMSH3wCH7n7NnOvdiFFkEqUdXf3XDqd4e7Rkv4SEL19kg
 RkwpFyoaC3pHnim7opBcr+KwXBTpMUYg/ckH1dy4OSwEhh42goeg8vML0YLM60YVfDD7
 C9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695053069; x=1695657869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZP1Jq5UriapAIWJmFwmSYSQUUVqpdEGdHuUn9UNvH2c=;
 b=hNqJ+AiZma/0CHpFxY+trIetxuZDr+2UDD6MPKST21vUgO5zc0Tn5RcM5TcjKSqBdr
 xyU9Xy8740Jky+fPE7JEc1MSP4z0nneC/JFiclNKClPc1Uq4gf55hwvU4cgZ/8PPdCJy
 ON7ws9U90cfw+V61xNJ/MqSHy7zihxkkOJnFWvaaoLs9gU/Bh9sA2viBbzP+Ajbi9cV+
 TQA5OUEfMDhx+EKOiL37HH923wAJ0kYZM5yg8sP9e6Yq5EBjR7DUE+W15b4x0ft743P6
 rdfsCMrvBXl8m9g+okayzJ8pgrQqIeGyKEuA6lil7c4uYL3oV/fsahDB0D6LzaoGDM4k
 4fLw==
X-Gm-Message-State: AOJu0Yw1U1/pjPWisjpFLlPejBiUSgGgGCfd0LJbXs9iQ5URTtJEJ9QL
 Un2/A+FRz4Ewvot0wDItQk3DdSr16kz3qgli4GJwfzn1
X-Google-Smtp-Source: AGHT+IHqyjalPcNFI3j/eC2mJhJCqyXLJDQU80ViEPpsSEn13nBGjwNzQvCpQXl9ahmUuhJ660k6zA==
X-Received: by 2002:a05:6512:31cd:b0:503:1722:bf3a with SMTP id
 j13-20020a05651231cd00b005031722bf3amr3370635lfe.1.1695053069418; 
 Mon, 18 Sep 2023 09:04:29 -0700 (PDT)
Received: from localhost.localdomain
 (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
 by smtp.gmail.com with ESMTPSA id
 ec31-20020a0564020d5f00b00530a9488623sm4149603edb.46.2023.09.18.09.04.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Sep 2023 09:04:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, David Hildenbrand <david@redhat.com>,
 Peter Xu <peterx@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Marek Vasut <marex@denx.de>, David Gibson <david@gibson.dropbear.id.au>,
 Brian Cain <bcain@quicinc.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Claudio Fontana <cfontana@suse.de>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-ppc@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alessandro Di Federico <ale@rev.ng>, Song Gao <gaosong@loongson.cn>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Chris Wulff <crwulff@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>,
 qemu-s390x@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Luc Michel <luc@lmichel.fr>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Bin Meng <bin.meng@windriver.com>, Stafford Horne <shorne@gmail.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 Michael Rolnik <mrolnik@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 17/22] target/i386: Extract verify_accel_features() from
 cpu_realize()
Date: Mon, 18 Sep 2023 18:02:50 +0200
Message-ID: <20230918160257.30127-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918160257.30127-1-philmd@linaro.org>
References: <20230918160257.30127-1-philmd@linaro.org>
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

When looking at the x86_cpu_realizefn() method, most of the
code run before the cpu_exec_realizefn() call checks whether
the requested CPU features are compatible with the requested
accelerator. Extract this code to a dedicated handler matching
our recently added CPUClass::verify_accel_features() handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.c | 62 +++++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d79797d963..2884733397 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7208,26 +7208,19 @@ static void x86_cpu_hyperv_realize(X86CPU *cpu)
     cpu->hyperv_limits[2] = 0;
 }
 
-static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
+/*
+ * note: the call to the framework needs to happen after feature expansion,
+ * but before the checks/modifications to ucode_rev, mwait, phys_bits.
+ * These may be set by the accel-specific code,
+ * and the results are subsequently checked / assumed in x86_cpu_realizefn().
+ */
+static bool x86_cpu_verify_accel_features(CPUState *cs, Error **errp)
 {
-    CPUState *cs = CPU(dev);
-    X86CPU *cpu = X86_CPU(dev);
-    X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
+    X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
     Error *local_err = NULL;
-    static bool ht_warned;
     unsigned requested_lbr_fmt;
 
-    /* Use pc-relative instructions in system-mode */
-#ifndef CONFIG_USER_ONLY
-    cs->tcg_cflags |= CF_PCREL;
-#endif
-
-    if (cpu->apic_id == UNASSIGNED_APIC_ID) {
-        error_setg(errp, "apic-id property was not initialized properly");
-        return;
-    }
-
     /*
      * Process Hyper-V enlightenments.
      * Note: this currently has to happen before the expansion of CPU features.
@@ -7236,7 +7229,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
     x86_cpu_expand_features(cpu, &local_err);
     if (local_err) {
-        goto out;
+        return false;
     }
 
     /*
@@ -7246,7 +7239,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     if (cpu->lbr_fmt != ~PERF_CAP_LBR_FMT) {
         if ((cpu->lbr_fmt & PERF_CAP_LBR_FMT) != cpu->lbr_fmt) {
             error_setg(errp, "invalid lbr-fmt");
-            return;
+            return false;
         }
         env->features[FEAT_PERF_CAPABILITIES] &= ~PERF_CAP_LBR_FMT;
         env->features[FEAT_PERF_CAPABILITIES] |= cpu->lbr_fmt;
@@ -7265,13 +7258,13 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
         if (!cpu->enable_pmu) {
             error_setg(errp, "vPMU: LBR is unsupported without pmu=on");
-            return;
+            return false;
         }
         if (requested_lbr_fmt != host_lbr_fmt) {
             error_setg(errp, "vPMU: the lbr-fmt value (0x%x) does not match "
                         "the host value (0x%x).",
                         requested_lbr_fmt, host_lbr_fmt);
-            return;
+            return false;
         }
     }
 
@@ -7282,7 +7275,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
                    accel_uses_host_cpuid() ?
                        "Host doesn't support requested features" :
                        "TCG doesn't support requested features");
-        goto out;
+        return false;
     }
 
     /* On AMD CPUs, some CPUID[8000_0001].EDX bits must match the bits on
@@ -7296,12 +7289,28 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
     x86_cpu_set_sgxlepubkeyhash(env);
 
-    /*
-     * note: the call to the framework needs to happen after feature expansion,
-     * but before the checks/modifications to ucode_rev, mwait, phys_bits.
-     * These may be set by the accel-specific code,
-     * and the results are subsequently checked / assumed in this function.
-     */
+    return true;
+}
+
+static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
+{
+    CPUState *cs = CPU(dev);
+    X86CPU *cpu = X86_CPU(dev);
+    X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
+    CPUX86State *env = &cpu->env;
+    Error *local_err = NULL;
+    static bool ht_warned;
+
+    /* Use pc-relative instructions in system-mode */
+#ifndef CONFIG_USER_ONLY
+    cs->tcg_cflags |= CF_PCREL;
+#endif
+
+    if (cpu->apic_id == UNASSIGNED_APIC_ID) {
+        error_setg(errp, "apic-id property was not initialized properly");
+        return;
+    }
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -7950,6 +7959,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = x86_cpu_class_by_name;
     cc->parse_features = x86_cpu_parse_featurestr;
+    cc->verify_accel_features = x86_cpu_verify_accel_features;
     cc->has_work = x86_cpu_has_work;
     cc->dump_state = x86_cpu_dump_state;
     cc->set_pc = x86_cpu_set_pc;
-- 
2.41.0



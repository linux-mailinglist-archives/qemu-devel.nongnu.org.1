Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3BD7A4E4C
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 18:10:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiGjk-0000gk-2C; Mon, 18 Sep 2023 12:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGjc-0008OA-46
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:04:28 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGjZ-0004MG-T0
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:04:27 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9ad8bba8125so619449966b.3
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 09:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695053064; x=1695657864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s5SThQE8VrEigaiBVVD1aPn+S9Eqq7fLgyN+q+7eopw=;
 b=iN3Zjls1wmhzBLJG3Osd6MYLOiBOmzWia6GDdHQDWIuLhxbH38pKbhfYlhljmS80HY
 T4zv0c869UyNBAuMeQa63lgwkWjovHlQvWdTrFyzv1kJKK9EwhaGdcx1gYFX5goPOmpl
 fdHq8TLPrYt7JVYvreBsMBli0MVv9n8ncjppXU8kVK2NZvi149SdO+JiFAsMcseBRjnE
 F4BewZrCG5+V08g3A2Pww6b1ZPgWHNPuxl5d765ilVlRqZG5SsDBgMaOdOklBBYe+Dkf
 d8+krUQdz6butreujCzQgCuLi1gwnHGMsHhPV1Ie2+5ee7G9Q1gpqTYgODRGDphrmWL6
 4HWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695053064; x=1695657864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s5SThQE8VrEigaiBVVD1aPn+S9Eqq7fLgyN+q+7eopw=;
 b=UyZhM77Hs9HArb6H8x3K6QXyz/T2Nce2vpnWRsvUvRvwXgFAEuYqVX4r/YgXrX/DVj
 nzJAE0EssMwyCdD04w5Krk8pzIAdvehpWaycjQRwtUG34xrKjE4Tt5aLeJYCpAyEPoOR
 M4uYyx4q0y9t4RnT4wRe5QPKX0FFjf13j9ecYSmFjb3QJAZdVF5UABi9y827taCdYMQs
 R1QeV1cGsAkPYp4ZgFcNbqCYFlhrLPYAHUb6cNIdJBtXiFe28xyrMpMvj0v/erIlDjo6
 secBl59l+DfVG7MjTwu21KX1aGrF95gfLZ3h+kFlEwe1sHBiEiUrxfw35WLcmqw1QKOC
 tlyw==
X-Gm-Message-State: AOJu0YzKqEGa90I88KQxFr0Zs2Bt5Vg9778S2Eo9YE5ld06bbDi2f9yC
 lD93n2X6/LJTnSLZgWntRHkK5t8jtKj+NhI43aAGxI1L
X-Google-Smtp-Source: AGHT+IFdhAv8NMQe3eDFfz6fXbmFXmpOAUlZ51p/ozjG+nSdvaZT7LZnHlxk4GI+z0N+RInhKW7YXQ==
X-Received: by 2002:a17:906:768f:b0:9ad:fb23:21cf with SMTP id
 o15-20020a170906768f00b009adfb2321cfmr4715553ejm.15.1695053064161; 
 Mon, 18 Sep 2023 09:04:24 -0700 (PDT)
Received: from localhost.localdomain
 (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
 by smtp.gmail.com with ESMTPSA id
 c26-20020a170906341a00b00993470682e5sm6646928ejb.32.2023.09.18.09.04.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Sep 2023 09:04:23 -0700 (PDT)
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
Subject: [PATCH 16/22] target/arm: Extract verify_accel_features() from
 cpu_realize()
Date: Mon, 18 Sep 2023 18:02:49 +0200
Message-ID: <20230918160257.30127-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918160257.30127-1-philmd@linaro.org>
References: <20230918160257.30127-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When looking at the arm_cpu_realizefn() method, most of the
code run before the cpu_exec_realizefn() call checks whether
the requested CPU features are compatible with the requested
accelerator. Extract this code to a dedicated handler matching
our recently added CPUClass::verify_accel_features() handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 46d3f70d63..a551383fd3 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1675,19 +1675,10 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
     }
 }
 
-static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
+static bool arm_cpu_verify_accel_features(CPUState *cs, Error **errp)
 {
-    CPUState *cs = CPU(dev);
-    ARMCPU *cpu = ARM_CPU(dev);
-    ARMCPUClass *acc = ARM_CPU_GET_CLASS(dev);
+    ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
-    int pagebits;
-    Error *local_err = NULL;
-
-    /* Use pc-relative instructions in system-mode */
-#ifndef CONFIG_USER_ONLY
-    cs->tcg_cflags |= CF_PCREL;
-#endif
 
     /* If we needed to query the host kernel for the CPU features
      * then it's possible that might have failed in the initfn, but
@@ -1699,10 +1690,13 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         } else {
             error_setg(errp, "Failed to retrieve host CPU features");
         }
-        return;
+        return false;
     }
 
 #ifndef CONFIG_USER_ONLY
+    /* Use pc-relative instructions in system-mode */
+    cs->tcg_cflags |= CF_PCREL;
+
     /* The NVIC and M-profile CPU are two halves of a single piece of
      * hardware; trying to use one without the other is a command line
      * error and will result in segfaults if not caught here.
@@ -1710,12 +1704,12 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     if (arm_feature(env, ARM_FEATURE_M)) {
         if (!env->nvic) {
             error_setg(errp, "This board cannot be used with Cortex-M CPUs");
-            return;
+            return false;
         }
     } else {
         if (env->nvic) {
             error_setg(errp, "This board can only be used with Cortex-M CPUs");
-            return;
+            return false;
         }
     }
 
@@ -1733,23 +1727,35 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
             error_setg(errp,
                        "Cannot enable %s when using an M-profile guest CPU",
                        current_accel_name());
-            return;
+            return false;
         }
         if (cpu->has_el3) {
             error_setg(errp,
                        "Cannot enable %s when guest CPU has EL3 enabled",
                        current_accel_name());
-            return;
+            return false;
         }
         if (cpu->tag_memory) {
             error_setg(errp,
                        "Cannot enable %s when guest CPUs has MTE enabled",
                        current_accel_name());
-            return;
+            return false;
         }
     }
 #endif
 
+    return true;
+}
+
+static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
+{
+    CPUState *cs = CPU(dev);
+    ARMCPU *cpu = ARM_CPU(dev);
+    ARMCPUClass *acc = ARM_CPU_GET_CLASS(dev);
+    CPUARMState *env = &cpu->env;
+    int pagebits;
+    Error *local_err = NULL;
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -2383,6 +2389,7 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
                                        &acc->parent_phases);
 
     cc->class_by_name = arm_cpu_class_by_name;
+    cc->verify_accel_features = arm_cpu_verify_accel_features;
     cc->has_work = arm_cpu_has_work;
     cc->dump_state = arm_cpu_dump_state;
     cc->set_pc = arm_cpu_set_pc;
-- 
2.41.0



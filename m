Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E65CE7D1F4D
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 22:07:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quIEL-0004cB-R2; Sat, 21 Oct 2023 16:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1quIEH-0004U7-Mh
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 16:05:49 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1quIEF-0006r1-TF
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 16:05:49 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-523100882f2so2817425a12.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 13:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1697918745; x=1698523545;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ovMG+qqsPp4n1CFPMcT1aXFMbGSaoM4oGxF97m1LS7I=;
 b=I4//VssykApD8OGPHsDF5V9ygvSIzZ2vsyFqvWx3fBts0OgsUfMNOlgQdXQKHGywjl
 K+ktLoS8Gg8z3mjVFZNjakbt0UHtoPgIv6kgVYkogNBfxa8p1fu/HjnRuzSN92cAJzI2
 Qd1nR6FUjCAnvI0W4XYM/CdUJWxkTycZE7GsMocY8Sw6YVtSjOBoUvFhiPgkUCx5zCsG
 OdhjxljFD2nQoslYUR7SGhWNEwkZ2UDiV9AkrEee7GSfFZgGGQx518UzLl6fz+kWgjUv
 JjwwidptuDwCZ86u8lspLNuYIVvHB11FHkcoBAuhyexqt06DJAPnXREXSYJogHcSLMBG
 O8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697918745; x=1698523545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ovMG+qqsPp4n1CFPMcT1aXFMbGSaoM4oGxF97m1LS7I=;
 b=VqSo1nLNKa6f60KvFGqHRejpidMELORPl5fD1ODXl4b9DZR51fVhu5HUrxaiEFPLz8
 wkswTkUoz+60laj2YqUdLs2r/SX5SrCnE72Tu7s0P8MCtZD6+kD549JOwWbYC6W70sNi
 dP0WnhU40O//mpH7EuhQRmxL4PbfcFDXc+awEFPXa03MPkSgMU25u0xRQTJudDBQ4n+y
 E1QneKyNRMqpt63PcO6PJXyE//XesgyE3RDKWPJQuUWQyubYB6IvQejLa6bY+5f1p48e
 Y5SZx0VmLF9XHSa5py4S17KrB0VqE5Vd2BPtSK+XhmhrKOq9I1bu882ZTK7/RZjCB4gk
 bKuA==
X-Gm-Message-State: AOJu0Yy2Vm9C8GMhuXqzorRORMizJMUIoDTD25X4aWvtoJfivmGK/3zw
 5EHTzlI5A+x8gGKVejo5HvO866Sx0nQ82njLSfU=
X-Google-Smtp-Source: AGHT+IFn8ZuJ3zdT1j6mzl2J0I1SsOa+RLl8pKPzaYd++hf7VvzYs2WV+kTxeEgkxGFoXYq19Sy07A==
X-Received: by 2002:a17:907:318d:b0:9ae:6ad0:f6cd with SMTP id
 xe13-20020a170907318d00b009ae6ad0f6cdmr3799588ejb.24.1697918744975; 
 Sat, 21 Oct 2023 13:05:44 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-249.customer.bnet.at.
 [89.104.8.249]) by smtp.gmail.com with ESMTPSA id
 u2-20020a17090617c200b0098ce63e36e9sm4138253eje.16.2023.10.21.13.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 13:05:44 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, roman@roolebo.dev, pbonzini@redhat.com,
 lists@philjordan.eu, phil@philjordan.eu
Subject: [PATCH v2 1/4] i386: hvf: Adds support for INVTSC cpuid bit
Date: Sat, 21 Oct 2023 22:05:15 +0200
Message-Id: <20231021200518.30125-2-phil@philjordan.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231021200518.30125-1-phil@philjordan.eu>
References: <20231021200518.30125-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::533;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x533.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

This patch adds the INVTSC bit to the Hypervisor.framework accelerator's
CPUID bit passthrough allow-list. Previously, specifying +invtsc in the CPU
configuration would fail with the following warning despite the host CPU
advertising the feature:

qemu-system-x86_64: warning: host doesn't support requested feature:
CPUID.80000007H:EDX.invtsc [bit 8]

x86 macOS itself relies on a fixed rate TSC for its own Mach absolute time
timestamp mechanism, so there's no reason we can't enable this bit for guests.
When the feature is enabled, a migration blocker is installed.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 target/i386/hvf/hvf.c       | 18 ++++++++++++++++++
 target/i386/hvf/x86_cpuid.c |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index cb2cd0b02f..43d64574ad 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -49,6 +49,8 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/memalign.h"
+#include "qapi/error.h"
+#include "migration/blocker.h"
 
 #include "sysemu/hvf.h"
 #include "sysemu/hvf_int.h"
@@ -74,6 +76,8 @@
 #include "qemu/accel.h"
 #include "target/i386/cpu.h"
 
+static Error *invtsc_mig_blocker;
+
 void vmx_update_tpr(CPUState *cpu)
 {
     /* TODO: need integrate APIC handling */
@@ -221,6 +225,8 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
     CPUX86State *env = &x86cpu->env;
+    Error *local_err = NULL;
+    int r;
     uint64_t reqCap;
 
     init_emu();
@@ -238,6 +244,18 @@ int hvf_arch_init_vcpu(CPUState *cpu)
         }
     }
 
+    if ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC) &&
+        invtsc_mig_blocker == NULL) {
+        error_setg(&invtsc_mig_blocker,
+                   "State blocked by non-migratable CPU device (invtsc flag)");
+        r = migrate_add_blocker(&invtsc_mig_blocker, &local_err);
+        if (r < 0) {
+            error_report_err(local_err);
+            return r;
+        }
+    }
+
+
     if (hv_vmx_read_capability(HV_VMX_CAP_PINBASED,
         &hvf_state->hvf_caps->vmx_cap_pinbased)) {
         abort();
diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index 9380b90496..e56cd8411b 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -146,6 +146,10 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
                 CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_OSVW | CPUID_EXT3_XOP |
                 CPUID_EXT3_FMA4 | CPUID_EXT3_TBM;
         break;
+    case 0x80000007:
+        edx &= CPUID_APM_INVTSC;
+        eax = ebx = ecx = 0;
+        break;
     default:
         return 0;
     }
-- 
2.36.1



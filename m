Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 195C5AA8424
	for <lists+qemu-devel@lfdr.de>; Sun,  4 May 2025 07:35:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRvS-0002WV-Ss; Sun, 04 May 2025 01:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRvI-0002Ou-Qk
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:56 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRvG-0004Tr-UF
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:56 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so2802065b3a.2
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336593; x=1746941393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z/CSUL0IAfSicZGUxwfQSMF+CcpH0uxTg/tJpwo9blQ=;
 b=CEHGbXTsOzVA3ox+2otz3pbAPvc68Ei89+rJhY39sTWIcX0puF/Kud/AcJhrKYi6Gr
 FZoWv2MCwV+/FhQ1z7SmslWYcgBAw2fxMWV5QB6J+DexUwpCDMeLzaqulPz0SP6t88zD
 4FT/BG/RTU/1oCfhhpmyj+Uml17TbXRmiAA0xQUtV3kDDdh/yS3LRc4cB6LHowbpUVOh
 sqehcx1U1d9V8byUIeaHkebXbte/xRthvCNRHqzzhb7s9Shod2auNh1JsfyWYBiePQF4
 tSklaQcA7tvKuRkz100F50pszGm5xKMP/pIn5WW4pQa7QbY2+7v7iswBAkljXA41lj3R
 FJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336593; x=1746941393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z/CSUL0IAfSicZGUxwfQSMF+CcpH0uxTg/tJpwo9blQ=;
 b=dB9fBca5sBAopjL7vqaJxsmWBX6+Cxi5tN3TU0C8JU9uaxeeM2W2CBypYOr48jDLSQ
 tT5jgL9BGHvue/kL0GHA8GpCA2Om9mi9o12RFnBhMGGC6jF2MJ+9UTlNhKiIkLRUD9ZB
 7kJ+b0Z0ln6/cjQ2ifxIW4dB69PfokZsYDGeVcD4e9mfxAmQqFBMFV7g+WTDU0gyJ9hg
 Qx7IxjnOWCES7CWdWgLbOOozcUQdcnzNdEuPaOY/dCH77rSaoOzwHF0192nbkUafb45M
 bRovzOcnuMv/yv3cTpjWnPPgblQ1qCIBO2ep/vK2uNt03pRH9fmFTS6LTt7bxu5VoFb5
 M7HQ==
X-Gm-Message-State: AOJu0YwVuVzhuIx5QJ7BQvtSf9u50bd8ZJ+cYc4BnZbG2JaZN9VvJgwD
 p97ztXmE6+VX0WMDFaLn1WDGeu4mW2g/S3cBGVA1mHiGTo3MlT1G0uhjJbv0/RSs9rmD93lzc3a
 aajw=
X-Gm-Gg: ASbGncuSRjQ3USBgDbHkYYuD89xpXcUNIZlXcpNTK5OgIRCCnmFuwzInVSFijnC+ZPs
 /XWT8TmI938rVvmEsCnBGm1UKZ76tbsccihh6DSGeuq+LXAqMIOVr1//gACc5w1TJlx7Cqtz3N+
 KwhpKhYXDh4MHryQL/jsRzZDFXZV+apfYoIO/w0IJOaNrGRnnOKwwuqrDEPlNd59dLsa8JyG9mh
 n0G0iCndYecDEMGsXSLSMwi0hPxoS22nYDoI6jPZToLoq8Bo8jhc0+cvagGWcGZmIf/itSeltV2
 z1AGajvypPux+b0bAbm9R4F8uY4u49E8X3MIa5T6
X-Google-Smtp-Source: AGHT+IHywaMkGvwrUiu+pF63431wfSDN2JgGeySP4RmqHLBWsgAcUe/WGEW4xlqLjZ4SRwwgqz4yuQ==
X-Received: by 2002:a05:6a00:414a:b0:736:3ea8:4805 with SMTP id
 d2e1a72fcca58-7406f0aca49mr4036802b3a.7.1746336593306; 
 Sat, 03 May 2025 22:29:53 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 38/40] target/arm/machine: move cpu_post_load kvm bits to
 kvm_arm_cpu_post_load function
Date: Sat,  3 May 2025 22:29:12 -0700
Message-ID: <20250504052914.3525365-39-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm_arm.h |  4 +++-
 target/arm/kvm.c     | 13 ++++++++++++-
 target/arm/machine.c |  8 +-------
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index d156c790b66..00fc82db711 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -83,8 +83,10 @@ void kvm_arm_cpu_pre_save(ARMCPU *cpu);
  * @cpu: ARMCPU
  *
  * Called from cpu_post_load() to update KVM CPU state from the cpreg list.
+ *
+ * Returns: true on success, or false if write_list_to_kvmstate failed.
  */
-void kvm_arm_cpu_post_load(ARMCPU *cpu);
+bool kvm_arm_cpu_post_load(ARMCPU *cpu);
 
 /**
  * kvm_arm_reset_vcpu:
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8f68aa10298..8132f2345c5 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -977,13 +977,24 @@ void kvm_arm_cpu_pre_save(ARMCPU *cpu)
     }
 }
 
-void kvm_arm_cpu_post_load(ARMCPU *cpu)
+bool kvm_arm_cpu_post_load(ARMCPU *cpu)
 {
+    if (!write_list_to_kvmstate(cpu, KVM_PUT_FULL_STATE)) {
+        return false;
+    }
+    /* Note that it's OK for the TCG side not to know about
+     * every register in the list; KVM is authoritative if
+     * we're using it.
+     */
+    write_list_to_cpustate(cpu);
+
     /* KVM virtual time adjustment */
     if (cpu->kvm_adjvtime) {
         cpu->kvm_vtime = *kvm_arm_get_cpreg_ptr(cpu, KVM_REG_ARM_TIMER_CNT);
         cpu->kvm_vtime_dirty = true;
     }
+
+    return true;
 }
 
 void kvm_arm_reset_vcpu(ARMCPU *cpu)
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 868246a98c0..e442d485241 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -976,15 +976,9 @@ static int cpu_post_load(void *opaque, int version_id)
     }
 
     if (kvm_enabled()) {
-        if (!write_list_to_kvmstate(cpu, KVM_PUT_FULL_STATE)) {
+        if (!kvm_arm_cpu_post_load(cpu)) {
             return -1;
         }
-        /* Note that it's OK for the TCG side not to know about
-         * every register in the list; KVM is authoritative if
-         * we're using it.
-         */
-        write_list_to_cpustate(cpu);
-        kvm_arm_cpu_post_load(cpu);
     } else {
         if (!write_list_to_cpustate(cpu)) {
             return -1;
-- 
2.47.2



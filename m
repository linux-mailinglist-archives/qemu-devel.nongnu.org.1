Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94279791781
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:46:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8wn-0002hP-Kc; Mon, 04 Sep 2023 08:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8wB-0002BD-0D
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:44:16 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8w7-0004hR-2k
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:44:14 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so1969801a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693831449; x=1694436249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y1KRPJbXgs1nETBjJNmlr2PmeFCKIGRCFU9IErPdUTo=;
 b=PF/J7Sp+O9zlBr9zE9ws5fv2ICxnWGaVkVK+5CH0ZN3Dz551s2G4Su/82pgQcOoqlF
 jXM+303olIGV7R5bJTswxSGiMRmVt7eOq0VjJg12BtZqzpXYMfjO9TuUwwpBo0+WOK+P
 miNO8RNuV9pVkzmekniU8u2rIp/Rq7EMeCPad4+3O7yijGg+Dnh4KzQR1g1tFcyOMpFF
 faiPsq0Jafc3rL/zDfcj4I8EhDrn5jlbbpbjgfS3bq9kyYmtNEJWvVraeyEWpIVhMNij
 T2emOpYmWRy4BmP8nerdTBXFv7n/N/1j5kT1RKqgMohMJAENk1MSXKYkMZA7NAvyQ/lU
 4AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693831449; x=1694436249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y1KRPJbXgs1nETBjJNmlr2PmeFCKIGRCFU9IErPdUTo=;
 b=Y2kq631CNe/YnQmoUOuNffltpYTVsHj+ZxLdcyGlFCQywTmxLmWRhoJNAYg2eJWJSa
 VGwt3l2Hirw4dXwTKf6lI0RgJGl6uV2WFZLKDVVnbYaQ/5Kp6XBSg1F4dK3L+789Gtp0
 +jRTlXAXbYQyEcC1iTL0p3VO2juXkrCeOyYF8OzXDHMq+j8nCrFJplavVPJkkuNRgX3v
 fnUaP3ePPOmyCm7S8/eWgi3iXcPj7Gu5Mui3RTyUAtqkC6yd6HiG5z/ITkb3AXhgF06z
 saogign4G653iqsUtpCxnxGctI+Of9pXXY1yo2RgAouvyDphayLcK1Fv5kHMUfjSBbSq
 Z9XQ==
X-Gm-Message-State: AOJu0YxQejGMflLUhvS0OlbJSzvOWI5UjEmrdtloc81Fw26berowpv9o
 B34x8qzWU5zQGg4dyYSRv9SY5MCkN3yGcEhKioo=
X-Google-Smtp-Source: AGHT+IEWg2VEI4Vi7IulTZgNKdrHE2WZNrX8LJFTMhv1AYpEjEk8Q1zYIfhClVUZKE72XnRCdYjEhg==
X-Received: by 2002:a17:907:2c75:b0:9a1:d29c:6aa9 with SMTP id
 ib21-20020a1709072c7500b009a1d29c6aa9mr5782355ejc.11.1693831449576; 
 Mon, 04 Sep 2023 05:44:09 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 lt14-20020a170906fa8e00b00977eec7b7e8sm6153822ejb.68.2023.09.04.05.44.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 05:44:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 07/13] target/i386: Allow elision of kvm_enable_x2apic()
Date: Mon,  4 Sep 2023 14:43:18 +0200
Message-ID: <20230904124325.79040-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904124325.79040-1-philmd@linaro.org>
References: <20230904124325.79040-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

Call kvm_enabled() before kvm_enable_x2apic() to
let the compiler elide its call.

Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/intel_iommu.c      | 2 +-
 hw/i386/x86.c              | 2 +-
 target/i386/kvm/kvm-stub.c | 7 -------
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3ca71df369..c9961ef752 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4053,7 +4053,7 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
             error_setg(errp, "eim=on requires accel=kvm,kernel-irqchip=split");
             return false;
         }
-        if (!kvm_enable_x2apic()) {
+        if (kvm_enabled() && !kvm_enable_x2apic()) {
             error_setg(errp, "eim=on requires support on the KVM side"
                              "(X2APIC_API, first shipped in v4.7)");
             return false;
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index a88a126123..d2920af792 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -136,7 +136,7 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
      * With KVM's in-kernel lapic: only if X2APIC API is enabled.
      */
     if (x86ms->apic_id_limit > 255 && !xen_enabled() &&
-        (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())) {
+        kvm_enabled() && (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())) {
         error_report("current -smp configuration requires kernel "
                      "irqchip and X2APIC API support.");
         exit(EXIT_FAILURE);
diff --git a/target/i386/kvm/kvm-stub.c b/target/i386/kvm/kvm-stub.c
index f985d9a1d3..62cccebee4 100644
--- a/target/i386/kvm/kvm-stub.c
+++ b/target/i386/kvm/kvm-stub.c
@@ -12,13 +12,6 @@
 #include "qemu/osdep.h"
 #include "kvm_i386.h"
 
-#ifndef __OPTIMIZE__
-bool kvm_enable_x2apic(void)
-{
-    return false;
-}
-#endif
-
 bool kvm_hv_vpindex_settable(void)
 {
     return false;
-- 
2.41.0



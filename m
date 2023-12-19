Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66084819079
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:16:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfXC-00023h-Nk; Tue, 19 Dec 2023 14:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWz-0001yS-NB
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:33 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWw-0001ro-8z
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:29 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40c39e936b4so56217315e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013205; x=1703618005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u7RSwDz13+9sv6W+3QlIzSQPKzKTiI3ycp67owFhcNM=;
 b=gA5uj+lX9sLkqTI3YNNrGi64fk2YQ/9jDP1QBYootLkNsStg1ikhUilbkFOXE+Qqwe
 ZUOsSb+aqAPT1R0sFP1QWmNJBlD4lqTOovM3uQLjyhRjqmbYDyvpd5uscsj+wQ6anj32
 pPh0xfVbWFBNp+HcIN74sG7arMcXULuMVfgFh1nBs0bHSYlV6rEzzjvcxTqXysUNccGv
 4VmE7VLfhEjQbvvWnXJmphuDN1BaV0edrkKXspYOMRvro8XWuBsjVyV8hMqCSduCA5g5
 /7ekFOS2MjvDEWDifewRTUboLvVyIY6vaGWrrzsfdCtQsGf5NTGMXRFYAql2uiG/nwiK
 jdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013205; x=1703618005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u7RSwDz13+9sv6W+3QlIzSQPKzKTiI3ycp67owFhcNM=;
 b=r/5YU8xB+VNCTzKjGY+wSPQ12zEkFZD2BI4tV/1fmiOUfX8e38OAcHjUV0eMezvBCZ
 1kKoBlczzgkTefboCVFexNM9+tdNSw7Rqed+9xJlCyCkK7bsT7h0T4FFdrkEH8jPaUn+
 cWjC03qDsHfQAEASNLAUECV6tiHwNhe0i/xN9pW+1eavCCTB59tbJukRkZC8iP+6ZbNl
 JV/dnA54j4HY6HtzJiQhI6HYVdwrNfl5LuMNDJbck1ropnMBGCjMcye8pnaCB1CDiwR8
 v0IEBIz5eL8U9/laiz6izOiMMZNTNFEHbR3vJxLEwkj3+qt3NVyfGhhymcC904jNG/jO
 aHyQ==
X-Gm-Message-State: AOJu0YwQ8c/jl/ZYsToCNtC7xQN+8F/aKv4Qga81PNi8CtoWYw8f7Q4A
 dA76/MKbXPMByLRG360fa18I4vxPGDTY9ffCnt0=
X-Google-Smtp-Source: AGHT+IHZNn6/HaDsLqGPgMwa7K1LQ9FCrHo2foMkvozzOwSBF8Kvo5j05ahsAImOt8iaXHNdYxUxIA==
X-Received: by 2002:a05:600c:16c4:b0:40c:3133:6f02 with SMTP id
 l4-20020a05600c16c400b0040c31336f02mr5045282wmn.342.1703013204803; 
 Tue, 19 Dec 2023 11:13:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/43] target/arm/kvm: Have kvm_arm_vcpu_finalize take a ARMCPU
 argument
Date: Tue, 19 Dec 2023 19:12:56 +0000
Message-Id: <20231219191307.2895919-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Unify the "kvm_arm.h" API: All functions related to ARM vCPUs
take a ARMCPU* argument. Use the CPU() QOM cast macro When
calling the generic vCPU API from "sysemu/kvm.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-id: 20231123183518.64569-12-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 9540d3cb618..a2370bc5747 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -82,7 +82,7 @@ static int kvm_arm_vcpu_init(ARMCPU *cpu)
 
 /**
  * kvm_arm_vcpu_finalize:
- * @cs: CPUState
+ * @cpu: ARMCPU
  * @feature: feature to finalize
  *
  * Finalizes the configuration of the specified VCPU feature by
@@ -92,9 +92,9 @@ static int kvm_arm_vcpu_init(ARMCPU *cpu)
  *
  * Returns: 0 if success else < 0 error code
  */
-static int kvm_arm_vcpu_finalize(CPUState *cs, int feature)
+static int kvm_arm_vcpu_finalize(ARMCPU *cpu, int feature)
 {
-    return kvm_vcpu_ioctl(cs, KVM_ARM_VCPU_FINALIZE, &feature);
+    return kvm_vcpu_ioctl(CPU(cpu), KVM_ARM_VCPU_FINALIZE, &feature);
 }
 
 bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
@@ -1921,7 +1921,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         if (ret) {
             return ret;
         }
-        ret = kvm_arm_vcpu_finalize(cs, KVM_ARM_VCPU_SVE);
+        ret = kvm_arm_vcpu_finalize(cpu, KVM_ARM_VCPU_SVE);
         if (ret) {
             return ret;
         }
-- 
2.34.1



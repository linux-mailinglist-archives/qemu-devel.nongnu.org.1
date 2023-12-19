Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB2981907C
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:17:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfXO-0002L6-6e; Tue, 19 Dec 2023 14:13:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfX8-00022z-VT
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:39 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWt-0001qH-6N
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:38 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33666fb9318so2874765f8f.2
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013201; x=1703618001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d/ifw9z6r6bmX0fdH0IVqZ7YqgrTTUGMwKeFbCj1mN8=;
 b=lUHh8iXgSg0FZIk6wVxdPfVFJF9sUTGd0Jb0xjUNZFmXNxWkor2jSDZpew8fYTg6kO
 9M/xEgU42sagv4jQQJGIcQyd2c0ji8ntnbldFi5XwrtDBOOeEvxbq2Vhwx5uGFmx+j0x
 WK4J1u3OLeBChR4lXVi51ttDVtNLzFbEZ4R1HtFskeZOexBCWfDqlbwhhNr6EuVX8VLL
 Q2wamH/ie00wS5X3K6PT2w7XoD0MBm3dEemEJXk0rMrVMPjTJ7lwXKsxhYOj+WFXNOhN
 +0PRdym6BpU8PfWu+O2vcJDl8n+er67e21EfRffLYPFrxozIYXuFjRS5P9t4kjsqPJD1
 j5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013201; x=1703618001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d/ifw9z6r6bmX0fdH0IVqZ7YqgrTTUGMwKeFbCj1mN8=;
 b=Z64aF2pjbyhiKSa7tqHt0BSl/vzDvk8/TowhKWv8SSsWxYHur0uDC1bkzAmvksE5DA
 Yo42WFC7mKhWXtPyCqHF8SjrUbTRgAQUnzL1QgEtE1Yjw1IBT11uCpFAzSzvrD1XRL7x
 SdhL7oWJEkdyEYg0RL03HuSbLCh6V7bW/KEOy06U7WbnghcFqASj5RleKv4EPABNE169
 /REzrMHZ9pMkwU3IU8TI42ZB8Q695G6MoxV7P/NYUavRR0pDWiWc39LyWInNpgeV6lC8
 MJ9bYT4AA98oSPUinfFaY19XHRgfoMAqHJGgA0vlrqBUNc6cJPSYGD2EAvOSccJol1zf
 TJwg==
X-Gm-Message-State: AOJu0Yx4OhauN5cQYnut8SPv3h8jXlA2+SJKxKQVQz724ka3U74LSxYB
 E7zNXsKAWkUfDYQ6ikCg1IpN0avWw2/iZijYGe8=
X-Google-Smtp-Source: AGHT+IFgIrz/QiNB9uiDfy8HkVl4kbEuMVbU6wKiM4MBmw30L4D/z893FaazOueV+lKQHMxSuJMAlQ==
X-Received: by 2002:a05:6000:1d84:b0:336:1fcf:5aec with SMTP id
 bk4-20020a0560001d8400b003361fcf5aecmr10149644wrb.55.1703013200759; 
 Tue, 19 Dec 2023 11:13:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/43] target/arm/kvm: Have kvm_arm_sve_set_vls take a ARMCPU
 argument
Date: Tue, 19 Dec 2023 19:12:49 +0000
Message-Id: <20231219191307.2895919-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Message-id: 20231123183518.64569-5-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index e5a2596890b..e9c6e2e17c1 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1855,14 +1855,13 @@ uint32_t kvm_arm_sve_get_vls(CPUState *cs)
     return vls[0];
 }
 
-static int kvm_arm_sve_set_vls(CPUState *cs)
+static int kvm_arm_sve_set_vls(ARMCPU *cpu)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
     uint64_t vls[KVM_ARM64_SVE_VLS_WORDS] = { cpu->sve_vq.map };
 
     assert(cpu->sve_max_vq <= KVM_ARM64_SVE_VQ_MAX);
 
-    return kvm_set_one_reg(cs, KVM_REG_ARM64_SVE_VLS, &vls[0]);
+    return kvm_set_one_reg(CPU(cpu), KVM_REG_ARM64_SVE_VLS, &vls[0]);
 }
 
 #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
@@ -1919,7 +1918,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
 
     if (cpu_isar_feature(aa64_sve, cpu)) {
-        ret = kvm_arm_sve_set_vls(cs);
+        ret = kvm_arm_sve_set_vls(cpu);
         if (ret) {
             return ret;
         }
-- 
2.34.1



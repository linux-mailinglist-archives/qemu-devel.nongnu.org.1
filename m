Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CF47B7C0D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:26:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qny8M-0000VW-Od; Wed, 04 Oct 2023 05:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qny8K-0000OB-2w
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:25:32 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qny8E-0006aY-PT
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:25:28 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50437c618b4so2223131e87.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 02:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696411524; x=1697016324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ht6f+EI+Idu4pYIpXB1U3bVhNwTUfL0DoVlLTOdL73U=;
 b=wGYJ4FIocMYNM/joNKxw9WH0U8qOqdy9rz0+xlG9UjCLj6qQpLLRL4guMlVN54TmFb
 EkYa5poNu8DUkIhMZ6dAZWa4sViMW+/35kMg+Ep1gRmpLklgJq3YMelJmTGstSqkRVZg
 G2P1xLOA84PdL2N9NnFDtLMm5b9PaE7SkPNTd6NZTh9wksXig+FTCeKJyCdyZFHWH0rM
 xK0z1x2mV8Y0gYCSGhZFji8IFZUxQsGCcp462WPo1cqaZz2nQcLlfnd7xhk1qS96f7bA
 VX2/ZtcCTEQKYC/d7XzPH4Q+Pc2BAK4J9ZFb6CFQcbqIDiAypC5QXy+o0cxfwoMNQshz
 tGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696411524; x=1697016324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ht6f+EI+Idu4pYIpXB1U3bVhNwTUfL0DoVlLTOdL73U=;
 b=HHg3VgDN1p7AK04MAE3ocpkdl8BJzE+qEQlkp7eBxEHQc6vKcu2ulQmzPmBcdbycUj
 JJpTTF1jRRzuIw5vo00FOz2uoyppyTdghNdZoz3lNn6HHggTg0/PrgShROvpKvTvNEm9
 Z5g7x3jPXPpQyKEtMnvL1bINw7dtAxBP9PIvKxSuQoh0Ts9u30CytumCLRVg6nG4BSPP
 zv3guuwMdYInI5QbYtv4muOUjYnvGX7MK4FEZCNw2Q37ghY7/mFzTtXKv7uml35QgXMG
 bsINc+1+gLYvtxkeYONVO0NMugU4BbAF5TkPUhYMYluBIF+w/lSHTvJvTuG0+Qvm0N8c
 9Tug==
X-Gm-Message-State: AOJu0YxY/2Ms20AFMIUNc/3sr9H7rYHh4JL478UVYYC7uf2m5y1+6G6t
 lJJ5RD3yJ80Fa1htclWoPUuVpm+q4d/KYCLW+4c=
X-Google-Smtp-Source: AGHT+IE9Nzagqv8EpOaU9dnoJJfndbNVanEQItgTOi5VYUtWArFS+IehE9AVd4zQuH4A6NSCY23Wpg==
X-Received: by 2002:a05:6512:250c:b0:503:1b83:e352 with SMTP id
 be12-20020a056512250c00b005031b83e352mr1868328lfb.52.1696411524470; 
 Wed, 04 Oct 2023 02:25:24 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 v14-20020a05600c214e00b00401c595fcc7sm1021759wml.11.2023.10.04.02.25.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 02:25:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/2] sysemu/kvm: Restrict hvf_get_supported_cpuid() to x86
 targets
Date: Wed,  4 Oct 2023 11:25:09 +0200
Message-ID: <20231004092510.39498-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004092510.39498-1-philmd@linaro.org>
References: <20231004092510.39498-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

hvf_get_supported_cpuid() is only defined for x86 targets
(in target/i386/hvf/x86_cpuid.c).
Its declaration is pointless on all other targets.

All the calls to it in target/i386/cpu.c are guarded by
a call on hvf_enabled(), so are elided when HVF is not
built in. Therefore we can remove the unnecessary function
stub.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/hvf.h        | 3 ---
 target/i386/hvf/hvf-i386.h  | 2 ++
 target/i386/cpu.c           | 1 +
 target/i386/hvf/hvf-cpu.c   | 1 +
 target/i386/hvf/x86_cpuid.c | 1 +
 5 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 4037cd6a73..4a7c6af3a5 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -20,13 +20,10 @@
 #include "cpu.h"
 
 #ifdef CONFIG_HVF
-uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
-                                 int reg);
 extern bool hvf_allowed;
 #define hvf_enabled() (hvf_allowed)
 #else /* !CONFIG_HVF */
 #define hvf_enabled() 0
-#define hvf_get_supported_cpuid(func, idx, reg) 0
 #endif /* !CONFIG_HVF */
 
 #endif /* NEED_CPU_H */
diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
index 243bc111cc..e99c02cd4b 100644
--- a/target/i386/hvf/hvf-i386.h
+++ b/target/i386/hvf/hvf-i386.h
@@ -16,6 +16,8 @@
 #ifndef HVF_I386_H
 #define HVF_I386_H
 
+uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx, int reg);
+
 void hvf_handle_io(CPUArchState *, uint16_t, void *, int, int, int);
 
 /* Host specific functions */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ed72883bf3..5b620500ab 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -26,6 +26,7 @@
 #include "tcg/helper-tcg.h"
 #include "sysemu/reset.h"
 #include "sysemu/hvf.h"
+#include "hvf/hvf-i386.h"
 #include "kvm/kvm_i386.h"
 #include "sev.h"
 #include "qapi/error.h"
diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
index 333db59898..21c519be74 100644
--- a/target/i386/hvf/hvf-cpu.c
+++ b/target/i386/hvf/hvf-cpu.c
@@ -15,6 +15,7 @@
 #include "hw/boards.h"
 #include "sysemu/hvf.h"
 #include "hw/core/accel-cpu.h"
+#include "hvf-i386.h"
 
 static void hvf_cpu_max_instance_init(X86CPU *cpu)
 {
diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index 7323a7a94b..9380b90496 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -25,6 +25,7 @@
 #include "x86.h"
 #include "vmx.h"
 #include "sysemu/hvf.h"
+#include "hvf-i386.h"
 
 static bool xgetbv(uint32_t cpuid_ecx, uint32_t idx, uint64_t *xcr)
 {
-- 
2.41.0



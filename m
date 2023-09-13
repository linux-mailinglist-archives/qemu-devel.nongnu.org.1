Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0058579E3C4
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 11:31:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgMCg-0000zx-7u; Wed, 13 Sep 2023 05:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgMCc-0000zC-Iz
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:30:31 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgMCZ-0002DA-0R
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:30:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40037db2fe7so70555085e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 02:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694597425; x=1695202225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJ4BcJE7pBMWigDDKZYpQ7Lkem5BrBoGp2n7HRl4RO0=;
 b=Ot3baEvqjPo4C2g3L/m5n6VZIaJaEPuMcah+4LrhS8DqsI/8wpfwpk+DQBP7HRJN6y
 +DlyZ2G+XjERDL2NXiXVG127AajRNFs3tMqKiEamGmXqe58x0IEFc4zWRMvdQDUh4U8p
 ePvlMGqdvz5rPVF3ZA5+WEevGAz6hvsL6ORtEGsVaRq6w4HJAYPgpBoOeVmoKBUl5Mc/
 K06IVExntQ0aCKPO7ALtjoDd+/5LG0RqG3eBbLSfCwU9ciMc237KJEH5SIFOTjd0SOFJ
 F41BCn9Ln+bTfNLi1R1/DEuMa0BDav6kZqKtFPg1XHOnQq0RPv3t72DJ6L5BwRRoCyDO
 xS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694597425; x=1695202225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJ4BcJE7pBMWigDDKZYpQ7Lkem5BrBoGp2n7HRl4RO0=;
 b=C/WOF8WWGLsw0p+kDbkbUdzxLjw2VRghWzvRtK22WQABwcPGfwtUxEyRtrNz1ne8mW
 XwOW81YqFJh4bXbzZHiR/2l0PMAGPOZz5WgWo3/SjrTH56+Ij8MIOmR9vG9A9mGrOWnO
 j5P9OEWfvat0a5vRRqfoLP0+TvnelADTWYvu7z4NBUjjUtheanmd/y2VkUe7Q7v6xL+C
 2IhUBIRJzyScMsy8flr4mVmrXNxhllkjGp1ML5esz8ChfbvnLCV87oYBm5NRVPsPALS/
 FuIUXVz1EliaT6BWJKBOhcQDRL4Mv8oNlT0jlbVhEMLszXNtJnCpCXuMnAB2fho9v+gB
 wBrg==
X-Gm-Message-State: AOJu0YyQh1QrnEHP5ePwr7pk3qOkXugo0y/n8zpZWUU+XuJXXV4XFOEX
 HPX0KuyYLKdKGStvlj58SqoOrf3uvsz180HlVrg=
X-Google-Smtp-Source: AGHT+IFdROd97h4uzNRN61vFnZYaTWPh6qjyAOrmyyYqJyeWXB3VMK5YJssReCo2Y5Jy+veDjKYKRg==
X-Received: by 2002:a7b:c8d6:0:b0:402:8c7e:3fc4 with SMTP id
 f22-20020a7bc8d6000000b004028c7e3fc4mr1633611wml.30.1694597425050; 
 Wed, 13 Sep 2023 02:30:25 -0700 (PDT)
Received: from m1x-phil.lan (176-131-211-241.abo.bbox.fr. [176.131.211.241])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a05600c11ce00b003fee8502999sm1476159wmi.18.2023.09.13.02.30.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Sep 2023 02:30:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 2/6] target/i386: Drop accel_uses_host_cpuid before
 x86_cpu_get_supported_cpuid
Date: Wed, 13 Sep 2023 11:30:04 +0200
Message-ID: <20230913093009.83520-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913093009.83520-1-philmd@linaro.org>
References: <20230913093009.83520-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

x86_cpu_get_supported_cpuid() already checks for KVM/HVF
accelerators, so it is not needed to manually check it via
a call to accel_uses_host_cpuid() before calling it.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bd6a932d08..94b1ba0cf1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6207,7 +6207,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0xA:
         /* Architectural Performance Monitoring Leaf */
-        if (accel_uses_host_cpuid() && cpu->enable_pmu) {
+        if (cpu->enable_pmu) {
             x86_cpu_get_supported_cpuid(0xA, count, eax, ebx, ecx, edx);
         } else {
             *eax = 0;
@@ -6247,8 +6247,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *ebx &= 0xffff; /* The count doesn't need to be reliable. */
         break;
     case 0x1C:
-        if (accel_uses_host_cpuid() && cpu->enable_pmu &&
-            (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
+        if (cpu->enable_pmu && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
             x86_cpu_get_supported_cpuid(0x1C, 0, eax, ebx, ecx, edx);
             *edx = 0;
         }
@@ -6322,9 +6321,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             } else {
                 *ecx &= ~XSTATE_ARCH_LBR_MASK;
             }
-        } else if (count == 0xf &&
-                   accel_uses_host_cpuid() && cpu->enable_pmu &&
-                   (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
+        } else if (count == 0xf && cpu->enable_pmu
+                   && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
             x86_cpu_get_supported_cpuid(0xD, count, eax, ebx, ecx, edx);
         } else if (count < ARRAY_SIZE(x86_ext_save_areas)) {
             const ExtSaveArea *esa = &x86_ext_save_areas[count];
-- 
2.41.0



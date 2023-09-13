Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D48F379E7A0
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 14:10:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgOfw-0000mZ-Rs; Wed, 13 Sep 2023 08:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qgOfe-0000fE-KK
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:08:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qgOfa-0002XV-5b
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694606910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9C5AefYQjmcOrbVMvLJ5+TEGEUahAOHdAuWdhroUX3Q=;
 b=gVMTRgQFMK+ai8b2xQ3gxne2/3x8QOHPM3ZF2jCr/LEIKf6+urcsV5d9fT8Uw43lxhANCv
 f5rdbZlPVtAoxwh58gkbzPSsrs0rEQQtxdoxiUEm8IQgGGwD0aAooJi9BRj0aQVHGmH/Fr
 0hDIYpL8kSxDWxjews8JObcvwiwp2Kk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-hRgzP1OmNseWt4PREP5aqA-1; Wed, 13 Sep 2023 08:08:29 -0400
X-MC-Unique: hRgzP1OmNseWt4PREP5aqA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31f3233861aso4871509f8f.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 05:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694606907; x=1695211707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9C5AefYQjmcOrbVMvLJ5+TEGEUahAOHdAuWdhroUX3Q=;
 b=L1qhPiHcEjCf91Fc3hZ9mKN7HMxcLGxsdS15EwiGNvsBo0iWwFY9lnirahNnJQhJm2
 zPQffnqqXgGxsao894KyyPxlA2SHt4yki1f5DERKS/wK42YaH+iUpvs7JswVxdMJCdPf
 EJdTDZwWGvqUUl7iuZl4L1u/RRECMZhI14eve9xwwWsY7L0Yv7Xf8oEvz59AmqqQSGAh
 4rZ+rBFgcPcUFPSuz1SO/CyqD2QYA1rL5iorTZzquEqjFNSBEw6x7vu9RDiMGNWs8wHs
 eRaV98y4NonkhUTKfFOjmz5J3jgl82deyqVgL/5ACSdS5A1DI+w5rJVyw7vPQOKpk8II
 wB3Q==
X-Gm-Message-State: AOJu0YzI4Zce5DBlviAKyljXF4MkNPPxuefoB91bKIXOJOrr9tasjaHw
 +kM1p4/H2PL3HFAKoErnwLmbZ5KTJwyUkV9p8v20aIjlMYu7k43hZFp//JphXawyLKOiVSqA9qb
 JJXgKkMAD7Vhx6UxMWFsAp2rjHnwz5zaBWIYUXlOTYBw9KTLpek5ArLpKQ8z+KNO4TmM+JXYcCi
 4=
X-Received: by 2002:a5d:6106:0:b0:319:731f:748c with SMTP id
 v6-20020a5d6106000000b00319731f748cmr1920814wrt.34.1694606907178; 
 Wed, 13 Sep 2023 05:08:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2aZZDBFhm9cT9EWibLwzUJ302SQrnwnEbSH60IODCi6JdM8Fl9bspOjtu38io7cAZ7v4bgg==
X-Received: by 2002:a5d:6106:0:b0:319:731f:748c with SMTP id
 v6-20020a5d6106000000b00319731f748cmr1920790wrt.34.1694606906775; 
 Wed, 13 Sep 2023 05:08:26 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a05600000cd00b0031ad2f9269dsm15341745wrx.40.2023.09.13.05.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 05:08:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/4] target/i386: Drop accel_uses_host_cpuid before
 x86_cpu_get_supported_cpuid
Date: Wed, 13 Sep 2023 14:08:19 +0200
Message-ID: <20230913120820.969262-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913120820.969262-1-pbonzini@redhat.com>
References: <20230913120820.969262-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

x86_cpu_get_supported_cpuid() already checks for KVM/HVF
accelerators, so it is not needed to manually check it via
a call to accel_uses_host_cpuid() before calling it.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230913093009.83520-3-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bd6a932d088..94b1ba0cf1a 100644
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



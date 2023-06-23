Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2E673B8A6
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 15:19:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgfM-0004YQ-Rd; Fri, 23 Jun 2023 09:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgfK-0004Xg-PV
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgfJ-0005bC-8h
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687526248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tJgCEvRIJfsZ4PHdwAsMys/JtM2LhLA5MowluJx/lzU=;
 b=Ysr+Hlh3VJGqtZwqk54e9TFI0fwZa0a14OTWW2nP3TbRjEMzj6d+NfeoSj98afm2PreD5w
 j6nMprCnxELZ3yQErH/n2/ZVRcdopxAtZaBIq2mWbjuq3NeraEBPS6VeLYae2odq/QOe+q
 5zqPhH1c0cKCo4pBQbJAoFh6oNyP9FA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-0nghi0HtPdWdihoyRR6Tpg-1; Fri, 23 Jun 2023 09:17:26 -0400
X-MC-Unique: 0nghi0HtPdWdihoyRR6Tpg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-978a991c3f5so46811266b.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 06:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687526245; x=1690118245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJgCEvRIJfsZ4PHdwAsMys/JtM2LhLA5MowluJx/lzU=;
 b=XjJBt7EXkhor1boH6odADSOQJz+AzqciTuKLBthEiPRe8cML4lDaSZYMtscKpJts1E
 UHudsPwaIHGQ0e07o/0FqbB7+hXCp1+EaiBQb3sNKvXbA867ANJ7eOKjjc1apVWFcFFC
 P/oAf9KJOVX80qoNwYDjzv5wEjEzKYaSidWtlPOVsNLHQoeYd61WQhk81EgaWDOhVCRD
 k56rVDNxRX8NFnI2Ozv3bR+yHppCZuzTOm5UjqxKd7zgtudCPaVRKVd5miAvnURPlh/6
 Swgpgb0SugBjaNDej9Nh3cGQS69968Q4HhdU79NNGk94p+h6kCx6ltvMUlTpdvBZ2ksH
 Qgqg==
X-Gm-Message-State: AC+VfDx0ZMpfQNhtT3LOlkue1KJNnw3aFs/ZhGJIeYa1KrbQ+WTy4KV5
 iDHT1ODHp07iARDvc3Ija4E7dXz8RYf2hXrRklF3K1z7aE0Kbaeo2WvJmNiBE4f/LN7lqXTqXn3
 Tq35qO0JZerBui8uJRhnfpHOdPyrDnJdCHJxiXsNYVC1jzsZv6VQfTXvpQT0UTYYpH1ulbxHmdU
 Q=
X-Received: by 2002:a17:907:3f18:b0:97d:ee91:df83 with SMTP id
 hq24-20020a1709073f1800b0097dee91df83mr22058705ejc.61.1687526245014; 
 Fri, 23 Jun 2023 06:17:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5jLXQRmIcHmeLlaaXL6VfTZbo7dm/ZLSNOJzMMZ+Vb2JtUMQjXZgEt6gy9NppRBEvnzo3iEw==
X-Received: by 2002:a17:907:3f18:b0:97d:ee91:df83 with SMTP id
 hq24-20020a1709073f1800b0097dee91df83mr22058692ejc.61.1687526244765; 
 Fri, 23 Jun 2023 06:17:24 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a1709063b4b00b0098d80adcc23sm835924ejf.113.2023.06.23.06.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 06:17:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 07/11] target/i386: Intel only supports SYSCALL/SYSRET in
 long mode
Date: Fri, 23 Jun 2023 15:17:07 +0200
Message-ID: <20230623131711.96775-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623131711.96775-1-pbonzini@redhat.com>
References: <20230623131711.96775-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c           | 4 ++++
 target/i386/tcg/translate.c | 9 ++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 695e01582bf..978d24b5ec7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6238,6 +6238,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                 *ecx |= 1 << 1;    /* CmpLegacy bit */
             }
         }
+        if (tcg_enabled() && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 &&
+            !(env->hflags & HF_LMA_MASK)) {
+            *edx &= ~CPUID_EXT2_SYSCALL;
+        }
         break;
     case 0x80000002:
     case 0x80000003:
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index b2e2dccb84f..ed4016f554b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -5692,7 +5692,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         break;
 #ifdef TARGET_X86_64
     case 0x105: /* syscall */
-        /* XXX: is it usable in real mode ? */
+        /* For Intel SYSCALL is only valid in long mode */
+        if (!LMA(s) && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1) {
+            goto illegal_op;
+        }
         gen_update_cc_op(s);
         gen_update_eip_cur(s);
         gen_helper_syscall(cpu_env, cur_insn_len_i32(s));
@@ -5702,6 +5705,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         gen_eob_worker(s, false, true);
         break;
     case 0x107: /* sysret */
+        /* For Intel SYSRET is only valid in long mode */
+        if (!LMA(s) && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1) {
+            goto illegal_op;
+        }
         if (!PE(s)) {
             gen_exception_gpf(s);
         } else {
-- 
2.41.0



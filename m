Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D07987BB630
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:16:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoimr-000815-Q1; Fri, 06 Oct 2023 07:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoimp-00080N-MI
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoimo-0000GN-5U
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VQp06QznhTp32bkj6DiTtyEnXwB982LrJKbC153Y+wQ=;
 b=EoxGSrat7xtx++hfBMJHwOB8WqdWCQ4pA92eGgryYxKwrRZhIeSiUvBdcy1Y2sYwNr/HtV
 4Hlsl/MoFrO/FqW/g0HkINnOPJ0TS3kdfPjDufphnsX/lML6ziWAIoZna25bw7QZzKUjKf
 MtEGWMKDzcy2oA7pKjKjqi8zaQAbnf4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-UYdrf6uUOE2GyqdLrFDD1w-1; Fri, 06 Oct 2023 07:14:23 -0400
X-MC-Unique: UYdrf6uUOE2GyqdLrFDD1w-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-99bcb13d8ddso174290766b.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590861; x=1697195661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VQp06QznhTp32bkj6DiTtyEnXwB982LrJKbC153Y+wQ=;
 b=McqSxFHw3/QQYdTKofWAk5ydxjJKpJIgpJuUQXBvSCpmRfqyUx6rY3P13MdGzwPP9P
 EaKVfrrM/Yn1qWOuVofQ35G7M/7cE3zkDfCuGIPAvTyR+x96qjBIIrz7CxOMimbyBQaV
 G90jVZEpEK85pIHuS1MmEJDi4Df2ZuSkLosTdxb+wokVPSk+ViXwX13l8O7rHjWHmMeI
 YLrYwCmeqbkr8FnvEtPx/abccbdLZzZ3fvkEdMElUFylnwjU9/gahsUR79kSjoYTapPe
 IgEjjMCl5fmwjzgFHkHWt4UBQZesXz56n5NKpsdhYodCtNAEHYtGqChr08oqIaCY7xY4
 CvqA==
X-Gm-Message-State: AOJu0YwcCucIR5VuRdRtqBV5T2WCkyZLQ4ot7PNXBTw+HPqhIU84BtOY
 dcSyzFdN3ZEcwcMdkM/T68Tfe3nVJn5gI/625T2raL4NhwjMTKrmTS1NB0f/wyF+EstL/aC3Pqr
 lJ4UNcf2FAh1qghiPJSYs+uJOV2CG41BlfP3v3rcpAT9o6KVgS5A/patFJUtw1/VNTvS+zPomlX
 k=
X-Received: by 2002:a17:906:4e:b0:9a2:16e2:353 with SMTP id
 14-20020a170906004e00b009a216e20353mr7406321ejg.6.1696590861448; 
 Fri, 06 Oct 2023 04:14:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDiYfX1DPAcIXt6/fGq8hksnDEk+6li+3QjAlGkKm0X6xDKo12dOmEy2e6KlIMfIWi0f2+8g==
X-Received: by 2002:a17:906:4e:b0:9a2:16e2:353 with SMTP id
 14-20020a170906004e00b009a216e20353mr7406304ejg.6.1696590861134; 
 Fri, 06 Oct 2023 04:14:21 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 u13-20020a1709060b0d00b009ad87d1be17sm2723239ejg.22.2023.10.06.04.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/26] target/i386: Check for USER_ONLY definition instead of
 SOFTMMU one
Date: Fri,  6 Oct 2023 13:13:50 +0200
Message-ID: <20231006111412.13130-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since we *might* have user emulation with softmmu,
replace the system emulation check by !user emulation one.

(target/ was cleaned from invalid CONFIG_SOFTMMU uses at
commit cab35c73be, but these files were merged few days
after, thus missed the cleanup.)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004082239.27251-1-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c             | 2 +-
 target/i386/tcg/misc_helper.c | 2 +-
 target/i386/tcg/translate.c   | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5b620500abf..3bcf7a3f904 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -719,7 +719,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_7_0_EBX_HLE
           CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM */
 
-#if defined CONFIG_SOFTMMU || defined CONFIG_LINUX
+#if !defined CONFIG_USER_ONLY || defined CONFIG_LINUX
 #define TCG_7_0_ECX_RDPID CPUID_7_0_ECX_RDPID
 #else
 #define TCG_7_0_ECX_RDPID 0
diff --git a/target/i386/tcg/misc_helper.c b/target/i386/tcg/misc_helper.c
index 868f36ab7f5..babff061864 100644
--- a/target/i386/tcg/misc_helper.c
+++ b/target/i386/tcg/misc_helper.c
@@ -134,7 +134,7 @@ void helper_wrpkru(CPUX86State *env, uint32_t ecx, uint64_t val)
 
 target_ulong HELPER(rdpid)(CPUX86State *env)
 {
-#if defined CONFIG_SOFTMMU
+#if !defined CONFIG_USER_ONLY
     return env->tsc_aux;
 #elif defined CONFIG_LINUX && defined CONFIG_GETCPU
     unsigned cpu, node;
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 72635b87d3c..aa4cdf45b4b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -178,10 +178,10 @@ typedef struct DisasContext {
 #else
 #define CODE64(S) (((S)->flags & HF_CS64_MASK) != 0)
 #endif
-#if defined(CONFIG_SOFTMMU) && !defined(TARGET_X86_64)
-#define LMA(S)    false
-#else
+#if defined(CONFIG_USER_ONLY) || defined(TARGET_X86_64)
 #define LMA(S)    (((S)->flags & HF_LMA_MASK) != 0)
+#else
+#define LMA(S)    false
 #endif
 
 #ifdef TARGET_X86_64
-- 
2.41.0



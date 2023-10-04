Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AA37B79EF
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:23:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnx9b-0004ba-GO; Wed, 04 Oct 2023 04:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnx9Z-0004b5-4Z
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:22:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnx9X-0001T7-E0
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:22:44 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4053c6f0db8so17345265e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696407761; x=1697012561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ulxJvNPaFsUpt1xwZlIqLy1G0lNEneBUvuubnQZmz1I=;
 b=pbuUwJRXDyXvsQZs+4VlKyXtZAPJ9Sb+FAdD8Le6GaKiAHb/hlnqWlFuLu8Uv56Q+x
 0dWQqn1uUCyVrkGu0OFO6XfbyXV5W6eWNhdyYfkVeXCiKHZbEqRPk8Tg5Atkn95lLq+r
 WxGKkyA/UoZmPBCggLNDV3mjxepBT0VplbFhqteh3S9t7bLAOazSZ4uY97ZKRtmWh8LF
 z8+D7UA/bxInWlyI5VFqnsVOSVhzHr/wwB4Zpfvmo7dDgr5ms+toAEFjtwkR4YllyE9M
 dNqSaV9Sx5j3RAlBU9ilCRHIsMkV+E5hijdLJpjP13evB+NslsSXwmenEuXhaMsrZRT+
 540w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696407761; x=1697012561;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ulxJvNPaFsUpt1xwZlIqLy1G0lNEneBUvuubnQZmz1I=;
 b=U52sHJ9H7qmaJku36nSyeEgG0pItDRjwo6mhUrGlJ1J5AhDLgQhbk3ZzjmoJ5kfGll
 /Z/wt0nImxVQD1/gvnL+bjbh/xb+Fa2ygT0pzdB9fCwAPTRmW+29BkUdWn56fCk4khZq
 A4nE0kSKc7zMa7gOXMSmadqmvHax2ttRqhYJa7rxoNJIPppxPhtDjrLWOzeLNd0m4VUW
 6mbVTB0TWNXy1Jcd9LAUGBQgORc6qg4UW+roF6E7wlVcCJJj0TLKRBZyqg7yhzIPJThX
 bsaaUJSJ7Yhl2NyQOaWPRAdtfF8hM30D6ifNWULXRQLcgLO5XeAz6u02/tYOewJqi+PP
 55eQ==
X-Gm-Message-State: AOJu0YxqtmFYfawJaC3i5UpVMmWVjmlz8D0Cbf/4bRKo88NQjZjgAzJ4
 ILp12jegpouNpFnigjzoPipPG/SEH7V4FQ8azs8=
X-Google-Smtp-Source: AGHT+IHXSLmvsCNGvtLSCU0Ifc6nikZPWU64nrnsKlm8Qn35OW3lU1HQdHdX/XvcOunAAZibDjMVhg==
X-Received: by 2002:a1c:7914:0:b0:401:1b58:72f7 with SMTP id
 l20-20020a1c7914000000b004011b5872f7mr1580704wme.38.1696407761581; 
 Wed, 04 Oct 2023 01:22:41 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 z3-20020a5d4d03000000b003232f167df5sm3393793wrt.108.2023.10.04.01.22.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 01:22:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/i386: Check for USER_ONLY definition instead of
 SOFTMMU one
Date: Wed,  4 Oct 2023 10:22:39 +0200
Message-ID: <20231004082239.27251-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Since we *might* have user emulation with softmmu,
replace the system emulation check by !user emulation one.

(target/ was cleaned from invalid CONFIG_SOFTMMU uses at
commit cab35c73be, but these files were merged few days
after, thus missed the cleanup.)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Ideally we'd restrict CONFIG_SOFTMMU to tcg meson source sets,
and #poison it for the rest of the code base.
---
 target/i386/cpu.c             | 2 +-
 target/i386/tcg/misc_helper.c | 2 +-
 target/i386/tcg/translate.c   | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ed72883bf3..af872c2f4b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -718,7 +718,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_7_0_EBX_HLE
           CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM */
 
-#if defined CONFIG_SOFTMMU || defined CONFIG_LINUX
+#if !defined CONFIG_USER_ONLY || defined CONFIG_LINUX
 #define TCG_7_0_ECX_RDPID CPUID_7_0_ECX_RDPID
 #else
 #define TCG_7_0_ECX_RDPID 0
diff --git a/target/i386/tcg/misc_helper.c b/target/i386/tcg/misc_helper.c
index 868f36ab7f..babff06186 100644
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
index 72635b87d3..aa4cdf45b4 100644
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



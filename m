Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B00AD79E3C2
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 11:31:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgMCs-0001FB-3B; Wed, 13 Sep 2023 05:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgMCq-0001Di-8U
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:30:44 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgMCm-0002JY-DE
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:30:43 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-402cc6b8bedso74613855e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 02:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694597437; x=1695202237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Qlz4UlYziPNq8F2NThvhMEsqE2XcvVN84mcny9xQ0s=;
 b=StI41PZpsGof1u6ic0imNlFMajuNiHlWROgMEep7VDj4TXwcRMamR5f4CGDKsJlTnw
 K5QKBYzQOuPl9Vja6/MeTf7CB1UhaiZZpeuqlFdlJzGAszxgvttC7Y+CaidTXECM5ePf
 Tceqrk7fK/Zh+Ts7jgT/cBgeGMxu689TpnWVwRrDHgzX7cljCH748yX9Qj1FAUuCc+4D
 84iMOtoC/V19K9k7PfBegkgSlM8NgZ+2hjFi6FKkdwx4JyKd5QztGPTOOiWYFy1/upv5
 un9BQ8Rt/58Fz9wOkSxGb6sDb6cTRAbBqjirdvAJNgwpC36baGeruxMT5DUAQUqytdjI
 xd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694597437; x=1695202237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Qlz4UlYziPNq8F2NThvhMEsqE2XcvVN84mcny9xQ0s=;
 b=YhOvbRKvfFq0EoPyKObcwKisaehwst5TjcCD8UsSrkQ2kugXF2xlNFdEfhZGsk/Sbj
 2p/yfQdUmavsHYSki6xUMVP+3kHg1X8HuAOKk1+jhzzCFtqg3V09O5ChJZtKUa5Mbak6
 TIhbx3XQZCP5QCbAqdJWLfLB7sevDLLMFdxJPAwjNM9C7xzI07VZfKYoF5dSciTIQ2QG
 0vLiD3uUtDprHbHIrVl/0La0RK8siSty5Xn8Ogpk8pE7rLpDOW2wrCDasYDQ+D3RjtTi
 JyYWrM/hA3wrKBgaaUgLnsu6r5HHiFfUABgCuaiU5pr2YRZLy/Em9MCXxrgS3WMD9265
 FWUQ==
X-Gm-Message-State: AOJu0Yzh7+TFFWXJp6zHlmlc7Zf0kB9qQxkRPrU4Tkh3ZUGEtFo5ir5d
 dRuKtDvToGjMN4nsIGfVgTYG3KBKBJHL8CwmAJg=
X-Google-Smtp-Source: AGHT+IEWpdoM+WDhrPjgODkxBAhlOnSq5m//vf86ss/9hM1maxstZ2t2i4/KaLoJUfi0o2DpthLKLQ==
X-Received: by 2002:a05:600c:1c89:b0:402:cf9f:c02d with SMTP id
 k9-20020a05600c1c8900b00402cf9fc02dmr1480014wms.8.1694597437459; 
 Wed, 13 Sep 2023 02:30:37 -0700 (PDT)
Received: from m1x-phil.lan (176-131-211-241.abo.bbox.fr. [176.131.211.241])
 by smtp.gmail.com with ESMTPSA id
 x20-20020a05600c2a5400b003fe601a7d46sm1452383wme.45.2023.09.13.02.30.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Sep 2023 02:30:37 -0700 (PDT)
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
Subject: [PATCH v5 4/6] target/i386: Move x86_cpu_get_migratable_flags() around
Date: Wed, 13 Sep 2023 11:30:06 +0200
Message-ID: <20230913093009.83520-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913093009.83520-1-philmd@linaro.org>
References: <20230913093009.83520-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

x86_cpu_get_migratable_flags() is only used once in
x86_cpu_get_supported_feature_word(). Move it the
code just before its caller, to reduce #ifdef'ry
in the next commit, when we restrict both functions
to system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b2a20365e1..3df85a6347 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1664,29 +1664,6 @@ static inline uint64_t x86_cpu_xsave_xss_components(X86CPU *cpu)
            cpu->env.features[FEAT_XSAVE_XSS_LO];
 }
 
-/*
- * Returns the set of feature flags that are supported and migratable by
- * QEMU, for a given FeatureWord.
- */
-static uint64_t x86_cpu_get_migratable_flags(FeatureWord w)
-{
-    FeatureWordInfo *wi = &feature_word_info[w];
-    uint64_t r = 0;
-    int i;
-
-    for (i = 0; i < 64; i++) {
-        uint64_t f = 1ULL << i;
-
-        /* If the feature name is known, it is implicitly considered migratable,
-         * unless it is explicitly set in unmigratable_flags */
-        if ((wi->migratable_flags & f) ||
-            (wi->feat_names[i] && !(wi->unmigratable_flags & f))) {
-            r |= f;
-        }
-    }
-    return r;
-}
-
 void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx)
 {
@@ -5679,6 +5656,29 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 
 #endif /* !CONFIG_USER_ONLY */
 
+/*
+ * Returns the set of feature flags that are supported and migratable by
+ * QEMU, for a given FeatureWord.
+ */
+static uint64_t x86_cpu_get_migratable_flags(FeatureWord w)
+{
+    FeatureWordInfo *wi = &feature_word_info[w];
+    uint64_t r = 0;
+    int i;
+
+    for (i = 0; i < 64; i++) {
+        uint64_t f = 1ULL << i;
+
+        /* If the feature name is known, it is implicitly considered migratable,
+         * unless it is explicitly set in unmigratable_flags */
+        if ((wi->migratable_flags & f) ||
+            (wi->feat_names[i] && !(wi->unmigratable_flags & f))) {
+            r |= f;
+        }
+    }
+    return r;
+}
+
 uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
                                             bool migratable_only)
 {
-- 
2.41.0



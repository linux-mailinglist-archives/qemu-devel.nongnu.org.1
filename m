Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A38B879AB78
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 23:14:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfoDs-0003dL-Ch; Mon, 11 Sep 2023 17:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfoDr-0003dB-77
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 17:13:31 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfoDp-0005Bv-01
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 17:13:30 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-991c786369cso653480066b.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 14:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694466807; x=1695071607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=krYgPPa35VQ/Pn0yOr01dbPDQetUwcBiBN86SxBA8xI=;
 b=DMmtUxDc4vdYzacIveds67u34/IpRIDo/8oqLJ4rntX5q3yUoDQdtUVmWmVbdQF4gJ
 11AbQPvobLU1+RwugK5iU3rTx9cR0oBcLposNprkuGqnBPwkRsbKJyC8DJSu7HNqYXLL
 4mInct+0A3iswXezTIkTAO1MQmjabcIgdhIH2w0iZAZggqQ4toSFO7J5E8H+yD8maMtO
 RBYE7iAybRjIcDXOZkAP1NEn58vuEJ4FYZRhweklYu3SIN7e5x+1mBXBjURE89lKF2eD
 r7A0b3QM/Sl/d2RwKTPr4KBlMBmx7350ZQSaq2t/Cf6BRBJJOCQLeVa5O0z0ZTcBoBIq
 syOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694466807; x=1695071607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=krYgPPa35VQ/Pn0yOr01dbPDQetUwcBiBN86SxBA8xI=;
 b=ZGpQn0Q60p/araBM9xR181vtpbUSOgc2UKItS6Sq5J4elI10q+T5Gopdy4v+zksQTY
 6j8t27MRzwyeSW0MVSb15aB7OgH2HDikvDR3dcvu9eHl/DNFoK706I9CyXf7rFMNZPM+
 +HlHbz+6xallfpFNC/Pg7dZ2h5AW2G762NN5X/4O1k+52xQQ5IkeTrPL6N7dz9DUEIlT
 y3eJqeIkHMJpNGy5WNYSkP9Ud58CJEC3IxqQdEoXM3nhpUudbM6bxdb0UWaU/zIlf8gb
 6yQSToeRcjXz8svD3nuEpNOVSu8MAIsU5hs5f5Z0QmEgnwDG69t3Hmvg0OzTZKOZsoHK
 XjUQ==
X-Gm-Message-State: AOJu0YyzNXSfv2ia0Gh/H5RSFfRmyM5TBDZwUXbz6LebfGZgsCX6pTJv
 22VsG2sv+yU6i6gufHDJ+0csUpIrKFHRq/NUA04=
X-Google-Smtp-Source: AGHT+IFb5xqfZhu6crzjkbBsTvKTmhmHOZhghmVtnzEZLh0+fZEAmQHgX4ItZFeAc78+suXTk4fGFg==
X-Received: by 2002:a17:906:749b:b0:9a5:852f:10bd with SMTP id
 e27-20020a170906749b00b009a5852f10bdmr8629126ejl.62.1694466807044; 
 Mon, 11 Sep 2023 14:13:27 -0700 (PDT)
Received: from m1x-phil.lan (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr.
 [176.171.221.76]) by smtp.gmail.com with ESMTPSA id
 gt34-20020a1709072da200b009ad8796a6aesm33004ejc.56.2023.09.11.14.13.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Sep 2023 14:13:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 1/3] target/i386: Check kvm_hyperv_expand_features() return
 value
Date: Mon, 11 Sep 2023 23:13:15 +0200
Message-ID: <20230911211317.28773-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911211317.28773-1-philmd@linaro.org>
References: <20230911211317.28773-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

Move kvm_hyperv_expand_features() call earlier (this will simplify
reviewing the next commit) and check its return value, since it can
fail.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 24ee67b42d..760428d4dc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7107,6 +7107,10 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
+    if (kvm_enabled() && !kvm_hyperv_expand_features(cpu, errp)) {
+        return;
+    }
+
     /* Set cpuid_*level* based on cpuid_min_*level, if not explicitly set */
     if (env->cpuid_level_func7 == UINT32_MAX) {
         env->cpuid_level_func7 = env->cpuid_min_level_func7;
@@ -7120,10 +7124,6 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
     if (env->cpuid_xlevel2 == UINT32_MAX) {
         env->cpuid_xlevel2 = env->cpuid_min_xlevel2;
     }
-
-    if (kvm_enabled()) {
-        kvm_hyperv_expand_features(cpu, errp);
-    }
 }
 
 /*
-- 
2.41.0



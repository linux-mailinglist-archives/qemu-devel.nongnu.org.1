Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C777BF4C8
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:51:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7Vc-0008Sc-9z; Tue, 10 Oct 2023 03:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq7VW-0008RR-AY
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:50:22 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq7VP-0004or-Io
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:50:21 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53d9f001b35so262087a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 00:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696924213; x=1697529013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f2NufxNzPZ9pUF8PsDHQZGBUjEuicTHUoNMeMj86XSo=;
 b=DcBXvfVQsQKMYcBa7ze5LXhmP9fzdc3TRtHMyEZiz0FwptqGcQr7ro5QHSIiI/5qKZ
 q+4QvDDLgMk5KVqO3bkOLl/4HnvHK6kcqQP9PQm5+0iPMydINr55hb0FKWb/ze9BV4TF
 lLdUG7qtbgsyVRMs3lxUd1cKpsHXIbqUDRvrSKYQhPURFaoh2Ki7K/YH6aSQ86Qttfjx
 20T3eafeZGG1xdqpgEvUDNOKL+MY1sSeJZMNLxRPMhQJw2PmHhzY9ji+PS1wzid6gEq1
 o2UCD8mSN2nDLKH6ueB+/uZcXq9jZayTju2QN9QUiztzaF7TNjs66FQKSUlX/O1l8dBH
 /U9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696924213; x=1697529013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f2NufxNzPZ9pUF8PsDHQZGBUjEuicTHUoNMeMj86XSo=;
 b=BzI5igO7/QMNzZDw9bvh4pPdYUqpc5WROYPxf605GZiUjQwSardfULsI8E0PhOP08x
 VKztnr7O6KNn7nQln8Zwh64JLaQWVVcAsJ6mL2q7S9sXOdi4BHhiwfBvQSHeg/IpzRsc
 9LMcZ49mWyYfLerQcmaZyBk4gtWEM7X9XpJ78ZoQ0epkbhXMq2iaRarJ3lzOCrdWzqHY
 SmrFetnhSwFMd+Nq7ACIJEbNW84k0aebob1XPra6vGidKElBuVfpnjgLc2L69HsOwF0l
 LrizADI42LbVTLWQ0BGm/DQL4iliDK889Pkl1LNw1UphAwhI0Z1i6G0c7rEYYQ0VQCS0
 uRMw==
X-Gm-Message-State: AOJu0Yxa1E4XQ6qGdJj30/1E08w/YM+SOcYCNUXshclfCld+lg8hsF9q
 stW6D99wVyHE327M4qSMaa2vFp6kEjVpKpmBnjnT+A==
X-Google-Smtp-Source: AGHT+IEg81lyQK+4P+iuRE5K/osIKaqgw2DTDRSNh7brZNSNguuQuf7Lsy24vNsO4ZymjcfJ2Qlqtg==
X-Received: by 2002:aa7:c746:0:b0:52a:38c3:1b49 with SMTP id
 c6-20020aa7c746000000b0052a38c31b49mr13446577eds.40.1696924213730; 
 Tue, 10 Oct 2023 00:50:13 -0700 (PDT)
Received: from m1x-phil.lan (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr.
 [176.172.113.148]) by smtp.gmail.com with ESMTPSA id
 ee48-20020a056402293000b0053120f313cbsm449545edb.39.2023.10.10.00.50.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Oct 2023 00:50:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 3/4] tests/libqtest: Introduce qtest_get_base_arch()
Date: Tue, 10 Oct 2023 09:49:51 +0200
Message-ID: <20231010074952.79165-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010074952.79165-1-philmd@linaro.org>
References: <20231010074952.79165-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

While qtest_get_arch() returns the target architecture name,
such "i386" or "x86_64", qtest_get_base_arch() return the
"base" (or real underlying) architecture, in this example
that is "x86".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/libqtest.h |  7 +++++++
 tests/qtest/libqtest.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 1e1b42241d..54071e74ec 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -654,6 +654,13 @@ bool qtest_big_endian(QTestState *s);
  */
 const char *qtest_get_arch(void);
 
+/**
+ * qtest_get_base_arch:
+ *
+ * Returns: The base architecture for the QEMU executable under test.
+ */
+const char *qtest_get_base_arch(void);
+
 /**
  * qtest_get_arch_bits:
  *
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index a643a6309c..51cc92af21 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -925,6 +925,34 @@ const char *qtest_get_arch(void)
     return end + 1;
 }
 
+const char *qtest_get_base_arch(void)
+{
+    static const struct {
+        const char *const arch;
+        const char *const base;
+    } basearch[] = {
+        { "aarch64", "arm" },
+        { "i386", "x86" },
+        { "loongarch64", "loongarch" },
+        { "mipsel", "mips" },
+        { "mips64", "mips" },
+        { "mips64el", "mips" },
+        { "ppc64", "ppc" },
+        { "riscv32", "riscv" },
+        { "riscv64", "riscv" },
+        { "sparc64", "sparc" },
+        { "x86_64", "x86" },
+    };
+    const char *arch = qtest_get_arch();
+
+    for (unsigned i = 0; i < ARRAY_SIZE(basearch); i++) {
+        if (!strcmp(arch, basearch[i].arch)) {
+            return basearch[i].base;
+        }
+    }
+    g_assert_not_reached();
+}
+
 unsigned qtest_get_arch_bits(void)
 {
     static const char *const arch64[] = {
-- 
2.41.0



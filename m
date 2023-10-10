Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C6C7BF4D5
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:51:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7VI-0008ME-Dp; Tue, 10 Oct 2023 03:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq7VF-0008KG-Sn
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:50:05 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq7VD-0004b5-CB
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:50:05 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9a6190af24aso926271466b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 00:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696924202; x=1697529002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xBzDwZo1XeWt7ItIGhOXUN3QV+md3tt2cNhSMxgmiwU=;
 b=GYfFz5KzggGrfArSJY6N1EwatuHdkl8siUccOQeAkJ9tbk3lenbRt2fkvO2SYwWUF3
 BAVcQ/AHYyIIVOzF2sSnFOT53rqYa/bEJPV0UL/AH4X/1R/ZkaBQdOmnjzTzr2wdv1Yg
 GrY+hdTlqFEKd9xPua/yJJqZf2Csz+KJmvonZpqyG/MqLXItbrWSVJxEMqy+VEIZ+lts
 195qtfbBFHuTFyFavkxUtjsIXF3SeGrayJ0Wx7NTojcZzM+psQMcS77f9iKQUEgefIrU
 0hD6Gf19yXcZPTitZCUJnxtWHq7B0CE4lneLA3I492crdA9TJrLIFRfZAwCo6Xg6DIpo
 64oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696924202; x=1697529002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xBzDwZo1XeWt7ItIGhOXUN3QV+md3tt2cNhSMxgmiwU=;
 b=rHKu4HUyD/rwzXUQF8+sxR94ypRxMy6Moz9xxbjV6A/CdKOqxYruxxAgMPdwZpHhKk
 Qsa6lIIs7SDuwe7YMfcfeddu0vxOmufTfl2eb5YnCqzPZNp37xaYpeSYQ7X210YbvMfa
 7LLO/EkymCX1Lwd1fGldv3iRZ9T/3voEZDd6a2TOfB2eRBCv4RMxs07b4OUGsAS76UOX
 192l+Ug8HEyalryoKgPYUwx85bsSEYM9dlI5IOS/SvLazuiSMiY3h5yIBOdqZCpnRRWN
 Y1EdvEpgvMdQv1h5lnhhvRVPZeNAyrthJyTJ9OYPfKgWzqZf9hI9NWFUux9VhEIuSxIt
 drTg==
X-Gm-Message-State: AOJu0YzVJVLXtVEqcAEJhdZzu9gigm/IqJOBZysxCp6D/YcukqG7oUNN
 IRXTQfAvNynX778VLpzZ5Hgntf8tbbECf5Am7B8ZUA==
X-Google-Smtp-Source: AGHT+IFQGorWt50yPZp6SZlf30MT4LJGbzbBrBk41keq9CJV1abUY1y/RVlMjL7hIVgZoMmgXiOLig==
X-Received: by 2002:a17:906:8455:b0:9ae:62ec:e897 with SMTP id
 e21-20020a170906845500b009ae62ece897mr15259871ejy.4.1696924201747; 
 Tue, 10 Oct 2023 00:50:01 -0700 (PDT)
Received: from m1x-phil.lan (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr.
 [176.172.113.148]) by smtp.gmail.com with ESMTPSA id
 a14-20020a17090680ce00b0099cb1a2cab0sm8012503ejx.28.2023.10.10.00.50.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Oct 2023 00:50:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 1/4] tests/libqtest: Introduce qtest_get_arch_bits()
Date: Tue, 10 Oct 2023 09:49:49 +0200
Message-ID: <20231010074952.79165-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010074952.79165-1-philmd@linaro.org>
References: <20231010074952.79165-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

Add a method to return the architecture bits (currently 8/32/64).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/libqtest.h |  8 ++++++++
 tests/qtest/libqtest.c | 21 +++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index e53e350e3a..1e1b42241d 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -654,6 +654,14 @@ bool qtest_big_endian(QTestState *s);
  */
 const char *qtest_get_arch(void);
 
+/**
+ * qtest_get_arch_bits:
+ *
+ * Returns: The architecture bits (a.k.a. word size) for the QEMU executable
+ * under test.
+ */
+unsigned qtest_get_arch_bits(void);
+
 /**
  * qtest_has_accel:
  * @accel_name: Accelerator name to check for.
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index b1eba71ffe..a643a6309c 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -925,6 +925,27 @@ const char *qtest_get_arch(void)
     return end + 1;
 }
 
+unsigned qtest_get_arch_bits(void)
+{
+    static const char *const arch64[] = {
+        "aarch64", "hppa", "x86_64", "loongarch64", "mips64",
+        "mips64el", "ppc64", "riscv64", "s390x", "sparc64",
+    };
+    const char *arch = qtest_get_arch();
+
+    if (!strcmp(arch, "avr")) {
+        return 8;
+    }
+
+    for (unsigned i = 0; i < ARRAY_SIZE(arch64); i++) {
+        if (!strcmp(arch, arch64[i])) {
+            return 64;
+        }
+    }
+
+    return 32;
+}
+
 bool qtest_has_accel(const char *accel_name)
 {
     if (g_str_equal(accel_name, "tcg")) {
-- 
2.41.0



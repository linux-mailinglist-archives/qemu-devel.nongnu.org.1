Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 500027F5052
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 20:13:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5s0b-0004BM-M3; Wed, 22 Nov 2023 13:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s0K-0004A3-1u
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:16 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s09-0004Yz-Sw
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:14 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c503da4fd6so996151fa.1
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 10:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700677862; x=1701282662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7103XOFxT5bJSMqrbJRnaAZtCqt8Oh3G3I/DOAsQEM=;
 b=XudJ9G9i3I3FSZCHQA6DVEod88neTJm5dbjN+lB3MnansF4zmSW7DdweYcwUnYHypc
 CoOvqM4jd4EjaxKeFhhCW2GRHB2/aWQFTntHwKCEwKOPUOsnMVLoL134zJmjHsAq4oFL
 Dw1P3hTnZuqvUIabYn0Jhzwk6evKhY0l5hx5Oy2RLQoA/UczR9cqoUb3i3ksNrxJYHSY
 ZnBnwXQaTz3oRPSvccFbKDKuqjUe5yNAfTrxSAuV1b6RZvFwMjFXgn5vk9vAr+qFCFuc
 NwV4mnj/JZYYcwU7XUaKRxLqi/zxu3NnGO7RAIly0tWd1xabcfv7HjPMIQhsXWhnSNOZ
 VT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700677862; x=1701282662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E7103XOFxT5bJSMqrbJRnaAZtCqt8Oh3G3I/DOAsQEM=;
 b=Qvho+TOsW60c+ZNOyGp1O8bnO0xpBCc5n7ZtTPM7kWCBHxth+0pORJ2TEbgs+tk0RW
 DAfVfNDOzZrcyz35AjHibF+SkhxbOjuQnMtOGp39RjJLb0UcfcjktpGCZiven8KhKMzd
 yWVNw0wGzF5PPRZry8zqob5fEuNQwyqEGfO3s127qzI47H/czAiUE7bHrfGZPeXu49kI
 M6RptCdihz3QzxAJaMEcVYaP4jy4ButFOAWiTKsk0iR6j2TRLOdEHUNscY9A4i7q9TMv
 +NoG+VfiZy4AlGY72x7EXf4FmKvYgzXu+/Mr53SWAmVp9Vj9rt2Z6PMZEGBwIMTzcE5h
 /J4g==
X-Gm-Message-State: AOJu0YzQ32cTLDoYFM2Pc/3bPXK2pOX7H1VYwP4ANGeGjQhoTAkWnYDp
 ZZsOuoSn5oJVddhBuYbgGIaMm3V7+zVBGUM3sJM=
X-Google-Smtp-Source: AGHT+IHIV10IErfFC07Es1yMjpQsHxoU13Fz1+eiamPARf56zp7ZGthltp+wH8DZLOe8g00EO/RHvQ==
X-Received: by 2002:a05:651c:21a:b0:2c8:7c22:97e2 with SMTP id
 y26-20020a05651c021a00b002c87c2297e2mr2064877ljn.45.1700677861838; 
 Wed, 22 Nov 2023 10:31:01 -0800 (PST)
Received: from m1x-phil.lan (pas38-h02-176-184-5-64.dsl.sta.abo.bbox.fr.
 [176.184.5.64]) by smtp.gmail.com with ESMTPSA id
 f3-20020a05600c43c300b003fc0505be19sm176312wmn.37.2023.11.22.10.31.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Nov 2023 10:31:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH-for-9.0 02/11] target/arm: Add target_aarch64_available()
 helper
Date: Wed, 22 Nov 2023 19:30:38 +0100
Message-ID: <20231122183048.17150-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231122183048.17150-1-philmd@linaro.org>
References: <20231122183048.17150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

We want to build HW models once, but don't want to
register types when all prerequisites are satisfied. Add
the target_aarch64_available() to know at runtime whether
TARGET_AARCH64 is built-in.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu-qom.h | 2 ++
 target/arm/cpu.c     | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index 02b914c876..bf6b3604ed 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -33,4 +33,6 @@ typedef struct AArch64CPUClass AArch64CPUClass;
 DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU,
                        TYPE_AARCH64_CPU)
 
+bool target_aarch64_available(void);
+
 #endif
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 25e9d2ae7b..1990c04089 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2548,3 +2548,12 @@ static void arm_cpu_register_types(void)
 }
 
 type_init(arm_cpu_register_types)
+
+bool target_aarch64_available(void)
+{
+#ifdef TARGET_AARCH64
+    return true;
+#else
+    return false;
+#endif
+}
-- 
2.41.0



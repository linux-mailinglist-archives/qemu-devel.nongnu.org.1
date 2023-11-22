Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEA67F4FA2
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 19:33:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5s0g-0004Ec-GW; Wed, 22 Nov 2023 13:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s0S-0004Bv-GJ
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:31 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s0D-0004ZV-U5
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:21 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-507a98517f3so21182e87.0
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 10:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700677867; x=1701282667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aGx5XygnULFFxHYgrgUAbmNY2b76PBI4xDcz2zCtY2c=;
 b=QyMYn8LcPHouMss7PKkuPerZ0IQ0UxBZKM79hwMoy+PJ1BwoOVgmu7Jl0KUoEmoU+X
 ekshtlgb5YaSaXBUvcndskveicFb6Rp3zs0P18UmPcF9opJ8rBLwdBrwYczFOQVWF5MQ
 vOqVZzExl+8L0azJSJY+xZVaxstV+2yD+YXcUcOp2X86Qfxo/E74w0/MGdTEAMguooWA
 N5UnPstwW/HAEp1OsEYhInRpyDM7mcfJeYpaTbcT9dWzFqnhjV6zj+bB1lb0E/IC9FyB
 rqDHDU9LtmgCn9ufCDOj7NhOL+E+15zZtFmJooigxCXp38HFzk4r4rWkp/rH9YbIiPW6
 4gTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700677867; x=1701282667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aGx5XygnULFFxHYgrgUAbmNY2b76PBI4xDcz2zCtY2c=;
 b=aWRxHLJWPRWvWPu91sGF/QYuqPzU6ihE90dj06HVSU/VEiKx6bYQD1kiOZJ4BcK6bh
 +c6yAX+EjnH/wJ19r9TtcazP7NioNi31/y43eu1/ODv3YjiXk+q1jDkFwYJtl7y7U2lf
 c1YSJuAJZwYJE5m9m7jlIiZzRI1ZYRWGrE6MwDXHFF6p6AqK3EK6qjtOw5omoujVCsFq
 +528aigHdS2kGZ9dkoL+2IxNfp6RKR6NneiVJWmbQsl1hW6q60d/l0fpCCJ4D1epGQQ1
 0llZJKGK3tuFQyIz8HVhI1BOgwNa9xVUFrFeEvwxS55U7X+wLadQQyLvI9CnTzkATRgY
 K/sA==
X-Gm-Message-State: AOJu0Yx1cZdlegpz8465KHE0gq6kE+sbhK4FjZJCfvp7WBrYjtCFgSwc
 4esMAPy69TKB0+k9BLrtl1003KGP5jQ0T55h+qY=
X-Google-Smtp-Source: AGHT+IGXiea0r3oI+ORFeqbb0Tw5S/xHce2rzUHHnseNrrpvUnoFaJ16nWaBmzGL7TIfeQ4Ggblq6g==
X-Received: by 2002:ac2:4a84:0:b0:507:9a49:2d3d with SMTP id
 l4-20020ac24a84000000b005079a492d3dmr2124262lfp.31.1700677867269; 
 Wed, 22 Nov 2023 10:31:07 -0800 (PST)
Received: from m1x-phil.lan (pas38-h02-176-184-5-64.dsl.sta.abo.bbox.fr.
 [176.184.5.64]) by smtp.gmail.com with ESMTPSA id
 dh10-20020a0560000a8a00b0032d8eecf901sm61377wrb.3.2023.11.22.10.31.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Nov 2023 10:31:06 -0800 (PST)
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
Subject: [PATCH-for-9.0 03/11] target/arm: Declare ARM_CPU_TYPE_NAME/SUFFIX in
 'cpu-qom.h'
Date: Wed, 22 Nov 2023 19:30:39 +0100
Message-ID: <20231122183048.17150-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231122183048.17150-1-philmd@linaro.org>
References: <20231122183048.17150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Missed in commit 2d56be5a29 ("target: Declare
FOO_CPU_TYPE_NAME/SUFFIX in 'cpu-qom.h'"). See
it for more details.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu-qom.h | 3 +++
 target/arm/cpu.h     | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index bf6b3604ed..be307037ff 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -33,6 +33,9 @@ typedef struct AArch64CPUClass AArch64CPUClass;
 DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU,
                        TYPE_AARCH64_CPU)
 
+#define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
+#define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
+
 bool target_aarch64_available(void);
 
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a0282e0d28..d369275827 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2834,8 +2834,6 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
 #define ARM_CPUID_TI915T      0x54029152
 #define ARM_CPUID_TI925T      0x54029252
 
-#define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
-#define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
 #define CPU_RESOLVING_TYPE TYPE_ARM_CPU
 
 #define TYPE_ARM_HOST_CPU "host-" TYPE_ARM_CPU
-- 
2.41.0



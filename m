Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FFF832033
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 21:08:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYg9-0004dJ-9b; Thu, 18 Jan 2024 15:07:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYg4-000498-6d
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:07:53 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYg2-000700-IT
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:07:51 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e60e135a7so307665e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 12:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705608469; x=1706213269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wzXk5yiY5MpA6wV2WpkIOyNiGD0qCuniPF02smOcXHA=;
 b=NQMxz9hGkxsZ2QGaC5LgCOV+I2h6LPffBqiN0NEEA0eGGq82mWPG29YkzVf05pJw8i
 sltT6dX/HdhVotU+U9hc3e/oyvJyZqXTphfohQ2u6VGoU9LzU17Qxr/80BP1rBOJzH8Q
 nXE/uWEwY38g/A+pP3ZRlYEm+8oZCeLrYnbmTZP9Sficw7Mulj4d+6gAqA6JuyTMvg1g
 WmLsFByuJi+WP2nwNtXCdpmbjQDCIGJK62vTWtRBX+B3VleHR3xr2tRv/gKY9PgPncyp
 p63l9UiljsSJvQk1VA4jBDq/urOIEen6r6hQjJQCwC4cIC0BTW28idBS089breCY3lJ9
 D6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705608469; x=1706213269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wzXk5yiY5MpA6wV2WpkIOyNiGD0qCuniPF02smOcXHA=;
 b=blgBNYuIQggZfxV1OS+loDK+m9Nmpk6jt0HEND1DqelJSB9/sluZbxXfIDVehy4ME4
 w0Q5HQ2+ywwcxOmCcFjpni/hlJ3HQWP2huTOg69T8T/xIjIzT3uvytmmBLi0WW7X4oK2
 4FwOYKcbHdOLUah/Byqf+OkWnQ7oWYk/DGLF7jujkByCXrFtZsinMr/VivhpU/TuBd5o
 zRvxuaed4DCPpEeyp0+fclAmMjuECRb2/vovDnRtjYipLPsjlP4X3OyUzjz/Y0FhCdpN
 q6hq3d0IKA59oXksaPHPddtRosU2FEQH8JAi79jNvxjRStbZiqQ4FHlsP7GrMh54v8cf
 6bYA==
X-Gm-Message-State: AOJu0YwaFv+bPfInh0Zl0mmAV7j+bEs7wUX5bzRiPfTDNsqmlwf7yE5I
 5wwjQutSB2Q378ofS2rJsgJRzgVz6mduc545zbQ6U4xfJPIRloqrFwQ2ElABPDm9/TmrFB+DHKv
 GXyk0aexv
X-Google-Smtp-Source: AGHT+IEp8Fqz9tymJZ6A+3yvqKGgKvpEkjLBs5M5134qAAIM06sEQbhoYAKYQgHskFvuYAdYPdlmpA==
X-Received: by 2002:adf:f191:0:b0:337:cef4:ae1e with SMTP id
 h17-20020adff191000000b00337cef4ae1emr909314wro.20.1705608469011; 
 Thu, 18 Jan 2024 12:07:49 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 o9-20020adfe809000000b00337bf81e06bsm4758039wrm.48.2024.01.18.12.07.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jan 2024 12:07:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Auger <eric.auger@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Rob Herring <robh@kernel.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Tyrone Ting <kfting@nuvoton.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Joel Stanley <joel@jms.id.au>, Hao Wu <wuhaotsh@google.com>,
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 11/20] target/arm: Declare ARM_CPU_TYPE_NAME/SUFFIX in
 'cpu-qom.h'
Date: Thu, 18 Jan 2024 21:06:32 +0100
Message-ID: <20240118200643.29037-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240118200643.29037-1-philmd@linaro.org>
References: <20240118200643.29037-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-qom.h | 3 +++
 target/arm/cpu.h     | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index 02b914c876..f795994135 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -33,4 +33,7 @@ typedef struct AArch64CPUClass AArch64CPUClass;
 DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU,
                        TYPE_AARCH64_CPU)
 
+#define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
+#define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
+
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cecac4c0a1..41659d0ef1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2837,8 +2837,6 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
 #define ARM_CPUID_TI915T      0x54029152
 #define ARM_CPUID_TI925T      0x54029252
 
-#define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
-#define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
 #define CPU_RESOLVING_TYPE TYPE_ARM_CPU
 
 #define TYPE_ARM_HOST_CPU "host-" TYPE_ARM_CPU
-- 
2.41.0



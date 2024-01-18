Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF06832038
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 21:08:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYge-0005iw-7G; Thu, 18 Jan 2024 15:08:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYgY-0005dz-CM
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:08:23 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYgV-00075v-Nf
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:08:22 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e586a62f7so244625e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 12:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705608498; x=1706213298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7i3W6cKZo6jUarGFVlLnFc+nsCmIDidPRgxq67roFM8=;
 b=pojMAryFBBS0LdPdUQ3Gh3tXrx0kXIY/lEMalqSe8o8dPTux04pvFHxWGInD0XvbC4
 /IFOeyEg98bHw6K++KFM3uQIflBcC74dQDsoP293f4mzS4eIvk7oNaLMak/5eueWH3RZ
 unaimRcXhoV2hXyJ8sVy+jMNqsHXwL9KJDjkepgA8rV1CwaSTrg9PT4uBdNi/PyAvviK
 56MCOjAUuxq3daJ6zAw3ZZN2GZp6tPJLGcVEj5b9mNDx6KLbehGdBHcZzWVIjgZZ3tmY
 BlLUdHR/jNoCCTglB4Y+7MPsqkemHSO6IvWLsNfVGVtJq1wTAZPswBOgmdHM1wc7o5IS
 isTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705608498; x=1706213298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7i3W6cKZo6jUarGFVlLnFc+nsCmIDidPRgxq67roFM8=;
 b=DA0Ly2kKtyKl3OD4/F7Y5tL1rzFyQvVOUmL+ExE8hrnER7Vpt69vqSmljvwGs8F56P
 49OW2DeI6rOpFD37YhS6c+IlFbafD1J8DQRlYwyG9Gz9mdamM8ahJVM+6BZBJwPhq5sf
 8F7uUYP6iCVf5u8ZggMp3qVEPCetkPeQUvW1uFC/5EGBVHWt5B883abHnMaRZxwWsVfP
 vsstn1syW9tQgWnRbGSVSd3HuMyIj4NGg/O0a+2mT6mpqN14Fv/DCf8j0X8Ji6MV0Uc+
 2mhBiqqLWmxeuvPjxLhLLDXZaYGqd5c2+KSiGy0noOqLP+WKhviRaCnyCbvuDgfemcmU
 fljw==
X-Gm-Message-State: AOJu0YxTZJ8wSTGKn0e79jcHW7/AFNL7LB7ffdLu3mX6E/dYsMUYK1S7
 jITpu+OYZPJWaMwfWjpohVkyWCCWwifc+L2Qp8f905GSzvASgKUbdNM+3tvUCTIn7TbRc5UYzcM
 WxtwcCfQI
X-Google-Smtp-Source: AGHT+IFoKd/89CskaiBLpvOHoHusNCnOu8tS11qS68UcjN3wO9IbW1+6ctvSRoHh+YJ/kkTBuD605w==
X-Received: by 2002:a05:600c:46ce:b0:40e:5feb:699d with SMTP id
 q14-20020a05600c46ce00b0040e5feb699dmr926186wmo.164.1705608498089; 
 Thu, 18 Jan 2024 12:08:18 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a5d69ce000000b00337478efa4fsm4783334wrw.60.2024.01.18.12.08.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jan 2024 12:08:17 -0800 (PST)
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
 kvm@vger.kernel.org
Subject: [PATCH 16/20] hw/arm/armv7m: Make 'hw/intc/armv7m_nvic.h' a target
 agnostic header
Date: Thu, 18 Jan 2024 21:06:37 +0100
Message-ID: <20240118200643.29037-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240118200643.29037-1-philmd@linaro.org>
References: <20240118200643.29037-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Now than we can access the M-profile bank index
definitions from the target-agnostic "cpu-qom.h"
header, we don't need the huge "cpu.h" anymore
(except in hw/arm/armv7m.c). Reduce its inclusion
to the source unit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/intc/armv7m_nvic.h | 2 +-
 hw/arm/armv7m.c               | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
index 6b4ae566c9..89fe8aedaa 100644
--- a/include/hw/intc/armv7m_nvic.h
+++ b/include/hw/intc/armv7m_nvic.h
@@ -10,7 +10,7 @@
 #ifndef HW_ARM_ARMV7M_NVIC_H
 #define HW_ARM_ARMV7M_NVIC_H
 
-#include "target/arm/cpu.h"
+#include "target/arm/cpu-qom.h"
 #include "hw/sysbus.h"
 #include "hw/timer/armv7m_systick.h"
 #include "qom/object.h"
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 1f21827773..edcd8adc74 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -21,6 +21,7 @@
 #include "qemu/module.h"
 #include "qemu/log.h"
 #include "target/arm/idau.h"
+#include "target/arm/cpu.h"
 #include "target/arm/cpu-features.h"
 #include "migration/vmstate.h"
 
-- 
2.41.0



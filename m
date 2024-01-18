Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6BA832046
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 21:09:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYgH-0005Hr-Qs; Thu, 18 Jan 2024 15:08:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYgF-0005BR-Mm
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:08:03 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYgD-00073O-Vo
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:08:03 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e800461baso231585e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 12:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705608480; x=1706213280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0rOeZxLobaeC+GA5Yjm4BlTG768XBMgHhLq69UHP94=;
 b=w69l6bmA/cVmFfsYvmbK6uTb73mAIsjn4cCaX5P0EtpVO62mhJ6AtF6wffgm7ObCt7
 yjbgTHRG9Zs4J6QOoaRT9NRd6xogK4gSn+7Vmax9GgkLIK2qbCufDYp/w+3QhC/PbgGc
 TDQ8L9AMn117sXBgBakPIwabzFteqiST5VG72OtBacjcovoMmS+UjqF5yHypmC16oLYn
 TSHV6AUdFffzvYaAbom01U224eHPjr8PD5Ecd5A5sCS+XgiHSKz8VvqO0I/45PllJitO
 PqSO83JTwOhntnIQML+mMNl4xMOyuhzI4Zeycq7UtYfM90kUwzAsaPrv3vj3orNkuKcJ
 M3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705608480; x=1706213280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o0rOeZxLobaeC+GA5Yjm4BlTG768XBMgHhLq69UHP94=;
 b=MnqIo5FGkL8CnZsT9JD8UF8xh0GNCXJOxDya2eA6YG1n8oNrzJbW8lwdfLvlabQAkF
 zpU20XteU1p1f89mNnR5fbvyUphhv7lautHxsGaSl5Rl3te/7bxKHfUWkSt/3kmmH2L+
 kWyBXidY1iRJdKBLsOWiA0dqyIDRtFCdPHNtXVFw32/ae5Wt/GmmOBAJjpNL/HwbFqI5
 Qccmk37kNyqSjp+Me0SecYqJ8g8C20mOIyOF7Vd5kcuz63cNghy1ZmDkfw20lVt3T5ju
 RDdeNlWmiKjWlwsD85ajnqpsTDVKWit0cjJ6eWMqQKfpEyJprh2t3l7wDH8HPRyU0Isr
 5C0Q==
X-Gm-Message-State: AOJu0Ywb2p8HiwcsGdJd5Tob+MprUXEkMcCJ4dfjSCwrspkA5sGSNqt7
 6vfXd9akvy9gGsLNTmBD5TvMDtzlLCDqImJVMm6BB3Zz33gStEsfP66orQ/bGHTwxDkYCQuVzhi
 Z9Ri0a8zD
X-Google-Smtp-Source: AGHT+IG1NAQIyrQe5pBXYsFsuXHLRNDmJDK8Q6CLF/Mb6tUVdicirciB4E9QrAoXLgL7l3NvgakNmg==
X-Received: by 2002:a05:6000:186a:b0:337:ac2c:cfd9 with SMTP id
 d10-20020a056000186a00b00337ac2ccfd9mr389531wri.196.1705608480329; 
 Thu, 18 Jan 2024 12:08:00 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adf9d8d000000b00337bcae5eb1sm4764752wre.72.2024.01.18.12.07.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jan 2024 12:08:00 -0800 (PST)
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
Subject: [PATCH 13/20] hw/misc/xlnx-versal-crl: Include generic 'cpu-qom.h'
 instead of 'cpu.h'
Date: Thu, 18 Jan 2024 21:06:34 +0100
Message-ID: <20240118200643.29037-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240118200643.29037-1-philmd@linaro.org>
References: <20240118200643.29037-1-philmd@linaro.org>
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

"target/arm/cpu.h" is target specific, any file including it
becomes target specific too, thus this is the same for any file
including "hw/misc/xlnx-versal-crl.h".

"hw/misc/xlnx-versal-crl.h" doesn't require any target specific
definition however, only the target-agnostic QOM definitions
from "target/arm/cpu-qom.h". Include the latter header to avoid
tainting unnecessary objects as target-specific.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/misc/xlnx-versal-crl.h | 2 +-
 hw/misc/xlnx-versal-crl.c         | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/xlnx-versal-crl.h b/include/hw/misc/xlnx-versal-crl.h
index dfb8dff197..dba6d3585d 100644
--- a/include/hw/misc/xlnx-versal-crl.h
+++ b/include/hw/misc/xlnx-versal-crl.h
@@ -11,7 +11,7 @@
 
 #include "hw/sysbus.h"
 #include "hw/register.h"
-#include "target/arm/cpu.h"
+#include "target/arm/cpu-qom.h"
 
 #define TYPE_XLNX_VERSAL_CRL "xlnx-versal-crl"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCRL, XLNX_VERSAL_CRL)
diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index 1f1762ef16..1a596f1cf5 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -18,6 +18,7 @@
 #include "hw/register.h"
 #include "hw/resettable.h"
 
+#include "target/arm/cpu.h"
 #include "target/arm/arm-powerctl.h"
 #include "target/arm/multiprocessing.h"
 #include "hw/misc/xlnx-versal-crl.h"
-- 
2.41.0



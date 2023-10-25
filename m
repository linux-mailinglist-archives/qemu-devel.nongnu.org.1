Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C655B7D61E3
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 08:55:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvXml-0000bo-L2; Wed, 25 Oct 2023 02:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvXmb-0000FH-0T
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:54:28 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvXmU-000754-V8
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:54:22 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40806e40fccso38724745e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 23:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698216855; x=1698821655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=394oo7+ySel1V6658dOBRpjALvCFA4gyRwTa12oK//k=;
 b=FQPahMRKDfc6UfQTaDoBzc4EFoGdi0WZv1vZ9SI5sBaEBaXwbGkOzWACxJ6pCmSdMk
 icDKfhrxfisLO4lhiN+tPtd3Eal+D8iuLI/NJg3l5U0V4DxzbzervYNtpLKJwyX6MNsQ
 knb1gtbcQOaeSJxqniyah3g7DaVhG6dHDNNsJMP8SXS1vI4GeKl566qrIKtl8CIUpQIL
 NWxIarsDILSswv5QHhZ8tyu3oTIXBvAPVfmw2UwAcGy78lrEsugl6ebBlv/+vAbHq26V
 zOPxpQzlaDbTWLLBoc0GBXIMAkJ3c7jsdobQrlkYWXtH14MWrIYx0oZ9aC4LtjImpeB9
 paSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698216855; x=1698821655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=394oo7+ySel1V6658dOBRpjALvCFA4gyRwTa12oK//k=;
 b=Alz2229B4E4yGYXq0syB15vohcRIVZn6eTIGONI7K25wFrGAhtB6sYrPaomlyEHh/n
 g3UfUJYBU7oNJDuetpaDOUJVY/u/egND7TlbkedoEDWLu4D2OMgcYnyOsXaK1titpWbw
 c1xG36ZL4qUo/AKq94stilfVDWCn6fYCLkV1ybC+X77fr/WhbN+IvdzkaiG/f3cfn1Dt
 LRK0sZHKigtaxMyLt8EnhBaEGM8py38UIUs6k2QpQUNi8NzF6MZIt6BgluieOdcX5K5c
 tGp1rjarj43gP+3mZm4rsaqNMJdK2IvugtrCQuYRJvlG8OQcJ20tsyufuMEdaa5/LCro
 htYA==
X-Gm-Message-State: AOJu0YwyR7tvn9TedsCbcRgYq8NKXXJ7VrHnLqs22W7pOazTWgf+n3Uz
 zjEWV9ntTEAQyZpVEioUZaWeV2rwExng/c/KeCg=
X-Google-Smtp-Source: AGHT+IG6xxYIeoIdvYuCGrf6fRxw494cNwAaFX8WEHfZ7D9f26iOrX7XjLL4xCVTgf6a6263F0WHgw==
X-Received: by 2002:a5d:5232:0:b0:32d:7f70:74eb with SMTP id
 i18-20020a5d5232000000b0032d7f7074ebmr11469238wra.52.1698216855428; 
 Tue, 24 Oct 2023 23:54:15 -0700 (PDT)
Received: from m1x-phil.lan (ghy59-h01-176-171-219-76.dsl.sta.abo.bbox.fr.
 [176.171.219.76]) by smtp.gmail.com with ESMTPSA id
 f10-20020adff98a000000b0031aef72a021sm11415464wrr.86.2023.10.24.23.54.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 23:54:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 09/10] hw/arm/xlnx-versal: Remove 'hw/arm/boot.h' from header
Date: Wed, 25 Oct 2023 08:53:15 +0200
Message-ID: <20231025065316.56817-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025065316.56817-1-philmd@linaro.org>
References: <20231025065316.56817-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

"hw/arm/boot.h" is only required on the source file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/xlnx-versal.h | 1 -
 hw/arm/xlnx-versal-virt.c    | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 7b419f88c2..b710d71fb0 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -13,7 +13,6 @@
 #define XLNX_VERSAL_H
 
 #include "hw/sysbus.h"
-#include "hw/arm/boot.h"
 #include "hw/cpu/cluster.h"
 #include "hw/or-irq.h"
 #include "hw/sd/sdhci.h"
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 88c561ff63..537118224f 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -19,6 +19,7 @@
 #include "cpu.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/xlnx-versal.h"
+#include "hw/arm/boot.h"
 #include "qom/object.h"
 
 #define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("xlnx-versal-virt")
-- 
2.41.0



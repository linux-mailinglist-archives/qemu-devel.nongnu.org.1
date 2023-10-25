Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D2A7D61E0
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 08:55:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvXmH-0008Qo-Qb; Wed, 25 Oct 2023 02:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvXm9-0008PY-If
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:53:59 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvXm5-00070D-Nj
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:53:55 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32dff08bbdbso1955821f8f.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 23:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698216831; x=1698821631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7g4xwrGmMffd4ojpgJjQSUiCtKxOCpSH88MmHURSx0=;
 b=sJIW+7Qs7zBvJRTtib2rwMHcynuIdlsnROYbaqoyG++XjlDrx+LPKRucM54Ksad5FP
 WZ6pX53VHPU6WXKOq0MuusG0sklIqDMqRxZD0ky+thYQ02tjtBQUXZ4W8bbOFjdMRX3W
 TZpcoa1voTOkfOJmiaLFWvcba6PDKmdOYJ/EKwEgd6Cs8GjMGiStpTT58piske/Bn1TK
 /NdPPLGu0jHMXT93QjPK4dxh7efWtWI2BNd0DQY7UzVesbFeSFR+3TP3QXvPXC8taebG
 0DPecFPIBV8ulCi4lOzgytGqTBvZF93d4vbBksvMXCGKwYnUAhg8uacr1kfonpTC+y/3
 gbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698216831; x=1698821631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g7g4xwrGmMffd4ojpgJjQSUiCtKxOCpSH88MmHURSx0=;
 b=su+ihiWHhpqcAlNBlnsybFF+KGpjEz/G7ifsvlhm8Yklj2Kerf7ViqyG3SPQPNSdmu
 xnF/TVmxWjDVkxqg7SgdF5YfTQBUGO3FjMT7dJW+yC2SiHBv81HPgx9oBRQd7Xy0YeRs
 y/Yq2Gk7s2/6PLSb3pgB/mNe35tA5DMsZ/VpoZ2brpP+RROp42QHdClp+XatXL1ZyNVX
 2h7ZPBUL/xCL68A+ozFecOLEoOavG7aKesJLQpe32QrmS67XtI3etWQLkysH4+k9fGnR
 tsPoh+9gYWGP8i7l8oDyGCb0GpA4RKFVxMYaWANOhQxeKiCJMVmZHdDJUy7XnJeoJBE8
 OilA==
X-Gm-Message-State: AOJu0YzH7j+x82y0CaPP51r6gqjoef5pZebNDhFeGEaVk+qMoI9uJkR4
 LeQm47YzXS+fyKv8uHa6ahwJU6Vryk7kBzZ8lpU=
X-Google-Smtp-Source: AGHT+IF7InIUGgqZEzTztFwPaNYs5H3vrI2OVV8NvWQxh3vx51herOXucIFjNp+iQgeA5C8F7MDcmg==
X-Received: by 2002:a5d:590c:0:b0:32d:c09d:6ec9 with SMTP id
 v12-20020a5d590c000000b0032dc09d6ec9mr11243337wrd.7.1698216830997; 
 Tue, 24 Oct 2023 23:53:50 -0700 (PDT)
Received: from m1x-phil.lan (ghy59-h01-176-171-219-76.dsl.sta.abo.bbox.fr.
 [176.171.219.76]) by smtp.gmail.com with ESMTPSA id
 l9-20020a5d5609000000b0032da7454ebesm11385591wrv.79.2023.10.24.23.53.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 23:53:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 05/10] hw/arm/fsl-imx31: Remove 'hw/arm/boot.h' from header
Date: Wed, 25 Oct 2023 08:53:11 +0200
Message-ID: <20231025065316.56817-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025065316.56817-1-philmd@linaro.org>
References: <20231025065316.56817-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

"hw/arm/boot.h" is only required on the source file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/fsl-imx31.h | 1 -
 hw/arm/kzm.c               | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/fsl-imx31.h b/include/hw/arm/fsl-imx31.h
index c116a73e0b..40c593a5cf 100644
--- a/include/hw/arm/fsl-imx31.h
+++ b/include/hw/arm/fsl-imx31.h
@@ -17,7 +17,6 @@
 #ifndef FSL_IMX31_H
 #define FSL_IMX31_H
 
-#include "hw/arm/boot.h"
 #include "hw/intc/imx_avic.h"
 #include "hw/misc/imx31_ccm.h"
 #include "hw/char/imx_serial.h"
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index b1b281c9ac..9be91ebeaa 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx31.h"
+#include "hw/arm/boot.h"
 #include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "exec/address-spaces.h"
-- 
2.41.0



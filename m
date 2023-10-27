Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E69627D9C00
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:47:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0p-0008Px-DB; Fri, 27 Oct 2023 10:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0F-0007IV-9c
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:59 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO09-00089V-Or
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:59 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-507c8316abcso2744684e87.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417592; x=1699022392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=STyU82hPIUpYks6uiomyW9R8nlE5SYdJeoBHFM04RVg=;
 b=bQBp8D6WbaMwHpTTfABoK3YIei+kNUJqyPuhEtviSq2E4gjnzNJ8IVFXyn/UE9Iwvw
 rCiFZDeZiR0+/5/OjidBqgpKDDvQxUjWN69/wW4BpNkSRCUO1gabnLFnnBbgL7Buo9fi
 9ca9OqVMTKT4tTG2F0cLrETchFdFVRq8dXdsTW48vCnacc8yRumpw42otUEh4nQ9cETr
 Ycw10oQ4ycMS560e3adLLm0fT63sHDse6gpJkoTrnLCjHkuIgV1luh3W30nSJiGn66WF
 oUNTUkk26pOEPgYrT4pOHEpYICEcbMtqSrHpu4xlRBA/W/fy+A3O9UqkK3HjbO5iONNS
 NSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417592; x=1699022392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=STyU82hPIUpYks6uiomyW9R8nlE5SYdJeoBHFM04RVg=;
 b=gdxMZ0j52Y3CxFAQvsWh61YK3VwECyE4L0B38xJZAQCeX0+uMfMilXvR6B7ZdOBFNY
 XpRHGjugMtjMkLZlJ1emAcVDW6YM7NWmUc/w/yKgvj6F8SlQUmSCVy7ICGbRn4vdpODr
 jcpJJInwxHVigwjiToB9RYXiUPzBqzakzhyn1uUHoQdI4r6MePWMxPV3jsLcc/fjHo4h
 Rylj8ZeeQwCJKKVaUus5O4BlZpbcnePwFNryIhU5IgdqY/SWDzl/BgStwLFMtAqnkLE7
 wtx1zkBR3oc9K937wlHVe4Y0SMAY8U5XW5JwIPa/L9olfqUWlQYnuDFoxkA/2uMjBGzv
 LA3g==
X-Gm-Message-State: AOJu0YwP6AYBtmEY0EGqj0QMTTzko3H7533ZxM2zL2r3NVjBc5tQxkIm
 6ohFGE+AcnB1KjVp+RIAtdtsx8N4qDnBPXhkSg0=
X-Google-Smtp-Source: AGHT+IE5S1FoXcWFQdSHx8aNP79zdUJh6BZYv8VEQ5HQUahOPXlfMM8O93PcxCWBQBRrqTEAzqPfTA==
X-Received: by 2002:a19:4f5d:0:b0:500:8022:3dc7 with SMTP id
 a29-20020a194f5d000000b0050080223dc7mr2095416lfk.10.1698417592273; 
 Fri, 27 Oct 2023 07:39:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/41] hw/arm/fsl-imx7: Remove 'hw/arm/boot.h' from header
Date: Fri, 27 Oct 2023 15:39:18 +0100
Message-Id: <20231027143942.3413881-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

"hw/arm/boot.h" is only required on the source file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
Message-id: 20231025065316.56817-9-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx7.h | 1 -
 hw/arm/mcimx7d-sabre.c    | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 2cbfc6b2b2c..411fa1c2e37 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -19,7 +19,6 @@
 #ifndef FSL_IMX7_H
 #define FSL_IMX7_H
 
-#include "hw/arm/boot.h"
 #include "hw/cpu/a15mpcore.h"
 #include "hw/intc/imx_gpcv2.h"
 #include "hw/misc/imx7_ccm.h"
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index d1778122b64..693a1023b6c 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx7.h"
+#include "hw/arm/boot.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
-- 
2.34.1



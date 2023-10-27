Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 854607D9BC3
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:42:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0F-0007Hb-EV; Fri, 27 Oct 2023 10:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0C-0007GS-4Y
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:56 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO09-000898-Bn
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:55 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507a29c7eefso3112111e87.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417591; x=1699022391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qRIOP/ceFHTRk8zEeRjbfMfsx/awJQ+B1yFMqlGEBrY=;
 b=LOp55dXhH31h+I/6/XAtb+WF0PfTJoxbb+XYrrUrz55mx3yaxwIVIIPltNc+g2NzvG
 w8Gyh1suP+A2yjtwh90NYVGuqTv7YK1LAy21ebmNFEeHRLDJ0Jt88YHRI/LxDxKyOLEd
 L1LvrjR8its7y/eaB/82ZsLUyj0weL1jEXkAAKa/PGyMgkrUy9dEiYN3AV7655GiRYXR
 TueV70JCfxFIhd+X3tIeT9vnDzxcRLu2JH02nRs7uzN0Ir12EdsaykKLvHhw9ky7cVmu
 VreqT1THuNYGMRDjepkTNNAzJrFOoiKY3IBs2GsF5VDfmcAR8LUwwPItiSuUaV1yTpVN
 PMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417591; x=1699022391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qRIOP/ceFHTRk8zEeRjbfMfsx/awJQ+B1yFMqlGEBrY=;
 b=OAmktI+mw3Fs3tOkXGJB1WT1OAI40Pxlp6nbZzOLA9FDRZUb+f20k6N/rnfOYO8Vaw
 6Yaq7HuoIh1Jgc+jLf9hG8ypXcjQWc7LCy5nVSi1kTap02Mlzz83B4nS9fyDyIkhmpRl
 CEKmXDxhuyAiLgkJXCV+CiAcNKq11petWm2yZQ+Y/sWZYR/hCCKz97GeguuUzAuYRuZd
 CXQgwLwpMhiyK+TkkSnkkLVzJIqlRN0RQU/tlE3aR45WzrEGZOB1WD9+cW3/3KEvxreX
 GD9nhiD71OQSVkNJ9CwhfbD1SZ83i1jdUOGREO+1fCb0MppCzhhuzfoZh1rng/cYuC8G
 L3YA==
X-Gm-Message-State: AOJu0YzFwRIFk5PTcRiYrT6mX/N671YxLO7K5IfuSPvp5h1Q/HIOAMpr
 OraM6kOYxLIbN/abWQTJRtxINvt4jRDCtMQQOpo=
X-Google-Smtp-Source: AGHT+IGl4jevLKRDpmGfxvzZPJbMtKnDte205JpLfO7OjieyHEyp8xAA8e7X2+if0BOLf4BbhyqOLQ==
X-Received: by 2002:a05:6512:39d4:b0:507:b084:d6bb with SMTP id
 k20-20020a05651239d400b00507b084d6bbmr2852819lfu.43.1698417591379; 
 Fri, 27 Oct 2023 07:39:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/41] hw/arm/fsl-imx6: Remove 'hw/arm/boot.h' from header
Date: Fri, 27 Oct 2023 15:39:16 +0100
Message-Id: <20231027143942.3413881-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

"hw/arm/boot.h" is only required on the source file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
Message-id: 20231025065316.56817-7-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx6.h | 1 -
 hw/arm/sabrelite.c        | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 5b4d48da084..519b871014a 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -17,7 +17,6 @@
 #ifndef FSL_IMX6_H
 #define FSL_IMX6_H
 
-#include "hw/arm/boot.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/misc/imx6_ccm.h"
 #include "hw/misc/imx6_src.h"
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 41191245b81..56f184b9ae7 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6.h"
+#include "hw/arm/boot.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
-- 
2.34.1



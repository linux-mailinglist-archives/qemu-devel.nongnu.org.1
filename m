Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFF77D9BF8
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:46:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0p-0008Ol-BH; Fri, 27 Oct 2023 10:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0A-0007FA-RZ
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:54 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO08-00088w-A3
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:54 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32dff08bbdbso1472825f8f.2
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417591; x=1699022391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1yXp5lXsBt0uFwWt6pWnQ2JZi5Tqj/E4wJ1aMNhTymc=;
 b=Ab4JXCMkGc4hyCk1oRwzssVTDRJ19l7iowGYI+akFIGMZnSA0jEt+NAdT6BSlVdapI
 /trlgSasPaXlG61fm9uhLz81S55slhdXRvro8OZ26WkOGEHhI5Xu+2GN3oRSA2/9EJPS
 7rAwSKkIQtO6Sk/iNq1qjAugN25VAXRoMeR0SXHGRqQg6u78kV+VqODqr58RxHqS/W4n
 4clDX5ABSNtoEZHy/nOGtjhsiNMw2iIO3G7euQrzHLWpSwN+5s0D7AwtNqKiKTm+iIzf
 qYlaxWHNpoOVdGQmMOCHJSFheQ7IOchdMXqxVPgdinNWEUQ2lRPVEwEXww/Oi+ZjVRxF
 SgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417591; x=1699022391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1yXp5lXsBt0uFwWt6pWnQ2JZi5Tqj/E4wJ1aMNhTymc=;
 b=Eze4YGeQlGKKsjxAbKK75KCq/WlZvKCjTEHWz8d1P4hO9LP/xD5CpmpPetn9MolV3f
 yLXd4HUE084hdIQWs4PI1NeqbUOu8HJaIphR1rptR8ltXxoClaHtlTDAa9lhOY1ZA1fV
 H+mWDzxEMCcoJ20JteOGj++VdasexQVdTB0E9TIBEuI+InRQTS/U2jKRn75Vz0EhSKqp
 mJstXDOSrxv9I75aE7g9mbe3R6gsH86tFgCNaxSHwwD3YmmpFMCL4R9RS/RnxFzx/HQM
 9G93d1Eia/wPBiMn9GODQqAa1ulb0KNSVhyTshPEBDAv+SLBQdsRB7hWG9Udc8fLRmjM
 jRNQ==
X-Gm-Message-State: AOJu0Yx/AyTYZ30OI+upP3BvShw11bhm9XhJ0dndkn48m1Vfac0xajBx
 pJ7GD0cE4fBUVNOdn+Wn1WI410QFmj7e8CF4j0s=
X-Google-Smtp-Source: AGHT+IFXSf5+ulR+O94F1odPwA04QH8fKqLX8q85xPXqQKyPg1Jchsnq4gvYG5Led+QfIFeJ3jzDyA==
X-Received: by 2002:a5d:6749:0:b0:31f:fa38:425f with SMTP id
 l9-20020a5d6749000000b0031ffa38425fmr2568817wrw.9.1698417590933; 
 Fri, 27 Oct 2023 07:39:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/41] hw/arm/fsl-imx31: Remove 'hw/arm/boot.h' from header
Date: Fri, 27 Oct 2023 15:39:15 +0100
Message-Id: <20231027143942.3413881-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
Message-id: 20231025065316.56817-6-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx31.h | 1 -
 hw/arm/kzm.c               | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/fsl-imx31.h b/include/hw/arm/fsl-imx31.h
index c116a73e0b3..40c593a5cf3 100644
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
index b1b281c9acb..9be91ebeaaf 100644
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
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A33177D61E1
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 08:55:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvXmg-00006O-EF; Wed, 25 Oct 2023 02:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvXmK-0008UH-0a
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:54:08 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvXmG-00072g-Fw
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:54:07 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32d80ae19f8so3688325f8f.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 23:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698216843; x=1698821643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9mQCUmt8kL3bXixksm+1XQHmEqrWqER6ahfYoxRZEc=;
 b=MtSD5rZgKQNd2IFPvtVq1DvoGwI2nloseF5bTCk9qED0pTxFnoS16Z64X4fIDt7TA+
 S6yqvlJUj9BVS7OpqcNBFiaEdiCh0pDon8ABdCFt4uj3xocVkp97hY1b3n3ufi9z9v7b
 GD5o4bIqL6wPn7umAlusxUTJQfJh3KV8WqmU3VAdKYzCO3kQF9WZgtgB6NHxiPgGi3+a
 dZoKs+lQ2ZMas6ZwvOTceGJpl7J3e/EW0flGjjl5DEibO86PVS0RoRoj5rrnukHnROu8
 0T6Bvih0qF0NQVeGQFTV/n6SYWKAPmH7zzTCCP4cRBjV7yHxQ0BNzuCU2KnLqfw51qg7
 p/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698216843; x=1698821643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9mQCUmt8kL3bXixksm+1XQHmEqrWqER6ahfYoxRZEc=;
 b=bR4H16IFGSCIKb1lsb+C24kZsdkP47loztAXhJyBQY/emNERPM3cJjNQNvdO7xl08g
 qTw6EteCxhZd1k26KYqEe6d6uJoU/bYM/tI83DEEukPwqHH/bfSB39nknP7Eue6y48f2
 6hL65iLFPHIf5g/tg8jUnjKHwYXMZNXFA0A/nxRoV566FyQomJRuTFt9x/JH0WrlwuhB
 wZjB4KlOm7p80eIIRLmyBexjlN0FWPQZ62ozPhO/tgmg+SfUw4S8Ac3TsiKi6FTCkoTn
 VajxQ2l8JGyUdjxQyQUrd0O7yg2ll9zEdfc/Rg0xeAqgAGvjEZqwLZm8VQ0rS/JTCsC1
 2i4A==
X-Gm-Message-State: AOJu0YzgZSH/WEQdjMJ9lMxs7Tb8ZkBMTT6SZqajeWZdbtfBkByWqfhG
 3z4MY2PmMXvQsexswpPXYBgWKaK7NtzatoYp9hU=
X-Google-Smtp-Source: AGHT+IH19gKEkonPfxdyTFTvSYJDPbrP9llUC/eceIAw6hQhocAVnF/sw08bY+8x9ykZaM5UaGfWMw==
X-Received: by 2002:a5d:5190:0:b0:32d:a101:689d with SMTP id
 k16-20020a5d5190000000b0032da101689dmr10595910wrv.56.1698216842996; 
 Tue, 24 Oct 2023 23:54:02 -0700 (PDT)
Received: from m1x-phil.lan (ghy59-h01-176-171-219-76.dsl.sta.abo.bbox.fr.
 [176.171.219.76]) by smtp.gmail.com with ESMTPSA id
 g11-20020adffc8b000000b0032dc24ae625sm11345346wrr.12.2023.10.24.23.54.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 23:54:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Subject: [PATCH 07/10] hw/arm/fsl-imx6ul: Remove 'hw/arm/boot.h' from header
Date: Wed, 25 Oct 2023 08:53:13 +0200
Message-ID: <20231025065316.56817-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025065316.56817-1-philmd@linaro.org>
References: <20231025065316.56817-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
 include/hw/arm/fsl-imx6ul.h | 1 -
 hw/arm/mcimx6ul-evk.c       | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 63012628ff..14390f6014 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -17,7 +17,6 @@
 #ifndef FSL_IMX6UL_H
 #define FSL_IMX6UL_H
 
-#include "hw/arm/boot.h"
 #include "hw/cpu/a15mpcore.h"
 #include "hw/misc/imx6ul_ccm.h"
 #include "hw/misc/imx6_src.h"
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 3ac1e2ea9b..500427e94b 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6ul.h"
+#include "hw/arm/boot.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
-- 
2.41.0



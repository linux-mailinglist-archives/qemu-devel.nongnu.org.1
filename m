Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A90C718E99
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 00:36:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4UOW-0003jh-4X; Wed, 31 May 2023 18:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UOU-0003eY-4c
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:34:14 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UOR-00053y-Hu
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:34:13 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f6d01d390bso1716115e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 15:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685572450; x=1688164450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhcA2XjpvZA5C8xTPJzpjClC6ek2VDg4k24l/0BltKI=;
 b=DBiO+QLd9/5fMXbT9Nrpdeu58ICh/zBgnjx0gCqNbE33lEgKOdoU+o6xvq3TfSAEer
 86Qtma2vzO/wP1YvO1HW9hK/7WQ0VIibSeS6pCOqpUKpEIXe5Tp9stdKIm5utKmoh3RQ
 6qZk0Bbc7uF9/veu2JMiyDO7UYWSHUel8lvwdNIHM2IQxCDNGJTs0xC1jYn475SRMcgw
 Fv+pkZULlhczon/0n8SCYC5Q5SDZQlho69F970qdvSrDc3hGl03Y88MoIJKYMskg7xua
 Qrfkbn+Tz62shfU/hkuLt2BC/+mwg6UXfKpWHIin6m1lPjHgrdpDlR4E+lzYGGAKG/kQ
 poyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685572450; x=1688164450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UhcA2XjpvZA5C8xTPJzpjClC6ek2VDg4k24l/0BltKI=;
 b=WIFpa+NNBUSdZDlwboKtoEZlDpcgQian0kEXtd+rPMxbNYw0efjREue0Uy922Bo2Ng
 fPeDJc8fXTfi0+piI2x4nFQ+eCS7psg6pK02nbof7jhU6ayeEAgGzd0xrOe+cNsf9OGE
 YVfe0GjoxaKkgmiRyEQQpaD9K8pECuXLnGQsYAiuGc09yuE6x9qhA+7gg03RN3Hd4MYq
 dnF7/bRF4t5SsuImyMa74auew7qe2VJlLfKCDTaY++3nvWQn8bLYrCS76TfWwMwK57HO
 nAOuE6q6aGT1yNt9tihjV002aRG4COU3yxCJscrLRYsDnmGbRiMrXIZzECA9G5zGHyW7
 +/Eg==
X-Gm-Message-State: AC+VfDx4l8ibuppxMTdRe7UaHhhuuyA8V460uo8QUBgvNUDPo21cc6Ib
 R3q4gEATi2MTkOrQuGWNUV1R8ro7rnKg+eVao3o=
X-Google-Smtp-Source: ACHHUZ6HeNDgmy+DwqjttaHPn7AAlMy3mAXkpMKLSI87KdLHYT/UuSJl1U0GbE8ZFrAK1zxVzi5rbA==
X-Received: by 2002:a7b:ce05:0:b0:3f5:967:bf1b with SMTP id
 m5-20020a7bce05000000b003f50967bf1bmr598013wmc.11.1685572450353; 
 Wed, 31 May 2023 15:34:10 -0700 (PDT)
Received: from localhost.localdomain ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a05600c205100b003f604ca479esm131623wmg.3.2023.05.31.15.34.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 May 2023 15:34:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/7] hw/sysbus: Make SYSBUS_DEVICE_GPIO_IRQ API internal
Date: Thu,  1 Jun 2023 00:33:39 +0200
Message-Id: <20230531223341.34827-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531223341.34827-1-philmd@linaro.org>
References: <20230531223341.34827-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Since we don't have any use of the SYSBUS_DEVICE_GPIO_IRQ definition
outside of sysbus.c, we can reduce its scope, making it internal to
the API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sysbus.h | 2 --
 hw/core/sysbus.c    | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index bc174b2dc3..cdd83c555e 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -26,8 +26,6 @@ OBJECT_DECLARE_TYPE(SysBusDevice, SysBusDeviceClass,
  * classes overriding it are not required to invoke its implementation.
  */
 
-#define SYSBUS_DEVICE_GPIO_IRQ "sysbus-irq"
-
 struct SysBusDeviceClass {
     /*< private >*/
     DeviceClass parent_class;
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index a1b4c362c9..f0ba57dcbf 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -24,6 +24,8 @@
 #include "monitor/monitor.h"
 #include "exec/address-spaces.h"
 
+#define SYSBUS_DEVICE_GPIO_IRQ "sysbus-irq"
+
 static void sysbus_dev_print(Monitor *mon, DeviceState *dev, int indent);
 static char *sysbus_get_fw_dev_path(DeviceState *dev);
 
-- 
2.38.1



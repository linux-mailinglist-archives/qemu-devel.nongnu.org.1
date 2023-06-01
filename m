Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C78719797
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:48:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4etj-00050d-8h; Thu, 01 Jun 2023 05:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4etX-0004sR-EJ
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:47:00 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4etV-0004Kp-4h
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:46:58 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f60804faf4so6042285e9.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 02:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685612815; x=1688204815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RYVCBEhA1iXQ5tL/suTEeLd5NADdFT/NM2XcFcptWG4=;
 b=j2K14w8VbPOtHENin/CDLGNvJAyQAvBSboBXMlWdiRU0+5ItuT6cg4CrGcxC8QpHOf
 83h+F7wa/9Ssbe0l+PqpXho6YfJm3qUvdr1Ce8AlwWkA2NlxQfKiJiy0l8CvKvJxyePP
 ThYEMCi5w3UgiEUc5iQVMncMOZCNOFJy45aZFk3N4JKfNXQ3cwEtzZf5kIQTUSd1XAs3
 +2ERdKEA86B9QfmpKNaNKW8JJPJzBQ4FGUqrW+f3qrNgwEpZYiqOFI6tT0kmZa/JXVpb
 v9Z24uIJbzmYqHkgz/xojtZlFx4loqpkp71Z5k5bkCXrzx4i0Myy7QMWZSnIFrYnca9P
 pM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685612815; x=1688204815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RYVCBEhA1iXQ5tL/suTEeLd5NADdFT/NM2XcFcptWG4=;
 b=QTrxtSZdfiISZVv9cl+9Iok7E1GpgMRIKOGJuu0LrnefaKfRKa7qAJz1H8CPkZUdcQ
 IMqmYvkXXv5n4gX2ZKHOa94N2JGjbw9gEqrSnK0E3Mp7J0/WV5jNVVCCCe91BGZNSpqU
 X6vlzuEBM0+vh31TKKRdHwbhQN04eOQX1FG18WUoYd7zd+TEDKvFu6ZrhUDomp+CC+oh
 vu6amlq/3CBKSbpD3iED9+2iHWrTLgqNLB3LdNuxM2L19vTzUy0UVMM4wHHwDlwk5Yqx
 S6MOo7X1UWdWpXaJydAf5ni3mz4p7+oTVCAx06R/genyRgF6ng3wCMnB4ubRSTifMe+e
 xImw==
X-Gm-Message-State: AC+VfDxsatGZm4C5+rH/WFIq11koO6K9KdRsbJRS/rVY6P76MAmo2rEw
 nyMmDJrl+CNNkrfjBeWKv0uAJT8Y6pzg8aXgjB4=
X-Google-Smtp-Source: ACHHUZ7R/I6L8mBKAoxzbkxy5W5MUgdJ3LBkvhbWjMwHw4wLc7lpacvxCrVaomdNba5q7jnmoJGucA==
X-Received: by 2002:a7b:c5c9:0:b0:3f6:683:628b with SMTP id
 n9-20020a7bc5c9000000b003f60683628bmr1764527wmk.3.1685612815467; 
 Thu, 01 Jun 2023 02:46:55 -0700 (PDT)
Received: from localhost.localdomain ([176.176.141.224])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a05600c214600b003f607875e5csm1685600wml.24.2023.06.01.02.46.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Jun 2023 02:46:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 5/7] hw/sysbus: Make SYSBUS_DEVICE_GPIO_IRQ API internal
Date: Thu,  1 Jun 2023 11:46:23 +0200
Message-Id: <20230601094625.39569-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230601094625.39569-1-philmd@linaro.org>
References: <20230601094625.39569-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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



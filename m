Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7995E718E93
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 00:34:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4UOH-0002ad-71; Wed, 31 May 2023 18:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UOF-0002U8-7L
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:33:59 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UOC-00052e-Ar
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:33:58 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f603d4bc5bso1779035e9.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 15:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685572434; x=1688164434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cytFQrzGMvOi8slgASF27XRO51GqurNYCbfldEiqvjA=;
 b=K4/ToxIZHVVXnyynSouEA6kbrFdLazOsGjRujeP4hK5R+TjDVxqilU0DGuVrGcK326
 ij4uX1sqzjEGMCjVtwF8m7nqnz3+1pwmVo+0pcl8AUF9Dy/HeFpBpTgzlIomBWzdSfWk
 Yiwea0jFmuof6ZlMomw7hWPjvVYJQGg0bjEY8zGwGT5ax9flktMVbUrfCPth4FbSqm9G
 nlvFGrYKjYFoi8g+ifK0duMN7NTLHe5BdqldV2lg5QSOU2TxuV/5mFmBJia0EO5B/Yj4
 AbVGIAI1kS+7a4MIkN9QNaloGQ+Ss2usHNRQug5bB/pBq82XZxpbBCWr9pHVf7vsImda
 oP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685572434; x=1688164434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cytFQrzGMvOi8slgASF27XRO51GqurNYCbfldEiqvjA=;
 b=jwU3Wx9CwsAua81PRC0lujxqdjKZD5vrTRVXOJCPpyjGMxjfZ3VgTMgFPZI68Mlcm5
 +GZZWodVsJmE4t5DGSdKDRzlawWiv/rkZgJYcg3zhbBslfh/+QSKvLK/stKHDRbwV2AH
 qsidVHiJY0wR1EuE7aTGlA5HJqtNiHw4/TLeOIv/065fEan6U6UyfTT4dbOf5W2XASxQ
 p+Uj7+cPW3TYOoX0WnE6ZGakSI63yfn7BIk0RGqfzY5VWSpw1OncSB3fmq7NEggVWQ4V
 I6ltD8a0/WtkuF3AN6UFRWp42o+JkxKyCof2StIzN1weGIxKjjAsFJraI3SyHaUTEkDN
 HxfQ==
X-Gm-Message-State: AC+VfDw9wf5M8u7rljsqltEsC4uIWvMHgqNhBmuIHNf+YvlBs5E0AkLQ
 7AnYvq64AI9PxaKgsKE//KBZ2p8kwC9ixxYPrRI=
X-Google-Smtp-Source: ACHHUZ6nMFB+/cLG3nkYCmC+SSL1osgTU5gQETwJSost9ZYl9C5ZMhqFM8a0I79YaZlSyUzQFruffw==
X-Received: by 2002:a1c:4c12:0:b0:3f4:271a:8aaf with SMTP id
 z18-20020a1c4c12000000b003f4271a8aafmr609146wmf.38.1685572434603; 
 Wed, 31 May 2023 15:33:54 -0700 (PDT)
Received: from localhost.localdomain ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 f1-20020a1c6a01000000b003f423508c6bsm68086wmc.44.2023.05.31.15.33.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 May 2023 15:33:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/7] hw/usb/xlnx: Do not open-code sysbus_pass_irq()
Date: Thu,  1 Jun 2023 00:33:36 +0200
Message-Id: <20230531223341.34827-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531223341.34827-1-philmd@linaro.org>
References: <20230531223341.34827-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

The SYSBUS_DEVICE_GPIO_IRQ definition should be internal to
the SysBus API. Here we simply open-coded sysbus_pass_irq().
Replace to use the proper API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/xlnx-usb-subsystem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/xlnx-usb-subsystem.c b/hw/usb/xlnx-usb-subsystem.c
index d8deeb6ced..462ce6c3ff 100644
--- a/hw/usb/xlnx-usb-subsystem.c
+++ b/hw/usb/xlnx-usb-subsystem.c
@@ -49,7 +49,7 @@ static void versal_usb2_realize(DeviceState *dev, Error **errp)
     }
     sysbus_init_mmio(sbd, &s->dwc3_mr);
     sysbus_init_mmio(sbd, &s->usb2Ctrl_mr);
-    qdev_pass_gpios(DEVICE(&s->dwc3.sysbus_xhci), dev, SYSBUS_DEVICE_GPIO_IRQ);
+    sysbus_pass_irq(sbd, SYS_BUS_DEVICE(&s->dwc3.sysbus_xhci));
 }
 
 static void versal_usb2_init(Object *obj)
-- 
2.38.1



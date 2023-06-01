Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F63719793
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:48:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4etK-0004kH-CZ; Thu, 01 Jun 2023 05:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4etH-0004jJ-FC
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:46:43 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4etE-0004CV-Tg
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:46:43 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-309382efe13so642175f8f.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 02:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685612799; x=1688204799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufm+WJCjG6m94oCrL/5Ldv1CVPJfrGDblHgEVPADtVU=;
 b=Z6E514TaBtii7SkwlCbxbvcqAA9FCT2ZS0eOX/DqTzYlpIKLG3PNA/cYdYKHUecCQb
 wqWof+8gR31KLmgMPRLy9ZhyoN4zcf/wnvNYyeN0YMKqB1Aw5NqjKbiXSOQBS+RdhFMX
 7Go/8BJZ0FQKI56FClS1WLI/V+6nm6sZErIPwWEsZTNzihV2KyHdlMwJzCuIKSTnfWDQ
 3Uo1uRtaN8OkyLhTfk3N3FFrIjfM2YVf8x3d6xXniLKpPJgTQ25KdhjXpJrIvB+j45nz
 KkFCT6iZuX0Zoblbb5Anc+FlDw1dVoJdHLRnLG0ucQnu7PyOXjytjxvq7cqEBdg7tX/G
 jYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685612799; x=1688204799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ufm+WJCjG6m94oCrL/5Ldv1CVPJfrGDblHgEVPADtVU=;
 b=VlGj6qZfjwxkLG3w05leSLLh/PkIAjAPdNNuCa/c2VqR30Tu+QJhcLC4LxVVtz8uSi
 IAqPJCMpauWNOa1kKcYF9oj3PFE5S2RmJbhbgvbMS4SUEo9eVLwTQZ7gPg6HxuhIlOew
 mfMRJZGVCZV3IijBXSlcUORDAD2SEC81F9qnY1cPvty9ekNq8DPPp1ZNzjf0Ft6A/lej
 ChF4OMS7pvEFPSN+K2dSfy2XcM8lNqfvxQvV56cWdXlAXIw2N8CYIOpyyO0RI+2Ls7wW
 CtM1jUVrS3tf961te5XD7ZrNJiF9p2cY9Q8CeZ5uqgy9WLd6aMdzlnC1/+l74v2hXCz0
 JsLw==
X-Gm-Message-State: AC+VfDy947TGE7js/yJYGf7DK7vWL9+QfRZQWqoEZW15J1zCyMwoSD3R
 ulov4VMoK7ij/mencwMciNLpRoCxIU7keVd5WLE=
X-Google-Smtp-Source: ACHHUZ5Cz1HN3UgNU7yq0wkrYEkn4Dr6IdJU9tMOzde9QYNLmog9dcqvbLDD6FHatnBRKRo5qCyEtg==
X-Received: by 2002:adf:e3c8:0:b0:30a:e643:2517 with SMTP id
 k8-20020adfe3c8000000b0030ae6432517mr1408660wrm.21.1685612799115; 
 Thu, 01 Jun 2023 02:46:39 -0700 (PDT)
Received: from localhost.localdomain ([176.176.141.224])
 by smtp.gmail.com with ESMTPSA id
 l13-20020adff48d000000b003064088a94fsm9659338wro.16.2023.06.01.02.46.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Jun 2023 02:46:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 2/7] hw/usb/xlnx: Do not open-code sysbus_pass_irq()
Date: Thu,  1 Jun 2023 11:46:20 +0200
Message-Id: <20230601094625.39569-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230601094625.39569-1-philmd@linaro.org>
References: <20230601094625.39569-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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



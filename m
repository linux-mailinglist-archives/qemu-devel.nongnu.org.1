Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E91E723FFA
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 12:47:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6UCg-00015q-QJ; Tue, 06 Jun 2023 06:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6UCe-00013y-LJ
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:46:16 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6UCb-0008Ei-9x
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:46:16 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f7353993cbso21378475e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 03:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686048371; x=1688640371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4aD9+19nYJuVLBjwZpPyQ1i9VBe5ol2xDDEn/QIZ0OQ=;
 b=CIJ8oOIDc6dTDWS1nq6qF9glYAhB1YR/HoIJirnb8WXyKD3d35NJHick7/SorY2z0x
 Vbcrx4TqayC04jpTAf89/FOeBn7hgK3C/5BQb+yTI761D2P5DbPVA6GmONOscP458WTJ
 3bllAoUbFdX8vH6d8xsmgYOBjWCgceEaTWbIg06N808NnmCOohC3Bj8mUwjhWL0oEZeP
 TTQ4S/zuwqkGV/9tb2MHqlxRg2LAq9ccpVQ4WHQV9ztwcp8MIhzHtEUGwygX0lArIWts
 HVlG4dBbhwo8cFEjRwlYcVdS/Ch+yzgPxsxDcA59GYHA8hhAI6X7cNXP7LcF8aTXtSRK
 5gXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686048371; x=1688640371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4aD9+19nYJuVLBjwZpPyQ1i9VBe5ol2xDDEn/QIZ0OQ=;
 b=MxXNQpHSRhwPF191lUOTK8tLArTIJeqN9n63/lroJy5lSM01cPn3StTiRH5LV7DRT3
 x2x99lSmL0Mpjg9oBeT8ApC4TDDCmRBfDXyYSJBAlHnTmeoKZWt/U4Sf7a13tNk2QYti
 Z+0UG81NQKBLD99wXRE+uvrPwRntA0Oe/373cfHL3fAnYCnANynkvVnjebtOfWnPcpsW
 JWKyScqyWBhMaCqszGWFJvVnOvnStaCXli1w1gZL0eCtbcKsJ2sgVQSvi8tVMhw+tvYQ
 ia6mmqkqHBcAiRtnUdwejcfuYYbOJxUKaBZQmHmxktkj1yifsaZ5444fCF0Y0dvrLvyY
 jZtw==
X-Gm-Message-State: AC+VfDyfA3eKCifRMpLDQ4HtVy7GMDox9bATAq3tp3Kh/RYHKILp/co6
 7V7ceuj5beR22nEViI/MLGIoXw==
X-Google-Smtp-Source: ACHHUZ6EOinVaCUg0+zHGdqekRqkWxpLY7Fs7B/ZPOTHRyspV1jXJ1xymbBo+U1ak79TlXbwmwF7pA==
X-Received: by 2002:a7b:c417:0:b0:3f7:367a:bd28 with SMTP id
 k23-20020a7bc417000000b003f7367abd28mr1552445wmi.4.1686048371156; 
 Tue, 06 Jun 2023 03:46:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a1c4b11000000b003f7298a32ccsm12195508wma.41.2023.06.06.03.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 03:46:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 1/2] hw/intc/allwinner-a10-pic: Handle IRQ levels other than 0
 or 1
Date: Tue,  6 Jun 2023 11:46:08 +0100
Message-Id: <20230606104609.3692557-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606104609.3692557-1-peter.maydell@linaro.org>
References: <20230606104609.3692557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

In commit 2c5fa0778c3b430 we fixed an endianness bug in the Allwinner
A10 PIC model; however in the process we introduced a regression.
This is because the old code was robust against the incoming 'level'
argument being something other than 0 or 1, whereas the new code was
not.

In particular, the allwinner-sdhost code treats its IRQ line
as 0-vs-non-0 rather than 0-vs-1, so when the SD controller
set its IRQ line for any reason other than transmit the
interrupt controller would ignore it. The observed effect
was a guest timeout when rebooting the guest kernel.

Handle level values other than 0 or 1, to restore the old
behaviour.

Fixes: 2c5fa0778c3b430 ("hw/intc/allwinner-a10-pic: Don't use set_bit()/clear_bit()")
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/allwinner-a10-pic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/allwinner-a10-pic.c b/hw/intc/allwinner-a10-pic.c
index 4875e68ba6a..d0bf8d545ba 100644
--- a/hw/intc/allwinner-a10-pic.c
+++ b/hw/intc/allwinner-a10-pic.c
@@ -51,7 +51,7 @@ static void aw_a10_pic_set_irq(void *opaque, int irq, int level)
     AwA10PICState *s = opaque;
     uint32_t *pending_reg = &s->irq_pending[irq / 32];
 
-    *pending_reg = deposit32(*pending_reg, irq % 32, 1, level);
+    *pending_reg = deposit32(*pending_reg, irq % 32, 1, !!level);
     aw_a10_pic_update(s);
 }
 
-- 
2.34.1



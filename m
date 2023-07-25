Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF71761C7E
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:59:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJUu-0002JA-6x; Tue, 25 Jul 2023 10:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJUq-0002IW-8w
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:58:44 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJUn-00012c-Kz
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:58:43 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742bso56711415e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690297118; x=1690901918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DhnCXjeG6foMHO/pwqkkfiFKoYWFYE9Zpc0uinZfEBU=;
 b=X8CpoZHEgq8X7n4mbuvPTxbx+hEWD2MPr0eMSt1Jkh8ud9vftH2e5E+2EN3Fg5NqbG
 odzZQNX7RW8BqGlx2bMJ7n6Es58Nadm10YmM3cKOZUF1wNxOEU6Y7IYd85MNrS8m/LNj
 Iv5Yl+gLXUINn+wX0uq0sBHYskKG/ZqcRHfd8bmWtw/pKxcVmOWZZzDV6c7uqHrhVRPP
 Ra8/mT61QspqTDPSfPrPsD9QMlsRWKqt7MNvH0AVMH6jJ5SYuLwx978VR51pn0AJfeob
 sBZ0pVRqP/8t4EUeq8UisCAIbIq7xBEEu5FCvtHZl/qU8iNHKrdeExOP4Mbzvh2nfGBi
 uDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690297118; x=1690901918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DhnCXjeG6foMHO/pwqkkfiFKoYWFYE9Zpc0uinZfEBU=;
 b=QIWIUZXmAp2sLgTsnnxQGHPYI8IZ+D5MYyYJjTvkRsMuXL/c7O+6BqPnjPcc/V3Ffe
 JqeGz+bGSruxePryET0nm05w/QQZosbeI76qpBBnuJu7cFzHCK0cVRFvD/phRyzdavT0
 AAgmAnO1rImxxnbCznbF+jYgCnF2NaslCPjVGSjm7XgDd3ehpnZd1f0FWp7SPY6sk0H2
 SzRSzAXrzwYVlqhayQDKRlzIqN2XESML0Wtr1hPf5kDaUHVV5k24GIj1LOpzeb7UFN6Q
 La1Wc7woLwhV6tpJwRAUI3Zqbnbhr5KE9Ge8GwKojIqQPnFaq9gcfSPnh/dzb/2h5GD+
 Vp6g==
X-Gm-Message-State: ABy/qLYB5PHjCd6quQe18cmQxLXBbRYpiZhYkMEdD4M4nLIDKYx5oOi0
 kkDoG7nN3aWnoY8OLKQWxti9zZWrqQQaGHmkieI=
X-Google-Smtp-Source: APBJJlHxuv8uiocFL4EaDbZ/+ZYXK9/KyBaCeuN7dKFFw4nhJqyNqZGFBShPDUCFFiPJ6eiKGX2gOQ==
X-Received: by 2002:a05:600c:40c:b0:3fb:dd9c:72d2 with SMTP id
 q12-20020a05600c040c00b003fbdd9c72d2mr10615707wmb.31.1690297117837; 
 Tue, 25 Jul 2023 07:58:37 -0700 (PDT)
Received: from localhost.localdomain ([176.187.203.142])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a05600c00c600b003fbdd9c72aasm13264194wmm.21.2023.07.25.07.58.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Jul 2023 07:58:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-block@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PULL 01/10] hw/sd/sdhci: Do not force sdhci_mmio_*_ops onto all SD
 controllers
Date: Tue, 25 Jul 2023 16:58:20 +0200
Message-Id: <20230725145829.37782-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230725145829.37782-1-philmd@linaro.org>
References: <20230725145829.37782-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Since commit c0a55a0c9da2 "hw/sd/sdhci: Support big endian SD host controller
interfaces" sdhci_common_realize() forces all SD card controllers to use either
sdhci_mmio_le_ops or sdhci_mmio_be_ops, depending on the "endianness" property.
However, there are device models which use different MMIO ops: TYPE_IMX_USDHC
uses usdhc_mmio_ops and TYPE_S3C_SDHCI uses sdhci_s3c_mmio_ops.

Forcing sdhci_mmio_le_ops breaks SD card handling on the "sabrelite" board, for
example. Fix this by defaulting the io_ops to little endian and switch to big
endian in sdhci_common_realize() only if there is a matchig big endian variant
available.

Fixes: c0a55a0c9da2 ("hw/sd/sdhci: Support big endian SD host controller
interfaces")

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Message-Id: <20230709080950.92489-1-shentey@gmail.com>
---
 hw/sd/sdhci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 6811f0f1a8..362c2c86aa 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1382,6 +1382,8 @@ void sdhci_initfn(SDHCIState *s)
 
     s->insert_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_raise_insertion_irq, s);
     s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_data_transfer, s);
+
+    s->io_ops = &sdhci_mmio_le_ops;
 }
 
 void sdhci_uninitfn(SDHCIState *s)
@@ -1399,9 +1401,13 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
 
     switch (s->endianness) {
     case DEVICE_LITTLE_ENDIAN:
-        s->io_ops = &sdhci_mmio_le_ops;
+        /* s->io_ops is little endian by default */
         break;
     case DEVICE_BIG_ENDIAN:
+        if (s->io_ops != &sdhci_mmio_le_ops) {
+            error_setg(errp, "SD controller doesn't support big endianness");
+            return;
+        }
         s->io_ops = &sdhci_mmio_be_ops;
         break;
     default:
-- 
2.38.1



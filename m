Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E87E37F2A4E
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 11:25:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Nw8-0004Mo-2N; Tue, 21 Nov 2023 05:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5Nw4-0004KQ-69
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:24:52 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5Nw1-0007FI-1Z
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:24:51 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c5056059e0so72475951fa.3
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 02:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700562287; x=1701167087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uKQw+Bk5quR0x5DmJj6cUhmxTm7kP9pkGDcsohAx+Rw=;
 b=qlDE5VNqkspa2ktpqDG357XZ1KO9wJXPcJ0wIyeBiaoQNz/X/kqsYdHhIxNhbTOqrm
 6PJvX/PO+vmKEKZMxMTCpCxsVaSvEKb6J31xfDpCaQxVzhrxUQ/pWK/+ABgwUCWwRyy7
 3VBydexpiTS2IXqWVLWtgcCfCG3KZhfPQMrP5JPzVMXWZA/xiDRxkG01VVcMRTSh1ec8
 snvKiKDpr8RO7EnObYKbxUPrRpweUgHzWZLls8AOkJa0vny+DpEMTafCX57p+C1ayYXy
 5kqq6inmmE4c03CsDSqEFe6KRQmQj45Q5VCDWBTAaaYnz6cHxVM8DK0tIp0jwMvnHaFL
 2iOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700562287; x=1701167087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uKQw+Bk5quR0x5DmJj6cUhmxTm7kP9pkGDcsohAx+Rw=;
 b=m/CwxQDIn1X/EBl3Xw7zROBl3lKmUq6A7VzNU81zZUBTzWd19ggkF66Ipa7+R0zDV5
 wT8gsfGvRcv0gOoKI05C72306eBQhH+HyQ5ihVYYeJXQJywpFAssVIe2Kw6Vj3JasK2E
 J8+i8YKoi7AhTtgiQWUMLPCiRJDb8DFB9jhsNe9Z81DaUqrqWtlHQJaErJjHU7gH9e+f
 HfbSAqDTAVefvzAQMJcVGY5bfo2A5UGwM8JYf1+m9wcH0mkTexVKedITWISvVASy5ABC
 NkripJlNHiOzZMrqFkUuvUKGCDBwQZ/DSYtA5jH3donHAtXNXOpDESsPnK+lZaLOrx+H
 l44A==
X-Gm-Message-State: AOJu0Yy4TrHs7fWjXjdL7Msqjuh1i82bgCw3N2CkGZFCBOM+KVoqEaja
 6eIuatzVrQvv3f8a37mFZkc6WbX6P2iLVCZlGug=
X-Google-Smtp-Source: AGHT+IFjBETApgksxp/2EPadPF/r/SIeNU1JmXH3zfQtc3MKrbloBbeKn4BdSs9USXAJdZHjAsaSrw==
X-Received: by 2002:a2e:9217:0:b0:2c7:f9d:587c with SMTP id
 k23-20020a2e9217000000b002c70f9d587cmr6370929ljg.24.1700562287146; 
 Tue, 21 Nov 2023 02:24:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n25-20020a05600c181900b00405442edc69sm20450835wmp.14.2023.11.21.02.24.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 02:24:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 8/8] hw/arm/fsl-imx: Do not ignore Error argument
Date: Tue, 21 Nov 2023 10:24:41 +0000
Message-Id: <20231121102441.3872902-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121102441.3872902-1-peter.maydell@linaro.org>
References: <20231121102441.3872902-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Both i.MX25 and i.MX6 SoC models ignore the Error argument when
setting the PHY number. Pick &error_abort which is the error
used by the i.MX7 SoC (see commit 1f7197deb0 "ability to change
the FEC PHY on i.MX7 processor").

Fixes: 74c1330582 ("ability to change the FEC PHY on i.MX25 processor")
Fixes: a9c167a3c4 ("ability to change the FEC PHY on i.MX6 processor")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231120115116.76858-1-philmd@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/fsl-imx25.c | 3 ++-
 hw/arm/fsl-imx6.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 24c43745903..9aabbf7f587 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -169,7 +169,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                             epit_table[i].irq));
     }
 
-    object_property_set_uint(OBJECT(&s->fec), "phy-num", s->phy_num, &err);
+    object_property_set_uint(OBJECT(&s->fec), "phy-num", s->phy_num,
+                             &error_abort);
     qdev_set_nic_properties(DEVICE(&s->fec), &nd_table[0]);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->fec), errp)) {
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 4fa7f0b95ed..7dc42cbfe64 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -379,7 +379,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                             spi_table[i].irq));
     }
 
-    object_property_set_uint(OBJECT(&s->eth), "phy-num", s->phy_num, &err);
+    object_property_set_uint(OBJECT(&s->eth), "phy-num", s->phy_num,
+                             &error_abort);
     qdev_set_nic_properties(DEVICE(&s->eth), &nd_table[0]);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->eth), errp)) {
         return;
-- 
2.34.1



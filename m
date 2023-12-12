Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9A980F2DB
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:35:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5ge-0007pP-PX; Tue, 12 Dec 2023 11:32:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5gC-0006cb-PW
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:32:22 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5g0-0007hx-8V
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:32:20 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40c3f68b79aso37747755e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398726; x=1703003526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LN5LIzaAXoHQp7eEvorlIZRES+1O6/1DEdlrH2EDvwo=;
 b=nGEb/ixsUYayrjlw/rxpvax1CMkAzRqKsQmGrG+qqvjALgykOziFSoQy3CtejGPgkz
 +9fk11KbCkU4KLCeHxjD7UEySHMxDFq51fK34DPosuSeR+stLXw/mpk/V5YPF8vDJb5i
 2AbR/Nn4dCOslGNnTx14Mm0uQgziDI/NKpEIfntKhxyHgyNFuY2XLiKz93JNFdjMlWs+
 Bmr6fkp1gJN9MDxONhD7wtY+F1nSduHE91SCWXk9DEw3xI382oxvzmBIhfZ+R+lMBok3
 88XFu/U0ic7PHQiPULL9Ile/jkntpQ09OiH5bZXJTpBma0sRysa6ic1xUbc1AMCyTp//
 477Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398726; x=1703003526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LN5LIzaAXoHQp7eEvorlIZRES+1O6/1DEdlrH2EDvwo=;
 b=GdJ7nJSptswvJl/2rLpxCL/O8fl5TNVjoGmL09+BuNFmKztqcRpAI4ZEOp/k1gF75I
 rOw/YUYrPXAxeZwtxxpfdb3HUs/V5qlZeoc28v5F8LEs8hX9waDXGwkMkc0uIHqZVL12
 KVXHeCj7SU0q8xMxUbY4bEteKWNEqrCCmE6zqJnxaKB2KXzBmYdyccUHrU00K9g9XSTL
 zKuF71MYBR2sisWRcpu9M+qsbQXOBuMxKwELGeu4ec9KPRjEvtTis+xlnU1QvZb2aNJc
 6nDFBwIzfKAVkqeAP0C440JF3ChTspMbdWIzsKHbzRNnv6rYNS8zOPLQtzilYQEos65Y
 cHJg==
X-Gm-Message-State: AOJu0YxtzNewEGnhyzlDBJGBNiHGstzsQ+AYKfX4AKiwYEMuiT6YGjxD
 IzbzCBd9K+oOdLfu4H+ujOer5QYr66EkXWqJh5c=
X-Google-Smtp-Source: AGHT+IGlvAoOiNx8wiI6Rl0Nash3b1odgtW+hNOm4vN5KcMa6y26/s300+JY0XpjXdM68mwgGrLijg==
X-Received: by 2002:a05:600c:6997:b0:40b:5e59:ccb9 with SMTP id
 fp23-20020a05600c699700b0040b5e59ccb9mr3593558wmb.154.1702398726582; 
 Tue, 12 Dec 2023 08:32:06 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 uh17-20020a170906b39100b00a1d5063b01csm6483712ejc.190.2023.12.12.08.32.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:32:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 20/33] hw/cpu/arm: Consolidate check on max GIC spi supported
Date: Tue, 12 Dec 2023 17:29:20 +0100
Message-ID: <20231212162935.42910-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/cpu/cortex_mpcore.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/cpu/cortex_mpcore.c b/hw/cpu/cortex_mpcore.c
index c9ba254818..75324268fa 100644
--- a/hw/cpu/cortex_mpcore.c
+++ b/hw/cpu/cortex_mpcore.c
@@ -43,6 +43,13 @@ static void cortex_mpcore_priv_realize(DeviceState *dev, Error **errp)
     CortexMPPrivClass *k = CORTEX_MPCORE_PRIV_GET_CLASS(dev);
     DeviceState *gicdev = DEVICE(&s->gic);
 
+    if (s->gic_spi_num > k->gic_spi_max) {
+        error_setg(errp,
+                   "At most %u GIC SPI are supported (requested %u)",
+                   k->gic_spi_max, s->gic_spi_num);
+        return;
+    }
+
     qdev_prop_set_uint32(gicdev, "num-cpu", s->num_cores);
     qdev_prop_set_uint32(gicdev, "num-irq", s->gic_spi_num);
     if (k->gic_priority_bits) {
-- 
2.41.0



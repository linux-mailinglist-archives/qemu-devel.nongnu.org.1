Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDBB7D9BE2
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:44:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0i-0007o7-Lm; Fri, 27 Oct 2023 10:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0I-0007LW-Jv
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:04 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0E-00089q-Gz
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:02 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5082a874098so948818e87.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417593; x=1699022393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zos/YT3JrRjqByZMNLI9yBeVZvxMZhI5gX49arsEv1w=;
 b=B1hmGppgQP++MJAF06zQ39dgzLrIEVj2ZK5bmCAe/WLIiA00f4fACnv0l0CBaIe5TI
 FNCWAn4/io0P43QswoylqKID4ClY3KGFRQAfKYAEBN4qiWPAcQFCcCKXqPf43TkKx6Kf
 77djS2oib7liEIkp1zCzYkdKJincDvNFtZ+Wg8RL8IuFDdQVRRHuF8ZNv9IXWbrQCv2E
 WBnJ9lR1c4FXUyxpcqvWn9fPkklOTmxJGDEYCtxCoXLFHJq+LSFmry7jd+MwXhqgiHWh
 xSHUGfNj/wfmfUFFlUhIgw0Fg40k2biTooHDjt1Uq+k6gEjqnZJAvtinvTNB/7cXppxy
 uEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417593; x=1699022393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zos/YT3JrRjqByZMNLI9yBeVZvxMZhI5gX49arsEv1w=;
 b=Al2vzDR/ckleabk+CoLbvYPrO2n2gA69io28K0/ozN5EIeN/lpeh6s6Vwk7i0uj2vT
 kJ6CHX+AMFW0rhMgWREcTLZYi/nKIUoNo3lWtZf/DpSHEdIzbGEGqX6zp8VJL17vDZMI
 CnLlgM4d+iRzR9sgwY5u2P59RDmtMrVeHF/C8eyivhZ9VqeR+PKMQUnJgSk+fFX5zMJy
 MsA84wWhN2WNV6Msfex4u8vAilcf/tfj3hvdoHmkD0LyjxCVZ90wN/6zKAAChGtdk3nf
 Ssnnr6Rpwcmf6SvsceEKsmN6wSRHvJTlJzS+hMhQYEv0Cyn2yKCNEAecaVq1V6qXPulS
 vopw==
X-Gm-Message-State: AOJu0YyYB4yTGxeSxkvipNQM8pF3W0FN3/uSHwI2rBDdKyawT3xwPAaz
 //6IERhmh8x16HTlISjokhTgss4+qxZ79DvdO24=
X-Google-Smtp-Source: AGHT+IF6ijecQTcAwkYNipV9DNsU+/5QyF3PTFb8vmlmNjiqNegBNGplPBcL35/WOzU8rR1cQmOGbQ==
X-Received: by 2002:a05:6512:3b87:b0:508:2b98:d6ce with SMTP id
 g7-20020a0565123b8700b005082b98d6cemr1597359lfv.45.1698417593679; 
 Fri, 27 Oct 2023 07:39:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/41] hw/sd/pxa2xx: Realize sysbus device before accessing it
Date: Fri, 27 Oct 2023 15:39:21 +0100
Message-Id: <20231027143942.3413881-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
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

sysbus_mmio_map() and sysbus_connect_irq() should not be
called on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231020130331.50048-2-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/pxa2xx_mmci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 124fbf8bbd4..9f7a880bac2 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -483,11 +483,11 @@ PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
 
     dev = qdev_new(TYPE_PXA2XX_MMCI);
     sbd = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sbd, &error_fatal);
     sysbus_mmio_map(sbd, 0, base);
     sysbus_connect_irq(sbd, 0, irq);
     qdev_connect_gpio_out_named(dev, "rx-dma", 0, rx_dma);
     qdev_connect_gpio_out_named(dev, "tx-dma", 0, tx_dma);
-    sysbus_realize_and_unref(sbd, &error_fatal);
 
     return PXA2XX_MMCI(dev);
 }
-- 
2.34.1



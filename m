Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EB47081CD
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:53:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6M-00048X-5H; Thu, 18 May 2023 08:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd68-00048D-0N
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:12 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd66-0007vV-Ih
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:11 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f42769a0c1so20056105e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414269; x=1687006269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=94FCi7vRK7PCs/VHyO/ULgXCs/4n8etjGNdHUXsYuv0=;
 b=FH3XHwwpO8AVRez9im6KL3DnjOzEy5bgBxrJimKFYw3QrKXEU//zANcAAEG2orkWFr
 zWwED5i5Um7RUUFb9mp0oTDuHbYG2zTeoDLPWTH2q1Y5WRYzdLzzk9gwT6NG+6C+4m/k
 CRB3Bmw70pIN+MVgetw4RVhW2yjDxnVP75FvENh/63c2hKwJATjqwc8wcBBqvjICHbz1
 7FGV2C/AHolw+xKqxJTnR8DbzBiPItKDuyMhsaGLkCOG4gim5V5jFclB11fO/WhY16Rd
 VU1R0o20rD5ffktvae2adeJFOzp/97utq+KlIkW/oc5zdc8heVnIgLkoqGNpzdac/tPQ
 UlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414269; x=1687006269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=94FCi7vRK7PCs/VHyO/ULgXCs/4n8etjGNdHUXsYuv0=;
 b=R4yj2UB8UG4xe5kBsojiEBjfjmcXsVUkswJy670Bh7qzkVzJsyVWGxfGblB+S3sqFU
 1MTYKfIWU3KHj/8oXaXpDuHCAKUnAb6NMjBtJVwNfQaPvwoeOCF6v3BMG0V3DANTNVqo
 1GQuLDrr2+8VOPMaT+LkVim1hdvaOJ8sKawSyu6D20OhvprIp4ZArfYBlvtj5xQ7M1op
 Iyn7acGh4zScabrY4XLm/XnEjjnj31Gn3Ia3qsG97dGXyIhoS10zm8cvtpD8TMFsFWtX
 p32uJyqpgAAUwcoa1yLGzjqfH0mkL0NEYlJJrhE32qFL2z8wC233s5J9ul2LJtt1WsT0
 fAPQ==
X-Gm-Message-State: AC+VfDwPilSKJr7h2KRrRWYKwLkkQjEQ3Uoih5tMELW/q6Pezu05NDXp
 yZ9YMfaLYVqxlS06av9GAuCw+ihJxhAqQxIhdQY=
X-Google-Smtp-Source: ACHHUZ47PDwBmtssD+SPDatP1AMFzZEfDqHTdtRKtzphe8l31CIzhfEaCUM77xMLfNM+DBheLKF4+g==
X-Received: by 2002:a1c:7910:0:b0:3f4:27ff:7d54 with SMTP id
 l16-20020a1c7910000000b003f427ff7d54mr1523362wme.3.1684414269118; 
 Thu, 18 May 2023 05:51:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/29] sbsa-ref: switch default cpu core to Neoverse-N1
Date: Thu, 18 May 2023 13:50:39 +0100
Message-Id: <20230518125107.146421-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

The world outside moves to newer and newer cpu cores. Let move SBSA
Reference Platform to something newer as well.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>
Message-id: 20230506183417.1360427-1-marcin.juszkiewicz@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sbsa-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 0b93558dde1..a1562f944a6 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -852,7 +852,7 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
 
     mc->init = sbsa_ref_init;
     mc->desc = "QEMU 'SBSA Reference' ARM Virtual Machine";
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a57");
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("neoverse-n1");
     mc->max_cpus = 512;
     mc->pci_allow_0_address = true;
     mc->minimum_page_bits = 12;
-- 
2.34.1



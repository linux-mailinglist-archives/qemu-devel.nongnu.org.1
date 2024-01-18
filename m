Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D2B83203F
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 21:09:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYfO-0003UL-UT; Thu, 18 Jan 2024 15:07:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYfM-0003TK-VK
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:07:08 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYfK-0006v6-8m
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:07:08 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e86a9fbd9so195945e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 12:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705608424; x=1706213224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5DV0gjEvxVYdSUXbSGfE0SOvd3u+uIvvVQeLb8GJ57M=;
 b=Lqyd6nKsMDgNVtksfCAfEXmHP74kdWZNhlNQHXfc91LR77fKjYmKhs4P9RIHv2CMez
 YM24Z+mHvkDYe9IhTHG3ATEdHb4f7Acg4XLrJacMu3qvAzUXAtbP4nS2p4B9mrnJo7sy
 Ldom26IU3nRc4Gt7y18FzHL2zm9ITs+EvQ7ByzxcmLMCLTvb6Qr9q6Xd6n5GfscAwCRx
 9Bu+GoWPEZhYENSti1oCUG2KsAGArSAGfPMCZ1SxtI9BrSTB1dK6sLbF9aanGPDIMECb
 eI3djIa29hDskvYcXU6uEZnzr41IHwB8XtTzYESCOjmb3ulqQqXUA+zmiIBs6j0FUHPP
 gQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705608424; x=1706213224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5DV0gjEvxVYdSUXbSGfE0SOvd3u+uIvvVQeLb8GJ57M=;
 b=EHO6TM/zgMcUC6et3AGCf4H9v69twfL74JB6q2NGl2sDV03SHcp3Qe00Z1ZgFEcAul
 y/EAnF2I8I4iYEqHif9gLJMATrFFkP0I8llFXt6/VX9hqOnoFmz07orDGoTPH0KL6MiL
 iaDj6aP0zGqqtkr8wocO+3Z32Irt+CPaK8MJAbojwujG67CZQibLN8buyWB2RHCM4nEk
 swtUyfDoJF8yYgO2QBjWxPAcS8vLwOgeTalerWZ2mk7CzD1LwYd0oT9cAqqPfPP5dPvA
 Wie8IARibPt9VtGXrf8PW0c9K06igPRZ/mdmMCHhX4rGwxy+Z6hHJw9QQl7DRkACoP7N
 W7hg==
X-Gm-Message-State: AOJu0YzGuaDhQdgI+vqFDLGuakS4K7+ZaajSH+zdR87M4pfc49GH/EJo
 Y0Oejhuacbh7Z88BrqVcgdn1+j2goryRwxH+2364brsM6pE3xSB69VT2c8zqxvGBGpYohlS5qVh
 bPCeIZWL9
X-Google-Smtp-Source: AGHT+IGyZXtCLkCvO+pPKnbG3scB5k1GCK313QwzV6L9kDFDYVagNopPUzfRy36YI8Alv8WDgVLOLg==
X-Received: by 2002:a05:600c:2981:b0:40e:954d:1a1a with SMTP id
 r1-20020a05600c298100b0040e954d1a1amr749105wmd.76.1705608424346; 
 Thu, 18 Jan 2024 12:07:04 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a05600c0a4b00b0040d53588d94sm30769470wmq.46.2024.01.18.12.07.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jan 2024 12:07:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Auger <eric.auger@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Rob Herring <robh@kernel.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Tyrone Ting <kfting@nuvoton.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Joel Stanley <joel@jms.id.au>, Hao Wu <wuhaotsh@google.com>,
 kvm@vger.kernel.org
Subject: [PATCH 03/20] hw/arm/smmuv3: Include missing 'hw/registerfields.h'
 header
Date: Thu, 18 Jan 2024 21:06:24 +0100
Message-ID: <20240118200643.29037-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240118200643.29037-1-philmd@linaro.org>
References: <20240118200643.29037-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

hw/arm/smmuv3-internal.h uses the REG32() and FIELD()
macros defined in "hw/registerfields.h". Include it in
order to avoid when refactoring unrelated headers:

  In file included from ../../hw/arm/smmuv3.c:34:
  hw/arm/smmuv3-internal.h:36:28: error: expected identifier
  REG32(IDR0,                0x0)
                             ^
  hw/arm/smmuv3-internal.h:37:5: error: expected function body after function declarator
      FIELD(IDR0, S2P,         0 , 1)
      ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/smmuv3-internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 6076025ad6..e987bc4686 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -21,6 +21,7 @@
 #ifndef HW_ARM_SMMUV3_INTERNAL_H
 #define HW_ARM_SMMUV3_INTERNAL_H
 
+#include "hw/registerfields.h"
 #include "hw/arm/smmu-common.h"
 
 typedef enum SMMUTranslationStatus {
-- 
2.41.0



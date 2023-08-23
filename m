Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 078BE785B45
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 16:57:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYpI0-0006zd-QS; Wed, 23 Aug 2023 10:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYpHn-0006xB-Fb
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:56:44 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYpHb-0007er-MD
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:56:34 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5007f3d3235so5530102e87.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 07:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692802589; x=1693407389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XE9v7foDNFxPe4946YxN3Nb7epPtd1r5RF+iq2i5yko=;
 b=eH7VO7+5mrkMBwbWOKoh9s5AiAsIzxYq6AqBb1KHNr0fEmOl0EdTtQKW8axPreSGK1
 GhQXkX/8zJBCRjImRlnkcyg6lhJg5X0ziTTuwc8X2kDTbKnbBiqImlc3WJPjW211qGha
 HpovdJyEjf/N5ur6aWAXh3cm7udQr/SIl2HhjQwzSl2WZ4eIEB8Lt0n6snBQPlBoNw9T
 j9OxZlDsgzdSOcCU1bPlIEH8IdVROfvXvyCMVoiK/ovnRAv++9Q7fnOctV1Q6f9fnHxX
 IJOzU0xq14xEDMUbCxmX/JetiPxWRGpI6rm4lqei5qbvXgLmkjDbNj5BHmq1FxBEyCXz
 UsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692802589; x=1693407389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XE9v7foDNFxPe4946YxN3Nb7epPtd1r5RF+iq2i5yko=;
 b=Df135+WrWSLWb69tFVAMz9Xgb5wp1+xU406uFyqVK/wvkYAnyqX7DVQlHsGlt2R80Q
 ThKjJHhG+pl16xCIw06HXOLIFJPZqmf+B6VXTH4op0sC5rN2FyUNGIu3Unj0bnx6AsTD
 rGv7YbC7u26I409sk3fJrW5owW7vZ5btEOP/p2SPVbHYC9UJEE0AjguxWHXcWCN8oOjG
 cl1lPOVK+NFRxyRWxza98KTrARMoV3XRQJX2FE7MVDC/WeAlYAUPJn02WWo+mMiCnX0S
 UDY7dkfWZd2gowVRvB4SmEu/ILHEe0sFMl6IUQoALf87N9BquiL9zgwdhxvWmxtwaw0q
 s65A==
X-Gm-Message-State: AOJu0YxinHmfm/pQuRblBHLKrNNTOfJVvXnQvdWq7Hz5ftBs4yeHp/w6
 6Wqr15Z/01Qsei89icty9fD9d5KksvwTdRgeiIwIEA==
X-Google-Smtp-Source: AGHT+IEkUhsmL5Bp7KF38u7f30H3Fhe/jrskoe6hcSt9njMpa60+9BNgeXHy1Qy0HBZ4L8hxyeMl6A==
X-Received: by 2002:a05:6512:3d0e:b0:500:91c1:9642 with SMTP id
 d14-20020a0565123d0e00b0050091c19642mr3569483lfv.21.1692802589598; 
 Wed, 23 Aug 2023 07:56:29 -0700 (PDT)
Received: from m1x-phil.lan (gsv95-h03-176-172-10-165.dsl.sta.abo.bbox.fr.
 [176.172.10.165]) by smtp.gmail.com with ESMTPSA id
 h2-20020a170906828200b00977cad140a8sm9839290ejx.218.2023.08.23.07.56.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Aug 2023 07:56:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 8/8] target/cris: Fix a typo in gen_swapr()
Date: Wed, 23 Aug 2023 16:55:42 +0200
Message-ID: <20230823145542.79633-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823145542.79633-1-philmd@linaro.org>
References: <20230823145542.79633-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/cris/translate.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index 0b3d724281..42103b5558 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -411,15 +411,17 @@ static inline void t_gen_swapw(TCGv d, TCGv s)
     tcg_gen_or_tl(d, d, t);
 }
 
-/* Reverse the within each byte.
-   T0 = (((T0 << 7) & 0x80808080) |
-   ((T0 << 5) & 0x40404040) |
-   ((T0 << 3) & 0x20202020) |
-   ((T0 << 1) & 0x10101010) |
-   ((T0 >> 1) & 0x08080808) |
-   ((T0 >> 3) & 0x04040404) |
-   ((T0 >> 5) & 0x02020202) |
-   ((T0 >> 7) & 0x01010101));
+/*
+ * Reverse the bits within each byte.
+ *
+ *  T0 = ((T0 << 7) & 0x80808080)
+ *     | ((T0 << 5) & 0x40404040)
+ *     | ((T0 << 3) & 0x20202020)
+ *     | ((T0 << 1) & 0x10101010)
+ *     | ((T0 >> 1) & 0x08080808)
+ *     | ((T0 >> 3) & 0x04040404)
+ *     | ((T0 >> 5) & 0x02020202)
+ *     | ((T0 >> 7) & 0x01010101);
  */
 static void t_gen_swapr(TCGv d, TCGv s)
 {
-- 
2.41.0



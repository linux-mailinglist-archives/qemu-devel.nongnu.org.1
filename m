Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 992EF7A9854
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:40:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNce-0002Bu-2X; Thu, 21 Sep 2023 13:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNca-00029z-OV
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcP-0007i8-Bk
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:48 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40413ccdd4cso16425935e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317854; x=1695922654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+K0O4G1OJUoEa5KBlRvuRwUc3XEOy61zeM7fZ8Tl0gw=;
 b=GkTWZXUhg2HwHlCUYWhRoLIjT3IWhehXtgFngPbqs4IIbk68oqTQ1Noz6SERClOIyO
 qa09AesR7Y11YiRz/4DWnkZ06Vzl0ZOzZWPUiXorJcRcaRVxxrb3fHH5LeJZsacgHb78
 w9yjcQ+qkVmuQ8k5JA3nW/3rL1B7ZXE3+rjxNEkZ63kmdxoRmZIbYTv1tgjIIuYdsSKM
 phVxDtMucNJGikWpmmlrW4y/voAY71EEvlURyVl96FOewyt5M/lYagjqIt3csv4bgz29
 APIq5J2IN/3N2CovGcCsVk2CTFWCMfL72bOGrd5O3Gd5uty/oEoWGqEwPIVC/ZTybBvV
 axcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317854; x=1695922654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+K0O4G1OJUoEa5KBlRvuRwUc3XEOy61zeM7fZ8Tl0gw=;
 b=M3bp7sp2Tk3y6ZKuz0jZrU6a0DWKqElKPku3yLs/IyKIAUsP7vFesJDIjV874dCN/e
 x1bkbHVKrQ7fi/6i7s4Q1nEEJDTEHs884PZcMSvCGSkYa/z1fT01N8MunYV1h/fGxC3g
 6SEJ1dY/AbAvmHCkkwtG3knqL15yWSTYoIrqVIsHf4acuScsJ3MgfG1TfXnddtoLhYb/
 BCTLx4cf7Wc+/oJsZFG4J8mh6MD1kia/w64dY6OTa5vFyScaW8duaY6qeiEl3UnOqhDI
 QjRw/9/an5oq+EU/wKrcZirnYt+34l+MgsM5w01Q3P7vD5SCmKnD6yqHYijrG42N0TGU
 w83A==
X-Gm-Message-State: AOJu0Yytts4SpTCMSxPCofgX4YEndmDKyFX8MdQ060eJ+HwRYrmdOSGu
 kQdXQdcrMlU2DziS2hYHtpioqeFXdg7t7K+X3D4=
X-Google-Smtp-Source: AGHT+IHQj38NN7Gl0dVyS1EwXryJFDdQtfvQdhMn+mIA+2uINbPS1NCqLvFgIRyMHmWhevA3oXniQQ==
X-Received: by 2002:a05:600c:8608:b0:400:140c:6083 with SMTP id
 ha8-20020a05600c860800b00400140c6083mr270393wmb.2.1695317854037; 
 Thu, 21 Sep 2023 10:37:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/30] sbsa-ref: add non-secure EL2 virtual timer
Date: Thu, 21 Sep 2023 18:37:15 +0100
Message-Id: <20230921173720.3250581-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Armv8.1+ cpus have Virtual Host Extension (VHE) which added non-secure
EL2 virtual timer.

This change adds it to fullfil Arm BSA (Base System Architecture)
requirements.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-id: 20230913140610.214893-2-marcin.juszkiewicz@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sbsa-ref.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index bc89eb48062..3c7dfcd6dc5 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -61,6 +61,7 @@
 #define ARCH_TIMER_S_EL1_IRQ   13
 #define ARCH_TIMER_NS_EL1_IRQ  14
 #define ARCH_TIMER_NS_EL2_IRQ  10
+#define ARCH_TIMER_NS_EL2_VIRT_IRQ  12
 
 enum {
     SBSA_FLASH,
@@ -489,6 +490,7 @@ static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
             [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
             [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
             [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
+            [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
         };
 
         for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
-- 
2.34.1



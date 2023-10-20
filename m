Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3913E7D147D
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 19:01:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtsrU-0002aJ-MO; Fri, 20 Oct 2023 13:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtsrS-0002Ys-Bh
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 13:00:34 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtsrQ-0000H4-8z
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 13:00:34 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4083f613272so8764815e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 10:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697821230; x=1698426030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1xZSgqSQwwblLFwOLujd84tc/4RL/5RbsxrAj9sMqy8=;
 b=Uxu0caw9V+mF9gc5xue8m5yGAWKN2t121DKBUV1Oo0t6RJMNvH/jucPFjUclMyc7h0
 e5FtFgnbcASgWsPeZasAER1VpmYZE29GYeSRzzVbkewKnOsScs7iLQHtRcIh36h2aDBx
 4DcMKi9gL0mD3J1Cemv6bEyocNKKB2NDiSZ8Z+CS03BapOp/hkyY7qZNEPaE0mWWA8V+
 eFlU57gn6AJR0dlLJrpYrM61NzipbnbZRzn1kZki3MXQh6j+pmaS2leu/yVtpKtiv9WG
 JKE6AeKMu/3004yJa6nJangX7hQx2BbrqlqIq1i0ge70F+klYboy14zUi5Z6Q2GvsXmu
 aV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697821230; x=1698426030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1xZSgqSQwwblLFwOLujd84tc/4RL/5RbsxrAj9sMqy8=;
 b=Cjq/hK+fiTP0TcKHnZ/xOvx00GlCAnist2rohhqCkfq+pVK96lkN7BdnB4iAM9fNpm
 gGbbRfGLBKDuBCJOY0pz+urzCIpJb0S8XHqdKvuGPVfu1dpANRJUAt4rv8YZkgXuF7my
 bZ12PCVCKBjvmuv8FnsH5o90i93rD2RzlBHN2/m6Y94tbIGzFtbOdxCHJtlednvgfMGS
 Lc3rvFgJjxS3IVFB6kye6+9wTEkea0fYrdcl+iOOkreuXE2RaSmsiMRCbdxf79guVY69
 59kiv9wcMuJEXcqd45QQkMgiqHifRGAXpC18RZy1S6PPuBSj7FnRLlDSWtsARfi6UsG4
 3y8Q==
X-Gm-Message-State: AOJu0YwoWPsYHQ9urYYip2xfgxUD/fpevuiJhvUXSlgZ+4KprScam0k+
 N+NumyrgblVUHFJMnGhSNJL09A==
X-Google-Smtp-Source: AGHT+IGsFFesbAckOWTZIDIA2r36G912m9NMFbneKwt0pGzI5Ala5AlLlZTRitzgbzodREYMWAj3gg==
X-Received: by 2002:a05:600c:35ca:b0:405:3955:5872 with SMTP id
 r10-20020a05600c35ca00b0040539555872mr2053594wmq.18.1697821229814; 
 Fri, 20 Oct 2023 10:00:29 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 e7-20020a05600c218700b00407efbc4361sm7346993wme.9.2023.10.20.10.00.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 10:00:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/4] hw/char/stm32f2xx_usart: Update IRQ when DR is written
Date: Fri, 20 Oct 2023 19:00:07 +0200
Message-ID: <20231020170009.86870-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020170009.86870-1-philmd@linaro.org>
References: <20231020170009.86870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>

Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
[PMD: Split from bigger patch]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/stm32f2xx_usart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 46e29089bc..74f007591a 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -169,6 +169,7 @@ static void stm32f2xx_usart_write(void *opaque, hwaddr addr,
                clear TC by writing 0 to the SR register, so set it again
                on each write. */
             s->usart_sr |= USART_SR_TC;
+            stm32f2xx_update_irq(s);
         }
         return;
     case USART_BRR:
-- 
2.41.0



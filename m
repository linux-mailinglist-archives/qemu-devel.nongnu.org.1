Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D99397C80E7
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:54:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqp-0001ih-Ax; Fri, 13 Oct 2023 04:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqe-0001Dv-0R
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:46 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqc-00018m-5o
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:43 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32615eaa312so1671388f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186920; x=1697791720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hOvGuBypuCWb7hwJnxTfq9f8trGAKqx0KCb984exKgY=;
 b=F+vcCliA8X3dwFVx2x4v/jXyboVUflRqxJGnsOm6qMsXcGrR+fqHbDehW0r8k2ZpYN
 XVuRaJP3peGpWRUshViz3ytSkr6ka7JMGTlEejWq2nSUY9KY5NVYLvmGupBwF/MbpSqX
 c1Tw3DAfZSKz7i1WDcGfxNKST8LF1BhISn7s0lXbQgMABpz/B+0MRTDHKIaRRq4bLqxS
 7/3GKsJ5Oaj4idYWQmyIcXTM+axCAOtFJFvSE/4HBSXESiio1hwX1lm0t77wa3qlVsFQ
 cX9r/aLWZqFe0FPOP3wDVongEbO9iOwFqDoI6kMa2vN1tcItTPRMuxzlAVEKzp6+jOEP
 s/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186920; x=1697791720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hOvGuBypuCWb7hwJnxTfq9f8trGAKqx0KCb984exKgY=;
 b=dPrvveN20BMltV5jYw0XjdUKM0ZO7F1SsCtUbNt5e4PaY6n977bSBKxUA656wZjvhd
 13m+yKKEyy5LzeGLVPWAXMMa7+V08OWZfpPiLHWRQnJngFknq4Hmn6xdG7Yca4usDZhG
 T3FpoozvImZgQoCY7mENOyjq2NeNQlQRgQZMVZi4X+8GokIOG6DVvL1Dw5pe2+fWWKFu
 EyalyeKJqZpBWYYHUwLGPZ9mlMFVFnoNmCEVUQgaSgQhI/iNOjga+ab6Juhd1cCwTwUX
 a2APYSYzBvgBh3yknJIKq1e5m3jMWTcM85uqRWT7p2xdJk9CXfvMexjNa8qFd80M3+FG
 CMnw==
X-Gm-Message-State: AOJu0YxY3+lpJSEYA08WJsQslGbSnWm5dICvHXBntzYSJNZAyByVwM9Q
 0SQQe7w+pXmndn7lDKWJvmqSTUdqZ7tPis0re04=
X-Google-Smtp-Source: AGHT+IE5j96IRnq8GWqFHi8dmOMIln8pVawuGNPTgBlMftAuvvevxRdsi4L7yKgq658CuBqE+vQlqg==
X-Received: by 2002:a05:6000:108d:b0:313:eb09:c029 with SMTP id
 y13-20020a056000108d00b00313eb09c029mr22881580wrw.43.1697186920539; 
 Fri, 13 Oct 2023 01:48:40 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:40 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org (open list:NRF51)
Subject: [RFC PATCH v3 52/78] hw/char: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:20 +0300
Message-Id: <299c3af2d3ce4394394fb952e30d97dde24dca04.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/char/nrf51_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
index dfe2276d71..3e2b35c7ad 100644
--- a/hw/char/nrf51_uart.c
+++ b/hw/char/nrf51_uart.c
@@ -170,13 +170,13 @@ static void uart_write(void *opaque, hwaddr addr,
         }
         s->enabled = false;
         value = 1;
-        /* fall through */
+        fallthrough;
     case A_UART_SUSPEND:
     case A_UART_STOPTX:
         if (value == 1) {
             s->tx_started = false;
         }
-        /* fall through */
+        fallthrough;
     case A_UART_STOPRX:
         if (addr != A_UART_STOPTX && value == 1) {
             s->rx_started = false;
-- 
2.39.2



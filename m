Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B2E761C8A
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:59:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJV1-0002Ot-MG; Tue, 25 Jul 2023 10:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJUz-0002Ns-3U
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:58:53 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJUw-00018A-Ni
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:58:51 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbc63c2e84so56767785e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 07:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690297129; x=1690901929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s4i7zxWBFbwawN5hoH2WbNEPh79dMjPmIuyC9TUA1JY=;
 b=WiQqv8hJyi5mTdrFxdItBf6EP6yakFcGpCeLGwfToTsBSqIgfXkN9CUv172FDVUpD5
 WIbcnuX6x4kuC3kRzBU/US8d6zPVwprnsopR6xJBSxV/B4Z0f/vZGC+iIfuc2N8En/ME
 vvy2srS1dmLwM7jrEqUc8aOxk5pfLlro+owIvwq9bAvQSn5JlTE+5JMSB9Je5aZwregr
 O0s3z2lCp/Rru+niPG1dI/LMxp1o0tMFVyGHd0qfE4ARjEi3Aa+OCo8n6Fk/8NdW3hTe
 x4K2DWHKbEfOAZcUwZo8YWtd9VDL66ZQ5tgl0AGp9ywqBQPwd+dsuZ4zC0qVwng3JlEN
 eYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690297129; x=1690901929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s4i7zxWBFbwawN5hoH2WbNEPh79dMjPmIuyC9TUA1JY=;
 b=RPqkfQm1Q726tMPSll7brhNhlRbpkaMwdhp6O21JqmzwXk186GAOWuPa0BO18uBTJ6
 2sg7/pFjxuukTGvIoYZRfTLBJprdR61wMc61XLXyXNQLhevFuXN1BSMdLXvR063i+3rb
 +zFqQXveKL1sPeeJiNGuHggWQ0JqROpnpRWUIuOH2XNH+QywU5zSuJ6P9C6ZYptn133a
 dsETte1AtRzCXUS88usl7a03++RH4u/tFH7iifsPl2vPiIx2LndLMru0TnDqFwbiyNGe
 19W9k6RKAJIQ9DZOR8Z+A6eQQVWmDI137JtxFkAexWx197zMgdTHiZg2BMSLc3bHOAVs
 fQEw==
X-Gm-Message-State: ABy/qLYMV7dzsLL4Gdiu97hiuRlbDtZxg9XiusMwcPsWKDcIAPTbTHy6
 WQ7x2fOJ2bnv2B9MHy8t/+2I4Vimn9Z7J1VXMPM=
X-Google-Smtp-Source: APBJJlGId4Y97vQf+fb9vUzUshwygU7TZCIu6eFOv8p7JJuzP75qyKrgEWPdT5eiCgv85Gc4QH4URw==
X-Received: by 2002:adf:f092:0:b0:317:5ece:e16a with SMTP id
 n18-20020adff092000000b003175ecee16amr4969070wro.50.1690297129252; 
 Tue, 25 Jul 2023 07:58:49 -0700 (PDT)
Received: from localhost.localdomain ([176.187.203.142])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a5d6441000000b00317643a93f4sm5219042wrw.96.2023.07.25.07.58.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Jul 2023 07:58:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-block@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/10] hw/char/escc: Implement loopback mode
Date: Tue, 25 Jul 2023 16:58:22 +0200
Message-Id: <20230725145829.37782-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230725145829.37782-1-philmd@linaro.org>
References: <20230725145829.37782-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Thomas Huth <huth@tuxfamily.org>

The firmware of the m68k next-cube machine uses the loopback mode
for self-testing the hardware and currently fails during this step.
By implementing the loopback mode, we can make the firmware pass
to the next step.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230716153519.31722-1-huth@tuxfamily.org>
---
 hw/char/escc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/char/escc.c b/hw/char/escc.c
index 4f3872bfe9..4be66053c1 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -653,7 +653,9 @@ static void escc_mem_write(void *opaque, hwaddr addr,
         escc_update_irq(s);
         s->tx = val;
         if (s->wregs[W_TXCTRL2] & TXCTRL2_TXEN) { /* tx enabled */
-            if (qemu_chr_fe_backend_connected(&s->chr)) {
+            if (s->wregs[W_MISC2] & MISC2_LCL_LOOP) {
+                serial_receive_byte(s, s->tx);
+            } else if (qemu_chr_fe_backend_connected(&s->chr)) {
                 /*
                  * XXX this blocks entire thread. Rewrite to use
                  * qemu_chr_fe_write and background I/O callbacks
-- 
2.38.1



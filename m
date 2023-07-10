Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D9C74E124
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:31:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzOD-000460-B7; Mon, 10 Jul 2023 18:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzOA-00042F-Uf
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:29:50 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzO9-0002DQ-FT
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:29:50 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbc244d384so52015505e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028188; x=1691620188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QX2IEM9dRwmrf277j4zOSy3qa25+owguTvW7VNekX1w=;
 b=zJqnkhECawB70bO01qwUEgZyXDAdHYGT9OOrWgLMFDUp4lpz+WbX3vkIztfyp+2fX0
 yZIj+JmWdFkLt4IZZxh7eEJMU3asSwLOhFzKyaayjUwG5zyWPgIB5gf35WtABkaarDi/
 PuuFbG6a4TRZnSDTLekYTA0pb3mw2+LEiePMvyl5boxTcYNEXCchcWu4ZdYj3K/nKe3A
 YBb2lJ/aRuW5Mcp8//uLbRVR7yvOObnZd81nswBIQdLJulQa9gPHXBWIaKwYNXx1xLhI
 VMlaNbJPG29Kw1ZITwZofQgttzG5yfLwBAH1meiEW7c32yVAXnicBrkVcGtq29Lk6Xak
 YWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028188; x=1691620188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QX2IEM9dRwmrf277j4zOSy3qa25+owguTvW7VNekX1w=;
 b=kcl0HPghHe8PRFcAqwRHzB/rD1uYGRbmlCoFlqFjr4CCl9U6xQ6pZMDW3+Tq1+hBs8
 EVhlQ64+/wsdPJ5dbbCJ/oTbl4A4N74bTQer6uQobDGxF3kLTUurTQm1RMmukqJTUhPy
 u7kHIcCt3bxZhNcVkQnFTaGFAYzy+TM5p+oh0fP6KDE7APfXgFmgCGpaHldnXHeVYpbd
 eKme2Uw2POlxU1DPFdTZAKdF4LuT4fDaH19cqSb2T8OS0rzFw/FnpykZ3JUtPG5oXHpZ
 tMLAeR51OAzjWzYFIrBhbWP8WZRm7JJ9yRfYTafr+uKXcpLp3tShQGYcCCUvMEBFcTRl
 bMmA==
X-Gm-Message-State: ABy/qLahu/h8X9XHmfyq7nNJf4819ySKApMEj29pEmlo2UxhGzG90Vn0
 yC/fQdgQ+9eaveHteQ0GHQaLdsp7KB2/M6JdA/kwiw==
X-Google-Smtp-Source: APBJJlGPVDVxPrCNF+aS8TsvpXtYugtaJxvG+TZPylmN7hd9GTz7nSKEYVHiKt9vY5BH42kA5lWZrA==
X-Received: by 2002:adf:f592:0:b0:313:f1ec:f429 with SMTP id
 f18-20020adff592000000b00313f1ecf429mr11955357wro.46.1689028187859; 
 Mon, 10 Jul 2023 15:29:47 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 y3-20020a056000108300b003141f96ed36sm579893wrw.0.2023.07.10.15.29.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:29:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 40/44] hw/isa/vt82c686: Remove via_isa_set_irq()
Date: Tue, 11 Jul 2023 00:26:07 +0200
Message-Id: <20230710222611.50978-41-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
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

From: Bernhard Beschow <shentey@gmail.com>

Now that via_isa_set_irq() is unused it can be removed.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20230531211043.41724-4-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/isa/vt82c686.h | 2 --
 hw/isa/vt82c686.c         | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/include/hw/isa/vt82c686.h b/include/hw/isa/vt82c686.h
index da1722daf2..b6e95b2851 100644
--- a/include/hw/isa/vt82c686.h
+++ b/include/hw/isa/vt82c686.h
@@ -34,6 +34,4 @@ struct ViaAC97State {
     uint32_t ac97_cmd;
 };
 
-void via_isa_set_irq(PCIDevice *d, int n, int level);
-
 #endif
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 8016c71315..57bdfb4e78 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -592,12 +592,6 @@ static const TypeInfo via_isa_info = {
     },
 };
 
-void via_isa_set_irq(PCIDevice *d, int n, int level)
-{
-    ViaISAState *s = VIA_ISA(d);
-    qemu_set_irq(s->isa_irqs_in[n], level);
-}
-
 static void via_isa_request_i8259_irq(void *opaque, int irq, int level)
 {
     ViaISAState *s = opaque;
-- 
2.38.1



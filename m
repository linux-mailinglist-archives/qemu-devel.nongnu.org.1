Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7200370C278
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 17:34:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q17Wi-0007hu-UC; Mon, 22 May 2023 11:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17Wh-0007fR-0B
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:32:47 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17Wf-0001W1-5N
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:32:46 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f606a89795so8951065e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 08:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684769563; x=1687361563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Cw30KRr0qwwjcjVLXiu2a6Jw/GDPIIDdtlKN9G+WEg=;
 b=jZVIhtxgsZKCPAyVJ1rubFhXRwSyB8yBf951IXSK22A8pvhlLdv9fEUSwo8Md8NWYg
 Fdgor+NAr64RrgZ+I653NYWxogB3UAB0pJQVVpsKh1gBDJqW3az+RCeMONd8U/cI8z+h
 SyS0IGSDNWx5h0Wdg5PaTsEsmUgg0gLB2GomrRRN9Pq4kIExCWsgDrRFhH/YFIw9234z
 BJYmoNeW8LkTcQ/xWT4BE1pLU6XpJMKTmZgdVfNmZrrGibgtwqMLOC4KlQkvHCU+yDd/
 giRI1DsGTdZp9YkuRb3sVO7arCM0qlqHOfZwBKEQW+CueT00kbQxWyEsWqQThmwYnepE
 Jraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684769563; x=1687361563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Cw30KRr0qwwjcjVLXiu2a6Jw/GDPIIDdtlKN9G+WEg=;
 b=jgwOXxmTIa3H8AiwChXtXaxvWHFR3dMb0YXHYWW9NuVtLEFhAzsU1j8mIb8N2rzgZb
 hSsrBQgK8AJVAncja4rkb4ehCpiXHRmoYe4Yboz8wnG1yKja+aHxZff1X1GCWqHsumth
 FN7G59gdQwZqNLm4lfmIUWsrS55xTTFD/7hZsR5KRaK42XhHiPy2DkLVoAcUMHsJyPwp
 +0jYOfpSwHK/9uYdMzCnM22bdlbTh69tMIWaa3zklaJncdjCrNrkNJp8+oSBI2Id/4vE
 cqLuFUELCbYJ/5BIt7s2k2uZO7yMK15LNp23eMBNTGF2dOzYttq12eGam1ATDOWTnII/
 yh7A==
X-Gm-Message-State: AC+VfDwRu48L5XrmVHf7jrORldPV76SKIk4itYw0Bz1pAsiPec0P19VA
 HepdClA/XzHPNdLuhcJEcykKs64mpw0YMZTp8cg=
X-Google-Smtp-Source: ACHHUZ7V+Ar12+UJMLcbWfJE71sPxCd6cPLuMDkPRtta0A4DvstrTKk/Jri6QgCzk2oKZJjqCMvO7g==
X-Received: by 2002:a05:600c:22d7:b0:3f6:8f5:f9e4 with SMTP id
 23-20020a05600c22d700b003f608f5f9e4mr200948wmg.35.1684769563339; 
 Mon, 22 May 2023 08:32:43 -0700 (PDT)
Received: from localhost.localdomain ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 j17-20020adfea51000000b003063938bf7bsm8019037wrn.86.2023.05.22.08.32.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 May 2023 08:32:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/12] hw/char/pl011: Check if receiver is enabled
Date: Mon, 22 May 2023 17:31:42 +0200
Message-Id: <20230522153144.30610-11-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230522153144.30610-1-philmd@linaro.org>
References: <20230522153144.30610-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Do not receive characters when UART or receiver are disabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 30bedeac15..1ec102d8de 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -77,6 +77,7 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define LCR_BRK     (1 << 0)
 
 /* Control Register, UARTCR */
+#define CR_RXE      (1 << 9)
 #define CR_TXE      (1 << 8)
 #define CR_UARTEN   (1 << 0)
 
@@ -348,9 +349,11 @@ static void pl011_write(void *opaque, hwaddr offset,
 static int pl011_can_receive(void *opaque)
 {
     PL011State *s = (PL011State *)opaque;
-    int r;
+    int r = 0;
 
-    r = s->read_count < pl011_get_fifo_depth(s);
+    if (s->cr & (CR_UARTEN | CR_RXE)) {
+        r = s->read_count < pl011_get_fifo_depth(s);
+    }
     trace_pl011_can_receive(s->lcr, s->read_count, r);
     return r;
 }
-- 
2.38.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4067D147E
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 19:02:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtsrN-0002Vi-Ut; Fri, 20 Oct 2023 13:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtsrL-0002VM-4Z
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 13:00:27 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtsrJ-0008Qx-9o
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 13:00:26 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso775308f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 10:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697821224; x=1698426024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kt78QWV8SLX4gIgX7BJ1w/k7e1eNEVxwNDppyA4h62Y=;
 b=buGso4mNLI77CVJxVv1P21yRdMP8Galoo/kQIGf25ymVheKhYkOPtoYeUuG1osbshq
 SVcF92XDIZMAg06cw5/sHNGv74RQaDp0wfhjkO4iOoe7t5iyT+fukAM6+4YRGheAr8lR
 pqIii50ZiqEQDLE0NSSg93Rs3lpxPxciHCOk+tqE4oRhE6cNngjzqRr8AarV4CVgvkNE
 /qoNeQaiBkpREqXLWcdxI+7lIPMtCu++MwG08/uovlu6LNTGqcPzaebb0DLWMBItRVMK
 DsKUDps1RRqKQWfks/slFbUJI6O9Png7L+5EtASMgRAad5fYWqFweVQ1lraXZwEFjxcW
 IQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697821224; x=1698426024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kt78QWV8SLX4gIgX7BJ1w/k7e1eNEVxwNDppyA4h62Y=;
 b=vDoCAyuNUy3/0RW2/QJdTLeavfUnum91EHZgdRD1fhm1xcCaB4lGVhA95aqnCWBLVI
 IazsijkNOSLyU4rRYFI6qC0gHI0ty4tKGPbpzoYLgU7qAhl+3EVmjwu/TcxxpSPfdTzR
 BGhxleqwaF/QGgXXcJsUIqQqOM8Xh1gc8sT65pR0YmHz5chG30v7OB5gj6Myu40tmbky
 x3yOfHIcMaDt3DOU8NtwfGtD+BALk571uGSn1I1iEyarC2MjFpImFhQX3HAquDW0fAe7
 SegYX88v5zbX6rV+tqvFIA/q1soQvGOOactrGJUEtRF1Bf41xk6UVQlQqnk2uRuH5/Xc
 4WVw==
X-Gm-Message-State: AOJu0YwFOiJIVAHIp9jBtFF5l4UJvRqkpeEH3fPiqeDuMt9J9IG6NBMA
 TyHc5idxWO/pRocS/xpfjV9xRQ==
X-Google-Smtp-Source: AGHT+IE0rkveu5itzxct08yLC/FHyKKiTJ4w/QvK65rA2OK2aJf041pbt3f1hLmyfW/hiXX8Ryl/0w==
X-Received: by 2002:adf:ea4e:0:b0:32d:9524:386b with SMTP id
 j14-20020adfea4e000000b0032d9524386bmr1975736wrn.32.1697821223908; 
 Fri, 20 Oct 2023 10:00:23 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 r17-20020a5d4e51000000b0032d09f7a713sm2068815wrt.18.2023.10.20.10.00.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 10:00:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/4] hw/char/stm32f2xx_usart: Update IRQ when SR is read
Date: Fri, 20 Oct 2023 19:00:06 +0200
Message-ID: <20231020170009.86870-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020170009.86870-1-philmd@linaro.org>
References: <20231020170009.86870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

From: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>

Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
[PMD: Split from bigger patch]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Is this required?
---
 hw/char/stm32f2xx_usart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 519d3461a3..46e29089bc 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -109,6 +109,7 @@ static uint64_t stm32f2xx_usart_read(void *opaque, hwaddr addr,
     case USART_SR:
         retvalue = s->usart_sr;
         qemu_chr_fe_accept_input(&s->chr);
+        stm32f2xx_update_irq(s);
         return retvalue;
     case USART_DR:
         DB_PRINT("Value: 0x%" PRIx32 ", %c\n", s->usart_dr, (char) s->usart_dr);
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A027DF905
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:42:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybfH-0003Pk-Cr; Thu, 02 Nov 2023 13:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybej-0003HM-Db
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:39:00 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybef-0002ug-Ul
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:56 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32f9268bf8cso668694f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946732; x=1699551532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jF0lqfreU7N6ImEIjsmoU/+iBQdAY2xp+peBqMSgOts=;
 b=W9XGCU52g/QoDpMP2KolJxevk+TYo8ncUUnU13gINWs3kXuZAEwFYJ+nB4KtL6QLMC
 iqwd/ZVi6teCV4amN5r+HNmf6GWnlgeXM0ktRkSZPHQU0+0jn6VBNJ3X75KLVN+PqpCV
 5Y/AAv8Sm7tU0zZpDwurp/AyLeij0nnE9WSQ6AxSaidHOTGUspaY1a966Ga5JKFTVpQO
 FVD4td5zCtNx4FWrUkW/6zjyQhOj6ecrlKWQUrJIFTc0u8m6n2+01AubU72raUO7B+cD
 SivR97ZQOsjQk5q5CL+nvGA2dhXjS0ML6ctS9u37uqi2nvcl98MuIUTjP571l0cM+qO2
 tcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946732; x=1699551532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jF0lqfreU7N6ImEIjsmoU/+iBQdAY2xp+peBqMSgOts=;
 b=eDPh6/sIGifb3umoCxnVbAwFVYmEve4Lq6NIcFqGgTDBojvk8XsoWYrcmISCOXQXYt
 /KXzcQ/dHVdlQDFYq2sOZZIuvwmhHa4fGzPrjZ2M6oWz28fHfjfeYSzhcszC2YhuSS84
 DeQdkUfrq8JWWmHwT9+59E8K2aDBe16TtFImAZOPFiFzdDneo3HfyrrDdxnon/oVESzR
 H7nP7QVa6T2gQqwVS7SMQZvGUDZYqUMYnLzPRBpQIa3htuzvFCxafdrSW26Q3wChlCOg
 8BdrNPus8BvWmKHSdNid354ftmmebfdwz3uwwJaymB3IP5DIr3Gia+LDjg9UaBLVI+57
 U0KQ==
X-Gm-Message-State: AOJu0YzuhEQLUiKP4FrZfYIIzxdxaAuCm3FHVgmGB/5FVK2w6MkO6dii
 1+Nzom6gsH5wNr0Cpk5IWMNpb1IqcwTo8WY29vg=
X-Google-Smtp-Source: AGHT+IEo5uZ4Pi73dlWaP/08XpdrdLwSvDm3WqLvHUqkd8jB/Y1iLrP7pjPHUxABlVMppoYKRGdE/Q==
X-Received: by 2002:a05:6000:194c:b0:32d:a3a0:e927 with SMTP id
 e12-20020a056000194c00b0032da3a0e927mr12358068wry.58.1698946731882; 
 Thu, 02 Nov 2023 10:38:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/33] hw/char/stm32f2xx_usart: Update IRQ when DR is written
Date: Thu,  2 Nov 2023 17:38:30 +0000
Message-Id: <20231102173835.609985-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
Message-id: 20231030151528.1138131-3-hans-erik.floryd@rt-labs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/stm32f2xx_usart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 519d3461a33..8753afeb2b8 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -168,6 +168,7 @@ static void stm32f2xx_usart_write(void *opaque, hwaddr addr,
                clear TC by writing 0 to the SR register, so set it again
                on each write. */
             s->usart_sr |= USART_SR_TC;
+            stm32f2xx_update_irq(s);
         }
         return;
     case USART_BRR:
-- 
2.34.1



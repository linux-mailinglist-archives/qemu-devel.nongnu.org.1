Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9B47DBC76
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 16:16:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTzq-0002gT-07; Mon, 30 Oct 2023 11:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hans-erik.floryd@rt-labs.com>)
 id 1qxTzg-0002cu-Re
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 11:15:56 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hans-erik.floryd@rt-labs.com>)
 id 1qxTzf-0002tm-AE
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 11:15:56 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2c50cd16f3bso63625711fa.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 08:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rt-labs-com.20230601.gappssmtp.com; s=20230601; t=1698678953; x=1699283753;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1JUS7ifgalxeVgxcJbIBOgd0URmCI4bQYikVDqFMDKM=;
 b=OunuuiTJZc3cRRQkTcSz5+Vzw8MD92P3ZB0tc2UI/AptrqUGi9R3NlNKv/1BBt10L5
 ScEElok1w//DxGZgcqK8i04Mz71/OONO5ct955vuOj7djIF+ubxR3iZ/SbgssAHzznMn
 rFZHw98CMAJjCxWx18B77uLpF6yKI7NDUwvHiGOiWpwFP6NzJL+O5k3O4G3Hw/RQMC9V
 iwNbgFv8IxHUcHUhvuAC2RQ3SHBTZLusNLlLlB+W8OYwctY04eeu+NAKwVnxcuWfa3Xn
 vOm/5/eiGF27JVzKoeOWj/6x5rwNbD1UUkvU1NTnEld9epz7106+5KhWu7PnK4v8eBe5
 CdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698678953; x=1699283753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1JUS7ifgalxeVgxcJbIBOgd0URmCI4bQYikVDqFMDKM=;
 b=KXu6JeQp8aMtEiOxA3Mlduww/h2GRhr7MjCCZBj2Ape7v6XNQ82LdPqw+C/r1CX8H9
 3eE0hjCqHJWs0fEi9kTCcQA9FOz6gn86rlCz6tKXhKib7d1Y2xkwWEGKBxI4tvQHHWqj
 Zo+j0iP2su488RnLH7wjTYfmfb55bYDyEA3Q7KEoxHgdYsZkK56IPEMG8IgT8RThKErC
 +goeOZtcOdKLwYiSYTJJeibFiADmOdHHhaQGpmesVymLFGwgUGuWtGWR3kMsPC2+gjAW
 PBfmLiWm1jkX39npDejVxw2D5bfySqwLlU4JnsdHFMYFmciirc7Hhl7Bav7d4BeKzRRq
 Re0Q==
X-Gm-Message-State: AOJu0YzBEGN1udBYlZpmhfmc0E76TwO/ja6Mwd7cPPTMY8FihRK7seFF
 pUToKOaAvezTgwZFfOlcjkyvFg==
X-Google-Smtp-Source: AGHT+IF6RnKtKYMShby9g89IqqraZUtFJ/ZTHZGCGOpnTa6zxXATIy18dUDkrb7cllZ1o9jaCSfYaA==
X-Received: by 2002:a2e:8910:0:b0:2bb:a123:2db7 with SMTP id
 d16-20020a2e8910000000b002bba1232db7mr7501407lji.51.1698678953257; 
 Mon, 30 Oct 2023 08:15:53 -0700 (PDT)
Received: from rtlap47.intra.rt-labs.com (h-213-136-33-86.NA.cust.bahnhof.se.
 [213.136.33.86]) by smtp.gmail.com with ESMTPSA id
 j18-20020a2e3c12000000b002b95eb96ab7sm1282274lja.18.2023.10.30.08.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 08:15:52 -0700 (PDT)
From: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
To: alistair@alistair23.me, peter.maydell@linaro.org,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, philmd@linaro.org
Cc: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 2/3] hw/char/stm32f2xx_usart: Update IRQ when DR is written
Date: Mon, 30 Oct 2023 16:15:17 +0100
Message-ID: <20231030151528.1138131-3-hans-erik.floryd@rt-labs.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030151528.1138131-1-hans-erik.floryd@rt-labs.com>
References: <20231030151528.1138131-1-hans-erik.floryd@rt-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=hans-erik.floryd@rt-labs.com; helo=mail-lj1-x236.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
---
 hw/char/stm32f2xx_usart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 519d3461a3..8753afeb2b 100644
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
2.42.0



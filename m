Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12054735998
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:33:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFtW-0001kk-8V; Mon, 19 Jun 2023 10:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsp-0000eD-K6
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:31 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsn-0002Fn-21
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:30 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f849a0e371so4434159e87.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184967; x=1689776967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JqZ8k1zAHq1ZWAnTPJViyRqU+IGDsCc34HFn4gFwiZ4=;
 b=gSbpZbTP0baG6wqKoeRF5IHGfGm4MCDu6iYXP9C5t69C4/t60m9gS3ehGueDBnMX0x
 1zHEQBAvbwAqxgawAvqs8hZKlxWl7Cv9JBAhlCuwFK4kOr5P1tsKxaeRnDGPvmfJsBi7
 vNLL+cILPaW8kSxRODLtWkriAjVESjBwGE0uqAMH3Cg0O8rC15kEUKpRNq5QB4dySj/4
 DiU3bWzTr/nAEDHW0Zb00MN8r4zIPXM2j4vzEMvvyra0UhmYC6kgha6pw9BkCUHeBt7T
 Z8hEAVnQ66phAy80UtF4idDzySQvNjBswFtIk6NZAubwFSR1Ml+Z4BX9e5p2IY530/+M
 E9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184967; x=1689776967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JqZ8k1zAHq1ZWAnTPJViyRqU+IGDsCc34HFn4gFwiZ4=;
 b=ANZn+LQvUFtwMw+n8BGEgVFOy029R1VkevgGjd5BdLkL1kIgMn2KdfKtGUlPne5wfs
 5ECt/BoNVlTAzWS8phDJSzFBpphZ8fUlY7DhTLGIPdOblfQTD0PwgRimwEZx78nBBVKH
 RhtCqnRDOdj8vx2Gw2oSmfTOijiGoy+apDqxdYfrnYW2O36w/+yoAnWjWioCe6jOULOi
 gq5A5g+6qj2PuZncxLYa9vqSZlhJ0Hvk7+bpR/T3orC1BvUgM5YQ3KMtMO0zurFvbJdQ
 19OgFGu8Dv2iMlePsrmM01MlSgVcOnyYulfXdvScm8pJ4OnXMcDNxqnn/dJPVo/82ayH
 ejyw==
X-Gm-Message-State: AC+VfDwJUHLdIFfsg7z7Ru1s9pcD1z3UhqdFrqW1Wa4Nl48BEswOvlvR
 z6oXfLh+9uxE4qSwkh4g9WhX+oRgvjcP273JoiQ=
X-Google-Smtp-Source: ACHHUZ70lhxB9h7f6mamtvVOmyylqolOwFGhVX4Pe1DDJc3Xq6PGZoNgX7kU51IE44uQfc3H/dx9dA==
X-Received: by 2002:a19:e057:0:b0:4f8:7551:7485 with SMTP id
 g23-20020a19e057000000b004f875517485mr945522lfj.5.1687184967203; 
 Mon, 19 Jun 2023 07:29:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/33] hw/intc/allwinner-a10-pic: Handle IRQ levels other than
 0 or 1
Date: Mon, 19 Jun 2023 15:29:05 +0100
Message-Id: <20230619142914.963184-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

In commit 2c5fa0778c3b430 we fixed an endianness bug in the Allwinner
A10 PIC model; however in the process we introduced a regression.
This is because the old code was robust against the incoming 'level'
argument being something other than 0 or 1, whereas the new code was
not.

In particular, the allwinner-sdhost code treats its IRQ line
as 0-vs-non-0 rather than 0-vs-1, so when the SD controller
set its IRQ line for any reason other than transmit the
interrupt controller would ignore it. The observed effect
was a guest timeout when rebooting the guest kernel.

Handle level values other than 0 or 1, to restore the old
behaviour.

Fixes: 2c5fa0778c3b430 ("hw/intc/allwinner-a10-pic: Don't use set_bit()/clear_bit()")
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20230606104609.3692557-2-peter.maydell@linaro.org
---
 hw/intc/allwinner-a10-pic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/allwinner-a10-pic.c b/hw/intc/allwinner-a10-pic.c
index 4875e68ba6a..d0bf8d545ba 100644
--- a/hw/intc/allwinner-a10-pic.c
+++ b/hw/intc/allwinner-a10-pic.c
@@ -51,7 +51,7 @@ static void aw_a10_pic_set_irq(void *opaque, int irq, int level)
     AwA10PICState *s = opaque;
     uint32_t *pending_reg = &s->irq_pending[irq / 32];
 
-    *pending_reg = deposit32(*pending_reg, irq % 32, 1, level);
+    *pending_reg = deposit32(*pending_reg, irq % 32, 1, !!level);
     aw_a10_pic_update(s);
 }
 
-- 
2.34.1



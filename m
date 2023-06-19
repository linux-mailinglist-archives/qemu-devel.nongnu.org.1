Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B46F7359AC
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:34:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFti-0002LQ-4O; Mon, 19 Jun 2023 10:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFss-0000ef-LW
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:36 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsp-0002Gi-Aw
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:33 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f9002a1a39so19964235e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184969; x=1689776969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MmGNmH8MdwxGE6tW13V4FAIDv1rJBSbOYavkF0+ToBY=;
 b=xwGgUekKwmHsgQwM+wLcF4p3ZuRMqDeLXnHUq/qhBEy0LLE7JBb6ZIVKMDFiWGlZYt
 3jP1wDjiyfexzrmYC+RrLh9yDptfwAcAGYqQ15OkSdKnE463IDlGh2SpBzEZWtUhLleY
 8iKe+3vC6u+veiHvYr278fmkoEJwLF16x5rULGLck5kWw1V+smElk35x3I/TILh1+gAK
 n1Q/BE+J1Avl76eaEeTAFbwROIG52AvFHxAid3JhTMKFz8VMWKm1+qpUSinYFh+Nykol
 h3pIpoT6cwD2pECRKvt98F8S/MXQ/FaSP9bVs0xKXr49htxMemi7/dEt8cL2JF7ft47k
 Q0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184969; x=1689776969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MmGNmH8MdwxGE6tW13V4FAIDv1rJBSbOYavkF0+ToBY=;
 b=KmwLCnsNfe8tQlnvlbdXi0+0VboJcQPl/V5cVeANF9XoOnOyLNTyJkrBDN991s7tHB
 0ayv877RgOvB0SbZO8rMLe8a4Vi5277/ArrYSxYgKuB8AUUqALZfGXsPbBuiEYZL75L1
 KRuZpm2tOtoyoxYEHmZ8ec8xevnH6Pk/oEYEDnkGXs6UwpYjUXkd612ctrstV0EDU8pI
 BMZAgjAEllZJhGsx2g5cckX5ysjhZ4U4fd3ZzO2XtwAqh2UtwkE7QCtAXEXR6fbiZiRe
 g9+SH1kuuEFYRw21hW7YWwBYDU0NT7fu30sriAyH82Szyc3MPCio21xnfm/xEUwMNnD1
 g/8g==
X-Gm-Message-State: AC+VfDxLMHmzk3NiCHBerD1h2aZmqkOdbLvUVtomtmuqYZw19WTM3LAi
 B4BCG8pO8kwCMEsfzuT+TmhSxRl5BGPKfywgILM=
X-Google-Smtp-Source: ACHHUZ6ZP+lsSzDGEEBPzEwwuz3tLwkDv127ahGD9L7SfeFda5dUzdaSONaYPj3vozPC08DsaXmIkw==
X-Received: by 2002:a1c:7514:0:b0:3f8:fe2a:25c2 with SMTP id
 o20-20020a1c7514000000b003f8fe2a25c2mr5644661wmc.38.1687184968944; 
 Mon, 19 Jun 2023 07:29:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/33] imx_serial: set wake bit when we receive a data byte
Date: Mon, 19 Jun 2023 15:29:09 +0100
Message-Id: <20230619142914.963184-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Martin Kaiser <martin@kaiser.cx>

The Linux kernel added a flood check for RX data recently in commit
496a4471b7c3 ("serial: imx: work-around for hardware RX flood"). This
check uses the wake bit in the UART status register 2. The wake bit
indicates that the receiver detected a start bit on the RX line. If the
kernel sees a number of RX interrupts without the wake bit being set, it
treats this as spurious data and resets the UART port. imx_serial does
never set the wake bit and triggers the kernel's flood check.

This patch adds support for the wake bit. wake is set when we receive a
new character (it's not set for break events). It seems that wake is
cleared by the kernel driver, the hardware does not have to clear it
automatically after data was read.

The wake bit can be configured as an interrupt source. Support this
mechanism as well.

Co-developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/char/imx_serial.h | 1 +
 hw/char/imx_serial.c         | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
index 91c9894ad55..b823f945195 100644
--- a/include/hw/char/imx_serial.h
+++ b/include/hw/char/imx_serial.h
@@ -71,6 +71,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IMXSerialState, IMX_SERIAL)
 
 #define UCR4_DREN       BIT(0)    /* Receive Data Ready interrupt enable */
 #define UCR4_TCEN       BIT(3)    /* TX complete interrupt enable */
+#define UCR4_WKEN       BIT(7)    /* WAKE interrupt enable */
 
 #define UTS1_TXEMPTY    (1<<6)
 #define UTS1_RXEMPTY    (1<<5)
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index ee1375e26d7..1b75a895881 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -80,7 +80,7 @@ static void imx_update(IMXSerialState *s)
      * TCEN and TXDC are both bit 3
      * RDR and DREN are both bit 0
      */
-    mask |= s->ucr4 & (UCR4_TCEN | UCR4_DREN);
+    mask |= s->ucr4 & (UCR4_WKEN | UCR4_TCEN | UCR4_DREN);
 
     usr2 = s->usr2 & mask;
 
@@ -321,6 +321,9 @@ static void imx_put_data(void *opaque, uint32_t value)
 
 static void imx_receive(void *opaque, const uint8_t *buf, int size)
 {
+    IMXSerialState *s = (IMXSerialState *)opaque;
+
+    s->usr2 |= USR2_WAKE;
     imx_put_data(opaque, *buf);
 }
 
-- 
2.34.1



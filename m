Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8C07DF8FC
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:41:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybfN-0003ZR-Os; Thu, 02 Nov 2023 13:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeh-0003Gp-Fg
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:55 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeb-0002lX-Vn
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:54 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50939d39d0fso1531699e87.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946727; x=1699551527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iD8xvESJqhMdvRBcqDuQwzM17Zf84AgBfxQAOku4bfg=;
 b=BB6Eu+7UYCnQUq9+1kXS46sSQX1D1IzbjlZkNGUicpvE/OnaClV26NzAhcqMvecS9+
 QgVxD8ggm+ttlamFf0fWRnd0aVBu9HNXXpldgYkMXcvRdx1JG/uEQ7i8k2sTe/CRC6U0
 dfhpKiBJ/bB9vE61CoOA5iq4yDKFtm8w5nR9NF0S1gtjdVeguC2bDhZKUDj9hbLkG1z0
 fXuNzIuUQQlS98ZIkiKtjn78LYryIeo3876dioUkslQ4fbcTgY9JmBL/MbZCQiZFq/Wu
 lC/MZtMGdcaqzZG4Znx6ia8tjJMKit+7H+pnHZUPw1eVmXj3UbE/KIB2+uHo6JaNmVwv
 bTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946727; x=1699551527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iD8xvESJqhMdvRBcqDuQwzM17Zf84AgBfxQAOku4bfg=;
 b=hksqG/NZf6cWllQzBFMllRd94zesBpQKbWm6M6BCfIOyRqpb9nCkDOk3L3Uz7LHLD8
 NHK79SGzGHDvdPobKWa1HJx2ncyOj4iql2jTmRtpvRhEpquXC8c0wwo4PrZ7lx+XmU/b
 i5YYRJFUf8uqjc39Z1aehU4oWdIkawxj2xh+YPhCuT+kvDDSfmDrYZsZbnz7qyAvxM1O
 P4ofc6LMoUKLeWq+eDPzSMEvWqtPioroRXoyJlZ+U18sOFatCN9e7XgSI/Nc9IcOuyIT
 vZQviX23hO0MJqgnVuWghPLDcdvX15Qa92bHOSJIm0bzMTVS1t7Wu9i8lq/7svdbKuNo
 2HAg==
X-Gm-Message-State: AOJu0YxtvoATEuVXIJJxVAQPm/I+1HqAxn7Ur7/xek/nD7vtY/EulEOi
 gYiHP3zwc95FwVRPqGtvCU6UNxQCV29JVBbp2JE=
X-Google-Smtp-Source: AGHT+IE8sO82x6+MGVGje2B+GxBYaoa5XxAa6eHax/2+AopM8tUgH3gB3/agzGqI569xV4B9xJ1ubg==
X-Received: by 2002:a05:6512:b87:b0:509:4424:2e13 with SMTP id
 b7-20020a0565120b8700b0050944242e13mr4110590lfv.65.1698946727592; 
 Thu, 02 Nov 2023 10:38:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/33] hw/watchdog/wdt_imx2: Trace timer activity
Date: Thu,  2 Nov 2023 17:38:21 +0000
Message-Id: <20231102173835.609985-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20231028122415.14869-3-shentey@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/watchdog/wdt_imx2.c   | 4 ++++
 hw/watchdog/trace-events | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index 885ebd39787..891d7beb2a1 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -23,6 +23,8 @@ static void imx2_wdt_interrupt(void *opaque)
 {
     IMX2WdtState *s = IMX2_WDT(opaque);
 
+    trace_imx2_wdt_interrupt();
+
     s->wicr |= IMX2_WDT_WICR_WTIS;
     qemu_set_irq(s->irq, 1);
 }
@@ -31,6 +33,8 @@ static void imx2_wdt_expired(void *opaque)
 {
     IMX2WdtState *s = IMX2_WDT(opaque);
 
+    trace_imx2_wdt_expired();
+
     s->wrsr = IMX2_WDT_WRSR_TOUT;
 
     /* Perform watchdog action if watchdog is enabled */
diff --git a/hw/watchdog/trace-events b/hw/watchdog/trace-events
index 874968cc06a..ad3be1e9bdd 100644
--- a/hw/watchdog/trace-events
+++ b/hw/watchdog/trace-events
@@ -20,6 +20,8 @@ aspeed_wdt_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " si
 # wdt_imx2.c
 imx2_wdt_read(uint32_t addr, uint16_t data) "[0x%" PRIx32 "] -> 0x%" PRIx16
 imx2_wdt_write(uint32_t addr, uint16_t data) "[0x%" PRIx32 "] <- 0x%" PRIx16
+imx2_wdt_interrupt(void) ""
+imx2_wdt_expired(void) ""
 
 # spapr_watchdog.c
 spapr_watchdog_start(uint64_t flags, uint64_t num, uint64_t timeout) "Flags 0x%" PRIx64 " num=%" PRId64 " %" PRIu64 "ms"
-- 
2.34.1



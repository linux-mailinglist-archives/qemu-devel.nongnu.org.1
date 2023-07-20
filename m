Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A9E75B3BC
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 18:03:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMW3t-0000Yl-Kc; Thu, 20 Jul 2023 11:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMW3X-0000Ww-R3
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 11:59:07 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMW3V-00053Q-I9
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 11:59:07 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742eso8466985e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 08:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689868744; x=1690473544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SzNtfI3TP/wA6vffJRkjpFoMkJ0EgXW2e/UYOIIB1hM=;
 b=RDhqxn/2Q8IIgM96ul0f8XeG+GNYAYGHkTKcTCuTclukKJy0YzZUFmukxxrMJ2iLQW
 KInMu+vYFsFOavLudpWtGeKdO7ONrBneD4h9eBgsXeUWL6ANlFrHdN+61XeOJw78r+GV
 T13xNY9zBbRSxC03xX5xzo3/zF8qcas/CdLEEK00WmSvCJjMfGVmbQpxPns9B5KfG4SI
 v+kMUjqKkbL40cehsJjWlS5XYgNYlztpTty6bzm7EDeeCqgeLWqIIvV7w8itFQHcKJgO
 cJ6XEHk5q9BeYG2DG9gfX6Wa6MzGVdTgyEmeuQgQXngM3TMQ1LTtZFUH/x/mEgrzjYPo
 YhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689868744; x=1690473544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SzNtfI3TP/wA6vffJRkjpFoMkJ0EgXW2e/UYOIIB1hM=;
 b=LVbTueV7rnqIZYXi02WWrHdhslHbSsFN/r1si7Ww08DT08kEH2qfMMtkOZESvS80wX
 59j+4n4mkM2puSTw8+tjbgGw8WoHA7INdus/vwHy+xCW0yZ6JLCvjRdX3zuvxSYZnKiv
 Ue4vQDnngzEzscVruG93G5PXUouB4qtLtzQl5Wt6q1xnIuVJQRURMB2k3chMttFudJec
 HV+v47LV22s9NXtBZDeXW40+Jp34G0UAXhJa7GjPmbLNrOuCO0FkipQozcyGdV0qYLYE
 mxPx14WO+pkZeoI7FyS+MJLczHcX2mKSnckfUMO8jnYK7NXTw+Na/ycP7wYibzqS/vBm
 UPTg==
X-Gm-Message-State: ABy/qLacjLYULK9gIpBQ4Nhgz/24ppd0kv8shiHMEClWbXU0tH1HqqXD
 g5Stdt3rhTnHUuIOr/Q1iMBo0K77+9numoSxRak=
X-Google-Smtp-Source: APBJJlH5USkAaP37iXPEdZz7u+4OcjyttG7pJV8ELRUo1QoflntYpcGrXZqTodbc3sa/1hQVLQ4auQ==
X-Received: by 2002:a1c:f30e:0:b0:3fa:91d2:55b6 with SMTP id
 q14-20020a1cf30e000000b003fa91d255b6mr2251865wmq.9.1689868744058; 
 Thu, 20 Jul 2023 08:59:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a05600c220500b003fc02a410d0sm4187572wml.48.2023.07.20.08.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 08:59:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Subject: [PATCH for-8.2 1/4] hw/rtc/m48t59: Use 64-bit arithmetic in
 set_alarm()
Date: Thu, 20 Jul 2023 16:58:59 +0100
Message-Id: <20230720155902.1590362-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720155902.1590362-1-peter.maydell@linaro.org>
References: <20230720155902.1590362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

In the m48t59 device we almost always use 64-bit arithmetic when
dealing with time_t deltas.  The one exception is in set_alarm(),
which currently uses a plain 'int' to hold the difference between two
time_t values.  Switch to int64_t instead to avoid any possible
overflow issues.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/rtc/m48t59.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index ec3e56e84fd..2e2c849985c 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -133,7 +133,7 @@ static void alarm_cb (void *opaque)
 
 static void set_alarm(M48t59State *NVRAM)
 {
-    int diff;
+    int64_t diff;
     if (NVRAM->alrm_timer != NULL) {
         timer_del(NVRAM->alrm_timer);
         diff = qemu_timedate_diff(&NVRAM->alarm) - NVRAM->time_offset;
-- 
2.34.1



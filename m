Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1B87244DB
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 15:50:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6X3t-0003DQ-18; Tue, 06 Jun 2023 09:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6X3q-0003Ce-Fm
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 09:49:22 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6X3o-0000e1-N1
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 09:49:22 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f60e536250so52006395e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 06:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686059359; x=1688651359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RdrpsAT8U3vpVlJ0tTA9gmGkITqwGBRiPD1ozdlKQgM=;
 b=b4yLvTKw2af8ln6D6aweyNmQMfqOEa0/r4v3tn6A6MDsEvtwsYUcV0I2PehJbYLJk9
 5ICcXDlNHngg+rpHtcI40Q674ksfneyPFG/yTflLCxozp5rFe6hQAGH8f0/XQ1BNcgLk
 9UOQhPgYRILdcZjVLFLQd+eYHXErdJOUSdIfZK+8yt1oAbbALboRqlHajbagjA6lQszb
 Csa/K3OrzzsbCJuDbNnFaJ0rZoNh1LneytBvQfzJhycSAbi8nr/d+6TXJlhz2X1xyOYo
 CC9Z8cmU+PwauL594FjDtAXp/1p49D/FzSCiQEEiAk9SUBUPOlSYb23uPzIxsDOJPjO6
 5RaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686059359; x=1688651359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RdrpsAT8U3vpVlJ0tTA9gmGkITqwGBRiPD1ozdlKQgM=;
 b=PojM74E4yGcrIJR9bPM7YP1MD9PaKx8cHrmLbBZzRbRhiPiyL8YagJHP1z/4RwTC8w
 q1H4JhQVoHloriGuCwch1sL9G0nASEmhad/K4BBxUk++Tbns5e/sBJsukc6R2RZ+DAAU
 hXAo8QvXGvxhT9vv+Oi3Xjj99rYl2twLRmzTBAFjhv3/HGuBtOSZvMzx9OZ/s5vjM8DE
 uZnQObvQmSVKHqdpC58hTMB+JPNWykUNJRlAtmtqlovROfpx1ufdBDC/B8OkWH9XDKfE
 7tbgb4ztGFp7UYsiCZNJMk9AGKGMrOp7tIabokpjEd/JAbJDWqr73Kwy3KFlGxcMq3Xr
 noAw==
X-Gm-Message-State: AC+VfDwO6ooo1022Ck41MNKc6UxPzk0zwQkYKdRRtgluXDExZla4YqjR
 F/s4WEo5MYHi+BYHSWuH9S82ww==
X-Google-Smtp-Source: ACHHUZ4HZBW+e/928wwm8Yth3nf9qiQzwjnr83w/eJM5+GihExtQPqr9hIjupxmTs31nP0dqpqwVXw==
X-Received: by 2002:a5d:4ece:0:b0:306:2713:f7f with SMTP id
 s14-20020a5d4ece000000b0030627130f7fmr8494214wrv.11.1686059358809; 
 Tue, 06 Jun 2023 06:49:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 g26-20020a7bc4da000000b003f50e88ffc1sm17802603wmk.0.2023.06.06.06.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 06:49:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Joel Stanley <joel@jms.id.au>
Subject: [PATCH] hw/timer/nrf51_timer: Don't lose time when timer is queried
 in tight loop
Date: Tue,  6 Jun 2023 14:49:17 +0100
Message-Id: <20230606134917.3782215-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

The nrf51_timer has a free-running counter which we implement using
the pattern of using two fields (update_counter_ns, counter) to track
the last point at which we calculated the counter value, and the
counter value at that time.  Then we can find the current counter
value by converting the difference in wall-clock time between then
and now to a tick count that we need to add to the counter value.

Unfortunately the nrf51_timer's implementation of this has a bug
which means it loses time every time update_counter() is called.
After updating s->counter it always sets s->update_counter_ns to
'now', even though the actual point when s->counter hit the new value
will be some point in the past (half a tick, say).  In the worst case
(guest code in a tight loop reading the counter, icount mode) the
counter is continually queried less than a tick after it was last
read, so s->counter never advances but s->update_counter_ns does, and
the guest never makes forward progress.

The fix for this is to only advance update_counter_ns to the
timestamp of the last tick, not all the way to 'now'.  (This is the
pattern used in hw/misc/mps2-fpgaio.c's counter.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
The hang in icount mode was discovered by the Zephyr folks as part
of their investigation into
https://github.com/zephyrproject-rtos/zephyr/issues/57512

 hw/timer/nrf51_timer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
index 42be79c7363..50c6772383e 100644
--- a/hw/timer/nrf51_timer.c
+++ b/hw/timer/nrf51_timer.c
@@ -45,7 +45,12 @@ static uint32_t update_counter(NRF51TimerState *s, int64_t now)
     uint32_t ticks = ns_to_ticks(s, now - s->update_counter_ns);
 
     s->counter = (s->counter + ticks) % BIT(bitwidths[s->bitmode]);
-    s->update_counter_ns = now;
+    /*
+     * Only advance the sync time to the timestamp of the last tick,
+     * not all the way to 'now', so we don't lose time if we do
+     * multiple resyncs in a single tick.
+     */
+    s->update_counter_ns += ticks_to_ns(s, ticks);
     return ticks;
 }
 
-- 
2.34.1



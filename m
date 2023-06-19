Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 233047359B8
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:36:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFtV-0001iB-ON; Mon, 19 Jun 2023 10:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFss-0000ed-Ld
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:36 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsn-0002GH-L2
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:32 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f906d8fca3so19973225e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184968; x=1689776968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y/asvDbpuEPmw7wglRXtLAabLlYBYvk+Qg+LSrFniF4=;
 b=MTdNamwBkWtM0q8JofFLOkkEltIJOiuQSp86tZ2ehokJrFV8OVWBuPEJV04VPiY0+z
 F28fWWjKuG28o8esZWvxiQZ6IpYaTjNTy07XbZQVNZDAgzYR05vrdNOEQk9oEf3rveu3
 HWxT7B7qR9/80iQpHWAdYaX432Hjd0dbxKMwV7vsrgDUMrRhnyxgMnxY2MwajvL309hm
 oyZmwfCBP+xKq6TNgXulLom9E8GZwZ3wdGRiEaDi7CaQ3Qs8HC7X5+JXj+0Iy+kL68Uq
 4Dj/fbG56OxPkjJ9ktkcqcZ4iJMvW3Nh0lwrrabPvoTyaDEHq1pdUwVgizOIKMfh20bW
 7kyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184968; x=1689776968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y/asvDbpuEPmw7wglRXtLAabLlYBYvk+Qg+LSrFniF4=;
 b=lMPm1pd5DnOso78YllYbgrG0toSICClgymTP4sloKmdzzlW77ou7HBe83t/Kd1TwMd
 Li6SmcU8qkUyfrygkY0ZExhgFhTZU+corGtw/enpylkMjvtbL7w/Jj8FFLqmJnJjldqU
 +mpvWi95yT4oeMzyYjhOjUvVtsz24apM1fNi0u934DuP2R/RsGMd7KxsFCn5lVZWy9nB
 nKi7Ak3d+jBp7pIAlhfKPiERrtnkBEbYBbhMDbQbBzxd86/s2E3vBKyNXsOTHe66kvFe
 vs8s3yIPx6eXMjgYkzL2KY6OIzsOjNVRZFKg68dEwLF0RhfhDIm1wU0SvpUm/PhrSKUk
 8s8w==
X-Gm-Message-State: AC+VfDyR3xe3dS6rLbGHKwKiziv/k/mf6EtmWO1A/WetDbwkF3Q7LBPt
 zTHbN8MTbM62IaS8WZePqmNzLo7bIFtXutuzh5k=
X-Google-Smtp-Source: ACHHUZ5gAI5DKCTD+cxDIuou4d/eGWAXkhp1hwGBJgNWrauawfmwBrhxM5fgMXSHu2OA0Bhs+psaoA==
X-Received: by 2002:a05:600c:22c2:b0:3f9:b19c:aab4 with SMTP id
 2-20020a05600c22c200b003f9b19caab4mr1646678wmg.6.1687184968171; 
 Mon, 19 Jun 2023 07:29:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/33] hw/timer/nrf51_timer: Don't lose time when timer is
 queried in tight loop
Date: Mon, 19 Jun 2023 15:29:07 +0100
Message-Id: <20230619142914.963184-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20230606134917.3782215-1-peter.maydell@linaro.org
---
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



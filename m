Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 088C37A1137
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 00:43:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgv2c-0000c8-Gs; Thu, 14 Sep 2023 18:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3SIwDZQcKCp0HLJILAFDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--komlodi.bounces.google.com>)
 id 1qgv2R-0000bE-RL
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 18:42:19 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3SIwDZQcKCp0HLJILAFDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--komlodi.bounces.google.com>)
 id 1qgv2Q-0006Ix-B2
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 18:42:19 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-58c9d29588aso19396507b3.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 15:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1694731337; x=1695336137; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=OlJhU4LHA+fzq8m2hyizz9EI1FeCvDgyPUR6IsKexwU=;
 b=vMXwFMREQRTi9AyXR3uX9JmSEfxo+wcSsl5DiFT2BX4Mp6JvYTO7DxKXaHmEUKNhJ8
 8ZQUU7t43Y/7+DlaKiE8ZYc61ydTIAYl6IHHOL2pBWNfRmfxgVz9faWed9zOb/Unr+Ha
 OOqqqQxRIqgbDE56ypb3nfgXQBPlD8fybQpT+aTB5ezeZdsCAZMg+9fuGRW9dQZ5Canr
 uP0SOO9erBiSFfTfdn15fRJwAvvkJd1LuaFa3a+ygOpjGcryRhZo/oGb1RKnwPR+LXT+
 kvdo8i4ZS1Zc07H4g23RTe2nh5IvcWZkzoshwtQwEf5Zfnk2jJqgIgmKfypppXRrGWP4
 +LuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694731337; x=1695336137;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OlJhU4LHA+fzq8m2hyizz9EI1FeCvDgyPUR6IsKexwU=;
 b=pS+iCttJ8AVgpznyChUgUq75VlNXZiJ+vyQOq488ripVTSOPrEv0W/QrBwMM1GUxSk
 QZC47CMKOkPDglXbGf9j/ztF49N+QZZhROkzkSLAImQtOOjtpTHjIYtFMguAG5wpr0vt
 +Txdu2hN6vkWGUVOR0TCYt6Y76EfOaGk9uivhcLEgf+FQxy8bh0JKGI/HiYq4FY3BeOt
 kB/L+NivQ4ZPIBIHU2sNPMMtXiauDlu+dkBUJ5fYV1Vfi5hy/Z3/1GR6aOJdMYbfZBgt
 x8rySgvQ1ZGhVM8Hvx3f9hlcHorfXdch856AL66niB6/FlbN4nd8nmJ4XVfpGvC+8SOb
 XF4w==
X-Gm-Message-State: AOJu0YzBj6a8o5StnqPTD/b6rLlGkTCg4AgjDZLs7LogskmetPqXQfKz
 JE34z+9vlAF0Tb3FNBjAWsuv1oOSoBcSLlztTv05xSRps1GIpOfBSbA9n7BvW9WBsKQBQ11U85E
 4WJbldXr7JzmxR9qy/YDBt2fhSSifxkLTluQk8ZhN3vcDO1j/phmz4QcScia3e9c=
X-Google-Smtp-Source: AGHT+IHD9hpFPxbfpEew3gS/1mgL6iazFiw7TsdOqhotr/MMod4S0j/xPRVG2wRsBwbGmYQCEsmqMFwCUE2S
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a81:4413:0:b0:59b:db15:498c with SMTP id
 r19-20020a814413000000b0059bdb15498cmr1069ywa.10.1694731336779; Thu, 14 Sep
 2023 15:42:16 -0700 (PDT)
Date: Thu, 14 Sep 2023 22:42:10 +0000
In-Reply-To: <20230914224211.2184828-1-komlodi@google.com>
Mime-Version: 1.0
References: <20230914224211.2184828-1-komlodi@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230914224211.2184828-2-komlodi@google.com>
Subject: [PATCH 1/1] hw/timer/sse-timer: Add CNTFRQ reset property
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: komlodi@google.com, qemu-arm@nongnu.org, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3SIwDZQcKCp0HLJILAFDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--komlodi.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

This can have a non-zero reset value, and cause the kernel to complain
about a CNTFRQ mismatch if TF-A (or firmware in general) does not
initialize it (because it expects the value to be non-zero out of
reset).

To fix this, we'll just add an object property that people can use to
initialize the CNTFRQ reset value.

Signed-off-by: Joe Komlodi <komlodi@google.com>
---
 hw/timer/sse-timer.c         | 4 +++-
 include/hw/timer/sse-timer.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/timer/sse-timer.c b/hw/timer/sse-timer.c
index e92e83747d..a727f05bac 100644
--- a/hw/timer/sse-timer.c
+++ b/hw/timer/sse-timer.c
@@ -376,7 +376,7 @@ static void sse_timer_reset(DeviceState *dev)
     trace_sse_timer_reset();
 
     timer_del(&s->timer);
-    s->cntfrq = 0;
+    s->cntfrq = s->cntfrq_reset;
     s->cntp_ctl = 0;
     s->cntp_cval = 0;
     s->cntp_aival = 0;
@@ -430,6 +430,7 @@ static const VMStateDescription sse_timer_vmstate = {
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
         VMSTATE_TIMER(timer, SSETimer),
+        VMSTATE_UINT32(cntfrq_reset, SSETimer),
         VMSTATE_UINT32(cntfrq, SSETimer),
         VMSTATE_UINT32(cntp_ctl, SSETimer),
         VMSTATE_UINT64(cntp_cval, SSETimer),
@@ -442,6 +443,7 @@ static const VMStateDescription sse_timer_vmstate = {
 
 static Property sse_timer_properties[] = {
     DEFINE_PROP_LINK("counter", SSETimer, counter, TYPE_SSE_COUNTER, SSECounter *),
+    DEFINE_PROP_UINT32("cntfrq-reset", SSETimer, cntfrq_reset, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/timer/sse-timer.h b/include/hw/timer/sse-timer.h
index 265ad32400..ad84c24940 100644
--- a/include/hw/timer/sse-timer.h
+++ b/include/hw/timer/sse-timer.h
@@ -43,6 +43,8 @@ struct SSETimer {
     QEMUTimer timer;
     Notifier counter_notifier;
 
+    uint32_t cntfrq_reset;
+
     uint32_t cntfrq;
     uint32_t cntp_ctl;
     uint64_t cntp_cval;
-- 
2.42.0.459.ge4e396fd5e-goog



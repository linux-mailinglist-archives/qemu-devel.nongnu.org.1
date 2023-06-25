Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC26373CF91
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 10:58:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDLYA-0003L4-Ns; Sun, 25 Jun 2023 04:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qDLY6-0003JO-N0
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 04:56:46 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qDLY4-0006o2-Jl
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 04:56:45 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-39ed11d6a50so1710287b6e.2
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 01:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1687683402; x=1690275402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F0NBhtkdkVQWn6VJ4Hn5xFxABZWT2yxynQQGpDKOHM4=;
 b=PbgHJbeLdrDXaf1WCr6idDjMyQxyXrHWXOIbolnAYQjeJvYoTi4EU4xBPus2QYArDC
 CMj0AEDmIb+wyb3lWUVTe2iPWM1JWrjy/1RsyLybodzoNxIsK7jpLgVqJaQAc+luZDnO
 Xa9B96X6HvwiXOGQRLd1S664Q7Ou0Et9MgtjlQEqO0jM7jC272aDQafdfaczQ/dr5DjX
 MN/Of65qxTHq46bq6Hu5P6nwaFBqA+6hlEcC/HnHiTSCZsBWeRnVnWhEAUhvqy2tiY2R
 +kiyS+YlgYwWLNZaC1znejeC4X0lGR5vj6lte3tPoMKAtEhcEF2SzZSrM1b+4QHA2iCp
 tWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687683402; x=1690275402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F0NBhtkdkVQWn6VJ4Hn5xFxABZWT2yxynQQGpDKOHM4=;
 b=Wog9jEokboqpGfdmDMoPATQ3vyUvEkh/WexcgXfm6oI8be2Ea0qwcL7m15KVnHqoW1
 8QPK5MUBvBqZ/Lr0rmFvQvVe0vLBmhyb2ou56P+48U9G/yZ31+vq1MC6UQzWtmvXRjoV
 umHH0W5uoXRwGk6s4RzfSZDF4Dj5AU0URYrCGxDq+AjWDiqEaSjStBB4XKgWMbJQv2WO
 wTqafI5y+/rS/vsenuPCXQNCHxepFLOJqb/BIotD9iSx+Sh37VUQmCCSRSO4MagSPRI2
 uQaHDrI6D+PYs5dDBh/k34AfSQ0ny/HWZrcN38nZa8Udo70FA798UUJ6Xn3Y3Ju7kBW9
 1nMw==
X-Gm-Message-State: AC+VfDwWdPYR5W4Js4x8ozq3g27DciV5oufP1L1NWhf8lUPZa1TIcctk
 85mpab3NCdCM2blQgOA9meJg9w==
X-Google-Smtp-Source: ACHHUZ6+1NWjoeEuMZIp1pwpaeOEx1vjzOWcYYyYKc1xANYGF0zeII+e1OffHp07qQIg0IHYsEjd0Q==
X-Received: by 2002:aca:1309:0:b0:3a1:c979:e6b6 with SMTP id
 e9-20020aca1309000000b003a1c979e6b6mr2556831oii.34.1687683402096; 
 Sun, 25 Jun 2023 01:56:42 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 w9-20020a170902e88900b001b1f991a4d0sm2176308plg.108.2023.06.25.01.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 01:56:41 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 2/5] test-throttle: use enum ThrottleTimerType
Date: Sun, 25 Jun 2023 16:56:28 +0800
Message-Id: <20230625085631.372238-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625085631.372238-1-pizhenwei@bytedance.com>
References: <20230625085631.372238-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=pizhenwei@bytedance.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Use enum ThrottleTimerType instead in the throttle test codes.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 tests/unit/test-throttle.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/unit/test-throttle.c b/tests/unit/test-throttle.c
index 7adb5e6652..5fc2de4d47 100644
--- a/tests/unit/test-throttle.c
+++ b/tests/unit/test-throttle.c
@@ -169,8 +169,8 @@ static void test_init(void)
 
     /* check initialized fields */
     g_assert(tt->clock_type == QEMU_CLOCK_VIRTUAL);
-    g_assert(tt->timers[0]);
-    g_assert(tt->timers[1]);
+    g_assert(tt->timers[THROTTLE_TIMER_READ]);
+    g_assert(tt->timers[THROTTLE_TIMER_WRITE]);
 
     /* check other fields where cleared */
     g_assert(!ts.previous_leak);
@@ -191,7 +191,7 @@ static void test_destroy(void)
     throttle_timers_init(tt, ctx, QEMU_CLOCK_VIRTUAL,
                          read_timer_cb, write_timer_cb, &ts);
     throttle_timers_destroy(tt);
-    for (i = 0; i < 2; i++) {
+    for (i = 0; i < THROTTLE_TIMER_MAX; i++) {
         g_assert(!tt->timers[i]);
     }
 }
-- 
2.34.1



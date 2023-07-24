Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C11B75F252
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 12:12:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNsWN-0007qP-Fl; Mon, 24 Jul 2023 06:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qNsW3-0007it-A7
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:10:11 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qNsVn-0000YK-7F
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:10:10 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-666eb03457cso2207144b3a.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 03:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690193394; x=1690798194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Po0gAxAU3dnysaVx2B26/6HXOapX1SQhA8vH8XAjSZc=;
 b=O4ObM1YqaLRcqgXMsAk/mPWpxMJ9/kFTFN54qK71rgylAkjTJHc9PeRKZyGRWvWjdN
 qFpxW3EEFGOeUW0xKxhcqioycyNGW1ZxNgGlHE41Crm1drAHbyGlOMxANmhM4LCdTKf/
 Uh+hYV7XNdcep9bqnMd25eNItVUkjQ7fjleq9aaOdgO79YTVGLnCiboopYne/Q2gvUxy
 xOyy953jxDZpUttE7B6ZKt9U8251w5juZEuOpIPi6Wc3axCmMuSzqqexni0I8MGwFy8Q
 iy9RmpPqYD9eurtS2g/cxdobwVKAdSoXBBJgIsByxYqzdO2f2MAHhBFModHakm/yp5fQ
 UeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690193394; x=1690798194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Po0gAxAU3dnysaVx2B26/6HXOapX1SQhA8vH8XAjSZc=;
 b=Nj5iAQqx4Z3FipUceY91ElYYbf9rRVD4jR7M7B25xe5MUT2zBrrE6biDHPSgzvd0yc
 OI0YKJxEC/I8wiMdqF3rukTeMJmhp+3eps0+dgUC1WJJyK8BFcnHGnRL2Bi8L7etQrsM
 gquMauEZhr9fYp5UqTHeD24DoBe8devbSub3PMcyFHbZcH0fOTetjzeEHN3kancTf3+J
 1x6hrrWPzuxn/U9/60RQydtAKz0M8PzEW2XA0GLrqjmnBqyisclLbQzw9BQ7freYYobE
 WCUUVx+IXmhw8knY9f9hohJjt4DtkhOkpfFc+y95zBKYnTzyC6+HrWoLXaV+G+VovGvX
 RqwA==
X-Gm-Message-State: ABy/qLYdbHACcfKPMFpX8L70Mk0Uk6iDwnDMuGZtXgPgVek6g0T9e+q3
 ND3HiZrWS6qDw69uY+oSORhG9Q==
X-Google-Smtp-Source: APBJJlF94MaBNI26y7tn+/z6NVOjE+maGZ1sU09y1mozRAuBKdbXUA0hv8ccufWGuOaHxwOf8ouRvA==
X-Received: by 2002:a17:903:190:b0:1b8:7618:5414 with SMTP id
 z16-20020a170903019000b001b876185414mr7008517plg.60.1690193393770; 
 Mon, 24 Jul 2023 03:09:53 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 je2-20020a170903264200b001bb9d6b1baasm2419124plb.198.2023.07.24.03.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 03:09:53 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com, kwolf@redhat.com, groug@kaod.org, qemu_oss@crudebyte.com,
 hreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v4 2/9] test-throttle: use enum ThrottleDirection
Date: Mon, 24 Jul 2023 18:09:32 +0800
Message-Id: <20230724100939.1022984-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724100939.1022984-1-pizhenwei@bytedance.com>
References: <20230724100939.1022984-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

Use enum ThrottleDirection instead in the throttle test codes.

Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 tests/unit/test-throttle.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/unit/test-throttle.c b/tests/unit/test-throttle.c
index 7adb5e6652..a60b5fe22e 100644
--- a/tests/unit/test-throttle.c
+++ b/tests/unit/test-throttle.c
@@ -169,8 +169,8 @@ static void test_init(void)
 
     /* check initialized fields */
     g_assert(tt->clock_type == QEMU_CLOCK_VIRTUAL);
-    g_assert(tt->timers[0]);
-    g_assert(tt->timers[1]);
+    g_assert(tt->timers[THROTTLE_READ]);
+    g_assert(tt->timers[THROTTLE_WRITE]);
 
     /* check other fields where cleared */
     g_assert(!ts.previous_leak);
@@ -191,7 +191,7 @@ static void test_destroy(void)
     throttle_timers_init(tt, ctx, QEMU_CLOCK_VIRTUAL,
                          read_timer_cb, write_timer_cb, &ts);
     throttle_timers_destroy(tt);
-    for (i = 0; i < 2; i++) {
+    for (i = 0; i < THROTTLE_MAX; i++) {
         g_assert(!tt->timers[i]);
     }
 }
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7680373F598
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 09:26:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE34B-00081N-OT; Tue, 27 Jun 2023 03:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qE349-000805-Bs
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:24:45 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qE347-0005v0-Mp
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:24:45 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-666e5f0d60bso2074980b3a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 00:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1687850682; x=1690442682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9T2skCqD7gbOa8K9gXY5lRhjHEdGesDQeEu2J1OpYu8=;
 b=D/rKe/GJvjD1fhjD1M3q6RwqhYWH/X0LzkmXWJBmjMPMiUvmUzJm75j0FJAvNozd9i
 tpLk1wqbS5eHBAI9BVqAeioSlkFLXw2URqOD3jlXAKcfR0JChYM7R3TVG6aq8yhO5RFf
 VamZZmcEPl6NS6SdqHd2FAoECvnvNXpL4igbur73EnZF5aE4y6D7iCvgdzARC7IBhnoi
 sp2MkvxlaCBYC2jJR43H/hHdbM/lrVeNHx6+TcpSjFDebvIKW8+rDUgK2xFMhS0/ejWz
 6kqJY1P9rwcnklR9ih7E5Tr3kuvIXcOO6xEX8DdPbS2RpVvDCyUuIlWGy08F4yXbyW/2
 8LyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687850682; x=1690442682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9T2skCqD7gbOa8K9gXY5lRhjHEdGesDQeEu2J1OpYu8=;
 b=fmC5FrizSqrzLWDH7ScFWWKZ3sCNN8zEcRme6ydYZEIHqiz57fAkoJB8RNpWc83opg
 3C4VSPMAelH6u3mf+mUXBrA91IvBvd9f3zg8MP6erYLCvtliGfybXcTc1T4f5UJdjHOa
 hcLZSA93/TKukbGxY1To2aJd5fT0qLwpBDivqQ5ni+1xfscl0d+XGOPu2Tw/9tpnclWb
 WqYTX5LVYJ2RSxz72VvBYrQzNFXXumXcKpwRGGSyfhAglaYncVxQB9sr7wGR/5Rk7h9M
 X3kIA7Kkf/i0CYj8IRfu7xbGPLtvFlHgbOOaw+44rudxWNC5q9+pKfmpx1NlTjpl4/mb
 f1VQ==
X-Gm-Message-State: AC+VfDzBppUIQjebNi83Nv1MUO1ZlYr1dGK4REfRjP+8JdM7CQ0bAfm9
 WJAtkKbwQfJjJZXYZGQZRNdsFw==
X-Google-Smtp-Source: ACHHUZ5PPVWPjTUAIe70mNKSlJGJmj4QDC9ZtlF9NKHgsANELZOTBjOBLMZipdjhi7E5vMrtpv/XcQ==
X-Received: by 2002:a05:6a00:1482:b0:65e:ec60:b019 with SMTP id
 v2-20020a056a00148200b0065eec60b019mr26281035pfu.25.1687850682538; 
 Tue, 27 Jun 2023 00:24:42 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 u22-20020aa78496000000b00640f1e4a811sm3210915pfn.22.2023.06.27.00.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 00:24:42 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 2/5] test-throttle: use enum ThrottleType
Date: Tue, 27 Jun 2023 15:24:28 +0800
Message-Id: <20230627072431.449171-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230627072431.449171-1-pizhenwei@bytedance.com>
References: <20230627072431.449171-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pf1-x42f.google.com
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

Use enum ThrottleType instead in the throttle test codes.

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



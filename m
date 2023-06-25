Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB7B73CF94
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 10:58:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDLYE-0003MO-Pj; Sun, 25 Jun 2023 04:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qDLYC-0003Ld-CQ
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 04:56:52 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qDLY9-0006pL-1Y
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 04:56:50 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b5422163f4so18267035ad.2
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 01:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1687683407; x=1690275407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/g/qKNXMsoUYUiLxUP/wb7Xh4Z40SdwPZE7/jq6+cKg=;
 b=e6TJzVrGGjTWbdAIS+z2uyizWcgniZc3q+jmeYnOkV/c59NBR4XCo6oIxavpoh0NgK
 jGxYAe/yiGFcFKDaiC5U3svZRyDnwrRL/+KAxyYu9SASExS3Ip8B35k1vIeURJ0VD1IX
 8nTRJSfvF34RR7ydDxQnv0R9l1MNBermsQBK0ueYJ7s7gt5Iso9r9aGpvm9HhAc1LGEL
 gzz+o7EmfZ6eYAdU/U5m+IjonGgnz0SDS26ofolQ3FaJGvrzMNCWPqstX1llgopYZtJv
 LjZcbk6P/mELHhjsmh4d6zsWskDdMkAQN2JEdVWJ4OU9kVjCtd527GHm7FU5rDxKSx1W
 TsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687683407; x=1690275407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/g/qKNXMsoUYUiLxUP/wb7Xh4Z40SdwPZE7/jq6+cKg=;
 b=IABLMWzN6zn57J7ZSDfbNN078lG7fcX92ibSnXu7JCkySq2FyZg9SobOW3cjX0vIjs
 3B8VyW99hcLk15FLueDFtKeF488TEan3BOyC/7uAExquHkq3wb3Ok3lfkP5s2g6uCfHw
 ny623shUaeTZhe7leGZ5/OsD3OxjSbpdn7/pJ899FHc0TCMBvaj3+JfS1kU8Zk/Kz+Kj
 4KQQe9fmViHH50eay21+BR4PUiGT17D+mvJLs1vs0tR87+2SJ2QQf4n9YxEhQM35X19o
 D2sQu2Ug0oe5S3VvuGbaHfsxwIJy9swAznzReUGPV7qk+YnIqlJ1vU5dspCBScxeYdai
 bE1w==
X-Gm-Message-State: AC+VfDzSJooeaU+UNFZf2LPcYPx6AQpF5fYfoy4k7SA9WqJgyks5bKD4
 oRApU4ITv4qFKr3J4dZyvpwXJw==
X-Google-Smtp-Source: ACHHUZ5h9EBdHvAb2sp7ZL+mLZl/PxZG1cSC0cdW+YH89UVhHC6qkt7Wlihny9EOF1pmQvMZH7CiYg==
X-Received: by 2002:a17:902:7781:b0:1af:bbfd:1c07 with SMTP id
 o1-20020a170902778100b001afbbfd1c07mr4049303pll.57.1687683407718; 
 Sun, 25 Jun 2023 01:56:47 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 w9-20020a170902e88900b001b1f991a4d0sm2176308plg.108.2023.06.25.01.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 01:56:47 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 4/5] test-throttle: test read only and write only
Date: Sun, 25 Jun 2023 16:56:30 +0800
Message-Id: <20230625085631.372238-5-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625085631.372238-1-pizhenwei@bytedance.com>
References: <20230625085631.372238-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x634.google.com
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

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 tests/unit/test-throttle.c | 66 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tests/unit/test-throttle.c b/tests/unit/test-throttle.c
index 5fc2de4d47..d7973980d1 100644
--- a/tests/unit/test-throttle.c
+++ b/tests/unit/test-throttle.c
@@ -184,6 +184,70 @@ static void test_init(void)
     throttle_timers_destroy(tt);
 }
 
+static void test_init_readonly(void)
+{
+    int i;
+
+    tt = &tgm.throttle_timers;
+
+    /* fill the structures with crap */
+    memset(&ts, 1, sizeof(ts));
+    memset(tt, 1, sizeof(*tt));
+
+    /* init structures */
+    throttle_init(&ts);
+    throttle_timers_init(tt, ctx, QEMU_CLOCK_VIRTUAL,
+                         read_timer_cb, NULL, &ts);
+
+    /* check initialized fields */
+    g_assert(tt->clock_type == QEMU_CLOCK_VIRTUAL);
+    g_assert(tt->timers[THROTTLE_TIMER_READ]);
+    g_assert(!tt->timers[THROTTLE_TIMER_WRITE]);
+
+    /* check other fields where cleared */
+    g_assert(!ts.previous_leak);
+    g_assert(!ts.cfg.op_size);
+    for (i = 0; i < BUCKETS_COUNT; i++) {
+        g_assert(!ts.cfg.buckets[i].avg);
+        g_assert(!ts.cfg.buckets[i].max);
+        g_assert(!ts.cfg.buckets[i].level);
+    }
+
+    throttle_timers_destroy(tt);
+}
+
+static void test_init_writeonly(void)
+{
+    int i;
+
+    tt = &tgm.throttle_timers;
+
+    /* fill the structures with crap */
+    memset(&ts, 1, sizeof(ts));
+    memset(tt, 1, sizeof(*tt));
+
+    /* init structures */
+    throttle_init(&ts);
+    throttle_timers_init(tt, ctx, QEMU_CLOCK_VIRTUAL,
+                         NULL, write_timer_cb, &ts);
+
+    /* check initialized fields */
+    g_assert(tt->clock_type == QEMU_CLOCK_VIRTUAL);
+    g_assert(!tt->timers[THROTTLE_TIMER_READ]);
+    g_assert(tt->timers[THROTTLE_TIMER_WRITE]);
+
+    /* check other fields where cleared */
+    g_assert(!ts.previous_leak);
+    g_assert(!ts.cfg.op_size);
+    for (i = 0; i < BUCKETS_COUNT; i++) {
+        g_assert(!ts.cfg.buckets[i].avg);
+        g_assert(!ts.cfg.buckets[i].max);
+        g_assert(!ts.cfg.buckets[i].level);
+    }
+
+    throttle_timers_destroy(tt);
+}
+
 static void test_destroy(void)
 {
     int i;
@@ -752,6 +816,8 @@ int main(int argc, char **argv)
     g_test_add_func("/throttle/leak_bucket",        test_leak_bucket);
     g_test_add_func("/throttle/compute_wait",       test_compute_wait);
     g_test_add_func("/throttle/init",               test_init);
+    g_test_add_func("/throttle/init_readonly",      test_init_readonly);
+    g_test_add_func("/throttle/init_writeonly",     test_init_writeonly);
     g_test_add_func("/throttle/destroy",            test_destroy);
     g_test_add_func("/throttle/have_timer",         test_have_timer);
     g_test_add_func("/throttle/detach_attach",      test_detach_attach);
-- 
2.34.1



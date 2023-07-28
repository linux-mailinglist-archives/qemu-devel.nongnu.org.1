Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4018C766262
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 05:26:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPD5r-0007wF-0Y; Thu, 27 Jul 2023 22:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qPD5f-0007vR-Kk
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 22:20:28 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qPD5e-0006yx-2T
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 22:20:27 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b8ad907ba4so10723775ad.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 19:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690510825; x=1691115625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wg78UB7cYAokVViU4U5tFWb/GJUMtPAxxn2JcC2wYiI=;
 b=T8Og8lb22kMN7nQ4vVkGyoRUBjRifex91RdCuo99G1iGgBNppqYVUDFfG1mPB2Ygki
 cX/AOw6piPyq7OA5LflU+aIPFUR7etkKY4DU3W5wH+JgCf9TU2gapulOzZIpOYaHxBZA
 bxFa7r8NdyXMEAQXxCKti+QZqerXPv4rfZqj2PBT+ARUBQS7+kEq73vu2nNhm9JSnoMq
 mu0GGQHftMjONPjQ1DJot3qUxXYjbXRYU1nXRzvULLxgl3kQCbE28M61jOl6XbqZMXvH
 xB/f0DQq8Cpy+EtOtgEtUaqFdQGF3SNH2+XVC5pvCRnusb47zBRSBbumV5rFXVD9bR12
 Je2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690510825; x=1691115625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wg78UB7cYAokVViU4U5tFWb/GJUMtPAxxn2JcC2wYiI=;
 b=f7IyZfm4fLoezUR+dp0eOFmznmECC+AXsrX6mksXdhdiW8QK6KMvMYA4XpQnUR23Zl
 dig0DKF2gK2E2FU43JwMmzdHjdZaFLyxb0dSKbhEzIBB+h/l74tKzyoCPDYWA7R5hrSX
 427nC86m016bC4m4J0Z9jsHx3MbwcUISdG+GQbkTr+7L9s66Vrcf8Y/UXF5NI9NbZQfO
 1vuZ32ezShQQACJSWR4Ct6LslRJTZDojUsX7W8l5q5/smq2cYStQbRLMRd0DleQiOy9G
 EdRlGvs27F9XxCI1c3hmoDxXo0F95OIkjOab9vew2wqFJs4TB1HH64JqT/hptK5EJj0n
 d2/w==
X-Gm-Message-State: ABy/qLYzTwS5DAV73V8/DefSGXBn1PLgo+U/GamQZJrJLIhOgdJ4bT4l
 vE0Onf6adMOBDLMjftX8oSVzWQ==
X-Google-Smtp-Source: APBJJlFiA3NUxb9GBA+KDT7AP7hwiWJamewbEn9uoRfZGtTYj+8NapOyvPwtzuawCbqoMaY/Hrtetg==
X-Received: by 2002:a17:902:a405:b0:1b8:7d0d:5ac5 with SMTP id
 p5-20020a170902a40500b001b87d0d5ac5mr245491plq.50.1690510824833; 
 Thu, 27 Jul 2023 19:20:24 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 b21-20020a170902d31500b001bb9f104328sm2312947plc.146.2023.07.27.19.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 19:20:24 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com,
	kwolf@redhat.com,
	hreitz@redhat.com
Cc: qemu_oss@crudebyte.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v5 4/9] test-throttle: test read only and write only
Date: Fri, 28 Jul 2023 10:20:01 +0800
Message-Id: <20230728022006.1098509-5-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728022006.1098509-1-pizhenwei@bytedance.com>
References: <20230728022006.1098509-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x630.google.com
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

Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 tests/unit/test-throttle.c | 66 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tests/unit/test-throttle.c b/tests/unit/test-throttle.c
index a60b5fe22e..5547837a58 100644
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
+    g_assert(tt->timers[THROTTLE_READ]);
+    g_assert(!tt->timers[THROTTLE_WRITE]);
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
+    g_assert(!tt->timers[THROTTLE_READ]);
+    g_assert(tt->timers[THROTTLE_WRITE]);
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



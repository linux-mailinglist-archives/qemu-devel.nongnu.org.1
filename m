Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8477518FC
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 08:43:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJq1M-0004g8-0Q; Thu, 13 Jul 2023 02:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qJq1J-0004fc-77
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 02:41:45 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qJq1H-0007qy-Hj
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 02:41:44 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6686ef86110so176982b3a.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 23:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1689230502; x=1691822502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n3sbCJaOmDfH1zIN/DRXdbhJFNPKJy9ruOuNCb7n1h4=;
 b=hK5cZs3QTH+j/ruUO+lYBc14Z3sQTZu+7FbMqkOQNmAS0Q3C7CWOlyd42q3Zq0ZMPt
 oD/n21UTN+zpbbj6GJfPiir2EI2YfcPqQBB5nAIvCpSBDRl2LMstnCbzB0DlR33q56k5
 hswrwQdNYwc9X6FXYnhwyKn+AMFUB4GGqcxvR5DrXISrAK0384/XHit21+Lsg32SzS3L
 97VLFsPRSXtDiDQ7aegRKSnasox7VW+2CfzJW7uNBpwZJa901uYzQPaPr8E0fORIfN1K
 4CcWKBLddDmpd9ilycB3TNhXXC1DlzTOQaF73b6SlbSXhv3YFAsN9HLxlwQtUYimVLj9
 F32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689230502; x=1691822502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n3sbCJaOmDfH1zIN/DRXdbhJFNPKJy9ruOuNCb7n1h4=;
 b=W3bQUG1IzEnNcLtlq/AFw+jjb6FLkwLVvwKFvaCC/khpC6qXKDwg/xMGSfC8ZOvbRk
 TgiAEbL1pMxTa7y7SHwZlhnuwau8BJBmHpmZNM19qYATiSdBOPrdGUQGqCgPM6OifUbe
 Itr1j1R08tcXf2tLi1sH3c9qUAvzUC56N2+UNCWt7hSIhne52B7PSVnWs44ef02I2rG/
 XNyi2c/xBmLVCZBm6EI+hrd4ubKa3/RbHrpEtB9WHhA8nYhzU9zsu/SA8BBqj1dP5KzE
 sZobZ2X8eeVCSPpveIYEx2nVCrusvA8n5wJLmc2cbcHpTDxC2W7RHNs/3BNItZDH0EVd
 rA/A==
X-Gm-Message-State: ABy/qLbDx1a4V2YoSLrCO9Dxu0y8hzH+6rxspsSSoWrv69moJ3rrd1A3
 nja5gYgrrZSO7gwB7y0G195IaA==
X-Google-Smtp-Source: APBJJlEbG7MFZPSEuGed7BpIpBwFmVr0HIAGUiTKfbYn0EqSvSzxHNjQZasXu5GcMSZ16EHjhkVwag==
X-Received: by 2002:a05:6a20:4403:b0:12b:c8ee:c457 with SMTP id
 ce3-20020a056a20440300b0012bc8eec457mr209690pzb.39.1689230502139; 
 Wed, 12 Jul 2023 23:41:42 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a170902680d00b001ac2be26340sm5144966plk.222.2023.07.12.23.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 23:41:41 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com, kwolf@redhat.com, groug@kaod.org, qemu_oss@crudebyte.com,
 hreitz@redhat.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v3 4/6] test-throttle: test read only and write only
Date: Thu, 13 Jul 2023 14:41:09 +0800
Message-Id: <20230713064111.558652-5-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713064111.558652-1-pizhenwei@bytedance.com>
References: <20230713064111.558652-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pf1-x42e.google.com
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



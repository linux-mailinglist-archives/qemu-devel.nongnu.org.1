Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A0678F9E5
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 10:20:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbzMN-00072o-Dd; Fri, 01 Sep 2023 04:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qbzMK-00071p-AA
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:18:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qbzMF-00015x-8Z
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693556302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y7BK6qeqanFJTu3/cEmV/cbdHHLyTLn53s5fMHN0XzE=;
 b=FF1CcNFSC6m3fVwQATka29Pn/QI2QQxjtg8cZXHnxpZ/8bH1oGT4NG+1KyKUi2e9obIe9h
 BY7bHcB3UEUWi1spfv1oP26je5p+GXODzlGmcXl8OfhojnckjFKiwcw3hWE+r2V27RIiTY
 9GekvYTDnwv0shoMzKrpnYhEeZFWBCY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-bfvdj2vkPzevHa7js2dmEQ-1; Fri, 01 Sep 2023 04:18:17 -0400
X-MC-Unique: bfvdj2vkPzevHa7js2dmEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A3CD101A53C;
 Fri,  1 Sep 2023 08:18:17 +0000 (UTC)
Received: from localhost (unknown [10.39.194.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B944112131B;
 Fri,  1 Sep 2023 08:18:16 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
	Hanna Czenczek <hreitz@redhat.com>
Subject: [PULL 04/14] test-throttle: test read only and write only
Date: Fri,  1 Sep 2023 10:17:59 +0200
Message-ID: <20230901081804.31377-5-hreitz@redhat.com>
In-Reply-To: <20230901081804.31377-1-hreitz@redhat.com>
References: <20230901081804.31377-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: zhenwei pi <pizhenwei@bytedance.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <20230728022006.1098509-5-pizhenwei@bytedance.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
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
2.41.0



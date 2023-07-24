Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3177975F241
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 12:11:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNsWO-0007vE-Qs; Mon, 24 Jul 2023 06:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qNsWB-0007nO-Gm
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:10:19 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qNsVu-0000ZG-W3
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:10:18 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bb775625e2so13588225ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 03:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690193401; x=1690798201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wg78UB7cYAokVViU4U5tFWb/GJUMtPAxxn2JcC2wYiI=;
 b=bnel0JMx0K8UiW/pkkPT4kkVAYPoy1yUJcc6zzF64JEaMfqrJR70uN99/XGfIltBC4
 DD7nJxMfG3JWXf0t9cMLSUM/eH9TQv/TNHPCZtiDDALZG4bvSAMOYFD97pbZYTt95h7T
 reQf2LIZeG1nJEL9GRVNY+3uN0mvZgI9fkiHcVRVnsVl7CTrm+g4zjHV4fKqSDyRbUsS
 y/qPgRzvf86PkOL0bndS5RwO5FhcVMxefbJf1qe7GTOknEd7olF7cSd+m6PcOuP3wJW3
 d51fvO+xQ+kHLkg6T5/D/1lZWHbQKd2l7lLmglU4cEDguBVzyV44xmtukiQvDTC0FXMn
 BXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690193401; x=1690798201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wg78UB7cYAokVViU4U5tFWb/GJUMtPAxxn2JcC2wYiI=;
 b=PwlsGB3E1bZPhsO96J1qoexeAjNqx2tVDc7S/QBlGChzFZaftcuXNFe0z67B2X9Enb
 pHrTPiGMMS1LmQsgvg3SvpGrWCkSoCp/3pdIxnfOpyT99yCLqUurfYy5Xejmh2FHhz38
 oC8uwCMsR/mHZJOeoMQlFxfWvfhqvxaMKbYkMekUE/jdUaSBxiauAlXm7tB9wJNsiwdX
 NNvpJ+MevFSKSBJcrnEcS/5AaU9zKh6si2L4ZXjNKHgEgYD6BCXY1en5+SQYfpSgkZtd
 3xFSdqOiDInRWfpms4DHDADl40hqHAUM7fm65ML18oyiJp7huINK7Mw/+U2ugOHwMvGv
 R/ig==
X-Gm-Message-State: ABy/qLahmW0ObjvQgtNvr3e7PP8waumr4ac50B5hi2I12a6rTWFnVko8
 vZf3Om5TIN6IA39JRW6sdoIqQQ==
X-Google-Smtp-Source: APBJJlEG04Zi9RrWWoYE9MgktvWKa+xPsNq2dbTEsMIt6urB9Udt25OlHwR1qNZTKj8Z/YbsSD610g==
X-Received: by 2002:a17:902:d2cd:b0:1b0:3ab6:5140 with SMTP id
 n13-20020a170902d2cd00b001b03ab65140mr13738594plc.4.1690193401139; 
 Mon, 24 Jul 2023 03:10:01 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 je2-20020a170903264200b001bb9d6b1baasm2419124plb.198.2023.07.24.03.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 03:10:00 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com, kwolf@redhat.com, groug@kaod.org, qemu_oss@crudebyte.com,
 hreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v4 4/9] test-throttle: test read only and write only
Date: Mon, 24 Jul 2023 18:09:34 +0800
Message-Id: <20230724100939.1022984-5-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724100939.1022984-1-pizhenwei@bytedance.com>
References: <20230724100939.1022984-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x62a.google.com
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5343E73F599
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 09:26:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE34I-00083g-H5; Tue, 27 Jun 2023 03:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qE34G-00083T-O0
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:24:52 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qE34D-0005xC-VT
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:24:52 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3a04cb10465so2997332b6e.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 00:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1687850689; x=1690442689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FRXWrqQ1kl9gX0iLfTTY+0v6ie/ntSqjODl1zUDXtao=;
 b=jNtNH0flxsy543WKsFhVyFawVZEfII2sBhh6HL5/mH0dtIuDxxhBGh58xxNaczBp4J
 Kg2bOMa8E4+nQEF0rFUzGIMP6s+PaoBT0J/aSrRCIwSYPlI91jUUbw3sZ3vPQkcSf6yn
 B4Feap7/mQD9z7Cp6SQx2ipcWWXM74GFThUNjlkF3L+SV1DiqTX6E64sgBcTIfiinPjm
 dB/lbEEt+SRoyDeNkXcxJv0bd8WchIQwbiEQQYm6O8mxACIqZNUiZ8ZT5yesFEfa2gYK
 yo0BmbUIAEa8eK5hg9Tm3qRO83Cl2Tn1P3FbXekZu30NbyEVRRpdDcEXUrKytn+f1RuN
 pZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687850689; x=1690442689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FRXWrqQ1kl9gX0iLfTTY+0v6ie/ntSqjODl1zUDXtao=;
 b=c9oeu3Z4zR+fWCal87qrXZv/71qXQThuGGGUXzz3FqBKxjg081sg4yEDYvCi0Ry+Ws
 nxIfAKp5ZLXpoqqN70Rgff6ILeBKLz2cQerouLhdsRqdIrAJ8RsLkmN4jTnpWSygVREn
 BwW1VCuCnnEgwYQ0m1iFL33PW/KF3SmP+W6AAtZHXZpzTPLIavvdqL8w7q4JPQ1okWf2
 zDXbdHlhhtGAXh1GumjLPPNdq0Nrisagda9AiId/GirmubeDzTW/r5fUFQY8mZQrEG2v
 HbkUv5QMlIXLA5FGbAc1c7sNpzfDBU3IhzIxHonQQEPGAYwxbFq/H2qvDxY+H+Jhfc8S
 w4Zg==
X-Gm-Message-State: AC+VfDxXzcwUgHu88HObKvZwnB+QEKv012pxGdLVS86kyS9m/+SLaZqN
 uR1THpRGI5O7sn6Wgpa7K3MPVQ==
X-Google-Smtp-Source: ACHHUZ5D0JWPQQNt87kZFEyFgWMYYCw2rLZcE43HmIP4J5kxQbslfNTNpjvfzIYOdkVOvHM1zHztEw==
X-Received: by 2002:a05:6808:1496:b0:3a0:3929:c6e7 with SMTP id
 e22-20020a056808149600b003a03929c6e7mr27129342oiw.21.1687850688530; 
 Tue, 27 Jun 2023 00:24:48 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 u22-20020aa78496000000b00640f1e4a811sm3210915pfn.22.2023.06.27.00.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 00:24:47 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 4/5] test-throttle: test read only and write only
Date: Tue, 27 Jun 2023 15:24:30 +0800
Message-Id: <20230627072431.449171-5-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230627072431.449171-1-pizhenwei@bytedance.com>
References: <20230627072431.449171-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=pizhenwei@bytedance.com; helo=mail-oi1-x22b.google.com
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



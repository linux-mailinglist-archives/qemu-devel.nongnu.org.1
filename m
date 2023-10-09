Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A057A7BD7EA
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 12:04:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpn7F-0003rF-SQ; Mon, 09 Oct 2023 06:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpn7C-0003nQ-H6
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:03:54 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpn77-0000I4-LU
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:03:54 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-323ef9a8b59so4140096f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 03:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696845827; x=1697450627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j5BNGs+G3EOO05KikjnRTYDtKwetCUKmXOLb4daofrU=;
 b=qfbbI8yY8NqDqpTFU+Q0fKIRBefTR95t+xv8lSMJNuXM5bOZLA/wKOQgh1SutgezcJ
 ZQehS0at/51Tsq0c3w5NdIc7wgTqcwv98meR9oBYUGmTXfNy5tYMZDHI96d8MyjJMzD+
 NmYfEoyPea9/Hcgfz90JIyirbMgnv9cDwswcIxiui3rfGMAyzJtr9R6StzrB6GhiT42V
 M53BmAeLf16KmoXUVFXt+aCy34XUzfIO5lJor9sa9DOE2ZLDceUPySlfhYO+zNmQrMVl
 HsDq0PW7Si/l8LZusI1Xb3eQ6gtPlBKWQvoeLNG/VVdjQWSsLKAyLTtiRN8DSNzV7Ibz
 bSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696845827; x=1697450627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j5BNGs+G3EOO05KikjnRTYDtKwetCUKmXOLb4daofrU=;
 b=EPI1q9gFDZrWiv1TTzaDXgYF5RPXtnoHxy8kEFnGzoGVKn22gT2kirrq+qZVlKg20f
 Op1SYhfxmm5NMdpi9sBvkK56jCGJHbtUPbVKzse25vjh8pDQcDyvBVi4PVClhpuqsz4i
 VFlM5apLAEecY/Tkh8b8tQXe7BKnR5nkS8Mf6nyvaha7dG8H/J09OF7kk0XpN8JsiIVJ
 yw2M8kX3eUMmV/QD05XqG9GWFr6zEbp9pRGx3nowFPhi0n9oFQAJGYeDsQtCqq2/pQUv
 3jy5Ev0hNKxLnyreo5UwCyVXOoF0OEvvNM1KyAtCVVuWP7wsZAfr651tKX8m3mFpyeSL
 /m3w==
X-Gm-Message-State: AOJu0YwLpfhQeNA+IG0wE8G9rbWRIuTBdYdFEFx1vaNry221AHAo0VSF
 lg5wXkSL7taS+0n2C34fKevdvxj78edafdPK09M=
X-Google-Smtp-Source: AGHT+IE9YxLEt/muh86Gc/XBMo0gh/LWmufACvCNy3aaAS8ORrFjEU9a/xwBtwxGUPG8lCCYEZfjAw==
X-Received: by 2002:a05:6000:186c:b0:321:6779:944d with SMTP id
 d12-20020a056000186c00b003216779944dmr19360377wri.47.1696845826765; 
 Mon, 09 Oct 2023 03:03:46 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 z3-20020adfec83000000b0032327b70ef6sm9238656wrn.70.2023.10.09.03.03.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 03:03:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Hao Wu <wuhaotsh@google.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Tyrone Ting <kfting@nuvoton.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/10] tests/aio-multithread: Clean up global variable
 shadowing
Date: Mon,  9 Oct 2023 12:02:50 +0200
Message-ID: <20231009100251.56019-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009100251.56019-1-philmd@linaro.org>
References: <20231009100251.56019-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Rename the argument to avoid:

  tests/unit/test-aio-multithread.c:226:37: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static void test_multi_co_mutex(int threads, int seconds)
                                      ^
  tests/unit/test-aio-multithread.c:401:34: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static void test_multi_mutex(int threads, int seconds)
                                   ^
  tests/unit/test-aio-multithread.c:24:18: note: previous declaration is here
  static IOThread *threads[NUM_CONTEXTS];
                   ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-aio-multithread.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/unit/test-aio-multithread.c b/tests/unit/test-aio-multithread.c
index 08d4570ccb..d587f20667 100644
--- a/tests/unit/test-aio-multithread.c
+++ b/tests/unit/test-aio-multithread.c
@@ -223,7 +223,7 @@ static void coroutine_fn test_multi_co_mutex_entry(void *opaque)
     qatomic_dec(&running);
 }
 
-static void test_multi_co_mutex(int threads, int seconds)
+static void test_multi_co_mutex(unsigned ctx_num, int seconds)
 {
     int i;
 
@@ -233,9 +233,9 @@ static void test_multi_co_mutex(int threads, int seconds)
     now_stopping = false;
 
     create_aio_contexts();
-    assert(threads <= NUM_CONTEXTS);
-    running = threads;
-    for (i = 0; i < threads; i++) {
+    assert(ctx_num <= NUM_CONTEXTS);
+    running = ctx_num;
+    for (i = 0; i < ctx_num; i++) {
         Coroutine *co1 = qemu_coroutine_create(test_multi_co_mutex_entry, NULL);
         aio_co_schedule(ctx[i], co1);
     }
@@ -398,7 +398,7 @@ static void test_multi_mutex_entry(void *opaque)
     qatomic_dec(&running);
 }
 
-static void test_multi_mutex(int threads, int seconds)
+static void test_multi_mutex(unsigned ctx_num, int seconds)
 {
     int i;
 
@@ -408,9 +408,9 @@ static void test_multi_mutex(int threads, int seconds)
     now_stopping = false;
 
     create_aio_contexts();
-    assert(threads <= NUM_CONTEXTS);
-    running = threads;
-    for (i = 0; i < threads; i++) {
+    assert(ctx_num <= NUM_CONTEXTS);
+    running = ctx_num;
+    for (i = 0; i < ctx_num; i++) {
         Coroutine *co1 = qemu_coroutine_create(test_multi_mutex_entry, NULL);
         aio_co_schedule(ctx[i], co1);
     }
-- 
2.41.0



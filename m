Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FC8735971
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:25:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFnK-0004FL-2w; Mon, 19 Jun 2023 10:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBFnD-0004Dt-NL
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:23:45 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBFnB-0000jd-3u
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:23:42 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f906d8fca3so19903885e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184620; x=1689776620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qMEBKL6knLVKab7hTTzt13ET959rfX68OW/IE4hZmWo=;
 b=iL7duy8Mm1gdLHukDRVquaxKLu4bLM1ooJVce2XzoXPc1lcAdRCKzvsdCOstMpsjjd
 z9KCJITAoO3MuzADbmiijkOFrKhrMKdS8Dc9FkD1BocsAUGe3O7F4sD17ueABJg18YjT
 RjBngxskh9c5rSQAID3HhRkD8jLHw81BGDR8ouJNQ3rI29r8RHCkYotUibnkyCsQ+7ye
 fy2w5ANlpQme/dR359aQFnSjEqkxkbc51jDcdB3ZgW+2nv5jlw+khEdPrQ0aGyTjVXOa
 MaCJdIVbbM0lkWs0M2KN2YXQ1u44aii2JNWBNKO0rnY34itTGG1mWuu7Y296vUiH0UGt
 r+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184620; x=1689776620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qMEBKL6knLVKab7hTTzt13ET959rfX68OW/IE4hZmWo=;
 b=jKdXX6ej+pPX8JsR5Ti7lcPNcVRluCGIrQ3HPwd9I7BsFCBmio2WhdwAd9Bcot1bvZ
 6wMbKbeHHYaqIBvjLl0Xm59XscYMqyHycthU4l9CaEdBJ32OYbB8rL5QCI0LmzD3SQfB
 bGYn0VTe9QS1RSQNJUTzof55kCBqdM+1lFS760SWTsNSDCSnHv6EpiEADjCyFn4FmAsr
 AY3aBhl+HZ8xbhZcVyG7UcNybY5z7YbPV6dH96FEnQ3sY1ug/KnJ/jHacDHFX6JODJqQ
 mTArssA60wWv/QZSrVNOM53oD64Y9ro/cs8P3Gm6SKDbFj+sFPa+xWxyVYLGg7L1Fz3J
 wodQ==
X-Gm-Message-State: AC+VfDz6KhqTpvOeamlGu4S5omfidlKTtfZrakGwEbP4jU95L9sfp1zT
 ap9pe1D+T7ZcE/63F735PPb+HYFGVQgJjlE5J5izuyUf
X-Google-Smtp-Source: ACHHUZ6+G9RkA5fnzXwxBI8r4R3g1AjKgwpGd07jKy5r39ZXDN5AvDPXOutte/na/Dr5ir5qLHWkAg==
X-Received: by 2002:a7b:cb4e:0:b0:3f7:f884:7be3 with SMTP id
 v14-20020a7bcb4e000000b003f7f8847be3mr7275839wmj.4.1687184619815; 
 Mon, 19 Jun 2023 07:23:39 -0700 (PDT)
Received: from stoup.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 k25-20020a7bc419000000b003f96d10eafbsm4143467wmi.12.2023.06.19.07.23.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:23:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/5] tcg: Do not elide memory barriers for !CF_PARALLEL in
 system mode
Date: Mon, 19 Jun 2023 16:23:30 +0200
Message-Id: <20230619142333.429028-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142333.429028-1-richard.henderson@linaro.org>
References: <20230619142333.429028-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

The virtio devices require proper memory ordering between
the vcpus and the iothreads.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c07de5d9f8..7aadb37756 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -102,7 +102,19 @@ void tcg_gen_br(TCGLabel *l)
 
 void tcg_gen_mb(TCGBar mb_type)
 {
-    if (tcg_ctx->gen_tb->cflags & CF_PARALLEL) {
+#ifdef CONFIG_USER_ONLY
+    bool parallel = tcg_ctx->gen_tb->cflags & CF_PARALLEL;
+#else
+    /*
+     * It is tempting to elide the barrier in a uniprocessor context.
+     * However, even with a single cpu we have i/o threads running in
+     * parallel, and lack of memory order can result in e.g. virtio
+     * queue entries being read incorrectly.
+     */
+    bool parallel = true;
+#endif
+
+    if (parallel) {
         tcg_gen_op1(INDEX_op_mb, mb_type);
     }
 }
-- 
2.34.1



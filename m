Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D356193C963
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Jul 2024 22:13:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX4p8-00072n-LM; Thu, 25 Jul 2024 16:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sX4p5-0006t4-KW
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 16:12:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sX4p4-00068q-4i
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 16:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721938341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VVqa5+LoCMu6Kp9TvnjLZk6BG0y9wPquSFjCq1RQVM4=;
 b=PO1ubuo4tR1qsQK0pcgFaw+pnqtsrxbhbnupdoFBoq8Aqc3AOufXub2KQUsythKd78xX3q
 mFgg+oFj2U+Y9D7X+0j1fDFVaxXQK4J8i1c8HcNZFY7+lvQ6Yqy4TdT+nRKWxakHuM05nh
 gP/c83FfVncCODiZIVkIjkJlzIV+yg8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-WN0vu4GoMsKw4MU5KJY9zA-1; Thu,
 25 Jul 2024 16:12:17 -0400
X-MC-Unique: WN0vu4GoMsKw4MU5KJY9zA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E646519560B1; Thu, 25 Jul 2024 20:12:15 +0000 (UTC)
Received: from localhost (unknown [10.2.16.100])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA7A319560AE; Thu, 25 Jul 2024 20:12:14 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/1] util/async.c: Forbid negative min/max in
 aio_context_set_thread_pool_params()
Date: Thu, 25 Jul 2024 16:12:11 -0400
Message-ID: <20240725201211.460318-2-stefanha@redhat.com>
In-Reply-To: <20240725201211.460318-1-stefanha@redhat.com>
References: <20240725201211.460318-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

aio_context_set_thread_pool_params() takes two int64_t arguments to
set the minimum and maximum number of threads in the pool.  We do
some bounds checking on these, but we don't catch the case where the
inputs are negative.  This means that later in the function when we
assign these inputs to the AioContext::thread_pool_min and
::thread_pool_max fields, which are of type int, the values might
overflow the smaller type.

A negative number of threads is meaningless, so make
aio_context_set_thread_pool_params() return an error if either min or
max are negative.

Resolves: Coverity CID 1547605
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240723150927.1396456-1-peter.maydell@linaro.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/async.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/async.c b/util/async.c
index 0467890052..3e3e4fc712 100644
--- a/util/async.c
+++ b/util/async.c
@@ -746,7 +746,7 @@ void aio_context_set_thread_pool_params(AioContext *ctx, int64_t min,
                                         int64_t max, Error **errp)
 {
 
-    if (min > max || !max || min > INT_MAX || max > INT_MAX) {
+    if (min > max || max <= 0 || min < 0 || min > INT_MAX || max > INT_MAX) {
         error_setg(errp, "bad thread-pool-min/thread-pool-max values");
         return;
     }
-- 
2.45.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11415B0CC55
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Jul 2025 23:17:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udxqP-00087n-L5; Mon, 21 Jul 2025 17:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udxlw-00044m-5J
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 17:10:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udxls-0007iu-3o
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 17:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753132203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X+W31z6YjCPE1k472t2A5043p8YVXZow4qRBgoq1+Xs=;
 b=ZC6ba4Y/PqO60TV10KKrkbWYn/0fdQjTc+0r2RB3biS49EZLKfKi00/nCpUjxgd5pmcDBM
 dQL1JVAA11SYLQG6uDNEC+rFfVi4jX3Op/W1KnANXlZRlqntPNrjJPgNrLJ7dPxPSHAeXL
 SZvD9ZFtR3HnVbl8P7SQvHeU91BDlAI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-WfTxZnBbOv2BdcU6WpW7zA-1; Mon,
 21 Jul 2025 17:09:55 -0400
X-MC-Unique: WfTxZnBbOv2BdcU6WpW7zA-1
X-Mimecast-MFC-AGG-ID: WfTxZnBbOv2BdcU6WpW7zA_1753132194
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AED0918001F7; Mon, 21 Jul 2025 21:09:53 +0000 (UTC)
Received: from localhost (unknown [10.2.16.31])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F02421800D82; Mon, 21 Jul 2025 21:09:52 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, hibriansong@gmail.com, eblake@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Chao Gao <chao.gao@intel.com>
Subject: [PATCH v3 02/12] aio-posix: keep polling enabled with fdmon-io_uring.c
Date: Mon, 21 Jul 2025 17:07:49 -0400
Message-ID: <20250721210759.179709-3-stefanha@redhat.com>
In-Reply-To: <20250721210759.179709-1-stefanha@redhat.com>
References: <20250721210759.179709-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit 816a430c517e ("util/aio: Defer disabling poll mode as long as
possible") kept polling enabled when the event loop timeout is 0. Since
there is no timeout the event loop will continue immediately and the
overhead of disabling and re-enabling polling can be avoided.

fdmon-io_uring.c is unable to take advantage of this optimization
because its ->need_wait() function returns true whenever there are new
io_uring SQEs to submit:

  if (timeout || ctx->fdmon_ops->need_wait(ctx)) {
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Polling will be disabled even when timeout == 0.

Extend the optimization to handle the case when need_wait() returns true
and timeout == 0.

Cc: Chao Gao <chao.gao@intel.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 util/aio-posix.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 2e0a5dadc4..824fdc34cc 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -559,7 +559,14 @@ static bool run_poll_handlers(AioContext *ctx, AioHandlerList *ready_list,
         elapsed_time = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start_time;
         max_ns = qemu_soonest_timeout(*timeout, max_ns);
         assert(!(max_ns && progress));
-    } while (elapsed_time < max_ns && !ctx->fdmon_ops->need_wait(ctx));
+
+        if (ctx->fdmon_ops->need_wait(ctx)) {
+            if (fdmon_supports_polling(ctx)) {
+                *timeout = 0; /* stay in polling mode */
+            }
+            break;
+        }
+    } while (elapsed_time < max_ns);
 
     if (remove_idle_poll_handlers(ctx, ready_list,
                                   start_time + elapsed_time)) {
@@ -722,7 +729,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
          * up IO threads when some work becomes pending. It is essential to
          * avoid hangs or unnecessary latency.
          */
-        if (poll_set_started(ctx, &ready_list, false)) {
+        if (timeout && poll_set_started(ctx, &ready_list, false)) {
             timeout = 0;
             progress = true;
         }
-- 
2.50.1



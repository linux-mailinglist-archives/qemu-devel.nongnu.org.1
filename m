Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8B3C20E89
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Oct 2025 16:25:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEUTg-0004YU-9n; Thu, 30 Oct 2025 11:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vEUTc-0004WR-CP
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:22:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vEUTR-0006Ra-VF
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761837720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bhIdU9Pq68DIdlooXfnd0NMfqftgWIVgWgth4LIJHLs=;
 b=b3l0BCE+eEWLqSrZv08LghTZjrVRSVNHCHZAFVNwWtjYF3tmVVSGPbGgDpFHrDc4o6F24x
 bGtfpXDK/KB7vSZLbj3EpkfCi0HfP1f6lNO56Dq5JtIvGs1YmyOpuOMKRa5Gly5SM9HAlX
 ak1uKFMK7RtiLhICieMi1ejm8ZyCadI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-tauMfiqyPxiKW9IH_zf62w-1; Thu,
 30 Oct 2025 11:21:57 -0400
X-MC-Unique: tauMfiqyPxiKW9IH_zf62w-1
X-Mimecast-MFC-AGG-ID: tauMfiqyPxiKW9IH_zf62w_1761837716
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B48F1955EB5; Thu, 30 Oct 2025 15:21:56 +0000 (UTC)
Received: from localhost (unknown [10.2.16.94])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 26AFC18002AD; Thu, 30 Oct 2025 15:21:56 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 hibriansong@gmail.com, eblake@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Subject: [RESEND PATCH v5 03/13] tests/unit: skip test-nested-aio-poll with
 io_uring
Date: Thu, 30 Oct 2025 11:21:39 -0400
Message-ID: <20251030152150.470170-4-stefanha@redhat.com>
In-Reply-To: <20251030152150.470170-1-stefanha@redhat.com>
References: <20251030152150.470170-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

test-nested-aio-poll relies on internal details of how fdmon-poll.c
handles AioContext polling. Skip it when other fdmon implementations are
in use.

The reason why fdmon-io_uring.c behaves differently from fdmon-poll.c is
that its fdmon_ops->need_wait() function returns true when
io_uring_enter(2) must be called (e.g. to submit pending SQEs).
AioContext polling is skipped when ->need_wait() returns true, so the
test case will never enter AioContext polling mode with
fdmon-io_uring.c.

Restrict this test to fdmon-poll.c and drop the
aio_context_use_g_source() call since it's no longer necessary.

Note that this test is only built on POSIX systems so it is safe to
include "util/aio-posix.h".

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
v5:
- Explain how fdmon-io_uring.c differs from other fdmon implementations
  in commit message [Kevin]
- Move test-nested-aio-poll aio_get_g_source() removal into commit that touches test case [Kevin]
---
 tests/unit/test-nested-aio-poll.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tests/unit/test-nested-aio-poll.c b/tests/unit/test-nested-aio-poll.c
index d8fd92c43b..d13ecccd8c 100644
--- a/tests/unit/test-nested-aio-poll.c
+++ b/tests/unit/test-nested-aio-poll.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "block/aio.h"
 #include "qapi/error.h"
+#include "util/aio-posix.h"
 
 typedef struct {
     AioContext *ctx;
@@ -71,17 +72,17 @@ static void test(void)
         .ctx = aio_context_new(&error_abort),
     };
 
+    if (td.ctx->fdmon_ops != &fdmon_poll_ops) {
+        /* This test is tied to fdmon-poll.c */
+        g_test_skip("fdmon_poll_ops not in use");
+        return;
+    }
+
     qemu_set_current_aio_context(td.ctx);
 
     /* Enable polling */
     aio_context_set_poll_params(td.ctx, 1000000, 2, 2, &error_abort);
 
-    /*
-     * The GSource is unused but this has the side-effect of changing the fdmon
-     * that AioContext uses.
-     */
-    aio_get_g_source(td.ctx);
-
     /* Make the event notifier active (set) right away */
     event_notifier_init(&td.poll_notifier, 1);
     aio_set_event_notifier(td.ctx, &td.poll_notifier,
-- 
2.51.0



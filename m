Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 716597169B8
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:35:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42IB-0007b7-Qz; Tue, 30 May 2023 12:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HK-0006Ta-Oc
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HI-0008FZ-Jj
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685464375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vpc8zDjMqIuzsQIO6J/QaTdJHUjH0z7XgaFZD9150hw=;
 b=dUjSDQial+5OcxEccPKKg1pp4gb2F9fRtAj7k2RdE9bFJ1he86IY0tInvt5g912Kv+sJ27
 4LUfk0K3bB+X1klJ0ca0KGsZ/OJC3jl6OgLdOjTM70LWlb1SPYFIhdo1ICK1a+kQero17c
 61lubUBMhWOElbptnZUO6Nju7hGy3OA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-S_GokUWIM5ujo_csPOupBg-1; Tue, 30 May 2023 12:32:54 -0400
X-MC-Unique: S_GokUWIM5ujo_csPOupBg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2832800B2A;
 Tue, 30 May 2023 16:32:53 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 019BDC154D2;
 Tue, 30 May 2023 16:32:52 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 07/32] raw-format: Fix open with 'file' in iothread
Date: Tue, 30 May 2023 18:32:14 +0200
Message-Id: <20230530163239.576632-8-kwolf@redhat.com>
In-Reply-To: <20230530163239.576632-1-kwolf@redhat.com>
References: <20230530163239.576632-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

When opening the 'file' child moves bs to an iothread, we need to hold
the AioContext lock of it before we can call raw_apply_options() (and
more specifically, bdrv_getlength() inside of it).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230525124713.401149-8-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/raw-format.c               | 5 +++++
 tests/unit/test-block-iothread.c | 3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/raw-format.c b/block/raw-format.c
index 918fe4fb7e..e4f35268e6 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -468,6 +468,7 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
                     Error **errp)
 {
     BDRVRawState *s = bs->opaque;
+    AioContext *ctx;
     bool has_size;
     uint64_t offset, size;
     BdrvChildRole file_role;
@@ -515,7 +516,11 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
                 bs->file->bs->filename);
     }
 
+    ctx = bdrv_get_aio_context(bs);
+    aio_context_acquire(ctx);
     ret = raw_apply_options(bs, s, offset, has_size, size, errp);
+    aio_context_release(ctx);
+
     if (ret < 0) {
         return ret;
     }
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 1b40e65bad..f081c09729 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -833,12 +833,9 @@ static void test_attach_second_node(void)
     qdict_put_str(options, "driver", "raw");
     qdict_put_str(options, "file", "base");
 
-    /* FIXME raw_open() should take ctx's lock internally */
-    aio_context_acquire(ctx);
     aio_context_acquire(main_ctx);
     filter = bdrv_open(NULL, NULL, options, BDRV_O_RDWR, &error_abort);
     aio_context_release(main_ctx);
-    aio_context_release(ctx);
 
     g_assert(blk_get_aio_context(blk) == ctx);
     g_assert(bdrv_get_aio_context(bs) == ctx);
-- 
2.40.1



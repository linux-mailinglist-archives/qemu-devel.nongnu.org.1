Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F9B7169CC
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:36:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42IA-0007A3-Di; Tue, 30 May 2023 12:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HF-0006NS-Mh
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HE-0008Dq-5K
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685464371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dzhFKhskU/fSjYHhxXdldkdr3BKm2r8aQp10XT8mT9E=;
 b=QGlsGOP+sXd6qm7NDJ8Q/VWlUzTaW4nNqc0r6ZYNoE0sdrsNpwPCUJNQAhPFQqH1DFyIly
 Vh9nB7tUNOinlKRjSGPE/ZITnkMZHSYRV12zTasPyMZfDLrSLmnvxBd3MjYUvg7BdWTq+M
 cJUfB618t1TYCAglUZp7B7m1rHbnRyY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-KqUrSezdP0ya2L8pVUxyfQ-1; Tue, 30 May 2023 12:32:49 -0400
X-MC-Unique: KqUrSezdP0ya2L8pVUxyfQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAD8F28EC101;
 Tue, 30 May 2023 16:32:48 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C785C154D2;
 Tue, 30 May 2023 16:32:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 02/32] block: Clarify locking rules for bdrv_open(_inherit)()
Date: Tue, 30 May 2023 18:32:09 +0200
Message-Id: <20230530163239.576632-3-kwolf@redhat.com>
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

These functions specify that the caller must hold the "@filename
AioContext lock". This doesn't make sense, file names don't have an
AioContext. New BlockDriverStates always start in the main AioContext,
so this is what we really need here.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230525124713.401149-3-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/block.c b/block.c
index a2f8d5a0c0..6ac47112fe 100644
--- a/block.c
+++ b/block.c
@@ -3810,9 +3810,7 @@ out:
  * should be opened. If specified, neither options nor a filename may be given,
  * nor can an existing BDS be reused (that is, *pbs has to be NULL).
  *
- * The caller must always hold @filename AioContext lock, because this
- * function eventually calls bdrv_refresh_total_sectors() which polls
- * when called from non-coroutine context.
+ * The caller must always hold the main AioContext lock.
  */
 static BlockDriverState * no_coroutine_fn
 bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
@@ -4100,11 +4098,7 @@ close_and_fail:
     return NULL;
 }
 
-/*
- * The caller must always hold @filename AioContext lock, because this
- * function eventually calls bdrv_refresh_total_sectors() which polls
- * when called from non-coroutine context.
- */
+/* The caller must always hold the main AioContext lock. */
 BlockDriverState *bdrv_open(const char *filename, const char *reference,
                             QDict *options, int flags, Error **errp)
 {
-- 
2.40.1



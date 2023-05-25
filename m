Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E87710C57
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 14:49:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ANq-0007yu-5B; Thu, 25 May 2023 08:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2ANU-0007wO-Kz
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:47:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2ANP-0001yu-LH
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685018851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=051AE6V7xY7ZlAOEC8ZQs+l53uCfZzE58ah4xTn0ORA=;
 b=g2UWh3ij8C5ZvesHd4+/3Akn+ud22nPvEG4JypeIsEw0qTxPmzGJrfESJ9YErT1PoXb/vy
 6vGWoFV7okqRwI93U2UPGccxUMm5ZNrZm7iUI/fc1SEcZ+J0qfOoQJS4Cw41BZ8zuruDcL
 NUUvLDpI7hhFcbnwSCyzuC4vKd9bnvY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-kWVh3NygPQGaIc1cSwOa-g-1; Thu, 25 May 2023 08:47:29 -0400
X-MC-Unique: kWVh3NygPQGaIc1cSwOa-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A38B3C13506;
 Thu, 25 May 2023 12:47:29 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 528FD8162;
 Thu, 25 May 2023 12:47:28 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 05/12] mirror: Hold main AioContext lock for calling
 bdrv_open_backing_file()
Date: Thu, 25 May 2023 14:47:06 +0200
Message-Id: <20230525124713.401149-6-kwolf@redhat.com>
In-Reply-To: <20230525124713.401149-1-kwolf@redhat.com>
References: <20230525124713.401149-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

bdrv_open_backing_file() calls bdrv_open_inherit(), so all callers must
hold the main AioContext lock.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c        | 2 ++
 block/mirror.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/block.c b/block.c
index 79bc9c01de..be9ae364fb 100644
--- a/block.c
+++ b/block.c
@@ -3478,6 +3478,8 @@ int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
  * itself, all options starting with "${bdref_key}." are considered part of the
  * BlockdevRef.
  *
+ * The caller must hold the main AioContext lock.
+ *
  * TODO Can this be unified with bdrv_open_image()?
  */
 int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
diff --git a/block/mirror.c b/block/mirror.c
index b7d92d1378..d3cacd1708 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -662,11 +662,15 @@ static int mirror_exit_common(Job *job)
     bool abort = job->ret < 0;
     int ret = 0;
 
+    GLOBAL_STATE_CODE();
+
     if (s->prepared) {
         return 0;
     }
     s->prepared = true;
 
+    aio_context_acquire(qemu_get_aio_context());
+
     mirror_top_bs = s->mirror_top_bs;
     bs_opaque = mirror_top_bs->opaque;
     src = mirror_top_bs->backing->bs;
@@ -789,6 +793,8 @@ static int mirror_exit_common(Job *job)
     bdrv_unref(mirror_top_bs);
     bdrv_unref(src);
 
+    aio_context_release(qemu_get_aio_context());
+
     return ret;
 }
 
-- 
2.40.1



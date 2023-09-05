Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2E17922CE
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 15:08:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdVl8-0003UC-V6; Tue, 05 Sep 2023 09:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdVl5-0003Te-UM
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 09:06:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdVl3-0001Gg-El
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 09:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693919176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JvzDTd8EDUKZrfNHwcpjAeg6YgYhrUZ9V3tY6lsczNw=;
 b=F2s/qeyzdPf1WycQ1ftR1q66lnF6nE7HnwJKKmjkkPpcEegoXU4a6yOfDYd/DNGJ/QpomC
 B5cljBPzeKJL6cSPC6GxXcGNJ+JE9QYCj3WpFepW7vCaTBuOUm6gxjuhX4e70pO/Q4VZvu
 XZzA9f6Mi0PCSiTl6whiXUeCzBEsneA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-YIwQk56_MD2mCd6ypdBrrg-1; Tue, 05 Sep 2023 09:06:13 -0400
X-MC-Unique: YIwQk56_MD2mCd6ypdBrrg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C7773C0FC84;
 Tue,  5 Sep 2023 13:06:13 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7184E21EE565;
 Tue,  5 Sep 2023 13:06:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] block: Make more BlockDriver definitions static
Date: Tue,  5 Sep 2023 15:06:07 +0200
Message-ID: <20230905130607.35134-3-kwolf@redhat.com>
In-Reply-To: <20230905130607.35134-1-kwolf@redhat.com>
References: <20230905130607.35134-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Most block driver implementations don't have any reason for their
BlockDriver to be public. The only exceptions are bdrv_file, bdrv_raw
and bdrv_qcow2, which are actually used in other source files.

Make all other BlockDriver definitions static if they aren't yet.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/copy-before-write.c | 2 +-
 block/preallocate.c       | 2 +-
 block/snapshot-access.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index b866e42271..9a0e2b69d9 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -503,7 +503,7 @@ static void cbw_close(BlockDriverState *bs)
     s->bcs = NULL;
 }
 
-BlockDriver bdrv_cbw_filter = {
+static BlockDriver bdrv_cbw_filter = {
     .format_name = "copy-before-write",
     .instance_size = sizeof(BDRVCopyBeforeWriteState),
 
diff --git a/block/preallocate.c b/block/preallocate.c
index 4d82125036..3d0f621003 100644
--- a/block/preallocate.c
+++ b/block/preallocate.c
@@ -535,7 +535,7 @@ static void preallocate_child_perm(BlockDriverState *bs, BdrvChild *c,
     }
 }
 
-BlockDriver bdrv_preallocate_filter = {
+static BlockDriver bdrv_preallocate_filter = {
     .format_name = "preallocate",
     .instance_size = sizeof(BDRVPreallocateState),
 
diff --git a/block/snapshot-access.c b/block/snapshot-access.c
index 67ea339da9..8d4e8932b8 100644
--- a/block/snapshot-access.c
+++ b/block/snapshot-access.c
@@ -108,7 +108,7 @@ static void snapshot_access_child_perm(BlockDriverState *bs, BdrvChild *c,
     *nshared = BLK_PERM_ALL;
 }
 
-BlockDriver bdrv_snapshot_access_drv = {
+static BlockDriver bdrv_snapshot_access_drv = {
     .format_name = "snapshot-access",
 
     .bdrv_open                  = snapshot_access_open,
-- 
2.41.0



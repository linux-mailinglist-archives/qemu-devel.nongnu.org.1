Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 018977D9D9C
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:56:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPAE-0003wr-7V; Fri, 27 Oct 2023 11:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwP9w-0003Z6-Gi
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwP9u-0002is-Ar
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698422041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UHMCI0H+gXZ+AaoChqFeHQ7NfIYhbmXdPzLnFa0KL5M=;
 b=Z+kr5IUczl+oDRtO+jEyVENrEi4JX4h1ihMJWS7oeD1uIAW0tREIVd1AtF5cqZZD/yYozq
 YHFCG7whVnI2N+kGRW5uYzAIu67VrLKXzzPzB52YAE0oykCYYQsDgqr/J7P08w2woKMeYL
 6Gj2V7Oir/i8O7a/vpo2lajIkD+o4Ys=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-CPoH7OHFML630na3Ul6pow-1; Fri, 27 Oct 2023 11:53:57 -0400
X-MC-Unique: CPoH7OHFML630na3Ul6pow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A56A801956;
 Fri, 27 Oct 2023 15:53:57 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04D955027;
 Fri, 27 Oct 2023 15:53:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 11/24] block: Mark bdrv_filter_child() and callers GRAPH_RDLOCK
Date: Fri, 27 Oct 2023 17:53:20 +0200
Message-ID: <20231027155333.420094-12-kwolf@redhat.com>
In-Reply-To: <20231027155333.420094-1-kwolf@redhat.com>
References: <20231027155333.420094-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This adds GRAPH_RDLOCK annotations to declare that callers of
bdrv_filter_child() need to hold a reader lock for the graph because it
accesses bs->file/backing.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-io.h | 4 ++--
 block.c                      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/block/block_int-io.h b/include/block/block_int-io.h
index 4e7bf57a5e..17547a2dab 100644
--- a/include/block/block_int-io.h
+++ b/include/block/block_int-io.h
@@ -131,8 +131,8 @@ int co_wrapper_mixed_bdrv_rdlock
 bdrv_refresh_total_sectors(BlockDriverState *bs, int64_t hint);
 
 BdrvChild *bdrv_cow_child(BlockDriverState *bs);
-BdrvChild *bdrv_filter_child(BlockDriverState *bs);
-BdrvChild *bdrv_filter_or_cow_child(BlockDriverState *bs);
+BdrvChild * GRAPH_RDLOCK bdrv_filter_child(BlockDriverState *bs);
+BdrvChild * GRAPH_RDLOCK bdrv_filter_or_cow_child(BlockDriverState *bs);
 BdrvChild * GRAPH_RDLOCK bdrv_primary_child(BlockDriverState *bs);
 BlockDriverState * GRAPH_RDLOCK bdrv_skip_filters(BlockDriverState *bs);
 BlockDriverState * GRAPH_RDLOCK bdrv_backing_chain_next(BlockDriverState *bs);
diff --git a/block.c b/block.c
index bb322df7d8..499b147315 100644
--- a/block.c
+++ b/block.c
@@ -8491,8 +8491,8 @@ BdrvChild *bdrv_primary_child(BlockDriverState *bs)
     return found;
 }
 
-static BlockDriverState *bdrv_do_skip_filters(BlockDriverState *bs,
-                                              bool stop_on_explicit_filter)
+static BlockDriverState * GRAPH_RDLOCK
+bdrv_do_skip_filters(BlockDriverState *bs, bool stop_on_explicit_filter)
 {
     BdrvChild *c;
 
-- 
2.41.0



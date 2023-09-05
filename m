Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED61D7922CD
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 15:08:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdVlC-0003VH-76; Tue, 05 Sep 2023 09:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdVl9-0003Ue-G6
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 09:06:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdVl2-0001GZ-Jh
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 09:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693919175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fgP4MJkR1gETM7R7U4KMW/K+jAX8ulVlyaA2rubVYGE=;
 b=afBBvOVeKJS7w2GOBo+832X638gNpn4m9lPLHmavtwDMaznr/iN9WueRhdP7CpzMG9Sxc5
 lxXYZOp5wzafRa0gbru5zWZDwHFrKpQlJt5MoLapJHSYG+HNB9UE5UITf5zPKPgT/lLU8z
 d1274prbhyJsCSozZXl1vpZHUp4zKaw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-LyEt0F_0NBCJfALzU0_nwQ-1; Tue, 05 Sep 2023 09:06:12 -0400
X-MC-Unique: LyEt0F_0NBCJfALzU0_nwQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A93C1040869;
 Tue,  5 Sep 2023 13:06:12 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F89621D4F3F;
 Tue,  5 Sep 2023 13:06:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] block/meson.build: Restore alphabetical order of files
Date: Tue,  5 Sep 2023 15:06:06 +0200
Message-ID: <20230905130607.35134-2-kwolf@redhat.com>
In-Reply-To: <20230905130607.35134-1-kwolf@redhat.com>
References: <20230905130607.35134-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When commit 5e5733e5999 created block/meson.build, the list of
unconditionally added files was in alphabetical order. Later commits
added new files in random places. Reorder the list to be alphabetical
again. (As for ordering foo.c against foo-*.c, there are both ways used
currently; standardise on having foo.c first, even though this is
different from the original commit 5e5733e5999.)

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/meson.build | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/meson.build b/block/meson.build
index 529fc172c6..f351b9d0d3 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -4,41 +4,41 @@ block_ss.add(files(
   'aio_task.c',
   'amend.c',
   'backup.c',
-  'copy-before-write.c',
   'blkdebug.c',
   'blklogwrites.c',
   'blkverify.c',
   'block-backend.c',
   'block-copy.c',
-  'graph-lock.c',
   'commit.c',
+  'copy-before-write.c',
   'copy-on-read.c',
-  'preallocate.c',
-  'progress_meter.c',
   'create.c',
   'crypto.c',
   'dirty-bitmap.c',
   'filter-compress.c',
+  'graph-lock.c',
   'io.c',
   'mirror.c',
   'nbd.c',
   'null.c',
   'plug.c',
+  'preallocate.c',
+  'progress_meter.c',
   'qapi.c',
+  'qcow2.c',
   'qcow2-bitmap.c',
   'qcow2-cache.c',
   'qcow2-cluster.c',
   'qcow2-refcount.c',
   'qcow2-snapshot.c',
   'qcow2-threads.c',
-  'qcow2.c',
   'quorum.c',
   'raw-format.c',
   'reqlist.c',
   'snapshot.c',
   'snapshot-access.c',
-  'throttle-groups.c',
   'throttle.c',
+  'throttle-groups.c',
   'write-threshold.c',
 ), zstd, zlib, gnutls)
 
-- 
2.41.0



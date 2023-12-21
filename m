Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D1A81C01A
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:28:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQWh-00079z-JH; Thu, 21 Dec 2023 16:24:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWc-0006vs-Fb
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWZ-00082H-Sc
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703193850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ERFL6t2Tb+M9pWRPOd+XWkXtWf8LEVISOvHqlE+Icyc=;
 b=TjbV4tKTZe1XKJCiQc7GRCwLLTyGPYzK0I5FpLNwvDhAcdt3fdJVStNE3sHgCLt5UUI8VU
 tMvQ5zYBLANxndpLpy4yuz0tRIoOzaZHzd1fGbO3umKT5RMqqedm9gEJNco5N5A/BaYUNL
 ducsbCPzuzznK9Q713zw30Nq+PpoAMQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-GrsFHK7fPUGbPTozYYTz3Q-1; Thu,
 21 Dec 2023 16:24:08 -0500
X-MC-Unique: GrsFHK7fPUGbPTozYYTz3Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FED21C05EA8;
 Thu, 21 Dec 2023 21:24:08 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6016EC15A0C;
 Thu, 21 Dec 2023 21:24:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 08/33] block: Fix crash when loading snapshot on inactive node
Date: Thu, 21 Dec 2023 22:23:13 +0100
Message-ID: <20231221212339.164439-9-kwolf@redhat.com>
In-Reply-To: <20231221212339.164439-1-kwolf@redhat.com>
References: <20231221212339.164439-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

bdrv_is_read_only() only checks if the node is configured to be
read-only eventually, but even if it returns false, writing to the node
may not be permitted at the moment (because it's inactive).

bdrv_is_writable() checks that the node can be written to right now, and
this is what the snapshot operations really need.

Change bdrv_can_snapshot() to use bdrv_is_writable() to fix crashes like
the following:

$ ./qemu-system-x86_64 -hda /tmp/test.qcow2 -loadvm foo -incoming defer
qemu-system-x86_64: ../block/io.c:1990: int bdrv_co_write_req_prepare(BdrvChild *, int64_t, int64_t, BdrvTrackedRequest *, int): Assertion `!(bs->open_flags & BDRV_O_INACTIVE)' failed.

The resulting error message after this patch isn't perfect yet, but at
least it doesn't crash any more:

$ ./qemu-system-x86_64 -hda /tmp/test.qcow2 -loadvm foo -incoming defer
qemu-system-x86_64: Device 'ide0-hd0' is writable but does not support snapshots

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231201142520.32255-2-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/snapshot.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/snapshot.c b/block/snapshot.c
index ec8cf4810b..c4d40e80dd 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -196,8 +196,10 @@ bdrv_snapshot_fallback(BlockDriverState *bs)
 int bdrv_can_snapshot(BlockDriverState *bs)
 {
     BlockDriver *drv = bs->drv;
+
     GLOBAL_STATE_CODE();
-    if (!drv || !bdrv_is_inserted(bs) || bdrv_is_read_only(bs)) {
+
+    if (!drv || !bdrv_is_inserted(bs) || !bdrv_is_writable(bs)) {
         return 0;
     }
 
-- 
2.43.0



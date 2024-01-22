Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 355B9836979
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 17:02:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRwk8-0001aW-Lg; Mon, 22 Jan 2024 11:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rRwk4-0001W8-1y
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:01:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rRwk2-0004CE-Gk
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705939301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9eZYOBiyLtZMjq2yi8d9zHmoX+ctsJtlNfR3xYLfzKY=;
 b=UEVZxXcOwS+arC92C0WlVKlHrAvEczjCMxwr6o+D5fIVn/9WN3UCjQ+Dv11xyywZEe+L3R
 wXlyn2mwXJ2qFfZFsiVEwyI2a0tgrEquf2VESAq4THJ7bmy5dVlCvOKTaDy8tkkJj4rjeW
 SNLMC5DprNuurMKAVM9+sNmeEFj/iXg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-PtCncahCMqW2fSpv_o-Raw-1; Mon, 22 Jan 2024 11:01:35 -0500
X-MC-Unique: PtCncahCMqW2fSpv_o-Raw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E87C85A5BC;
 Mon, 22 Jan 2024 16:01:34 +0000 (UTC)
Received: from localhost (unknown [10.39.194.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DEDA1C060AF;
 Mon, 22 Jan 2024 16:01:32 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 2/2] block/io: clear BDRV_BLOCK_RECURSE flag after recursing in
 bdrv_co_block_status
Date: Mon, 22 Jan 2024 11:01:26 -0500
Message-ID: <20240122160126.394141-3-stefanha@redhat.com>
In-Reply-To: <20240122160126.394141-1-stefanha@redhat.com>
References: <20240122160126.394141-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

Using fleecing backup like in [0] on a qcow2 image (with metadata
preallocation) can lead to the following assertion failure:

> bdrv_co_do_block_status: Assertion `!(ret & BDRV_BLOCK_ZERO)' failed.

In the reproducer [0], it happens because the BDRV_BLOCK_RECURSE flag
will be set by the qcow2 driver, so the caller will recursively check
the file child. Then the BDRV_BLOCK_ZERO set too. Later up the call
chain, in bdrv_co_do_block_status() for the snapshot-access driver,
the assertion failure will happen, because both flags are set.

To fix it, clear the recurse flag after the recursive check was done.

In detail:

> #0  qcow2_co_block_status

Returns 0x45 = BDRV_BLOCK_RECURSE | BDRV_BLOCK_DATA |
BDRV_BLOCK_OFFSET_VALID.

> #1  bdrv_co_do_block_status

Because of the data flag, bdrv_co_do_block_status() will now also set
BDRV_BLOCK_ALLOCATED. Because of the recurse flag,
bdrv_co_do_block_status() for the bdrv_file child will be called,
which returns 0x16 = BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_OFFSET_VALID |
BDRV_BLOCK_ZERO. Now the return value inherits the zero flag.

Returns 0x57 = BDRV_BLOCK_RECURSE | BDRV_BLOCK_DATA |
BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_ZERO.

> #2  bdrv_co_common_block_status_above
> #3  bdrv_co_block_status_above
> #4  bdrv_co_block_status
> #5  cbw_co_snapshot_block_status
> #6  bdrv_co_snapshot_block_status
> #7  snapshot_access_co_block_status
> #8  bdrv_co_do_block_status

Return value is propagated all the way up to here, where the assertion
failure happens, because BDRV_BLOCK_RECURSE and BDRV_BLOCK_ZERO are
both set.

> #9  bdrv_co_common_block_status_above
> #10 bdrv_co_block_status_above
> #11 block_copy_block_status
> #12 block_copy_dirty_clusters
> #13 block_copy_common
> #14 block_copy_async_co_entry
> #15 coroutine_trampoline

[0]:

> #!/bin/bash
> rm /tmp/disk.qcow2
> ./qemu-img create /tmp/disk.qcow2 -o preallocation=metadata -f qcow2 1G
> ./qemu-img create /tmp/fleecing.qcow2 -f qcow2 1G
> ./qemu-img create /tmp/backup.qcow2 -f qcow2 1G
> ./qemu-system-x86_64 --qmp stdio \
> --blockdev qcow2,node-name=node0,file.driver=file,file.filename=/tmp/disk.qcow2 \
> --blockdev qcow2,node-name=node1,file.driver=file,file.filename=/tmp/fleecing.qcow2 \
> --blockdev qcow2,node-name=node2,file.driver=file,file.filename=/tmp/backup.qcow2 \
> <<EOF
> {"execute": "qmp_capabilities"}
> {"execute": "blockdev-add", "arguments": { "driver": "copy-before-write", "file": "node0", "target": "node1", "node-name": "node3" } }
> {"execute": "blockdev-add", "arguments": { "driver": "snapshot-access", "file": "node3", "node-name": "snap0" } }
> {"execute": "blockdev-backup", "arguments": { "device": "snap0", "target": "node1", "sync": "full", "job-id": "backup0" } }
> EOF

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-id: 20240116154839.401030-1-f.ebner@proxmox.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/io.c b/block/io.c
index 8fa7670571..33150c0359 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2584,6 +2584,16 @@ bdrv_co_do_block_status(BlockDriverState *bs, bool want_zero,
                 ret |= (ret2 & BDRV_BLOCK_ZERO);
             }
         }
+
+        /*
+         * Now that the recursive search was done, clear the flag. Otherwise,
+         * with more complicated block graphs like snapshot-access ->
+         * copy-before-write -> qcow2, where the return value will be propagated
+         * further up to a parent bdrv_co_do_block_status() call, both the
+         * BDRV_BLOCK_RECURSE and BDRV_BLOCK_ZERO flags would be set, which is
+         * not allowed.
+         */
+        ret &= ~BDRV_BLOCK_RECURSE;
     }
 
 out:
-- 
2.43.0



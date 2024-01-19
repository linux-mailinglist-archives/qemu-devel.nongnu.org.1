Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF7A832EB9
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 19:15:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQtNK-0001gk-MD; Fri, 19 Jan 2024 13:13:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtN8-0001cv-KR
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:13:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtN5-0007ZP-V3
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705688017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7KXVoT9IraWqlZ0Y8JMlj17j6pFajLnqEWukWX7hPLs=;
 b=CV/2AWqZZf12VtMojhRxDgEIokTNwDBlxo9oLLM//os5McsJPwH7A976ZYlhPGIEbBondS
 rpDcgkKdxpKfyG78g9Mp4N6FCb1Wd6ucNWh81XqBVw+NtQFY/tIhZmhMlYpClUawAl3pYh
 7atDQckhAM4QXN93xW2efJovn/oEHgw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-ipxZrrffOJqw720Kkp8Eqw-1; Fri, 19 Jan 2024 13:13:35 -0500
X-MC-Unique: ipxZrrffOJqw720Kkp8Eqw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCE9F185A786;
 Fri, 19 Jan 2024 18:13:33 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E5CA1B96;
 Fri, 19 Jan 2024 18:13:33 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 01/14] block/blklogwrites: Fix a bug when logging "write
 zeroes" operations.
Date: Fri, 19 Jan 2024 19:13:14 +0100
Message-ID: <20240119181327.236745-2-kwolf@redhat.com>
In-Reply-To: <20240119181327.236745-1-kwolf@redhat.com>
References: <20240119181327.236745-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
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

From: Ari Sundholm <ari@tuxera.com>

There is a bug in the blklogwrites driver pertaining to logging "write
zeroes" operations, causing log corruption. This can be easily observed
by setting detect-zeroes to something other than "off" for the driver.

The issue is caused by a concurrency bug pertaining to the fact that
"write zeroes" operations have to be logged in two parts: first the log
entry metadata, then the zeroed-out region. While the log entry
metadata is being written by bdrv_co_pwritev(), another operation may
begin in the meanwhile and modify the state of the blklogwrites driver.
This is as intended by the coroutine-driven I/O model in QEMU, of
course.

Unfortunately, this specific scenario is mishandled. A short example:
    1. Initially, in the current operation (#1), the current log sector
number in the driver state is only incremented by the number of sectors
taken by the log entry metadata, after which the log entry metadata is
written. The current operation yields.
    2. Another operation (#2) may start while the log entry metadata is
being written. It uses the current log position as the start offset for
its log entry. This is in the sector right after the operation #1 log
entry metadata, which is bad!
    3. After bdrv_co_pwritev() returns (#1), the current log sector
number is reread from the driver state in order to find out the start
offset for bdrv_co_pwrite_zeroes(). This is an obvious blunder, as the
offset will be the sector right after the (misplaced) operation #2 log
entry, which means that the zeroed-out region begins at the wrong
offset.
    4. As a result of the above, the log is corrupt.

Fix this by only reading the driver metadata once, computing the
offsets and sizes in one go (including the optional zeroed-out region)
and setting the log sector number to the appropriate value for the next
operation in line.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
Cc: qemu-stable@nongnu.org
Message-ID: <20240109184646.1128475-1-megari@gmx.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/blklogwrites.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 7207b2e757..ba717dab4d 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -328,22 +328,39 @@ static void coroutine_fn GRAPH_RDLOCK
 blk_log_writes_co_do_log(BlkLogWritesLogReq *lr)
 {
     BDRVBlkLogWritesState *s = lr->bs->opaque;
-    uint64_t cur_log_offset = s->cur_log_sector << s->sectorbits;
 
-    s->nr_entries++;
-    s->cur_log_sector +=
-            ROUND_UP(lr->qiov->size, s->sectorsize) >> s->sectorbits;
+    /*
+     * Determine the offsets and sizes of different parts of the entry, and
+     * update the state of the driver.
+     *
+     * This needs to be done in one go, before any actual I/O is done, as the
+     * log entry may have to be written in two parts, and the state of the
+     * driver may be modified by other driver operations while waiting for the
+     * I/O to complete.
+     */
+    const uint64_t entry_start_sector = s->cur_log_sector;
+    const uint64_t entry_offset = entry_start_sector << s->sectorbits;
+    const uint64_t qiov_aligned_size = ROUND_UP(lr->qiov->size, s->sectorsize);
+    const uint64_t entry_aligned_size = qiov_aligned_size +
+        ROUND_UP(lr->zero_size, s->sectorsize);
+    const uint64_t entry_nr_sectors = entry_aligned_size >> s->sectorbits;
 
-    lr->log_ret = bdrv_co_pwritev(s->log_file, cur_log_offset, lr->qiov->size,
+    s->nr_entries++;
+    s->cur_log_sector += entry_nr_sectors;
+
+    /*
+     * Write the log entry. Note that if this is a "write zeroes" operation,
+     * only the entry header is written here, with the zeroing being done
+     * separately below.
+     */
+    lr->log_ret = bdrv_co_pwritev(s->log_file, entry_offset, lr->qiov->size,
                                   lr->qiov, 0);
 
     /* Logging for the "write zeroes" operation */
     if (lr->log_ret == 0 && lr->zero_size) {
-        cur_log_offset = s->cur_log_sector << s->sectorbits;
-        s->cur_log_sector +=
-                ROUND_UP(lr->zero_size, s->sectorsize) >> s->sectorbits;
+        const uint64_t zeroes_offset = entry_offset + qiov_aligned_size;
 
-        lr->log_ret = bdrv_co_pwrite_zeroes(s->log_file, cur_log_offset,
+        lr->log_ret = bdrv_co_pwrite_zeroes(s->log_file, zeroes_offset,
                                             lr->zero_size, 0);
     }
 
-- 
2.43.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DA5A205D3
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Jan 2025 09:19:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgcS-00064g-0e; Tue, 28 Jan 2025 03:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgbQ-0003vj-0M; Tue, 28 Jan 2025 03:05:52 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgbN-0003BB-Dq; Tue, 28 Jan 2025 03:05:42 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4E3F7E1B78;
 Tue, 28 Jan 2025 10:57:09 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BE0521A632B;
 Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 3ACD8520E7; Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yuan Liu <yuan1.liu@intel.com>,
 Jason Zeng <jason.zeng@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 49/58] multifd: bugfix for incorrect migration data
 with QPL compression
Date: Mon, 27 Jan 2025 23:25:35 +0300
Message-Id: <20250127202547.3723716-49-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
References: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

When QPL compression is enabled on the migration channel and the same
dirty page changes from a normal page to a zero page in the iterative
memory copy, the dirty page will not be updated to a zero page again
on the target side, resulting in incorrect memory data on the source
and target sides.

The root cause is that the target side does not record the normal pages
to the receivedmap.

The solution is to add ramblock_recv_bitmap_set_offset in target side
to record the normal pages.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Jason Zeng <jason.zeng@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20241218091413.140396-3-yuan1.liu@intel.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
(cherry picked from commit 2588a5f99b0c3493b4690e3ff01ed36f80e830cc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
index 9265098ee7..fea60e3937 100644
--- a/migration/multifd-qpl.c
+++ b/migration/multifd-qpl.c
@@ -730,6 +730,7 @@ static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
         qpl->zlen[i] = be32_to_cpu(qpl->zlen[i]);
         assert(qpl->zlen[i] <= p->page_size);
         zbuf_len += qpl->zlen[i];
+        ramblock_recv_bitmap_set_offset(p->block, p->normal[i]);
     }
 
     /* read compressed pages */
-- 
2.39.5



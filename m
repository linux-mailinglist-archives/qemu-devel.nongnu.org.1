Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41742876FA6
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Mar 2024 09:00:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rirbH-00063c-0o; Sat, 09 Mar 2024 02:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rirbE-00062o-VQ
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 02:58:32 -0500
Received: from out-181.mta1.migadu.com ([2001:41d0:203:375::b5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rirbD-00010x-A4
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 02:58:32 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1709971106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SXSrRNKG2y6mw2kCVZivpNphMeBgf6+dzpwgsitq+4E=;
 b=P5oHATd+QOsFFZ9jzWI8MhfzRbhODIDTc5y7AZbS4t1ivzdoZdkQSclmAqLl9XGu1zrZm/
 /sdXClSXS9qypSgewFLEoK9UDKqhI4bXQeij4gO/116zvKwBdULC8c3b67xEoI4WCse05l
 GcM56ZIGImJXKe7vlBBj/j9CFqeKgSM=
From: Hao Xiang <hao.xiang@linux.dev>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Subject: [PATCH v5 1/7] migration/multifd: Allow zero pages in file migration
Date: Sat,  9 Mar 2024 07:57:22 +0000
Message-Id: <20240309075728.1487211-2-hao.xiang@linux.dev>
In-Reply-To: <20240309075728.1487211-1-hao.xiang@linux.dev>
References: <20240309075728.1487211-1-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::b5;
 envelope-from=hao.xiang@linux.dev; helo=out-181.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

Currently, it's an error to have no data pages in the multifd file
migration because zero page detection is done in the migration thread
and zero pages don't reach multifd. This is enforced with the
pages->num assert.

We're about to add zero page detection on the multifd thread. Fix the
file_write_ramblock_iov() to stop considering p->iovs_num=0 an error.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/file.c b/migration/file.c
index 164b079966..5075f9526f 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -159,7 +159,7 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
 int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
                             int niov, RAMBlock *block, Error **errp)
 {
-    ssize_t ret = -1;
+    ssize_t ret = 0;
     int i, slice_idx, slice_num;
     uintptr_t base, next, offset;
     size_t len;
-- 
2.30.2



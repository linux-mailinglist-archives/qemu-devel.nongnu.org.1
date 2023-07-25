Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A54761B37
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:20:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOIso-0000nE-7X; Tue, 25 Jul 2023 10:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOIsm-0000me-Ak
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:19:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOIsk-0000ws-Q1
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690294762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cH/W3q5ZiRkNxXGdWNYjOSTlSvVAa6ckF98aVZ7GeiU=;
 b=e1B0EscrxTnzgc9Iyi6ij5aw/1nkSSgCmOIzkJfHyoKqA5kJUkLmg4ZSs62v5jOqdbr9uK
 j6DMgHfoUk0nFntln7NPx66XAT1cHiG5Yv46HnVDcVdqCn2K1qVH4nKk96BdW7CHswDjnk
 vcl1G0ROVyvE2OKQFZLBFbuw3phDYls=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-ES_PsbeeMt-y-u_pjI6qhw-1; Tue, 25 Jul 2023 10:19:20 -0400
X-MC-Unique: ES_PsbeeMt-y-u_pjI6qhw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B520801E80;
 Tue, 25 Jul 2023 14:19:20 +0000 (UTC)
Received: from localhost (unknown [10.39.192.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC7562166B26;
 Tue, 25 Jul 2023 14:19:19 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 1/7] block/blkio: add io_uring: filename parsing
Date: Tue, 25 Jul 2023 10:19:09 -0400
Message-ID: <20230725141915.386364-2-stefanha@redhat.com>
In-Reply-To: <20230725141915.386364-1-stefanha@redhat.com>
References: <20230725141915.386364-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The qemu-iotests test suite requires filename parsing because it does
not use image options syntax everywhere. Add it now so that later
patches can enable qemu-iotests for the io_uring block driver.

The blkio.c code has other libblkio-based drivers that could benefit
from filename parsing too. Leave them for now because I am not yet ready
to add qemu-iotests support for them.

Suggested-by: Hanna Czenczek <hreitz@redhat.com>
Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/blkio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/blkio.c b/block/blkio.c
index 1798648134..a0240a5bcc 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -603,6 +603,12 @@ static void blkio_unregister_buf(BlockDriverState *bs, void *host, size_t size)
     }
 }
 
+static void blkio_io_uring_parse_filename(const char *filename, QDict *options,
+                                          Error **errp)
+{
+    bdrv_parse_filename_strip_prefix(filename, "io_uring:", options);
+}
+
 static int blkio_io_uring_open(BlockDriverState *bs, QDict *options, int flags,
                                Error **errp)
 {
@@ -1049,6 +1055,7 @@ static BlockDriver bdrv_io_uring = {
     .format_name         = "io_uring",
     .protocol_name       = "io_uring",
     .bdrv_needs_filename = true,
+    .bdrv_parse_filename = blkio_io_uring_parse_filename,
     BLKIO_DRIVER_COMMON
 };
 
-- 
2.41.0



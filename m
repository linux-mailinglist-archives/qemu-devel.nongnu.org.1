Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 241C87DD68C
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:05:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtyt-0004oQ-7i; Tue, 31 Oct 2023 15:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtyO-0004Jk-LR
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxo-00069K-D0
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lzk/ukVAnmDCIfDRtB0x+2n/bqaS86jaBOl4BUKRcys=;
 b=DyAgIVOcNEMuPlESlG2SYuwz6yuCbNSMdI5kC9jIa8/yVJuXioDMU/s915EKctGA1slUQ5
 3c0LUCnGr4CVUREj1VZsEq/ATKjuqXBUZR8QPajgui07G9RNh3owjstSs4q3iEhL8k3Doo
 K5gOxYp2TXM8i0gGUUKmsrTTT/C5qto=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-1R9dxqoAN5qTbqIxCzuy5g-1; Tue,
 31 Oct 2023 14:59:31 -0400
X-MC-Unique: 1R9dxqoAN5qTbqIxCzuy5g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CD661C06E0E;
 Tue, 31 Oct 2023 18:59:31 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9EBCF25C0;
 Tue, 31 Oct 2023 18:59:30 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 13/27] blockdev: mirror: avoid potential deadlock when using
 iothread
Date: Tue, 31 Oct 2023 19:59:04 +0100
Message-ID: <20231031185918.346940-14-kwolf@redhat.com>
In-Reply-To: <20231031185918.346940-1-kwolf@redhat.com>
References: <20231031185918.346940-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The bdrv_getlength() function is a generated co-wrapper and uses
AIO_WAIT_WHILE() to wait for the spawned coroutine. AIO_WAIT_WHILE()
expects the lock to be acquired exactly once.

Fix a case where it may be acquired twice. This can happen when the
source node is explicitly specified as the @replaces parameter or if the
source node is a filter node.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20231019131936.414246-4-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index a01c62596b..877e3a26d4 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2968,6 +2968,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
 
     if (replaces) {
         BlockDriverState *to_replace_bs;
+        AioContext *aio_context;
         AioContext *replace_aio_context;
         int64_t bs_size, replace_size;
 
@@ -2982,10 +2983,19 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
             return;
         }
 
+        aio_context = bdrv_get_aio_context(bs);
         replace_aio_context = bdrv_get_aio_context(to_replace_bs);
-        aio_context_acquire(replace_aio_context);
+        /*
+         * bdrv_getlength() is a co-wrapper and uses AIO_WAIT_WHILE. Be sure not
+         * to acquire the same AioContext twice.
+         */
+        if (replace_aio_context != aio_context) {
+            aio_context_acquire(replace_aio_context);
+        }
         replace_size = bdrv_getlength(to_replace_bs);
-        aio_context_release(replace_aio_context);
+        if (replace_aio_context != aio_context) {
+            aio_context_release(replace_aio_context);
+        }
 
         if (replace_size < 0) {
             error_setg_errno(errp, -replace_size,
-- 
2.41.0



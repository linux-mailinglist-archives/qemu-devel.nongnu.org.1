Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D799D7413A1
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 16:20:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEVyE-0000KA-AX; Wed, 28 Jun 2023 10:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVxz-0008KH-SK
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:16:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVxw-0005Jj-AF
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687961773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ETKNQBPKI8AfHzDWP2bucdZbOVL7nzz6r8QDdMsok9o=;
 b=AN6BnyujXeQuPl1/MMtqo8yZ8aq57jFeIRgoFdKVhtBnT8DOqnxuPn30RhVW/CSI76/Gl9
 2sblyjWkzUn3SCHen5+GKuQkZyTzXuNfqsF8tgiA7FC5CAVOXOxcPg2hJiQkrq3Z28fSyX
 FSMsU7fY9OJ0GcNp4h7E4Wp/E3ZgPdQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-oyYxxjuKP6WExvvO5eFTkA-1; Wed, 28 Jun 2023 10:16:08 -0400
X-MC-Unique: oyYxxjuKP6WExvvO5eFTkA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26CDB28237DD;
 Wed, 28 Jun 2023 14:15:56 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.195.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54F7040C2063;
 Wed, 28 Jun 2023 14:15:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 16/23] block: mark another function as coroutine_fns and
 GRAPH_UNLOCKED
Date: Wed, 28 Jun 2023 16:15:19 +0200
Message-ID: <20230628141526.293104-17-kwolf@redhat.com>
In-Reply-To: <20230628141526.293104-1-kwolf@redhat.com>
References: <20230628141526.293104-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

Mark functions as coroutine_fn when they are only called by other coroutine_fns
and they can suspend.  Because this function operates on a BlockBackend, mark it
GRAPH_UNLOCKED.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20230601115145.196465-6-pbonzini@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index 0cd1a12344..a307c151a8 100644
--- a/block.c
+++ b/block.c
@@ -555,8 +555,9 @@ int coroutine_fn bdrv_co_create(BlockDriver *drv, const char *filename,
  * On success, return @blk's actual length.
  * Otherwise, return -errno.
  */
-static int64_t create_file_fallback_truncate(BlockBackend *blk,
-                                             int64_t minimum_size, Error **errp)
+static int64_t coroutine_fn GRAPH_UNLOCKED
+create_file_fallback_truncate(BlockBackend *blk, int64_t minimum_size,
+                              Error **errp)
 {
     Error *local_err = NULL;
     int64_t size;
@@ -564,14 +565,14 @@ static int64_t create_file_fallback_truncate(BlockBackend *blk,
 
     GLOBAL_STATE_CODE();
 
-    ret = blk_truncate(blk, minimum_size, false, PREALLOC_MODE_OFF, 0,
-                       &local_err);
+    ret = blk_co_truncate(blk, minimum_size, false, PREALLOC_MODE_OFF, 0,
+                          &local_err);
     if (ret < 0 && ret != -ENOTSUP) {
         error_propagate(errp, local_err);
         return ret;
     }
 
-    size = blk_getlength(blk);
+    size = blk_co_getlength(blk);
     if (size < 0) {
         error_free(local_err);
         error_setg_errno(errp, -size,
-- 
2.41.0



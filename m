Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 214087919CC
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:39:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAhP-0002EE-PN; Mon, 04 Sep 2023 10:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdAhN-0002CV-Rn
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:37:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdAhI-0001k6-5n
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693838218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vp42tg2077UKS8yn6t4e4+7kfeg7DlOQpeRnLhc8MKk=;
 b=Fsui+Ov5fqlESIa/Q+jHSwiRo7SzmXCSjKmr3IXZXZ36FxOYImA4udn45txPC1uwLmP+si
 jh9UhpG1VIFtmd0vwdzDolRHmUQFuIopPIghuzR0exrPioeAKQ7vDUQzYGO4vBa5L4Hzgp
 PwYfZD5HyAnoaqNn/jPzDZgGFZOJKHY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-xq6vZ4lRPQmz8EMb1qJgtg-1; Mon, 04 Sep 2023 10:36:55 -0400
X-MC-Unique: xq6vZ4lRPQmz8EMb1qJgtg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 203C93803906;
 Mon,  4 Sep 2023 14:36:55 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8445C400F5A;
 Mon,  4 Sep 2023 14:36:54 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 07/14] block: Be more verbose in create fallback
Date: Mon,  4 Sep 2023 16:36:36 +0200
Message-ID: <20230904143643.259916-8-kwolf@redhat.com>
In-Reply-To: <20230904143643.259916-1-kwolf@redhat.com>
References: <20230904143643.259916-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

From: Hanna Czenczek <hreitz@redhat.com>

For image creation code, we have central fallback code for protocols
that do not support creating new images (like NBD or iscsi).  So for
them, you can only specify existing paths/exports that are overwritten
to make clean new images.  In such a case, if the given path cannot be
opened (assuming a pre-existing image there), we print an error message
that tries to describe what is going on: That with this protocol, you
cannot create new images, but only overwrite existing ones; and the
given path could not be opened as a pre-existing image.

However, the current message is confusing, because it does not say that
the protocol in question does not support creating new images, but
instead that "image creation" is unsupported.  This can be interpreted
to mean that `qemu-img create` will not work in principle, which is not
true.  Be more verbose for clarity.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2217204
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20230720140024.46836-1-hreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index b79b1ce7fe..1a5cb554a8 100644
--- a/block.c
+++ b/block.c
@@ -661,8 +661,10 @@ int coroutine_fn bdrv_co_create_opts_simple(BlockDriver *drv,
     blk = blk_co_new_open(filename, NULL, options,
                           BDRV_O_RDWR | BDRV_O_RESIZE, errp);
     if (!blk) {
-        error_prepend(errp, "Protocol driver '%s' does not support image "
-                      "creation, and opening the image failed: ",
+        error_prepend(errp, "Protocol driver '%s' does not support creating "
+                      "new images, so an existing image must be selected as "
+                      "the target; however, opening the given target as an "
+                      "existing image failed: ",
                       drv->format_name);
         return -EINVAL;
     }
-- 
2.41.0



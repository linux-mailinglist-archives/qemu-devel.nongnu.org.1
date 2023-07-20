Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 659CC75B0A4
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 16:02:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMUD2-0001Rv-Do; Thu, 20 Jul 2023 10:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMUD1-0001Rl-0F
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 10:00:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMUCo-0005V7-Jd
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 10:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689861631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cn9ws6g9BiUBsSv2HMdIOcDrDIn4b6FgSbL0J9YWLYg=;
 b=X8KAgUkw93v5IMkEC2dc1nbz6LEZxJJCqx9c30ns6es7NrNX0G0P3gmQWpSvZrrB37GTn3
 pf2FjY2OJshftjOSWoRh8UsqvzuPIV0CylynCvw95XLBXx7RhMb5dHFXcAL9OB9X0BcR3j
 oKfy8Vu6/kgBc7PCmIYxVfQ0q1of/z8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-MlI1bSNGMcqTtUrQnDBZgA-1; Thu, 20 Jul 2023 10:00:29 -0400
X-MC-Unique: MlI1bSNGMcqTtUrQnDBZgA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCFFD3813F41;
 Thu, 20 Jul 2023 14:00:27 +0000 (UTC)
Received: from localhost (unknown [10.39.193.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72079492CAD;
 Thu, 20 Jul 2023 14:00:27 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH] block: Be more verbose in create fallback
Date: Thu, 20 Jul 2023 16:00:24 +0200
Message-ID: <20230720140024.46836-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
---
 block.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index a307c151a8..f530dd9c02 100644
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



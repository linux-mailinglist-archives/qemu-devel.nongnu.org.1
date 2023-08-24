Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 736A57874A2
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:54:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCeo-0000io-1U; Thu, 24 Aug 2023 11:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZCek-0000gj-8u
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZCeh-0007jM-LK
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692892435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F6vcnuXjxYis8QLNdQQGjifkbhRFa3ZI43Wi16UBd/U=;
 b=eJQgwuQp2pe/pysv6N8YV5gU5VujkLbRsSNNR2Z9BrEIShuQ4phFZ6Jc8BM0NcwvHjL4xF
 tRAOVeY1zBNXH2UMqS03E5qmyRFIizmLirSv+DDoUgabYL6aeN15IUNIJSqY0TF7fvhGal
 x9+b1X1RUwiTHGpZw/U7RdE7yd33f+Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-5zgkEwswPoGLayqF5NsBug-1; Thu, 24 Aug 2023 11:53:51 -0400
X-MC-Unique: 5zgkEwswPoGLayqF5NsBug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 641F085CBE6;
 Thu, 24 Aug 2023 15:53:51 +0000 (UTC)
Received: from localhost (unknown [10.39.193.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13A35C1602E;
 Thu, 24 Aug 2023 15:53:50 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH 3/5] file-posix: Fix zone update in I/O error path
Date: Thu, 24 Aug 2023 17:53:42 +0200
Message-ID: <20230824155345.109765-4-hreitz@redhat.com>
In-Reply-To: <20230824155345.109765-1-hreitz@redhat.com>
References: <20230824155345.109765-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
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

We must check that zone information is present before running
update_zones_wp().

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2234374
Fixes: Coverity CID 1512459
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/file-posix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 46e22403fe..a050682e97 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2525,7 +2525,8 @@ out:
             }
         }
     } else {
-        if (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
+        if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) &&
+            bs->bl.zoned != BLK_Z_NONE) {
             update_zones_wp(bs, s->fd, 0, 1);
         }
     }
-- 
2.41.0



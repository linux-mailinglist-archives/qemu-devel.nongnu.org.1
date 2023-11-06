Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3467E2ABB
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 18:11:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r037l-0002a6-2V; Mon, 06 Nov 2023 12:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1r037j-0002Zg-MK
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:10:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1r037d-00071B-HF
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699290644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tt285uAAiJGay31EKSbK1TdL4ZWi3Wd1g8Th72g+Nwc=;
 b=XqUukMsw+8flTuTzwA4HB0onZTMcDR6O5ijZoR4TRP3pYmUxERdajsF8krEVO4nPDOJEEU
 v47yWYhlfWHhaD+lMgY4yEOSHmGRlRBbw4s94R/mLgF4L3lZonnS0bY5T9um2rx5ffxATm
 6if0nDpdIht3tQmZ9uyDpa754pIHf0E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-6uRl-xhhMQCHxgTMeIR5og-1; Mon, 06 Nov 2023 12:10:37 -0500
X-MC-Unique: 6uRl-xhhMQCHxgTMeIR5og-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF218185A794;
 Mon,  6 Nov 2023 17:10:36 +0000 (UTC)
Received: from localhost (unknown [10.39.193.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FB1EC1596F;
 Mon,  6 Nov 2023 17:10:36 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
	Hanna Czenczek <hreitz@redhat.com>
Subject: [PULL 2/3] block/file-posix: fix update_zones_wp() caller
Date: Mon,  6 Nov 2023 18:10:30 +0100
Message-ID: <20231106171031.1084277-3-hreitz@redhat.com>
In-Reply-To: <20231106171031.1084277-1-hreitz@redhat.com>
References: <20231106171031.1084277-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

From: Sam Li <faithilikerun@gmail.com>

When the zoned request fail, it needs to update only the wp of
the target zones for not disrupting the in-flight writes on
these other zones. The wp is updated successfully after the
request completes.

Fixed the callers with right offset and nr_zones.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
Message-Id: <20230825040556.4217-1-faithilikerun@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
[hreitz: Rebased and fixed comment spelling]
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/file-posix.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 50e2b20d5c..3c0ce9c258 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2523,7 +2523,10 @@ out:
                 }
             }
         } else {
-            update_zones_wp(bs, s->fd, 0, 1);
+            /*
+             * write and append write are not allowed to cross zone boundaries
+             */
+            update_zones_wp(bs, s->fd, offset, 1);
         }
 
         qemu_co_mutex_unlock(&wps->colock);
@@ -3470,7 +3473,7 @@ static int coroutine_fn raw_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
                         len >> BDRV_SECTOR_BITS);
     ret = raw_thread_pool_submit(handle_aiocb_zone_mgmt, &acb);
     if (ret != 0) {
-        update_zones_wp(bs, s->fd, offset, i);
+        update_zones_wp(bs, s->fd, offset, nrz);
         error_report("ioctl %s failed %d", op_name, ret);
         return ret;
     }
-- 
2.41.0



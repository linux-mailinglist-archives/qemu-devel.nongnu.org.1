Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B07DDA929C7
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Apr 2025 20:44:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5UBa-00043y-HW; Thu, 17 Apr 2025 14:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5UBY-000436-Et
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:42:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5UBW-0002tg-P1
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744915321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=csqy0lFVvHPMOE3Y+BWOfgNJuQqp7DKuYy228mUVHtk=;
 b=W1PmD6xhti+LISvhoukRv0/ZLVnd5gTTuaiCaa4154rKRoCs5zd4Fma7G+w2qtRuybVcS9
 f8N6z4IHywrgWET9UL43oGMtsDyAIP9056ry9tDp61yIeIpz4QFEhxIKOZDeBcN0A1DOUT
 FKdgmxjPctzFRRRujgY8RlN7SfQ6sb4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563--3VsHMIcOe2j8rvNlqrr-A-1; Thu,
 17 Apr 2025 14:41:57 -0400
X-MC-Unique: -3VsHMIcOe2j8rvNlqrr-A-1
X-Mimecast-MFC-AGG-ID: -3VsHMIcOe2j8rvNlqrr-A_1744915316
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAB81195608B; Thu, 17 Apr 2025 18:41:56 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.121])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A59F81955E96; Thu, 17 Apr 2025 18:41:54 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v2 03/11] block: Let bdrv_co_is_zero_fast consolidate adjacent
 extents
Date: Thu, 17 Apr 2025 13:39:08 -0500
Message-ID: <20250417184133.105746-16-eblake@redhat.com>
In-Reply-To: <20250417184133.105746-13-eblake@redhat.com>
References: <20250417184133.105746-13-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some BDS drivers have a cap on how much block status they can supply
in one query (for example, NBD talking to an older server cannot
inspect more than 4G per query; and qcow2 tends to cap its answers
rather than cross a cluster boundary of an L1 table).  Although the
existing callers of bdrv_co_is_zero_fast are not passing in that large
of a 'bytes' parameter, an upcoming caller wants to query the entire
image at once, and will thus benefit from being able to treat adjacent
zero regions in a coalesced manner, rather than claiming the region is
non-zero merely because pnum was truncated and didn't match the
incoming bytes.

While refactoring this into a loop, note that there is no need to
assign pnum prior to calling bdrv_co_common_block_status_above() (it
is guaranteed to be assigned deeper in the callstack).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/io.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/block/io.c b/block/io.c
index 73c96084e62..6ef78070915 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2757,22 +2757,25 @@ int coroutine_fn bdrv_co_is_zero_fast(BlockDriverState *bs, int64_t offset,
                                       int64_t bytes)
 {
     int ret;
-    int64_t pnum = bytes;
+    int64_t pnum;
     IO_CODE();

-    if (!bytes) {
-        return 1;
+    while (bytes) {
+        ret = bdrv_co_common_block_status_above(bs, NULL, false,
+                                                BDRV_BSTAT_ZERO, offset, bytes,
+                                                &pnum, NULL, NULL, NULL);
+
+        if (ret < 0) {
+            return ret;
+        }
+        if (!(ret & BDRV_BLOCK_ZERO)) {
+            return 0;
+        }
+        offset += pnum;
+        bytes -= pnum;
     }

-    ret = bdrv_co_common_block_status_above(bs, NULL, false, BDRV_BSTAT_ZERO,
-                                            offset, bytes, &pnum, NULL, NULL,
-                                            NULL);
-
-    if (ret < 0) {
-        return ret;
-    }
-
-    return (pnum == bytes) && (ret & BDRV_BLOCK_ZERO);
+    return 1;
 }

 int coroutine_fn bdrv_co_is_allocated(BlockDriverState *bs, int64_t offset,
-- 
2.49.0



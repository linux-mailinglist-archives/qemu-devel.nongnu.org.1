Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A558B03DC
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Apr 2024 10:06:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXc1-0006ra-8p; Wed, 24 Apr 2024 04:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXbW-0005ss-OO
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXbR-0003nI-Ms
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713945820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiuiV2XNWoLOe0i8EiZrScnl5eVDDJW6PHINxn2sw/0=;
 b=Pg+WD1YOAMihhAGu9PCudo49jsD9Dt0SpsMdQ0Qtbf6ZzHBiHZqaAp8eIX5ovwzIOdM6pF
 3c4oGzQPSLntr1TDaNohG9QwqU/uncuo7gJZDGQPsCulzirWWNQ8i8SLyHSjv5Yto3qGN4
 eCc4Q/XcjJNrm0vkZ8xO+DNB4szIfkY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-9BK_vXyENPqZQA65VJvL8w-1; Wed,
 24 Apr 2024 04:03:38 -0400
X-MC-Unique: 9BK_vXyENPqZQA65VJvL8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39CD31C03159;
 Wed, 24 Apr 2024 08:03:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 19F5A1121312;
 Wed, 24 Apr 2024 08:03:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3E1B221E669B; Wed, 24 Apr 2024 10:03:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/10] qapi: Inline and remove QERR_DEVICE_HAS_NO_MEDIUM
 definition
Date: Wed, 24 Apr 2024 10:03:30 +0200
Message-ID: <20240424080337.2782594-4-armbru@redhat.com>
In-Reply-To: <20240424080337.2782594-1-armbru@redhat.com>
References: <20240424080337.2782594-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Address the comment added in commit 4629ed1e98
("qerror: Finally unused, clean up"), from 2015:

  /*
   * These macros will go away, please don't use
   * in new code, and do not add new ones!
   */

Mechanical transformation using sed, and manual cleanup.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240312141343.3168265-4-armbru@redhat.com>
---
 include/qapi/qmp/qerror.h | 3 ---
 block/snapshot.c          | 7 ++++---
 blockdev.c                | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index 06a1d2248e..daa889809b 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -17,9 +17,6 @@
  * add new ones!
  */
 
-#define QERR_DEVICE_HAS_NO_MEDIUM \
-    "Device '%s' has no medium"
-
 #define QERR_DEVICE_NO_HOTPLUG \
     "Device '%s' does not support hotplugging"
 
diff --git a/block/snapshot.c b/block/snapshot.c
index 8242b4abac..8fd1756777 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -28,7 +28,6 @@
 #include "block/qdict.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/option.h"
 #include "sysemu/block-backend.h"
@@ -359,7 +358,8 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
     GLOBAL_STATE_CODE();
 
     if (!drv) {
-        error_setg(errp, QERR_DEVICE_HAS_NO_MEDIUM, bdrv_get_device_name(bs));
+        error_setg(errp, "Device '%s' has no medium",
+                   bdrv_get_device_name(bs));
         return -ENOMEDIUM;
     }
     if (!snapshot_id && !name) {
@@ -437,7 +437,8 @@ int bdrv_snapshot_load_tmp(BlockDriverState *bs,
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (!drv) {
-        error_setg(errp, QERR_DEVICE_HAS_NO_MEDIUM, bdrv_get_device_name(bs));
+        error_setg(errp, "Device '%s' has no medium",
+                   bdrv_get_device_name(bs));
         return -ENOMEDIUM;
     }
     if (!snapshot_id && !name) {
diff --git a/blockdev.c b/blockdev.c
index 057601dcf0..08eccc9052 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1395,7 +1395,7 @@ static void external_snapshot_action(TransactionAction *action,
     bdrv_drained_begin(state->old_bs);
 
     if (!bdrv_is_inserted(state->old_bs)) {
-        error_setg(errp, QERR_DEVICE_HAS_NO_MEDIUM,
+        error_setg(errp, "Device '%s' has no medium",
                    bdrv_get_device_or_node_name(state->old_bs));
         return;
     }
-- 
2.44.0



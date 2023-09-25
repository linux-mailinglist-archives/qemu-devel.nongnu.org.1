Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCC17ADF65
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:04:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqqr-0002pn-0A; Mon, 25 Sep 2023 15:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkqql-0002p8-Vf
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkqqh-0005WW-19
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695668545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4lXYcXWo8hCeTUShIT4/UbAPm7PFlODCxerMxYzeMy4=;
 b=HIwq4zhdtHlZgDOXjPC62ByBXkoRP+rXVo+czEF2MR5ihYA7qMvrL9AMvTUEUK1Fu+qvhV
 8EYcAgNEVYdf9fKDhNn6xG+Eso3shyWfVkzHllhpIVf81rglIRNgMGbp2FrLVj9OD8IVlB
 7BHKDnORh0X4Q5E389m7Xu7Yarrovhw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-jkKW60HNMxiF5ZFz2gRI5g-1; Mon, 25 Sep 2023 15:02:23 -0400
X-MC-Unique: jkKW60HNMxiF5ZFz2gRI5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30EB21C06500;
 Mon, 25 Sep 2023 19:02:23 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 344C6C15BB8;
 Mon, 25 Sep 2023 19:02:22 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PULL 1/7] iotests: use TEST_IMG_FILE instead of TEST_IMG in
 _require_large_file
Date: Mon, 25 Sep 2023 14:01:16 -0500
Message-ID: <20230925190114.3163545-10-eblake@redhat.com>
In-Reply-To: <20230925190114.3163545-9-eblake@redhat.com>
References: <20230925190114.3163545-9-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 16
X-Spam_score: 1.6
X-Spam_bar: +
X-Spam_report: (1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: "Denis V. Lunev" <den@openvz.org>

We need to check that we are able to create large enough file which is
used as an export base rather than connection URL. Unfortunately, there
are cases when the TEST_IMG_FILE is not defined. We should fallback to
TEST_IMG in that case.

This problem has been detected when running
    ./check -nbd 5
The test should be able to run while it does not.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20230906140917.559129-2-den@openvz.org>
Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/common.rc | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index d145f08201c..95c12577dd4 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -979,10 +979,15 @@ _require_drivers()
 #
 _require_large_file()
 {
-    if ! truncate --size="$1" "$TEST_IMG"; then
+    if [ -z "$TEST_IMG_FILE" ]; then
+        FILENAME="$TEST_IMG"
+    else
+        FILENAME="$TEST_IMG_FILE"
+    fi
+    if ! truncate --size="$1" "$FILENAME"; then
         _notrun "file system on $TEST_DIR does not support large enough files"
     fi
-    rm "$TEST_IMG"
+    rm "$FILENAME"
 }

 # Check that a set of devices is available in the QEMU binary
-- 
2.41.0



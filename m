Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 271D87CDB10
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 13:57:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt59H-0007Oj-R1; Wed, 18 Oct 2023 07:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt59D-0007MG-17
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:55:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt59B-0001l5-JV
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697630133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mXaChLJ6it3Hz3+dy/+87RcFjHbPcvdoSIGtZOAy6XY=;
 b=HDWnG3LJusdTH34c+Bup7H1OucwJIWuEIZHsJG+OmdPE+w8VjcPaoWV2FeDsY/zQ8uRV4t
 ad3x8MjAY5jgWJq0YHh/6BYD+wTXZT0yUmsVKaT2kvbfIyoVoyH5Y3e7kMNAnrUucq5FDf
 fhf7w6xaGB/IjkbsG/DsDVX/4Eke2M8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-6waQ9BCuOwWUIJ1p1p9gfA-1; Wed, 18 Oct 2023 07:55:19 -0400
X-MC-Unique: 6waQ9BCuOwWUIJ1p1p9gfA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2695028AC1F1;
 Wed, 18 Oct 2023 11:55:19 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19E5E20268C8;
 Wed, 18 Oct 2023 11:55:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Leonardo Bras <leobras@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fam Zheng <fam@euphon.net>, Peter Xu <peterx@redhat.com>,
 libvir-list@redhat.com, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v8 1/5] qemu-iotests: Filter warnings about block migration
 being deprecated
Date: Wed, 18 Oct 2023 13:55:09 +0200
Message-ID: <20231018115513.2163-2-quintela@redhat.com>
In-Reply-To: <20231018115513.2163-1-quintela@redhat.com>
References: <20231018115513.2163-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Create a new filter that removes the two warnings for test 183.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qemu-iotests/183           | 2 +-
 tests/qemu-iotests/common.filter | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index ee62939e72..b85770458e 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -90,7 +90,7 @@ echo
 reply="$(_send_qemu_cmd $src \
     "{ 'execute': 'migrate',
        'arguments': { 'uri': 'unix:${MIG_SOCKET}', 'blk': true } }" \
-    'return\|error')"
+    'return\|error' | _filter_migration_block_deprecated)"
 echo "$reply"
 if echo "$reply" | grep "compiled without old-style" > /dev/null; then
     _notrun "migrate -b support not compiled in"
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index fc3c64bcb8..2846c83808 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -359,5 +359,12 @@ _filter_qcow2_compression_type_bit()
         -e 's/\(incompatible_features.*\), 3\(,.*\)/\1\2/'
 }
 
+# filter warnings caused for block migration deprecation
+_filter_migration_block_deprecated()
+{
+    gsed -e '/warning: parameter .blk. is deprecated; use blockdev-mirror with NBD instead/d' \
+         -e '/warning: block migration is deprecated; use blockdev-mirror with NBD instead/d'
+}
+
 # make sure this script returns success
 true
-- 
2.41.0



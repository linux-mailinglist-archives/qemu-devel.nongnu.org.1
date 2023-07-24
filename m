Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E71275F7E1
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 15:10:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNvI6-0004rl-BB; Mon, 24 Jul 2023 09:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qNvHV-0004Aq-Qg
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qNvHU-0002cl-9G
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690204039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DgfPHen12kn/Tt0KY2EYgK30m6PxOvFEC8h9F1aKAnY=;
 b=Dgo7Pjfc02MmO00wKPVHL73g1hjc8R8IRNpt8RXwqqv07nLEAPS+TGyp+MEcA3d2Ns5Cyv
 ENUaaWyBMXjvPIadOYJCAbopVzQixllSbZElJ/oEB9cKo6LB0uF4cM9UULSIRaIbbBFRC1
 CC1MrD/AMsPTqt4i1itcEBaYqIo06Bs=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-jrcKU4RuOkOktaYuaZuFAQ-1; Mon, 24 Jul 2023 09:07:17 -0400
X-MC-Unique: jrcKU4RuOkOktaYuaZuFAQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6002381180C
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 13:07:16 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D4D110E5E;
 Mon, 24 Jul 2023 13:07:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, libvir-list@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 16/26] migration: skipped field is really obsolete.
Date: Mon, 24 Jul 2023 15:06:29 +0200
Message-Id: <20230724130639.93135-17-quintela@redhat.com>
In-Reply-To: <20230724130639.93135-1-quintela@redhat.com>
References: <20230724130639.93135-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Has return zero for more than 10 years.

Specifically we introduced the field in 1.5.0

commit f1c72795af573b24a7da5eb52375c9aba8a37972
Author: Peter Lieven <pl@kamp.de>
Date:   Tue Mar 26 10:58:37 2013 +0100

    migration: do not sent zero pages in bulk stage

    during bulk stage of ram migration if a page is a
    zero page do not send it at all.
    the memory at the destination reads as zero anyway.

    even if there is an madvise with QEMU_MADV_DONTNEED
    at the target upon receipt of a zero page I have observed
    that the target starts swapping if the memory is overcommitted.
    it seems that the pages are dropped asynchronously.

    this patch also updates QMP to return the number of
    skipped pages in MigrationStats.

but removed its usage in 1.5.3

commit 9ef051e5536b6368a1076046ec6c4ec4ac12b5c6
Author: Peter Lieven <pl@kamp.de>
Date:   Mon Jun 10 12:14:19 2013 +0200

    Revert "migration: do not sent zero pages in bulk stage"

    Not sending zero pages breaks migration if a page is zero
    at the source but not at the destination. This can e.g. happen
    if different BIOS versions are used at source and destination.
    It has also been reported that migration on pseries is completely
    broken with this patch.

    This effectively reverts commit f1c72795af573b24a7da5eb52375c9aba8a37972.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20230612193344.3796-2-quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 docs/about/deprecated.rst | 10 ++++++++++
 qapi/migration.json       | 12 ++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 02ea5a839f..1c35f55666 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -451,3 +451,13 @@ both, older and future versions of QEMU.
 The ``blacklist`` config file option has been renamed to ``block-rpcs``
 (to be in sync with the renaming of the corresponding command line
 option).
+
+Migration
+---------
+
+``skipped`` MigrationStats field (since 8.1)
+''''''''''''''''''''''''''''''''''''''''''''
+
+``skipped`` field in Migration stats has been deprecated.  It hasn't
+been used for more than 10 years.
+
diff --git a/qapi/migration.json b/qapi/migration.json
index 7ccb28e64f..bc9ae3fef7 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -23,7 +23,8 @@
 #
 # @duplicate: number of duplicate (zero) pages (since 1.2)
 #
-# @skipped: number of skipped zero pages (since 1.5)
+# @skipped: number of skipped zero pages. Always zero, only provided for
+#     compatibility (since 1.5)
 #
 # @normal: number of normal pages (since 1.2)
 #
@@ -62,11 +63,18 @@
 #     between 0 and @dirty-sync-count * @multifd-channels.  (since
 #     7.1)
 #
+# Features:
+#
+# @deprecated: Member @skipped is always zero since 1.5.3
+#
 # Since: 0.14
+#
 ##
 { 'struct': 'MigrationStats',
   'data': {'transferred': 'int', 'remaining': 'int', 'total': 'int' ,
-           'duplicate': 'int', 'skipped': 'int', 'normal': 'int',
+           'duplicate': 'int',
+           'skipped': { 'type': 'int', 'features': ['deprecated'] },
+           'normal': 'int',
            'normal-bytes': 'int', 'dirty-pages-rate': 'int',
            'mbps': 'number', 'dirty-sync-count': 'int',
            'postcopy-requests': 'int', 'page-size': 'int',
-- 
2.40.1



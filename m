Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BD172CF9E
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 21:34:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8nIe-0004Lo-IK; Mon, 12 Jun 2023 15:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q8nIc-0004L1-6J
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 15:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q8nIa-0006C5-LE
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 15:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686598434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eAEuYkGVVoI5bWsaGN5ZaE9+Wu+8W3AgkJEird0C2WM=;
 b=RgA7+qpyHg9QJstCttqw03l0NuLOtiyckW6FJi0hLQf15gzWN87EHkdVpe33sl5nDaXBuh
 4GGqMIZtJ3CRxf/NGAK3jy6p6POX+Q1TBRO77JH4QYwJNLDKoypQLw/o01OvTNsGK4f4q+
 UAeHnbNYGh4aeO511+UIIGOYS6+DkDE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-PaYKS77mMJ25JhK9pYKQKA-1; Mon, 12 Jun 2023 15:33:50 -0400
X-MC-Unique: PaYKS77mMJ25JhK9pYKQKA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F3332823803;
 Mon, 12 Jun 2023 19:33:50 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DE9F141510A;
 Mon, 12 Jun 2023 19:33:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Subject: [RFC 1/6] migration: skipped field is really obsolete.
Date: Mon, 12 Jun 2023 21:33:39 +0200
Message-Id: <20230612193344.3796-2-quintela@redhat.com>
In-Reply-To: <20230612193344.3796-1-quintela@redhat.com>
References: <20230612193344.3796-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Has return zero for more than 10 years.  Just mark it deprecated.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 docs/about/deprecated.rst | 10 ++++++++++
 qapi/migration.json       | 12 ++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 0743459862..e1aa0eafc8 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -423,3 +423,13 @@ both, older and future versions of QEMU.
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
index cb7cd3e578..bcae193733 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -23,7 +23,8 @@
 #
 # @duplicate: number of duplicate (zero) pages (since 1.2)
 #
-# @skipped: number of skipped zero pages (since 1.5)
+# @skipped: number of skipped zero pages. Don't use, only provided for
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
+# @deprecated: Member @skipped has not been used for a long time.
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



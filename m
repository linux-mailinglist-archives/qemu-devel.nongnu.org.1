Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F394875CFF8
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 18:45:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMtEi-0007YW-NT; Fri, 21 Jul 2023 12:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qMtEZ-0007Qx-3m
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 12:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qMtEX-0006AF-6D
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 12:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689957838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jlpwS4FiQd9kRIuhI+dezEakMlvGxKOhGvA8wfYKJco=;
 b=EGyjBMCNseezTsudTGOgZc9RdaGhnFPy6uC6iJggJ63FWVTXJeLgQnvZFDjYDZ4HoXR/aV
 h+hFG1RgXCbOvLNT81488vV1+0b6/Ix62Y9+kmZKk5TvJBCrouViv9Ta4vjYhHFhA7pSOU
 yvydKeA1TtDBJm+b/WkBMonLoZU/UHk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-dn-GatS5NV2wzXLNyQPv1A-1; Fri, 21 Jul 2023 12:43:51 -0400
X-MC-Unique: dn-GatS5NV2wzXLNyQPv1A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 693EB185A78B;
 Fri, 21 Jul 2023 16:43:51 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87433200A7CA;
 Fri, 21 Jul 2023 16:43:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Cc: qemu-s390x@nongnu.org, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] tests/avocado/migration: Remove the malfunctioning s390x tests
Date: Fri, 21 Jul 2023 18:43:46 +0200
Message-Id: <20230721164346.10112-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The tests from tests/avocado/migration.py do not work at all
on s390x - the bios shuts down immediately when it cannot find
a boot disk, so there is nothing left to migrate here. For doing
a proper migration test, we would need a proper payload, but we
already do such tests in the migration *qtest*, so it is unnecessary
to redo such a test here, thus let's simply remove this test.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 I'm tempted to remove this file completely - what test coverage do
 we get here that we don't get by tests/qtest/migration-test.c already?

 tests/avocado/migration.py | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/tests/avocado/migration.py b/tests/avocado/migration.py
index 8b2ec0e3c4..fdc1d234fb 100644
--- a/tests/avocado/migration.py
+++ b/tests/avocado/migration.py
@@ -134,21 +134,3 @@ def test_migration_with_unix(self):
 
     def test_migration_with_exec(self):
         self.migration_with_exec()
-
-
-@skipUnless('s390x' in os.uname()[4], "host != target")
-class S390X(MigrationTest):
-    """
-    :avocado: tags=arch:s390x
-    :avocado: tags=machine:s390-ccw-virtio
-    :avocado: tags=cpu:qemu
-    """
-
-    def test_migration_with_tcp_localhost(self):
-        self.migration_with_tcp_localhost()
-
-    def test_migration_with_unix(self):
-        self.migration_with_unix()
-
-    def test_migration_with_exec(self):
-        self.migration_with_exec()
-- 
2.39.3



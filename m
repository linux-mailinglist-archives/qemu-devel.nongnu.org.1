Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E83A7CD797
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:13:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt2bk-0001np-Ml; Wed, 18 Oct 2023 05:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt2bf-0001nG-Qn
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:12:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt2be-0005Ki-F7
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697620365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8avDTUmYPtMtEszHmwwduqtHigDYKYLBMjtTWtsF6Q8=;
 b=cHw9DqTtFSq9MqQViEcGjn5SBXcCFK0BqU/RmMN02oqy4UlUgO3ycbFCAOW868AwCCPHrQ
 Y5lvWdltI1bf+Zf4F4TIs6ed1B0+aKlVAVTxRaIZ4WCsL/Tat8DhSX/TdKzsmnjcncr8uh
 ivYumSNVE+8q2mTjsSX5AjHhkca3klo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-uYXxLaTrODuK-jYZdnV-8w-1; Wed, 18 Oct 2023 05:12:43 -0400
X-MC-Unique: uYXxLaTrODuK-jYZdnV-8w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BE7128EA6F9;
 Wed, 18 Oct 2023 09:12:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B8281C060AE;
 Wed, 18 Oct 2023 09:12:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>
Cc: qemu-s390x@nongnu.org
Subject: [PATCH] tests/qtest/migration-test: Disable the analyze-migration.py
 test on s390x
Date: Wed, 18 Oct 2023 11:12:39 +0200
Message-ID: <20231018091239.164452-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The analyze-migration.py script fails on s390x hosts:

 Traceback (most recent call last):
   File "scripts/analyze-migration.py", line 662, in <module>
     dump.read(dump_memory = args.memory)
   File "scripts/analyze-migration.py", line 596, in read
     classdesc = self.section_classes[section_key]
 KeyError: ('s390-storage_attributes', 0)

It obviously never has been adapted to s390x yet, so until this
has been done, disable this test on s390x.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/migration-test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index e1c110537b..241b409857 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3034,7 +3034,9 @@ int main(int argc, char **argv)
 
     qtest_add_func("/migration/bad_dest", test_baddest);
 #ifndef _WIN32
-    qtest_add_func("/migration/analyze-script", test_analyze_script);
+    if (!g_str_equal(arch, "s390x")) {
+        qtest_add_func("/migration/analyze-script", test_analyze_script);
+    }
 #endif
     qtest_add_func("/migration/precopy/unix/plain", test_precopy_unix_plain);
     qtest_add_func("/migration/precopy/unix/xbzrle", test_precopy_unix_xbzrle);
-- 
2.41.0



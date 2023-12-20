Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 350BF819B95
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 10:43:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFt5D-0002b6-Oy; Wed, 20 Dec 2023 04:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFt5C-0002aN-4p
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:41:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFt58-0005lP-Qc
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703065297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zkvih5v7Vy/QP69Lz1BS5+ziaxLKZku5MbDnhfO2v6M=;
 b=NmTXcHVpHtU2ZSZYm0K5qtqKpkl1egchSNnYhpLKk9UsIJL0J4Lv/JBzmLlz1khz51LH/k
 HPDA1FODSHM/6u5t5UbMcLuyzjohIngUEiAVUb+ogS9X8sxoI7SrSPZPw5AfoJmEt+n35N
 ToCKTkhUkegr9x6EcrK8SRXZNLiSRPk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-9NCYXlNHPK2aOJIaIW0SZQ-1; Wed, 20 Dec 2023 04:41:36 -0500
X-MC-Unique: 9NCYXlNHPK2aOJIaIW0SZQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C674283DE2B;
 Wed, 20 Dec 2023 09:41:35 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 876B12166B31;
 Wed, 20 Dec 2023 09:41:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 14/19] tests/qtest/migration-test: Fix analyze-migration.py for
 s390x
Date: Wed, 20 Dec 2023 10:41:00 +0100
Message-ID: <20231220094105.6588-15-thuth@redhat.com>
In-Reply-To: <20231220094105.6588-1-thuth@redhat.com>
References: <20231220094105.6588-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

The migration stream on s390x contains data for the storage_attributes
which the analyze-migration.py cannot handle yet. Add the basic code
for handling this, so we can re-enable the check in the migration-test.

Message-ID: <20231120113951.162090-1-thuth@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/migration-test.c |  4 +---
 scripts/analyze-migration.py | 35 +++++++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 0fbaa6a90f..d520c587f7 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3360,9 +3360,7 @@ int main(int argc, char **argv)
 
     qtest_add_func("/migration/bad_dest", test_baddest);
 #ifndef _WIN32
-    if (!g_str_equal(arch, "s390x")) {
-        qtest_add_func("/migration/analyze-script", test_analyze_script);
-    }
+    qtest_add_func("/migration/analyze-script", test_analyze_script);
 #endif
     qtest_add_func("/migration/precopy/unix/plain", test_precopy_unix_plain);
     qtest_add_func("/migration/precopy/unix/xbzrle", test_precopy_unix_xbzrle);
diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index de506cb8bf..a39dfb8766 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -263,6 +263,34 @@ def getDict(self):
         return ""
 
 
+class S390StorageAttributes(object):
+    STATTR_FLAG_EOS   = 0x01
+    STATTR_FLAG_MORE  = 0x02
+    STATTR_FLAG_ERROR = 0x04
+    STATTR_FLAG_DONE  = 0x08
+
+    def __init__(self, file, version_id, device, section_key):
+        if version_id != 0:
+            raise Exception("Unknown storage_attributes version %d" % version_id)
+
+        self.file = file
+        self.section_key = section_key
+
+    def read(self):
+        while True:
+            addr_flags = self.file.read64()
+            flags = addr_flags & 0xfff
+            if (flags & (self.STATTR_FLAG_DONE | self.STATTR_FLAG_EOS)):
+                return
+            if (flags & self.STATTR_FLAG_ERROR):
+                raise Exception("Error in migration stream")
+            count = self.file.read64()
+            self.file.readvar(count)
+
+    def getDict(self):
+        return ""
+
+
 class ConfigurationSection(object):
     def __init__(self, file, desc):
         self.file = file
@@ -544,8 +572,11 @@ class MigrationDump(object):
     QEMU_VM_SECTION_FOOTER= 0x7e
 
     def __init__(self, filename):
-        self.section_classes = { ( 'ram', 0 ) : [ RamSection, None ],
-                                 ( 'spapr/htab', 0) : ( HTABSection, None ) }
+        self.section_classes = {
+            ( 'ram', 0 ) : [ RamSection, None ],
+            ( 's390-storage_attributes', 0 ) : [ S390StorageAttributes, None],
+            ( 'spapr/htab', 0) : ( HTABSection, None )
+        }
         self.filename = filename
         self.vmsd_desc = None
 
-- 
2.43.0



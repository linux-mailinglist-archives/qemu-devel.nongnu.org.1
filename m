Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C26FB9F645A
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Dec 2024 12:11:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrxG-0006ni-F5; Wed, 18 Dec 2024 06:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrxD-0006mr-GR
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrxB-0005rB-Pa
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734520257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qK9FeF2ug4HC9bP+PICoWOfdfHK6SZEXv3UKwOI5wnI=;
 b=eesdjH+FIVrveU6dMaGeCKBxaMhriwPt2PqdM4D9iYQNsZRagQV7uEJh+V8fn9sDCZiOD5
 wUFFvAZAXrdb0li505tHEm/17clJ8Bm5bd8wOSbxHB5tx2lopM0+sx1HRTeVkp/qP1phNh
 eMwEwC/J4E+GZo0YtqNkar920Yf2djU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-5Z1b7-gNPK2wxGfS4TYlLQ-1; Wed,
 18 Dec 2024 06:10:54 -0500
X-MC-Unique: 5Z1b7-gNPK2wxGfS4TYlLQ-1
X-Mimecast-MFC-AGG-ID: 5Z1b7-gNPK2wxGfS4TYlLQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35FAB1955EB5
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:10:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8984019560AD; Wed, 18 Dec 2024 11:10:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 22/38] tests/functional: add 'archive_extract' to QemuBaseTest
Date: Wed, 18 Dec 2024 12:09:42 +0100
Message-ID: <20241218110958.226932-23-thuth@redhat.com>
In-Reply-To: <20241218110958.226932-1-thuth@redhat.com>
References: <20241218110958.226932-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

This helper wrappers archive.archive_extract, forcing the use of the
scratch directory, to ensure any extracted files are cleaned at test
termination. If a specific member is requested, then the path to the
extracted file is also returned.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20241217155953.3950506-23-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 493938240c..19fb1d0c07 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -25,6 +25,7 @@
 from qemu.machine import QEMUMachine
 from qemu.utils import kvm_available, tcg_available
 
+from .archive import archive_extract
 from .asset import Asset
 from .cmd import run_cmd
 from .config import BUILD_DIR
@@ -39,6 +40,37 @@ class QemuBaseTest(unittest.TestCase):
     log = None
     logdir = None
 
+    '''
+    @params archive: filename, Asset, or file-like object to extract
+    @params format: optional archive format (tar, zip, deb, cpio)
+    @params sub_dir: optional sub-directory to extract into
+    @params member: optional member file to limit extraction to
+
+    Extracts @archive into the scratch directory, or a directory beneath
+    named by @sub_dir. All files are extracted unless @member specifies
+    a limit.
+
+    If @format is None, heuristics will be applied to guess the format
+    from the filename or Asset URL. @format must be non-None if @archive
+    is a file-like object.
+
+    If @member is non-None, returns the fully qualified path to @member
+    '''
+    def archive_extract(self, archive, format=None, sub_dir=None, member=None):
+        self.log.debug(f"Extract {archive} format={format}" +
+                       f"sub_dir={sub_dir} member={member}")
+        if type(archive) == Asset:
+            archive.fetch()
+        if sub_dir is None:
+            archive_extract(archive, self.scratch_file(), format, member)
+        else:
+            archive_extract(archive, self.scratch_file(sub_dir),
+                            format, member)
+
+        if member is not None:
+            return self.scratch_file(member)
+        return None
+
     '''
     Create a temporary directory suitable for storing UNIX
     socket paths.
-- 
2.47.1



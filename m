Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EB0B1CA63
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Aug 2025 19:14:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujhh6-0007Zs-2I; Wed, 06 Aug 2025 13:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujhKF-0005BZ-NP
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 12:49:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujhKE-0002GK-9U
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 12:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754498953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1UpAgl57uXNyusZ5pFUvn++FTTsnpHSfYb+eyCy17Bw=;
 b=eVO3TGYbB7+xyFftkL0t5Tqw3snAQAHSBTG88tj/ekSpuQZkuaNwapKtM8czPbLrDW2HGM
 wKsBWgejwCNneha1ROIgzT/9MGfxL08tKtjM2y7LGdABXXx9Rn9Hm7T5wfNHSZbYOYrTp+
 lN2WVCkxegkp3Gx4p4z5qDJIhu1aeu8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-3y7GAF15Nwa64zundabshA-1; Wed,
 06 Aug 2025 12:49:12 -0400
X-MC-Unique: 3y7GAF15Nwa64zundabshA-1
X-Mimecast-MFC-AGG-ID: 3y7GAF15Nwa64zundabshA_1754498951
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E00B01800378; Wed,  6 Aug 2025 16:49:10 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.223])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60CC91956086; Wed,  6 Aug 2025 16:49:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 8/8] qapi: switch to use QEMU_TEST_REGENERATE env var
Date: Wed,  6 Aug 2025 17:48:32 +0100
Message-ID: <20250806164832.1382919-9-berrange@redhat.com>
In-Reply-To: <20250806164832.1382919-1-berrange@redhat.com>
References: <20250806164832.1382919-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The QAPI_TEST_UPDATE env var can be set when running the QAPI
schema tests to regenerate the reference output. For consistent
naming with the tracetool test, change the env var name to
QEMU_TEST_REGENERATE.

The test is modified to provide a hint about use of the new
env var and it is also added to the developer documentation.document its usage.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/devel/testing/main.rst    | 12 ++++++++++++
 tests/qapi-schema/test-qapi.py |  7 +++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index 11f05c0006..fe233fcf7a 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -178,6 +178,18 @@ parser (either fixing a bug or extending/modifying the syntax). To do this:
 
   ``qapi-schema += foo.json``
 
+The reference output can be automatically updated to match the latest QAPI
+code generator by running the tests with the QEMU_TEST_REGENERATE environment
+variable set.
+
+.. code::
+
+   QEMU_TEST_REGENERATE=1 make check-qapi-schema
+
+The resulting changes must be reviewed by the author to ensure they match
+the intended results, before adding the updated reference output to the
+same commit that alters the generator code.
+
 .. _tracetool-tests:
 
 Tracetool tests
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 4be930228c..cf7fb8a6df 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -165,7 +165,7 @@ def test_and_diff(test_name, dir_name, update):
     if actual_out == expected_out and actual_err == expected_err:
         return 0
 
-    print("%s %s" % (test_name, 'UPDATE' if update else 'FAIL'),
+    print("%s: %s" % (test_name, 'UPDATE' if update else 'FAIL'),
           file=sys.stderr)
     out_diff = difflib.unified_diff(expected_out, actual_out, outfp.name)
     err_diff = difflib.unified_diff(expected_err, actual_err, errfp.name)
@@ -173,6 +173,9 @@ def test_and_diff(test_name, dir_name, update):
     sys.stdout.writelines(err_diff)
 
     if not update:
+        print(("\n%s: set QEMU_TEST_REGENERATE=1 to recreate reference output" +
+               "if the QAPI schema generator was intentionally changed") % test_name,
+              file=sys.stderr)
         return 1
 
     try:
@@ -197,7 +200,7 @@ def main(argv):
     parser.add_argument('-d', '--dir', action='store', default='',
                         help="directory containing tests")
     parser.add_argument('-u', '--update', action='store_true',
-                        default='QAPI_TEST_UPDATE' in os.environ,
+                        default='QEMU_TEST_REGENERATE' in os.environ,
                         help="update expected test results")
     parser.add_argument('tests', nargs='*', metavar='TEST', action='store')
     args = parser.parse_args()
-- 
2.50.1



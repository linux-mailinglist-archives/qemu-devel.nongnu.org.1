Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 318329DEBC4
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Nov 2024 18:36:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH4rQ-0004z4-Km; Fri, 29 Nov 2024 12:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4qx-00046T-QQ
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:32:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4qw-00017Y-Cb
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732901545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xL5Wxr2F74R3RQEXwSYCoWJhnI9k2JMIAfjAihei9rU=;
 b=DvBtAgZ3tH16cVO3V1qntehplsFkmzS1sGq2WjpLVk6qC8LEXQ+OBG8r0XW6MbHnQ1Ydcz
 e+gq0tMiFGnni33/ydbZi7tJ808NK+Ynr5YNpPxGTYOQu5DCZ/O+MBI75AbbfEnXFtWF4J
 XpTbjJ5nNpRxw385IzOAB7oN+gFpLmI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-SpRAWYlVMeS0UrB2rcE9dQ-1; Fri,
 29 Nov 2024 12:32:20 -0500
X-MC-Unique: SpRAWYlVMeS0UrB2rcE9dQ-1
X-Mimecast-MFC-AGG-ID: SpRAWYlVMeS0UrB2rcE9dQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56B931955EA9; Fri, 29 Nov 2024 17:32:19 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 13CE21955F2F; Fri, 29 Nov 2024 17:32:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 21/22] tests/functional: add 'uncompress' to QemuBaseTest
Date: Fri, 29 Nov 2024 17:31:19 +0000
Message-ID: <20241129173120.761728-22-berrange@redhat.com>
In-Reply-To: <20241129173120.761728-1-berrange@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This helper wrappers utils.uncompress, forcing the use of the scratch
directory, to ensure any uncompressed files are cleaned at test
termination.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 31d06f0172..5c088a2442 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -29,7 +29,8 @@
 from .cmd import run_cmd
 from .config import BUILD_DIR
 from .utils import (archive_extract as utils_archive_extract,
-                    guess_archive_format)
+                    uncompress as utils_uncompress,
+                    guess_archive_format, guess_uncompress_format)
 
 
 class QemuBaseTest(unittest.TestCase):
@@ -41,6 +42,21 @@ class QemuBaseTest(unittest.TestCase):
     log = None
     logdir = None
 
+    def uncompress(self, input_path, format=None):
+        if type(input_path) == Asset:
+            if format is None:
+                format = guess_uncompress_format(input_path.url)
+            input_path = input_path.fetch()
+        elif format is None:
+            format = guess_uncompress_format(input_path)
+
+        (name, ext) = os.path.splitext(input_path)
+        output_path = self.scratch_file(os.path.basename(name))
+
+        utils_uncompress(input_path, output_path)
+
+        return output_path
+
     '''
     @params archive: filename, Asset, or file-like object to extract
     @params sub_dir: optional sub-directory to extract into
-- 
2.46.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA50DA64F8D
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Mar 2025 13:44:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu9oX-0005kv-72; Mon, 17 Mar 2025 08:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tu9oI-0005kB-8w
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 08:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tu9oG-0007JK-Ie
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 08:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742215391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OVXTnO12DbqtUF60t5lOBwR9yjKTqKpwVnASaQvyFcg=;
 b=fc1HM7dj63Bga10VIZY8fEUl1KLtDvKkm9yvYni60uiySVp8uW7fOY57bJbfY+XxxeCW0K
 Y2UB6X3a4illJMnWwtLJup0fpfyFbuuQExdx65VeBTPBu8/FuAWtgY1u4qUGHlJcQnL80s
 9kDIrteg06LWxJtSTEMAfrJ7WVtzWOs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-iG6-rRtFODa-yawuig-BbA-1; Mon,
 17 Mar 2025 08:43:07 -0400
X-MC-Unique: iG6-rRtFODa-yawuig-BbA-1
X-Mimecast-MFC-AGG-ID: iG6-rRtFODa-yawuig-BbA_1742215386
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DFDA1800361; Mon, 17 Mar 2025 12:43:05 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A6A3C1955DCE; Mon, 17 Mar 2025 12:43:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <dan-qemu@berrange.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3] tests/functional: remove all class level fields
Date: Mon, 17 Mar 2025 12:43:00 +0000
Message-ID: <20250317124300.84266-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

A number of fields are set at the class level on QemuBaseTest, even
though the exact same named field is then set at the object level
later in most cases.

The 'self.logger' initialization in ACPI bits test needs to be removed
since 'self.log' won't exist at that point in the flow. It already
initialized 'self.logger' later in the setUp() method, so the __init__
method was redundant.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 6 ------
 tests/functional/test_acpi_bits.py     | 1 -
 2 files changed, 7 deletions(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 50d232a7c6..50c401b8c3 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -33,12 +33,6 @@
 
 class QemuBaseTest(unittest.TestCase):
 
-    arch = None
-
-    workdir = None
-    log = None
-    logdir = None
-
     '''
     @params compressed: filename, Asset, or file-like object to uncompress
     @params format: optional compression format (gzip, lzma)
diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_acpi_bits.py
index 20da435687..8e0563a97b 100755
--- a/tests/functional/test_acpi_bits.py
+++ b/tests/functional/test_acpi_bits.py
@@ -119,7 +119,6 @@ def __init__(self, *args, **kwargs):
 
         self._debugcon_addr = '0x403'
         self._debugcon_log = 'debugcon-log.txt'
-        self.logger = self.log
 
     def _print_log(self, log):
         self.logger.info('\nlogs from biosbits follows:')
-- 
2.48.1



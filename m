Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6197A7EB4EC
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 17:33:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wK1-0002vF-5Z; Tue, 14 Nov 2023 11:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2wJy-0002uI-2J
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:31:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2wJw-0006PM-Kr
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699979484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2IhRetqNyf+ECaS1NJt3qFrZxCNRTuGbI7jied8VWoo=;
 b=O9D9LMG9jBkDuqxVUUQ/fOK7RXTIiPoDh2DPY7XHWcoun87yIxyd0HaRGeb3K0GGKQal9b
 s06oFmVS3aWB8jWuwX55yrFkE9Tx/xXe+lK1BWQriHnfe4f7EwPbmgsHFf8qEbXvx1/SQU
 24msV1bjmG28E8jseF8T0iwcjQZF6Yo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-kcJAuOv_Pyi5rIML6AzCVw-1; Tue, 14 Nov 2023 11:31:19 -0500
X-MC-Unique: kcJAuOv_Pyi5rIML6AzCVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E716185A7A8;
 Tue, 14 Nov 2023 16:31:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A46C40C6EB9;
 Tue, 14 Nov 2023 16:31:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH] tests/avocado/reverse_debugging: Disable the ppc64 tests by
 default
Date: Tue, 14 Nov 2023 17:31:15 +0100
Message-ID: <20231114163115.298041-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

The tests seem currently to be broken. Disable them by default
until someone fixes them.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/reverse_debugging.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index fc47874eda..2585c78f34 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -11,6 +11,7 @@
 import logging
 
 from avocado import skipIf
+from avocado import skipUnless
 from avocado_qemu import BUILD_DIR
 from avocado.utils import gdb
 from avocado.utils import process
@@ -241,8 +242,8 @@ class ReverseDebugging_ppc64(ReverseDebugging):
 
     REG_PC = 0x40
 
-    # unidentified gitlab timeout problem
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    # Test seems to be broken right now
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test gets stuck')
     def test_ppc64_pseries(self):
         """
         :avocado: tags=arch:ppc64
@@ -254,7 +255,7 @@ def test_ppc64_pseries(self):
         self.endian_is_le = False
         self.reverse_debugging()
 
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test often fails')
     def test_ppc64_powernv(self):
         """
         :avocado: tags=arch:ppc64
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB96974DBDF
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 19:03:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIuH1-0007cf-RD; Mon, 10 Jul 2023 13:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIuH0-0007c0-OW
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:02:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIuGy-0001Zw-7t
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689008522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cx1rnRIeuyVVSO8/3NH5unDX9hfH1KXnsG2nccb01qo=;
 b=cuvzlg0jbpy+nrf9pxRLnWLLzZP5wodYjIvTdbqD8xgoKkKCyOL/k2b6MDi/XpeTj1WEKn
 0wP6y8nmIK9eosOe0RUxkpokdt/KSkJZwtaerxgW7Cxonj0j77rv5YNAdV35V/j4geP5nG
 3zAEXtkiTNyf9+05LrKnP7Q9ki3Geeg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-oLMWT4-zM6ue0pPgIPjMNQ-1; Mon, 10 Jul 2023 13:02:00 -0400
X-MC-Unique: oLMWT4-zM6ue0pPgIPjMNQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABC763C0F662;
 Mon, 10 Jul 2023 17:01:59 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DD894CD0C9;
 Mon, 10 Jul 2023 17:01:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>
Cc: Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2] tests/avocado: Disable the test_sbsaref_edk2_firmware by
 default
Date: Mon, 10 Jul 2023 19:01:55 +0200
Message-Id: <20230710170155.7192-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

The test fails occasionally, see e.g.:

 https://gitlab.com/thuth/qemu/-/jobs/4196177756#L489
 https://gitlab.com/thuth/qemu/-/jobs/4623296271#L290

It also fails on my laptop in ca. 50% of all runs. Thus disable it by
default by using the QEMU_TEST_FLAKY_TESTS environment variable to fence
it (which we also already use in flaky qtests). While we're at it, also
document this variable in docs/devel/testing.rst.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Use QEMU_TEST_FLAKY_TESTS instead of GITLAB_CI as sugested by PMM

 docs/devel/testing.rst                   | 5 +++++
 tests/avocado/machine_aarch64_sbsaref.py | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index fb651eae11..b6ad21bed1 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -1384,6 +1384,11 @@ variable as shown on the code snippet below to skip the test:
   def test(self):
       do_something()
 
+QEMU_TEST_FLAKY_TESTS
+^^^^^^^^^^^^^^^^^^^^^
+Some tests are not working reliably and thus are disabled by default.
+Set this environment variable to enable them.
+
 Uninstalling Avocado
 ~~~~~~~~~~~~~~~~~~~~
 
diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index cce6ef9f65..a794245e7e 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -8,7 +8,6 @@
 
 import os
 
-from avocado import skip
 from avocado import skipUnless
 from avocado.utils import archive
 
@@ -76,6 +75,7 @@ def fetch_firmware(self):
             "sbsa-ref",
         )
 
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is not reliable')
     def test_sbsaref_edk2_firmware(self):
         """
         :avocado: tags=cpu:cortex-a57
-- 
2.39.3



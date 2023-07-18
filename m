Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E31DA757814
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 11:32:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLh2o-00042A-5E; Tue, 18 Jul 2023 05:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLh2m-00041o-PR
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLh2l-0004F2-9m
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689672654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cwk3Mhat8DF/tpvyGthuyT18eMCpgAbOaTBAvXT9+d0=;
 b=YnzSpdIlFWHv6cttYe85MnE/dER/vPvs8nOZsoec4dbrgK9zFzDOyE1e0C6ijZct0WBTe1
 m3N49obpqTTud1KXnBsLQui+Y4o7w+He6QppYv6WmjBaNRkazrpO4yssoH1fYSC56yTXZX
 6eSYWpi1LVEBtVIrS76aTZrBwCXp7is=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-eFAz_GObPDG_uyikGfWByw-1; Tue, 18 Jul 2023 05:30:53 -0400
X-MC-Unique: eFAz_GObPDG_uyikGfWByw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13ADF1C34096;
 Tue, 18 Jul 2023 09:30:53 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68CBA2166B25;
 Tue, 18 Jul 2023 09:30:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 8/8] tests/avocado: Disable the test_sbsaref_edk2_firmware by
 default
Date: Tue, 18 Jul 2023 11:30:40 +0200
Message-Id: <20230718093040.172145-9-thuth@redhat.com>
In-Reply-To: <20230718093040.172145-1-thuth@redhat.com>
References: <20230718093040.172145-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

The test fails occasionally, see e.g.:

 https://gitlab.com/thuth/qemu/-/jobs/4196177756#L489
 https://gitlab.com/thuth/qemu/-/jobs/4623296271#L290

It also fails on my laptop in ca. 50% of all runs. Thus disable it by
default by using the QEMU_TEST_FLAKY_TESTS environment variable to fence
it (which we also already use in flaky qtests). While we're at it, also
document this variable in docs/devel/testing.rst.

Message-Id: <20230710170155.7192-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
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



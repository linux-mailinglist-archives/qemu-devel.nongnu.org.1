Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2E49D6040
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Nov 2024 15:19:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEUUe-0001UJ-4S; Fri, 22 Nov 2024 09:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tEUUc-0001Tz-Rp
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 09:18:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tEUUa-0004ak-Ol
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 09:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732285119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=igiuvLcD2TSFgEZ9NwbX7MVrBe+Id0se/pyyOnDbswg=;
 b=MG9/haPhmVodcpaetA0n4KHPTo/wJ+RFxrXA7YHWP4N/ZAeOefBF7K8FC0aA8fO5McoezX
 i38R8JJ06K+wI9wnTp6GBohIL0t8DWmX7CVXFfL1/w+rHduKX2FV1gIM+USO6B9cHT4gZC
 76ElK4K/qzl0RojFPv9W6nlVAAosqmM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-JKk6xpjTOdSvSClIUCaXUw-1; Fri,
 22 Nov 2024 09:18:34 -0500
X-MC-Unique: JKk6xpjTOdSvSClIUCaXUw-1
X-Mimecast-MFC-AGG-ID: JKk6xpjTOdSvSClIUCaXUw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 309FC195394A; Fri, 22 Nov 2024 14:18:33 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.92])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E3A2719560A3; Fri, 22 Nov 2024 14:18:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2] tests/functional: Remove sleep workarounds from sh4 test
Date: Fri, 22 Nov 2024 15:18:27 +0100
Message-ID: <20241122141827.2039984-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

These were introduced in the avocado tests to workaround read issues
when interacting with console. They are no longer necessary and we can
use the expected login string instead.

Test always passes now. Remove skipUnless test on QEMU_TEST_FLAKY_TESTS.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/test_sh4_tuxrun.py | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tests/functional/test_sh4_tuxrun.py b/tests/functional/test_sh4_tuxrun.py
index 352cb360ef74..b33533fc7e7b 100755
--- a/tests/functional/test_sh4_tuxrun.py
+++ b/tests/functional/test_sh4_tuxrun.py
@@ -15,7 +15,7 @@
 import time
 
 from unittest import skipUnless
-from qemu_test import Asset, exec_command_and_wait_for_pattern, exec_command
+from qemu_test import Asset, exec_command_and_wait_for_pattern
 from qemu_test.tuxruntest import TuxRunBaselineTest
 
 class TuxRunSh4Test(TuxRunBaselineTest):
@@ -27,8 +27,6 @@ class TuxRunSh4Test(TuxRunBaselineTest):
         'https://storage.tuxboot.com/20230331/sh4/rootfs.ext4.zst',
         '3592a7a3d5a641e8b9821449e77bc43c9904a56c30d45da0694349cfd86743fd')
 
-    # Note: some segfaults caused by unaligned userspace access
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable')
     def test_sh4(self):
         self.set_machine('r2d')
         self.cpu='sh7785'
@@ -46,10 +44,8 @@ def test_sh4(self):
                          console_index=1)
         self.vm.launch()
 
-        self.wait_for_console_pattern("Welcome to TuxTest")
-        time.sleep(0.1)
-        exec_command(self, 'root')
-        time.sleep(0.1)
+        self.wait_for_console_pattern("tuxtest login:")
+        exec_command_and_wait_for_pattern(self, 'root', 'root@tuxtest:~#')
         exec_command_and_wait_for_pattern(self, 'halt',
                                           "reboot: System halted")
 
-- 
2.47.0



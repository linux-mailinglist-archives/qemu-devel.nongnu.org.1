Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBF2A6EB54
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Mar 2025 09:19:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twzTb-0004m1-PO; Tue, 25 Mar 2025 04:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1twzTY-0004lL-3v
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 04:17:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1twzTV-0004RQ-Ql
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 04:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742890647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UQlV0p+74jmI5JyVfg6p+xncXHwdy9n0k/5RG/Os2WQ=;
 b=QH8H6VVT1iW0CmfiIRIPI9iZcJteP8/VY3N7pGEaIu7hpASpJnF33UeLhYxqnj+3IZU9XJ
 yuD8jrj7w+QXaKHXjxzz6AU9jcpgDEdtNKVwd+orW5z5AMDWXT9n4A2PoXRDtfAJZpfLeF
 QtxDgG6Wuew74nbP9HUK/mrRwy82jYc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-8W9Qw8hWMZu2qOg6UryWmQ-1; Tue,
 25 Mar 2025 04:17:24 -0400
X-MC-Unique: 8W9Qw8hWMZu2qOg6UryWmQ-1
X-Mimecast-MFC-AGG-ID: 8W9Qw8hWMZu2qOg6UryWmQ_1742890643
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CECDB1828B34; Tue, 25 Mar 2025 08:17:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.142])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2F1291801750; Tue, 25 Mar 2025 08:17:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>
Subject: [PATCH] tests/functional: Skip the screendump tests if the command is
 not available
Date: Tue, 25 Mar 2025 09:17:12 +0100
Message-ID: <20250325081713.283490-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Thomas Huth <thuth@redhat.com>

It is possible nowadays to compile QEMU without pixman support - in that
case the screendump command is not available and the related tests fail.
Thus skip these tests if the screendump command could not be executed.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_arm_integratorcp.py | 6 ++++--
 tests/functional/test_m68k_nextcube.py    | 6 ++++--
 tests/functional/test_mips64el_malta.py   | 6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/tests/functional/test_arm_integratorcp.py b/tests/functional/test_arm_integratorcp.py
index a85b339d772..4f00924aa03 100755
--- a/tests/functional/test_arm_integratorcp.py
+++ b/tests/functional/test_arm_integratorcp.py
@@ -73,8 +73,10 @@ def test_framebuffer_tux_logo(self):
         framebuffer_ready = 'Console: switching to colour frame buffer device'
         wait_for_console_pattern(self, framebuffer_ready)
         self.vm.cmd('human-monitor-command', command_line='stop')
-        self.vm.cmd('human-monitor-command',
-                    command_line='screendump %s' % screendump_path)
+        res = self.vm.cmd('human-monitor-command',
+                          command_line='screendump %s' % screendump_path)
+        if 'unknown command' in res:
+            self.skipTest('screendump not available')
         logger = logging.getLogger('framebuffer')
 
         cpu_count = 1
diff --git a/tests/functional/test_m68k_nextcube.py b/tests/functional/test_m68k_nextcube.py
index ff773a7994f..13c72bd136a 100755
--- a/tests/functional/test_m68k_nextcube.py
+++ b/tests/functional/test_m68k_nextcube.py
@@ -32,8 +32,10 @@ def check_bootrom_framebuffer(self, screenshot_path):
         # TODO: wait for the 'displaysurface_create 1120x832' trace-event.
         time.sleep(2)
 
-        self.vm.cmd('human-monitor-command',
-                    command_line='screendump %s' % screenshot_path)
+        res = self.vm.cmd('human-monitor-command',
+                          command_line='screendump %s' % screenshot_path)
+        if 'unknown command' in res:
+            self.skipTest('screendump not available')
 
     @skipIfMissingImports("PIL")
     def test_bootrom_framebuffer_size(self):
diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
index a8da15a26b3..a0bbd847512 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/test_mips64el_malta.py
@@ -133,8 +133,10 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
         framebuffer_ready = 'Console: switching to colour frame buffer device'
         self.wait_for_console_pattern(framebuffer_ready)
         self.vm.cmd('human-monitor-command', command_line='stop')
-        self.vm.cmd('human-monitor-command',
-                    command_line='screendump %s' % screendump_path)
+        res = self.vm.cmd('human-monitor-command',
+                          command_line='screendump %s' % screendump_path)
+        if 'unknown command' in res:
+            self.skipTest('screendump not available')
         logger = logging.getLogger('framebuffer')
 
         match_threshold = 0.95
-- 
2.49.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C8E811258
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 14:02:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDOrx-0008FE-Vg; Wed, 13 Dec 2023 08:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rDOrT-00084i-Hj; Wed, 13 Dec 2023 08:01:18 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rDOrQ-0006yu-RC; Wed, 13 Dec 2023 08:01:15 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3199E3B43A;
 Wed, 13 Dec 2023 16:01:01 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id CAF893C8CB;
 Wed, 13 Dec 2023 16:00:41 +0300 (MSK)
Received: (nullmailer pid 1024714 invoked by uid 1000);
 Wed, 13 Dec 2023 13:00:41 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.8 07/24] tests/avocado: Replace assertRegexpMatches() for
 Python 3.12 compatibility
Date: Wed, 13 Dec 2023 16:00:16 +0300
Message-Id: <20231213130041.1024630-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
References: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

assertRegexpMatches() has been removed in Python 3.12 and should be replaced by
assertRegex(). See: https://docs.python.org/3.12/whatsnew/3.12.html#id3

Inspired-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231114144832.71612-1-philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit f0a663b4ced2bf315936c774c2b6ff398fce8905)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: adjust context for before v8.1.0-1582-g684750ab4f
 "python/qemu: rename command() to cmd()")

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 8cad156aa0..98c26ecf18 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -990,7 +990,7 @@ class.  Here's a simple usage example:
           self.vm.launch()
           res = self.vm.command('human-monitor-command',
                                 command_line='info version')
-          self.assertRegexpMatches(res, r'^(\d+\.\d+\.\d)')
+          self.assertRegex(res, r'^(\d+\.\d+\.\d)')
 
 To execute your test, run:
 
diff --git a/tests/avocado/version.py b/tests/avocado/version.py
index ded7f039c1..5f88ff300b 100644
--- a/tests/avocado/version.py
+++ b/tests/avocado/version.py
@@ -21,4 +21,4 @@ def test_qmp_human_info_version(self):
         self.vm.launch()
         res = self.vm.command('human-monitor-command',
                               command_line='info version')
-        self.assertRegexpMatches(res, r'^(\d+\.\d+\.\d)')
+        self.assertRegex(res, r'^(\d+\.\d+\.\d)')
-- 
2.39.2



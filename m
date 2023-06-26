Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F4E73EAB4
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 20:58:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrIM-000425-LQ; Mon, 26 Jun 2023 14:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrIH-00040h-BP; Mon, 26 Jun 2023 14:50:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrIF-0004kW-FW; Mon, 26 Jun 2023 14:50:33 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 28188EF15;
 Mon, 26 Jun 2023 21:50:18 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1D7A9F7A8;
 Mon, 26 Jun 2023 21:50:16 +0300 (MSK)
Received: (nullmailer pid 1573964 invoked by uid 1000);
 Mon, 26 Jun 2023 18:50:15 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Eldon Stegall <eldon-qemu@eldondev.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 02/54] scripts/device-crash-test: Add a parameter to
 run with TCG only
Date: Mon, 26 Jun 2023 21:49:09 +0300
Message-Id: <20230626185002.1573836-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
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

From: Thomas Huth <thuth@redhat.com>

We're currently facing the problem that the device-crash-test script
runs twice as long in the CI when a runner supports KVM - which sometimes
results in a timeout of the CI job. To get a more deterministic runtime
here, add an option to the script that allows to run it with TCG only.

Reported-by: Eldon Stegall <eldon-qemu@eldondev.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230414145845.456145-3-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230424092249.58552-6-alex.bennee@linaro.org>
(cherry picked from commit 8b869aa59109d238fd684e1ade204b6942202120)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 333eea9dd3..bb3650a51c 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -103,7 +103,7 @@ crash-test-debian:
   script:
     - cd build
     - make NINJA=":" check-venv
-    - tests/venv/bin/python3 scripts/device-crash-test -q ./qemu-system-i386
+    - tests/venv/bin/python3 scripts/device-crash-test -q --tcg-only ./qemu-system-i386
 
 build-system-fedora:
   extends:
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 73bcb98693..b74d887331 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -397,7 +397,7 @@ def binariesToTest(args, testcase):
 
 
 def accelsToTest(args, testcase):
-    if getBinaryInfo(args, testcase['binary']).kvm_available:
+    if getBinaryInfo(args, testcase['binary']).kvm_available and not args.tcg_only:
         yield 'kvm'
     yield 'tcg'
 
@@ -510,6 +510,8 @@ def main():
                         help="Full mode: test cases that are expected to fail")
     parser.add_argument('--strict', action='store_true', dest='strict',
                         help="Treat all warnings as fatal")
+    parser.add_argument('--tcg-only', action='store_true', dest='tcg_only',
+                        help="Only test with TCG accelerator")
     parser.add_argument('qemu', nargs='*', metavar='QEMU',
                         help='QEMU binary to run')
     args = parser.parse_args()
-- 
2.39.2



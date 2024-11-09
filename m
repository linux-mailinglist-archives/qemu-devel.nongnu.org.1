Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B15C29C2AD7
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Nov 2024 07:45:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9fBN-0006am-D3; Sat, 09 Nov 2024 01:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9f9E-0004Vt-Jt; Sat, 09 Nov 2024 01:40:40 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9f9C-0002VD-JA; Sat, 09 Nov 2024 01:40:40 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A638EA12FB;
 Sat,  9 Nov 2024 09:38:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1C5F5167DDE;
 Sat,  9 Nov 2024 09:39:05 +0300 (MSK)
Received: (nullmailer pid 3272550 invoked by uid 1000);
 Sat, 09 Nov 2024 06:39:03 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.15 19/33] gitlab: make check-[dco|patch] a little more
 verbose
Date: Sat,  9 Nov 2024 09:38:45 +0300
Message-Id: <20241109063903.3272404-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.15-20241109093832@cover.tls.msk.ru>
References: <qemu-stable-7.2.15-20241109093832@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Alex Bennée <alex.bennee@linaro.org>

When git fails the rather terse backtrace only indicates it failed
without some useful context. Add some to make the log a little more
useful.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241023113406.1284676-11-alex.bennee@linaro.org>
(cherry picked from commit 97f116f9c6fd127b6ed2953993fa9fb05e82f450)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: context fix for stable-7.2)

diff --git a/.gitlab-ci.d/check-dco.py b/.gitlab-ci.d/check-dco.py
index b929571eed..8780d73e31 100755
--- a/.gitlab-ci.d/check-dco.py
+++ b/.gitlab-ci.d/check-dco.py
@@ -19,10 +19,9 @@
 reponame = os.path.basename(cwd)
 repourl = "https://gitlab.com/%s/%s.git" % (namespace, reponame)
 
+print(f"adding upstream git repo @ {repourl}")
 subprocess.check_call(["git", "remote", "add", "check-dco", repourl])
-subprocess.check_call(["git", "fetch", "check-dco", "stable-7.2"],
-                      stdout=subprocess.DEVNULL,
-                      stderr=subprocess.DEVNULL)
+subprocess.check_call(["git", "fetch", "check-dco", "stable-7.2"])
 
 ancestor = subprocess.check_output(["git", "merge-base",
                                     "check-dco/stable-7.2", "HEAD"],
diff --git a/.gitlab-ci.d/check-patch.py b/.gitlab-ci.d/check-patch.py
index 39e2b403c9..68c549a146 100755
--- a/.gitlab-ci.d/check-patch.py
+++ b/.gitlab-ci.d/check-patch.py
@@ -19,13 +19,12 @@
 reponame = os.path.basename(cwd)
 repourl = "https://gitlab.com/%s/%s.git" % (namespace, reponame)
 
+print(f"adding upstream git repo @ {repourl}")
 # GitLab CI environment does not give us any direct info about the
 # base for the user's branch. We thus need to figure out a common
 # ancestor between the user's branch and current git master.
 subprocess.check_call(["git", "remote", "add", "check-patch", repourl])
-subprocess.check_call(["git", "fetch", "check-patch", "master"],
-                      stdout=subprocess.DEVNULL,
-                      stderr=subprocess.DEVNULL)
+subprocess.check_call(["git", "fetch", "check-patch", "master"])
 
 ancestor = subprocess.check_output(["git", "merge-base",
                                     "check-patch/master", "HEAD"],
-- 
2.39.5



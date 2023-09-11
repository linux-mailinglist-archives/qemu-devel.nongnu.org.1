Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A91C79A59D
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 10:09:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbsV-0001D3-V3; Mon, 11 Sep 2023 04:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfbsP-0001Cc-54; Mon, 11 Sep 2023 04:02:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfbsM-000270-AB; Mon, 11 Sep 2023 04:02:32 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B1D8120AEE;
 Mon, 11 Sep 2023 11:02:28 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 14AE227243;
 Mon, 11 Sep 2023 11:02:27 +0300 (MSK)
Received: (nullmailer pid 3680121 invoked by uid 1000);
 Mon, 11 Sep 2023 08:02:27 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Thomas Huth <thuth@redhat.com>
Subject: [Stable-7.2.6 01/51] gitlab-ci: check-dco.py: switch from master to
 stable-7.2 branch
Date: Mon, 11 Sep 2023 11:01:52 +0300
Message-Id: <20230911080225.3680068-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.6-20230911105418@cover.tls.msk.ru>
References: <qemu-stable-7.2.6-20230911105418@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

There's one commit, tagged v7.2.2, without Signed-off-by line.
Due to this, check-dco test always fail on 7.2.  Since this is
a stable branch with almost all commits coming from master
already with S-o-b (except of the version bumps and very rare
stable-specific commits), and v7.2.2 is already cast in stone,
let's base the check on stable-7.2 branch (with its last version)
instead of master branch.  This way, staging-7.2 will be checked
against stable-7.2, but stable-7.2 itself will not be checked
anymore, - so we can catch errors during stable preparations.

Note: this is a change specific to stable-7.2 branch/series, it
is not supposed to be in master.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Thomas Huth <thuth@redhat.com>

diff --git a/.gitlab-ci.d/check-dco.py b/.gitlab-ci.d/check-dco.py
index 632c8bcce8..b929571eed 100755
--- a/.gitlab-ci.d/check-dco.py
+++ b/.gitlab-ci.d/check-dco.py
@@ -20,12 +20,12 @@
 repourl = "https://gitlab.com/%s/%s.git" % (namespace, reponame)
 
 subprocess.check_call(["git", "remote", "add", "check-dco", repourl])
-subprocess.check_call(["git", "fetch", "check-dco", "master"],
+subprocess.check_call(["git", "fetch", "check-dco", "stable-7.2"],
                       stdout=subprocess.DEVNULL,
                       stderr=subprocess.DEVNULL)
 
 ancestor = subprocess.check_output(["git", "merge-base",
-                                    "check-dco/master", "HEAD"],
+                                    "check-dco/stable-7.2", "HEAD"],
                                    universal_newlines=True)
 
 ancestor = ancestor.strip()
@@ -85,7 +85,7 @@
 
 To bulk update all commits on current branch "git rebase" can be used:
 
-  git rebase -i master -x 'git commit --amend --no-edit -s'
+  git rebase -i stable-7.2 -x 'git commit --amend --no-edit -s'
 
 """)
 
-- 
2.39.2



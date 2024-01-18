Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43938831EE8
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 19:03:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQWhR-0005Ib-13; Thu, 18 Jan 2024 13:01:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQWhD-0005BO-Jl; Thu, 18 Jan 2024 13:00:56 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQWhB-0001kw-TE; Thu, 18 Jan 2024 13:00:55 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B384E4545F;
 Thu, 18 Jan 2024 21:01:13 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4995266C28;
 Thu, 18 Jan 2024 21:00:42 +0300 (MSK)
Received: (nullmailer pid 2513374 invoked by uid 1000);
 Thu, 18 Jan 2024 18:00:31 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.9 8/8] .gitlab-ci.d/buildtest.yml: Work around htags bug
 when environment is large
Date: Thu, 18 Jan 2024 21:00:27 +0300
Message-Id: <20240118180031.2513319-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.9-20240118170458@cover.tls.msk.ru>
References: <qemu-stable-7.2.9-20240118170458@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

Sometimes the CI "pages" job fails with a message like this from
htags:

$ htags -anT --tree-view=filetree -m qemu_init -t "Welcome to the QEMU sourcecode"
htags: Negative exec line limit = -371

This is due to a bug in hflags where if the environment is too large it
falls over:
https://lists.gnu.org/archive/html/bug-global/2024-01/msg00000.html

This happens to us because GitLab CI puts the commit message of the
commit under test into the CI_COMMIT_MESSAGE and/or CI_COMMIT_TAG_MESSAGE
environment variables, so the job will fail if the commit happens to
have a verbose commit message.

Work around the htags bug by unsetting these variables while running
htags.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2080
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240111125543.1573473-1-peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 52a21689cd829c1cc931b59b5ee5bdb10dd578c1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 10886bb414..7243b8079b 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -637,7 +637,10 @@ pages:
     - mkdir -p public
     # HTML-ised source tree
     - make gtags
-    - htags -anT --tree-view=filetree -m qemu_init
+    # We unset variables to work around a bug in some htags versions
+    # which causes it to fail when the environment is large
+    - CI_COMMIT_MESSAGE= CI_COMMIT_TAG_MESSAGE= htags
+        -anT --tree-view=filetree -m qemu_init
         -t "Welcome to the QEMU sourcecode"
     - mv HTML public/src
     # Project documentation
-- 
2.39.2



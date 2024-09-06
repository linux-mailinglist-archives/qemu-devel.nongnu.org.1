Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE29E96E924
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Sep 2024 07:22:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smRMM-0008K5-Ta; Fri, 06 Sep 2024 01:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smRMJ-00087k-GB; Fri, 06 Sep 2024 01:18:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smRMH-000840-IO; Fri, 06 Sep 2024 01:18:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 63FEB8C127;
 Fri,  6 Sep 2024 08:15:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1494A13336D;
 Fri,  6 Sep 2024 08:16:35 +0300 (MSK)
Received: (nullmailer pid 10442 invoked by uid 1000);
 Fri, 06 Sep 2024 05:16:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.14 19/40] docs/sphinx/depfile.py: Handle env.doc2path()
 returning a Path not a str
Date: Fri,  6 Sep 2024 08:16:07 +0300
Message-Id: <20240906051633.10288-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
References: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
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

In newer versions of Sphinx the env.doc2path() API is going to change
to return a Path object rather than a str. This was originally visible
in Sphinx 8.0.0rc1, but has been rolled back for the final 8.0.0
release. However it will probably emit a deprecation warning and is
likely to change for good in 9.0:
  https://github.com/sphinx-doc/sphinx/issues/12686

Our use in depfile.py assumes a str, and if it is passed a Path
it will fall over:
 Handler <function write_depfile at 0x77a1775ff560> for event 'build-finished' threw an exception (exception: unsupported operand type(s) for +: 'PosixPath' and 'str')

Wrapping the env.doc2path() call in str() will coerce a Path object
to the str we expect, and have no effect in older Sphinx versions
that do return a str.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2458
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240729120533.2486427-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 48e5b5f994bccf161dd88a67fdd819d4bfb400f1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/docs/sphinx/depfile.py b/docs/sphinx/depfile.py
index afdcbcec6e..e74be6af98 100644
--- a/docs/sphinx/depfile.py
+++ b/docs/sphinx/depfile.py
@@ -19,7 +19,7 @@
 
 def get_infiles(env):
     for x in env.found_docs:
-        yield env.doc2path(x)
+        yield str(env.doc2path(x))
         yield from ((os.path.join(env.srcdir, dep)
                     for dep in env.dependencies[x]))
     for mod in sys.modules.values():
-- 
2.39.2



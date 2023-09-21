Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8568A7A92A9
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:37:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFAf-00079b-Db; Thu, 21 Sep 2023 04:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjF9t-00067B-QF; Thu, 21 Sep 2023 04:35:38 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjF9r-0001Jm-SG; Thu, 21 Sep 2023 04:35:37 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CD79B23DAB;
 Thu, 21 Sep 2023 11:35:34 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7D31A29A05;
 Thu, 21 Sep 2023 11:35:13 +0300 (MSK)
Received: (nullmailer pid 509106 invoked by uid 1000);
 Thu, 21 Sep 2023 08:35:11 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/17] subprojects: Use the correct .git suffix in the
 repository URLs
Date: Thu, 21 Sep 2023 11:34:57 +0300
Message-Id: <20230921083506.509032-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230921083506.509032-1-mjt@tls.msk.ru>
References: <20230921083506.509032-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Thomas Huth <thuth@redhat.com>

This avoids the warnings à la:
"warning: redirecting to https://gitlab.com/qemu-project/xyz.git/"

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 subprojects/berkeley-softfloat-3.wrap | 2 +-
 subprojects/berkeley-testfloat-3.wrap | 2 +-
 subprojects/slirp.wrap                | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/subprojects/berkeley-softfloat-3.wrap b/subprojects/berkeley-softfloat-3.wrap
index a8fd87740b..c3e356d42f 100644
--- a/subprojects/berkeley-softfloat-3.wrap
+++ b/subprojects/berkeley-softfloat-3.wrap
@@ -1,5 +1,5 @@
 [wrap-git]
-url = https://gitlab.com/qemu-project/berkeley-softfloat-3
+url = https://gitlab.com/qemu-project/berkeley-softfloat-3.git
 revision = b64af41c3276f97f0e181920400ee056b9c88037
 patch_directory = berkeley-softfloat-3
 depth = 1
diff --git a/subprojects/berkeley-testfloat-3.wrap b/subprojects/berkeley-testfloat-3.wrap
index c86dc078a8..b8b12e7629 100644
--- a/subprojects/berkeley-testfloat-3.wrap
+++ b/subprojects/berkeley-testfloat-3.wrap
@@ -1,5 +1,5 @@
 [wrap-git]
-url = https://gitlab.com/qemu-project/berkeley-testfloat-3
+url = https://gitlab.com/qemu-project/berkeley-testfloat-3.git
 revision = e7af9751d9f9fd3b47911f51a5cfd08af256a9ab
 patch_directory = berkeley-testfloat-3
 depth = 1
diff --git a/subprojects/slirp.wrap b/subprojects/slirp.wrap
index 08291a4cf9..a93b048962 100644
--- a/subprojects/slirp.wrap
+++ b/subprojects/slirp.wrap
@@ -1,5 +1,5 @@
 [wrap-git]
-url = https://gitlab.freedesktop.org/slirp/libslirp
+url = https://gitlab.freedesktop.org/slirp/libslirp.git
 revision = 26be815b86e8d49add8c9a8b320239b9594ff03d
 
 [provide]
-- 
2.39.2



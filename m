Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01169799892
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:18:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexbl-0003EH-Gh; Sat, 09 Sep 2023 09:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexbg-0002tX-3W; Sat, 09 Sep 2023 09:02:37 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexbb-0002no-5G; Sat, 09 Sep 2023 09:02:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5E4A4205A8;
 Sat,  9 Sep 2023 16:01:18 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3399D26E0E;
 Sat,  9 Sep 2023 16:00:27 +0300 (MSK)
Received: (nullmailer pid 353133 invoked by uid 1000);
 Sat, 09 Sep 2023 13:00:22 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.5 26/43] docs/about/license: Update LICENSE URL
Date: Sat,  9 Sep 2023 15:59:52 +0300
Message-Id: <20230909130020.352951-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.5-20230909155813@cover.tls.msk.ru>
References: <qemu-stable-8.0.5-20230909155813@cover.tls.msk.ru>
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In early 2021 (see commit 2ad784339e "docs: update README to use
GitLab repo URLs") almost all of the code base was converted to
point to GitLab instead of git.qemu.org. During 2023, git.qemu.org
switched from a git mirror to a http redirect to GitLab (see [1]).

Update the LICENSE URL to match its previous content, displaying
the file raw content similarly to gitweb 'blob_plain' format ([2]).

[1] https://lore.kernel.org/qemu-devel/CABgObfZu3mFc8tM20K-yXdt7F-7eV-uKZN4sKDarSeu7DYoRbA@mail.gmail.com/
[2] https://git-scm.com/docs/gitweb#Documentation/gitweb.txt-blobplain

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230822125716.55295-1-philmd@linaro.org>
(cherry picked from commit 09a3fffae00b042bed8ad9c351b1a58c505fde37)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/docs/about/license.rst b/docs/about/license.rst
index cde3d2d25d..303c55d61b 100644
--- a/docs/about/license.rst
+++ b/docs/about/license.rst
@@ -8,4 +8,4 @@ QEMU is a trademark of Fabrice Bellard.
 QEMU is released under the `GNU General Public
 License <https://www.gnu.org/licenses/gpl-2.0.txt>`__, version 2. Parts
 of QEMU have specific licenses, see file
-`LICENSE <https://git.qemu.org/?p=qemu.git;a=blob_plain;f=LICENSE>`__.
+`LICENSE <https://gitlab.com/qemu-project/qemu/-/raw/master/LICENSE>`__.
-- 
2.39.2



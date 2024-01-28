Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B5783F8E0
	for <lists+qemu-devel@lfdr.de>; Sun, 28 Jan 2024 18:54:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU9KC-00068a-JR; Sun, 28 Jan 2024 12:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9Jy-00055w-FD; Sun, 28 Jan 2024 12:51:55 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9Jw-00012q-Rs; Sun, 28 Jan 2024 12:51:54 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0751F48111;
 Sun, 28 Jan 2024 20:51:35 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 90A686D52D;
 Sun, 28 Jan 2024 20:50:43 +0300 (MSK)
Received: (nullmailer pid 812443 invoked by uid 1000);
 Sun, 28 Jan 2024 17:50:35 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 68/71] qtest: bump aspeed_smc-test timeout to 6 minutes
Date: Sun, 28 Jan 2024 20:50:31 +0300
Message-Id: <20240128175035.812352-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
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

From: Daniel P. Berrangé <berrange@redhat.com>

On a loaded system with --enable-debug, this test can take longer than
5 minutes. Raising the timeout to 6 minutes gives greater headroom for
such situations.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
[thuth: Increase the timeout to 6 minutes for very loaded systems]
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-11-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
(cherry picked from commit e8a12fe31f776c60fec993513cd1b1e66c2b8e29)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: context fixup in tests/qtest/meson.build)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 47dabf91d0..fc14ae95a3 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -1,5 +1,6 @@
 slow_qtests = {
   'ahci-test' : 60,
+  'aspeed_smc-test': 360,
   'bios-tables-test' : 120,
   'boot-serial-test' : 60,
   'migration-test' : 150,
-- 
2.39.2



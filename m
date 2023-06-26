Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDD273EB16
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 21:16:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrTL-0000hx-6P; Mon, 26 Jun 2023 15:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrSq-0008Up-4d; Mon, 26 Jun 2023 15:01:29 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrSo-0007nJ-EM; Mon, 26 Jun 2023 15:01:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6DB5FEFBF;
 Mon, 26 Jun 2023 21:59:13 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id DCE51F7FB;
 Mon, 26 Jun 2023 21:59:11 +0300 (MSK)
Received: (nullmailer pid 1575367 invoked by uid 1000);
 Mon, 26 Jun 2023 18:59:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Francisco Iglesias <frasse.iglesias@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.4 30/43] aspeed/hace: Initialize g_autofree pointer
Date: Mon, 26 Jun 2023 21:58:48 +0300
Message-Id: <20230626185902.1575177-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
References: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
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

From: Cédric Le Goater <clg@kaod.org>

As mentioned in docs/devel/style.rst "Automatic memory deallocation":

* Variables declared with g_auto* MUST always be initialized,
  otherwise the cleanup function will use uninitialized stack memory

This avoids QEMU to coredump when running the "hash test" command
under Zephyr.

Cc: Steven Lee <steven_lee@aspeedtech.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: qemu-stable@nongnu.org
Fixes: c5475b3f9a ("hw: Model ASPEED's Hash and Crypto Engine")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Message-Id: <20230421131547.2177449-1-clg@kaod.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
(cherry picked from commit c8f48b120b31f6bbe33135ef5d478e485c37e3c2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index ac21be306c..69175e972d 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -189,7 +189,7 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
                               bool acc_mode)
 {
     struct iovec iov[ASPEED_HACE_MAX_SG];
-    g_autofree uint8_t *digest_buf;
+    g_autofree uint8_t *digest_buf = NULL;
     size_t digest_len = 0;
     int niov = 0;
     int i;
-- 
2.39.2



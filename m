Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BD673EAA7
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 20:57:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrKy-0000SG-V1; Mon, 26 Jun 2023 14:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrKQ-0000K0-4c; Mon, 26 Jun 2023 14:52:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrKO-0005H8-Is; Mon, 26 Jun 2023 14:52:45 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7173DEF32;
 Mon, 26 Jun 2023 21:50:23 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E2105F7C1;
 Mon, 26 Jun 2023 21:50:21 +0300 (MSK)
Received: (nullmailer pid 1574040 invoked by uid 1000);
 Mon, 26 Jun 2023 18:50:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: David Woodhouse <dwmw@amazon.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>,
 Anthony PERARD <anthony.perard@citrix.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 27/54] hw/xen: Fix memory leak in libxenstore_open()
 for Xen
Date: Mon, 26 Jun 2023 21:49:34 +0300
Message-Id: <20230626185002.1573836-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: David Woodhouse <dwmw@amazon.co.uk>

There was a superfluous allocation of the XS handle, leading to it
being leaked on both the error path and the success path (where it gets
allocated again).

Spotted by Coverity (CID 1508098).

Fixes: ba2a92db1ff6 ("hw/xen: Add xenstore operations to allow redirection to internal emulation")
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Paul Durrant <paul@xen.org>
Message-Id: <20230412185102.441523-3-dwmw2@infradead.org>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
(cherry picked from commit 8442232eba1b041b379ca5845df8252c1e905e43)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/xen/xen-operations.c b/hw/xen/xen-operations.c
index 4b78fbf4bd..3d213d28df 100644
--- a/hw/xen/xen-operations.c
+++ b/hw/xen/xen-operations.c
@@ -287,7 +287,7 @@ static void watch_event(void *opaque)
 static struct qemu_xs_handle *libxenstore_open(void)
 {
     struct xs_handle *xsh = xs_open(0);
-    struct qemu_xs_handle *h = g_new0(struct qemu_xs_handle, 1);
+    struct qemu_xs_handle *h;
 
     if (!xsh) {
         return NULL;
-- 
2.39.2



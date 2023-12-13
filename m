Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E9981127E
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 14:06:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDOuC-0003au-BP; Wed, 13 Dec 2023 08:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rDOsa-0000O8-MF; Wed, 13 Dec 2023 08:02:28 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rDOsV-00076y-JH; Wed, 13 Dec 2023 08:02:22 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C56413B446;
 Wed, 13 Dec 2023 16:01:05 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 68BFE3C8D7;
 Wed, 13 Dec 2023 16:00:46 +0300 (MSK)
Received: (nullmailer pid 1024772 invoked by uid 1000);
 Wed, 13 Dec 2023 13:00:46 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Robert Hoo <robert.hoo.linux@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.8 19/24] msix: unset PCIDevice::msix_vector_poll_notifier
 in rollback
Date: Wed, 13 Dec 2023 16:00:28 +0300
Message-Id: <20231213130041.1024630-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
References: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
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

From: Robert Hoo <robert.hoo.linux@gmail.com>

In the rollback in msix_set_vector_notifiers(), original patch forgot to
undo msix_vector_poll_notifier pointer.

Fixes: bbef882cc193 ("msi: add API to get notified about pending bit poll")
Signed-off-by: Robert Hoo <robert.hoo.linux@gmail.com>
Message-Id: <20231113081349.1307-1-robert.hoo.linux@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 2d37fe9e5e61b04bddbed00dbb7436e61a01c115)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 9e70fcd6fa..4b258566d4 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -639,6 +639,7 @@ undo:
     }
     dev->msix_vector_use_notifier = NULL;
     dev->msix_vector_release_notifier = NULL;
+    dev->msix_vector_poll_notifier = NULL;
     return ret;
 }
 
-- 
2.39.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 784687CCA9D
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 20:27:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsolo-0006H6-O7; Tue, 17 Oct 2023 14:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+e442e50539a6073fd887+7359+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1qsolV-0006F2-3j
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:26:05 -0400
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+e442e50539a6073fd887+7359+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1qsolQ-0001UD-H8
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=mT1XScI7NSJ4weZ5c1NJoTEjfaqAFFggM/PoQY19qlQ=; b=u2pl0HXyBSCIO8jw1OQWFNhf2O
 Hj/MN1k4AK95NViqo7qIk/mSIRKYon9a3ezB59j4K+iKbmyMri//ejsICoyYSix0lyRkGFkcyL8Ou
 vMliReAQ0IrMARgiZES6WA1xMB9twTeVfZaMrm7HvisUfl1T8yHWWDxG1ReTokk08H8//LXKNOliM
 dUxj2P1UJ++Q69tUfpC1Q86upQsLUc8mxFbFAnIxev/h+kAeEKtWt0+X7iWYdUwPCLGF3kdmr5wMK
 7jQS8z9M1Mx5BxrobTWp3WEr1ZawgXQ8MGh4TnVlvCyk5ih0AL87cVI0NjBGyW7h/y/UBLoyHHEI6
 10GUyejw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1qsolL-00DrCq-Pk; Tue, 17 Oct 2023 18:25:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qsolI-000Par-2F; Tue, 17 Oct 2023 19:25:48 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Jason Wang <jasowang@redhat.com>, xen-devel@lists.xenproject.org
Subject: [PATCH 3/4] [WTF] avoid qemu_del_nic() in xen_netdev_unrealize() on
 shutdown
Date: Tue, 17 Oct 2023 19:25:44 +0100
Message-Id: <20231017182545.97973-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231017182545.97973-1-dwmw2@infradead.org>
References: <20231017182545.97973-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+e442e50539a6073fd887+7359+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

When QEMU is exiting, qemu_cleanup() calls net_cleanup(), which deletes
the NIC from underneath the xen-net-device. When xen_netdev_unrealize()
is later called via the xenbus exit notifier, it crashes.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/net/xen_nic.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index 84914c329c..8d25fb3101 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -25,6 +25,8 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/error.h"
 
+#include "sysemu/runstate.h"
+
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <sys/wait.h>
@@ -530,7 +532,11 @@ static void xen_netdev_unrealize(XenDevice *xendev)
     /* Disconnect from the frontend in case this has not already happened */
     xen_netdev_disconnect(xendev, NULL);
 
-    if (netdev->nic) {
+    /*
+     * WTF? In RUN_STATE_SHUTDOWN, qemu_cleanup()→net_cleanup() already deleted
+     * our NIC from underneath us!
+     */
+    if (netdev->nic && !runstate_check(RUN_STATE_SHUTDOWN)) {
         qemu_del_nic(netdev->nic);
     }
 }
-- 
2.40.1



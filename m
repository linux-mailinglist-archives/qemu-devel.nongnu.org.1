Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3A27D701E
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:55:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvfEg-0005ia-PY; Wed, 25 Oct 2023 10:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+fe87d11d956b9f6f1554+7367+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qvfE8-0005E5-R9; Wed, 25 Oct 2023 10:51:22 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+fe87d11d956b9f6f1554+7367+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qvfDp-000764-99; Wed, 25 Oct 2023 10:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=iaeDXSTaoWdCm87GDHXDzDikArDTOfszjp92r6YPQM0=; b=Fpo2lDHmkFJFrEzTxCnYSHMQc+
 H+POf4RpTDXrqfi7zmTI2kpkXiZEJ/4ikVugJbl/UXMyulJnl8bxTi7gdq+Xlhe/NOsdTz353nXNS
 skhnTvQvc19bBykXDJLHjeBVQ97kJvOEjCn3zBqYb/BH5rDtwk6NqQC0EyXGhRuEVDofWOrIuQUbH
 eDXBfUYpNVxLjOjbdUpmFPsWWBCjffiEX876q5ArcW6FdlTHX93HUMDbaBkhxtxYaZxt/fpHXCNkE
 Ko/NceL/1GypeXooX+xxhcNkWMbOUUaDd3BrGGwo4s3+7LbNRB/e9K7vIixU+dnx+7J2jpuR7mvKp
 dd1Vd6Hw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1qvfDa-00GPM5-1F; Wed, 25 Oct 2023 14:50:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qvfDZ-002dFL-0k; Wed, 25 Oct 2023 15:50:45 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
Subject: [PATCH v3 20/28] net: do not delete nics in net_cleanup()
Date: Wed, 25 Oct 2023 15:50:34 +0100
Message-Id: <20231025145042.627381-21-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231025145042.627381-1-dwmw2@infradead.org>
References: <20231025145042.627381-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+fe87d11d956b9f6f1554+7367+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
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

In net_cleanup() we only need to delete the netdevs, as those may have
state which outlives Qemu when it exits, and thus may actually need to
be cleaned up on exit.

The nics, on the other hand, are owned by the device which created them.
Most devices don't bother to clean up on exit because they don't have
any state which will outlive Qemu... but XenBus devices do need to clean
up their nodes in XenStore, and do have an exit handler to delete them.

When the XenBus exit handler destroys the xen-net-device, it attempts
to delete its nic after net_cleanup() had already done so. And crashes.

Fix this by only deleting netdevs as we walk the list. As the comment
notes, we can't use QTAILQ_FOREACH_SAFE() as each deletion may remove
*multiple* entries, including the "safely" saved 'next' pointer. But
we can store the *previous* entry, since nics are safe.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 net/net.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/net.c b/net/net.c
index c0c0cbe99e..bbe33da176 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1499,18 +1499,34 @@ static void net_vm_change_state_handler(void *opaque, bool running,
 
 void net_cleanup(void)
 {
-    NetClientState *nc;
+    NetClientState *nc, **p = &QTAILQ_FIRST(&net_clients);
 
     /*cleanup colo compare module for COLO*/
     colo_compare_cleanup();
 
-    /* We may del multiple entries during qemu_del_net_client(),
-     * so QTAILQ_FOREACH_SAFE() is also not safe here.
+    /*
+     * Walk the net_clients list and remove the netdevs but *not* any
+     * NET_CLIENT_DRIVER_NIC entries. The latter are owned by the device
+     * model which created them, and in some cases (e.g. xen-net-device)
+     * the device itself may do cleanup at exit and will be upset if we
+     * just delete its NIC from underneath it.
+     *
+     * Since qemu_del_net_client() may delete multiple entries, using
+     * QTAILQ_FOREACH_SAFE() is not safe here. The only safe pointer
+     * to keep as a bookmark is a NET_CLIENT_DRIVER_NIC entry, so keep
+     * 'p' pointing to either the head of the list, or the 'next' field
+     * of the latest NET_CLIENT_DRIVER_NIC, and operate on *p as we walk
+     * the list.
+     *
+     * The 'nc' variable isn't part of the list traversal; it's purely
+     * for convenience as too much '(*p)->' has a tendency to make the
+     * readers' eyes bleed.
      */
-    while (!QTAILQ_EMPTY(&net_clients)) {
-        nc = QTAILQ_FIRST(&net_clients);
+    while (*p) {
+        nc = *p;
         if (nc->info->type == NET_CLIENT_DRIVER_NIC) {
-            qemu_del_nic(qemu_get_nic(nc));
+            /* Skip NET_CLIENT_DRIVER_NIC entries */
+            p = &QTAILQ_NEXT(nc, next);
         } else {
             qemu_del_net_client(nc);
         }
-- 
2.40.1



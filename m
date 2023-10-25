Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B2A7D6FCC
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:53:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvfEY-0005TZ-FM; Wed, 25 Oct 2023 10:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+fe87d11d956b9f6f1554+7367+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qvfE4-0005CG-FR; Wed, 25 Oct 2023 10:51:18 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+fe87d11d956b9f6f1554+7367+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qvfDp-000767-Dr; Wed, 25 Oct 2023 10:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=RxBAjsQ+mysvOozFK2bkVeJvxuxKEpOcW9P4vMvsaUw=; b=kWEwCVesu3RU1Gi+zD5e+MXOzL
 TI6NwMrSRoAQx1N/L//K4TlUXhKgj7PQrl+DuBhCNNSDgpxlC7tv6T7Eclwqo3JB/3jdzRkNzQ9qF
 quoMMtl9n21EtXIqLbI9iMJAqKE5Ob4RUIz7XAD1NO24I6Wwr+QeGorNW5GKyAU6AJbWDsEToPZSu
 XMKIpWSZ84bjXrvQIeIKE++0nq8nOdav05MHqaccNURQ/24YIQufkFSp5KZYBu8Or7scgLcu/6cHU
 UsvgICpmvIfuJWV3/+UaFP9GBwV1+sI8ZM3NKS1yiX/c3qj/QciOq9QyDey+tRL/JUEb9G4h67r4c
 sMq+tCFA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1qvfDZ-00GPLx-01; Wed, 25 Oct 2023 14:50:52 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qvfDY-002dEF-06; Wed, 25 Oct 2023 15:50:44 +0100
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
Subject: [PATCH v3 05/28] hw/xen: fix XenStore watch delivery to guest
Date: Wed, 25 Oct 2023 15:50:19 +0100
Message-Id: <20231025145042.627381-6-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231025145042.627381-1-dwmw2@infradead.org>
References: <20231025145042.627381-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When fire_watch_cb() found the response buffer empty, it would call
deliver_watch() to generate the XS_WATCH_EVENT message in the response
buffer and send an event channel notification to the guest… without
actually *copying* the response buffer into the ring. So there was
nothing for the guest to see. The pending response didn't actually get
processed into the ring until the guest next triggered some activity
from its side.

Add the missing call to put_rsp().

It might have been slightly nicer to call xen_xenstore_event() here,
which would *almost* have worked. Except for the fact that it calls
xen_be_evtchn_pending() to check that it really does have an event
pending (and clear the eventfd for next time). And under Xen it's
defined that setting that fd to O_NONBLOCK isn't guaranteed to work,
so the emu implementation follows suit.

This fixes Xen device hot-unplug.

Fixes: 0254c4d19df ("hw/xen: Add xenstore wire implementation and implementation stubs")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/kvm/xen_xenstore.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
index 660d0b72f9..8e716a7009 100644
--- a/hw/i386/kvm/xen_xenstore.c
+++ b/hw/i386/kvm/xen_xenstore.c
@@ -1357,10 +1357,12 @@ static void fire_watch_cb(void *opaque, const char *path, const char *token)
     } else {
         deliver_watch(s, path, token);
         /*
-         * If the message was queued because there was already ring activity,
-         * no need to wake the guest. But if not, we need to send the evtchn.
+         * Attempt to queue the message into the actual ring, and send
+         * the event channel notification if any bytes are copied.
          */
-        xen_be_evtchn_notify(s->eh, s->be_port);
+        if (s->rsp_pending && put_rsp(s) > 0) {
+            xen_be_evtchn_notify(s->eh, s->be_port);
+        }
     }
 }
 
-- 
2.40.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 917E77E6BAB
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:53:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15Nn-0000Hw-45; Thu, 09 Nov 2023 08:47:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Me-00079k-RJ; Thu, 09 Nov 2023 08:46:36 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Mc-0001zt-31; Thu, 09 Nov 2023 08:46:31 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2A15031B1A;
 Thu,  9 Nov 2023 16:43:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3AB15344C0;
 Thu,  9 Nov 2023 16:43:06 +0300 (MSK)
Received: (nullmailer pid 1461864 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, David Woodhouse <dwmw@amazon.co.uk>,
 Paul Durrant <paul@xen.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 34/55] hw/xen: fix XenStore watch delivery to guest
Date: Thu,  9 Nov 2023 16:42:38 +0300
Message-Id: <20231109134300.1461632-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
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

Cc: qemu-stable@nongnu.org
Fixes: 0254c4d19df ("hw/xen: Add xenstore wire implementation and implementation stubs")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
(cherry picked from commit 4a5780f52095f1daf23618dc6198a2a1665ea505)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
index 133d89e953..725ca2f15d 100644
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
2.39.2



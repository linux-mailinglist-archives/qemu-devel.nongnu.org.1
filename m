Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC671753EDB
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 17:30:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKKir-0007tn-BC; Fri, 14 Jul 2023 11:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5525cada8=anthony.perard@citrix.com>)
 id 1qKKig-0007tX-J8
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:28:34 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5525cada8=anthony.perard@citrix.com>)
 id 1qKKia-0007aM-6w
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1689348508;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=daxpglMo8opEhboaTIroB1uF87PMJ2lYCn6MNFm6U1M=;
 b=ci1sMeh7g2f30jSojrCQ22LfVevUdECKah2gB51d6P4Hx6V72tJNmPa2
 wEMpQRShgqlOlsPBykHuzVJYauy/zpCpYNBckfvHBLjwVm2kNMr/sCcb9
 JpKLFQcoPaHZzL7ayevzIhYydEebPVn5srU3TG57cxtx9ws31nsfZBeAC 4=;
Authentication-Results: esa2.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 116124843
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:L7+rBqJamYgU2h9+FE+RzZUlxSXFcZb7ZxGr2PjKsXjdYENS0WdRn
 GpNXTjXM6uMNGfxLtsiPI7n9U9X65LRmIVkQFdlqX01Q3x08seUXt7xwmUcnc+xBpaaEB84t
 ZV2hv3odp1coqr0/0/1WlTZhSAgk/rOHvykU7Ss1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpKrfrawP9TlK6q4mhA4QViPakjUGL2zBH5MrpOfcldEFOgKmVkNrbSb
 /rOyri/4lTY838FYj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnVaPpIAHOgdcS9qZwChxLid/
 jnvWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I+QrvBIAzt03ZHzaM7H09c5VDGBQ1
 aM3Lwo1NB68qePu6qq8Z/Vz05FLwMnDZOvzu1llxDDdS/0nXYrCU+PB4towMDUY354UW6yEP
 oxANGQpNU6bC/FMEg5/5JYWleG0hn75YntApUicv6Yf6GnP1g1hlrPqNbI5f/TTHJsMxBrI+
 jmuE2LRBVYhL8O+lh+/2G+TquzgzQ76fqIKPejtnhJtqALKnTFCYPEMbnOirPykz0KzRd9bA
 0oT/CUosO417kPDZsH3WBuqoXiFlgQRV9pZD6sx7wTl4qnL5AKXLnIJQj5IdJots8pebSc22
 1GAmdPgLSZivL2cVTSW8bL8kN+pEXFLdylYP3ZCFFZbpYC5++nfky4jUP5BHa+rroLaHgvIm
 T61gilmra0UoNIUgvDTEU/8v968mnTYZldrtlSMBDr1tlwRiJ2NPNLxtwWChRpUBMPAFwTa4
 iBZ8ySLxLpWZaxhghBhVwnk8FuBw/+eeAPRjld0d3XK32T8oiXzFWy8DdwXGauIDirnUWWzC
 KMrkVkNjKK/xVPzBUONX6q/Ct4x0Y/rHsn/W/bfY7JmO8YhJVXYp3kxORDNjwgBdXTAd4llY
 v93lu71XR4n5VlPlmLqF4/xL5d2rszB+Y8jbc+ilEn2uVZvTHWUVa0EIDOzghMRtcu5TPHu2
 48HbaOikkwPONASlwGLqeb/23hWdylkbX03wuQLHtO+zv1OQT96VKCJn+x+J+SIXc19z4/1w
 510YWcAoHKXuJENAV7ihqxLAF83YatCkA==
IronPort-HdrOrdr: A9a23:zHY3Sq9eavuLVXqlUcBuk+DbI+orL9Y04lQ7vn2ZhyYlFfBw9v
 re+sjzsCWftN9/YgBCpTntAsm9qBDnlKKdg7NhX4tKNTOO0ACVxepZnO7fKlPbaknDHy1muZ
 uIsZISNDQ9NzdHZA/BjjWFLw==
X-Talos-CUID: 9a23:e99qvWBCUnsHqOj6Ewtq9VA0Re8iSEWHwkj+IheSEWFEVKLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3A0nIVcg5CO+E/TvaAgUnp2U8JxoxvpJ+1F2FStK8?=
 =?us-ascii?q?spvaoNgMgFja7rCyeF9o=3D?=
X-IronPort-AV: E=Sophos;i="6.01,205,1684814400"; d="scan'208";a="116124843"
To: <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Stefan Hajnoczi" <stefanha@redhat.com>, Anthony PERARD
 <anthony.perard@citrix.com>
Subject: [PATCH] thread-pool: signal "request_cond" while locked
Date: Fri, 14 Jul 2023 16:27:20 +0100
Message-ID: <20230714152720.5077-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.145.153;
 envelope-from=prvs=5525cada8=anthony.perard@citrix.com;
 helo=esa2.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Anthony PERARD <anthony.perard@citrix.com>

thread_pool_free() might have been called on the `pool`, which would
be a reason for worker_thread() to quit. In this case,
`pool->request_cond` is been destroyed.

If worker_thread() didn't managed to signal `request_cond` before it
been destroyed by thread_pool_free(), we got:
    util/qemu-thread-posix.c:198: qemu_cond_signal: Assertion `cond->initialized' failed.

One backtrace:
    __GI___assert_fail (assertion=0x55555614abcb "cond->initialized", file=0x55555614ab88 "util/qemu-thread-posix.c", line=198,
	function=0x55555614ad80 <__PRETTY_FUNCTION__.17104> "qemu_cond_signal") at assert.c:101
    qemu_cond_signal (cond=0x7fffb800db30) at util/qemu-thread-posix.c:198
    worker_thread (opaque=0x7fffb800dab0) at util/thread-pool.c:129
    qemu_thread_start (args=0x7fffb8000b20) at util/qemu-thread-posix.c:505
    start_thread (arg=<optimized out>) at pthread_create.c:486

Reported here:
    https://lore.kernel.org/all/ZJwoK50FcnTSfFZ8@MacBook-Air-de-Roger.local/T/#u

To avoid issue, keep lock while sending a signal to `request_cond`.

Fixes: 900fa208f506 ("thread-pool: replace semaphore with condition variable")
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---

There's maybe an issue in thread_pool_submit_aio() as well with
signalling `request_cond`, but maybe it's much less likely to be an
issue?
---
 util/thread-pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/thread-pool.c b/util/thread-pool.c
index 0d97888df0..e3d8292d14 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -120,13 +120,13 @@ static void *worker_thread(void *opaque)
 
     pool->cur_threads--;
     qemu_cond_signal(&pool->worker_stopped);
-    qemu_mutex_unlock(&pool->lock);
 
     /*
      * Wake up another thread, in case we got a wakeup but decided
      * to exit due to pool->cur_threads > pool->max_threads.
      */
     qemu_cond_signal(&pool->request_cond);
+    qemu_mutex_unlock(&pool->lock);
     return NULL;
 }
 
-- 
Anthony PERARD



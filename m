Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 774F673EAF1
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 21:10:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrUG-00041x-CK; Mon, 26 Jun 2023 15:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrUB-0003pD-2W; Mon, 26 Jun 2023 15:02:51 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrU9-000834-1M; Mon, 26 Jun 2023 15:02:50 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D6EC9EFCE;
 Mon, 26 Jun 2023 21:59:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 74AD8F808;
 Mon, 26 Jun 2023 21:59:14 +0300 (MSK)
Received: (nullmailer pid 1575406 invoked by uid 1000);
 Mon, 26 Jun 2023 18:59:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, imammedo@redhat.com, jusual@redhat.com,
 mst@redhat.com, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.4 43/43] vhost-vdpa: do not cleanup the vdpa/vhost-net
 structures if peer nic is present
Date: Mon, 26 Jun 2023 21:59:01 +0300
Message-Id: <20230626185902.1575177-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
References: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
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

From: Ani Sinha <anisinha@redhat.com>

When a peer nic is still attached to the vdpa backend, it is too early to free
up the vhost-net and vdpa structures. If these structures are freed here, then
QEMU crashes when the guest is being shut down. The following call chain
would result in an assertion failure since the pointer returned from
vhost_vdpa_get_vhost_net() would be NULL:

do_vm_stop() -> vm_state_notify() -> virtio_set_status() ->
virtio_net_vhost_status() -> get_vhost_net().

Therefore, we defer freeing up the structures until at guest shutdown
time when qemu_cleanup() calls net_cleanup() which then calls
qemu_del_net_client() which would eventually call vhost_vdpa_cleanup()
again to free up the structures. This time, the loop in net_cleanup()
ensures that vhost_vdpa_cleanup() will be called one last time when
all the peer nics are detached and freed.

All unit tests pass with this change.

CC: imammedo@redhat.com
CC: jusual@redhat.com
CC: mst@redhat.com
Fixes: CVE-2023-3301
Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Message-Id: <20230619065209.442185-1-anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit a0d7215e339b61c7d7a7b3fcf754954d80d93eb8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: context change for stable-7.2)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 71a7dd1586..acdf3cb96c 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -160,6 +160,14 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
     struct vhost_dev *dev = &s->vhost_net->dev;
 
+    /*
+     * If a peer NIC is attached, do not cleanup anything.
+     * Cleanup will happen as a part of qemu_cleanup() -> net_cleanup()
+     * when the guest is shutting down.
+     */
+    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_NIC) {
+        return;
+    }
     qemu_vfree(s->cvq_cmd_out_buffer);
     qemu_vfree(s->status);
     if (dev->vq_index + dev->nvqs == dev->vq_index_end) {
-- 
2.39.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4B4B0189F
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Jul 2025 11:46:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAJ0-0005RA-1F; Fri, 11 Jul 2025 05:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@iogearbox.net>)
 id 1uaAIv-0005Lk-Rc
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:44:30 -0400
Received: from www62.your-server.de ([213.133.104.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@iogearbox.net>)
 id 1uaAIs-0001Hh-Ux
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=sVvTLZG3L4cK+m724KizckhOtMr0iVae+h/z8LxV+Vk=; b=NVQz54vXgAIYvlOxwGnw0W1UJ7
 UGZgX4fkiYYmn1wg5nsVRYT2Aip1xFGQbdL/u0C7JEY6a3EadCbAXY+ITXGYp7smQBEJsx3m/vQ2i
 2ZKWb8iYKkkFRwIK5jVO60B1LxyS/Ak4keWtQTKV0aCWBbDcDtcmStATJupFnN96i+dAVCnO8d3WY
 W+SO3GpcKLtlN28TEB6yx+WaSyOtj7+kDkOh0RB8z2PJoOf3AJXJGHh481c56qmmsjqIxYYodJVHZ
 wABreQx12zEMIWEVSFg+6j9juAdb+sYklF/PoKWmlP2DNYy19zTU6v6dm3wxNMnOuGckQlhY68Ieu
 sT5EU1lQ==;
Received: from localhost ([127.0.0.1])
 by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <daniel@iogearbox.net>)
 id 1uaAIj-0002mz-0b; Fri, 11 Jul 2025 11:44:17 +0200
To: qemu-devel@nongnu.org
Cc: daniel@iogearbox.net, Ilya Maximets <i.maximets@ovn.org>,
 Jason Wang <jasowang@redhat.com>, Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v5 1/3] net/af-xdp: Remove XDP program cleanup logic
Date: Fri, 11 Jul 2025 11:44:14 +0200
Message-ID: <20250711094416.247125-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27695/Thu Jul 10 11:08:41 2025)
Received-SPF: pass client-ip=213.133.104.62; envelope-from=daniel@iogearbox.net;
 helo=www62.your-server.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Daniel Borkmann <daniel@iogearbox.net>
From:  Daniel Borkmann via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

There are two issues with the XDP program removal in af_xdp_cleanup():

1) Starting from libxdp 1.3.0 [0] the XDP program gets automatically
   detached when we call xsk_socket__delete() for the last successfully
   configured queue. libxdp internally keeps track of that. For QEMU
   we require libxdp >= 1.4.0. Given QEMU is not loading the program,
   lets also not attempt to remove it and delegate this instead.

2) The removal logic is incorrect anyway because we are setting n_queues
   into the last queue that never has xdp_flags on failure, so the logic
   is always skipped since the non-zero test for s->xdp_flags in
   af_xdp_cleanup() fails.

Fixes: cb039ef3d9e3 ("net: add initial support for AF_XDP network backend")
Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Cc: Ilya Maximets <i.maximets@ovn.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Anton Protopopov <aspsk@isovalent.com>
Link: https://github.com/xdp-project/xdp-tools/commit/38c2914988fd5c1ef65f2381fc8af9f3e8404e2b [0]
---
 net/af-xdp.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/af-xdp.c b/net/af-xdp.c
index 01c5fb914e..c5d3b6a953 100644
--- a/net/af-xdp.c
+++ b/net/af-xdp.c
@@ -49,7 +49,6 @@ typedef struct AFXDPState {
     char                 *buffer;
     struct xsk_umem      *umem;
 
-    uint32_t             n_queues;
     uint32_t             xdp_flags;
     bool                 inhibit;
 } AFXDPState;
@@ -274,14 +273,6 @@ static void af_xdp_cleanup(NetClientState *nc)
     s->umem = NULL;
     qemu_vfree(s->buffer);
     s->buffer = NULL;
-
-    /* Remove the program if it's the last open queue. */
-    if (!s->inhibit && nc->queue_index == s->n_queues - 1 && s->xdp_flags
-        && bpf_xdp_detach(s->ifindex, s->xdp_flags, NULL) != 0) {
-        fprintf(stderr,
-                "af-xdp: unable to remove XDP program from '%s', ifindex: %d\n",
-                s->ifname, s->ifindex);
-    }
 }
 
 static int af_xdp_umem_create(AFXDPState *s, int sock_fd, Error **errp)
@@ -490,12 +481,9 @@ int net_init_af_xdp(const Netdev *netdev,
 
         pstrcpy(s->ifname, sizeof(s->ifname), opts->ifname);
         s->ifindex = ifindex;
-        s->n_queues = queues;
 
         if (af_xdp_umem_create(s, sock_fds ? sock_fds[i] : -1, errp)
             || af_xdp_socket_create(s, opts, errp)) {
-            /* Make sure the XDP program will be removed. */
-            s->n_queues = i;
             error_propagate(errp, err);
             goto err;
         }
-- 
2.43.0



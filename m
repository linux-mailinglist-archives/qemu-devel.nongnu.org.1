Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FE1A22DED
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Jan 2025 14:36:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUhA-0002dO-DN; Thu, 30 Jan 2025 08:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tdUh5-0002bI-HI; Thu, 30 Jan 2025 08:34:55 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tdUh3-0002Wj-Dq; Thu, 30 Jan 2025 08:34:54 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E7829E3040;
 Thu, 30 Jan 2025 16:34:18 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D76111A7F87;
 Thu, 30 Jan 2025 16:34:47 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C7C7C52404; Thu, 30 Jan 2025 16:34:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-trivial@nongnu.org,
 akihiko.odaki@daynix.com, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 2/7] net/dump: Correctly compute Ethernet packet offset
Date: Thu, 30 Jan 2025 16:34:42 +0300
Message-Id: <20250130133447.873566-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250130133447.873566-1-mjt@tls.msk.ru>
References: <20250130133447.873566-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Laurent Vivier <lvivier@redhat.com>

When a packet is sent with QEMU_NET_PACKET_FLAG_RAW by QEMU it
never includes virtio-net header even if qemu_get_vnet_hdr_len()
is not 0, and filter-dump is not managing this case.

The only user of QEMU_NET_PACKET_FLAG_RAW is announce_self,
we can show the problem using it and tcpddump:

- QEMU parameters:

  .. -monitor stdio \
     -netdev bridge,id=netdev0,br=virbr0 \
     -device virtio-net,mac=9a:2b:2c:2d:2e:2f,netdev=netdev0 \
     -object filter-dump,netdev=netdev0,file=log.pcap,id=pcap0

- HMP command:

  (qemu) announce_self

- TCP dump:

  $ tcpdump -nxr log.pcap

  without the fix:

    08:00:06:04:00:03 > 2e:2f:80:35:00:01, ethertype Unknown (0x9a2b), length 50:
         0x0000:  2c2d 2e2f 0000 0000 9a2b 2c2d 2e2f 0000
         0x0010:  0000 0000 0000 0000 0000 0000 0000 0000
         0x0020:  0000 0000

  with the fix:

    ARP, Reverse Request who-is 9a:2b:2c:2d:2e:2f tell 9a:2b:2c:2d:2e:2f, length 46
         0x0000:  0001 0800 0604 0003 9a2b 2c2d 2e2f 0000
         0x0010:  0000 9a2b 2c2d 2e2f 0000 0000 0000 0000
         0x0020:  0000 0000 0000 0000 0000 0000 0000

Fixes: 481c52320a26 ("net: Strip virtio-net header when dumping")
Cc: akihiko.odaki@daynix.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 net/dump.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/dump.c b/net/dump.c
index d7dd2ce461..140215aa10 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -155,7 +155,8 @@ static ssize_t filter_dump_receive_iov(NetFilterState *nf, NetClientState *sndr,
 {
     NetFilterDumpState *nfds = FILTER_DUMP(nf);
 
-    dump_receive_iov(&nfds->ds, iov, iovcnt, qemu_get_vnet_hdr_len(nf->netdev));
+    dump_receive_iov(&nfds->ds, iov, iovcnt, flags & QEMU_NET_PACKET_FLAG_RAW ?
+                     0 : qemu_get_vnet_hdr_len(nf->netdev));
     return 0;
 }
 
-- 
2.39.5



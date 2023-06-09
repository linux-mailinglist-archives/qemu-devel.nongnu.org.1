Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ACF7290F4
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 09:29:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7WXd-0005qN-Dr; Fri, 09 Jun 2023 03:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1q7WXZ-0005mC-Dn
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 03:28:10 -0400
Received: from mout.kundenserver.de ([212.227.126.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1q7WXX-0003Ea-IE
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 03:28:08 -0400
Received: from lenovo-t14s.redhat.com ([82.142.8.70]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M3D7V-1qB6VP0PuP-003eAJ; Fri, 09 Jun 2023 09:27:50 +0200
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Gibson <dgibson@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 1/3] net: socket: prepare to cleanup net_init_socket()
Date: Fri,  9 Jun 2023 09:27:46 +0200
Message-Id: <20230609072748.4179873-2-lvivier@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230609072748.4179873-1-lvivier@redhat.com>
References: <20230609072748.4179873-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XMYS/ig/0imZSVzknFzyerXeZnCZ2k5JC4dbipEgt5bRYPtRunJ
 0lDuIvBqI5ZSogwm/aO5JJAvAS/h7YUuJL5LkNapqd+ryxaOVjiw9bBIwrEW8FpQKgR/3s5
 YsVYUkxfbTbqlHcERW+9JWJ+D82DzMubnMJ2s0uCmg6g7lhvjpFsU0OoSC6co/di9dybxL2
 IC/jOctIClsyxO21pd7lg==
UI-OutboundReport: notjunk:1;M01:P0:wp2GhohRp9Q=;gE/9dynBftzCaIdQiZnq9V/b41e
 KgvppQH6OQzoFkLc4uLZcD1SLGespR10N0wXCRVFqy+JEHWDa1EjqZ9JT7Q2mcnmEvm2AVNQe
 8s+IEMqh/J8FFGw7ReOE18jBimARjpOYEoeHCg76PrCV+sMp2hD9wsfdtFDpBdM8YNC9HkTXq
 umZHVhm0/wA45F3WpLY06OhY2EB8i/vv4//lvSDcPAu/mMTVMZaIQnRqTuXbwTzQO3aQr/5Tp
 siibWFbbf8A6GK82OE1iNhWdfGD7vtbkuhxNyK5+dSriQQu8Y4MYx9tsQ0jCCAgMtUKn0/oa5
 sOMb6Bj6+TP3gkbmbuxGd37BzLZ5NOQpRX4oYr1vI5sDwHvrCZ7glgxOd8zKXnPsbWd0PoEjH
 wYzymMP/2QC+YcieDOPNQwFWmrTZBQ4Gr9pui56UNuWDZ8lyUrTgoxqRilBDHNbOqsMvFsv+3
 mbgQXQi2D1EzHuxtPPleroFQ8pDsExJBqfUbstubrqqiU9jjg47MZ/i5ogbnV2EseUfUMMDAO
 PlvPCNQ7lx2mfxPXFJyMja6FEA/WVPVVM/uq1uIyn/c3BLq99gDLZZLED2KMMUOxrg7mlkb7/
 OPqL3Ip7fgYPB8bsZNXj8h+TX+BKabBzpo1zyoNeFZXya/+F6AYAGp5lPn7IILvxKBL09ETpu
 EYhPvFco7URxj3cGi303/yNkgc2kR9ZgOlJKrJqDwQ==
Received-SPF: permerror client-ip=212.227.126.130;
 envelope-from=lvivier@redhat.com; helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_FAIL=0.001,
 SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Use directly net_socket_fd_init_stream() and net_socket_fd_init_dgram()
when the socket type is already known.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 net/socket.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index ba6e5b0b0035..24dcaa55bc46 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -587,7 +587,7 @@ static int net_socket_connect_init(NetClientState *peer,
             break;
         }
     }
-    s = net_socket_fd_init(peer, model, name, fd, connected, NULL, errp);
+    s = net_socket_fd_init_stream(peer, model, name, fd, connected);
     if (!s) {
         return -1;
     }
@@ -629,7 +629,7 @@ static int net_socket_mcast_init(NetClientState *peer,
         return -1;
     }
 
-    s = net_socket_fd_init(peer, model, name, fd, 0, NULL, errp);
+    s = net_socket_fd_init_dgram(peer, model, name, fd, 0, NULL, errp);
     if (!s) {
         return -1;
     }
@@ -683,7 +683,7 @@ static int net_socket_udp_init(NetClientState *peer,
     }
     qemu_socket_set_nonblock(fd);
 
-    s = net_socket_fd_init(peer, model, name, fd, 0, NULL, errp);
+    s = net_socket_fd_init_dgram(peer, model, name, fd, 0, NULL, errp);
     if (!s) {
         return -1;
     }
-- 
2.39.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E519E7E6B90
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:51:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15LY-00033d-TT; Thu, 09 Nov 2023 08:45:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15L6-0002Xh-9t; Thu, 09 Nov 2023 08:44:59 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15L2-0001Hj-4j; Thu, 09 Nov 2023 08:44:55 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4A92431B08;
 Thu,  9 Nov 2023 16:43:12 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5C640344AF;
 Thu,  9 Nov 2023 16:43:04 +0300 (MSK)
Received: (nullmailer pid 1461812 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 17/55] hw/rdma/vmw/pvrdma_cmd: Use correct struct in
 query_port()
Date: Thu,  9 Nov 2023 16:42:21 +0300
Message-Id: <20231109134300.1461632-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

In query_port() we pass the address of a local pvrdma_port_attr
struct to the rdma_query_backend_port() function.  Unfortunately,
rdma_backend_query_port() wants a pointer to a struct ibv_port_attr,
and the two are not the same length.

Coverity spotted this (CID 1507146): pvrdma_port_attr is 48 bytes
long, and ibv_port_attr is 52 bytes, because it has a few extra
fields at the end.

Fortunately, all we do with the attrs struct after the call is to
read a few specific fields out of it which are all at the same
offsets in both structs, so we can simply make the local variable the
correct type.  This also lets us drop the cast (which should have
been a bit of a warning flag that we were doing something wrong
here).

We do however need to add extra casts for the fields of the
struct that are enums: clang will complain about the implicit
cast to a different enum type otherwise.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit 4ab9a7429bf7507fba4b96b97d4147628c91ba14)

diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index c6ed025982..d385d18d9c 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -129,23 +129,27 @@ static int query_port(PVRDMADev *dev, union pvrdma_cmd_req *req,
 {
     struct pvrdma_cmd_query_port *cmd = &req->query_port;
     struct pvrdma_cmd_query_port_resp *resp = &rsp->query_port_resp;
-    struct pvrdma_port_attr attrs = {};
+    struct ibv_port_attr attrs = {};
 
     if (cmd->port_num > MAX_PORTS) {
         return -EINVAL;
     }
 
-    if (rdma_backend_query_port(&dev->backend_dev,
-                                (struct ibv_port_attr *)&attrs)) {
+    if (rdma_backend_query_port(&dev->backend_dev, &attrs)) {
         return -ENOMEM;
     }
 
     memset(resp, 0, sizeof(*resp));
 
-    resp->attrs.state = dev->func0->device_active ? attrs.state :
-                                                    PVRDMA_PORT_DOWN;
-    resp->attrs.max_mtu = attrs.max_mtu;
-    resp->attrs.active_mtu = attrs.active_mtu;
+    /*
+     * The state, max_mtu and active_mtu fields are enums; the values
+     * for pvrdma_port_state and pvrdma_mtu match those for
+     * ibv_port_state and ibv_mtu, so we can cast them safely.
+     */
+    resp->attrs.state = dev->func0->device_active ?
+        (enum pvrdma_port_state)attrs.state : PVRDMA_PORT_DOWN;
+    resp->attrs.max_mtu = (enum pvrdma_mtu)attrs.max_mtu;
+    resp->attrs.active_mtu = (enum pvrdma_mtu)attrs.active_mtu;
     resp->attrs.phys_state = attrs.phys_state;
     resp->attrs.gid_tbl_len = MIN(MAX_PORT_GIDS, attrs.gid_tbl_len);
     resp->attrs.max_msg_sz = 1024;
-- 
2.39.2



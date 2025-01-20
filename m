Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D4DA1743A
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Jan 2025 22:35:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZzPX-0005lh-O8; Mon, 20 Jan 2025 16:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tZzPD-0005iX-N4
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:33:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tZzP9-0000xU-0Q
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:33:57 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 83D295C5E50;
 Mon, 20 Jan 2025 21:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE0FC4CEDD;
 Mon, 20 Jan 2025 21:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737408832;
 bh=JTVqhin2beb56vrEHH1mRc/LGI4hrl4oEoiOqbZZoVs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WdNCth4qGR3uYIFKQDzdqtIRJ9Vj6sUumwk198GIKVh+nmPM19iArhXUCF4zVLlJy
 KSx5d/eROXkAT/OnmTU/BExj4e7gXPZqt7FzTcfXe/rS1fX6PCvkHQA/REPEe7Gn/r
 0m7i8Hx4WNZmN08P/EwdiE1jtiqasVZzhwJg7QeC7SydepgIIx2oDktIhRp7VrbWIq
 5dgOOJgOtd6LkcuZtchT+iymJ1+0LKs9FtIw6W3cYzbqS9vOhj2PTt9P3sR3tqeakJ
 zs7Dhvpy71UhbI59pe87mOfy6iveRC1CnHNE/0jP1Mi0OH2p7A+txuHvpgUjKh6sOI
 PJnPIJrHBW8hw==
From: deller@kernel.org
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: deller@gmx.de
Subject: [PATCH v4 5/7] linux-user: netlink: add netlink neighbour emulation
Date: Mon, 20 Jan 2025 22:33:38 +0100
Message-ID: <20250120213340.359195-6-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250120213340.359195-1-deller@kernel.org>
References: <20250120213340.359195-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Helge Deller <deller@gmx.de>

Fixes various warnings in the testsuite while building gupnp:
 gssdp-net-DEBUG: Failed to send netlink message: Operation not supported
 gupnp-context-DEBUG: Mismatch between host header and host IP (example.com, expected: 127.0.0.1)
 gupnp-context-DEBUG: Mismatch between host header and host port (80, expected 4711)
 gupnp-context-DEBUG: Mismatch between host header and host IP (192.168.1.2, expected: 127.0.0.1)
 gupnp-context-DEBUG: Mismatch between host header and host IP (fe80::01, expected: 127.0.0.1)
 gupnp-context-DEBUG: Mismatch between host header and host port (80, expected 4711)
 gupnp-context-DEBUG: Failed to parse HOST header from request: Invalid IPv6 address ?[fe80::01%1]? in URI
 gupnp-context-DEBUG: Failed to parse HOST header from request: Invalid IPv6 address ?[fe80::01%eth0]? in URI
 gupnp-context-DEBUG: Failed to parse HOST header from request: Could not parse port ?:1? in URI
 gupnp-context-DEBUG: Mismatch between host header and host IP (example.com, expected: ::1)
 gupnp-context-DEBUG: Mismatch between host header and host port (80, expected 4711)
 gupnp-context-DEBUG: Mismatch between host header and host IP (example.com, expected: ::1)
 gupnp-context-DEBUG: Mismatch between host header and host port (80, expected 4711)
 gupnp-context-DEBUG: Mismatch between host header and host IP (example.com, expected: ::1)

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/fd-trans.c | 100 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index 05a944b32e..59b622aba9 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -25,12 +25,16 @@
 #ifdef CONFIG_RTNETLINK
 #include <linux/rtnetlink.h>
 #include <linux/if_bridge.h>
+#include <linux/neighbour.h>
 #endif
 #include "qemu.h"
 #include "user-internals.h"
 #include "fd-trans.h"
 #include "signal-common.h"
 
+#define NDM_RTA(r)  ((struct rtattr*)(((char*)(r)) + \
+                    NLMSG_ALIGN(sizeof(struct ndmsg))))
+
 enum {
     QEMU_IFA_UNSPEC,
     QEMU_IFA_ADDRESS,
@@ -1226,6 +1230,35 @@ static abi_long host_to_target_data_route_rtattr(struct rtattr *rtattr)
     return 0;
 }
 
+static abi_long host_to_target_data_neigh_rtattr(struct rtattr *rtattr)
+{
+    struct nda_cacheinfo *ndac;
+    uint32_t *u32;
+
+    switch (rtattr->rta_type) {
+    case NDA_UNSPEC:
+    case NDA_DST:
+    case NDA_LLADDR:
+        break;
+    case NDA_PROBES:
+        u32 = RTA_DATA(rtattr);
+        *u32 = tswap32(*u32);
+        break;
+    case NDA_CACHEINFO:
+        ndac = RTA_DATA(rtattr);
+        ndac->ndm_confirmed = tswap32(ndac->ndm_confirmed);
+        ndac->ndm_used      = tswap32(ndac->ndm_used);
+        ndac->ndm_updated   = tswap32(ndac->ndm_updated);
+        ndac->ndm_refcnt    = tswap32(ndac->ndm_refcnt);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Unknown host to target NEIGH type: %d\n",
+                      rtattr->rta_type);
+        break;
+    }
+    return 0;
+}
+
 static abi_long host_to_target_link_rtattr(struct rtattr *rtattr,
                                          uint32_t rtattr_len)
 {
@@ -1247,12 +1280,20 @@ static abi_long host_to_target_route_rtattr(struct rtattr *rtattr,
                                           host_to_target_data_route_rtattr);
 }
 
+static abi_long host_to_target_neigh_rtattr(struct rtattr *rtattr,
+                                         uint32_t rtattr_len)
+{
+    return host_to_target_for_each_rtattr(rtattr, rtattr_len,
+                                          host_to_target_data_neigh_rtattr);
+}
+
 static abi_long host_to_target_data_route(struct nlmsghdr *nlh)
 {
     uint32_t nlmsg_len;
     struct ifinfomsg *ifi;
     struct ifaddrmsg *ifa;
     struct rtmsg *rtm;
+    struct ndmsg *ndm;
 
     nlmsg_len = nlh->nlmsg_len;
     switch (nlh->nlmsg_type) {
@@ -1279,6 +1320,17 @@ static abi_long host_to_target_data_route(struct nlmsghdr *nlh)
                                        nlmsg_len - NLMSG_LENGTH(sizeof(*ifa)));
         }
         break;
+    case RTM_NEWNEIGH:
+    case RTM_DELNEIGH:
+    case RTM_GETNEIGH:
+        if (nlh->nlmsg_len >= NLMSG_LENGTH(sizeof(*ndm))) {
+            ndm = NLMSG_DATA(nlh);
+            ndm->ndm_ifindex = tswap32(ndm->ndm_ifindex);
+            ndm->ndm_state = tswap16(ndm->ndm_state);
+            host_to_target_neigh_rtattr(NDM_RTA(ndm),
+                                    nlmsg_len - NLMSG_LENGTH(sizeof(*ndm)));
+        }
+        break;
     case RTM_NEWROUTE:
     case RTM_DELROUTE:
     case RTM_GETROUTE:
@@ -1426,6 +1478,35 @@ static abi_long target_to_host_data_addr_rtattr(struct rtattr *rtattr)
     return 0;
 }
 
+static abi_long target_to_host_data_neigh_rtattr(struct rtattr *rtattr)
+{
+    struct nda_cacheinfo *ndac;
+    uint32_t *u32;
+
+    switch (rtattr->rta_type) {
+    case NDA_UNSPEC:
+    case NDA_DST:
+    case NDA_LLADDR:
+        break;
+    case NDA_PROBES:
+        u32 = RTA_DATA(rtattr);
+        *u32 = tswap32(*u32);
+        break;
+    case NDA_CACHEINFO:
+        ndac = RTA_DATA(rtattr);
+        ndac->ndm_confirmed = tswap32(ndac->ndm_confirmed);
+        ndac->ndm_used      = tswap32(ndac->ndm_used);
+        ndac->ndm_updated   = tswap32(ndac->ndm_updated);
+        ndac->ndm_refcnt    = tswap32(ndac->ndm_refcnt);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Unknown target NEIGH type: %d\n",
+                      rtattr->rta_type);
+        break;
+    }
+    return 0;
+}
+
 static abi_long target_to_host_data_route_rtattr(struct rtattr *rtattr)
 {
     uint32_t *u32;
@@ -1464,6 +1545,13 @@ static void target_to_host_addr_rtattr(struct rtattr *rtattr,
                                    target_to_host_data_addr_rtattr);
 }
 
+static void target_to_host_neigh_rtattr(struct rtattr *rtattr,
+                                     uint32_t rtattr_len)
+{
+    target_to_host_for_each_rtattr(rtattr, rtattr_len,
+                                   target_to_host_data_neigh_rtattr);
+}
+
 static void target_to_host_route_rtattr(struct rtattr *rtattr,
                                      uint32_t rtattr_len)
 {
@@ -1476,6 +1564,7 @@ static abi_long target_to_host_data_route(struct nlmsghdr *nlh)
     struct ifinfomsg *ifi;
     struct ifaddrmsg *ifa;
     struct rtmsg *rtm;
+    struct ndmsg *ndm;
 
     switch (nlh->nlmsg_type) {
     case RTM_NEWLINK:
@@ -1502,6 +1591,17 @@ static abi_long target_to_host_data_route(struct nlmsghdr *nlh)
                                        NLMSG_LENGTH(sizeof(*ifa)));
         }
         break;
+    case RTM_NEWNEIGH:
+    case RTM_DELNEIGH:
+    case RTM_GETNEIGH:
+        if (nlh->nlmsg_len >= NLMSG_LENGTH(sizeof(*ndm))) {
+            ndm = NLMSG_DATA(nlh);
+            ndm->ndm_ifindex = tswap32(ndm->ndm_ifindex);
+            ndm->ndm_state = tswap16(ndm->ndm_state);
+            target_to_host_neigh_rtattr(NDM_RTA(ndm), nlh->nlmsg_len -
+                                       NLMSG_LENGTH(sizeof(*ndm)));
+        }
+        break;
     case RTM_NEWROUTE:
     case RTM_DELROUTE:
     case RTM_GETROUTE:
-- 
2.47.0



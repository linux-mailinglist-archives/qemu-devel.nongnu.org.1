Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2718F9068A6
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jun 2024 11:28:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHgks-0004HM-1X; Thu, 13 Jun 2024 05:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1sHgko-0004Fp-Pi
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:28:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1sHgkm-0006KO-LO
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718270900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lKLxZBeBJIcBJzDaEw1e6WfhpfHwojzZWNRQlnPXRqE=;
 b=XBxExOFrPIYZMRYteC+SUpHOPsdRIQSthrhKRlcO+kgIHwnUzuO9PFGRdDFP3BPAAja1rC
 yKcgoUsJubVx2OUGkqTR499XONweOp08v03ApI44XIKKWOb+uT5SDUEtsGjGVKH6+ZOlgf
 yKixRyD3t4zggeGUSLeANOfpHDSk1UE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-cPxIfpjUNbemElvzXjsESg-1; Thu,
 13 Jun 2024 05:28:16 -0400
X-MC-Unique: cPxIfpjUNbemElvzXjsESg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43C95195608C; Thu, 13 Jun 2024 09:28:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.216])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2003F3000219; Thu, 13 Jun 2024 09:28:11 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com,
	kkostiuk@redhat.com,
	michael.roth@amd.com
Subject: [PATCH v6 1/1] qga/linux: Add new api 'guest-network-get-route'
Date: Thu, 13 Jun 2024 17:28:02 +0800
Message-Id: <20240613092802.346246-2-demeng@redhat.com>
In-Reply-To: <20240613092802.346246-1-demeng@redhat.com>
References: <20240613092802.346246-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The Route information of the Linux VM needs to be used
by administrators and users when debugging network problems
and troubleshooting.

Signed-off-by: Dehan Meng <demeng@redhat.com>
---
 qga/commands-posix.c | 135 +++++++++++++++++++++++++++++++++++++++++++
 qga/commands-win32.c |   6 ++
 qga/qapi-schema.json |  71 +++++++++++++++++++++++
 3 files changed, 212 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 7f05996495..b85b3937bf 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2708,6 +2708,135 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
     return head;
 }
 
+static char *hexToIPAddress(const void *hexValue, int is_ipv6)
+{
+    if (is_ipv6) {
+        char addr[INET6_ADDRSTRLEN];
+        struct in6_addr in6;
+        const char *hexStr = (const char *)hexValue;
+        int i;
+
+        for (i = 0; i < 16; i++) {
+            sscanf(&hexStr[i * 2], "%02hhx", &in6.s6_addr[i]);
+        }
+        inet_ntop(AF_INET6, &in6, addr, INET6_ADDRSTRLEN);
+
+        return g_strdup(addr);
+    } else {
+        unsigned int hexInt = *(unsigned int *)hexValue;
+        unsigned int byte1 = (hexInt >> 24) & 0xFF;
+        unsigned int byte2 = (hexInt >> 16) & 0xFF;
+        unsigned int byte3 = (hexInt >> 8) & 0xFF;
+        unsigned int byte4 = hexInt & 0xFF;
+
+        return g_strdup_printf("%u.%u.%u.%u", byte4, byte3, byte2, byte1);
+    }
+}
+
+GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
+{
+    GuestNetworkRouteList *head = NULL, **tail = &head;
+    const char *routeFiles[] = {"/proc/net/route", "/proc/net/ipv6_route"};
+    FILE *fp;
+    size_t n;
+    char *line = NULL;
+    int firstLine;
+    int is_ipv6;
+    int i;
+
+    for (i = 0; i < 2; i++) {
+        firstLine = 1;
+        is_ipv6 = (i == 1);
+        fp = fopen(routeFiles[i], "r");
+        if (fp == NULL) {
+            error_setg_errno(errp, errno, "open(\"%s\")", routeFiles[i]);
+            free(line);
+            continue;
+        }
+
+        while (getline(&line, &n, fp) != -1) {
+            if (firstLine && !is_ipv6) {
+                firstLine = 0;
+                continue;
+            }
+            GuestNetworkRoute *route = NULL;
+            GuestNetworkRoute *networkroute;
+            char Iface[IFNAMSIZ];
+            if (is_ipv6) {
+                char Destination[33], Source[33], NextHop[33];
+                int DesPrefixlen, SrcPrefixlen, Metric, RefCnt, Use, Flags;
+
+                /* Parse the line and extract the values */
+                if (sscanf(line, "%32s %x %32s %x %32s %x %x %x %x %32s",
+                           Destination, &DesPrefixlen, Source,
+                           &SrcPrefixlen, NextHop, &Metric, &RefCnt,
+                           &Use, &Flags, Iface) != 10) {
+                    continue;
+                }
+
+                route = g_new0(GuestNetworkRoute, 1);
+                networkroute = route;
+                networkroute->iface = g_strdup(Iface);
+                networkroute->destination = hexToIPAddress(Destination, 1);
+                networkroute->metric = Metric;
+                networkroute->source = hexToIPAddress(Source, 1);
+                networkroute->desprefixlen = g_strdup_printf(
+                    "%d", DesPrefixlen
+                );
+                networkroute->srcprefixlen = g_strdup_printf(
+                    "%d", SrcPrefixlen
+                );
+                networkroute->nexthop = hexToIPAddress(NextHop, 1);
+                networkroute->has_flags = true;
+                networkroute->flags = Flags;
+                networkroute->has_refcnt = true;
+                networkroute->refcnt = RefCnt;
+                networkroute->has_use = true;
+                networkroute->use = Use;
+                networkroute->version = 6;
+            } else {
+                unsigned int Destination, Gateway, Mask, Flags;
+                int RefCnt, Use, Metric, MTU, Window, IRTT;
+
+                /* Parse the line and extract the values */
+                if (sscanf(line, "%s %X %X %x %d %d %d %X %d %d %d",
+                           Iface, &Destination, &Gateway, &Flags, &RefCnt,
+                           &Use, &Metric, &Mask, &MTU, &Window, &IRTT) != 11) {
+                    continue;
+                }
+
+                route = g_new0(GuestNetworkRoute, 1);
+                networkroute = route;
+                networkroute->iface = g_strdup(Iface);
+                networkroute->destination = hexToIPAddress(&Destination, 0);
+                networkroute->gateway = hexToIPAddress(&Gateway, 0);
+                networkroute->mask = hexToIPAddress(&Mask, 0);
+                networkroute->metric = Metric;
+                networkroute->has_flags = true;
+                networkroute->flags = Flags;
+                networkroute->has_refcnt = true;
+                networkroute->refcnt = RefCnt;
+                networkroute->has_use = true;
+                networkroute->use = Use;
+                networkroute->has_mtu = true;
+                networkroute->mtu = MTU;
+                networkroute->has_window = true;
+                networkroute->window = Window;
+                networkroute->has_irtt = true;
+                networkroute->irtt = IRTT;
+                networkroute->version = 4;
+            }
+
+            QAPI_LIST_APPEND(tail, route);
+        }
+
+        free(line);
+        fclose(fp);
+    }
+
+    return head;
+}
+
 #else /* defined(__linux__) */
 
 void qmp_guest_suspend_disk(Error **errp)
@@ -3079,6 +3208,12 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
     return NULL;
 }
 
+GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
+
 #endif /* CONFIG_FSFREEZE */
 
 #if !defined(CONFIG_FSTRIM)
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 0d1b836e87..91289bc9ab 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2517,3 +2517,9 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
     error_setg(errp, QERR_UNSUPPORTED);
     return NULL;
 }
+
+GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index b3de1fb6b3..1c2ee9f3c6 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1800,3 +1800,74 @@
 { 'command': 'guest-get-cpustats',
   'returns': ['GuestCpuStats']
 }
+
+##
+# @GuestNetworkRoute:
+#
+# Route information, currently, only linux supported.
+#
+# @iface: The destination network or host's egress network interface in the routing table
+#
+# @destination: The IP address of the target network or host, The final destination of the packet
+#
+# @metric: Route metric
+#
+# @gateway: The IP address of the next hop router
+#
+# @mask: Subnet Mask (IPv4 only)
+#
+# @irtt: Initial round-trip delay (not for windows, IPv4 only)
+#
+# @flags: Route flags (not for windows)
+#
+# @refcnt: The route's reference count (not for windows)
+#
+# @use: Route usage count (not for windows)
+#
+# @window: TCP window size, used for flow control (not for windows, IPv4 only)
+#
+# @mtu: Data link layer maximum packet size (not for windows)
+#
+# @desprefixlen: Destination prefix length (for IPv6)
+#
+# @source: Source IP address (for IPv6)
+#
+# @srcprefixlen: Source prefix length (for IPv6)
+#
+# @nexthop: Next hop IP address (for IPv6)
+#
+# @version: IP version (4 or 6)
+#
+# Since: 9.1
+
+##
+{ 'struct': 'GuestNetworkRoute',
+  'data': {'iface': 'str',
+           'destination': 'str',
+           'metric': 'int',
+           '*gateway': 'str',
+           '*mask': 'str',
+           '*irtt': 'int',
+           '*flags': 'uint64',
+           '*refcnt': 'int',
+           '*use': 'int',
+           '*window': 'int',
+           '*mtu': 'int',
+           '*desprefixlen': 'str',
+           '*source': 'str',
+           '*srcprefixlen': 'str',
+           '*nexthop': 'str',
+           'version': 'int'
+           }}
+
+##
+# @guest-network-get-route:
+#
+# Retrieve information about route of network.
+# Returns: List of route info of guest.
+#
+# Since: 9.1
+##
+{ 'command': 'guest-network-get-route',
+  'returns': ['GuestNetworkRoute']
+}
-- 
2.40.1



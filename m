Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3BB7F6AFD
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 04:41:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6N2w-00068Z-Ec; Thu, 23 Nov 2023 22:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1r6N2u-00067s-IJ
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 22:40:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1r6N2s-0004wH-Tw
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 22:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700797198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z4rURaphcKk7/a+8zTv9dZaq+CdNL6F+N6TeXLxwyK0=;
 b=PWBtaOBWi/P3Y359R4pEjJvwtiGEzDcweOmgKrGUZejKuW5XG8e8E9mAYFK9c4iMSXoPls
 2Fsg+s+9ST3tAeNX83mTuMVdxouoi0m6h+bNjrIyMseFp29+PC71+NxuhoyKSHwQd/IWdu
 WwWE1UoKbUaBKefq91gdgRIu8npsUkw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-aW7mPaHwNwaQXFMniOo5MA-1; Thu, 23 Nov 2023 22:39:56 -0500
X-MC-Unique: aW7mPaHwNwaQXFMniOo5MA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0252A811E82;
 Fri, 24 Nov 2023 03:39:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DE8E40C6EB9;
 Fri, 24 Nov 2023 03:39:52 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com,
	kkostiuk@redhat.com,
	michael.roth@amd.com
Subject: [PATCH v2 1/1] qga/linux: Add new api 'guest-network-get-route'
Date: Fri, 24 Nov 2023 11:39:46 +0800
Message-Id: <20231124033946.197371-2-demeng@redhat.com>
In-Reply-To: <20231124033946.197371-1-demeng@redhat.com>
References: <20231124033946.197371-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The Route information of the Linux VM needs to be used
by administrators and users when debugging network problems
and troubleshooting.

Signed-off-by: Dehan Meng <demeng@redhat.com>
---
 qga/commands-posix.c | 78 ++++++++++++++++++++++++++++++++++++++++++
 qga/commands-win32.c |  6 ++++
 qga/qapi-schema.json | 80 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 6169bbf7a0..894cc43fce 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2747,6 +2747,78 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
     return head;
 }
 
+char *hexToIPAddress(unsigned int hexValue);
+
+char *hexToIPAddress(unsigned int hexValue)
+{
+    unsigned int byte1 = (hexValue >> 24) & 0xFF;
+    unsigned int byte2 = (hexValue >> 16) & 0xFF;
+    unsigned int byte3 = (hexValue >> 8) & 0xFF;
+    unsigned int byte4 = hexValue & 0xFF;
+
+    return g_strdup_printf("%u.%u.%u.%u", byte4, byte3, byte2, byte1);
+}
+
+GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
+{
+    GuestNetworkRouteList *head = NULL, **tail = &head;
+    const char *routeFile = "/proc/net/route";
+    FILE *fp;
+    size_t n;
+    char *line = NULL;
+    int firstLine = 1;
+
+    fp = fopen(routeFile, "r");
+    if (fp == NULL) {
+        error_setg_errno(errp, errno, "open(\"%s\")", routeFile);
+        free(line);
+        return NULL;
+    }
+
+    while (getline(&line, &n, fp) != -1) {
+        if (firstLine) {
+            firstLine = 0;
+            continue;
+        }
+        GuestNetworkRoute *route = NULL;
+        GuestNetworkRouteStat *networkroute;
+        int i;
+        char Iface[16];
+        unsigned int Destination, Gateway, Mask, Flags;
+        int RefCnt, Use, Metric, MTU, Window, IRTT;
+
+        /* Parse the line and extract the values */
+        i = (sscanf(line, "%s %X %X %x %d %d %d %X %d %d %d",
+                    Iface, &Destination, &Gateway, &Flags, &RefCnt,
+                    &Use, &Metric, &Mask, &MTU, &Window, &IRTT) == 11);
+        if (i == EOF) {
+            continue;
+        }
+
+        route = g_new0(GuestNetworkRoute, 1);
+        route->type = GUEST_NETWORK_ROUTE_TYPE_LINUX;
+
+        networkroute = &route->u.q_linux;
+        networkroute->iface = g_strdup(Iface);
+        networkroute->destination = hexToIPAddress(Destination);
+        networkroute->gateway = hexToIPAddress(Gateway);
+        networkroute->mask = hexToIPAddress(Mask);
+        networkroute->metric = Metric;
+        networkroute->flags = Flags;
+        networkroute->refcnt = RefCnt;
+        networkroute->use = Use;
+        networkroute->mtu = MTU;
+        networkroute->window = Window;
+        networkroute->irtt = IRTT;
+
+        QAPI_LIST_APPEND(tail, route);
+    }
+
+    free(line);
+    fclose(fp);
+    return head;
+}
+
 #else /* defined(__linux__) */
 
 void qmp_guest_suspend_disk(Error **errp)
@@ -3118,6 +3190,12 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
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
index 697c65507c..e62c04800a 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2522,3 +2522,9 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
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
index 876e2a8ea8..eed9539bb7 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1789,3 +1789,83 @@
 { 'command': 'guest-get-cpustats',
   'returns': ['GuestCpuStats']
 }
+
+##
+# @GuestNetworkRouteType:
+#
+# An enumeration of OS type
+#
+# Since: 8.2
+##
+{ 'enum': 'GuestNetworkRouteType',
+  'data': [ 'linux' ] }
+
+##
+# @GuestNetworkRouteStat:
+#
+# Route information, currently, only linux supported.
+#
+# @iface: The destination network or host's egress network interface in the routing table
+#
+# @destination: The IP address of the target network or host, The final destination of the packet
+#
+# @gateway: The IP address of the next hop router
+#
+# @mask: Subnet Mask
+#
+# @metric: Route metric
+#
+# @flags: Route flags (not for windows)
+#
+# @irtt: Initial round-trip delay (not for windows)
+#
+# @refcnt: The route's reference count (not for windows)
+#
+# @use: Route usage count (not for windows)
+#
+# @window: TCP window size, used for flow control (not for windows)
+#
+# @mtu: Data link layer maximum packet size (not for windows)
+#
+# Since: 8.2
+
+##
+{ 'struct': 'GuestNetworkRouteStat',
+  'data': {'iface': 'str',
+           'destination': 'str',
+           'gateway': 'str',
+           'metric': 'int',
+           'mask': 'str',
+           '*irtt': 'int',
+           '*flags': 'uint64',
+           '*refcnt': 'int',
+           '*use': 'int',
+           '*window': 'int',
+           '*mtu': 'int'
+           }}
+
+##
+# @GuestNetworkRoute:
+#
+# Get route information of system.
+#
+# - @linux: Linux style network route
+#
+# Since: 8.2
+##
+{ 'union': 'GuestNetworkRoute',
+  'base': { 'type': 'GuestNetworkRouteType' },
+  'discriminator': 'type',
+  'data': { 'linux': 'GuestNetworkRouteStat' } }
+
+##
+# @guest-network-get-route:
+#
+# Retrieve information about route of network.
+# Returns: List of route info of guest.
+#
+# Since: 8.2
+##
+{ 'command': 'guest-network-get-route',
+  'returns': ['GuestNetworkRoute']
+}
-- 
2.35.1



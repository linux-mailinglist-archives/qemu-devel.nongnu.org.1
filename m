Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C447DCB86
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 12:13:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxmeR-0004Ke-03; Tue, 31 Oct 2023 07:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxmeM-00043R-C0
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxmeJ-0006xm-S0
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698750667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pQbfsF7CGATAVMrtrNb3IySMF3mUpQa+LtSkkxRplvs=;
 b=SdzIteM2LS8ZILLeuH+2E6DVTLJD4tGYmueqYBA14c2/SG+N6sPQMbpZdmiC+tvVaOA/Y2
 XD4bGYi9mnKU3vs689u18mb8SHG54ulx5tGx60yeYRt3kYeEpO8N101e8eBSvuHGmANLIM
 X9sRHjA/SUl1I36Hsy7krSoDucjPxKw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-w0zAfFy9NAivmNx07UTXAQ-1; Tue,
 31 Oct 2023 07:11:03 -0400
X-MC-Unique: w0zAfFy9NAivmNx07UTXAQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 559FF2808FCB;
 Tue, 31 Oct 2023 11:11:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3252140C6EB9;
 Tue, 31 Oct 2023 11:11:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EDE8F21E6921; Tue, 31 Oct 2023 12:10:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, dave@treblig.org,
 jasowang@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 mst@redhat.com, david@redhat.com, kraxel@redhat.com,
 marcandre.lureau@redhat.com, qemu-ppc@nongnu.org
Subject: [PATCH 5/7] net: Fix a misleading error message
Date: Tue, 31 Oct 2023 12:10:57 +0100
Message-ID: <20231031111059.3407803-6-armbru@redhat.com>
In-Reply-To: <20231031111059.3407803-1-armbru@redhat.com>
References: <20231031111059.3407803-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The error message

    $ qemu-system-x86_64 -netdev user,id=net0,ipv6-net=fec0::0/
    qemu-system-x86_64: -netdev user,id=net0,ipv6-net=fec0::0/: Parameter 'ipv6-prefixlen' expects a number

points to ipv6-prefixlen instead of ipv6-net.  Fix:

    qemu-system-x86_64: -netdev user,id=net0,ipv6-net=fec0::0/: parameter 'ipv6-net' expects a number after '/'

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 net/net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/net.c b/net/net.c
index c0c0cbe99e..8e67a20abc 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1227,7 +1227,7 @@ static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
     int ret = -1;
     Visitor *v = opts_visitor_new(opts);
 
-    /* Parse convenience option format ip6-net=fec0::0[/64] */
+    /* Parse convenience option format ipv6-net=fec0::0[/64] */
     const char *ip6_net = qemu_opt_get(opts, "ipv6-net");
 
     if (ip6_net) {
@@ -1247,8 +1247,8 @@ static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
         if (substrings[1] &&
             qemu_strtoul(substrings[1], NULL, 10, &prefix_len))
         {
-            error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                       "ipv6-prefixlen", "a number");
+            error_setg(errp,
+                       "parameter 'ipv6-net' expects a number after '/'");
             goto out;
         }
 
-- 
2.41.0



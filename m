Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 937A37EEF4F
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 10:54:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3vXk-0007sd-O5; Fri, 17 Nov 2023 04:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3vXj-0007pH-0Z
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 04:53:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3vXh-0006fT-74
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 04:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700214819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jw/isfbp3xt/B11NQG83ja0Vh09xM5FOXvP5SNGXNnM=;
 b=TnawN/KZxO0na2gRij57q2QsZvtkX8hm5jcVU+V+tZUxf015rFQ4tz6aY9VtjPVh5jz42r
 iE5PX8BwjdwKgFMIE56PgF4vUDZ8BFGF+H7mQBecM3Uu+lYAjm5kJbOilI43LKEF96g1dy
 JPp3zeLkrrNapEwphpDkaLvP+lA5KMc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-rl3qgInoOO6Dp_d5EXxt7Q-1; Fri, 17 Nov 2023 04:53:37 -0500
X-MC-Unique: rl3qgInoOO6Dp_d5EXxt7Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED98D85A59D
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 09:53:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCD681121306
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 09:53:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E3E6621E6921; Fri, 17 Nov 2023 10:53:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 5/7] net: Fix a misleading error message
Date: Fri, 17 Nov 2023 10:53:32 +0100
Message-ID: <20231117095334.1819613-6-armbru@redhat.com>
In-Reply-To: <20231117095334.1819613-1-armbru@redhat.com>
References: <20231117095334.1819613-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
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

The error message

    $ qemu-system-x86_64 -netdev user,id=net0,ipv6-net=fec0::0/
    qemu-system-x86_64: -netdev user,id=net0,ipv6-net=fec0::0/: Parameter 'ipv6-prefixlen' expects a number

points to ipv6-prefixlen instead of ipv6-net.  Fix:

    qemu-system-x86_64: -netdev user,id=net0,ipv6-net=fec0::0/: parameter 'ipv6-net' expects a number after '/'

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20231031111059.3407803-6-armbru@redhat.com>
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



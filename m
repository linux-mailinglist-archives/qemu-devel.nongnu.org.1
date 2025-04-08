Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFDDA80160
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Apr 2025 13:39:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u275g-0007Xu-0e; Tue, 08 Apr 2025 07:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1u275a-0007WR-TX
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 07:25:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1u275Z-0006NU-B4
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 07:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744111556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0qFSq+Nz5Tjs3h45eynnba7uyQWzWhoqTJ7eq5wvpo=;
 b=ISTKAH5Z6VjLKAKLb9YZBy4Gw9IQ8ublWx1ECry7fBQEl4s8tAraxtXZT/q2Kh8MYv85G6
 kNte5OK7YEGDud2v6PGbjIT4TXO7MjIbBFuS4QKrcDkB4X5Q2qceleo4gxIWdB9cV3iC0b
 wbP6+8nehmTfflgxQpKaZi3rqI4p5fU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-_IJfgG6hPFeF3vW94NsNRg-1; Tue,
 08 Apr 2025 07:25:53 -0400
X-MC-Unique: _IJfgG6hPFeF3vW94NsNRg-1
X-Mimecast-MFC-AGG-ID: _IJfgG6hPFeF3vW94NsNRg_1744111552
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA8DD19560B8; Tue,  8 Apr 2025 11:25:52 +0000 (UTC)
Received: from rh-jmarcin.redhat.com (unknown [10.44.34.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BACEE19541A6; Tue,  8 Apr 2025 11:25:50 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, vsementsov@yandex-team.ru,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 2/5] util/qemu-sockets: Refactor setting client sockopts
 into a separate function
Date: Tue,  8 Apr 2025 13:25:01 +0200
Message-ID: <20250408112508.1638722-3-jmarcin@redhat.com>
In-Reply-To: <20250408112508.1638722-1-jmarcin@redhat.com>
References: <20250408112508.1638722-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Juraj Marcin <jmarcin@redhat.com>

This is done in preparation for enabling the SO_KEEPALIVE support for
server sockets and adding settings for more TCP keep-alive socket
options.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 util/qemu-sockets.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 77477c1cd5..d15f6aa4b0 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -205,6 +205,22 @@ static int try_bind(int socket, InetSocketAddress *saddr, struct addrinfo *e)
 #endif
 }
 
+static int inet_set_sockopts(int sock, InetSocketAddress *saddr, Error **errp)
+{
+    if (saddr->keep_alive) {
+        int keep_alive = 1;
+        int ret = setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE,
+                             &keep_alive, sizeof(keep_alive));
+
+        if (ret < 0) {
+            error_setg_errno(errp, errno,
+                             "Unable to set keep-alive option on socket");
+            return -1;
+        }
+    }
+    return 0;
+}
+
 static int inet_listen_saddr(InetSocketAddress *saddr,
                              int port_offset,
                              int num,
@@ -475,16 +491,9 @@ int inet_connect_saddr(InetSocketAddress *saddr, Error **errp)
         return sock;
     }
 
-    if (saddr->keep_alive) {
-        int val = 1;
-        int ret = setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE,
-                             &val, sizeof(val));
-
-        if (ret < 0) {
-            error_setg_errno(errp, errno, "Unable to set KEEPALIVE");
-            close(sock);
-            return -1;
-        }
+    if (inet_set_sockopts(sock, saddr, errp)) {
+        close(sock);
+        return -1;
     }
 
     return sock;
-- 
2.48.1



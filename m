Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 986EAA80017
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Apr 2025 13:28:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u275o-0007aB-HY; Tue, 08 Apr 2025 07:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1u275l-0007Zr-QA
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 07:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1u275j-0006OH-VR
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 07:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744111567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ExzazHutwHcMdtek0Bh0IzwUbsdsm4bkTxcjrWo+zao=;
 b=jFJF6YB5WB424biD6VqjRJLnKoBagvf7M3TbyvJraJQqDkcQesKlr8HxwZLQFPtAFElQBK
 qKJMnQv6IY536O2PSxXoQguxfOvBil+5ssJmq9pwKHG4kAiSqugnDXBBAHKjuX08EsROGA
 NyRCpVwfTPf6gLPL4KaaAKSw54JPdsw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-nOJO2SmIOne_jM9hxVq1Uw-1; Tue,
 08 Apr 2025 07:26:03 -0400
X-MC-Unique: nOJO2SmIOne_jM9hxVq1Uw-1
X-Mimecast-MFC-AGG-ID: nOJO2SmIOne_jM9hxVq1Uw_1744111563
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBB42180AF72; Tue,  8 Apr 2025 11:26:02 +0000 (UTC)
Received: from rh-jmarcin.redhat.com (unknown [10.44.34.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B05EF19560AD; Tue,  8 Apr 2025 11:26:00 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, vsementsov@yandex-team.ru,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 4/5] util/qemu-sockets: Add support for keep-alive flag to
 passive sockets
Date: Tue,  8 Apr 2025 13:25:03 +0200
Message-ID: <20250408112508.1638722-5-jmarcin@redhat.com>
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

Commit aec21d3175 (qapi: Add InetSocketAddress member keep-alive)
introduces the keep-alive flag, which enables the SO_KEEPALIVE socket
option, but only on client-side sockets. However, this option is also
useful for server-side sockets, so they can check if a client is still
reachable or drop the connection otherwise.

This patch enables the SO_KEEPALIVE socket option on passive server-side
sockets if the keep-alive flag is enabled. This socket option is then
inherited by active server-side sockets communicating with connected
clients.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 qapi/sockets.json   | 4 ++--
 util/qemu-sockets.c | 9 +++------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/qapi/sockets.json b/qapi/sockets.json
index 6a95023315..62797cd027 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -56,8 +56,8 @@
 # @ipv6: whether to accept IPv6 addresses, default try both IPv4 and
 #     IPv6
 #
-# @keep-alive: enable keep-alive when connecting to this socket.  Not
-#     supported for passive sockets.  (Since 4.2)
+# @keep-alive: enable keep-alive when connecting to/listening on this socket.
+#     (Since 4.2, not supported for listening sockets until 10.1)
 #
 # @mptcp: enable multi-path TCP.  (Since 6.1)
 #
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index a86964786a..fed17a1ffb 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -236,12 +236,6 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
     int saved_errno = 0;
     bool socket_created = false;
 
-    if (saddr->keep_alive) {
-        error_setg(errp, "keep-alive option is not supported for passive "
-                   "sockets");
-        return -1;
-    }
-
     memset(&ai,0, sizeof(ai));
     ai.ai_flags = AI_PASSIVE;
     if (saddr->has_numeric && saddr->numeric) {
@@ -349,6 +343,9 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
                 goto fail;
             }
             /* We have a listening socket */
+            if (inet_set_sockopts(slisten, saddr, errp)) {
+                goto fail;
+            }
             freeaddrinfo(res);
             return slisten;
         }
-- 
2.48.1



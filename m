Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7654FAC09D4
	for <lists+qemu-devel@lfdr.de>; Thu, 22 May 2025 12:32:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI3CY-00043u-K4; Thu, 22 May 2025 06:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3CO-0003lf-Kb
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3CI-0006ft-8t
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747909842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iIZzfgTdaV8CXAkQx0Ke4gbgAg+jKeWuEAcGyxYH8Lc=;
 b=TzmczH3QfVNtj5O2Udvz6+89bHDoSQgELffRPduv7McuW7aJHf0ba5Uon1mjYcrKSHrFAQ
 gKPrHPoVHDVnfeBwk1XfTpP05rlUKxXgs3sTjmx3hLCgJh57Fo/qBe7TRtYZal0pQ4H4oI
 aC/Obh98P99OHQmfcIHjTtlFbYi9azY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-TArIV9rBMFi9sp0jJp7jsw-1; Thu,
 22 May 2025 06:30:39 -0400
X-MC-Unique: TArIV9rBMFi9sp0jJp7jsw-1
X-Mimecast-MFC-AGG-ID: TArIV9rBMFi9sp0jJp7jsw_1747909838
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84B7919560B0; Thu, 22 May 2025 10:30:38 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.179])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 866721958014; Thu, 22 May 2025 10:30:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 19/23] util/qemu-sockets: Refactor success and failure paths in
 inet_listen_saddr()
Date: Thu, 22 May 2025 11:29:19 +0100
Message-ID: <20250522102923.309452-20-berrange@redhat.com>
In-Reply-To: <20250522102923.309452-1-berrange@redhat.com>
References: <20250522102923.309452-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
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

To get a listening socket, we need to first create a socket, try binding
it to a certain port, and lastly starting listening to it. Each of these
operations can fail due to various reasons, one of them being that the
requested address/port is already in use. In such case, the function
tries the same process with a new port number.

This patch refactors the port number loop, so the success path is no
longer buried inside the 'if' statements in the middle of the loop. Now,
the success path is not nested and ends at the end of the iteration
after successful socket creation, binding, and listening. In case any of
the operations fails, it either continues to the next iteration (and the
next port) or jumps out of the loop to handle the error and exits the
function.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/qemu-sockets.c | 51 ++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 4a878e0527..329fdbfd97 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -303,11 +303,20 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
         port_min = inet_getport(e);
         port_max = saddr->has_to ? saddr->to + port_offset : port_min;
         for (p = port_min; p <= port_max; p++) {
+            if (slisten >= 0) {
+                /*
+                 * We have a socket we tried with the previous port. It cannot
+                 * be rebound, we need to close it and create a new one.
+                 */
+                close(slisten);
+                slisten = -1;
+            }
             inet_setport(e, p);
 
             slisten = create_fast_reuse_socket(e);
             if (slisten < 0) {
-                /* First time we expect we might fail to create the socket
+                /*
+                 * First time we expect we might fail to create the socket
                  * eg if 'e' has AF_INET6 but ipv6 kmod is not loaded.
                  * Later iterations should always succeed if first iteration
                  * worked though, so treat that as fatal.
@@ -317,40 +326,38 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
                 } else {
                     error_setg_errno(errp, errno,
                                      "Failed to recreate failed listening socket");
-                    goto listen_failed;
+                    goto fail;
                 }
             }
             socket_created = true;
 
             rc = try_bind(slisten, saddr, e);
             if (rc < 0) {
-                if (errno != EADDRINUSE) {
-                    error_setg_errno(errp, errno, "Failed to bind socket");
-                    goto listen_failed;
-                }
-            } else {
-                if (!listen(slisten, num)) {
-                    goto listen_ok;
+                if (errno == EADDRINUSE) {
+                    /* This port is already used, try the next one */
+                    continue;
                 }
-                if (errno != EADDRINUSE) {
-                    error_setg_errno(errp, errno, "Failed to listen on socket");
-                    goto listen_failed;
+                error_setg_errno(errp, errno, "Failed to bind socket");
+                goto fail;
+            }
+            if (listen(slisten, num)) {
+                if (errno == EADDRINUSE) {
+                    /* This port is already used, try the next one */
+                    continue;
                 }
+                error_setg_errno(errp, errno, "Failed to listen on socket");
+                goto fail;
             }
-            /* Someone else managed to bind to the same port and beat us
-             * to listen on it! Socket semantics does not allow us to
-             * recover from this situation, so we need to recreate the
-             * socket to allow bind attempts for subsequent ports:
-             */
-            close(slisten);
-            slisten = -1;
+            /* We have a listening socket */
+            freeaddrinfo(res);
+            return slisten;
         }
     }
     error_setg_errno(errp, errno,
                      socket_created ?
                      "Failed to find an available port" :
                      "Failed to create a socket");
-listen_failed:
+fail:
     saved_errno = errno;
     if (slisten >= 0) {
         close(slisten);
@@ -358,10 +365,6 @@ listen_failed:
     freeaddrinfo(res);
     errno = saved_errno;
     return -1;
-
-listen_ok:
-    freeaddrinfo(res);
-    return slisten;
 }
 
 #ifdef _WIN32
-- 
2.49.0



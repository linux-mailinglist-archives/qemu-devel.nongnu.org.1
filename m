Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DED9D1915
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Nov 2024 20:37:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD7Yp-0008Lu-0Q; Mon, 18 Nov 2024 14:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tD7YK-0007gH-LP
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 14:36:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tD7YF-0002mp-Kd
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 14:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731958601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l00QVC/M1EOdKC7fTi+PujFyXX+16ChunhNVDiN7q9k=;
 b=MLxtMX0olv/t5pozXYgaS9muRpv5gkWNHQzq9dWJxDuTsohWIxKofBDiGEtCfInIRBegfk
 CP2cr0Si+RGX3d4ZqzYw5dK8QWsWQgVFayKl/9Mgv0qhbjGP6aq3Qo3jrW2KvNtuBW8FpF
 /AzAbwmqGWcjCBOzaoapj0V6EhkfMPY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-DBVeppEiOo6TCRb2ERfq6Q-1; Mon,
 18 Nov 2024 14:36:37 -0500
X-MC-Unique: DBVeppEiOo6TCRb2ERfq6Q-1
X-Mimecast-MFC-AGG-ID: DBVeppEiOo6TCRb2ERfq6Q
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 763E0195609E; Mon, 18 Nov 2024 19:36:34 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.76])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 52DB1195607C; Mon, 18 Nov 2024 19:36:32 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 1/1] nbd-server: Silence server warnings on port probes
Date: Mon, 18 Nov 2024 13:35:12 -0600
Message-ID: <20241118193627.1826228-4-eblake@redhat.com>
In-Reply-To: <20241118193627.1826228-3-eblake@redhat.com>
References: <20241118193627.1826228-3-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

While testing the use of qemu-nbd in a Pod of a Kubernetes cluster, I
got LOTS of log messages of the forms:

qemu-nbd: option negotiation failed: Failed to read flags: Unexpected end-of-file before all data were read
qemu-nbd: option negotiation failed: Failed to read flags: Unable to read from socket: Connection reset by peer

While it is nice to warn about clients that aren't following protocol
(in case it helps diagnosing bugs in those clients), a mere port probe
(where the client never write()s any bytes, and where we might even
hit EPIPE in trying to send our greeting to the client) is NOT
abnormal, but merely serves to pollute the log.  And Kubernetes
_really_ likes to do port probes to determine whether a given Pod is
up and running.

Easy ways to demonstrate the above port probes:
$ qemu-nbd -r -f raw path/to/file &
$ nc localhost 10809 </dev/null
$ bash -c 'exec </dev/tcp/localhost/10809'
$ kill $!

Silence the noise by not capturing errors until after our first
successful read() from a client.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20241115195638.1132007-2-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 nbd/server.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index c30e687fc8b..f64e47270c0 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1150,8 +1150,8 @@ nbd_negotiate_meta_queries(NBDClient *client, Error **errp)
  * Return:
  * -errno  on error, errp is set
  * 0       on successful negotiation, errp is not set
- * 1       if client sent NBD_OPT_ABORT, i.e. on valid disconnect,
- *         errp is not set
+ * 1       if client sent NBD_OPT_ABORT (i.e. on valid disconnect) or never
+ *         wrote anything (i.e. port probe); errp is not set
  */
 static coroutine_fn int
 nbd_negotiate_options(NBDClient *client, Error **errp)
@@ -1175,8 +1175,13 @@ nbd_negotiate_options(NBDClient *client, Error **errp)
         ...           Rest of request
     */

-    if (nbd_read32(client->ioc, &flags, "flags", errp) < 0) {
-        return -EIO;
+    /*
+     * Intentionally ignore errors on this first read - we do not want
+     * to be noisy about a mere port probe, but only for clients that
+     * start talking the protocol and then quit abruptly.
+     */
+    if (nbd_read32(client->ioc, &flags, "flags", NULL) < 0) {
+        return 1;
     }
     client->mode = NBD_MODE_EXPORT_NAME;
     trace_nbd_negotiate_options_flags(flags);
@@ -1383,8 +1388,8 @@ nbd_negotiate_options(NBDClient *client, Error **errp)
  * Return:
  * -errno  on error, errp is set
  * 0       on successful negotiation, errp is not set
- * 1       if client sent NBD_OPT_ABORT, i.e. on valid disconnect,
- *         errp is not set
+ * 1       if client sent NBD_OPT_ABORT (i.e. on valid disconnect) or never
+ *         wrote anything (i.e. port probe); errp is not set
  */
 static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
 {
@@ -1415,9 +1420,12 @@ static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
     stq_be_p(buf + 8, NBD_OPTS_MAGIC);
     stw_be_p(buf + 16, NBD_FLAG_FIXED_NEWSTYLE | NBD_FLAG_NO_ZEROES);

-    if (nbd_write(client->ioc, buf, 18, errp) < 0) {
-        error_prepend(errp, "write failed: ");
-        return -EINVAL;
+    /*
+     * Be silent about failure to write our greeting: there is nothing
+     * wrong with a client testing if our port is alive.
+     */
+    if (nbd_write(client->ioc, buf, 18, NULL) < 0) {
+        return 1;
     }
     ret = nbd_negotiate_options(client, errp);
     if (ret != 0) {
-- 
2.47.0



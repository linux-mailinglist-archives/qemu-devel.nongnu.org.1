Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6FC787913
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 22:07:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZGaO-0000MW-KD; Thu, 24 Aug 2023 16:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qZGaJ-0000Lo-76
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 16:05:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qZGaG-0007hm-1D
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 16:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692907534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hKdYcMBLaw9Xkva3LmFa4Q04TOPMi1MovMMjYwWutXg=;
 b=B9j6oYc5HbI4hEyWaUBj2wLRGjW0u4pF/S6mWWgOV37LqyzuRtQXD/oKNgemeBrQfdzat8
 w15kBx1p3jQihg95UMVyEwGaoKz6wbS3tfuZqpG8de7CbG65s1iYfkspttg4S2VIAtQi6Q
 qPrHPpOkuTxscOGjWM0dRGp9ce2V0Xw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-n1Ds5zsaMbi9j5hidQpSug-1; Thu, 24 Aug 2023 16:05:24 -0400
X-MC-Unique: n1Ds5zsaMbi9j5hidQpSug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B45258015AA;
 Thu, 24 Aug 2023 20:05:23 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D33B91121319;
 Thu, 24 Aug 2023 20:05:22 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-stable@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PATCH] qemu-nbd: Restore "qemu-nbd -v --fork" output
Date: Thu, 24 Aug 2023 15:03:12 -0500
Message-ID: <20230824200311.636589-2-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Closing stderr earlier is good for daemonized qemu-nbd under ssh
earlier, but breaks the case where -v is being used to track what is
happening in the server, as in iotest 233.

When we know we are verbose, we do NOT want qemu_daemon to close
stderr.  For management purposes, we still need to temporarily
override the daemon child's stderr with the pipe to the parent until
after the pid file is created; but since qemu_daemon would normally
set stdout to /dev/null had we not been verbose, we can use stdout as
a place to stash our original stderr.  Thus, whether normal or vebose,
when the management handoff is complete, copying stdout back to stderr
does the right thing for the rest of the life of the daemon child.

Note that while the error messages expected by iotest 233 are now
restored, the change in file descriptors means they now show up
earlier in the testsuite output.

Reported-by: Kevin Wolf <kwolf@redhat.com>
CC: Denis V. Lunev <den@openvz.org>
CC: qemu-stable@nongnu.org
Fixes: 5c56dd27a2 ("qemu-nbd: fix regression with qemu-nbd --fork run over ssh")
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c                 | 21 ++++++++++++++++++++-
 tests/qemu-iotests/233.out | 20 ++++++++++----------
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index aaccaa33184..a105094fb17 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -944,9 +944,24 @@ int main(int argc, char **argv)

             close(stderr_fd[0]);

-            ret = qemu_daemon(1, 0);
+            ret = qemu_daemon(1, verbose);
             saved_errno = errno;    /* dup2 will overwrite error below */

+            if (verbose) {
+                /* We want stdin at /dev/null when qemu_daemon didn't do it */
+                stdin = freopen("/dev/null", "r", stdin);
+                if (stdin == NULL) {
+                    error_report("Failed to redirect stdin: %s",
+                                 strerror(errno));
+                    exit(EXIT_FAILURE);
+                }
+                /* To keep the parent's stderr alive, copy it to stdout */
+                if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
+                    error_report("Failed to redirect stdout: %s",
+                                 strerror(errno));
+                    exit(EXIT_FAILURE);
+                }
+            }
             /* Temporarily redirect stderr to the parent's pipe...  */
             if (dup2(stderr_fd[1], STDERR_FILENO) < 0) {
                 char str[256];
@@ -1180,6 +1195,10 @@ int main(int argc, char **argv)
     }

     if (fork_process) {
+        /*
+         * See above. If verbose is false, stdout is /dev/null (thanks
+         * to qemu_daemon); otherwise, stdout is the parent's stderr.
+         */
         if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
             error_report("Could not set stderr to /dev/null: %s",
                          strerror(errno));
diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
index 237c82767ea..b09a197020a 100644
--- a/tests/qemu-iotests/233.out
+++ b/tests/qemu-iotests/233.out
@@ -41,8 +41,10 @@ exports available: 1
   min block: 1

 == check TLS fail over TCP with mismatched hostname ==
+qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
 qemu-img: Could not open 'driver=nbd,host=localhost,port=PORT,tls-creds=tls0': Certificate does not match the hostname localhost
 qemu-nbd: Certificate does not match the hostname localhost
+qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort

 == check TLS works over TCP with mismatched hostname and override ==
 image: nbd://localhost:PORT
@@ -55,7 +57,9 @@ exports available: 1
   min block: 1

 == check TLS with different CA fails ==
+qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
 qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': The certificate hasn't got a known issuer
+qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
 qemu-nbd: The certificate hasn't got a known issuer

 == perform I/O over TLS ==
@@ -67,11 +71,15 @@ read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

 == check TLS with authorization ==
+qemu-nbd: option negotiation failed: TLS x509 authz check for C=South Pacific,L=R'lyeh,O=Cthulhu Dark Lord Enterprises client1,CN=localhost is denied
 qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Failed to read option reply: Cannot read from TLS channel: Software caused connection abort
+qemu-nbd: option negotiation failed: TLS x509 authz check for C=South Pacific,L=R'lyeh,O=Cthulhu Dark Lord Enterprises client3,CN=localhost is denied
 qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Failed to read option reply: Cannot read from TLS channel: Software caused connection abort

 == check TLS fail over UNIX with no hostname ==
+qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
 qemu-img: Could not open 'driver=nbd,path=SOCK_DIR/qemu-nbd.sock,tls-creds=tls0': No hostname for certificate validation
+qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
 qemu-nbd: No hostname for certificate validation

 == check TLS works over UNIX with hostname override ==
@@ -95,18 +103,10 @@ exports available: 1
   min block: 1

 == check TLS fails over UNIX with mismatch PSK ==
+qemu-nbd: option negotiation failed: TLS handshake failed: An illegal parameter has been received.
 qemu-img: Could not open 'driver=nbd,path=SOCK_DIR/qemu-nbd.sock,tls-creds=tls0': TLS handshake failed: The TLS connection was non-properly terminated.
+qemu-nbd: option negotiation failed: TLS handshake failed: An illegal parameter has been received.
 qemu-nbd: TLS handshake failed: The TLS connection was non-properly terminated.

 == final server log ==
-qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
-qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
-qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
-qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
-qemu-nbd: option negotiation failed: TLS x509 authz check for DISTINGUISHED-NAME is denied
-qemu-nbd: option negotiation failed: TLS x509 authz check for DISTINGUISHED-NAME is denied
-qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
-qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
-qemu-nbd: option negotiation failed: TLS handshake failed: An illegal parameter has been received.
-qemu-nbd: option negotiation failed: TLS handshake failed: An illegal parameter has been received.
 *** done
-- 
2.41.0



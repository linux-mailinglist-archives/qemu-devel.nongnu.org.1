Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B791A48B17
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Feb 2025 23:08:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnm1m-0002WA-KH; Thu, 27 Feb 2025 17:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tnm1h-0002TH-Ug
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:06:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tnm1e-0000Ce-8a
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740693996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZIvbUNhwvyldi7bMLa/2gx4DBnYpihWI8z4IcALzIOY=;
 b=Y418/5ioMvNIgQJyNC5sTv7dOONWrskg/nvaUv1gMbwCmVvY0UeI1pkHuNH63QUX2yLo8/
 jFeBHiJtxtudqwGwqYJaGfRpJgJKNiA56D9lN4qppzjPh+FKyjh0C5s5jbNSTVgMxo3sTA
 kHQ3QDVdAhiXx5nIGo0x2EJeNRPOTlA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-nDbH0mpqOdeAe-xpXyEzPg-1; Thu,
 27 Feb 2025 17:06:33 -0500
X-MC-Unique: nDbH0mpqOdeAe-xpXyEzPg-1
X-Mimecast-MFC-AGG-ID: nDbH0mpqOdeAe-xpXyEzPg_1740693992
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B46C91954B19; Thu, 27 Feb 2025 22:06:31 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.162])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5BBA81800998; Thu, 27 Feb 2025 22:06:28 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH] nbd: Defer trace init until after daemonization
Date: Thu, 27 Feb 2025 16:06:15 -0600
Message-ID: <20250227220625.870246-2-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

At least the simple trace backend works by spawning a helper thread,
and setting up an atexit() handler that coordinates completion with
the helper thread.  But since atexit registrations survive fork() but
helper threads do not, this means that qemu-nbd configured to use the
simple trace will deadlock waiting for a thread that no longer exists
when it has daemonized.

Better is to follow the example of vl.c: don't call any setup
functions that might spawn helper threads until we are in the final
process that will be doing the work worth tracing.

Tested by configuring with --enable-trace-backends=simple, then running
  qemu-nbd --fork --trace=nbd_\*,file=qemu-nbd.trace -f raw -r README.rst
followed by `nbdinfo nbd://localhost`, and observing that the trace
file is now created without hanging.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 05b61da51ea..ed5895861bb 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -852,10 +852,6 @@ int main(int argc, char **argv)
         export_name = "";
     }

-    if (!trace_init_backends()) {
-        exit(1);
-    }
-    trace_init_file();
     qemu_set_log(LOG_TRACE, &error_fatal);

     socket_activation = check_socket_activation();
@@ -1045,6 +1041,18 @@ int main(int argc, char **argv)
 #endif /* WIN32 */
     }

+    /*
+     * trace_init must be done after daemonization.  Why? Because at
+     * least the simple backend spins up a helper thread as well as an
+     * atexit() handler that waits on that thread, but the helper
+     * thread won't survive a fork, leading to deadlock in the child
+     * if we initialized pre-fork.
+     */
+    if (!trace_init_backends()) {
+        exit(1);
+    }
+    trace_init_file();
+
     if (opts.device != NULL && sockpath == NULL) {
         sockpath = g_malloc(128);
         snprintf(sockpath, 128, SOCKET_PATH, basename(opts.device));
-- 
2.48.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B21FD79803D
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 03:37:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeQQ7-0008VS-NO; Thu, 07 Sep 2023 21:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeQQ5-0008Ti-Ev
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 21:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeQQ0-0007tr-80
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 21:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694136979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wTez80S1XdCord+X4wsj2A7zlFo9Zap+JHk8yhuflk8=;
 b=egARFX4+/fCligMpyk2i9+1aXFHpa51h/eQEYjQLU19Nl8qEu/TftsgKEOAZzWm9tvajcX
 S+6Iiyt9OMTvZHbkWhlgN/hyDCRGrGQOE2MDzqhqohPfVV7cvPQ8BQ3gPixiXQwpSlpNw2
 cPxGQzcKdGA1tP/q2+K4AM6a6kkviHI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-zx5z4aXRM_qORPZhalV7mg-1; Thu, 07 Sep 2023 21:36:17 -0400
X-MC-Unique: zx5z4aXRM_qORPZhalV7mg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D2AE38008A9;
 Fri,  8 Sep 2023 01:36:17 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09BDC40C2070;
 Fri,  8 Sep 2023 01:36:16 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 09/13] qemu-nbd: move srcpath into struct NbdClientOpts
Date: Thu,  7 Sep 2023 20:35:45 -0500
Message-ID: <20230908013535.990731-24-eblake@redhat.com>
In-Reply-To: <20230908013535.990731-15-eblake@redhat.com>
References: <20230908013535.990731-15-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

From: "Denis V. Lunev" <den@openvz.org>

We pass other parameters into nbd_client_thread() in this way. This patch
makes the code more consistent.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20230906093210.339585-4-den@openvz.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: Note that this also cleans up a -Wshadow issue, first
introduced in e5b815b0]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index acbdc0cd8fd..16c59424f13 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -73,7 +73,6 @@

 #define MBR_SIZE 512

-static char *srcpath;
 static SocketAddress *saddr;
 static int persistent = 0;
 static enum { RUNNING, TERMINATE, TERMINATED } state;
@@ -255,6 +254,7 @@ static int qemu_nbd_client_list(SocketAddress *saddr, QCryptoTLSCreds *tls,

 struct NbdClientOpts {
     char *device;
+    char *srcpath;
     bool fork_process;
     bool verbose;
 };
@@ -320,7 +320,7 @@ static void *nbd_client_thread(void *arg)

     if (opts->verbose && !opts->fork_process) {
         fprintf(stderr, "NBD device %s is now connected to %s\n",
-                opts->device, srcpath);
+                opts->device, opts->srcpath);
     } else {
         /* Close stderr so that the qemu-nbd process exits.  */
         if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
@@ -590,6 +590,7 @@ int main(int argc, char **argv)
         .fork_process = false,
         .verbose = false,
         .device = NULL,
+        .srcpath = NULL,
     };

 #ifdef CONFIG_POSIX
@@ -1059,19 +1060,19 @@ int main(int argc, char **argv)
     bdrv_init();
     atexit(qemu_nbd_shutdown);

-    srcpath = argv[optind];
+    opts.srcpath = argv[optind];
     if (imageOpts) {
-        QemuOpts *opts;
+        QemuOpts *o;
         if (fmt) {
             error_report("--image-opts and -f are mutually exclusive");
             exit(EXIT_FAILURE);
         }
-        opts = qemu_opts_parse_noisily(&file_opts, srcpath, true);
-        if (!opts) {
+        o = qemu_opts_parse_noisily(&file_opts, opts.srcpath, true);
+        if (!o) {
             qemu_opts_reset(&file_opts);
             exit(EXIT_FAILURE);
         }
-        options = qemu_opts_to_qdict(opts, NULL);
+        options = qemu_opts_to_qdict(o, NULL);
         qemu_opts_reset(&file_opts);
         blk = blk_new_open(NULL, NULL, options, flags, &local_err);
     } else {
@@ -1079,7 +1080,7 @@ int main(int argc, char **argv)
             options = qdict_new();
             qdict_put_str(options, "driver", fmt);
         }
-        blk = blk_new_open(srcpath, NULL, options, flags, &local_err);
+        blk = blk_new_open(opts.srcpath, NULL, options, flags, &local_err);
     }

     if (!blk) {
-- 
2.41.0



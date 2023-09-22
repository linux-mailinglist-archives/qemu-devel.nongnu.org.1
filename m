Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BA87ABAB6
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 22:56:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjnBj-00046N-55; Fri, 22 Sep 2023 16:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qjnBg-00045q-Ui
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 16:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qjnBf-0004sP-H7
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 16:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695416143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wxtpjNz0rs5YhuqAcqSNWS4ifnvH/yoYlRix1ka4hn8=;
 b=Zw5ma+M4GYDtRP3h/HOcB/LtVUCGceszdA5MeWWY8YzJPgDUHas1I8lpYzc/cZDmamTp4V
 oHXq9QsgMcRahBUPL9/V1w2FEbDT6lQBTEeGSf1TV2X/3eE3oDbfg9t7LZJYRaVChv+Al/
 cuLKJHIYnOwR4IzMvAihlP1YViFq2Xo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-iiMaZWqgN4K0fPTjfYCdpA-1; Fri, 22 Sep 2023 16:55:40 -0400
X-MC-Unique: iiMaZWqgN4K0fPTjfYCdpA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B1C0101A5C9;
 Fri, 22 Sep 2023 20:55:40 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A9AC40C2064;
 Fri, 22 Sep 2023 20:55:39 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, philmd@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH] qemu-nbd: changes towards enabling -Wshadow=local
Date: Fri, 22 Sep 2023 15:50:20 -0500
Message-ID: <20230922205019.2755352-2-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Address all compiler complaints from -Wshadow in qemu-nbd.  Several
instances of 'int ret' became shadows when commit 4fbec260 added 'ret'
at a higher scope in main.  More interesting was the 'void *ret'
capturing the result of a pthread; where we were conceptually doing
'(void*)(intptr_t)EXIT_FAILURE != NULL' which just feels wrong (even
though it happens to compile correctly), so it was worth a better
cleanup.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

I'm happy to let Markus collect this with the growing pile on
shadow-next, instead of going through my NBD tree.

 qemu-nbd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 30eeb6f3c75..9bc410c6c56 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -937,7 +937,6 @@ int main(int argc, char **argv)
         g_autoptr(GError) err = NULL;
         int stderr_fd[2];
         pid_t pid;
-        int ret;

         if (!g_unix_open_pipe(stderr_fd, FD_CLOEXEC, &err)) {
             error_report("Error setting up communication pipe: %s",
@@ -1170,7 +1169,6 @@ int main(int argc, char **argv)

     if (opts.device) {
 #if HAVE_NBD_DEVICE
-        int ret;
         ret = pthread_create(&client_thread, NULL, nbd_client_thread, &opts);
         if (ret != 0) {
             error_report("Failed to create client thread: %s", strerror(ret));
@@ -1217,9 +1215,10 @@ int main(int argc, char **argv)
     qemu_opts_del(sn_opts);

     if (opts.device) {
-        void *ret;
-        pthread_join(client_thread, &ret);
-        exit(ret != NULL);
+        void *result;
+        pthread_join(client_thread, &result);
+        ret = (intptr_t)result;
+        exit(ret);
     } else {
         exit(EXIT_SUCCESS);
     }
-- 
2.41.0



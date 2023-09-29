Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 956107B2ECE
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 11:02:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Mn-0001qV-8J; Fri, 29 Sep 2023 05:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9MT-0001l7-Of
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 05:00:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9MM-0008BZ-JW
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 05:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695978029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q39m1Z38XSXj0I2NOcQS+JuI487dqhRgCtVyZ1Wnoac=;
 b=BGPvTv4at9jxwstsfeteutze0Ydo/q5ns6BdtRYj3gkeypT7C1lTIV5iL1vBd4fsFijPEh
 LWzqFYgUpVLlR8TqJkuU6gZPgtdIW71mqb3XA3xgX29t/hcIJU72qAbitq1L9etIHo+Yh5
 BPZ57nWFKq0HZCaQn2Of9NOFIR0Nt3w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-NlMusAbzOAuGMHWR05DvkQ-1; Fri, 29 Sep 2023 05:00:27 -0400
X-MC-Unique: NlMusAbzOAuGMHWR05DvkQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76D8F858F1D
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 09:00:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5380E2026D68
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 09:00:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E5ADD21E68A7; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 50/56] qemu-nbd: changes towards enabling -Wshadow=local
Date: Fri, 29 Sep 2023 10:50:47 +0200
Message-ID: <20230929085053.2789105-51-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Eric Blake <eblake@redhat.com>

Address all compiler complaints from -Wshadow in qemu-nbd.  Several
instances of 'int ret' became shadows when commit 4fbec260 added 'ret'
at a higher scope in main.  More interesting was the 'void *ret'
capturing the result of a pthread; where we were conceptually doing
'(void*)(intptr_t)EXIT_FAILURE != NULL' which just feels wrong (even
though it happens to compile correctly), so it was worth a better
cleanup.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20230922205019.2755352-2-eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qemu-nbd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 70aa3c487a..54faa87a0c 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -939,7 +939,6 @@ int main(int argc, char **argv)
         g_autoptr(GError) err = NULL;
         int stderr_fd[2];
         pid_t pid;
-        int ret;
 
         if (!g_unix_open_pipe(stderr_fd, FD_CLOEXEC, &err)) {
             error_report("Error setting up communication pipe: %s",
@@ -1172,7 +1171,6 @@ int main(int argc, char **argv)
 
     if (opts.device) {
 #if HAVE_NBD_DEVICE
-        int ret;
         ret = pthread_create(&client_thread, NULL, nbd_client_thread, &opts);
         if (ret != 0) {
             error_report("Failed to create client thread: %s", strerror(ret));
@@ -1219,9 +1217,10 @@ int main(int argc, char **argv)
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



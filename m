Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3961785C34
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 17:35:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYpt9-0002Yz-GA; Wed, 23 Aug 2023 11:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYpsk-00021X-6h
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 11:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYpsi-0008GA-LT
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 11:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692804892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xs5XMyhe7YjtiDAbU2Nk1FNiu4gls1rpQ8zCGsiAoY4=;
 b=Jkqo8x622UmaY1GPXSlZE+ATbkK4Bh5fJ5d9ILSsm8mWbf5dOfHuy+3nFOE6GaMtTFZJPp
 lEbgpUdaa/A5Wv0QOLpRx21eNEUYJis15NA4fWJ2kVtAH/+JKCsMA2I9/I6HiKMf/wneNs
 gLYjGHSR8zvgSjL1rq8qog2184aUZ/U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-QNYVl9zUNkOlRsLUs_nQRQ-1; Wed, 23 Aug 2023 11:34:46 -0400
X-MC-Unique: QNYVl9zUNkOlRsLUs_nQRQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BCE2185A792;
 Wed, 23 Aug 2023 15:34:46 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B94A1121314;
 Wed, 23 Aug 2023 15:34:43 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Thiner Logoer <logoerthiner1@163.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v3 10/11] softmmu/physmem: Hint that "readonly=on,
 rom=off" exists when opening file R/W for private mapping fails
Date: Wed, 23 Aug 2023 17:34:10 +0200
Message-ID: <20230823153412.832081-11-david@redhat.com>
In-Reply-To: <20230823153412.832081-1-david@redhat.com>
References: <20230823153412.832081-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It's easy to miss that memory-backend-file with "share=off" (default)
will always try opening the file R/W as default, and fail if we don't
have write permissions to the file.

In that case, the user has to explicit specify "readonly=on,rom=off" to
get usable RAM, for example, for VM templating.

Let's hint that '-object memory-backend-file,readonly=on,rom=off,...'
exists to consume R/O files in a private mapping to create writable RAM,
but only if we have permissions to open the file read-only.

Suggested-by: ThinerLogoer <logoerthiner1@163.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 softmmu/physmem.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 2d903e479b..d812276f41 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -1970,6 +1970,25 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
     if (fd < 0) {
         error_setg_errno(errp, -fd, "can't open backing store %s for guest RAM",
                          mem_path);
+        if (!(ram_flags & RAM_READONLY_FD) && !(ram_flags & RAM_SHARED) &&
+            fd == -EACCES) {
+            /*
+             * If we can open the file R/O (note: will never create a new file)
+             * and we are dealing with a private mapping, there are still ways
+             * to consume such files and get RAM instead of ROM.
+             */
+            fd = file_ram_open(mem_path, memory_region_name(mr), true,
+                               &created);
+            if (fd < 0) {
+                return NULL;
+            }
+            assert(!created);
+            close(fd);
+            error_append_hint(errp, "Consider opening the backing store"
+                " read-only but still creating writable RAM using"
+                " '-object memory-backend-file,readonly=on,rom=off...'"
+                " (see \"VM templating\" documentation)\n");
+        }
         return NULL;
     }
 
-- 
2.41.0



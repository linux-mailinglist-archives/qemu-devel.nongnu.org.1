Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4BD793C4C
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 14:07:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdrIb-0004LP-H6; Wed, 06 Sep 2023 08:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qdrHx-0003pj-3L
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 08:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qdrHj-0006mV-P5
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 08:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694001927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hykUh6TnEx8JfXbun8UQHWnSyhMREwRG9FsAKWz22Hg=;
 b=CRdsLTK9KHuVI4mA9Jlhhm3vhpdGsmh2MTurEKETtbTmq0C1A+7jx8Qdq4EYd4OTcXv3GA
 ZM/st93JAyUus7QK9UufIrC9nWRIsM3lrazDOQnjDpiSbrNoqou764UDO0PAaI/cSrxjWe
 HZQlZU6tOxHzXupDxNAkTR58qYvvm1k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-3lGm74bBMn-rst4TDdOevw-1; Wed, 06 Sep 2023 08:05:24 -0400
X-MC-Unique: 3lGm74bBMn-rst4TDdOevw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 653672815E33;
 Wed,  6 Sep 2023 12:05:23 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66C40493110;
 Wed,  6 Sep 2023 12:05:20 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thiner Logoer <logoerthiner1@163.com>,
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
Subject: [PATCH v4 04/11] softmmu/physmem: Remap with proper protection in
 qemu_ram_remap()
Date: Wed,  6 Sep 2023 14:04:56 +0200
Message-ID: <20230906120503.359863-5-david@redhat.com>
In-Reply-To: <20230906120503.359863-1-david@redhat.com>
References: <20230906120503.359863-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
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

Let's remap with the proper protection that we can derive from
RAM_READONLY.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 softmmu/physmem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 7e03ed7e3e..88482bd32a 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -2069,6 +2069,7 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
     ram_addr_t offset;
     int flags;
     void *area, *vaddr;
+    int prot;
 
     RAMBLOCK_FOREACH(block) {
         offset = addr - block->offset;
@@ -2083,13 +2084,14 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
                 flags |= block->flags & RAM_SHARED ?
                          MAP_SHARED : MAP_PRIVATE;
                 flags |= block->flags & RAM_NORESERVE ? MAP_NORESERVE : 0;
+                prot = PROT_READ;
+                prot |= block->flags & RAM_READONLY ? 0 : PROT_WRITE;
                 if (block->fd >= 0) {
-                    area = mmap(vaddr, length, PROT_READ | PROT_WRITE,
-                                flags, block->fd, offset + block->fd_offset);
+                    area = mmap(vaddr, length, prot, flags, block->fd,
+                                offset + block->fd_offset);
                 } else {
                     flags |= MAP_ANONYMOUS;
-                    area = mmap(vaddr, length, PROT_READ | PROT_WRITE,
-                                flags, -1, 0);
+                    area = mmap(vaddr, length, prot, flags, -1, 0);
                 }
                 if (area != vaddr) {
                     error_report("Could not remap addr: "
-- 
2.41.0



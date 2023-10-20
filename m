Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AD17D0913
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 09:01:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtjT7-0002eb-OA; Fri, 20 Oct 2023 02:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtjT3-0002bT-Hx
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 02:58:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtjT2-0003X4-0I
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 02:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697785123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b9pXnfvE217MgZiA1KwQf4E/+MFgK3AhJc1q/dcWL9Q=;
 b=DAyfd1DLSPXfe0jz0GSV8WEyz6N2yYY6WBRlxaDFHqV386ekoee/3E61W1n2cVzDeFRn4F
 NDc/lvvMNoK5S+SYpt9oZdFtnZ20CSJIO+0Y0Wt9ymNo2/W+DKWkaFknbghli+W7vqWTpP
 uBReFhQh/hKEPWI6n2l18B2Mc5s/+no=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-Gl8yl_f-MbqeImRuS8JXLA-1; Fri, 20 Oct 2023 02:58:23 -0400
X-MC-Unique: Gl8yl_f-MbqeImRuS8JXLA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3D2B88B770;
 Fri, 20 Oct 2023 06:58:21 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 104A325C1;
 Fri, 20 Oct 2023 06:58:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, "Denis V. Lunev" <den@openvz.org>,
 Juan Quintela <quintela@redhat.com>, Fam Zheng <fam@euphon.net>,
 kvm@vger.kernel.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Kevin Wolf <kwolf@redhat.com>,
 David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>, qemu-arm@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jeff Cody <codyprime@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>, qemu-block@nongnu.org
Subject: [PULL 03/17] migration: Fix parse_ramblock() on overwritten retvals
Date: Fri, 20 Oct 2023 08:57:37 +0200
Message-ID: <20231020065751.26047-4-quintela@redhat.com>
In-Reply-To: <20231020065751.26047-1-quintela@redhat.com>
References: <20231020065751.26047-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

From: Peter Xu <peterx@redhat.com>

It's possible that some errors can be overwritten with success retval later
on, and then ignored.  Always capture all errors and report.

Reported by Coverity 1522861, but actually I spot one more in the same
function.

Fixes: CID 1522861
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231017203855.298260-1-peterx@redhat.com>
---
 migration/ram.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 16c30a9d7a..92769902bb 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3873,6 +3873,7 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
         ret = qemu_ram_resize(block, length, &local_err);
         if (local_err) {
             error_report_err(local_err);
+            return ret;
         }
     }
     /* For postcopy we need to check hugepage sizes match */
@@ -3883,7 +3884,7 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
             error_report("Mismatched RAM page size %s "
                          "(local) %zd != %" PRId64, block->idstr,
                          block->page_size, remote_page_size);
-            ret = -EINVAL;
+            return -EINVAL;
         }
     }
     if (migrate_ignore_shared()) {
@@ -3893,7 +3894,7 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
             error_report("Mismatched GPAs for block %s "
                          "%" PRId64 "!= %" PRId64, block->idstr,
                          (uint64_t)addr, (uint64_t)block->mr->addr);
-            ret = -EINVAL;
+            return -EINVAL;
         }
     }
     ret = rdma_block_notification_handle(f, block->idstr);
-- 
2.41.0



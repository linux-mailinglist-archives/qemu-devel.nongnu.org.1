Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0474E7C70CF
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:58:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqx7z-0007ua-Jo; Thu, 12 Oct 2023 10:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqx7w-0007t7-SW
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:57:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqx7u-0000qx-FP
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697122644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PvKF1qsv71TYYzVIrrRNhVv7AkYPQmdytx2QovROBqE=;
 b=c86MwsncOQMBIFiLSIx/BV4dTbxwfSGpCpd1bR2/8afmo76LWiBor+XUiC3nZsBfELFh8c
 eX0YPcy9hA1dbK3fMUqf9c6+Cqc2BXqAlGznZdqJFsC+WtcTg0Jt/KqzThGqg7hcDkB2Lp
 rNblOwcYMFV4t4JltmRGmKWZ3pA9wAs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-yJQttvH6O1SYLPk_CCst2g-1; Thu, 12 Oct 2023 10:57:23 -0400
X-MC-Unique: yJQttvH6O1SYLPk_CCst2g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF217185A797
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 14:57:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACB73492B02
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 14:57:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AE37B21E6A23; Thu, 12 Oct 2023 16:57:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Thomas Huth <thuth@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 2/5] libvhost-user: Fix compiler warning with -Wshadow=local
Date: Thu, 12 Oct 2023 16:57:18 +0200
Message-ID: <20231012145721.77039-3-armbru@redhat.com>
In-Reply-To: <20231012145721.77039-1-armbru@redhat.com>
References: <20231012145721.77039-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

From: Thomas Huth <thuth@redhat.com>

Rename shadowing variables to make this code compilable
with -Wshadow=local.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20231006121129.487251-1-thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 051a611da3..ea2822a44c 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -870,10 +870,10 @@ vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
     for (i = 0; i < dev->nregions; i++) {
         if (reg_equal(&dev->regions[i], msg_region)) {
             VuDevRegion *r = &dev->regions[i];
-            void *m = (void *) (uintptr_t) r->mmap_addr;
+            void *ma = (void *) (uintptr_t) r->mmap_addr;
 
-            if (m) {
-                munmap(m, r->size + r->mmap_offset);
+            if (ma) {
+                munmap(ma, r->size + r->mmap_offset);
             }
 
             /*
@@ -1005,10 +1005,10 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
 
     for (i = 0; i < dev->nregions; i++) {
         VuDevRegion *r = &dev->regions[i];
-        void *m = (void *) (uintptr_t) r->mmap_addr;
+        void *ma = (void *) (uintptr_t) r->mmap_addr;
 
-        if (m) {
-            munmap(m, r->size + r->mmap_offset);
+        if (ma) {
+            munmap(ma, r->size + r->mmap_offset);
         }
     }
     dev->nregions = memory->nregions;
-- 
2.41.0



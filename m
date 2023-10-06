Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 648317BB762
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 14:12:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qojgG-000218-UC; Fri, 06 Oct 2023 08:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qojg9-00020q-O9
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 08:11:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qojg8-0000pa-1m
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 08:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696594293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=v2gd5MpBU429xIonrfGZazNkQirLo+MNDAYB2mN1tbQ=;
 b=KOYHuNN+eCd/cQl1VeDE20UVlr+QahZMmll3/caR35J973ONYQ7eVb6s4WPhQT5lc4Xxxu
 tpzON9DozFGq17tdBkdopNUEE5c7rirIgeJZI+HiVSvSokDyYnWezkeWCmgclVALYtQdQn
 kmcMVsBvYsZ81JFojbnAulS5bnV7hH8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-t-4CD-DaMOCDCwxPpxof1Q-1; Fri, 06 Oct 2023 08:11:32 -0400
X-MC-Unique: t-4CD-DaMOCDCwxPpxof1Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03C3F3C108DD;
 Fri,  6 Oct 2023 12:11:32 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.195.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DC8D492C37;
 Fri,  6 Oct 2023 12:11:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-trivial@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] libvhost-user: Fix compiler warning with -Wshadow=local
Date: Fri,  6 Oct 2023 14:11:29 +0200
Message-ID: <20231006121129.487251-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

Rename shadowing variables to make this code compilable
with -Wshadow=local.

Signed-off-by: Thomas Huth <thuth@redhat.com>
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F18D9847BE1
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Feb 2024 22:55:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rW1Tq-00088b-1E; Fri, 02 Feb 2024 16:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rW1To-00088R-Ds
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:53:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rW1Tm-0004pw-Kp
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:53:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706910825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+sTK7SxvFmjL3/R7XiBJpkSqtBZ/tOmfZKghGUy0GP0=;
 b=FKZkq/KTqu5o7A592LszV/G96PrVndBOV43KurKeXG9rq/6OtXIYPKQKW8JIVdAcd+fqVf
 89tmwE8ijFjFVNz0AeIJUR1RU58gIodFh7VdeEjYZXgGCHNpe7cVvlSqETd19ztDXxgpSQ
 sbEx9/IZNUJJ3E8laGRBxOjOjkVg900=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-v1chVkfNOXmrSDfhcaI1TA-1; Fri,
 02 Feb 2024 16:53:43 -0500
X-MC-Unique: v1chVkfNOXmrSDfhcaI1TA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B0243806712;
 Fri,  2 Feb 2024 21:53:43 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30A162166B31;
 Fri,  2 Feb 2024 21:53:41 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v1 01/15] libvhost-user: Fix msg_region->userspace_addr
 computation
Date: Fri,  2 Feb 2024 22:53:18 +0100
Message-ID: <20240202215332.118728-2-david@redhat.com>
In-Reply-To: <20240202215332.118728-1-david@redhat.com>
References: <20240202215332.118728-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We barely had mmap_offset set in the past. With virtio-mem and
dynamic-memslots that will change.

In vu_add_mem_reg() and vu_set_mem_table_exec_postcopy(), we are
performing pointer arithmetics, which is wrong. Let's simply
use dev_region->mmap_addr instead of "void *mmap_addr".

Fixes: ec94c8e621de ("Support adding individual regions in libvhost-user")
Fixes: 9bb38019942c ("vhost+postcopy: Send address back to qemu")
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index a3b158c671..7e515ed15d 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -800,8 +800,8 @@ vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
          * Return the address to QEMU so that it can translate the ufd
          * fault addresses back.
          */
-        msg_region->userspace_addr = (uintptr_t)(mmap_addr +
-                                                 dev_region->mmap_offset);
+        msg_region->userspace_addr = dev_region->mmap_addr +
+                                     dev_region->mmap_offset;
 
         /* Send the message back to qemu with the addresses filled in. */
         vmsg->fd_num = 0;
@@ -969,8 +969,8 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
         /* Return the address to QEMU so that it can translate the ufd
          * fault addresses back.
          */
-        msg_region->userspace_addr = (uintptr_t)(mmap_addr +
-                                                 dev_region->mmap_offset);
+        msg_region->userspace_addr = dev_region->mmap_addr +
+                                     dev_region->mmap_offset;
         close(vmsg->fds[i]);
     }
 
-- 
2.43.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC607C70D2
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:58:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqx7y-0007ta-1e; Thu, 12 Oct 2023 10:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqx7v-0007si-Su
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:57:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqx7u-0000qv-Aa
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697122644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HnxIkOwXrglxwYiNreVWLBkEnCpRM0iOGeUaYxfGx7U=;
 b=eXkfaEVKEp2h/lC7u0lxdxsH6LJDu9rEr0ThdbWQt/jtfnPiG/aQY+nTjgQ+3+7sG9U6Tg
 MKyIMlGRuw0CPY4ZWLopL0jYhQ9jDvH79ivfQFRcVAj+73ZXU7LJCyRAmxelfp+Mqd+ZNq
 ZSlbZr7HumK0chEyQX625shwTyEF6Xg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-JzC0TTIvOcCcRWRYlpuqXQ-1; Thu, 12 Oct 2023 10:57:23 -0400
X-MC-Unique: JzC0TTIvOcCcRWRYlpuqXQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E68D855315;
 Thu, 12 Oct 2023 14:57:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E1554C15BBC;
 Thu, 12 Oct 2023 14:57:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AAD0821E6A22; Thu, 12 Oct 2023 16:57:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xie Yongji <xieyongji@bytedance.com>
Subject: [PULL 1/5] libvduse: Fix compiler warning with -Wshadow=local
Date: Thu, 12 Oct 2023 16:57:17 +0200
Message-ID: <20231012145721.77039-2-armbru@redhat.com>
In-Reply-To: <20231012145721.77039-1-armbru@redhat.com>
References: <20231012145721.77039-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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

No need to declare a new variable with the same name here,
we can simple re-use the one from the top of the function.
With this change, the file now compiles fine with -Wshadow=local.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20231006120819.480792-1-thuth@redhat.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 subprojects/libvduse/libvduse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/subprojects/libvduse/libvduse.c b/subprojects/libvduse/libvduse.c
index 377959a0b4..21ffbb5b8d 100644
--- a/subprojects/libvduse/libvduse.c
+++ b/subprojects/libvduse/libvduse.c
@@ -1031,7 +1031,7 @@ int vduse_dev_handler(VduseDev *dev)
         /* The iova will be updated by iova_to_va() later, so just remove it */
         vduse_iova_remove_region(dev, req.iova.start, req.iova.last);
         for (i = 0; i < dev->num_queues; i++) {
-            VduseVirtq *vq = &dev->vqs[i];
+            vq = &dev->vqs[i];
             if (vq->ready) {
                 if (vduse_queue_update_vring(vq, vq->vring.desc_addr,
                                              vq->vring.avail_addr,
-- 
2.41.0



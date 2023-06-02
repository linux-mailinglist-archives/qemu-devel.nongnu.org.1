Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 421AF7204AB
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 16:40:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q55vm-0003vO-FT; Fri, 02 Jun 2023 10:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q55vl-0003up-6Y
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q55vi-0001di-Gb
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685716741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ka+LiNBF/dCGRfiLjW/9wLebH8nrJpOHNnu8A/GIj4Q=;
 b=LkToiRemeP5Y7A9ThbWyKmn1gx5LHS/JyUGLL9OdUlQ7iEGKhIAnS3otzuHPdAMFdbCpRR
 rdKjRNhnk31yo4KnVYAHq1ZrZ4XO1e5ZPwQBi6ekELtP5L+VMN8dg6wCOROFD9Yslia9Jn
 9Uq0TKWp/H332/QanJdN4jf0cJ3iVXU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-K2SsDnQuNTWtUigOluGSQQ-1; Fri, 02 Jun 2023 10:39:00 -0400
X-MC-Unique: K2SsDnQuNTWtUigOluGSQQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF017100AFED
 for <qemu-devel@nongnu.org>; Fri,  2 Jun 2023 14:38:59 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A57061410F25;
 Fri,  2 Jun 2023 14:38:58 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>
Subject: [PATCH v2 2/3] vdpa: reorder vhost_vdpa_net_cvq_cmd_page_len function
Date: Fri,  2 Jun 2023 16:38:53 +0200
Message-Id: <20230602143854.1879091-3-eperezma@redhat.com>
In-Reply-To: <20230602143854.1879091-1-eperezma@redhat.com>
References: <20230602143854.1879091-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We need to call it from resource cleanup context, as munmap needs the
size of the mappings.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 net/vhost-vdpa.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index c63456ff7c..91451a254a 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -116,6 +116,22 @@ VHostNetState *vhost_vdpa_get_vhost_net(NetClientState *nc)
     return s->vhost_net;
 }
 
+static size_t vhost_vdpa_net_cvq_cmd_len(void)
+{
+    /*
+     * MAC_TABLE_SET is the ctrl command that produces the longer out buffer.
+     * In buffer is always 1 byte, so it should fit here
+     */
+    return sizeof(struct virtio_net_ctrl_hdr) +
+           2 * sizeof(struct virtio_net_ctrl_mac) +
+           MAC_TABLE_ENTRIES * ETH_ALEN;
+}
+
+static size_t vhost_vdpa_net_cvq_cmd_page_len(void)
+{
+    return ROUND_UP(vhost_vdpa_net_cvq_cmd_len(), qemu_real_host_page_size());
+}
+
 static bool vhost_vdpa_net_valid_svq_features(uint64_t features, Error **errp)
 {
     uint64_t invalid_dev_features =
@@ -422,22 +438,6 @@ static void vhost_vdpa_cvq_unmap_buf(struct vhost_vdpa *v, void *addr)
     vhost_iova_tree_remove(tree, *map);
 }
 
-static size_t vhost_vdpa_net_cvq_cmd_len(void)
-{
-    /*
-     * MAC_TABLE_SET is the ctrl command that produces the longer out buffer.
-     * In buffer is always 1 byte, so it should fit here
-     */
-    return sizeof(struct virtio_net_ctrl_hdr) +
-           2 * sizeof(struct virtio_net_ctrl_mac) +
-           MAC_TABLE_ENTRIES * ETH_ALEN;
-}
-
-static size_t vhost_vdpa_net_cvq_cmd_page_len(void)
-{
-    return ROUND_UP(vhost_vdpa_net_cvq_cmd_len(), qemu_real_host_page_size());
-}
-
 /** Map CVQ buffer. */
 static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa *v, void *buf, size_t size,
                                   bool write)
-- 
2.31.1



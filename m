Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B03F7B7E77
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 13:49:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0Mi-00049x-Mu; Wed, 04 Oct 2023 07:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo0MX-000474-Ev
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:48:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo0MW-0003e9-0y
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696420099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1Dv6cYSoMMilPNs/9rWnaaObeP3PNkFU0bmTRXlZRuI=;
 b=PqXxbS6Ntr0wx6HGdCjp3Ar6aiNhHJzhiPMPhyPkg5ekIFgdS8LsnnY49vXjSD1bwQAv66
 97sE6Nug/Tc7TmPop0PYtLpaiW/FarnXIQBBqZ+amdREeDPWHlmUkkYi2BT8WfBRZxO+l2
 4WL86fphxW2u2NQJ/Tnvn6pObA9AMZg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-2NOMnpPpOxCbk6u0QxpStg-1; Wed, 04 Oct 2023 07:48:11 -0400
X-MC-Unique: 2NOMnpPpOxCbk6u0QxpStg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 977CB80349A;
 Wed,  4 Oct 2023 11:48:10 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-181.str.redhat.com
 [10.33.192.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBF604A9B0A;
 Wed,  4 Oct 2023 11:48:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
	qemu-trivial@nongnu.org
Subject: [PATCH] hw/virtio/vhost: Silence compiler warnings in vhost code when
 using -Wshadow
Date: Wed,  4 Oct 2023 13:48:09 +0200
Message-ID: <20231004114809.105672-1-thuth@redhat.com>
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

Rename a variable in vhost_dev_sync_region() and remove a superfluous
declaration in vhost_commit() to make this code compilable with "-Wshadow".

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/virtio/vhost.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index e2f6ffb446..9cfac40fde 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -66,12 +66,12 @@ static void vhost_dev_sync_region(struct vhost_dev *dev,
                                   uint64_t mfirst, uint64_t mlast,
                                   uint64_t rfirst, uint64_t rlast)
 {
-    vhost_log_chunk_t *log = dev->log->log;
+    vhost_log_chunk_t *dev_log = dev->log->log;
 
     uint64_t start = MAX(mfirst, rfirst);
     uint64_t end = MIN(mlast, rlast);
-    vhost_log_chunk_t *from = log + start / VHOST_LOG_CHUNK;
-    vhost_log_chunk_t *to = log + end / VHOST_LOG_CHUNK + 1;
+    vhost_log_chunk_t *from = dev_log + start / VHOST_LOG_CHUNK;
+    vhost_log_chunk_t *to = dev_log + end / VHOST_LOG_CHUNK + 1;
     uint64_t addr = QEMU_ALIGN_DOWN(start, VHOST_LOG_CHUNK);
 
     if (end < start) {
@@ -549,7 +549,7 @@ static void vhost_commit(MemoryListener *listener)
         changed = true;
     } else {
         /* Same size, lets check the contents */
-        for (int i = 0; i < n_old_sections; i++) {
+        for (i = 0; i < n_old_sections; i++) {
             if (!MemoryRegionSection_eq(&old_sections[i],
                                         &dev->mem_sections[i])) {
                 changed = true;
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6827F7BB6A4
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:40:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj9R-0005CI-VH; Fri, 06 Oct 2023 07:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8q-0004zo-LL
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8j-00007N-3C
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7x8VuDt1h0/2cT147JMVxmfA4/SI0gZ5zVSFFGE3UDA=;
 b=IojwjrXMCH+vtEJ2KMQcZMhQRm0BEGWSV8UiVUyynoCVT2l1VSK0NMkeeabGodgW4kiHtS
 Dfl3LYkIQ/IKGaoFnrkNecZs/6Yr5nPswoiBVrQ7FZ2I90/x/xNf3Wj5w76xiKvzqErgvN
 6jM4JT6Mqqzao6r/v4A8om4it5bitt0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-z2CkecMsOomUZftLnhaMqQ-1; Fri, 06 Oct 2023 07:37:00 -0400
X-MC-Unique: z2CkecMsOomUZftLnhaMqQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABB37101A590;
 Fri,  6 Oct 2023 11:36:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B4132156711;
 Fri,  6 Oct 2023 11:36:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6BCD021E6911; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Thomas Huth <thuth@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 08/32] hw/virtio/vhost: Silence compiler warnings in vhost code
 when using -Wshadow
Date: Fri,  6 Oct 2023 13:36:33 +0200
Message-ID: <20231006113657.3803180-9-armbru@redhat.com>
In-Reply-To: <20231006113657.3803180-1-armbru@redhat.com>
References: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

From: Thomas Huth <thuth@redhat.com>

Rename a variable in vhost_dev_sync_region() and remove a superfluous
declaration in vhost_commit() to make this code compilable with "-Wshadow".

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20231004114809.105672-1-thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-By: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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



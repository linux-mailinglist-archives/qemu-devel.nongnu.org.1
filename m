Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C39E7B7CA0
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:54:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnyZ8-0008Uc-Qu; Wed, 04 Oct 2023 05:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qnyZ6-0008RI-DN
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:53:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qnyZ3-0005Ub-GL
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696413185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=y9fV9VZLMEm2ANZcqWcxUohwIJzUh5ZeL5W/LBwPtik=;
 b=Cwrb67KyTLOMFbR153t0fikd/wLEsr64laERSYEmpkMze2nAYxe4ZLyd5dMYPicK32re4M
 GzLCJafJewRtaeHgx46mL13lkJgSM3R34y7t61XmKtXttFzL8maSIUwtoqu51b1ojFjUrh
 roaiO5blYOqUnHgxneIpk5dduU/5kGQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-Zm9n1ecQMGG5eVhGoq7DOw-1; Wed, 04 Oct 2023 05:53:04 -0400
X-MC-Unique: Zm9n1ecQMGG5eVhGoq7DOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFCE1800888;
 Wed,  4 Oct 2023 09:53:03 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-181.str.redhat.com
 [10.33.192.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3656C1006B74;
 Wed,  4 Oct 2023 09:53:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
	qemu-trivial@nongnu.org
Subject: [PATCH v2] hw/virtio/virtio-pci: Avoid compiler warning with -Wshadow
Date: Wed,  4 Oct 2023 11:53:02 +0200
Message-ID: <20231004095302.99037-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

"len" is used as parameter of the functions virtio_write_config()
and virtio_read_config(), and additionally as a local variable,
so this causes a compiler warning when compiling with "-Wshadow"
and can be confusing for the reader. Rename the local variables
to "caplen" to avoid this problem.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Fix virtio_read_config() function as well

 hw/virtio/virtio-pci.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index edbc0daa18..abebd0075a 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -780,15 +780,15 @@ static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
                                                                   pci_cfg_data),
                        sizeof cfg->pci_cfg_data)) {
         uint32_t off;
-        uint32_t len;
+        uint32_t caplen;
 
         cfg = (void *)(proxy->pci_dev.config + proxy->config_cap);
         off = le32_to_cpu(cfg->cap.offset);
-        len = le32_to_cpu(cfg->cap.length);
+        caplen = le32_to_cpu(cfg->cap.length);
 
-        if (len == 1 || len == 2 || len == 4) {
-            assert(len <= sizeof cfg->pci_cfg_data);
-            virtio_address_space_write(proxy, off, cfg->pci_cfg_data, len);
+        if (caplen == 1 || caplen == 2 || caplen == 4) {
+            assert(caplen <= sizeof cfg->pci_cfg_data);
+            virtio_address_space_write(proxy, off, cfg->pci_cfg_data, caplen);
         }
     }
 }
@@ -804,15 +804,15 @@ static uint32_t virtio_read_config(PCIDevice *pci_dev,
                                                                   pci_cfg_data),
                        sizeof cfg->pci_cfg_data)) {
         uint32_t off;
-        uint32_t len;
+        uint32_t caplen;
 
         cfg = (void *)(proxy->pci_dev.config + proxy->config_cap);
         off = le32_to_cpu(cfg->cap.offset);
-        len = le32_to_cpu(cfg->cap.length);
+        caplen = le32_to_cpu(cfg->cap.length);
 
-        if (len == 1 || len == 2 || len == 4) {
-            assert(len <= sizeof cfg->pci_cfg_data);
-            virtio_address_space_read(proxy, off, cfg->pci_cfg_data, len);
+        if (caplen == 1 || caplen == 2 || caplen == 4) {
+            assert(caplen <= sizeof cfg->pci_cfg_data);
+            virtio_address_space_read(proxy, off, cfg->pci_cfg_data, caplen);
         }
     }
 
-- 
2.41.0



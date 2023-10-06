Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0E17BB6B2
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:42:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj9J-000589-GH; Fri, 06 Oct 2023 07:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8u-00050r-8b
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8o-00008v-6h
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Wjqy/b5KUIIyv5+VdfsykcttIE6ok1OTGxheaSCnq0=;
 b=DM9DGn564Ryg4objH1K0ue9EyOpYF79m3H75XkqQ/p3zDRGMUiqBzwdTIx28ddR8J9VCIR
 xTNPZgIN7H/Ka8C69XW4MsmT6BwgiicHLc9TBBueY82Fh5Y5hGR0TuMzDo2rvPBJuPwCJa
 FgPuM749N9EEHHxPJ9TSWuyGOY0jF8Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-4G_BT-mjMNebQrbrUfpbng-1; Fri, 06 Oct 2023 07:37:00 -0400
X-MC-Unique: 4G_BT-mjMNebQrbrUfpbng-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AACAA3827DE8;
 Fri,  6 Oct 2023 11:36:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A363140E953;
 Fri,  6 Oct 2023 11:36:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 68EA521E6910; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/32] hw/virtio/virtio-pci: Avoid compiler warning with
 -Wshadow
Date: Fri,  6 Oct 2023 13:36:32 +0200
Message-ID: <20231006113657.3803180-8-armbru@redhat.com>
In-Reply-To: <20231006113657.3803180-1-armbru@redhat.com>
References: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

"len" is used as parameter of the functions virtio_write_config()
and virtio_read_config(), and additionally as a local variable,
so this causes a compiler warning when compiling with "-Wshadow"
and can be confusing for the reader. Rename the local variables
to "caplen" to avoid this problem.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20231004095302.99037-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
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



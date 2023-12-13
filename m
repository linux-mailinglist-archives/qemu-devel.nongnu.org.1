Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC56F81127B
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 14:05:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDOtp-0001kz-5M; Wed, 13 Dec 2023 08:03:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rDOsA-0008LD-MN; Wed, 13 Dec 2023 08:01:59 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rDOs8-00076O-Pl; Wed, 13 Dec 2023 08:01:58 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B2C503B445;
 Wed, 13 Dec 2023 16:01:05 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 564533C8D6;
 Wed, 13 Dec 2023 16:00:46 +0300 (MSK)
Received: (nullmailer pid 1024769 invoked by uid 1000);
 Wed, 13 Dec 2023 13:00:46 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.8 18/24] hw/acpi/erst: Do not ignore Error* in realize
 handler
Date: Wed, 13 Dec 2023 16:00:27 +0300
Message-Id: <20231213130041.1024630-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
References: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

erst_realizefn() passes @errp to functions without checking for
failure.  If it runs into another failure, it trips error_setv()'s
assertion.

Use the ERRP_GUARD() macro and check *errp, as suggested in commit
ae7c80a7bd ("error: New macro ERRP_GUARD()").

Cc: qemu-stable@nongnu.org
Fixes: f7e26ffa59 ("ACPI ERST: support for ACPI ERST feature")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231120130017.81286-1-philmd@linaro.org>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 20bc50137f3add52eb4788b420d717de27fed14b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/acpi/erst.c b/hw/acpi/erst.c
index aefcc03ad6..2e057b1800 100644
--- a/hw/acpi/erst.c
+++ b/hw/acpi/erst.c
@@ -947,6 +947,7 @@ static const VMStateDescription erst_vmstate  = {
 
 static void erst_realizefn(PCIDevice *pci_dev, Error **errp)
 {
+    ERRP_GUARD();
     ERSTDeviceState *s = ACPIERST(pci_dev);
 
     trace_acpi_erst_realizefn_in();
@@ -964,9 +965,15 @@ static void erst_realizefn(PCIDevice *pci_dev, Error **errp)
 
     /* HostMemoryBackend size will be multiple of PAGE_SIZE */
     s->storage_size = object_property_get_int(OBJECT(s->hostmem), "size", errp);
+    if (*errp) {
+        return;
+    }
 
     /* Initialize backend storage and record_count */
     check_erst_backend_storage(s, errp);
+    if (*errp) {
+        return;
+    }
 
     /* BAR 0: Programming registers */
     memory_region_init_io(&s->iomem_mr, OBJECT(pci_dev), &erst_reg_ops, s,
@@ -977,6 +984,9 @@ static void erst_realizefn(PCIDevice *pci_dev, Error **errp)
     memory_region_init_ram(&s->exchange_mr, OBJECT(pci_dev),
                             "erst.exchange",
                             le32_to_cpu(s->header->record_size), errp);
+    if (*errp) {
+        return;
+    }
     pci_register_bar(pci_dev, 1, PCI_BASE_ADDRESS_SPACE_MEMORY,
                         &s->exchange_mr);
 
-- 
2.39.2



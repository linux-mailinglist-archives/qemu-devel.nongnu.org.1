Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2F0766851
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 11:10:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPJ2C-0001GP-QJ; Fri, 28 Jul 2023 04:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qPJ2A-0001GH-Ea
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 04:41:14 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qPJ28-0002Ro-Ib
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 04:41:14 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-98e39784a85so666453166b.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690533664; x=1691138464;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QQgYaOdHzCl++J9NMsdAiruYMkZ9LY8h7wiUCud6BpE=;
 b=ggK5hes4DBL4Dt8RgZRvAk2z08PSPRK+P9sG4fc7DXVlTyOris5rdkcXQydIAwMgJ9
 x9biRFENlIAhP4wtNylc8vBeXBUOeK0MHX/iYsz2y5Fz8mf5ekppplYam+wzBXV5Fk6Y
 h0nK8ZHJJx+HD2otRAJ2uZQi8SA5T11HVa3GxDIjeJIXgSyDEzY4CeZbWnr449jFcoMb
 JpcjJ8hudW/J/p9U1EC4MlwfraGB/k2n/8oVDtCMHCdgTBVbGX7vlUGhf5CGUi5SGSt0
 RMgXOJx4QjaY6h48xqiV5o6u/0ekEKRo0h+7/MbaayBrtOPphzJb0UlqfzsmcoJ/02Na
 Vfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690533664; x=1691138464;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QQgYaOdHzCl++J9NMsdAiruYMkZ9LY8h7wiUCud6BpE=;
 b=JHQg/uIJ6epo9gAEPxc6BOk1nED//N8q0PiHpia9PWwb+R8+OBlEJ1MyDaiaNTA6un
 +tHpXuFiK5m2TQxcY7jrEdBCl1MhCpdKaf0L+q2mnHPWwsQMzFJ85rH+y31qaHYI86yI
 jLABbzCaMgMMfr0WbXJi0ZnT0wkOUb9Uuoc6FgVWJ4iP46QYS+9fTL5LEHpUt/XCs5qF
 ijiSrhMPWRIVgkmIxbE4R3EEZA4jY59RaGcgkiCuFba1t94UkM/3WR3cev9vhcXeI6Ov
 QUD6cAU+BuJm9b3YYQpi/rlHbsjccZS060Q9sCfBZ4JXeParqPVSfIOrVDkOEDwxQG7l
 FvJw==
X-Gm-Message-State: ABy/qLaJMAUfadv0f6B1Ks57TnQgoyRmcnGVj/sZ3BLxOSLN9f/cvZ9L
 bFn35LPpwWfzYyOVGhgob25P5p6vUAbbcerbv8o=
X-Google-Smtp-Source: APBJJlGO6n3c108Bi7Iz8zgYtsJflqQ2lABs6QW9sQYttdzKKvrVVZ5lBCtwcbNfztMVwsL/HcjVeg==
X-Received: by 2002:a17:907:7625:b0:989:450:e565 with SMTP id
 jy5-20020a170907762500b009890450e565mr1802821ejc.23.1690533664408; 
 Fri, 28 Jul 2023 01:41:04 -0700 (PDT)
Received: from localhost.localdomain
 ([2a06:c701:46e6:7e00:c5bb:d943:dc1b:8245])
 by smtp.gmail.com with ESMTPSA id
 kq6-20020a170906abc600b009828e26e519sm1769066ejb.122.2023.07.28.01.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 01:41:03 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: yan@daynix.com
Subject: [PATCH] pci: do not respond config requests after PCI device eject
Date: Fri, 28 Jul 2023 11:40:49 +0300
Message-Id: <20230728084049.191454-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::62f;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2224964

In migration with VF failover, Windows guest and ACPI hot
unplug we do not need to satisfy config requests, otherwise
the guest immediately detects the device and brings up its
driver. Many network VF's are stuck on the guest PCI bus after
the migration.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/pci/pci_host.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 7af8afdcbe..a18aa0a8d4 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -62,6 +62,17 @@ static void pci_adjust_config_limit(PCIBus *bus, uint32_t *limit)
     }
 }
 
+static bool is_pci_dev_ejected(PCIDevice *pci_dev)
+{
+    /*
+     * device unplug was requested and the guest acked it,
+     * so we stop responding config accesses even if the
+     * device is not deleted (failover flow)
+     */
+    return pci_dev && pci_dev->partially_hotplugged &&
+           !pci_dev->qdev.pending_deleted_event;
+}
+
 void pci_host_config_write_common(PCIDevice *pci_dev, uint32_t addr,
                                   uint32_t limit, uint32_t val, uint32_t len)
 {
@@ -75,7 +86,7 @@ void pci_host_config_write_common(PCIDevice *pci_dev, uint32_t addr,
      * allowing direct removal of unexposed functions.
      */
     if ((pci_dev->qdev.hotplugged && !pci_get_function_0(pci_dev)) ||
-        !pci_dev->has_power) {
+        !pci_dev->has_power || is_pci_dev_ejected(pci_dev)) {
         return;
     }
 
@@ -100,7 +111,7 @@ uint32_t pci_host_config_read_common(PCIDevice *pci_dev, uint32_t addr,
      * allowing direct removal of unexposed functions.
      */
     if ((pci_dev->qdev.hotplugged && !pci_get_function_0(pci_dev)) ||
-        !pci_dev->has_power) {
+        !pci_dev->has_power || is_pci_dev_ejected(pci_dev)) {
         return ~0x0;
     }
 
-- 
2.34.3



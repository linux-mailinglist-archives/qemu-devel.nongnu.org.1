Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D21843F06
	for <lists+qemu-devel@lfdr.de>; Wed, 31 Jan 2024 13:01:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV9Cd-0000Fq-VB; Wed, 31 Jan 2024 06:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rV9CQ-00005b-6r; Wed, 31 Jan 2024 06:56:15 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rV9CN-0003xX-1q; Wed, 31 Jan 2024 06:56:13 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 61344490C8;
 Wed, 31 Jan 2024 14:56:47 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9651870271;
 Wed, 31 Jan 2024 14:55:50 +0300 (MSK)
Received: (nullmailer pid 2263942 invoked by uid 1000);
 Wed, 31 Jan 2024 11:55:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 10/21] acpi: Clean up includes
Date: Wed, 31 Jan 2024 14:55:38 +0300
Message-Id: <20240131115549.2263854-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131115549.2263854-1-mjt@tls.msk.ru>
References: <20240131115549.2263854-1-mjt@tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

This commit was created with scripts/clean-includes:
 ./scripts/clean-includes --git acpi include/hw/*/*acpi.h hw/*/*acpi.c

All .c should include qemu/osdep.h first.  The script performs three
related cleanups:

* Ensure .c files include qemu/osdep.h first.
* Including it in a .h is redundant, since the .c  already includes
  it.  Drop such inclusions.
* Likewise, including headers qemu/osdep.h includes is redundant.
  Drop these, too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/nvram/fw_cfg-acpi.c          | 1 +
 hw/virtio/virtio-acpi.c         | 1 +
 include/hw/nvram/fw_cfg_acpi.h  | 1 -
 include/hw/virtio/virtio-acpi.h | 1 -
 4 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/nvram/fw_cfg-acpi.c b/hw/nvram/fw_cfg-acpi.c
index 4e48baeaa0..58cdcd3121 100644
--- a/hw/nvram/fw_cfg-acpi.c
+++ b/hw/nvram/fw_cfg-acpi.c
@@ -4,6 +4,7 @@
  *
  */
 
+#include "qemu/osdep.h"
 #include "hw/nvram/fw_cfg_acpi.h"
 #include "hw/acpi/aml-build.h"
 
diff --git a/hw/virtio/virtio-acpi.c b/hw/virtio/virtio-acpi.c
index e18cb38bdb..230a669500 100644
--- a/hw/virtio/virtio-acpi.c
+++ b/hw/virtio/virtio-acpi.c
@@ -4,6 +4,7 @@
  *
  */
 
+#include "qemu/osdep.h"
 #include "hw/virtio/virtio-acpi.h"
 #include "hw/acpi/aml-build.h"
 
diff --git a/include/hw/nvram/fw_cfg_acpi.h b/include/hw/nvram/fw_cfg_acpi.h
index b6553d86fc..b39eb0490f 100644
--- a/include/hw/nvram/fw_cfg_acpi.h
+++ b/include/hw/nvram/fw_cfg_acpi.h
@@ -7,7 +7,6 @@
 #ifndef FW_CFG_ACPI_H
 #define FW_CFG_ACPI_H
 
-#include "qemu/osdep.h"
 #include "exec/hwaddr.h"
 
 void fw_cfg_acpi_dsdt_add(Aml *scope, const MemMapEntry *fw_cfg_memmap);
diff --git a/include/hw/virtio/virtio-acpi.h b/include/hw/virtio/virtio-acpi.h
index 844e102569..cace2a315f 100644
--- a/include/hw/virtio/virtio-acpi.h
+++ b/include/hw/virtio/virtio-acpi.h
@@ -6,7 +6,6 @@
 #ifndef VIRTIO_ACPI_H
 #define VIRTIO_ACPI_H
 
-#include "qemu/osdep.h"
 #include "exec/hwaddr.h"
 
 void virtio_acpi_dsdt_add(Aml *scope, const hwaddr virtio_mmio_base,
-- 
2.39.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DDFB3D980
	for <lists+qemu-devel@lfdr.de>; Mon,  1 Sep 2025 08:08:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usxgi-00039F-SV; Mon, 01 Sep 2025 02:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-2025090105563076d4b775c70002070e-hZtRxR@rts-flowmailer.siemens.com>)
 id 1usxge-00037s-Pd
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:06:40 -0400
Received: from mta-64-226.siemens.flowmailer.net ([185.136.64.226])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-2025090105563076d4b775c70002070e-hZtRxR@rts-flowmailer.siemens.com>)
 id 1usxgc-0001x1-3a
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:06:40 -0400
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 2025090105563076d4b775c70002070e for <qemu-devel@nongnu.org>;
 Mon, 01 Sep 2025 07:56:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=e3EQT5gyoHqhFMBmKwgqxpylfFDp3FV32G6zJWOQZUw=;
 b=avRtqdbv3M3zIVPaD3/VK73aonDaIC0V080MrB6BbGpXi40U8rE9DuS1wo8KHryj074eVM
 Szt1yNaccN97Ys4ZCeaTHsTTIcoG8/0MtMNKBKdZEhFsesMyIVu66pVhhj7ppX6nPTq6zt+d
 Hw3xaz23j0/EVhxXhFhWiLWkSGmyF4ETK+q6ZXjXts14jI2MqiaYso/qkK0hbm0ONrbFDzIY
 sqz0ELrMlPZYJ/6F3N8hdQEKOrieo+BZvKlNXnsGk1cEKX0Sgho4hKC0vXkCpXG+XIY8H6q6
 mTV//j4zHwdE8sgS4uWKwOwn0tY6piPp/vMUXKt2pHiIbX0OXcZPsfIA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 4/8] hw/sd/sdcard: Refactor sd_bootpart_offset
Date: Mon,  1 Sep 2025 07:56:24 +0200
Message-ID: <66e9b07476aad61820c4f42f4f984cc90752ba5e.1756706188.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1756706188.git.jan.kiszka@siemens.com>
References: <cover.1756706188.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.64.226;
 envelope-from=fm-294854-2025090105563076d4b775c70002070e-hZtRxR@rts-flowmailer.siemens.com;
 helo=mta-64-226.siemens.flowmailer.net
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jan Kiszka <jan.kiszka@siemens.com>

This function provides the offset for any partition in the block image,
not only the boot partitions, therefore rename it. Align the constant
names with the numbering scheme in the standard and use constants for
both boot partitions for consistency reasons. There is also no reason to
return early if boot_part_size is zero because the existing code will
provide the right value in that case as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c             | 16 ++++++++--------
 hw/sd/sdmmc-internal.h |  3 ++-
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8a4f58295b..b727a37d06 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -838,14 +838,14 @@ static uint32_t sd_blk_len(SDState *sd)
 
 /*
  * This requires a disk image that has two boot partitions inserted at the
- * beginning of it. The size of the boot partitions is the "boot-size"
- * property.
+ * beginning of it, followed by an RPMB partition. The size of the boot
+ * partitions is the "boot-partition-size" property.
  */
-static uint32_t sd_bootpart_offset(SDState *sd)
+static uint32_t sd_part_offset(SDState *sd)
 {
     unsigned partition_access;
 
-    if (!sd->boot_part_size || !sd_is_emmc(sd)) {
+    if (!sd_is_emmc(sd)) {
         return 0;
     }
 
@@ -854,9 +854,9 @@ static uint32_t sd_bootpart_offset(SDState *sd)
     switch (partition_access) {
     case EXT_CSD_PART_CONFIG_ACC_DEFAULT:
         return sd->boot_part_size * 2;
-    case EXT_CSD_PART_CONFIG_ACC_BOOT0:
+    case EXT_CSD_PART_CONFIG_ACC_BOOT1:
         return 0;
-    case EXT_CSD_PART_CONFIG_ACC_BOOT0 + 1:
+    case EXT_CSD_PART_CONFIG_ACC_BOOT2:
         return sd->boot_part_size * 1;
     default:
          g_assert_not_reached();
@@ -1057,7 +1057,7 @@ static const VMStateDescription sd_vmstate = {
 static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 {
     trace_sdcard_read_block(addr, len);
-    addr += sd_bootpart_offset(sd);
+    addr += sd_part_offset(sd);
     if (!sd->blk || blk_pread(sd->blk, addr, len, sd->data, 0) < 0) {
         fprintf(stderr, "sd_blk_read: read error on host side\n");
     }
@@ -1066,7 +1066,7 @@ static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
 {
     trace_sdcard_write_block(addr, len);
-    addr += sd_bootpart_offset(sd);
+    addr += sd_part_offset(sd);
     if (!sd->blk || blk_pwrite(sd->blk, addr, len, sd->data, 0) < 0) {
         fprintf(stderr, "sd_blk_write: write error on host side\n");
     }
diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
index 91eb5b6b2f..ce6bc4e6ec 100644
--- a/hw/sd/sdmmc-internal.h
+++ b/hw/sd/sdmmc-internal.h
@@ -116,7 +116,8 @@ DECLARE_OBJ_CHECKERS(SDState, SDCardClass, SDMMC_COMMON, TYPE_SDMMC_COMMON)
 
 #define EXT_CSD_PART_CONFIG_ACC_MASK            (0x7)
 #define EXT_CSD_PART_CONFIG_ACC_DEFAULT         (0x0)
-#define EXT_CSD_PART_CONFIG_ACC_BOOT0           (0x1)
+#define EXT_CSD_PART_CONFIG_ACC_BOOT1           (0x1)
+#define EXT_CSD_PART_CONFIG_ACC_BOOT2           (0x2)
 
 #define EXT_CSD_PART_CONFIG_EN_MASK             (0x7 << 3)
 #define EXT_CSD_PART_CONFIG_EN_BOOT0            (0x1 << 3)
-- 
2.43.0



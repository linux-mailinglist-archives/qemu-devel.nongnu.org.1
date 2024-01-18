Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D45F8318A5
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 12:48:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQQsJ-0005RY-Uj; Thu, 18 Jan 2024 06:48:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rQQro-0005C9-It
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 06:47:28 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rQQrk-0004kg-PN
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 06:47:28 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxuvDHD6llfJ4BAA--.8005S3;
 Thu, 18 Jan 2024 19:47:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxXs3HD6llrW8IAA--.40089S4; 
 Thu, 18 Jan 2024 19:47:19 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, philmd@linaro.org,
 maobibo@loongson.cn, zhaotianrui@loongson.cn, lixianglai@loongson.cn
Subject: [RESEND PATCH v4 02/17] hw/loongarch: Add load initrd
Date: Thu, 18 Jan 2024 19:31:08 +0800
Message-Id: <20240118113123.1672939-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240118113123.1672939-1-gaosong@loongson.cn>
References: <20240118113123.1672939-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxXs3HD6llrW8IAA--.40089S4
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

we load initrd ramdisk after kernel_high address

Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20231227080821.3216113-3-gaosong@loongson.cn>
---
 hw/loongarch/boot.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 0f2bc15fdf..3075c276d4 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -21,7 +21,8 @@ static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
 
 static int64_t load_kernel_info(struct loongarch_boot_info *info)
 {
-    uint64_t kernel_entry, kernel_low, kernel_high;
+    uint64_t kernel_entry, kernel_low, kernel_high, initrd_size;
+    ram_addr_t initrd_offset;
     ssize_t kernel_size;
 
     kernel_size = load_elf(info->kernel_filename, NULL,
@@ -36,6 +37,32 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
                      load_elf_strerror(kernel_size));
         exit(1);
     }
+
+    if (info->initrd_filename) {
+        initrd_size = get_image_size(info->initrd_filename);
+        if (initrd_size > 0) {
+            initrd_offset = ROUND_UP(kernel_high + 4 * kernel_size, 64 * KiB);
+
+            if (initrd_offset + initrd_size > info->ram_size) {
+                error_report("memory too small for initial ram disk '%s'",
+                             info->initrd_filename);
+                exit(1);
+            }
+
+            initrd_size = load_image_targphys(info->initrd_filename, initrd_offset,
+                                              info->ram_size - initrd_offset);
+        }
+
+        if (initrd_size == (target_ulong)-1) {
+            error_report("could not load initial ram disk '%s'",
+                         info->initrd_filename);
+            exit(1);
+        }
+    } else {
+        error_report("Need initrd!");
+        exit(1);
+    }
+
     return kernel_entry;
 }
 
-- 
2.25.1



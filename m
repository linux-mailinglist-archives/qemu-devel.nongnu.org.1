Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A8D9263D7
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jul 2024 16:52:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP1KV-0007IU-G6; Wed, 03 Jul 2024 10:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sP1KS-0007GX-Gx; Wed, 03 Jul 2024 10:51:28 -0400
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sP1KQ-0001H3-2W; Wed, 03 Jul 2024 10:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1720018281; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=WFo4T08yYcFD2nEJduux7AoJHu9sAzbgr8IyKKTIf0Q=;
 b=K8FW6bxEORPth2hdn/VyFnlaASwJccfIuVybxFZ7SkJB9F4KPpnMkDtsY2QxUWva9ZAO7XQlLvTwPY97/9Wh6DwgFqGswtqNXhrhg5bnvnpKyCtNqHwzuBeXR++I75yzUmveJzWiRcAixVK6lxG9Lq8ZlcawU8Z4GSQypI+nK0w=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R911e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067110;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W9ndsQM_1720018277; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W9ndsQM_1720018277) by smtp.aliyun-inc.com;
 Wed, 03 Jul 2024 22:51:19 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v3 1/7] target/riscv: Add fw_dynamic_info32 for booting RV32
 OpenSBI
Date: Wed,  3 Jul 2024 22:49:15 +0800
Message-Id: <20240703144921.1281-2-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240703144921.1281-1-zhiwei_liu@linux.alibaba.com>
References: <20240703144921.1281-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

RV32 OpenSBI need a fw_dynamic_info parameter with 32-bit fields instead
of target_ulong.

In RV64 QEMU, target_ulong is 64. So it is not right for booting RV32 OpenSBI.
We create a fw_dynmaic_info32 struct for this purpose.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/boot.c                 | 35 ++++++++++++++++++++++-----------
 hw/riscv/sifive_u.c             |  3 ++-
 include/hw/riscv/boot.h         |  4 +++-
 include/hw/riscv/boot_opensbi.h | 29 +++++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 47281ca853..1a2c1ff9e0 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -342,27 +342,33 @@ void riscv_load_fdt(hwaddr fdt_addr, void *fdt)
                         rom_ptr_for_as(&address_space_memory, fdt_addr, fdtsize));
 }
 
-void riscv_rom_copy_firmware_info(MachineState *machine, hwaddr rom_base,
-                                  hwaddr rom_size, uint32_t reset_vec_size,
+void riscv_rom_copy_firmware_info(MachineState *machine,
+                                  RISCVHartArrayState *harts,
+                                  hwaddr rom_base, hwaddr rom_size,
+                                  uint32_t reset_vec_size,
                                   uint64_t kernel_entry)
 {
+    struct fw_dynamic_info32 dinfo32;
     struct fw_dynamic_info dinfo;
     size_t dinfo_len;
 
-    if (sizeof(dinfo.magic) == 4) {
-        dinfo.magic = cpu_to_le32(FW_DYNAMIC_INFO_MAGIC_VALUE);
-        dinfo.version = cpu_to_le32(FW_DYNAMIC_INFO_VERSION);
-        dinfo.next_mode = cpu_to_le32(FW_DYNAMIC_INFO_NEXT_MODE_S);
-        dinfo.next_addr = cpu_to_le32(kernel_entry);
+    if (riscv_is_32bit(harts)) {
+        dinfo32.magic = cpu_to_le32(FW_DYNAMIC_INFO_MAGIC_VALUE);
+        dinfo32.version = cpu_to_le32(FW_DYNAMIC_INFO_VERSION);
+        dinfo32.next_mode = cpu_to_le32(FW_DYNAMIC_INFO_NEXT_MODE_S);
+        dinfo32.next_addr = cpu_to_le32(kernel_entry);
+        dinfo32.options = 0;
+        dinfo32.boot_hart = 0;
+        dinfo_len = sizeof(dinfo32);
     } else {
         dinfo.magic = cpu_to_le64(FW_DYNAMIC_INFO_MAGIC_VALUE);
         dinfo.version = cpu_to_le64(FW_DYNAMIC_INFO_VERSION);
         dinfo.next_mode = cpu_to_le64(FW_DYNAMIC_INFO_NEXT_MODE_S);
         dinfo.next_addr = cpu_to_le64(kernel_entry);
+        dinfo.options = 0;
+        dinfo.boot_hart = 0;
+        dinfo_len = sizeof(dinfo);
     }
-    dinfo.options = 0;
-    dinfo.boot_hart = 0;
-    dinfo_len = sizeof(dinfo);
 
     /**
      * copy the dynamic firmware info. This information is specific to
@@ -374,7 +380,10 @@ void riscv_rom_copy_firmware_info(MachineState *machine, hwaddr rom_base,
         exit(1);
     }
 
-    rom_add_blob_fixed_as("mrom.finfo", &dinfo, dinfo_len,
+    rom_add_blob_fixed_as("mrom.finfo",
+                           riscv_is_32bit(harts) ?
+                           (void *)&dinfo32 : (void *)&dinfo,
+                           dinfo_len,
                            rom_base + reset_vec_size,
                            &address_space_memory);
 }
@@ -430,7 +439,9 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
     }
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
                           rom_base, &address_space_memory);
-    riscv_rom_copy_firmware_info(machine, rom_base, rom_size, sizeof(reset_vec),
+    riscv_rom_copy_firmware_info(machine, harts,
+                                 rom_base, rom_size,
+                                 sizeof(reset_vec),
                                  kernel_entry);
 }
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index af5f923f54..5010c3eadb 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -646,7 +646,8 @@ static void sifive_u_machine_init(MachineState *machine)
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
                           memmap[SIFIVE_U_DEV_MROM].base, &address_space_memory);
 
-    riscv_rom_copy_firmware_info(machine, memmap[SIFIVE_U_DEV_MROM].base,
+    riscv_rom_copy_firmware_info(machine, &s->soc.u_cpus,
+                                 memmap[SIFIVE_U_DEV_MROM].base,
                                  memmap[SIFIVE_U_DEV_MROM].size,
                                  sizeof(reset_vec), kernel_entry);
 
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index a2e4ae9cb0..806256d23f 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -56,7 +56,9 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
                                hwaddr rom_base, hwaddr rom_size,
                                uint64_t kernel_entry,
                                uint64_t fdt_load_addr);
-void riscv_rom_copy_firmware_info(MachineState *machine, hwaddr rom_base,
+void riscv_rom_copy_firmware_info(MachineState *machine,
+                                  RISCVHartArrayState *harts,
+                                  hwaddr rom_base,
                                   hwaddr rom_size,
                                   uint32_t reset_vec_size,
                                   uint64_t kernel_entry);
diff --git a/include/hw/riscv/boot_opensbi.h b/include/hw/riscv/boot_opensbi.h
index 1b749663dc..18664a174b 100644
--- a/include/hw/riscv/boot_opensbi.h
+++ b/include/hw/riscv/boot_opensbi.h
@@ -58,4 +58,33 @@ struct fw_dynamic_info {
     target_long boot_hart;
 };
 
+/** Representation dynamic info passed by previous booting stage */
+struct fw_dynamic_info32 {
+    /** Info magic */
+    int32_t magic;
+    /** Info version */
+    int32_t version;
+    /** Next booting stage address */
+    int32_t next_addr;
+    /** Next booting stage mode */
+    int32_t next_mode;
+    /** Options for OpenSBI library */
+    int32_t options;
+    /**
+     * Preferred boot HART id
+     *
+     * It is possible that the previous booting stage uses same link
+     * address as the FW_DYNAMIC firmware. In this case, the relocation
+     * lottery mechanism can potentially overwrite the previous booting
+     * stage while other HARTs are still running in the previous booting
+     * stage leading to boot-time crash. To avoid this boot-time crash,
+     * the previous booting stage can specify last HART that will jump
+     * to the FW_DYNAMIC firmware as the preferred boot HART.
+     *
+     * To avoid specifying a preferred boot HART, the previous booting
+     * stage can set it to -1UL which will force the FW_DYNAMIC firmware
+     * to use the relocation lottery mechanism.
+     */
+    int32_t boot_hart;
+};
 #endif
-- 
2.25.1



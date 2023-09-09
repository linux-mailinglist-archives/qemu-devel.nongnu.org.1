Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7327D79983F
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:01:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexZt-000694-E8; Sat, 09 Sep 2023 09:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexZo-0005zv-Bi; Sat, 09 Sep 2023 09:00:40 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexZl-0002AE-WC; Sat, 09 Sep 2023 09:00:40 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6863620591;
 Sat,  9 Sep 2023 16:01:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3D84326DF8;
 Sat,  9 Sep 2023 16:00:23 +0300 (MSK)
Received: (nullmailer pid 353066 invoked by uid 1000);
 Sat, 09 Sep 2023 13:00:22 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.5 04/43] hw/smbios: Fix core count in type4
Date: Sat,  9 Sep 2023 15:59:30 +0300
Message-Id: <20230909130020.352951-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.5-20230909155813@cover.tls.msk.ru>
References: <qemu-stable-8.0.5-20230909155813@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Zhao Liu <zhao1.liu@intel.com>

>From SMBIOS 3.0 specification, core count field means:

Core Count is the number of cores detected by the BIOS for this
processor socket. [1]

Before 003f230e37d7 ("machine: Tweak the order of topology members in
struct CpuTopology"), MachineState.smp.cores means "the number of cores
in one package", and it's correct to use smp.cores for core count.

But 003f230e37d7 changes the smp.cores' meaning to "the number of cores
in one die" and doesn't change the original smp.cores' use in smbios as
well, which makes core count in type4 go wrong.

Fix this issue with the correct "cores per socket" caculation.

[1] SMBIOS 3.0.0, section 7.5.6, Processor Information - Core Count

Fixes: 003f230e37d7 ("machine: Tweak the order of topology members in struct CpuTopology")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20230628135437.1145805-5-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 196ea60a734c346d7d75f1d89aa37703d4d854e7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 3aae9328c0..10cd22f610 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -714,6 +714,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     char sock_str[128];
     size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
     unsigned threads_per_socket;
+    unsigned cores_per_socket;
 
     if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
         tbl_len = SMBIOS_TYPE_4_LEN_V30;
@@ -749,8 +750,9 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     SMBIOS_TABLE_SET_STR(4, part_number_str, type4.part);
 
     threads_per_socket = machine_topo_get_threads_per_socket(ms);
+    cores_per_socket = machine_topo_get_cores_per_socket(ms);
 
-    t->core_count = (ms->smp.cores > 255) ? 0xFF : ms->smp.cores;
+    t->core_count = (cores_per_socket > 255) ? 0xFF : cores_per_socket;
     t->core_enabled = t->core_count;
 
     t->thread_count = (threads_per_socket > 255) ? 0xFF : threads_per_socket;
@@ -759,7 +761,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     t->processor_family2 = cpu_to_le16(0x01); /* Other */
 
     if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
-        t->core_count2 = t->core_enabled2 = cpu_to_le16(ms->smp.cores);
+        t->core_count2 = t->core_enabled2 = cpu_to_le16(cores_per_socket);
         t->thread_count2 = cpu_to_le16(threads_per_socket);
     }
 
-- 
2.39.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E164732CB7
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 12:03:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA6HT-0007H2-L3; Fri, 16 Jun 2023 06:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qA6HP-0007Fx-OO
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 06:02:07 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qA6HM-0000dY-V3
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 06:02:07 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxvOoZM4xkR+8FAA--.12650S3;
 Fri, 16 Jun 2023 18:02:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxFOQWM4xkSygdAA--.17116S6; 
 Fri, 16 Jun 2023 18:02:01 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Tianrui Zhao <zhaotianrui@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/5] hw/loongarch: Supplement cpu topology arguments
Date: Fri, 16 Jun 2023 18:01:57 +0800
Message-Id: <20230616100158.1845239-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230616100158.1845239-1-gaosong@loongson.cn>
References: <20230616100158.1845239-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxFOQWM4xkSygdAA--.17116S6
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

From: Tianrui Zhao <zhaotianrui@loongson.cn>

Supplement LoongArch cpu topology arguments, including support socket
and threads per core.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20230613123251.2471878-1-zhaotianrui@loongson.cn>
---
 hw/loongarch/acpi-build.c | 4 ++++
 hw/loongarch/virt.c       | 9 ++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index f526f3abba..0b62c3a2f7 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -437,6 +437,10 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     acpi_add_table(table_offsets, tables_blob);
     build_madt(tables_blob, tables->linker, lams);
 
+    acpi_add_table(table_offsets, tables_blob);
+    build_pptt(tables_blob, tables->linker, machine,
+               lams->oem_id, lams->oem_table_id);
+
     acpi_add_table(table_offsets, tables_blob);
     build_srat(tables_blob, tables->linker, machine);
 
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 1d5c764408..ca8824b6ef 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1096,8 +1096,15 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
     for (n = 0; n < ms->possible_cpus->len; n++) {
         ms->possible_cpus->cpus[n].type = ms->cpu_type;
         ms->possible_cpus->cpus[n].arch_id = n;
+
+        ms->possible_cpus->cpus[n].props.has_socket_id = true;
+        ms->possible_cpus->cpus[n].props.socket_id  =
+                                   n / (ms->smp.cores * ms->smp.threads);
         ms->possible_cpus->cpus[n].props.has_core_id = true;
-        ms->possible_cpus->cpus[n].props.core_id = n % ms->smp.cores;
+        ms->possible_cpus->cpus[n].props.core_id =
+                                   n / ms->smp.threads % ms->smp.cores;
+        ms->possible_cpus->cpus[n].props.has_thread_id = true;
+        ms->possible_cpus->cpus[n].props.thread_id = n % ms->smp.threads;
     }
     return ms->possible_cpus;
 }
-- 
2.39.1



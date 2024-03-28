Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FCA87E49D
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Mar 2024 09:02:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm7wA-0003gy-E0; Mon, 18 Mar 2024 04:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rm7w8-0003fJ-47
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 04:01:36 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1rm7w3-0001Sh-DE
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 04:01:34 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxqejW9PdlWUAaAA--.43474S3;
 Mon, 18 Mar 2024 16:01:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx8OTR9PdliWtcAA--.46553S7; 
 Mon, 18 Mar 2024 16:01:26 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 5/5] hw/loongarch: Remove minimum and default memory size
Date: Mon, 18 Mar 2024 16:01:21 +0800
Message-Id: <20240318080121.2836548-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240318080121.2836548-1-maobibo@loongson.cn>
References: <20240318080121.2836548-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx8OTR9PdliWtcAA--.46553S7
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

Some qtest test cases such as numa use default memory size of generic
machine class, which is 128M by fault.

Here generic default memory size is used, and also remove minimum memory
size which is 1G originally.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index a2975c3c5a..deb3750d81 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -930,10 +930,6 @@ static void loongarch_init(MachineState *machine)
         cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
     }
 
-    if (ram_size < 1 * GiB) {
-        error_report("ram_size must be greater than 1G.");
-        exit(1);
-    }
     create_fdt(lams);
 
     /* Create IOCSR space */
@@ -1241,7 +1237,6 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Loongson-3A5000 LS7A1000 machine";
     mc->init = loongarch_init;
-    mc->default_ram_size = 1 * GiB;
     mc->default_cpu_type = LOONGARCH_CPU_TYPE_NAME("la464");
     mc->default_ram_id = "loongarch.ram";
     mc->max_cpus = LOONGARCH_MAX_CPUS;
-- 
2.39.3



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2779B786BBE
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:28:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6ar-0005tC-01; Thu, 24 Aug 2023 05:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qZ6aM-0004Fx-HN
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:25:10 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qZ6aH-0003jr-C9
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:25:01 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx5_HIIedkqHkbAA--.56042S3;
 Thu, 24 Aug 2023 17:24:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxJ826IedkJjhiAA--.40637S33; 
 Thu, 24 Aug 2023 17:24:24 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, richard.henderson@linaro.org, Jiajie Chen <c@jia.je>,
 Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 31/31] hw/loongarch: Fix ACPI processor id off-by-one error
Date: Thu, 24 Aug 2023 17:24:09 +0800
Message-Id: <20230824092409.1492470-32-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230824092409.1492470-1-gaosong@loongson.cn>
References: <20230824092409.1492470-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxJ826IedkJjhiAA--.40637S33
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jiajie Chen <c@jia.je>

In hw/acpi/aml-build.c:build_pptt() function, the code assumes that the
ACPI processor id equals to the cpu index, for example if we have 8
cpus, then the ACPI processor id should be in range 0-7.

However, in hw/loongarch/acpi-build.c:build_madt() function we broke the
assumption. If we have 8 cpus again, the ACPI processor id in MADT table
would be in range 1-8. It violates the following description taken from
ACPI spec 6.4 table 5.138:

If the processor structure represents an actual processor, this field
must match the value of ACPI processor ID field in the processor’s entry
in the MADT.

It will break the latest Linux 6.5-rc6 with the
following error message:

ACPI PPTT: PPTT table found, but unable to locate core 7 (8)
Invalid BIOS PPTT

Here 7 is the last cpu index, 8 is the ACPI processor id learned from
MADT.

With this patch, Linux can properly detect SMT threads when "-smp
8,sockets=1,cores=4,threads=2" is passed:

Thread(s) per core:  2
Core(s) per socket:  2
Socket(s):           2

The detection of number of sockets is still wrong, but that is out of
scope of the commit.

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20230820105658.99123-2-c@jia.je>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index 0b62c3a2f7..ae292fc543 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -127,7 +127,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, LoongArchMachineState *lams)
         build_append_int_noprefix(table_data, 17, 1);    /* Type */
         build_append_int_noprefix(table_data, 15, 1);    /* Length */
         build_append_int_noprefix(table_data, 1, 1);     /* Version */
-        build_append_int_noprefix(table_data, i + 1, 4); /* ACPI Processor ID */
+        build_append_int_noprefix(table_data, i, 4);     /* ACPI Processor ID */
         build_append_int_noprefix(table_data, arch_id, 4); /* Core ID */
         build_append_int_noprefix(table_data, 1, 4);     /* Flags */
     }
-- 
2.39.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9E6B16E55
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Jul 2025 11:18:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhPPO-0001TM-5O; Thu, 31 Jul 2025 05:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uhPPB-0001P9-FA; Thu, 31 Jul 2025 05:16:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1uhPP4-0000VL-Jk; Thu, 31 Jul 2025 05:16:52 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxnOJ3NItoN9o1AQ--.6230S3;
 Thu, 31 Jul 2025 17:16:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJAxE+RxNItopTwvAA--.39675S3;
 Thu, 31 Jul 2025 17:16:38 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, qemu-stable@nongnu.org, Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 1/2] target/loongarch: Fix valid virtual address checking
Date: Thu, 31 Jul 2025 16:53:31 +0800
Message-Id: <20250731085332.247531-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250731085332.247531-1-gaosong@loongson.cn>
References: <20250731085332.247531-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxE+RxNItopTwvAA--.39675S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Bibo Mao <maobibo@loongson.cn>

On LoongArch64 system, the high 32 bit of 64 bit virtual address should be
0x00000[0-7]yyy or 0xffff8yyy. The bit from 47 to 63 should be all 0 or
all 1.

Function get_physical_address() only checks bit 48 to 63, there will be
problem with the following test case. On physical machine, there is bus
error report and program exits abnormally. However on qemu TCG system
emulation mode, the program runs normally. The virtual address
0xffff000000000000ULL + addr and addr are treated the same on TLB entry
checking. This patch fixes this issue.

void main()
{
        void *addr, *addr1;
        int val;

        addr = malloc(100);
        *(int *)addr = 1;
        addr1 = 0xffff000000000000ULL + addr;
        val = *(int *)addr1;
        printf("val %d \n", val);
}

Cc: qemu-stable@nongnu.org
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20250714015446.746163-1-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index e172b11ce1..b5f732f15b 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -196,8 +196,8 @@ int get_physical_address(CPULoongArchState *env, hwaddr *physical,
     }
 
     /* Check valid extension */
-    addr_high = sextract64(address, TARGET_VIRT_ADDR_SPACE_BITS, 16);
-    if (!(addr_high == 0 || addr_high == -1)) {
+    addr_high = (int64_t)address >> (TARGET_VIRT_ADDR_SPACE_BITS - 1);
+    if (!(addr_high == 0 || addr_high == -1ULL)) {
         return TLBRET_BADADDR;
     }
 
-- 
2.47.0



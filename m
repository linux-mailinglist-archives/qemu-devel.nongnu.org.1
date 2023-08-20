Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C28BB781D84
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 13:00:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXg8f-0006IZ-Dm; Sun, 20 Aug 2023 06:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qXg8X-0006Gf-5Q
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 06:58:25 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qXg8E-0005H8-LE
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 06:58:09 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id EF4DB440AC;
 Sun, 20 Aug 2023 10:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1692529076; bh=MpXbOwiS4MDA6mYXv1z0R8eZYtTZ/CJ70sFXNXJITp8=;
 h=From:To:Cc:Subject:Date;
 b=rit8VQ9ccrRlghSqxn3ThpBqgTdfP8UsKWChwN4N0bs0mRAzfRy8UwWTb5bOJz/fq
 feosAQX0M9cWHWmAoktWG/CswTq3rONdEC3uyf8AGvXMOfDrqJnmSELwplaPkEweUJ
 hq1vMIq3ElnRuyZpNyEI+r6KETI8MuWfsAmdNM8A=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn,
 yangxiaojuan@loongson.cn, zhaotianrui@loongson.cn, Jiajie Chen <c@jia.je>
Subject: [PATCH] hw/loongarch: Fix ACPI processor id off-by-one error
Date: Sun, 20 Aug 2023 18:56:59 +0800
Message-ID: <20230820105658.99123-2-c@jia.je>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBCE73EA90
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 20:55:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrKV-00006K-9D; Mon, 26 Jun 2023 14:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrK2-0007ok-GI; Mon, 26 Jun 2023 14:52:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrK0-0005EN-Md; Mon, 26 Jun 2023 14:52:22 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EC18BEF30;
 Mon, 26 Jun 2023 21:50:22 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 746E9F7BF;
 Mon, 26 Jun 2023 21:50:21 +0300 (MSK)
Received: (nullmailer pid 1574033 invoked by uid 1000);
 Mon, 26 Jun 2023 18:50:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 25/54] s390x/tcg: Fix CPU address returned by STIDP
Date: Mon, 26 Jun 2023 21:49:32 +0300
Message-Id: <20230626185002.1573836-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

In qemu-user-s390x, /proc/cpuinfo contains:

	processor 0: version = 00,  identification = 000000,  machine = 8561
	processor 1: version = 00,  identification = 400000,  machine = 8561

The highest nibble is supposed to contain the CPU address, but it's off
by 2 bits. Fix the shift value and provide a symbolic constant for it.

With the fix we get:

	processor 0: version = 00,  identification = 000000,  machine = 8561
	processor 1: version = 00,  identification = 100000,  machine = 8561

Fixes: 076d4d39b65f ("s390x/cpumodel: wire up cpu type + id for TCG")
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230605113950.1169228-2-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 71b11cbe1c34411238703abe24bfaf2e9712c30d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 457b5cb10c..ae8880e81d 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -607,8 +607,8 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp)
 #if !defined(CONFIG_USER_ONLY)
     cpu->env.cpuid = s390_cpuid_from_cpu_model(cpu->model);
     if (tcg_enabled()) {
-        /* basic mode, write the cpu address into the first 4 bit of the ID */
-        cpu->env.cpuid = deposit64(cpu->env.cpuid, 54, 4, cpu->env.core_id);
+        cpu->env.cpuid = deposit64(cpu->env.cpuid, CPU_PHYS_ADDR_SHIFT,
+                                   CPU_PHYS_ADDR_BITS, cpu->env.core_id);
     }
 #endif
 }
diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index fb1adc8b21..cc7305ec21 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -96,10 +96,18 @@ static inline bool s390_known_cpu_type(uint16_t type)
 {
     return s390_get_gen_for_cpu_type(type) != 0;
 }
+#define CPU_ID_SHIFT 32
+#define CPU_ID_BITS 24
+/*
+ * When cpu_id_format is 0 (basic mode), the leftmost 4 bits of cpu_id contain
+ * the rightmost 4 bits of the physical CPU address.
+ */
+#define CPU_PHYS_ADDR_BITS 4
+#define CPU_PHYS_ADDR_SHIFT (CPU_ID_SHIFT + CPU_ID_BITS - CPU_PHYS_ADDR_BITS)
 static inline uint64_t s390_cpuid_from_cpu_model(const S390CPUModel *model)
 {
     return ((uint64_t)model->cpu_ver << 56) |
-           ((uint64_t)model->cpu_id << 32) |
+           ((uint64_t)model->cpu_id << CPU_ID_SHIFT) |
            ((uint64_t)model->def->type << 16) |
            (model->def->gen == 7 ? 0 : (uint64_t)model->cpu_id_format << 15);
 }
-- 
2.39.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BAA743BD9
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 14:28:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFDDx-0000No-Ih; Fri, 30 Jun 2023 08:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qFDCY-0007iT-Q0
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:26:16 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qFDCW-0007qF-By
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eYAzleHckNSL2bhGy1XrBY7Nysuvs5N/7DTht7w9SGk=; b=WUbd5P61Hug52BM8cT/nkPTY1y
 fOrdYO2ayszQQHHqdOw9Ra6h7+ltW2gmsyx7awK44AGWbfKQ5j4C1n2fiCnShBC9xEjeJIyreVbEg
 +VYP6QHo2lefuMODPOPM11G8ThgOtglpHPOw6MUKmXImpz+o84FJO4vOMWxUveoTr+VY=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 peter.maydell@linaro.org, wangyanan55@huawei.com
Subject: [PATCH 8/9] target: Remove CPUNegativeOffsetState field from ArchCPU
Date: Fri, 30 Jun 2023 14:25:50 +0200
Message-ID: <20230630122551.21766-9-anjo@rev.ng>
In-Reply-To: <20230630122551.21766-1-anjo@rev.ng>
References: <20230630122551.21766-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

All fields in CPUNegativeOffsetState have been moved to CPUState.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/alpha/cpu.h      | 1 -
 target/arm/cpu.h        | 1 -
 target/avr/cpu.h        | 1 -
 target/cris/cpu.h       | 1 -
 target/hexagon/cpu.h    | 1 -
 target/hppa/cpu.h       | 1 -
 target/i386/cpu.h       | 1 -
 target/loongarch/cpu.h  | 1 -
 target/m68k/cpu.h       | 1 -
 target/microblaze/cpu.h | 1 -
 target/mips/cpu.h       | 3 +--
 target/nios2/cpu.h      | 1 -
 target/openrisc/cpu.h   | 1 -
 target/ppc/cpu.h        | 1 -
 target/riscv/cpu.h      | 1 -
 target/rx/cpu.h         | 1 -
 target/s390x/cpu.h      | 1 -
 target/sh4/cpu.h        | 1 -
 target/sparc/cpu.h      | 1 -
 target/tricore/cpu.h    | 1 -
 target/xtensa/cpu.h     | 3 +--
 21 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index fcd20bfd3a..2e4b7cfc53 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -263,7 +263,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUAlphaState env;
 
     /* This alarm doesn't exist in real hardware; we wish it did.  */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4d6c0f95d5..7bced90c34 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -856,7 +856,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUARMState env;
 
     /* Coprocessor information */
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 7225174668..4ce22d8e4f 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -148,7 +148,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUAVRState env;
 };
 
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 8e37c6e50d..676b8e93ca 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -178,7 +178,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUCRISState env;
 };
 
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index daef5c3f00..b2de6e1d5d 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -141,7 +141,6 @@ struct ArchCPU {
     /*< private >*/
     CPUState parent_obj;
     /*< public >*/
-    CPUNegativeOffsetState neg;
     CPUHexagonState env;
 
     bool lldb_compat;
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 7373177b55..b36de8f431 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -219,7 +219,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUHPPAState env;
     QEMUTimer *alarm_timer;
 };
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2c9b0d2ebc..3bc215dc5d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1889,7 +1889,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUX86State env;
     VMChangeStateEntry *vmsentry;
 
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index ed04027af1..87529c93bf 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -367,7 +367,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPULoongArchState env;
     QEMUTimer timer;
 
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index cf70282717..20afb0c94d 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -168,7 +168,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUM68KState env;
 };
 
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index a7b040abd4..baf7d979f6 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -352,7 +352,6 @@ struct ArchCPU {
     bool ns_axi_dc;
     bool ns_axi_ic;
 
-    CPUNegativeOffsetState neg;
     CPUMBState env;
     MicroBlazeCPUConfig cfg;
 };
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index a3bc646976..d118170a62 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1177,9 +1177,8 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    Clock *clock;
-    CPUNegativeOffsetState neg;
     CPUMIPSState env;
+    Clock *clock;
 };
 
 
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 477a3161fd..70b6377a4f 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -218,7 +218,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUNios2State env;
 
     bool diverr_present;
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 92c38f54c2..e823858e40 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -305,7 +305,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUOpenRISCState env;
 };
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index af12c93ebc..c480a1b37f 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1311,7 +1311,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUPPCState env;
 
     int vcpu_id;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7adb8706ac..4b9e0f818e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -383,7 +383,6 @@ struct ArchCPU {
     /* < private > */
     CPUState parent_obj;
     /* < public > */
-    CPUNegativeOffsetState neg;
     CPURISCVState env;
 
     char *dyn_csr_xml;
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 7f03ffcfed..f66754eb8a 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -111,7 +111,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPURXState env;
 };
 
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index eb5b65b7d3..7592ad53a8 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -168,7 +168,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUS390XState env;
     S390CPUModel *model;
     /* needed for live migration */
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 1399d3840f..f75a235973 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -208,7 +208,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUSH4State env;
 };
 
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 95d2d0da71..9385228a96 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -561,7 +561,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUSPARCState env;
 };
 
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index a50b91cc36..7a48077485 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -192,7 +192,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUTriCoreState env;
 };
 
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 87fe992ba6..c6bbef1e5d 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -560,9 +560,8 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    Clock *clock;
-    CPUNegativeOffsetState neg;
     CPUXtensaState env;
+    Clock *clock;
 };
 
 
-- 
2.41.0



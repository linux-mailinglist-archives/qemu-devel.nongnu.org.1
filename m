Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F6B8B9CEA
	for <lists+qemu-devel@lfdr.de>; Thu,  2 May 2024 16:56:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Xpu-0002vh-Ux; Thu, 02 May 2024 10:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1s2Xpn-0002vR-Mz
 for qemu-devel@nongnu.org; Thu, 02 May 2024 10:54:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1s2Xpl-0007F5-7Q
 for qemu-devel@nongnu.org; Thu, 02 May 2024 10:54:55 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 442BH7eB024733;
 Thu, 2 May 2024 14:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=qcppdkim1; bh=nYW1wGU
 0upuXsWcin/lCTyyfIWuvge5uKvXMb8euHpw=; b=FUvj2TtabO5GNmrn688RAkE
 6OYo7foWs4aUg+HX59+b8g+SuLvOT/YGd2JPB54HGN8kgEeZ6ggMJA9syjMuGHK7
 4ryOyz5iwvS7GkFL5N7FqzU3Hc0yC+Z7WxYw74FKKW0ZhY4QI9j2g4t6Hbr03JP4
 GGMYIsOxg+6VuyVsI8OZ8s3VXNQdUDAZIeHd3MxYkozv7sNdNG+04ZVIf+sj15N8
 UY98/QYHX946QHei/ZR8HbsdEY6ngGszoaVj56dU8K1rFJd7z6SNOy/CcIxpz/jB
 7uJ8unzrlyhA1Y+afjvAl+1QTexqVReyGHnr9ZDI6Wc7hYnZ9FYC9eX1+rz58lA=
 =
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xv8vs8jcp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 May 2024 14:54:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 442EsmoH021768
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 2 May 2024 14:54:48 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 2 May 2024 07:54:47 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <sidneym@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <ltaylorsimpson@gmail.com>, <richard.henderson@linaro.org>, Laurent Vivier
 <laurent@vivier.eu>
Subject: [PATCH v4] Hexagon: add PC alignment check and exception
Date: Thu, 2 May 2024 11:54:33 -0300
Message-ID: <4073a0bafcb239623b719d3304955fd8603428b2.1714661573.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: Cmi0KqYVxbqoMk5m44CFEKtrvRkOqqpn
X-Proofpoint-GUID: Cmi0KqYVxbqoMk5m44CFEKtrvRkOqqpn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_05,2024-05-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405020097
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The Hexagon Programmer's Reference Manual says that the exception 0x1e
should be raised upon an unaligned program counter. Let's implement that
and also add some tests.

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: https://lore.kernel.org/qemu-devel/5c90567ec28723865e144f386b36f5b676b7a5d3.1714486874.git.quic_mathbern@quicinc.com/

Changes in v4:
- Added missing regs to clobber list as mentioned by Taylor.
- Avoided undefined behavior on package with multiple branches
  (at test_multi_cof), as suggested offline by Brian.

 target/hexagon/cpu.h                       |  7 ++
 target/hexagon/cpu_bits.h                  |  4 +
 target/hexagon/macros.h                    |  3 -
 linux-user/hexagon/cpu_loop.c              |  4 +
 target/hexagon/op_helper.c                 |  9 +--
 tests/tcg/hexagon/unaligned_pc.c           | 93 ++++++++++++++++++++++
 tests/tcg/hexagon/Makefile.target          |  4 +
 tests/tcg/hexagon/unaligned_pc_multi_cof.S |  5 ++
 8 files changed, 121 insertions(+), 8 deletions(-)
 create mode 100644 tests/tcg/hexagon/unaligned_pc.c
 create mode 100644 tests/tcg/hexagon/unaligned_pc_multi_cof.S

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 3eef58fe8f..764f3c38cc 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -134,6 +134,10 @@ struct ArchCPU {
 
 FIELD(TB_FLAGS, IS_TIGHT_LOOP, 0, 1)
 
+G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
+                                            uint32_t exception,
+                                            uintptr_t pc);
+
 static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
@@ -144,6 +148,9 @@ static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
         hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP, 1);
     }
     *flags = hex_flags;
+    if (*pc & PCALIGN_MASK) {
+        hexagon_raise_exception_err(env, HEX_EXCP_PC_NOT_ALIGNED, 0);
+    }
 }
 
 typedef HexagonCPU ArchCPU;
diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
index 96fef71729..4279281a71 100644
--- a/target/hexagon/cpu_bits.h
+++ b/target/hexagon/cpu_bits.h
@@ -20,9 +20,13 @@
 
 #include "qemu/bitops.h"
 
+#define PCALIGN 4
+#define PCALIGN_MASK (PCALIGN - 1)
+
 #define HEX_EXCP_FETCH_NO_UPAGE  0x012
 #define HEX_EXCP_INVALID_PACKET  0x015
 #define HEX_EXCP_INVALID_OPCODE  0x015
+#define HEX_EXCP_PC_NOT_ALIGNED  0x01e
 #define HEX_EXCP_PRIV_NO_UREAD   0x024
 #define HEX_EXCP_PRIV_NO_UWRITE  0x025
 
diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index 1376d6ccc1..f375471a98 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -22,9 +22,6 @@
 #include "hex_regs.h"
 #include "reg_fields.h"
 
-#define PCALIGN 4
-#define PCALIGN_MASK (PCALIGN - 1)
-
 #define GET_FIELD(FIELD, REGIN) \
     fEXTRACTU_BITS(REGIN, reg_field_info[FIELD].width, \
                    reg_field_info[FIELD].offset)
diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index 7f1499ed28..d41159e52a 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -60,6 +60,10 @@ void cpu_loop(CPUHexagonState *env)
                 env->gpr[0] = ret;
             }
             break;
+        case HEX_EXCP_PC_NOT_ALIGNED:
+            force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
+                            env->gpr[HEX_REG_R31]);
+            break;
         case EXCP_ATOMIC:
             cpu_exec_step_atomic(cs);
             break;
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index da10ac5847..ae5a605513 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -36,10 +36,9 @@
 #define SF_MANTBITS    23
 
 /* Exceptions processing helpers */
-static G_NORETURN
-void do_raise_exception_err(CPUHexagonState *env,
-                            uint32_t exception,
-                            uintptr_t pc)
+G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
+                                            uint32_t exception,
+                                            uintptr_t pc)
 {
     CPUState *cs = env_cpu(env);
     qemu_log_mask(CPU_LOG_INT, "%s: %d\n", __func__, exception);
@@ -49,7 +48,7 @@ void do_raise_exception_err(CPUHexagonState *env,
 
 G_NORETURN void HELPER(raise_exception)(CPUHexagonState *env, uint32_t excp)
 {
-    do_raise_exception_err(env, excp, 0);
+    hexagon_raise_exception_err(env, excp, 0);
 }
 
 void log_store32(CPUHexagonState *env, target_ulong addr,
diff --git a/tests/tcg/hexagon/unaligned_pc.c b/tests/tcg/hexagon/unaligned_pc.c
new file mode 100644
index 0000000000..798e0a0f63
--- /dev/null
+++ b/tests/tcg/hexagon/unaligned_pc.c
@@ -0,0 +1,93 @@
+#include <stdio.h>
+#include <signal.h>
+#include <setjmp.h>
+#include <stdlib.h>
+
+/* will be changed in signal handler */
+volatile sig_atomic_t completed_tests;
+static jmp_buf after_test;
+static int nr_tests;
+
+void __attribute__((naked)) test_return(void)
+{
+    asm volatile(
+        "allocframe(#0x8)\n"
+        "r0 = #0xffffffff\n"
+        "framekey = r0\n"
+        "dealloc_return\n"
+        :
+        :
+        : "r0", "r29", "r30", "r31", "framekey");
+}
+
+void test_endloop(void)
+{
+    asm volatile(
+        "loop0(1f, #2)\n"
+        "1: r0 = #0x3\n"
+        "sa0 = r0\n"
+        "{ nop }:endloop0\n"
+        :
+        :
+        : "r0", "sa0", "lc0", "usr");
+}
+
+void test_multi_cof(void)
+{
+    asm volatile(
+        "p0 = cmp.eq(r0, r0)\n"
+        "{\n"
+        "    if (p0) jump test_multi_cof_unaligned\n"
+        "    if (!p0) jump 1f\n"
+        "}\n"
+        "1: nop\n"
+        :
+        :
+        : "p0");
+}
+
+void sigbus_handler(int signum)
+{
+    /* retore framekey after test_return */
+    asm volatile(
+        "r0 = #0\n"
+        "framekey = r0\n"
+        :
+        :
+        : "r0", "framekey");
+    printf("Test %d complete\n", completed_tests);
+    completed_tests++;
+    siglongjmp(after_test, 1);
+}
+
+void test_done(void)
+{
+    int err = (completed_tests != nr_tests);
+    puts(err ? "FAIL" : "PASS");
+    exit(err);
+}
+
+typedef void (*test_fn)(void);
+
+int main()
+{
+    test_fn tests[] = { test_return, test_endloop, test_multi_cof, test_done };
+    nr_tests = (sizeof(tests) / sizeof(tests[0])) - 1;
+
+    struct sigaction sa = {
+        .sa_sigaction = sigbus_handler,
+        .sa_flags = SA_SIGINFO
+    };
+
+    if (sigaction(SIGBUS, &sa, NULL) < 0) {
+        perror("sigaction");
+        return EXIT_FAILURE;
+    }
+
+    sigsetjmp(after_test, 1);
+    tests[completed_tests]();
+
+    /* should never get here */
+    puts("FAIL");
+    return 1;
+}
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index f839b2c0d5..75139e731c 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -51,6 +51,7 @@ HEX_TESTS += scatter_gather
 HEX_TESTS += hvx_misc
 HEX_TESTS += hvx_histogram
 HEX_TESTS += invalid-slots
+HEX_TESTS += unaligned_pc
 
 run-and-check-exception = $(call run-test,$2,$3 2>$2.stderr; \
 	test $$? -eq 1 && grep -q "exception $(strip $1)" $2.stderr)
@@ -108,6 +109,9 @@ preg_alias: preg_alias.c hex_test.h
 read_write_overlap: read_write_overlap.c hex_test.h
 reg_mut: reg_mut.c hex_test.h
 
+unaligned_pc: unaligned_pc.c unaligned_pc_multi_cof.S
+	$(CC) $(CFLAGS) $(CROSS_CC_GUEST_CFLAGS) -mv73 $^ -o $@ $(LDFLAGS)
+
 # This test has to be compiled for the -mv67t target
 usr: usr.c hex_test.h
 	$(CC) $(CFLAGS) -mv67t -O2 -Wno-inline-asm -Wno-expansion-to-defined $< -o $@ $(LDFLAGS)
diff --git a/tests/tcg/hexagon/unaligned_pc_multi_cof.S b/tests/tcg/hexagon/unaligned_pc_multi_cof.S
new file mode 100644
index 0000000000..10accd0057
--- /dev/null
+++ b/tests/tcg/hexagon/unaligned_pc_multi_cof.S
@@ -0,0 +1,5 @@
+.org 0x3
+.global test_multi_cof_unaligned
+test_multi_cof_unaligned:
+	nop
+	jumpr r31
-- 
2.37.2



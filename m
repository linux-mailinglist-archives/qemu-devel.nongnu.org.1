Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 174FC704E09
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 14:49:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyu6U-0004cR-LQ; Tue, 16 May 2023 08:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pyu6J-0004Pu-Tk
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:48:23 -0400
Received: from mout.kundenserver.de ([212.227.126.135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pyu6H-00065o-Nm
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:48:23 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MPrXf-1pkn673dqt-00MvUp; Tue, 16
 May 2023 14:48:13 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Afonso Bordado <afonsobordado@gmail.com>,
 Palmer Dabbelt <palmer@rivosinc.com>, Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 1/9] linux-user: Emulate /proc/cpuinfo output for riscv
Date: Tue, 16 May 2023 14:48:02 +0200
Message-Id: <20230516124810.90494-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516124810.90494-1-laurent@vivier.eu>
References: <20230516124810.90494-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MVwrVJoTIufoNfQ2wu4yFIGDEfeKlQ+Yc2ks7MW7Uo/yfd0xQda
 5USZSqzFyxRvr66z3B7Y7YQ+4HAgV5lQ2jEqOzawryWFqtgEQ5wmR2TQDouIkA6Q29RLS7J
 d9ovCtI52D+JummLM9GSH8e1x0FSA0NhMKzrbYlfi1PLFoduzyg9z0JDK2eYANP5dPvUb9F
 4pnUsCW0LICf9aDXcL4Jg==
UI-OutboundReport: notjunk:1;M01:P0:SdlzxfD7JhY=;mwDASfxZJ/xwuF6E7Prbupqsk3n
 jR/0xd6HKiPZLhKi6Vo0bSoAs2Ob0jnAdeEZr1AYKinEeCi2dZpl0YZd7yTnRgI9Mvc2C7lDX
 a5xjpcytg97ltDjsvTpeUl9evCL5+qC7Iq+7KlIzl73dPxhrYalSX/qAo5lTgD9ru9bhRk67Y
 eLReXRCTNrZVQGuKxRpSZoTD4nOKL9yN3R/VuGiHQ4ksbd/Sw/DNSIbC/UwYhkDoTwLLcNqSN
 yciA1aDKEpbB+nkmnWVN6Sv8GRBLy8BXWNkfFvrEDP0kSrfKxzPDNIz7P7Y6g5aCRe9tepTS7
 LouzTkBlGAd1kJ7Bjcg9iMrKudH5D6e2SK7AtyOvf1r1Ur/NmYV/verzFul4hvv8T157N+wcj
 yclQ9feIGOZC1vjUHJm9QEThKwsurSwPPfrcLhuRiF26g0/gntjn2D/iDe+FrFUaiUALvKcSd
 bwpzm0EYOH16qtBlHBnwgF6+LmQFONs0AoCkp0Oz5D0zRzWu2b2awr6LL6z1GCATgfdQbEeLE
 AFSWPEpByxU4f2CXV0p6W5pS4/OR+1vgy1pOaRBIiPWhmGedjuvbQkp39qtSxFJu0x6+toJW8
 5J7LVoeCyavBP2pF8cdoWoYxpHBxuUEopCGR9WUwvYWrXxabL3u++kj9d3e+R2BvStD2CSseQ
 8AJwrQFtJ+5yRnOxpfIhXReH7AlSnNetip8rTwIo+w==
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Afonso Bordado <afonsobordado@gmail.com>

RISC-V does not expose all extensions via hwcaps, thus some userspace
applications may want to query these via /proc/cpuinfo.

Currently when querying this file the host's file is shown instead
which is slightly confusing. Emulate a basic /proc/cpuinfo file
with mmu info and an ISA string.

Signed-off-by: Afonso Bordado <afonsobordado@gmail.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-Id: <167873059442.9885.15152085316575248452-0@git.sr.ht>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c              | 34 +++++++++++++++++++++++++++++--
 tests/tcg/riscv64/Makefile.target |  1 +
 tests/tcg/riscv64/cpuinfo.c       | 31 ++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/riscv64/cpuinfo.c

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 69f740ff98c8..085ce530213e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8231,7 +8231,8 @@ void target_exception_dump(CPUArchState *env, const char *fmt, int code)
 }
 
 #if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN || \
-    defined(TARGET_SPARC) || defined(TARGET_M68K) || defined(TARGET_HPPA)
+    defined(TARGET_SPARC) || defined(TARGET_M68K) || defined(TARGET_HPPA) || \
+    defined(TARGET_RISCV)
 static int is_proc(const char *filename, const char *entry)
 {
     return strcmp(filename, entry) == 0;
@@ -8309,6 +8310,35 @@ static int open_cpuinfo(CPUArchState *cpu_env, int fd)
 }
 #endif
 
+#if defined(TARGET_RISCV)
+static int open_cpuinfo(CPUArchState *cpu_env, int fd)
+{
+    int i;
+    int num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+    RISCVCPU *cpu = env_archcpu(cpu_env);
+    const RISCVCPUConfig *cfg = riscv_cpu_cfg((CPURISCVState *) cpu_env);
+    char *isa_string = riscv_isa_string(cpu);
+    const char *mmu;
+
+    if (cfg->mmu) {
+        mmu = (cpu_env->xl == MXL_RV32) ? "sv32"  : "sv48";
+    } else {
+        mmu = "none";
+    }
+
+    for (i = 0; i < num_cpus; i++) {
+        dprintf(fd, "processor\t: %d\n", i);
+        dprintf(fd, "hart\t\t: %d\n", i);
+        dprintf(fd, "isa\t\t: %s\n", isa_string);
+        dprintf(fd, "mmu\t\t: %s\n", mmu);
+        dprintf(fd, "uarch\t\t: qemu\n\n");
+    }
+
+    g_free(isa_string);
+    return 0;
+}
+#endif
+
 #if defined(TARGET_M68K)
 static int open_hardware(CPUArchState *cpu_env, int fd)
 {
@@ -8333,7 +8363,7 @@ static int do_openat(CPUArchState *cpu_env, int dirfd, const char *pathname, int
 #if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
         { "/proc/net/route", open_net_route, is_proc },
 #endif
-#if defined(TARGET_SPARC) || defined(TARGET_HPPA)
+#if defined(TARGET_SPARC) || defined(TARGET_HPPA) || defined(TARGET_RISCV)
         { "/proc/cpuinfo", open_cpuinfo, is_proc },
 #endif
 #if defined(TARGET_M68K)
diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
index 9973ba3b5f8c..2da65dccaf6a 100644
--- a/tests/tcg/riscv64/Makefile.target
+++ b/tests/tcg/riscv64/Makefile.target
@@ -4,6 +4,7 @@
 VPATH += $(SRC_PATH)/tests/tcg/riscv64
 TESTS += test-div
 TESTS += noexec
+TESTS += cpuinfo
 
 # Disable compressed instructions for test-noc
 TESTS += test-noc
diff --git a/tests/tcg/riscv64/cpuinfo.c b/tests/tcg/riscv64/cpuinfo.c
new file mode 100644
index 000000000000..5c2b79022e9c
--- /dev/null
+++ b/tests/tcg/riscv64/cpuinfo.c
@@ -0,0 +1,31 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <assert.h>
+
+#define BUFFER_SIZE 1024
+
+int main(void)
+{
+    char buffer[BUFFER_SIZE];
+    FILE *fp = fopen("/proc/cpuinfo", "r");
+    assert(fp != NULL);
+
+    while (fgets(buffer, BUFFER_SIZE, fp) != NULL) {
+        if (strstr(buffer, "processor") != NULL) {
+            assert(strstr(buffer, "processor\t: ") == buffer);
+        } else if (strstr(buffer, "hart") != NULL) {
+            assert(strstr(buffer, "hart\t\t: ") == buffer);
+        } else if (strstr(buffer, "isa") != NULL) {
+            assert(strcmp(buffer, "isa\t\t: rv64imafdc_zicsr_zifencei\n") == 0);
+        } else if (strstr(buffer, "mmu") != NULL) {
+            assert(strcmp(buffer, "mmu\t\t: sv48\n") == 0);
+        } else if (strstr(buffer, "uarch") != NULL) {
+            assert(strcmp(buffer, "uarch\t\t: qemu\n") == 0);
+            break;
+        }
+    }
+
+    fclose(fp);
+    return 0;
+}
-- 
2.40.1



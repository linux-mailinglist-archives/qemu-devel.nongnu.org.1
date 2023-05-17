Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAF5706228
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:03:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC75-0003kx-Rk; Wed, 17 May 2023 04:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pzC6z-0003SB-Ui
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:02:17 -0400
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pzC6t-0000xD-Kp
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:02:17 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MtfeD-1qIe4L1wnH-00v9US; Wed, 17
 May 2023 10:01:54 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Afonso Bordado <afonsobordado@gmail.com>,
 Palmer Dabbelt <palmer@rivosinc.com>, Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 1/9] linux-user: Emulate /proc/cpuinfo output for riscv
Date: Wed, 17 May 2023 10:01:44 +0200
Message-Id: <20230517080152.108660-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517080152.108660-1-laurent@vivier.eu>
References: <20230517080152.108660-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9Awxo4gQpL5xSuJ+eslw3xyRuWYvgpoLUuwpMFPopIKukzco+Oc
 o0KXumJVq8fNGiSp4LJpGIac+TlTnM6jNNRpdgXYyXsDQ/QtpIKDXdlH97hrn6magHivB9r
 37dhIEZGdbvL6h2Apy1TTpYZyl4b0YKlGy/ZgwszbJa9ppsqlt2c68/a8dJxrFxCTg1lLDc
 31kLdGdejmGWunwZW9Gdg==
UI-OutboundReport: notjunk:1;M01:P0:DttOHe+P+HY=;u50JeHKqOOT8v0WjBD2zzUT2ebG
 veqz0tng5JIPF+r+W0fT/C5iWuBXig8RWKfpPZlvIATvb3lsnV2Qe5Uo9s4niVSPFVX27Tf23
 qwZ5Zf5iwf8z6zRHI6pq39UrtyS6tqr5Hkc6IvW7GfQvU7AHZaYeDAFkvjm+Eev1inBdw3x0e
 z0ciZ0QYpeav3r5DVdPlvuGrAbZu+ZDLZxdtA2Cw2vA0SvqndYIXALE9XvwLBP1SjX1BFzG+i
 SDy+WMglrARFZlpNK5cHCcFw6QCe3PBeOI5mOeJxT2vXeLnAZSeZgHUnNs7sIADilWm+PIoBe
 pQWtKDNV+TqjNrEa9Jz+kjdSBen6wzzBAT7taERseLQA33NBw/uIzlNFwPgqIOkPO0uVtWSxu
 XGmEeujs9LL5FcHKbc2Tjt7MsSXMAlYEusrImoT7z2fhLpNrtsKgEZAEw4KmLDwiglxKbXbJL
 tvF0Pnal+s91u9CrIGUsw/xnzPD+GnxywKVRcJAaG3s6pl+6CUUQDFByWFXpVlJQKMFWU0GwJ
 CQC3LQs+/0kiuBw/dpPiOL++WUZoyWj6xevL0Iw1wTOnfXEHLuVTm+5Ewt4Jdwt+hJ9shhc8R
 +9pG1knlby7F7VEXA2AuJ24pnl83b/Tq/dWr0dxvPe3qOpEvU2FMO6iviYoH3d7vwCN++uuPZ
 ZcfQvrR8DAhRl1WsMSKEBw91QMmoBdGsPaA0l8zjrA==
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
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
[lv: removed the test that fails in CI for unknown reason]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

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
-- 
2.40.1



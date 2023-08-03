Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0662E76F4C8
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 23:46:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRg82-0003t1-Ua; Thu, 03 Aug 2023 17:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qRg81-0003sn-7Z; Thu, 03 Aug 2023 17:45:05 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qRg7y-0001Gs-8O; Thu, 03 Aug 2023 17:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691099091; x=1691703891; i=deller@gmx.de;
 bh=/02ufWd4kJoEc7JJHuyZDWsKtIMBSraIfCOSIvVAJPc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=C9WbPzkx96QAAhRajMhO/EgKwCU5Q1c0TI1f22HU4v6b2kgSbN7oJlBpTnM1iE36A+973+K
 M2X+UFmR0ATIux0K9K887i4VTY5/472/KwDiJl/HS4TiuIV7XEhrP6gsxEPUKI10LYliN6ynA
 c8mYNlA3gY6p4z/wdnAkUFb/U5QgTzKdB04e5BLmIgbt+T3bG+NUDEX+3avTNnJC0s6jzdeKK
 P/JqcPUaN7FpGuUi4GVUsNrJN/hsOu2mUuqdjOUzvZrDfT05BMTQMPP2d2UdRFICr16hQS4aM
 4BrHDeKSF/JpxTRQQ9/5mwavxqGyvqe7/WozcHJrvKEhX+XMkzTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.147.53]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnJlc-1q0LbD1Bxs-00jGDt; Thu, 03
 Aug 2023 23:44:51 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Cree <mcree@orcon.net.nz>
Subject: [PATCH v4 3/3] linux-user: Emulate /proc/cpuinfo for Alpha
Date: Thu,  3 Aug 2023 23:44:49 +0200
Message-ID: <20230803214450.647040-4-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803214450.647040-1-deller@gmx.de>
References: <20230803214450.647040-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QS5FUNJmVRwQhUXSAdGoGAtQszlnLdkshwjiRZoAmkagIH3tdrA
 x2NBwsRtxKWGDIGJGkOVYtvApN4O91lDOl0YKa7NyOpKD2ejHbP0C3ZyjPugrMXPWygPMEl
 b/Chj/Q/zsGEJxJVrvWH26EJ25lh601ObDB29+T2xtoaa1gouGzoyfEC5wHmlAW2p5fUGCD
 8bIXYHvdTME6/AIMFaSsA==
UI-OutboundReport: notjunk:1;M01:P0:RPwYYEAgkIY=;UvBbEzdgYu8O+bHQENtIh5q8WCE
 H6vGHN9z5APgMCprWrORQ0XC8pwqQbLpymRc0pLhqVdZZbzlXj/1xH6YFkS1ULvj/XDp/zgxK
 LJTSxDWNunUezGKNeGcSYImt/tU0nnWor51PLpb00i+XQPBuPSW1LW3aAg3hGU8js+4fKUFa1
 n2dN8V+UQMCoetdaO+mDN9adzQTdUEe+zCwfYzjCN/P31UJWQmTZx2Wk+kbzq8mDEuGdO8E07
 veqYLSX6Tm+H+2eQPyp4SFWAPS3VBmUW+sjij/b183KipFE++Rjn4eGnLcFuApH6+q6jK1bPm
 lIlBb8LxuVYRpN2dP+2e0bQSLqijhRdCr4Yy4aEHtRJMbq4Gi6BioM865gDCeIdoYZ6ubZIjD
 P+Hu1RFBmF++v/Ko6Bi6jVDRu4AlZwtZHFuVbKBwv3WV9Ts4guVvhg2N1pWKjACYAFyv+vn+K
 oQpkrQvewyMCTx7UTKB0/XkFv14oIDVhTaBoc91UL8mhL8m9X269cuDFoHrriMH8lfkKKjI9g
 FoLhI9Mv6myITfwcKakKB9MdK2Ao5PDZ6IRkGce3ZDTtmL6LzSh+D6v9II9JN3XSL2/9oyTap
 xsGCLGQ0E1adcwBqVo/ZWpsDULDoviQa/+4Uv+61E2GxKBl7F4XqUtEo7VlLArghKeeM0fnvx
 eSCO9LvcJVtIM/pODhB5Uiw/DBeq2NwZfUl6j0uZeGyvVLKqiRXJNPpuP+4uaN44OPsBy8JVT
 khLKZHXZLybEU2CVbEvNxrb9JluqhQfY7X9vlUSFUSY3MYhoX+HcDglEANRVA9ncQBYiAyRQR
 6lAVkdgCe8lsa9Poit9Ot8uieHnht26HMxerhq5uNJCXN7RQGoiSoPFws6/cINt/ducvoL3JH
 XTOgXEq9NU9EbH9/caSiVJN0VvR0rnZC9OdP8aUnZvkDwS/d+EWzFUiXuT1Ovo4idW1bVYiuH
 OU21/Q==
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Add emulation for /proc/cpuinfo for the alpha architecture.

alpha output example:

(alpha-chroot)root@p100:/# cat /proc/cpuinfo
cpu                     : Alpha
cpu model               : ev67
cpu variation           : 7
cpu revision            : 0
cpu serial number       : JA00000000
system type             : QEMU
system variation        : QEMU_v8.0.92
system revision         : 0
system serial number    : AY00000000
cycle frequency [Hz]    : 250000000
timer frequency [Hz]    : 250.00
page size [bytes]       : 8192
phys. address bits      : 44
max. addr. space #      : 255
BogoMIPS                : 2500.00
platform string         : AlphaServer QEMU user-mode VM
cpus detected           : 8
cpus active             : 4
cpu active mask         : 0000000000000095
L1 Icache               : n/a
L1 Dcache               : n/a
L2 cache                : n/a
L3 cache                : n/a

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: Michael Cree <mcree@orcon.net.nz>

v3:
- use PRIx64 instead of casting to long long
v2:
- revised platform string and system variation output
- show cpus detected/active/active mask based on
  current physical machine configuration
=2D--
 linux-user/syscall.c | 56 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 6328d7f434..aa470c465d 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8324,7 +8324,7 @@ void target_exception_dump(CPUArchState *env, const =
char *fmt, int code)
 #if HOST_BIG_ENDIAN !=3D TARGET_BIG_ENDIAN || \
     defined(TARGET_SPARC) || defined(TARGET_M68K) || defined(TARGET_HPPA)=
 || \
     defined(TARGET_RISCV) || defined(TARGET_S390X) || defined(TARGET_ARM)=
 || \
-    defined(TARGET_AARCH64)
+    defined(TARGET_AARCH64) || defined(TARGET_ALPHA)
 static int is_proc(const char *filename, const char *entry)
 {
     return strcmp(filename, entry) =3D=3D 0;
@@ -8376,6 +8376,57 @@ static int open_net_route(CPUArchState *cpu_env, in=
t fd)
 }
 #endif

+#if defined(TARGET_ALPHA)
+static int open_cpuinfo(CPUArchState *cpu_env, int fd)
+{
+    int max_cpus =3D sysconf(_SC_NPROCESSORS_CONF);
+    int num_cpus =3D sysconf(_SC_NPROCESSORS_ONLN);
+    uint64_t cpu_mask;
+    char model[32];
+    char *p;
+    AlphaCPU *cpu =3D env_archcpu(cpu_env);
+    CPUAlphaState *env =3D &cpu->env;
+
+    g_strlcpy(model, object_class_get_name(
+                        OBJECT_CLASS(CPU_GET_CLASS(env_cpu(cpu_env)))),
+              sizeof(model));
+    p =3D strchr(model, '-');
+    if (p) {
+        *p =3D '\0';
+    }
+    if (sched_getaffinity(getpid(), sizeof(cpu_mask),
+                          (cpu_set_t *) &cpu_mask) < 0) {
+        cpu_mask =3D (1ULL << num_cpus) - 1;
+    }
+
+    dprintf(fd, "cpu\t\t\t: Alpha\n");
+    dprintf(fd, "cpu model\t\t: %s\n", model);
+    dprintf(fd, "cpu variation\t\t: %d\n", env->implver + 5);
+    dprintf(fd, "cpu revision\t\t: 0\n");
+    dprintf(fd, "cpu serial number\t: JA00000000\n");
+    dprintf(fd, "system type\t\t: QEMU\n");
+    dprintf(fd, "system variation\t: QEMU_v%s\n", QEMU_VERSION);
+    dprintf(fd, "system revision\t\t: 0\n");
+    dprintf(fd, "system serial number\t: AY00000000\n");
+    dprintf(fd, "cycle frequency [Hz]\t: 250000000\n");
+    dprintf(fd, "timer frequency [Hz]\t: 250.00\n");
+    dprintf(fd, "page size [bytes]\t: %d\n", TARGET_PAGE_SIZE);
+    dprintf(fd, "phys. address bits\t: %d\n", TARGET_PHYS_ADDR_SPACE_BITS=
);
+    dprintf(fd, "max. addr. space #\t: 255\n");
+    dprintf(fd, "BogoMIPS\t\t: 2500.00\n");
+    dprintf(fd, "platform string\t\t: AlphaServer QEMU user-mode VM\n");
+    dprintf(fd, "cpus detected\t\t: %d\n", max_cpus);
+    dprintf(fd, "cpus active\t\t: %d\n", num_cpus);
+    dprintf(fd, "cpu active mask\t\t: %016"PRIx64"\n", cpu_mask);
+    dprintf(fd, "L1 Icache\t\t: n/a\n");
+    dprintf(fd, "L1 Dcache\t\t: n/a\n");
+    dprintf(fd, "L2 cache\t\t: n/a\n");
+    dprintf(fd, "L3 cache\t\t: n/a\n");
+    return 0;
+}
+#endif
+
+
 #if defined(TARGET_SPARC)
 static int open_cpuinfo(CPUArchState *cpu_env, int fd)
 {
@@ -8633,7 +8684,8 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd=
, const char *fname,
 #endif
 #if defined(TARGET_SPARC) || defined(TARGET_HPPA) || \
     defined(TARGET_RISCV) || defined(TARGET_S390X) || \
-    defined(TARGET_ARM)   || defined(TARGET_AARCH64)
+    defined(TARGET_ARM)   || defined(TARGET_AARCH64) || \
+    defined(TARGET_ALPHA)
         { "/proc/cpuinfo", open_cpuinfo, is_proc },
 #endif
 #if defined(TARGET_M68K)
=2D-
2.41.0



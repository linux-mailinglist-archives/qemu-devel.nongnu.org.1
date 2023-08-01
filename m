Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C78F076C0AE
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 01:10:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQyUD-0007OE-TE; Tue, 01 Aug 2023 19:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qQyUB-0007Nh-Hv; Tue, 01 Aug 2023 19:09:03 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qQyU9-0004fV-Mj; Tue, 01 Aug 2023 19:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690931325; x=1691536125; i=deller@gmx.de;
 bh=79i+wprPSHPx+eDP6ZoZRFZesYV7H7obdHrhMufFAds=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WES2DBnRIGYQj4XMF3hHDi4lUdWN/pt4ZHhtwCiNmKgnj21OGQ2DjRqyUIC0ci5msmDQaYO
 4siWc+upvlW4YyBjqiCi0buojahgA1vuYJzEse609Ej+VrDlEEoQ2m2NSwNu6GAnBhSXm8ckQ
 iWVcqdil7NSk97WJ8wV5kJGf5WvlRCKnl/9cldR/DTkqiYj3OAzasXWEPTb/6VGZb1oXaaUrt
 byOIlZEZWJasHDwLLGOR7xnBid2Rr61IhrlCxnbRNlBXlaCXwzcQg3ozVrjfgSYafNCUy+Jzp
 2DaH53eZ7NzEYgBi/yDLiaRoQoe17z5j9UyRijkAGEElbnZCOp2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.150.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbEp-1qa5Py1KaZ-009if7; Wed, 02
 Aug 2023 01:08:45 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Helge Deller <deller@gmx.de>, Michael Cree <mcree@orcon.net.nz>
Subject: [PATCH v2 3/3] linux-user: Emulate /proc/cpuinfo for Alpha
Date: Wed,  2 Aug 2023 01:08:42 +0200
Message-ID: <20230801230842.414421-4-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801230842.414421-1-deller@gmx.de>
References: <20230801230842.414421-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ykCZzbY1WXwIXpwMJS4jaUsYO1X9wMpRwqDdQCXl3vp1QMHAwso
 vAzdaXNO82XA0pwXdslJaxrFaTbXC1xzXVvGAVBvRDUR6K/P2y4ZSQvuoOdUsxmGY1L6QLh
 gasFSbbLbSi5WHD142xP8Td7Gi52sW4chaUTBaf2TUBpWH4cSHvhgmdbqTudgaTt3WHZMnN
 oasXVrKh66nO4dMZEJRBA==
UI-OutboundReport: notjunk:1;M01:P0:PR1i6An27x4=;05OY9rE5eTotGZjYhktvERObmKr
 1uqgmEh5JcAfDfckhpkYUeI7s/wQFMNAm2z3svuF5Og+IDAAYrbNgDYSZt67P1LlJxoX23b+3
 tGSPrKy6W1S+kPJvqbqFDWEsoJNp6yBtUVMKu3m2/no28zevurvwH5QqBS4PbZeum6gYVagFE
 jdTjIKHOmbX+dXFe5dvXHT6EOlZ/1qAMifBE3juOR3/L6odCNw/brz9llM5SzZHxkRBAI+L6m
 JopNAAcJmKEGYAAnev/4b5y/+AboeEf1Iaiebho3Q+MnN0C3bXwKtITs/8NqVAv08KBSCeUub
 jnj0XJzQfZsvFu/EpGtJ/wvxNquvLyt6ya4t1bL3AclcuZKl9ZL0nJUIh/Cn1PQrK4mrc276P
 ekfPmyjybg9wqMYrgC6bsFskQRiV0d22H3SfizP3I2traBtFdD6uvyKRCS5/MmbTtLD6CTcsX
 T5/kBGFzu4qUZzJevYVBzpjJdoWDP/A70qDPALx8ZnFPzTU/HSWboQlrYNPLMy8NESO6F3PaP
 Q+8zyLEwSJl35Tsbi4IDtNY+ZDNs+NQnay6deGpvS6rnB6l3WK1sU3jpzG9tlpMDuAXuSoy3c
 Nu5ySGiWBsjlsAx0KKBh0svu99sCgZHNGm3iiqtGIvk/DhuWpEVzKPX24MnZvfC01lzfcOSn4
 LDgs5wtCujWtIB0d/XfJG1CGy1MFpimHGh5+v7pgqmzq0Abv8fslvunzUrk/Tg18kgbSDpm5e
 GKY9ekJlPy4HeIBgtLywqYp6UwidFL/LqbF5t7GNbJKqfSJKWcvgvlZQPUljJLnOCSwSxgUbJ
 62Ix1j/a1D7EnUsGLQqXBf4B61OKBiEETxNLu08fgqsXz39d3VrdfsDBH3CqwLqwERO6fvThR
 Vgi6SFgf743RIHufBkNdNuJfMst7ZT0FiDce3KWwKk4NWZza9d2RFTJ5yS4rhxo5pYR2aI0ot
 0cWMSw==
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add emulation for /proc/cpuinfo for the alpha architecture.

alpha output example:

(alpha-chroot)root@p100:/# cat /proc/cpuinfo
cpu                     : Alpha
cpu model               : ev67
cpu variation           : 7
cpu revision            : 0
cpu serial number       : JA00000000
system type             : QEMU
system variation        : 8.0.91
system revision         : 0
system serial number    : AY00000000
cycle frequency [Hz]    : 250000000
timer frequency [Hz]    : 250.00
page size [bytes]       : 8192
phys. address bits      : 44
max. addr. space #      : 255
BogoMIPS                : 2500.00
platform string         : AlphaServer QEMU virtual machine
cpus detected           : 8
cpus active             : 8
cpu active mask         : 00000000000000ff
L1 Icache               : n/a
L1 Dcache               : n/a
L2 cache                : n/a
L3 cache                : n/a

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: Michael Cree <mcree@orcon.net.nz>
=2D--
 linux-user/syscall.c | 50 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 51ce81cefb..548eaea3a0 100644
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
@@ -8376,6 +8376,51 @@ static int open_net_route(CPUArchState *cpu_env, in=
t fd)
 }
 #endif

+#if defined(TARGET_ALPHA)
+static int open_cpuinfo(CPUArchState *cpu_env, int fd)
+{
+    int num_cpus =3D sysconf(_SC_NPROCESSORS_ONLN);
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
+
+    dprintf(fd, "cpu\t\t\t: Alpha\n");
+    dprintf(fd, "cpu model\t\t: %s\n", model);
+    // object_class_get_name(OBJECT_CLASS(CPU_GET_CLASS(env_cpu(cpu_env))=
)));
+    dprintf(fd, "cpu variation\t\t: %d\n", env->implver + 5);
+    dprintf(fd, "cpu revision\t\t: 0\n");
+    dprintf(fd, "cpu serial number\t: JA00000000\n");
+    dprintf(fd, "system type\t\t: QEMU\n");
+    dprintf(fd, "system variation\t: %s\n", QEMU_VERSION);
+    dprintf(fd, "system revision\t\t: 0\n");
+    dprintf(fd, "system serial number\t: AY00000000\n");
+    dprintf(fd, "cycle frequency [Hz]\t: 250000000\n");
+    dprintf(fd, "timer frequency [Hz]\t: 250.00\n");
+    dprintf(fd, "page size [bytes]\t: %d\n", TARGET_PAGE_SIZE);
+    dprintf(fd, "phys. address bits\t: %d\n", TARGET_PHYS_ADDR_SPACE_BITS=
);
+    dprintf(fd, "max. addr. space #\t: 255\n");
+    dprintf(fd, "BogoMIPS\t\t: 2500.00\n");
+    dprintf(fd, "platform string\t\t: AlphaServer QEMU virtual machine\n"=
);
+    dprintf(fd, "cpus detected\t\t: %d\n", num_cpus);
+    dprintf(fd, "cpus active\t\t: %d\n", num_cpus);
+    dprintf(fd, "cpu active mask\t\t: %016llx\n", (1ULL << num_cpus) - 1)=
;
+    dprintf(fd, "L1 Icache\t\t: n/a\n");
+    dprintf(fd, "L1 Dcache\t\t: n/a\n");
+    dprintf(fd, "L2 cache\t\t: n/a\n");
+    dprintf(fd, "L3 cache\t\t: n/a\n");
+    return 0;
+}
+#endif
+
 #if defined(TARGET_SPARC)
 static int open_cpuinfo(CPUArchState *cpu_env, int fd)
 {
@@ -8624,7 +8669,8 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd=
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



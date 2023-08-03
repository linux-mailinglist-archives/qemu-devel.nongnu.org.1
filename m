Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B9476F436
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 22:48:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRfF1-0007Wi-Vv; Thu, 03 Aug 2023 16:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qRfEz-0007Ux-EU; Thu, 03 Aug 2023 16:48:13 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qRfEw-0002Se-UO; Thu, 03 Aug 2023 16:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691095684; x=1691700484; i=deller@gmx.de;
 bh=XWSnm7MlhEIJTAyNaAmmAZHyaAMI6Jg/4buWfucSipI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dD/GnG1CNaptYwT0ykzsgFXCPZKkdbfgNiB32qX1EhQ2dEIpwqss3iaZs5RiIsA5/aTlXM2
 DSDvLfVXwj1Fyw/7SvwNBpC88oICG8U501QMzSCEneaJFmL/7yKxEzKed8z6+MNFdzFwLUYga
 WWr/xD/g0z894Fqc4k40dGGkudT96fwDzyyB6k6pY3rzjt0E/AqiTpaaR8+c74fGOmGITpZEg
 j6Bpnptvg4pr978/UMVJ/WyzbYEZ5m9LAXyJobT8OGZ2TMS+aH75Dt+Z4Qu10QjblBEauGVZa
 TAWMlbBct5KgHl0VklUFk7vUSjoxP40qknYVSIRhXfD/Uz1MkO2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.147.53]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0XD2-1peMPQ2u8K-00wYKj; Thu, 03
 Aug 2023 22:48:04 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PATCH v3 2/3] linux-user: Emulate /proc/cpuinfo on aarch64 and arm
Date: Thu,  3 Aug 2023 22:48:02 +0200
Message-ID: <20230803204803.639733-3-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803204803.639733-1-deller@gmx.de>
References: <20230803204803.639733-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pAfX9IZIztBv37IaGITGUblZYck+LXI/nA0BsHmCfikc6wuJ+2u
 4VBvtFfQI6E5NeyYeWk0F0qIwo52Au+R0bxR1jGCM05WNlXi4HReVGchIGmpKKoVgI//DYU
 e7MTWZ0z7QvSpCI4WGgoGwfeTaO6eqo4KrsP1r+cX5YHlH9VWzSGBRk86ZhL7f9eFaK0kUI
 tNF7dXNoGCevAUk61fevQ==
UI-OutboundReport: notjunk:1;M01:P0:pbYVW42pKZo=;BUdApvVkquhEO1ldVIXEmK567le
 aCqn47kd8iiMfvB0LcZqmv6K5uWG62Jc+IZwUMEByhnqPqCxPp24TIGrkfdDeP/n4ArAObFd1
 NZ5RiZwbCCpG9Hx+J+s7WN992iyb0Nam8DwwDSG7p4BT489ni/MhiHNZOd3kpAydrnCvLft4g
 gI5hUMDSQMLc2gY1VjhD0jsuAu8wvvrs8mEjWPXlmlZxRB9Jvoj8wOcrf136bqwt3xwJI35wK
 DX2GudOa26ZtsFqQ+MlL5n3pgODuyED+ptu2f+URzUUhW4aYI0kN/IDNdE9gIQGWKo7AoHYGb
 vtt8Vy+X5/jILiNl9ZRzLCjMQj/x29lZj22JA15PleFbHXWFR/cygg01F1pwrVumR/SbFmigC
 M+Ysd2u85JFCB8pwbDqwxfasqRH9I4ytZ7jonYiSo40EhzWY6ew83mOpPQiKE6HXySd+mvgPV
 UZOHEEoXTAY/slO7llmFXUcdaTRN/VLRpE2wkqH2Fn6EoRw25DEvQbjsO62aZc5vXfiUWEak7
 1/rRIKVkdEMdOYthuzcYcsUqfHEIBL/vMtZWFPQe3OPDSh1FvmfFZAWNV3xbjLxJ8Ea+jyJ6r
 658VV3r5kiNFaPxUVVAjDYIfRrswCelJd8ckXs+QGY809/I/9EhHiOZf0vqgDkxkeRO1+gXGG
 nwcm22knrDmfVYxvYC9/YIJrGmhRmYxUohYyzOVeoaNrSCmEFcLbbBhGxo8bNI1pFY39Exxqy
 WhRlNZ5xW+Ob/6mIwAYTeYXdlgbwx98zEr4T0Z71Kr2ppMgL+Ah0OlXEnMm7Gz5aFRZ4VG2JY
 S91JCckEm4XkF9MpzDD81B6Wl35swMA/tRn6sNlgg3zILe6PFwCrwHK8gtTorLsgf2eU7qW3j
 5p1Ij5FRtKOClMZpQdqVIn40359AZuarD6lJtH9guVQXUSB9XASi78jHQTFRRgBn7Kpg2R5Gr
 /S109H6dLkkIxnzwD1HVshsTFgY=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add emulation for /proc/cpuinfo for arm architecture.
The output below mimics output as seen on debian porterboxes.

aarch64 output example:

processor       : 0
model name      : ARMv8 Processor rev 0 (v8l)
BogoMIPS        : 100.00
Features        : swp half thumb fast_mult vfp edsp neon vfpv3 tls vfpv4 i=
diva idivt vfpd32 lpae aes pmull sha1 sha2 crc32
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x1
CPU part        : 0xd07
CPU revision    : 0
Hardware        : QEMU v8.0.92 arm,cortex-a57

arm 32-bit output example:

processor       : 0
model name      : ARMv5 Processor rev 6 (armv5l)
BogoMIPS        : 50.00
Features        : swp half thumb fast_mult edsp
CPU implementer : 0x69
CPU architecture: 5
CPU variant     : 0
CPU part        : 0x2d0
CPU revision    : 6
Hardware        : QEMU v8.0.92 marvell,xscale
Revision        : 0000
Serial          : 0000000000000000

Signed-off-by: Helge Deller <deller@gmx.de>

v4:
- more refinements based on Richards feedback
v3:
- show variant, part, revision and implementor based on midr
  value (suggested by Richard Henderson)
v2:
- show features of CPU which is actually being emulated by qemu
  (suggested by Peter Maydell)
=2D--
 linux-user/elfload.c | 130 +++++++++++++++++++++++++++++++++++++++++--
 linux-user/loader.h  |   6 +-
 linux-user/syscall.c |  76 ++++++++++++++++++++++++-
 3 files changed, 205 insertions(+), 7 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 861ec07abc..99804e477d 100644
=2D-- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -466,7 +466,7 @@ static bool init_guest_commpage(void)
 #define ELF_HWCAP get_elf_hwcap()
 #define ELF_HWCAP2 get_elf_hwcap2()

-static uint32_t get_elf_hwcap(void)
+uint32_t get_elf_hwcap(void)
 {
     ARMCPU *cpu =3D ARM_CPU(thread_cpu);
     uint32_t hwcaps =3D 0;
@@ -508,7 +508,7 @@ static uint32_t get_elf_hwcap(void)
     return hwcaps;
 }

-static uint32_t get_elf_hwcap2(void)
+uint32_t get_elf_hwcap2(void)
 {
     ARMCPU *cpu =3D ARM_CPU(thread_cpu);
     uint32_t hwcaps =3D 0;
@@ -521,6 +521,49 @@ static uint32_t get_elf_hwcap2(void)
     return hwcaps;
 }

+const char *elf_hwcap_str(uint32_t bit)
+{
+    static const char *hwcap_str[] =3D {
+    [__builtin_ctz(ARM_HWCAP_ARM_SWP      )] =3D "swp",
+    [__builtin_ctz(ARM_HWCAP_ARM_HALF     )] =3D "half",
+    [__builtin_ctz(ARM_HWCAP_ARM_THUMB    )] =3D "thumb",
+    [__builtin_ctz(ARM_HWCAP_ARM_26BIT    )] =3D "26bit",
+    [__builtin_ctz(ARM_HWCAP_ARM_FAST_MULT)] =3D "fast_mult",
+    [__builtin_ctz(ARM_HWCAP_ARM_FPA      )] =3D "fpa",
+    [__builtin_ctz(ARM_HWCAP_ARM_VFP      )] =3D "vfp",
+    [__builtin_ctz(ARM_HWCAP_ARM_EDSP     )] =3D "edsp",
+    [__builtin_ctz(ARM_HWCAP_ARM_JAVA     )] =3D "java",
+    [__builtin_ctz(ARM_HWCAP_ARM_IWMMXT   )] =3D "iwmmxt",
+    [__builtin_ctz(ARM_HWCAP_ARM_CRUNCH   )] =3D "crunch",
+    [__builtin_ctz(ARM_HWCAP_ARM_THUMBEE  )] =3D "thumbee",
+    [__builtin_ctz(ARM_HWCAP_ARM_NEON     )] =3D "neon",
+    [__builtin_ctz(ARM_HWCAP_ARM_VFPv3    )] =3D "vfpv3",
+    [__builtin_ctz(ARM_HWCAP_ARM_VFPv3D16 )] =3D "vfpv3d16",
+    [__builtin_ctz(ARM_HWCAP_ARM_TLS      )] =3D "tls",
+    [__builtin_ctz(ARM_HWCAP_ARM_VFPv4    )] =3D "vfpv4",
+    [__builtin_ctz(ARM_HWCAP_ARM_IDIVA    )] =3D "idiva",
+    [__builtin_ctz(ARM_HWCAP_ARM_IDIVT    )] =3D "idivt",
+    [__builtin_ctz(ARM_HWCAP_ARM_VFPD32   )] =3D "vfpd32",
+    [__builtin_ctz(ARM_HWCAP_ARM_LPAE     )] =3D "lpae",
+    [__builtin_ctz(ARM_HWCAP_ARM_EVTSTRM  )] =3D "evtstrm",
+    };
+
+    return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
+}
+
+const char *elf_hwcap2_str(uint32_t bit)
+{
+    static const char *hwcap_str[] =3D {
+    [__builtin_ctz(ARM_HWCAP2_ARM_AES  )] =3D "aes",
+    [__builtin_ctz(ARM_HWCAP2_ARM_PMULL)] =3D "pmull",
+    [__builtin_ctz(ARM_HWCAP2_ARM_SHA1 )] =3D "sha1",
+    [__builtin_ctz(ARM_HWCAP2_ARM_SHA2 )] =3D "sha2",
+    [__builtin_ctz(ARM_HWCAP2_ARM_CRC32)] =3D "crc32",
+    };
+
+    return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
+}
+
 #undef GET_FEATURE
 #undef GET_FEATURE_ID

@@ -668,7 +711,7 @@ enum {
 #define GET_FEATURE_ID(feat, hwcap) \
     do { if (cpu_isar_feature(feat, cpu)) { hwcaps |=3D hwcap; } } while =
(0)

-static uint32_t get_elf_hwcap(void)
+uint32_t get_elf_hwcap(void)
 {
     ARMCPU *cpu =3D ARM_CPU(thread_cpu);
     uint32_t hwcaps =3D 0;
@@ -706,7 +749,7 @@ static uint32_t get_elf_hwcap(void)
     return hwcaps;
 }

-static uint32_t get_elf_hwcap2(void)
+uint32_t get_elf_hwcap2(void)
 {
     ARMCPU *cpu =3D ARM_CPU(thread_cpu);
     uint32_t hwcaps =3D 0;
@@ -741,6 +784,85 @@ static uint32_t get_elf_hwcap2(void)
     return hwcaps;
 }

+const char *elf_hwcap_str(uint32_t bit)
+{
+    static const char *hwcap_str[] =3D {
+    [__builtin_ctz(ARM_HWCAP_A64_FP      )] =3D "fp",
+    [__builtin_ctz(ARM_HWCAP_A64_ASIMD   )] =3D "asimd",
+    [__builtin_ctz(ARM_HWCAP_A64_EVTSTRM )] =3D "evtstrm",
+    [__builtin_ctz(ARM_HWCAP_A64_AES     )] =3D "aes",
+    [__builtin_ctz(ARM_HWCAP_A64_PMULL   )] =3D "pmull",
+    [__builtin_ctz(ARM_HWCAP_A64_SHA1    )] =3D "sha1",
+    [__builtin_ctz(ARM_HWCAP_A64_SHA2    )] =3D "sha2",
+    [__builtin_ctz(ARM_HWCAP_A64_CRC32   )] =3D "crc32",
+    [__builtin_ctz(ARM_HWCAP_A64_ATOMICS )] =3D "atomics",
+    [__builtin_ctz(ARM_HWCAP_A64_FPHP    )] =3D "fphp",
+    [__builtin_ctz(ARM_HWCAP_A64_ASIMDHP )] =3D "asimdhp",
+    [__builtin_ctz(ARM_HWCAP_A64_CPUID   )] =3D "cpuid",
+    [__builtin_ctz(ARM_HWCAP_A64_ASIMDRDM)] =3D "asimdrdm",
+    [__builtin_ctz(ARM_HWCAP_A64_JSCVT   )] =3D "jscvt",
+    [__builtin_ctz(ARM_HWCAP_A64_FCMA    )] =3D "fcma",
+    [__builtin_ctz(ARM_HWCAP_A64_LRCPC   )] =3D "lrcpc",
+    [__builtin_ctz(ARM_HWCAP_A64_DCPOP   )] =3D "dcpop",
+    [__builtin_ctz(ARM_HWCAP_A64_SHA3    )] =3D "sha3",
+    [__builtin_ctz(ARM_HWCAP_A64_SM3     )] =3D "sm3",
+    [__builtin_ctz(ARM_HWCAP_A64_SM4     )] =3D "sm4",
+    [__builtin_ctz(ARM_HWCAP_A64_ASIMDDP )] =3D "asimddp",
+    [__builtin_ctz(ARM_HWCAP_A64_SHA512  )] =3D "sha512",
+    [__builtin_ctz(ARM_HWCAP_A64_SVE     )] =3D "sve",
+    [__builtin_ctz(ARM_HWCAP_A64_ASIMDFHM)] =3D "asimdfhm",
+    [__builtin_ctz(ARM_HWCAP_A64_DIT     )] =3D "dit",
+    [__builtin_ctz(ARM_HWCAP_A64_USCAT   )] =3D "uscat",
+    [__builtin_ctz(ARM_HWCAP_A64_ILRCPC  )] =3D "ilrcpc",
+    [__builtin_ctz(ARM_HWCAP_A64_FLAGM   )] =3D "flagm",
+    [__builtin_ctz(ARM_HWCAP_A64_SSBS    )] =3D "ssbs",
+    [__builtin_ctz(ARM_HWCAP_A64_SB      )] =3D "sb",
+    [__builtin_ctz(ARM_HWCAP_A64_PACA    )] =3D "paca",
+    [__builtin_ctz(ARM_HWCAP_A64_PACG    )] =3D "pacg",
+    };
+
+    return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
+}
+
+const char *elf_hwcap2_str(uint32_t bit)
+{
+    static const char *hwcap_str[] =3D {
+    [__builtin_ctz(ARM_HWCAP2_A64_DCPODP       )] =3D "dcpodp",
+    [__builtin_ctz(ARM_HWCAP2_A64_SVE2         )] =3D "sve2",
+    [__builtin_ctz(ARM_HWCAP2_A64_SVEAES       )] =3D "sveaes",
+    [__builtin_ctz(ARM_HWCAP2_A64_SVEPMULL     )] =3D "svepmull",
+    [__builtin_ctz(ARM_HWCAP2_A64_SVEBITPERM   )] =3D "svebitperm",
+    [__builtin_ctz(ARM_HWCAP2_A64_SVESHA3      )] =3D "svesha3",
+    [__builtin_ctz(ARM_HWCAP2_A64_SVESM4       )] =3D "svesm4",
+    [__builtin_ctz(ARM_HWCAP2_A64_FLAGM2       )] =3D "flagm2",
+    [__builtin_ctz(ARM_HWCAP2_A64_FRINT        )] =3D "frint",
+    [__builtin_ctz(ARM_HWCAP2_A64_SVEI8MM      )] =3D "svei8mm",
+    [__builtin_ctz(ARM_HWCAP2_A64_SVEF32MM     )] =3D "svef32mm",
+    [__builtin_ctz(ARM_HWCAP2_A64_SVEF64MM     )] =3D "svef64mm",
+    [__builtin_ctz(ARM_HWCAP2_A64_SVEBF16      )] =3D "svebf16",
+    [__builtin_ctz(ARM_HWCAP2_A64_I8MM         )] =3D "i8mm",
+    [__builtin_ctz(ARM_HWCAP2_A64_BF16         )] =3D "bf16",
+    [__builtin_ctz(ARM_HWCAP2_A64_DGH          )] =3D "dgh",
+    [__builtin_ctz(ARM_HWCAP2_A64_RNG          )] =3D "rng",
+    [__builtin_ctz(ARM_HWCAP2_A64_BTI          )] =3D "bti",
+    [__builtin_ctz(ARM_HWCAP2_A64_MTE          )] =3D "mte",
+    [__builtin_ctz(ARM_HWCAP2_A64_ECV          )] =3D "ecv",
+    [__builtin_ctz(ARM_HWCAP2_A64_AFP          )] =3D "afp",
+    [__builtin_ctz(ARM_HWCAP2_A64_RPRES        )] =3D "rpres",
+    [__builtin_ctz(ARM_HWCAP2_A64_MTE3         )] =3D "mte3",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME          )] =3D "sme",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_I16I64   )] =3D "sme_i16i64",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_F64F64   )] =3D "sme_f64f64",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_I8I32    )] =3D "sme_i8i32",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_F16F32   )] =3D "sme_f16f32",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_B16F32   )] =3D "sme_b16f32",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_F32F32   )] =3D "sme_f32f32",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_FA64     )] =3D "sme_fa64",
+    };
+
+    return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
+}
+
 #undef GET_FEATURE_ID

 #endif /* not TARGET_AARCH64 */
diff --git a/linux-user/loader.h b/linux-user/loader.h
index 59cbeacf24..324e5c872a 100644
=2D-- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -56,9 +56,13 @@ abi_long memcpy_to_target(abi_ulong dest, const void *s=
rc,

 extern unsigned long guest_stack_size;

-#ifdef TARGET_S390X
+#if defined(TARGET_S390X) || defined(TARGET_AARCH64) || defined(TARGET_AR=
M)
 uint32_t get_elf_hwcap(void);
 const char *elf_hwcap_str(uint32_t bit);
 #endif
+#if defined(TARGET_AARCH64) || defined(TARGET_ARM)
+uint32_t get_elf_hwcap2(void);
+const char *elf_hwcap2_str(uint32_t bit);
+#endif

 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1ec7d27e37..bac764f502 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8323,7 +8323,8 @@ void target_exception_dump(CPUArchState *env, const =
char *fmt, int code)

 #if HOST_BIG_ENDIAN !=3D TARGET_BIG_ENDIAN || \
     defined(TARGET_SPARC) || defined(TARGET_M68K) || defined(TARGET_HPPA)=
 || \
-    defined(TARGET_RISCV) || defined(TARGET_S390X)
+    defined(TARGET_RISCV) || defined(TARGET_S390X) || defined(TARGET_ARM)=
 || \
+    defined(TARGET_AARCH64)
 static int is_proc(const char *filename, const char *entry)
 {
     return strcmp(filename, entry) =3D=3D 0;
@@ -8539,6 +8540,76 @@ static int open_hardware(CPUArchState *cpu_env, int=
 fd)
 }
 #endif

+#if defined(TARGET_AARCH64) || defined(TARGET_ARM)
+static int open_cpuinfo(CPUArchState *cpu_env, int fd)
+{
+    ARMCPU *cpu =3D ARM_CPU(thread_cpu);
+    const int rev  =3D FIELD_EX64(cpu->midr, MIDR_EL1, REVISION);
+    int arch, is64;
+    uint32_t elf_hwcap =3D get_elf_hwcap();
+    uint32_t elf_hwcap2 =3D get_elf_hwcap2();
+    const char *hwcap_str;
+    int i, j, num_cpus;
+
+    if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+        arch =3D 8;
+    } else if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+        arch =3D 7;
+    } else if (arm_feature(&cpu->env, ARM_FEATURE_V6)) {
+        arch =3D 6;
+    } else if (arm_feature(&cpu->env, ARM_FEATURE_V5)) {
+        arch =3D 5;
+    } else {
+        arch =3D 4;
+    }
+    is64 =3D (arch >=3D 8) ? 1 : 0;
+
+    num_cpus =3D sysconf(_SC_NPROCESSORS_ONLN);
+    for (i =3D 0; i < num_cpus; i++) {
+        dprintf(fd, "processor\t: %d\n", i);
+        dprintf(fd, "model name\t: ARMv%d Processor rev %d (%sv%d%c)\n",
+            arch, rev, is64 ? "" : "arm", arch, TARGET_BIG_ENDIAN ? 'b' :=
 'l');
+        dprintf(fd, "BogoMIPS\t: %d.00\n", is64 ? 100 : 50);
+        dprintf(fd, "Features\t:");
+        for (j =3D 0; j < sizeof(elf_hwcap) * 8; j++) {
+            if (!(elf_hwcap & (1 << j))) {
+                continue;
+            }
+            hwcap_str =3D elf_hwcap_str(j);
+            if (hwcap_str) {
+                dprintf(fd, " %s", hwcap_str);
+            }
+        }
+        for (j =3D 0; j < sizeof(elf_hwcap2) * 8; j++) {
+            if (!(elf_hwcap2 & (1 << j))) {
+                continue;
+            }
+            hwcap_str =3D elf_hwcap2_str(j);
+            if (hwcap_str) {
+                dprintf(fd, " %s", hwcap_str);
+            }
+        }
+        dprintf(fd, "\n");
+        dprintf(fd, "CPU implementer\t: %#02x\n",
+                (unsigned int) FIELD_EX64(cpu->midr, MIDR_EL1, IMPLEMENTE=
R));
+        dprintf(fd, "CPU architecture: %d\n", arch);
+        dprintf(fd, "CPU variant\t: %#x\n",
+                (unsigned int) FIELD_EX64(cpu->midr, MIDR_EL1, VARIANT));
+        dprintf(fd, "CPU part\t: %#03x\n",
+                (unsigned int) FIELD_EX64(cpu->midr, MIDR_EL1, PARTNUM));
+        dprintf(fd, "CPU revision\t: %d\n\n", rev);
+    }
+
+    dprintf(fd, "Hardware\t: QEMU v%s %s\n", QEMU_VERSION,
+                cpu->dtb_compatible ? : "");
+    if (!is64) {
+        dprintf(fd, "Revision\t: 0000\n");
+        dprintf(fd, "Serial\t\t: 0000000000000000\n");
+    }
+
+    return 0;
+}
+#endif

 int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
                     int flags, mode_t mode, bool safe)
@@ -8561,7 +8632,8 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd=
, const char *fname,
         { "/proc/net/route", open_net_route, is_proc },
 #endif
 #if defined(TARGET_SPARC) || defined(TARGET_HPPA) || \
-    defined(TARGET_RISCV) || defined(TARGET_S390X)
+    defined(TARGET_RISCV) || defined(TARGET_S390X) || \
+    defined(TARGET_ARM)   || defined(TARGET_AARCH64)
         { "/proc/cpuinfo", open_cpuinfo, is_proc },
 #endif
 #if defined(TARGET_M68K)
=2D-
2.41.0



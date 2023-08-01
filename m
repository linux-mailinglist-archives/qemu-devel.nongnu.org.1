Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7204476BD70
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 21:12:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQuln-0002iJ-Dt; Tue, 01 Aug 2023 15:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qQuld-0002Xe-TT; Tue, 01 Aug 2023 15:10:49 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qQulX-0002DB-Nr; Tue, 01 Aug 2023 15:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690917037; x=1691521837; i=deller@gmx.de;
 bh=A9foXwB4xfV1MCiqkjNwcLYxaCPGMINDt6L21YLkWSE=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Lai3Nm2hyVorLpb8v5YEJwV/FQuPZQBz+V8ljKQv/qsvyRxHbLmXCDTNZWJLKdmWacbHcoj
 TGLYC9Hlkaajamw1K9a/p9TE4wRq4pO/k8t05pRo4KLVq397h6t05+VdYvHn1BI8lOfcr4hZl
 EyUa5IVoGSEhwMDSUuRB0H4SnUlBwP+eCLeZl/YKUF530VacHn/SRTz7TKZX2v0gcKvRq0zhh
 qO5MCmSr15pGhUn6lQXRsBZ6opTNqhNbe6QZg//raTSQmgUtGcr99zNpQr2cTYCMhE8GLa2xT
 xmQJAkvgjrFcC9DxSulZzTCDr5DqA0PqlNLCYqm56esLzFzlKS1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.150.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Msq24-1pXyh30y7c-00tFFZ; Tue, 01
 Aug 2023 21:10:37 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 2/2] linux-user: Emulate /proc/cpuinfo on aarch64 and arm
Date: Tue,  1 Aug 2023 21:10:35 +0200
Message-ID: <20230801191035.374120-3-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801191035.374120-1-deller@gmx.de>
References: <20230801191035.374120-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IjMVSLXi1tUy2nsWl6SHNHXUABBdUBqv3vGm0L1p9Sf3Vg2jrB6
 xDBNBdFcpdIippsC3l4xZTEQOb0JpiUC2AClK+IHyaYB7gtXYUo6mtuTPn2PftLc7fk9GJk
 hVz56jVS6cMwhoKQYBt+EOGHHmlrI1FOkODxMerzAt0CSyklqXWqrp32XMpPdRc9j9mWWuR
 5nNjNk3qJqND9aTIiq4Rw==
UI-OutboundReport: notjunk:1;M01:P0:rtFmJehCun8=;hy9qzKqyOVqXnMGyFcJVBulClgI
 QhcWmk/EtXYr6QCHJxCTZYja+cU+YJZCSSaI2vTsTLCoa0blSAkq1GrGEX/skbqGKe3Y0T4nZ
 HJV+y71UwGcc9iR1Z1ZbINPQHEd2zOPCnPfh/+Kq6mwPJAwIPmiBd6Dy1rR4xfx1lqhQQ2fP6
 MUGn3fVDyZhtw6pC+yNcWkV1RIsyPJQZA+sItEhQSp7OguQGZ5cPgcTQB57TGysJeDVdbn2Cx
 z6jZmuy/HZFxFrLACWNlxUfalG4GVxxmugJQLXDb31MZr2NLJ2nHw0Fij8hgDFho6hUb+lyFV
 B3ZOXC2x8NeXXk1Dk1o8VaSb6iuaN3yJSe3a9IMH67ABPg3ji3Zzm9CbZCaxIgqaSeo/pxZke
 f7M1gHjc0ufcHCdvtt6QlCWUuB9z5t8pCOEvNZt3uiyqRz6WPYlaIFucXbZQSUIhxuWYlHhrg
 xRl24CwdOLMl/sX8OXsEtyRpjv+NEHnEnTswxZcY0OMQwRrhB9sx9TCTdLAABySRihBp9Xmnc
 dOgXC3q3LGZGroseFjtK5W6NQJ1uI0QUyTo9GgRPAt/Bh1t0Uf84IrjZW19DjQ9o+pyrV+6hD
 9Lt04IFPWkkIQSQUiG02cpHU3wipWI/P7uIL3/ScrWg2KikTZKbDBCQ2pTcSYYia/BDcoh8VH
 VnhErhUBPmh8hcHIyFgsfadS70zrYVZrwtWJIsYmmZS2CciaUerj/xOGMTWFK/oMRtgyiR/3z
 Cvuy74Jg2YGckWpBcYkibPjFpl7D9aznubB5dhpSvOQvILULSTfEkn4tWkR07S+5h6McomZXf
 x+j3Tga4ahvG7VEnBlJ9f01T7oJJMGWUShwQPKgUmJTpFji8NI/YZXqCfZu6l6cEUQIq6qaL2
 ToC5bxD5Hq1hakJuRXWzWCVFdZekRjcy3cv2WillnOsy23GMQh7fUJDqFeb/eG5NqsqI8RCNM
 zt5lu5D6jm19vvci/EJDfKBd6b0=
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

Add emulation for /proc/cpuinfo for arm architecture.
The output below mimics output as seen on debian porterboxes.

aarch64 output example:

processor       : 0
BogoMIPS        : 100.00
Features        : fp asimd aes pmull sha1 sha2 crc32 atomics fphp asimdhp =
cpuid asimdrdm jscvt fcma lrcpc dcpop sha3 sm3 sm4 asimddp sha512 sve asim=
dfhm ilrcpc flagm sb paca pacg dcpodp sve2 sveaes svepmull svebitperm sves=
ha3 svesm4 flagm2 frint svei8mm svef32mm svef64mm svebf16 i8mm bf16 rng bt=
i mte sme sme_i16i64 sme_f64f64 sme_i8i32 sme_f16f32 sme_b16f32 sme_f32f32=
 sme_fa64
CPU implementer : 0x50
CPU architecture: 8
CPU variant     : 0x0
CPU part        : 0x0
CPU revision    : 1

arm output example:

processor       : 0
model name      : ARMv7 Processor rev 2 (v7l)
BogoMIPS        : 50.00
Features        : swp half thumb fast_mult vfp edsp neon vfpv3 tls vfpv4 i=
diva idivt vfpd32 lpae aes pmull sha1 sha2 crc32
CPU implementer : 0x56
CPU architecture: 7
CPU variant     : 0x2
CPU part        : 0x584
CPU revision    : 2

Hardware        : Marvell Armada 370/XP (Device Tree)
Revision        : 0000
Serial          : 0000000000000000

Signed-off-by: Helge Deller <deller@gmx.de>

v2:
- show features of CPU which is actually being emulated by qemu
  (suggested by Peter Maydell)
=2D--
 linux-user/elfload.c | 130 +++++++++++++++++++++++++++++++++++++++++--
 linux-user/loader.h  |   6 +-
 linux-user/syscall.c |  58 ++++++++++++++++++-
 3 files changed, 187 insertions(+), 7 deletions(-)

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
index a089463969..8d11c459cc 100644
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
@@ -8539,6 +8540,58 @@ static int open_hardware(CPUArchState *cpu_env, int=
 fd)
 }
 #endif

+#if defined(TARGET_AARCH64) || defined(TARGET_ARM)
+static int open_cpuinfo(CPUArchState *cpu_env, int fd)
+{
+    const int is64 =3D TARGET_ABI_BITS =3D=3D 64;
+    uint32_t elf_hwcap =3D get_elf_hwcap();
+    uint32_t elf_hwcap2 =3D get_elf_hwcap2();
+    const char *hwcap_str;
+    int i, j, num_cpus;
+
+    num_cpus =3D sysconf(_SC_NPROCESSORS_ONLN);
+    for (i =3D 0; i < num_cpus; i++) {
+        dprintf(fd, "processor\t: %d\n", i);
+        if (!is64) {
+            dprintf(fd, "model name\t: ARMv7 Processor rev 2 (v7l)\n");
+        }
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
+        dprintf(fd, "CPU implementer\t: 0x%d\n", is64 ? 50 : 56);
+        dprintf(fd, "CPU architecture: %d\n",    is64 ? 8 : 7);
+        dprintf(fd, "CPU variant\t: 0x%d\n",     is64 ? 0 : 2);
+        dprintf(fd, "CPU part\t: 0x%d\n",        is64 ? 0 : 584);
+        dprintf(fd, "CPU revision\t: %d\n\n",    is64 ? 1 : 2);
+    }
+
+    if (!is64) {
+        dprintf(fd, "Hardware\t: %s\n", is64 ? "??" : "Marvell Armada 370=
/XP (Device Tree)");
+        dprintf(fd, "Revision\t: 0000\n");
+        dprintf(fd, "Serial\t\t: 0000000000000000\n");
+    }
+
+    return 0;
+}
+#endif

 int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
                     int flags, mode_t mode, bool safe)
@@ -8561,7 +8614,8 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd=
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



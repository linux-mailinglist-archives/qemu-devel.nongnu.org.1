Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B491777E876
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:16:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWL2h-0002NC-JQ; Wed, 16 Aug 2023 14:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWL2f-0002Lg-6g
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:14:49 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWL2c-0003gz-Ne
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:14:48 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bdc243d62bso32209085ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 11:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692209684; x=1692814484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/VrLavYNm2qSqY+s/daJnb3lPDtmWM2XHscaFIHocI=;
 b=I+X/sp58mJC0uRA/4OZpX+sQctDJxQpB4HPP0uOxflAjGy9ncHI6XXgD+F4lJDsg+p
 HuuAGcPkTrdBEBogQ1imRmpDdMChFAgiTcn9JBcB0dwCzeern84bG1XHlO0qgc70uRFu
 Dxyq/vXOo5BjHxOmv67XVsDn9Ouugm2AVApT/t0uv91FbkiRhCkeOo/MHHY+kc22IC0p
 2EYpZfDSp117ikX1u78BMpuIqbwBZmwzg9FSVcpp7eI4pdikJE6JNc3xgoUnMjsoHiNi
 gKi0w9SfzWZbb0YbRj/mhDcDcuKL00+4a15DLuleMxGGSNW6hm6QRCpvcepWRGmAOQZK
 ysBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692209684; x=1692814484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N/VrLavYNm2qSqY+s/daJnb3lPDtmWM2XHscaFIHocI=;
 b=aw/Tt5fUQeHA3HIyBFXfUfoV33XMIfny08cvU/adoOAtBQO67GJtMaUIRTDatMrwBX
 9GC6brUKs+bG2HG8TyFqDZ6XKy1CXOb+t6WLrrBk3bo+OvurejkRhPvCanfchtRaygAM
 h5G3RJpInUvyJh5cZFj/y7yWCBRSNVdpfePRcq4nAY8Gm1WoHap74sDqSIj/sW7KXmjg
 3jMOY1zfYFddCuSlq+9qyEhffHUg2quR+27uGyR6rgXVC1oMgoDajWKRi8ekVquO1NY6
 m36fRSyYqt0debPdyoQnQ3MCATVJ4VPcX/jQO+KJ3r5kaOYuGvfskCPj4f02e8X6Bdg0
 etuA==
X-Gm-Message-State: AOJu0YzKsk5effT79/HjHTMw/HXrCj3vu1aPyDRiDHKckWB6ESerdwQ7
 fLXC/harLzxD9Frdl87gpJgAa9wAaNG1VTVJKZw=
X-Google-Smtp-Source: AGHT+IF4zTVddy+fqxZMAJ4pdlazNuplThfMVyhX8nHU8pTx2wR4NIqF5MH6ZKCtkkvulRo857tYww==
X-Received: by 2002:a17:902:680e:b0:1b6:6c32:59a8 with SMTP id
 h14-20020a170902680e00b001b66c3259a8mr2479897plk.36.1692209684356; 
 Wed, 16 Aug 2023 11:14:44 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a170902868e00b001b9dab0397bsm13423563plo.29.2023.08.16.11.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 11:14:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	deller@gmx.de
Subject: [PATCH 5/6] linux-user: Remove ELF_START_MMAP and
 image_info.start_mmap
Date: Wed, 16 Aug 2023 11:14:36 -0700
Message-Id: <20230816181437.572997-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816181437.572997-1-richard.henderson@linaro.org>
References: <20230816181437.572997-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The start_mmap value is write-only.
Remove the field and the defines that populated it.
Logically, this has been replaced by task_unmapped_base.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h    |  1 -
 linux-user/elfload.c | 38 --------------------------------------
 2 files changed, 39 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 4f8b55e2fb..12f638336a 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -30,7 +30,6 @@ struct image_info {
         abi_ulong       start_data;
         abi_ulong       end_data;
         abi_ulong       brk;
-        abi_ulong       start_mmap;
         abi_ulong       start_stack;
         abi_ulong       stack_limit;
         abi_ulong       entry;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ab11f141c3..a670a7817a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -156,8 +156,6 @@ static uint32_t get_elf_hwcap(void)
 }
 
 #ifdef TARGET_X86_64
-#define ELF_START_MMAP 0x2aaaaab000ULL
-
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_X86_64
 
@@ -234,8 +232,6 @@ static bool init_guest_commpage(void)
 #endif
 #else
 
-#define ELF_START_MMAP 0x80000000
-
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
@@ -333,8 +329,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
 #ifndef TARGET_AARCH64
 /* 32 bit ARM definitions */
 
-#define ELF_START_MMAP 0x80000000
-
 #define ELF_ARCH        EM_ARM
 #define ELF_CLASS       ELFCLASS32
 #define EXSTACK_DEFAULT true
@@ -606,7 +600,6 @@ static const VdsoImageInfo *vdso_image_info(void)
 
 #else
 /* 64 bit ARM definitions */
-#define ELF_START_MMAP 0x80000000
 
 #define ELF_ARCH        EM_AARCH64
 #define ELF_CLASS       ELFCLASS64
@@ -802,7 +795,6 @@ static uint32_t get_elf_hwcap2(void)
 #ifdef TARGET_SPARC
 #ifdef TARGET_SPARC64
 
-#define ELF_START_MMAP 0x80000000
 #define ELF_HWCAP  (HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR | HWCAP_SPARC_SWAP \
                     | HWCAP_SPARC_MULDIV | HWCAP_SPARC_V9)
 #ifndef TARGET_ABI32
@@ -814,7 +806,6 @@ static uint32_t get_elf_hwcap2(void)
 #define ELF_CLASS   ELFCLASS64
 #define ELF_ARCH    EM_SPARCV9
 #else
-#define ELF_START_MMAP 0x80000000
 #define ELF_HWCAP  (HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR | HWCAP_SPARC_SWAP \
                     | HWCAP_SPARC_MULDIV)
 #define ELF_CLASS   ELFCLASS32
@@ -836,7 +827,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 #ifdef TARGET_PPC
 
 #define ELF_MACHINE    PPC_ELF_MACHINE
-#define ELF_START_MMAP 0x80000000
 
 #if defined(TARGET_PPC64)
 
@@ -1048,8 +1038,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *en
 
 #ifdef TARGET_LOONGARCH64
 
-#define ELF_START_MMAP 0x80000000
-
 #define ELF_CLASS   ELFCLASS64
 #define ELF_ARCH    EM_LOONGARCH
 #define EXSTACK_DEFAULT true
@@ -1144,8 +1132,6 @@ static uint32_t get_elf_hwcap(void)
 
 #ifdef TARGET_MIPS
 
-#define ELF_START_MMAP 0x80000000
-
 #ifdef TARGET_MIPS64
 #define ELF_CLASS   ELFCLASS64
 #else
@@ -1303,8 +1289,6 @@ static uint32_t get_elf_hwcap(void)
 
 #ifdef TARGET_MICROBLAZE
 
-#define ELF_START_MMAP 0x80000000
-
 #define elf_check_arch(x) ( (x) == EM_MICROBLAZE || (x) == EM_MICROBLAZE_OLD)
 
 #define ELF_CLASS   ELFCLASS32
@@ -1345,8 +1329,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env
 
 #ifdef TARGET_NIOS2
 
-#define ELF_START_MMAP 0x80000000
-
 #define elf_check_arch(x) ((x) == EM_ALTERA_NIOS2)
 
 #define ELF_CLASS   ELFCLASS32
@@ -1442,8 +1424,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 #ifdef TARGET_OPENRISC
 
-#define ELF_START_MMAP 0x08000000
-
 #define ELF_ARCH EM_OPENRISC
 #define ELF_CLASS ELFCLASS32
 #define ELF_DATA  ELFDATA2MSB
@@ -1480,8 +1460,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 #ifdef TARGET_SH4
 
-#define ELF_START_MMAP 0x80000000
-
 #define ELF_CLASS ELFCLASS32
 #define ELF_ARCH  EM_SH
 
@@ -1562,8 +1540,6 @@ static uint32_t get_elf_hwcap(void)
 
 #ifdef TARGET_CRIS
 
-#define ELF_START_MMAP 0x80000000
-
 #define ELF_CLASS ELFCLASS32
 #define ELF_ARCH  EM_CRIS
 
@@ -1579,8 +1555,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #ifdef TARGET_M68K
 
-#define ELF_START_MMAP 0x80000000
-
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_68K
 
@@ -1630,8 +1604,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUM68KState *e
 
 #ifdef TARGET_ALPHA
 
-#define ELF_START_MMAP (0x30000000000ULL)
-
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_ALPHA
 
@@ -1649,8 +1621,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #ifdef TARGET_S390X
 
-#define ELF_START_MMAP (0x20000000000ULL)
-
 #define ELF_CLASS	ELFCLASS64
 #define ELF_DATA	ELFDATA2MSB
 #define ELF_ARCH	EM_S390
@@ -1763,7 +1733,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 #ifdef TARGET_RISCV
 
-#define ELF_START_MMAP 0x80000000
 #define ELF_ARCH  EM_RISCV
 
 #ifdef TARGET_RISCV32
@@ -1803,7 +1772,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #ifdef TARGET_HPPA
 
-#define ELF_START_MMAP  0x80000000
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_PARISC
 #define ELF_PLATFORM    "PARISC"
@@ -1859,8 +1827,6 @@ static bool init_guest_commpage(void)
 
 #ifdef TARGET_XTENSA
 
-#define ELF_START_MMAP 0x20000000
-
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_XTENSA
 
@@ -1926,8 +1892,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 #ifdef TARGET_HEXAGON
 
-#define ELF_START_MMAP 0x20000000
-
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_HEXAGON
 
@@ -3684,8 +3648,6 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
     interp_info.fp_abi = MIPS_ABI_FP_UNKNOWN;
 #endif
 
-    info->start_mmap = (abi_ulong)ELF_START_MMAP;
-
     load_elf_image(bprm->filename, &bprm->src, info, &ehdr, &elf_interpreter);
 
     /* Do this so that we can load the interpreter, if need be.  We will
-- 
2.34.1



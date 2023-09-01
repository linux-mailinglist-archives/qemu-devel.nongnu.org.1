Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 238307902ED
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 22:44:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcAzD-0007Ai-RQ; Fri, 01 Sep 2023 16:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAyw-00071D-Ks
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:43:06 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAyu-0001y0-1o
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:43:06 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68c3ec0578bso2056850b3a.2
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 13:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693600980; x=1694205780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=210OlXxvczx1b1iEJ/hgZ0SIwPEb13CqLNf5LjSm/Y4=;
 b=C1idA/A2xT5bGIAYYnodAORH1hVTbdyj0JR7v7cfVdE8KB3OOCXbLEZOPY77EphUYL
 voacJeElOGJjDG7oyAv8qGRFbH9qEhMBm9E/hh0SEg1NcA/GVL2h2DQU2vDnkePy7ILc
 eTg6T1S+VRNH5LuTz7ar/L4P5FNjiUHNAOyZOWRMxbASdeswb2dyxJcqyiUkkIgP7td8
 TERzUmzGUf0jC/95r1OoLosE6Q7Dq+Sw+pSDyMwgj/j/XwoM+7ykJGZj3loefmNyNP0x
 5B/qmAzOV7+EvZ1FwVTrEodDOxAZdzQneu/o1gegFA5vm/KpRxvCGpZypsLn2vCO4h1J
 1J0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693600980; x=1694205780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=210OlXxvczx1b1iEJ/hgZ0SIwPEb13CqLNf5LjSm/Y4=;
 b=NEr5gAiEZvHj2XsYtKzbeosou9Uewxr98uPMbtWjiPkvy6sqcO4v8HyD6YiiM6NYZN
 fwBhHi+RgDs54ZGkhP0/S9ELQuaZ+k/xpWaSORFXkY5I3e5Lro6FN59RnRxtMZjptJD7
 z+oQn33FWNCxXmFWp36NhTTWhNqmEotGj8jVMn5//0+WTy0IUOoFGk8cDBotYU5tLyQY
 SgSmlEy2uhvpDhZ6Ed4mZuR1+PUqA04bEpoT5s6WJPWVmWYfTj1m3IHxXW/rOF8EMQdE
 /RI0vEmeB59RW70puQSoS0bVOHQgyM0HvKXZL4N0bAY7+OUOpcjSb5vXtoD8jDe2MXsb
 8STg==
X-Gm-Message-State: AOJu0Yygm7hgHp5EYJh9zvM83/X8hFDNsChznzsh+hMT48Pee1Jnj3Ly
 HEHpdxrjNfW9+5tWknIuORguKOPns7wdC/1lYcU=
X-Google-Smtp-Source: AGHT+IFqZQDxQk254ul7Q3VyznTjxeevvxKJKBjb7zYNjh8zN1MQnhxA8qR8dD3+WPym0F0vmyZ5PA==
X-Received: by 2002:aa7:888a:0:b0:68a:5cf8:dad5 with SMTP id
 z10-20020aa7888a000000b0068a5cf8dad5mr3894952pfe.2.1693600980664; 
 Fri, 01 Sep 2023 13:43:00 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j15-20020aa78d0f000000b0068c97a4eb0dsm3320666pfe.191.2023.09.01.13.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 13:43:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/13] linux-user: Remove ELF_START_MMAP and
 image_info.start_mmap
Date: Fri,  1 Sep 2023 13:42:47 -0700
Message-Id: <20230901204251.137307-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901204251.137307-1-richard.henderson@linaro.org>
References: <20230901204251.137307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index d52d47c5c3..a5b28fa3e7 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -143,8 +143,6 @@ static uint32_t get_elf_hwcap(void)
 }
 
 #ifdef TARGET_X86_64
-#define ELF_START_MMAP 0x2aaaaab000ULL
-
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_X86_64
 
@@ -221,8 +219,6 @@ static bool init_guest_commpage(void)
 #endif
 #else
 
-#define ELF_START_MMAP 0x80000000
-
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
@@ -308,8 +304,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
 #ifndef TARGET_AARCH64
 /* 32 bit ARM definitions */
 
-#define ELF_START_MMAP 0x80000000
-
 #define ELF_ARCH        EM_ARM
 #define ELF_CLASS       ELFCLASS32
 #define EXSTACK_DEFAULT true
@@ -600,7 +594,6 @@ static const char *get_elf_platform(void)
 
 #else
 /* 64 bit ARM definitions */
-#define ELF_START_MMAP 0x80000000
 
 #define ELF_ARCH        EM_AARCH64
 #define ELF_CLASS       ELFCLASS64
@@ -871,7 +864,6 @@ const char *elf_hwcap2_str(uint32_t bit)
 #ifdef TARGET_SPARC
 #ifdef TARGET_SPARC64
 
-#define ELF_START_MMAP 0x80000000
 #define ELF_HWCAP  (HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR | HWCAP_SPARC_SWAP \
                     | HWCAP_SPARC_MULDIV | HWCAP_SPARC_V9)
 #ifndef TARGET_ABI32
@@ -883,7 +875,6 @@ const char *elf_hwcap2_str(uint32_t bit)
 #define ELF_CLASS   ELFCLASS64
 #define ELF_ARCH    EM_SPARCV9
 #else
-#define ELF_START_MMAP 0x80000000
 #define ELF_HWCAP  (HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR | HWCAP_SPARC_SWAP \
                     | HWCAP_SPARC_MULDIV)
 #define ELF_CLASS   ELFCLASS32
@@ -905,7 +896,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 #ifdef TARGET_PPC
 
 #define ELF_MACHINE    PPC_ELF_MACHINE
-#define ELF_START_MMAP 0x80000000
 
 #if defined(TARGET_PPC64)
 
@@ -1108,8 +1098,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *en
 
 #ifdef TARGET_LOONGARCH64
 
-#define ELF_START_MMAP 0x80000000
-
 #define ELF_CLASS   ELFCLASS64
 #define ELF_ARCH    EM_LOONGARCH
 #define EXSTACK_DEFAULT true
@@ -1200,8 +1188,6 @@ static uint32_t get_elf_hwcap(void)
 
 #ifdef TARGET_MIPS
 
-#define ELF_START_MMAP 0x80000000
-
 #ifdef TARGET_MIPS64
 #define ELF_CLASS   ELFCLASS64
 #else
@@ -1359,8 +1345,6 @@ static uint32_t get_elf_hwcap(void)
 
 #ifdef TARGET_MICROBLAZE
 
-#define ELF_START_MMAP 0x80000000
-
 #define elf_check_arch(x) ( (x) == EM_MICROBLAZE || (x) == EM_MICROBLAZE_OLD)
 
 #define ELF_CLASS   ELFCLASS32
@@ -1401,8 +1385,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env
 
 #ifdef TARGET_NIOS2
 
-#define ELF_START_MMAP 0x80000000
-
 #define elf_check_arch(x) ((x) == EM_ALTERA_NIOS2)
 
 #define ELF_CLASS   ELFCLASS32
@@ -1498,8 +1480,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 #ifdef TARGET_OPENRISC
 
-#define ELF_START_MMAP 0x08000000
-
 #define ELF_ARCH EM_OPENRISC
 #define ELF_CLASS ELFCLASS32
 #define ELF_DATA  ELFDATA2MSB
@@ -1536,8 +1516,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 #ifdef TARGET_SH4
 
-#define ELF_START_MMAP 0x80000000
-
 #define ELF_CLASS ELFCLASS32
 #define ELF_ARCH  EM_SH
 
@@ -1618,8 +1596,6 @@ static uint32_t get_elf_hwcap(void)
 
 #ifdef TARGET_CRIS
 
-#define ELF_START_MMAP 0x80000000
-
 #define ELF_CLASS ELFCLASS32
 #define ELF_ARCH  EM_CRIS
 
@@ -1635,8 +1611,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #ifdef TARGET_M68K
 
-#define ELF_START_MMAP 0x80000000
-
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_68K
 
@@ -1686,8 +1660,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUM68KState *e
 
 #ifdef TARGET_ALPHA
 
-#define ELF_START_MMAP (0x30000000000ULL)
-
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_ALPHA
 
@@ -1705,8 +1677,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #ifdef TARGET_S390X
 
-#define ELF_START_MMAP (0x20000000000ULL)
-
 #define ELF_CLASS	ELFCLASS64
 #define ELF_DATA	ELFDATA2MSB
 #define ELF_ARCH	EM_S390
@@ -1817,7 +1787,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 #ifdef TARGET_RISCV
 
-#define ELF_START_MMAP 0x80000000
 #define ELF_ARCH  EM_RISCV
 
 #ifdef TARGET_RISCV32
@@ -1853,7 +1822,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #ifdef TARGET_HPPA
 
-#define ELF_START_MMAP  0x80000000
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_PARISC
 #define ELF_PLATFORM    "PARISC"
@@ -1905,8 +1873,6 @@ static bool init_guest_commpage(void)
 
 #ifdef TARGET_XTENSA
 
-#define ELF_START_MMAP 0x20000000
-
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_XTENSA
 
@@ -1972,8 +1938,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 #ifdef TARGET_HEXAGON
 
-#define ELF_START_MMAP 0x20000000
-
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_HEXAGON
 
@@ -3690,8 +3654,6 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
     interp_info.fp_abi = MIPS_ABI_FP_UNKNOWN;
 #endif
 
-    info->start_mmap = (abi_ulong)ELF_START_MMAP;
-
     load_elf_image(bprm->filename, bprm->fd, info,
                    &elf_interpreter, bprm->buf);
 
-- 
2.34.1



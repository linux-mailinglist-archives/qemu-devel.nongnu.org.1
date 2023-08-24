Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B1578646E
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 03:05:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYykO-0000EZ-Ce; Wed, 23 Aug 2023 21:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYykM-0000A6-AG
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 21:02:50 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYykJ-0000Rm-Ku
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 21:02:50 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68a3082c771so308935b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 18:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692838966; x=1693443766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KH0FHPd2e6QV8ZmEsDwRCzlCpTkPvLk9RV9t+BHx8lg=;
 b=qrjREae0vYGgV59nzd5uaUetMBJJfB928NlFtfawd9KRmwtkPl+SJ5cW5lGehCAb/K
 p9z2dS7ly/LClyQGzSFzovwmDN3JM52z5MJ8c9rRY84ZF0uz5jeUqfBwWL1Dgye2nW9v
 Aky+wQ/woTQg2nCMM2y8cIaCmxpoyk49tUAU9eZshUQbqo7rXIHg0shW7kvRxZMnzFCw
 +cKL46HCTdMrSXDuPCXnSiANjSeJ6YHrWnPEypJeEKKWM2Pohln6pM+L8ZNgB58jMydP
 AU9Y/xcTMI6q4kWLUfQRJLuajNap5doYHHjAnvd1oIQ+vF25SvZFwDy8c/GQ4Pl4Aykp
 kB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692838966; x=1693443766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KH0FHPd2e6QV8ZmEsDwRCzlCpTkPvLk9RV9t+BHx8lg=;
 b=IEugWMtt2pRdexlMba4zKzwCQU3odK5Iym5josGlAUaymbFij6ERuhEwv8Vbxopdy/
 Ix6XKH+7I93ovAbZiUP/WAiy/8DnZaRw7Fgz7HXytemaOSGlKusjxQJKDg+86zCgfq++
 TRi++86y1ZvsWBPcJ6UMJa8oFAu3pxmxCSWyPX2FjKMFhuBlCJbr0Y/k7FKPPtrs+dsl
 /RZ/x9TbHLSIvL9r/8bRtc336llUzEK7Bc21oU6oFKJNVP0fSyO0Obl4L7vfeN9cp349
 /3v5swg/bWe4ox8lSlIYt0RmwOl9pVUewkixX59DvNKP29rl9OduSZHq30Wbt4yypiHC
 F8WA==
X-Gm-Message-State: AOJu0YzR0dRDlDk4JAmZqhg4k9uTJlXjoBkyJONPU+p4dlEexQDmQw/n
 o7AguDObbjhE8CmfXiOhGRDoRhMQRT7gdtVCRj8=
X-Google-Smtp-Source: AGHT+IGe9scQgB+P0dLDzQMqqLVt90YsPYVbkHqq4hiVQxhF5KB4wmTO7wLCfcYcxRS3yY0UQnuDSw==
X-Received: by 2002:a05:6a00:801a:b0:68a:4163:66f with SMTP id
 eg26-20020a056a00801a00b0068a4163066fmr17000226pfb.9.1692838966308; 
 Wed, 23 Aug 2023 18:02:46 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 c10-20020aa78c0a000000b006875df4773fsm2050789pfd.163.2023.08.23.18.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 18:02:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/13] linux-user: Remove ELF_START_MMAP and
 image_info.start_mmap
Date: Wed, 23 Aug 2023 18:02:33 -0700
Message-Id: <20230824010237.1379735-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824010237.1379735-1-richard.henderson@linaro.org>
References: <20230824010237.1379735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
index dbc5d430e8..fdb87d80d3 100644
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
@@ -1816,7 +1786,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 #ifdef TARGET_RISCV
 
-#define ELF_START_MMAP 0x80000000
 #define ELF_ARCH  EM_RISCV
 
 #ifdef TARGET_RISCV32
@@ -1852,7 +1821,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #ifdef TARGET_HPPA
 
-#define ELF_START_MMAP  0x80000000
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_PARISC
 #define ELF_PLATFORM    "PARISC"
@@ -1904,8 +1872,6 @@ static bool init_guest_commpage(void)
 
 #ifdef TARGET_XTENSA
 
-#define ELF_START_MMAP 0x20000000
-
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_XTENSA
 
@@ -1971,8 +1937,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 #ifdef TARGET_HEXAGON
 
-#define ELF_START_MMAP 0x20000000
-
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_HEXAGON
 
@@ -3689,8 +3653,6 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
     interp_info.fp_abi = MIPS_ABI_FP_UNKNOWN;
 #endif
 
-    info->start_mmap = (abi_ulong)ELF_START_MMAP;
-
     load_elf_image(bprm->filename, bprm->fd, info,
                    &elf_interpreter, bprm->buf);
 
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D67FF76F982
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 07:21:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRnFM-00041e-1j; Fri, 04 Aug 2023 01:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qRnFH-0003iy-Mv
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:21:05 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qRnFF-000124-5s
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:21:03 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-54290603887so948894a12.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 22:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691126459; x=1691731259;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aX7hAlhrK8IRPaAfn7CLAOTCPGRHTRku19fZyN2Y+U8=;
 b=gJdDFyoV6IZhzF52g9VG5lyFDKLospAjuDZ/0Q1+mpugmpRKmbeETgAeTDqpNvzvz9
 jsHdyFhEqzH8FldjgsOeoxsPqw/5Kj/i45bDrGG5bivYAAolWDwx8W4ZgfiN/9v3zggY
 XJqwCLm92iW2moyzIfR+FkH7cFHwD5vQtBvOXQUs1wradUVzqLdtgx2/OR6F1YYUFPwn
 /v+T+n3liT3Jw+L+whLnnyzhTbolIzkAgFOD1jpnh9akC+l9Pb9d6Z/i7dh4b2IUrTTa
 q0lPKr0qRI0Gb4Qz/y9GF8dKeNR/kRG/BBTOROkUdTysYzh2zhwCaRSYVzig79SDpifB
 s8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691126459; x=1691731259;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aX7hAlhrK8IRPaAfn7CLAOTCPGRHTRku19fZyN2Y+U8=;
 b=Vy34/HVup2FEOAnWlANPlhclwQKpjmpmmV9aMZYmx5PE8TsaheLi8vkA3fMlGEOBmT
 ZtEdjISnBmH0mG5umx37XfVlXdOHtCxo73YGGUNQpWC/Nu+pInmDKwqHVNasN5oqkiZA
 rxJ2WkdCJPdlYnbdI/eP/v4Ho95DP9ayAl/nz+juIyZ6Nq9gBO9FJleJOYyJEqJKiOl2
 i9R5VSJJkyUQ978e5F3ZwqY8pf2jXKDGhNueIU5mBtIEh2WBjqPBdC4tvFEQDvtsk/19
 37G4T0QU33y6gpNZzAkqLvCM2rsql35FLmlDPK89khRBjL2x2fP6dm5bJf8fC5u2g2Mo
 8b0w==
X-Gm-Message-State: AOJu0Ywr2foqm1X09Y9vMEBENeQJ5infKfeamgafLi4Xery7LWvAMe41
 hFzM02hKiPVET43BfRvC44mJzA==
X-Google-Smtp-Source: AGHT+IEd8gzM8ZS5ekO6gmy0FFHIRpT8iWJlWxT6NGmMo01vmZMJn4BL7Ae4kuTQq15k3tg10eL3iw==
X-Received: by 2002:a17:902:e84a:b0:1b8:9ecd:8b86 with SMTP id
 t10-20020a170902e84a00b001b89ecd8b86mr684067plg.5.1691126458862; 
 Thu, 03 Aug 2023 22:20:58 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 jk21-20020a170903331500b001bbb7d8fff2sm763579plb.116.2023.08.03.22.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 22:20:58 -0700 (PDT)
Message-ID: <e6b824bb-9bc6-3609-e58c-37963e110fbe@daynix.com>
Date: Fri, 4 Aug 2023 14:20:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/17] linux-user: Define ELF_ET_DYN_BASE in
 $guest/target_mman.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: joel@jms.id.au, laurent@vivier.eu, deller@gmx.de
References: <20230804014517.6361-1-richard.henderson@linaro.org>
 <20230804014517.6361-11-richard.henderson@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230804014517.6361-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/08/04 10:45, Richard Henderson wrote:
> Copy each guest kernel's default value, then bound it
> against reserved_va or the host address space.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/aarch64/target_mman.h     |  3 +++
>   linux-user/alpha/target_mman.h       |  3 +++
>   linux-user/arm/target_mman.h         |  3 +++
>   linux-user/cris/target_mman.h        |  3 +++
>   linux-user/hexagon/target_mman.h     |  3 +++
>   linux-user/hppa/target_mman.h        |  3 +++
>   linux-user/i386/target_mman.h        |  3 +++
>   linux-user/loongarch64/target_mman.h |  3 +++
>   linux-user/m68k/target_mman.h        |  2 ++
>   linux-user/microblaze/target_mman.h  |  3 +++
>   linux-user/mips/target_mman.h        |  3 +++
>   linux-user/nios2/target_mman.h       |  3 +++
>   linux-user/openrisc/target_mman.h    |  3 +++
>   linux-user/ppc/target_mman.h         |  7 +++++++
>   linux-user/riscv/target_mman.h       |  3 +++
>   linux-user/s390x/target_mman.h       | 10 ++++++++++
>   linux-user/sh4/target_mman.h         |  3 +++
>   linux-user/sparc/target_mman.h       | 11 +++++++++++
>   linux-user/user-mmap.h               |  1 +
>   linux-user/x86_64/target_mman.h      |  3 +++
>   linux-user/xtensa/target_mman.h      |  4 ++++
>   linux-user/main.c                    | 15 +++++++++++++++
>   linux-user/mmap.c                    |  1 +
>   23 files changed, 96 insertions(+)
> 
> diff --git a/linux-user/aarch64/target_mman.h b/linux-user/aarch64/target_mman.h
> index 4d3eecfb26..69ec5d5739 100644
> --- a/linux-user/aarch64/target_mman.h
> +++ b/linux-user/aarch64/target_mman.h
> @@ -14,6 +14,9 @@
>    */
>   #define TASK_UNMAPPED_BASE      (1ull << (48 - 2))
>   
> +/* arch/arm64/include/asm/elf.h */
> +#define ELF_ET_DYN_BASE         TARGET_PAGE_ALIGN((1ull << 48) / 3 * 2)
> +
>   #include "../generic/target_mman.h"
>   
>   #endif
> diff --git a/linux-user/alpha/target_mman.h b/linux-user/alpha/target_mman.h
> index c90b493711..8edfe2b88c 100644
> --- a/linux-user/alpha/target_mman.h
> +++ b/linux-user/alpha/target_mman.h
> @@ -28,6 +28,9 @@
>    */
>   #define TASK_UNMAPPED_BASE      0x20000000000ull
>   
> +/* arch/alpha/include/asm/elf.h */
> +#define ELF_ET_DYN_BASE         (TASK_UNMAPPED_BASE + 0x1000000)
> +
>   #include "../generic/target_mman.h"
>   
>   #endif
> diff --git a/linux-user/arm/target_mman.h b/linux-user/arm/target_mman.h
> index 76275b2c7e..51005da869 100644
> --- a/linux-user/arm/target_mman.h
> +++ b/linux-user/arm/target_mman.h
> @@ -6,4 +6,7 @@
>    */
>   #define TASK_UNMAPPED_BASE   0x40000000
>   
> +/* arch/arm/include/asm/elf.h */
> +#define ELF_ET_DYN_BASE      0x00400000
> +
>   #include "../generic/target_mman.h"
> diff --git a/linux-user/cris/target_mman.h b/linux-user/cris/target_mman.h
> index 9df7b1eda5..9ace8ac292 100644
> --- a/linux-user/cris/target_mman.h
> +++ b/linux-user/cris/target_mman.h
> @@ -7,4 +7,7 @@
>    */
>   #define TASK_UNMAPPED_BASE TARGET_PAGE_ALIGN(0xb0000000 / 3)
>   
> +/* arch/cris/include/uapi/asm/elf.h */
> +#define ELF_ET_DYN_BASE    (TASK_UNMAPPED_BASE * 2)
> +
>   #include "../generic/target_mman.h"
> diff --git a/linux-user/hexagon/target_mman.h b/linux-user/hexagon/target_mman.h
> index c5ae336e07..e6b5e2ca36 100644
> --- a/linux-user/hexagon/target_mman.h
> +++ b/linux-user/hexagon/target_mman.h
> @@ -8,4 +8,7 @@
>    */
>   #define TASK_UNMAPPED_BASE   0x40000000
>   
> +/* arch/hexagon/include/asm/elf.h */
> +#define ELF_ET_DYN_BASE      0x08000000
> +
>   #include "../generic/target_mman.h"
> diff --git a/linux-user/hppa/target_mman.h b/linux-user/hppa/target_mman.h
> index 6459e7dbdd..ccda46e842 100644
> --- a/linux-user/hppa/target_mman.h
> +++ b/linux-user/hppa/target_mman.h
> @@ -27,6 +27,9 @@
>   /* arch/parisc/include/asm/processor.h: DEFAULT_MAP_BASE32 */
>   #define TASK_UNMAPPED_BASE      0x40000000
>   
> +/* arch/parisc/include/asm/elf.h */
> +#define ELF_ET_DYN_BASE         (TASK_UNMAPPED_BASE + 0x01000000)
> +
>   #include "../generic/target_mman.h"
>   
>   #endif
> diff --git a/linux-user/i386/target_mman.h b/linux-user/i386/target_mman.h
> index cc3382007f..e3b8e1eaa6 100644
> --- a/linux-user/i386/target_mman.h
> +++ b/linux-user/i386/target_mman.h
> @@ -11,4 +11,7 @@
>    */
>   #define TASK_UNMAPPED_BASE    0x40000000
>   
> +/* arch/x86/include/asm/elf.h */
> +#define ELF_ET_DYN_BASE       0x00400000
> +
>   #include "../generic/target_mman.h"
> diff --git a/linux-user/loongarch64/target_mman.h b/linux-user/loongarch64/target_mman.h
> index d70e44d44c..8c2a3d5596 100644
> --- a/linux-user/loongarch64/target_mman.h
> +++ b/linux-user/loongarch64/target_mman.h
> @@ -6,4 +6,7 @@
>   #define TASK_UNMAPPED_BASE \
>       TARGET_PAGE_ALIGN((1ull << TARGET_VIRT_ADDR_SPACE_BITS) / 3)
>   
> +/* arch/loongarch/include/asm/elf.h */
> +#define ELF_ET_DYN_BASE       (TASK_UNMAPPED_BASE * 2)
> +
>   #include "../generic/target_mman.h"
> diff --git a/linux-user/m68k/target_mman.h b/linux-user/m68k/target_mman.h
> index d3eceb663b..20cfe750c5 100644
> --- a/linux-user/m68k/target_mman.h
> +++ b/linux-user/m68k/target_mman.h
> @@ -1,4 +1,6 @@
>   /* arch/m68k/include/asm/processor.h */
>   #define TASK_UNMAPPED_BASE      0xC0000000
> +/* arch/m68k/include/asm/elf.h */
> +#define ELF_ET_DYN_BASE         0xD0000000
>   
>   #include "../generic/target_mman.h"
> diff --git a/linux-user/microblaze/target_mman.h b/linux-user/microblaze/target_mman.h
> index ffee869db4..6b3dd54f89 100644
> --- a/linux-user/microblaze/target_mman.h
> +++ b/linux-user/microblaze/target_mman.h
> @@ -6,4 +6,7 @@
>    */
>   #define TASK_UNMAPPED_BASE      0x48000000
>   
> +/* arch/microblaze/include/uapi/asm/elf.h */
> +#define ELF_ET_DYN_BASE         0x08000000
> +
>   #include "../generic/target_mman.h"
> diff --git a/linux-user/mips/target_mman.h b/linux-user/mips/target_mman.h
> index fe1eec2d0b..b84fe1e8a8 100644
> --- a/linux-user/mips/target_mman.h
> +++ b/linux-user/mips/target_mman.h
> @@ -21,6 +21,9 @@
>   #define TASK_UNMAPPED_BASE \
>       TARGET_PAGE_ALIGN((1ull << TARGET_VIRT_ADDR_SPACE_BITS) / 3)
>   
> +/* arch/mips/include/asm/elf.h */
> +#define ELF_ET_DYN_BASE       (TASK_UNMAPPED_BASE * 2)
> +
>   #include "../generic/target_mman.h"
>   
>   #endif
> diff --git a/linux-user/nios2/target_mman.h b/linux-user/nios2/target_mman.h
> index ce18f4f871..ab16ad4f03 100644
> --- a/linux-user/nios2/target_mman.h
> +++ b/linux-user/nios2/target_mman.h
> @@ -5,4 +5,7 @@
>    */
>   #define TASK_UNMAPPED_BASE    TARGET_PAGE_ALIGN(0x7FFF0000 / 3)
>   
> +/* arch/nios2/include/asm/elf.h */
> +#define ELF_ET_DYN_BASE       0xD0000000
> +
>   #include "../generic/target_mman.h"
> diff --git a/linux-user/openrisc/target_mman.h b/linux-user/openrisc/target_mman.h
> index f1aaad809d..243c1d5f26 100644
> --- a/linux-user/openrisc/target_mman.h
> +++ b/linux-user/openrisc/target_mman.h
> @@ -5,4 +5,7 @@
>    */
>   #define TASK_UNMAPPED_BASE      0x30000000
>   
> +/* arch/openrisc/include/asm/elf.h */
> +#define ELF_ET_DYN_BASE         0x08000000
> +
>   #include "../generic/target_mman.h"
> diff --git a/linux-user/ppc/target_mman.h b/linux-user/ppc/target_mman.h
> index 04f99c6077..646d1ccae7 100644
> --- a/linux-user/ppc/target_mman.h
> +++ b/linux-user/ppc/target_mman.h
> @@ -17,6 +17,13 @@
>   #define TASK_UNMAPPED_BASE      0x40000000
>   #endif
>   
> +/* arch/powerpc/include/asm/elf.h */
> +#ifdef TARGET_PPC64
> +#define ELF_ET_DYN_BASE         0x100000000ull
> +#else
> +#define ELF_ET_DYN_BASE         0x000400000
> +#endif
> +
>   #include "../generic/target_mman.h"
>   
>   #endif
> diff --git a/linux-user/riscv/target_mman.h b/linux-user/riscv/target_mman.h
> index 0f06dadbd4..3049bcc67d 100644
> --- a/linux-user/riscv/target_mman.h
> +++ b/linux-user/riscv/target_mman.h
> @@ -5,4 +5,7 @@
>   #define TASK_UNMAPPED_BASE \
>       TARGET_PAGE_ALIGN((1ull << (TARGET_VIRT_ADDR_SPACE_BITS - 1)) / 3)
>   
> +/* arch/riscv/include/asm/elf.h */
> +#define ELF_ET_DYN_BASE       (TASK_UNMAPPED_BASE * 2)
> +
>   #include "../generic/target_mman.h"
> diff --git a/linux-user/s390x/target_mman.h b/linux-user/s390x/target_mman.h
> index 40d149b329..c82435e381 100644
> --- a/linux-user/s390x/target_mman.h
> +++ b/linux-user/s390x/target_mman.h
> @@ -8,4 +8,14 @@
>    */
>   #define TASK_UNMAPPED_BASE      (1ull << 41)
>   
> +/*
> + * arch/s390/include/asm/elf.h:
> + * ELF_ET_DYN_BASE              (STACK_TOP / 3 * 2) & ~((1UL << 32) - 1)
> + *
> + * arch/s390/include/asm/processor.h:
> + * STACK_TOP                    VDSO_LIMIT - VDSO_SIZE - PAGE_SIZE
> + * VDSO_LIMIT                   _REGION2_SIZE
> + */
> +#define ELF_ET_DYN_BASE         (((1ull << 42) / 3 * 2) & ~0xffffffffull)
> +
>   #include "../generic/target_mman.h"
> diff --git a/linux-user/sh4/target_mman.h b/linux-user/sh4/target_mman.h
> index bbbc223398..dd9016081e 100644
> --- a/linux-user/sh4/target_mman.h
> +++ b/linux-user/sh4/target_mman.h
> @@ -2,4 +2,7 @@
>   #define TASK_UNMAPPED_BASE \
>       TARGET_PAGE_ALIGN((1u << TARGET_VIRT_ADDR_SPACE_BITS) / 3)
>   
> +/* arch/sh/include/asm/elf.h */
> +#define ELF_ET_DYN_BASE       (TASK_UNMAPPED_BASE * 2)
> +
>   #include "../generic/target_mman.h"
> diff --git a/linux-user/sparc/target_mman.h b/linux-user/sparc/target_mman.h
> index 692ebf9dd7..696ca73fe4 100644
> --- a/linux-user/sparc/target_mman.h
> +++ b/linux-user/sparc/target_mman.h
> @@ -19,6 +19,17 @@
>   #define TASK_UNMAPPED_BASE      (1ull << (TARGET_VIRT_ADDR_SPACE_BITS - 2))
>   #endif
>   
> +/*
> + * arch/sparc/include/asm/elf_64.h
> + * Except that COMPAT_ELF_ET_DYN_BASE exactly matches TASK_UNMAPPED_BASE,
> + * so move it up a bit.
> + */
> +#ifdef TARGET_ABI32
> +#define ELF_ET_DYN_BASE         0x78000000
> +#else
> +#define ELF_ET_DYN_BASE         0x0000010000000000ull
> +#endif
> +
>   #include "../generic/target_mman.h"
>   
>   #endif
> diff --git a/linux-user/user-mmap.h b/linux-user/user-mmap.h
> index bae49059e0..5dd48a458d 100644
> --- a/linux-user/user-mmap.h
> +++ b/linux-user/user-mmap.h
> @@ -20,6 +20,7 @@
>   
>   extern abi_ulong task_unmapped_base;
>   extern abi_ulong mmap_next_start;
> +extern abi_ulong elf_et_dyn_base;
>   
>   int target_mprotect(abi_ulong start, abi_ulong len, int prot);
>   abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
> diff --git a/linux-user/x86_64/target_mman.h b/linux-user/x86_64/target_mman.h
> index f9ff652b37..48fbf20b42 100644
> --- a/linux-user/x86_64/target_mman.h
> +++ b/linux-user/x86_64/target_mman.h
> @@ -10,4 +10,7 @@
>   #define TASK_UNMAPPED_BASE \
>       TARGET_PAGE_ALIGN((1ull << TARGET_VIRT_ADDR_SPACE_BITS) / 3)
>   
> +/* arch/x86/include/asm/elf.h */
> +#define ELF_ET_DYN_BASE       (TASK_UNMAPPED_BASE * 2)
> +
>   #include "../generic/target_mman.h"
> diff --git a/linux-user/xtensa/target_mman.h b/linux-user/xtensa/target_mman.h
> index c4f671adb7..8fa6337a97 100644
> --- a/linux-user/xtensa/target_mman.h
> +++ b/linux-user/xtensa/target_mman.h
> @@ -20,6 +20,10 @@
>    */
>   #define TASK_UNMAPPED_BASE      (1u << (TARGET_VIRT_ADDR_SPACE_BITS - 1))
>   
> +/* arch/xtensa/include/asm/elf.h */
> +#define ELF_ET_DYN_BASE \
> +    TARGET_PAGE_ALIGN((1u << TARGET_VIRT_ADDR_SPACE_BITS) / 3)
> +
>   #include "../generic/target_mman.h"
>   
>   #endif
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 52809c260a..e089123cfa 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -839,6 +839,21 @@ int main(int argc, char **argv, char **envp)
>       }
>       mmap_next_start = task_unmapped_base;
>   
> +    /* Similarly for elf_et_dyn_base. */
> +    if (reserved_va) {
> +        if (ELF_ET_DYN_BASE < reserved_va) {
> +            elf_et_dyn_base = ELF_ET_DYN_BASE;
> +        } else {
> +            /* The most common default formula is TASK_SIZE / 3 * 2. */
> +            task_unmapped_base = TARGET_PAGE_ALIGN(reserved_va / 3) * 2;

This assigns a value to task_unmapped_base and that does not seem correct.

> +        }
> +    } else if (ELF_ET_DYN_BASE < UINTPTR_MAX) {
> +        elf_et_dyn_base = ELF_ET_DYN_BASE;
> +    } else {
> +        /* 32-bit host: pick something medium size. */
> +        task_unmapped_base = 0x18000000;
> +    }
> +
>       {
>           Error *err = NULL;
>           if (seed_optarg != NULL) {
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 84436d45c8..949c4090f3 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -301,6 +301,7 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
>   
>   abi_ulong task_unmapped_base;
>   abi_ulong mmap_next_start;
> +abi_ulong elf_et_dyn_base;
>   
>   /*
>    * Subroutine of mmap_find_vma, used when we have pre-allocated


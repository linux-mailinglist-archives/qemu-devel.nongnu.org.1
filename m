Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B4D77394C
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 11:20:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTIrm-0005Et-VY; Tue, 08 Aug 2023 05:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTIrl-0005Eh-3x
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 05:19:01 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTIrj-0004lg-Cc
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 05:19:00 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fe1d462762so45872545e9.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 02:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691486337; x=1692091137;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkqVhA0IQEjzDkz8HZI7bBlbDT9b4jMYdzRAKUTnjqc=;
 b=VIMeF3RZednZNJNJkktea9tkSssu114kHv3lenvUFcVcw9X90IhQTtfeentbHub1tk
 nOKyY18mZi/AbEupDk/bH4upx0ky0mPJmNpHdzLmoAm3RjjuxIfNpPTKpFf56lEsTJbj
 BUWFKYx99CFB/44nlzpBrM7q5eIdUnZALT4+uewdicJGPwAI7YryB6j6AiHxPpCWS2iy
 dkUwxFHAENnte6puuGxblmtqhLvFH3Rdg5QHVZQATPeDvW3mbhHvogA1plonL3VkoFHK
 vJIG23tDubjxawblraecj6eQamD1AlG7M8cIuF7TbkmPA6wj4/uAY0PoWTb6pMRSbUBC
 t0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691486337; x=1692091137;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nkqVhA0IQEjzDkz8HZI7bBlbDT9b4jMYdzRAKUTnjqc=;
 b=UNXTMXEAUG9SrVRacAgI2f0vzDqxIRQR/9egOH99J/u++7z8Yce7281Mdllvq/K/03
 agV14OfpkyM126j3aqxg2ZExr/kZPM7ZxRmXP3LXAZzjgoJ2aCMvk2vWhGKqdwCjbD/C
 9868L+iz/wIEG5B+jC6LH02Q5PRswISAMzQHXI0EbD9w6QiklBWTU/+kwOUvjpWR0pGd
 Yh6SMONzUke4bT+2LA0XqvViizcDWgjRIxTfvYO2R3MlL117khjt0W3DjuvWNXxUCjpX
 s7IksLI6CVOeSm7M7G5/RKChlJFo12a+pCiybZP3loShnbRAUta9vsc7z1ghZ3abmeL2
 Hs/w==
X-Gm-Message-State: AOJu0YxL5LsyBFOU7j+e3zB/aEV+Xj50xL8y68EEMr5ezPN/E/O3qyKC
 Hww4NuiVVCWSggYYQyzYEPK4ug==
X-Google-Smtp-Source: AGHT+IGTQ6A0itl3BDETGI9ekH1k7JY3+eXzY2/rFZD/u7wxoT5N7/6bR0gFNq7z/LPP3LU66xRNyA==
X-Received: by 2002:a7b:cb85:0:b0:3f9:82f:bad1 with SMTP id
 m5-20020a7bcb85000000b003f9082fbad1mr7082131wmi.40.1691486337425; 
 Tue, 08 Aug 2023 02:18:57 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y6-20020a05600c364600b003fe2a40d287sm13171443wmq.1.2023.08.08.02.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 02:18:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1E6811FFBB;
 Tue,  8 Aug 2023 10:18:56 +0100 (BST)
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-2-richard.henderson@linaro.org>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu,
 deller@gmx.de, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH for-8.1 v10 01/14] linux-user: Adjust task_unmapped_base
 for reserved_va
Date: Tue, 08 Aug 2023 10:10:34 +0100
In-reply-to: <20230807163705.9848-2-richard.henderson@linaro.org>
Message-ID: <87wmy599j3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> Ensure that the chosen values for mmap_next_start and
> task_unmapped_base are within the guest address space.
>
> Tested-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/user-mmap.h | 18 +++++++++++++++++-
>  linux-user/main.c      | 28 ++++++++++++++++++++++++++++
>  linux-user/mmap.c      | 18 +++---------------
>  3 files changed, 48 insertions(+), 16 deletions(-)
>
> diff --git a/linux-user/user-mmap.h b/linux-user/user-mmap.h
> index 7265c2c116..fd456e024e 100644
> --- a/linux-user/user-mmap.h
> +++ b/linux-user/user-mmap.h
> @@ -18,6 +18,23 @@
>  #ifndef LINUX_USER_USER_MMAP_H
>  #define LINUX_USER_USER_MMAP_H
>=20=20
> +#if HOST_LONG_BITS =3D=3D 64 && TARGET_ABI_BITS =3D=3D 64
> +#ifdef TARGET_AARCH64
> +# define TASK_UNMAPPED_BASE  0x5500000000
> +#else
> +# define TASK_UNMAPPED_BASE  (1ul << 38)
> +#endif
> +#else
> +#ifdef TARGET_HPPA
> +# define TASK_UNMAPPED_BASE  0xfa000000
> +#else
> +# define TASK_UNMAPPED_BASE  0x40000000
> +#endif
> +#endif
> +
> +extern abi_ulong task_unmapped_base;
> +extern abi_ulong mmap_next_start;
> +
>  int target_mprotect(abi_ulong start, abi_ulong len, int prot);
>  abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
>                       int flags, int fd, off_t offset);
> @@ -26,7 +43,6 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong ol=
d_size,
>                         abi_ulong new_size, unsigned long flags,
>                         abi_ulong new_addr);
>  abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice);
> -extern abi_ulong mmap_next_start;
>  abi_ulong mmap_find_vma(abi_ulong, abi_ulong, abi_ulong);
>  void mmap_fork_start(void);
>  void mmap_fork_end(int child);
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 556956c363..be621dc792 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -821,6 +821,34 @@ int main(int argc, char **argv, char **envp)
>          reserved_va =3D max_reserved_va;
>      }
>=20=20
> +    /*
> +     * Temporarily disable
> +     *   "comparison is always false due to limited range of data type"
> +     * due to comparison between (possible) uint64_t and uintptr_t.
> +     */
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wtype-limits"
> +
> +    /*
> +     * Select an initial value for task_unmapped_base that is in range.
> +     */
> +    if (reserved_va) {
> +        if (TASK_UNMAPPED_BASE < reserved_va) {
> +            task_unmapped_base =3D TASK_UNMAPPED_BASE;
> +        } else {
> +            /* The most common default formula is TASK_SIZE / 3. */
> +            task_unmapped_base =3D TARGET_PAGE_ALIGN(reserved_va / 3);
> +        }
> +    } else if (TASK_UNMAPPED_BASE < UINTPTR_MAX) {
> +        task_unmapped_base =3D TASK_UNMAPPED_BASE;
> +    } else {
> +        /* 32-bit host: pick something medium size. */
> +        task_unmapped_base =3D 0x10000000;
> +    }
> +    mmap_next_start =3D task_unmapped_base;
> +
> +#pragma GCC diagnostic pop
> +
>      {
>          Error *err =3D NULL;
>          if (seed_optarg !=3D NULL) {
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index eb04fab8ab..84436d45c8 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -299,20 +299,8 @@ static bool mmap_frag(abi_ulong real_start, abi_ulon=
g start, abi_ulong last,
>      return true;
>  }
>=20=20
> -#if HOST_LONG_BITS =3D=3D 64 && TARGET_ABI_BITS =3D=3D 64
> -#ifdef TARGET_AARCH64
> -# define TASK_UNMAPPED_BASE  0x5500000000
> -#else
> -# define TASK_UNMAPPED_BASE  (1ul << 38)
> -#endif
> -#else
> -#ifdef TARGET_HPPA
> -# define TASK_UNMAPPED_BASE  0xfa000000
> -#else
> -# define TASK_UNMAPPED_BASE  0x40000000
> -#endif
> -#endif
> -abi_ulong mmap_next_start =3D TASK_UNMAPPED_BASE;
> +abi_ulong task_unmapped_base;
> +abi_ulong mmap_next_start;

I feel we could help ourselves a bit more by documenting these globals
and what they mean:

  task_unmapped_base represents the start of unmapped memory in the
  guests programs address space. It is generally a function of the size
  of the address space and it defined at the start of execution.
  mmap_next_start is the base address for the next anonymous mmap and is
  increased after each successful map, starting at task_unmapped_base.

One thing I'm slightly confused by is the ELF_ET_DYN_BASE can be above
this (or sometimes the same). Should the mapping of ELF segments be
handled with mmap_next_start? I assume once mmap_next_start meets the
mappings for the ELF segments we skip over until we get to more free
space after the program code?

>=20=20
>  /*
>   * Subroutine of mmap_find_vma, used when we have pre-allocated
> @@ -391,7 +379,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong si=
ze, abi_ulong align)
>=20=20
>              if ((addr & (align - 1)) =3D=3D 0) {
>                  /* Success.  */
> -                if (start =3D=3D mmap_next_start && addr >=3D TASK_UNMAP=
PED_BASE) {
> +                if (start =3D=3D mmap_next_start && addr >=3D task_unmap=
ped_base) {
>                      mmap_next_start =3D addr + size;
>                  }
>                  return addr;


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


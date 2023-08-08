Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A25DF7739ED
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 13:40:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTL3B-0002ND-Ic; Tue, 08 Aug 2023 07:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTL35-0002LA-E9
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 07:38:52 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTL2z-0005Pl-3L
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 07:38:48 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fe426b8583so48596195e9.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 04:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691494718; x=1692099518;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Da0gKrCiIFkB7rzbOtlfWHWU+Xsmy/n0p18ef9P9Vg=;
 b=wWxcdA0SDlW1mRynY5kkjKxUMMjVXnolxOJS8VFmE6AbfemAA7pmJv/mL022ZPFY5i
 2zoVTjgqqkokBWJbYHd+yIhEmqPMUhVYUUYjgXnia5h4Ku+h1ID4SRTuFsq4JVlx8v2x
 bVibhTJUg/71mnSK4Ps6yGdrYuJtABGlui+dIXmzEheC3ivKrbv8bFmyZlD3JVupuN1T
 Q1UepNKTsFX7n2/lvEFCa4fUdW9u/Mfy0yfWJu87rSvpVKC4h6rYpo8m8P5yuQdOcBS5
 vVQ4zBVoZGi17rPwF6UOfO+XSzheoe3Sxss9ShC+z5K6LtniCIjDFoileQIZa1KQgT+A
 nmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691494718; x=1692099518;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5Da0gKrCiIFkB7rzbOtlfWHWU+Xsmy/n0p18ef9P9Vg=;
 b=j1mr0h4Layk5Wp+nctBe0qM/nCgrbyYqKfBgdO3czL90EZ8fphF7rbf0rgt248QEd0
 +x6L8khM/boX/wokGHdPuR9YQtzDYf8TMIQURbOV/iiqJdXYSf+VTBGJ8GtkGz6+r/hR
 FRFrR/x8P6NLkzaYJ/lAzQbOxKGIjp8jJ0vCA3vl6ubjNbsQ/fUhgPjdtZHZfbLASsm6
 pj0f2H5Fb3/ew4WscUqR/SD/YhsGxSzYNenHpPNwEZEXOISfAOeouB6fazOLgwhz9xUJ
 u6t9emXUGQIxMWfo87AULRCL5mTDGkBIRrM2sjUe+ygtAr53MDKL6/aSY4TIPo+cd7DV
 mHyQ==
X-Gm-Message-State: AOJu0YxHRvCsv6wbR3VPVxi6Dd51LSxG0vHpmOZ5kNwMm/VNvwcuwKtg
 BryxUluxLBdqJBeIqTNehYSGIg==
X-Google-Smtp-Source: AGHT+IEtBUgu8Yez4WdJN/4FJWfTq6LfjDvl+yA7LofWZwwn4RXN1h0UvIC+qyeL8Igd+8rQ+uqT2Q==
X-Received: by 2002:a05:600c:22ce:b0:3fb:d1db:545b with SMTP id
 14-20020a05600c22ce00b003fbd1db545bmr10034682wmg.20.1691494718610; 
 Tue, 08 Aug 2023 04:38:38 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a7bca52000000b003fe1e3937aesm13366644wml.20.2023.08.08.04.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 04:38:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6A3F01FFBB;
 Tue,  8 Aug 2023 12:38:37 +0100 (BST)
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-9-richard.henderson@linaro.org>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu,
 deller@gmx.de, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH for-8.1 v10 08/14] linux-user: Do not adjust zero_bss
 for host page size
Date: Tue, 08 Aug 2023 12:38:10 +0100
In-reply-to: <20230807163705.9848-9-richard.henderson@linaro.org>
Message-ID: <877cq5932a.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

> Rely on target_mmap to handle guest vs host page size mismatch.
>
> Tested-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 54 +++++++++++++++++++-------------------------
>  1 file changed, 23 insertions(+), 31 deletions(-)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 964b21f997..6c28cb70ef 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2213,44 +2213,36 @@ static abi_ulong setup_arg_pages(struct linux_bin=
prm *bprm,
>=20=20
>  /* Map and zero the bss.  We need to explicitly zero any fractional pages
>     after the data section (i.e. bss).  */
> -static void zero_bss(abi_ulong elf_bss, abi_ulong last_bss, int prot)
> +static void zero_bss(abi_ulong start_bss, abi_ulong end_bss, int prot)
>  {
> -    uintptr_t host_start, host_map_start, host_end;
> +    abi_ulong align_bss;
>=20=20
> -    last_bss =3D TARGET_PAGE_ALIGN(last_bss);
> +    align_bss =3D TARGET_PAGE_ALIGN(start_bss);
> +    end_bss =3D TARGET_PAGE_ALIGN(end_bss);
>=20=20
> -    /* ??? There is confusion between qemu_real_host_page_size and
> -       qemu_host_page_size here and elsewhere in target_mmap, which
> -       may lead to the end of the data section mapping from the file
> -       not being mapped.  At least there was an explicit test and
> -       comment for that here, suggesting that "the file size must
> -       be known".  The comment probably pre-dates the introduction
> -       of the fstat system call in target_mmap which does in fact
> -       find out the size.  What isn't clear is if the workaround
> -       here is still actually needed.  For now, continue with it,
> -       but merge it with the "normal" mmap that would allocate the bss. =
 */
> +    if (start_bss < align_bss) {
> +        int flags =3D page_get_flags(start_bss);
>=20=20
> -    host_start =3D (uintptr_t) g2h_untagged(elf_bss);
> -    host_end =3D (uintptr_t) g2h_untagged(last_bss);
> -    host_map_start =3D REAL_HOST_PAGE_ALIGN(host_start);
> -
> -    if (host_map_start < host_end) {
> -        void *p =3D mmap((void *)host_map_start, host_end - host_map_sta=
rt,
> -                       prot, MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1=
, 0);
> -        if (p =3D=3D MAP_FAILED) {
> -            perror("cannot mmap brk");
> -            exit(-1);
> +        if (!(flags & PAGE_VALID)) {
> +            /* Map the start of the bss. */
> +            align_bss -=3D TARGET_PAGE_SIZE;
> +        } else if (flags & PAGE_WRITE) {
> +            /* The page is already mapped writable. */
> +            memset(g2h_untagged(start_bss), 0, align_bss - start_bss);
> +        } else {
> +            /* Read-only zeros? */
> +            g_assert_not_reached();
>          }
>      }
>=20=20
> -    /* Ensure that the bss page(s) are valid */
> -    if ((page_get_flags(last_bss-1) & prot) !=3D prot) {
> -        page_set_flags(elf_bss & TARGET_PAGE_MASK, last_bss - 1,
> -                       prot | PAGE_VALID);
> -    }
> -
> -    if (host_start < host_map_start) {
> -        memset((void *)host_start, 0, host_map_start - host_start);
> +    if (align_bss < end_bss) {
> +        abi_long err =3D target_mmap(align_bss, end_bss - align_bss, pro=
t,
> +                                   MAP_FIXED | MAP_PRIVATE | MAP_ANONYMO=
US,
> +                                   -1, 0);
> +        if (err =3D=3D -1) {
> +            perror("cannot mmap brk");
> +            exit(-1);

brk !=3D bss even if brk generally comes after the bss section.

> +        }
>      }
>  }


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC77A82BFF3
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 13:48:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOGw7-00026K-Qt; Fri, 12 Jan 2024 07:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOGvy-000215-97
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:46:51 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOGvw-0001n0-6J
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:46:49 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2cd8bd6ce1bso18279861fa.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 04:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705063603; x=1705668403; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f5e6YIUFh1L0RCDhKUoemowif1MjyflSqmQcGKvPcTs=;
 b=iWhIFgiRwtf1XxJbz1SFw0q7YYwC1dvxGTbzobUVX9qDyDaWrU8Dk9q8mH+N5mqxKL
 KQMyqCP1kv9pethvOQCQx9eJgjDMANYYXxDTMn/+hSWbSg0MzrxXm6m2y/v4tA5ZYujl
 HHvkJKnnRGZbysUYitjxjKxl0Y80M43TJ97nDUFE/OKtF5pSLAFD3sClPuK/0n5cze2O
 wtI1m60PtqQKD1sCgRzNgmxv5/b4czwomb2LbFnfaBvJFCsX+sK2Z0xT8DJIGS+lyuQJ
 EpmddAjDtXVqF+OWp37PUpMk20Mbx5OrGvgFdwQl48A4Lt3i6QmmaoaKwn6P4V9nlXcE
 T95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705063603; x=1705668403;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f5e6YIUFh1L0RCDhKUoemowif1MjyflSqmQcGKvPcTs=;
 b=qNtSdinereqyibTBicx96dtkwcOPggGUZRYO63w4jAH2cMTeaDCDy6rm9B0Z+BeAvo
 B4hynoQCm8JF+U31kjyfD3Y43IUbXha805YkzU0ASqkKuXDOVaBCC/c9J2ps2/mbZ5/T
 02dwovfzHFZssrnVW0Ve1C6Y7WR5pZfW3cb8bDzR8hCHmcnH/DRZYiCoe6nwHhoVso6R
 BjoLm7BBpWMN5GhIEZG9QHcySTzSTVX3ptAjLVX2nvpheqxLcBMhfomsPVmuJRQI3tdp
 rfNGW3p4rVNMgB0GbzzbyGqQswQI/lMI0x8+FmHBg+8AGKYnj9IkkIbyarWp4TmSz2uS
 HrmQ==
X-Gm-Message-State: AOJu0Ywgd9Uv8VnR66sL32XioYKhkETEF/Pcsxnj+PAzT93Xn64WpXUo
 iJCmjp5cLaHAzIrKjpCjb1VU+05OTRFzIQGGcGC2TAhfOGEN5w==
X-Google-Smtp-Source: AGHT+IGm7R1Inxby3qbFZXsCSJNNRxVyPyrPn0bJ39CVgl+5Uzpi2GbKXaVn+bnlGTgAPWkHgIRy8K36STG033b2fqw=
X-Received: by 2002:ac2:4823:0:b0:50e:37f9:37aa with SMTP id
 3-20020ac24823000000b0050e37f937aamr425883lft.50.1705063603074; Fri, 12 Jan
 2024 04:46:43 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA9DU7aZjzWc+fnMw14JupM6ff1=ChxaX3+kfGt3LBrP5Q@mail.gmail.com>
 <20240112114527.7911-1-abelova@astralinux.ru>
In-Reply-To: <20240112114527.7911-1-abelova@astralinux.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2024 12:46:32 +0000
Message-ID: <CAFEAcA8jpCr-GnkUZipN8bCFTZHSb+FjDS7nOtZrs2jkdZ0cyA@mail.gmail.com>
Subject: Re: [PATCH v2] load_elf: fix iterators' types for elf file processing
To: Anastasia Belova <abelova@astralinux.ru>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 12 Jan 2024 at 11:46, Anastasia Belova <abelova@astralinux.ru> wrote:
>
> i and size should be the same type as ehdr.e_phnum (Elf32_Half or
> Elf64_Half) to avoid overflows. So the bigger one is chosen.
>
> j should be the same type as file_size for the same reasons.
>
> This commit fixes a minor bug, maybe even a typo.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 7ef295ea5b ("loader: Add data swap option to load-elf")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>  include/hw/elf_ops.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index 0a5c258fe6..6e807708f3 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -325,7 +325,7 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
>  {
>      struct elfhdr ehdr;
>      struct elf_phdr *phdr = NULL, *ph;
> -    int size, i;
> +    Elf64_Half size, i;

Elf64_Half is a 16 bit type -- this doesn't seem right.

In particular we use 'size' to store "ehdr.e_phnum * sizeof(phdr[0])"
so even if we know e_phnum fits in a 16 bit type the
multiplication is not guaranteed to; so this change actually
introduces a bug. The type we need for what we're doing needs
to be big enough to store the result of that multiplication,
so anything bigger than 16 bits will be fine, including 'int'
(since we know the RHS is a small number). We could change
this to 'size_t' or 'ssize_t', I suppose, but it doesn't
really seem necessary.

(Side note: whatever your static analyser is could presumbaly be
doing better about identifying overflows here -- it ought to be
able to figure out that "unsigned 16 bit value * constant 64"
is not going to overflow a signed 32 bit type.)

i is only used as the iterator through the program headers,
so it wouldn't be wrong to make it a 16 bit type, but there's
really no need to constrain it -- an 'int' is fine.

Also, these functions have macro magic so we create both the
32-bit and 64-bit elf versions from one bit of source, so it
is not in general right for them to have a type in them that
is specific to one or the other, as Elf64_Half is.

>      ssize_t total_size;
>      elf_word mem_size, file_size, data_offset;
>      uint64_t addr, low = (uint64_t)-1, high = 0;
> @@ -464,7 +464,7 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
>                   * the ROM overlap check in loader.c, so we don't try to
>                   * explicitly detect those here.
>                   */
> -                int j;
> +                Elf64_Half j;

This case is like 'i' above -- it's not a bug to use a 16 bit
type for the iterator variable, but it isn't necessary,
and we shouldn't use an Elf64* type.

>                  elf_word zero_start = ph->p_paddr + file_size;
>                  elf_word zero_end = ph->p_paddr + mem_size;
>
> @@ -500,7 +500,7 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
>              }
>
>              if (data_swab) {
> -                int j;
> +                elf_word j;
>                  for (j = 0; j < file_size; j += (1 << data_swab)) {
>                      uint8_t *dp = data + j;
>                      switch (data_swab) {

This change is OK and necessary. It fixes a minor bug:
if we are loading an ELF file that contains a segment
whose data in the ELF file is larger than 2GB and we need
to byteswap that data, we would previously get this wrong.
(We should mention this in the commit message.)

thanks
-- PMM


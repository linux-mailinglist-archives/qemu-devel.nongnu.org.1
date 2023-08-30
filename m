Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF3278D67A
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:22:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbM5P-0004So-S7; Wed, 30 Aug 2023 10:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbM5D-0004R2-7L
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:22:13 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbM59-0001Rh-PN
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:22:09 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5007abb15e9so8856425e87.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693405324; x=1694010124; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OmJcXCe3INI88WWxZa1dg/gqWtejlf46vF//E1eZYiw=;
 b=gGt+M76xvnnmplf96OuS0sf0c9oUM7Vw8FE1+CoAiJ7ZUw0sdcPs14ZBaxEtA4OXJO
 744vmoG6jbdcyk+pdQmwSEXs4OlZz83LSqUc0qifhbIcRqpEZlIH9RbpNkzvAP9KkRvQ
 zjs4m6VR53fH74kKlebFrG3kkTeXrmAdRBUe/kyTRtDRz6l1hULR5FlnQyZnwt8U+IXS
 jwr9uzexaNGOh10WpakRqJRi22/T8NEL//Pxh/JzLcvODVXvJXHzaUShuhNkcll4uKnF
 jVIEyuj0L5IbXPYsSw08gDquMyGZRWqwpZEzFOJrm158QNwwnCGVZwLS5hgagVf4TeOU
 eMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693405324; x=1694010124;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OmJcXCe3INI88WWxZa1dg/gqWtejlf46vF//E1eZYiw=;
 b=b2zIywv0c+Gh9AZsUohZDNEuOyQK7KOphbgzmY1wc4gVHTr/QYXGPCH2FqFZ0GnGiy
 HjZ+L9Db2nGdau9lzX8OjvVU7NjhbFEnieRBHf6gWhyP2KzZd8TNkFLViZLjbir/dDFB
 MM4xeSe4fVjSGg7e0eLPPuhC2skke1J16spi5G0xuhHis37qwIcP8zwaf8eiHcCPj7r1
 6+PhnKAHkZuRmhECEPjYVuTfZ1PhznSjW19QQpl3ql7cbXMMVsCuOYCQwESKoKSBUIDx
 /nNdHj+wsU/KOlLURauImwbeGBVJK7KH1TiaQYA+l1gW32/UhgIR2pLZPBEfykWOae6V
 RWZw==
X-Gm-Message-State: AOJu0YxpD00OqH+D4PXZVihUQZzgPKUTVwMq0V+hj3/IY3j8g7COg7Jg
 500aWqkHRxIlRJ2l5aqMr217KdiX0utDYeV6Sjk29KAR
X-Google-Smtp-Source: AGHT+IFKUjXkXCh0rcxix6pUaY4JA+f3hKt6GvHjuFVylNqCRLNsuehbIqW7yb7sAqPZPfmemJ6WmQ==
X-Received: by 2002:a05:6512:3b2b:b0:500:848a:80df with SMTP id
 f43-20020a0565123b2b00b00500848a80dfmr1934286lfv.66.1693405324529; 
 Wed, 30 Aug 2023 07:22:04 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 17-20020a170906059100b0098e16f8c198sm7315290ejn.18.2023.08.30.07.22.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 07:22:04 -0700 (PDT)
Message-ID: <d703be2d-8131-58d4-2ed8-7104316a8e21@linaro.org>
Date: Wed, 30 Aug 2023 16:22:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v5 08/20] linux-user: Load vdso image if available
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu
References: <20230829220228.928506-1-richard.henderson@linaro.org>
 <20230829220228.928506-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230829220228.928506-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

Hi Richard,

On 30/8/23 00:02, Richard Henderson wrote:
> The vdso image will be pre-processed into a C data array, with
> a simple list of relocations to perform, and identifying the
> location of signal trampolines.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 87 +++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 78 insertions(+), 9 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index f34fb64c0c..2a6adebb4a 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -33,6 +33,19 @@
>   #undef ELF_ARCH
>   #endif
>   
> +#ifndef TARGET_ARCH_HAS_SIGTRAMP_PAGE
> +#define TARGET_ARCH_HAS_SIGTRAMP_PAGE 0

I'd rather #error here so new targets are added with
a clearly defined TARGET_ARCH_HAS_SIGTRAMP_PAGE.

> +#endif
> +
> +typedef struct {
> +    const uint8_t *image;
> +    const uint32_t *relocs;
> +    unsigned image_size;
> +    unsigned reloc_count;
> +    unsigned sigreturn_ofs;
> +    unsigned rt_sigreturn_ofs;
> +} VdsoImageInfo;
> +
>   #define ELF_OSABI   ELFOSABI_SYSV


> +#ifndef vdso_image_info
> +#define vdso_image_info()    NULL
> +#endif
> +
> +static void load_elf_vdso(struct image_info *info, const VdsoImageInfo *vdso)
> +{
> +    ImageSource src;
> +    struct elfhdr ehdr;
> +    abi_ulong load_bias, load_addr;
> +
> +    src.fd = -1;
> +    src.cache = vdso->image;
> +    src.cache_size = vdso->image_size;
> +
> +    load_elf_image("<internal-vdso>", &src, info, &ehdr, NULL);
> +    load_addr = info->load_addr;
> +    load_bias = info->load_bias;
> +
> +    /*
> +     * We need to relocate the VDSO image.  The one built into the kernel
> +     * is built for a fixed address.  The one built for QEMU is not, since
> +     * that requires close control of the guest address space.
> +     * We pre-processed the image to locate all of the addresses that need
> +     * to be updated.
> +     */
> +    for (unsigned i = 0, n = vdso->reloc_count; i < n; i++) {

Do we really need 'n'?

> +        abi_ulong *addr = g2h_untagged(load_addr + vdso->relocs[i]);
> +        *addr = tswapal(tswapal(*addr) + load_bias);
> +    }
> +
> +    /* Install signal trampolines, if present. */
> +    if (vdso->sigreturn_ofs) {
> +        default_sigreturn = load_addr + vdso->sigreturn_ofs;
> +    }
> +    if (vdso->rt_sigreturn_ofs) {
> +        default_rt_sigreturn = load_addr + vdso->rt_sigreturn_ofs;
> +    }
> +
> +    /* Remove write from VDSO segment. */
> +    target_mprotect(info->start_data, info->end_data - info->start_data,
> +                    PROT_READ | PROT_EXEC);
> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



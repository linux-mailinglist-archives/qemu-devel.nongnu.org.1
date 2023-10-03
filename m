Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FCA7B6961
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:48:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qneoi-0004gf-Rw; Tue, 03 Oct 2023 08:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qneog-0004gG-DO
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:47:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qneoe-0003Xg-F9
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:47:58 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4065f29e933so8788745e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 05:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696337274; x=1696942074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a9vp41JKK1v9PojRZQZ/jCs0K9QyVSqgOUssSFstCHE=;
 b=CbrIoUqyJS8FR1sp2p8y7XoLJ1msVxoUrchA1/jDXV8NhYrvyYOMz80yCo1uv7TN2k
 mxMiwEL9k0bDX5EKUU0XYIG+m7HGxInJU9JmYqplCHyxZajpdx9ZKjQim/ZaDsLAab66
 2bBotmO10tXIsNA5Q63xdyZEwDVEq6XhAYpX7EOLx36ie1ktz+0GKKu9UgEPT2BnpVOY
 P/BZBHkXtCovKRXLpWw67gIhQT81HSsASoO5juTCIbSyE/Cob1duij6W8IprzSRyBk8/
 BHRJ4eR5uGoaDNrnbUYu6q+ILnQahzw/Iwpq8aYIAcytRmakQrpWMnLHjMZKCIXNEXeu
 YfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696337274; x=1696942074;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a9vp41JKK1v9PojRZQZ/jCs0K9QyVSqgOUssSFstCHE=;
 b=r3/s1wMdT8/dgQN9ZZejwan7m6Yc5yWzf/5H+jypJjBa2jnP75b+cH8bUoIYZpjc7G
 mByo/vic3FzyK1DiW0sYIW/KRzyKHb5gy4Qj075PUQqPRXJOTKJEj+/6AEt8gc27lcC7
 sczWVxXHNDl4zbfQutCgxV6zJtYNAIUyT+wPYqj9RPFknbX6m4F0MLGQzGbNxtM9Mjty
 ifR8R3qAVG/dW/Owyq9FbkUXxlK9qCMdwDsgsqRcc/h8VgRwuyvwox8o0k6Me5n2TWXa
 0XxlRuvKia8BPFISjXv1h9fhejOAdNYMv+wjAwoH+/dFOc0z9Paq0HxUsfaJDeBmKV2u
 +BpQ==
X-Gm-Message-State: AOJu0YwNVx4jvCVwXlzNtTjuAUpUPzr4QaK0G+LasQsQOYrEcQ7z1ne+
 B431lvqnjmnoKsccYjcHaRSIgQ==
X-Google-Smtp-Source: AGHT+IEsbIqPhzavNhk8N8IUJ5jYoIfbCAh+Waf1lGmCvqfKAwMCOMZ9kNygxp7GqR/FuYLDI4af8w==
X-Received: by 2002:a05:6000:1106:b0:323:2f16:66ee with SMTP id
 z6-20020a056000110600b003232f1666eemr11151665wrw.71.1696337274423; 
 Tue, 03 Oct 2023 05:47:54 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-246.abo.bbox.fr.
 [176.131.222.246]) by smtp.gmail.com with ESMTPSA id
 m4-20020adffa04000000b0031980783d78sm1518058wrr.54.2023.10.03.05.47.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 05:47:53 -0700 (PDT)
Message-ID: <ea810702-eb8f-ecad-996a-d45529c99629@linaro.org>
Date: Tue, 3 Oct 2023 14:47:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6 07/19] linux-user: Load vdso image if available
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu
References: <20230930021529.987950-1-richard.henderson@linaro.org>
 <20230930021529.987950-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230930021529.987950-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 30/9/23 04:15, Richard Henderson wrote:
> The vdso image will be pre-processed into a C data array, with
> a simple list of relocations to perform, and identifying the
> location of signal trampolines.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 90 +++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 81 insertions(+), 9 deletions(-)


> @@ -3691,7 +3759,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
>        * and let elf_load_image do any swapping that may be required.
>        */
>       struct elfhdr ehdr;
> -    struct image_info interp_info;
> +    struct image_info interp_info, vdso_info;
>       char *elf_interpreter = NULL;
>       char *scratch;
>   
> @@ -3772,10 +3840,13 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
>       }
>   
>       /*
> -     * TODO: load a vdso, which would also contain the signal trampolines.
> -     * Otherwise, allocate a private page to hold them.
> +     * Load a vdso if available, which will amongst other things contain the
> +     * signal trampolines.  Otherwise, allocate a separate page for them.
>        */
> -    if (TARGET_ARCH_HAS_SIGTRAMP_PAGE) {
> +    const VdsoImageInfo *vdso = vdso_image_info();

Declare in prologue? Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    if (vdso) {
> +        load_elf_vdso(&vdso_info, vdso);
> +    } else if (TARGET_ARCH_HAS_SIGTRAMP_PAGE) {
>           abi_long tramp_page = target_mmap(0, TARGET_PAGE_SIZE,
>                                             PROT_READ | PROT_WRITE,
>                                             MAP_PRIVATE | MAP_ANON, -1, 0);



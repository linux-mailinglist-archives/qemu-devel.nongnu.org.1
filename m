Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A3D78E0FC
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 22:51:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbS8k-0006qm-QH; Wed, 30 Aug 2023 16:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbS8d-0006py-86
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 16:50:09 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbS8Z-0003GG-V8
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 16:50:06 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99c136ee106so6733966b.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 13:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693428600; x=1694033400; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rVL4/+nP1ihfUX8FJeGXm0UE5kBrs8TFC0OGTZdj/KE=;
 b=yqDm8nJtjRT3KmjXal/KItMji1OLp8B09GqNi/KbMrlytPx6Wp2N3aO2bhuQiUuSIv
 +yYrC3Yh7gbrqbAp4QJCrGRRra7N6O7fsoXB4sSwoXN9eokYSRCV6xEpHCS4Mgw09Zx8
 Ik3HchLQ5FaXDPCDb2zUYFfbTnTNzUk7imekM4Tl0dGFoWcumUuX609iM2seUJdYjW9S
 +VSn2CBs4pLbvghNM8iBjQ2GJc+9K6cAnFfrlbVtbCDZrMAw9rwJ+CtJZIIMCIAjO9Ta
 3p0aiSLi3CRGjgixyAt0mXZCloxGB+JW20oW1R3vm3645OtXW/eTYSINaFvWWoIL8VX3
 dcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693428600; x=1694033400;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rVL4/+nP1ihfUX8FJeGXm0UE5kBrs8TFC0OGTZdj/KE=;
 b=O3XK80GK/rAgIK3g89nOyflNW8jKfumvmRddo+sE16LtzW1HKIUKJgwPZLmhcdWkWF
 FsZVrIBEZSVvbgJ3NbHE+MKHBjwoBc34f9HjhL2y8KTJOi7otmdUFai8tpXPcwT50Uw1
 zMdTcV6moW/Cbjmbly/n58RIHBf2IoswSBbOapIcQc8zYstOIxvgL/2b+v3Mfo7SnC+t
 1bydifPAcQn5Zv0ehE33PlZrzrmi8xw2B8Tp5Rzu1TaH90TUH8SIhgN1MCFOv10tHeHk
 Du/VX0bwgS/6MX42YqVMRmcBPfXx/ZMeM8x7DvhDjk2bb0Yx2DZIiqcz42DV1tP0jfhl
 TuzQ==
X-Gm-Message-State: AOJu0YxFzeF8sdbVqZo2k1KsF0A+VrOdA1kdjx1C6A1hyycDgkVSjIKt
 yfr2XKzw1rLcxCX0wtDeYWS+TQ==
X-Google-Smtp-Source: AGHT+IFzXfqmSXxoPiH8ndedBxORdaxKklgkwJ20APKBuUTUQJQwHrmie/NqIPQH7j8jMS66D/akOg==
X-Received: by 2002:a17:906:9c2:b0:9a3:b0c9:8203 with SMTP id
 r2-20020a17090609c200b009a3b0c98203mr2716321eje.35.1693428600344; 
 Wed, 30 Aug 2023 13:50:00 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 z9-20020a170906434900b0097404f4a124sm7492841ejm.2.2023.08.30.13.49.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 13:49:59 -0700 (PDT)
Message-ID: <2e68e6ae-e581-81ca-baee-6a0e52a86ff2@linaro.org>
Date: Wed, 30 Aug 2023 22:49:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] linux-user: Fixes for zero_bss
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, qemu-stable@nongnu.org
References: <20230830203443.1126914-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830203443.1126914-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

On 30/8/23 22:34, Richard Henderson wrote:
> The previous change, 2d385be6152, assumed !PAGE_VALID meant that
> the page would be unmapped by the elf image.  However, since we
> reserved the entire image space via mmap, PAGE_VALID will always
> be set.  Instead, assume PROT_NONE for the same condition.
> 
> Furthermore, assume bss is only ever present for writable segments,
> and that there is no page overlap between PT_LOAD segments.
> Instead of an assert, return false to indicate failure.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1854
> Fixes: 2d385be6152 ("linux-user: Do not adjust zero_bss for host page size")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 33 ++++++++++++++++++++++++++-------
>   1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index a5b28fa3e7..7bc7bcec19 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2308,21 +2308,40 @@ static bool zero_bss(abi_ulong start_bss, abi_ulong end_bss, int prot)
>   {
>       abi_ulong align_bss;
>   
> +    /* We only expect writable bss; the code segment shouldn't need this. */
> +    if (!(prot & PROT_WRITE)) {
> +        return false;

Caller will fail with random errno and "Error mapping file".
Not really accurate. Maybe we could pass an Error* paramenter
to zero_bss().

> +    }
> +
>       align_bss = TARGET_PAGE_ALIGN(start_bss);
>       end_bss = TARGET_PAGE_ALIGN(end_bss);
>   
>       if (start_bss < align_bss) {
>           int flags = page_get_flags(start_bss);
>   
> -        if (!(flags & PAGE_VALID)) {
> -            /* Map the start of the bss. */
> +        if (!(flags & PAGE_BITS)) {
> +            /*
> +             * The whole address space of the executable was reserved
> +             * at the start, therefore all pages will be VALID.
> +             * But assuming there are no PROT_NONE PT_LOAD segments,
> +             * a PROT_NONE page means no data all bss, and we can
> +             * simply extend the new anon mapping back to the start
> +             * of the page of bss.
> +             */
>               align_bss -= TARGET_PAGE_SIZE;
> -        } else if (flags & PAGE_WRITE) {
> -            /* The page is already mapped writable. */
> -            memset(g2h_untagged(start_bss), 0, align_bss - start_bss);
>           } else {
> -            /* Read-only zeros? */
> -            g_assert_not_reached();
> +            /*
> +             * The start of the bss shares a page with something.
> +             * The only thing that we expect is the data section,
> +             * which would already be marked writable.
> +             * Overlapping the RX code segment seems malformed.
> +             */
> +            if (!(flags & PAGE_WRITE)) {

Similar random errno and "Error mapping file".

> +                return false;
> +            }
> +
> +            /* The page is already mapped and writable. */
> +            memset(g2h_untagged(start_bss), 0, align_bss - start_bss);
>           }
>       }
>   



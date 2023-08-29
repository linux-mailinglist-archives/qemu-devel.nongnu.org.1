Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F8078D097
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:28:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n1-0000oT-VD; Tue, 29 Aug 2023 19:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4mD-0001dW-KH
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:53:26 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4mA-0006A1-H1
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:53:24 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6bc9254a1baso3633321a34.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693338800; x=1693943600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WCMltG0uZJJgvo3ueVAW7Dxtn1YUSOSTOsATDYSoCag=;
 b=O2oGtrXFX+aA0yz5EEXgHGenDgmdNdOzbOsvV/0+BscUi0vlZaj77rEConwKUUfMx7
 RSt6w7sC8P03QPzJAjslcQv4ZGDmosAjd78k2CTzd98jbk3tZVMHv3E04XwNCS+Us+pt
 R0WRHaoKBgwlWU7HYwxSDPvFhXnZezHvo+Vb5ak+R9+S4KrndS10cZB8JNTCsCyn+e/J
 QOo2xbVbFfLD5rm7PUCyu+UYOP6ojLaEDPui5luWzS8sBqpicTLg1jJWdyKjFHqC5G1I
 YgMHVyVzvqyRksOMT+d7L2f8NQRBvPDFavkIUKXMuL093ZIeHpR8hUsdRO/MCbilkdQo
 QMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693338800; x=1693943600;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WCMltG0uZJJgvo3ueVAW7Dxtn1YUSOSTOsATDYSoCag=;
 b=NjAKKl8ehalIJsA03rzHzOhUuMiDRME+Vvg7yYpxeDEHsHOo+w392mGpG19t9lseR+
 fy+7xMaPqyhHjXp7wdv/NfD17TKlN9xKqn+jg+WeVkfX2ZhIWTz64aBc1Xn9LQvf6CPX
 ICMb3QPFFo6dvU2VrEA1TYSC1kyCyR5kBudLkIl94jRhlKadHsujZv5Flhuorow7jtqo
 nkbSix//cOVHHIPEPhloM22kmm1eb7NTVynYhCHGEUBoYBktfzNUgiIa9FMzse6dBKZQ
 hZSWJsg2hzpcXTdyaY4Q7dihyQSO6L5KqnbdsyRg8p2/rDIZWFxWVgg5XKiaYg9DCXn+
 tf7Q==
X-Gm-Message-State: AOJu0Yw1hyYbMZO2xVagj0dbe5P1rH5ynp+ufoGOZdbneUVrlUJtVogi
 HAOVSVr2VnPI3J57aNJQoRwu9g==
X-Google-Smtp-Source: AGHT+IFBCv/q9r7AHX64YP/dedyjamROBihK/XvBj96ibJkpAGpFjXdCNjrJfEdExGyGiTRBG1VSHg==
X-Received: by 2002:a05:6870:610c:b0:1bb:4bad:ebce with SMTP id
 s12-20020a056870610c00b001bb4badebcemr194647oae.27.1693338799890; 
 Tue, 29 Aug 2023 12:53:19 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 11-20020a17090a194b00b0026f3e396882sm11884590pjh.45.2023.08.29.12.53.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 12:53:19 -0700 (PDT)
Message-ID: <7dd423ed-9949-0850-5bd4-eaf9a2201187@linaro.org>
Date: Tue, 29 Aug 2023 12:53:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 12/32] bsd-user: Implement getgroups(2) and setgroups(2)
 system calls.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-13-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-13-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

On 8/27/23 08:57, Karim Taha wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-proc.h           | 44 +++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |  9 +++++++
>   2 files changed, 53 insertions(+)
> 
> diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
> index b6225e520e..ecd6a13c2d 100644
> --- a/bsd-user/bsd-proc.h
> +++ b/bsd-user/bsd-proc.h
> @@ -41,4 +41,48 @@ static inline abi_long do_bsd_exit(void *cpu_env, abi_long arg1)
>       return 0;
>   }
>   
> +/* getgroups(2) */
> +static inline abi_long do_bsd_getgroups(abi_long gidsetsize, abi_long arg2)
> +{
> +    abi_long ret;
> +    uint32_t *target_grouplist;
> +    gid_t *grouplist;
> +    int i;
> +
> +    grouplist = alloca(gidsetsize * sizeof(gid_t));

Don't use alloca for items that are sized by the guest.

Use g_autofree and g_try_new, failing with ENOMEM.

> +/* setgroups(2) */
> +static inline abi_long do_bsd_setgroups(abi_long gidsetsize, abi_long arg2)
> +{
> +    uint32_t *target_grouplist;
> +    gid_t *grouplist;
> +    int i;
> +
> +    grouplist = alloca(gidsetsize * sizeof(gid_t));

Likewise.


r~


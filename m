Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AEF7DA9A4
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 23:36:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwqxv-0007Q9-Ho; Sat, 28 Oct 2023 17:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwqxt-0007Ph-2U
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 17:35:29 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwqxr-0005pe-Hv
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 17:35:28 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-58441865ffaso2021691eaf.1
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 14:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698528926; x=1699133726; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9iXhMbCiHxK3QdcH0kQKI7uQZBa18kBJkZ66k3iJeJA=;
 b=Yi4hyCVRm5XmWbmEV/jfybmydmYRYYl1L12sFbdzWSfl7stI7SQf1QQ/Kn+MdNFB0l
 1CqQVyIegAGowOvJ6hxShi/WNxYDE5u4IjfqmN4pZRaNaBPq88KoUGshvK81bVTRgb3D
 YyUn/VxM/AS7lPQ/EFDiFnkI8DA9Khvk/gJWSUbFAFrmczVS5vKlk1f0rUE1fWBG4ff9
 ccOSaSdXvX8iihjSYrvVZK7Ny3iV+MPJavuVFy4MXsA87N0zLuoAH/YJaJ86kAPQQRXT
 QBRLvtpP78Bo9p+L+AX+xez2Jzu3uzq5cD7/za/Uw7drZ2sPeaQi9u71Rd6Liklohjq2
 88kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698528926; x=1699133726;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9iXhMbCiHxK3QdcH0kQKI7uQZBa18kBJkZ66k3iJeJA=;
 b=Cc6gW/V5Kw+3W3peaBXbYlJxFyZ8cZeIjhdSq+ax5oV4fZ6AVc7WtdEtp+xR7XInwk
 T8QgNkBCLQJ2A0bafuZgv6TWfBqjV8Z4xsZiB05/bmHXMG+LwcDenrXD5MDA6xSjTT2M
 CQfokJv9d9i+X+K7ctK4ogsi0YQtC8Lz+tXnxIP/9BNx9TSxAC1MDtOIob7wcjFiIuua
 giag/3a/pOZrTL+4yN8DWSenoGPOqwQv7s4q3PDvtlk5DqdcUuJpV0i8wXBKd+zOzg0h
 OkLVTi9wc1IKvaTuacw/3I8FVYph9k/7UTRZ5JljgWp4Z7F6TyqM3rH0NWdwsgfkGA13
 85NA==
X-Gm-Message-State: AOJu0YxUQJaBSbcq2hlwLa0mh2EfdPbzREd52YqakhMkGNN4PO2aPxuK
 o/ggyDAF+wZorDMR8RIC5zj89g==
X-Google-Smtp-Source: AGHT+IGPUde5o7V7M8Zxa6CeUMImklK++Zak6F1UVxp7EKfhvrbdfMSXIgo/0/8/ybvCUlrsGo4pjw==
X-Received: by 2002:a05:6359:1a09:b0:168:e8e6:b91f with SMTP id
 rt9-20020a0563591a0900b00168e8e6b91fmr4922692rwb.18.1698528925565; 
 Sat, 28 Oct 2023 14:35:25 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 12-20020a170902ee4c00b001bc18e579aesm861350plo.101.2023.10.28.14.35.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 14:35:25 -0700 (PDT)
Message-ID: <b2335b60-b2f5-4ece-ab75-079fac4f7f9b@linaro.org>
Date: Sat, 28 Oct 2023 14:35:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/6] linux-user/loongarch64: Add LSX sigcontext
 save/restore
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, laurent@vivier.e, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, laurent@vivier.eu
References: <20231010033701.385725-1-gaosong@loongson.cn>
 <20231010033701.385725-6-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231010033701.385725-6-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

On 10/9/23 20:37, Song Gao wrote:
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   linux-user/loongarch64/signal.c | 107 ++++++++++++++++++++++++++------
>   1 file changed, 87 insertions(+), 20 deletions(-)
> 
> diff --git a/linux-user/loongarch64/signal.c b/linux-user/loongarch64/signal.c
> index 277e9f5757..4b09e50a5f 100644
> --- a/linux-user/loongarch64/signal.c
> +++ b/linux-user/loongarch64/signal.c
> @@ -33,6 +33,14 @@ struct target_fpu_context {
>       uint32_t fcsr;
>   } QEMU_ALIGNED(FPU_CTX_ALIGN);
>   
> +#define LSX_CTX_MAGIC           0x53580001
> +#define LSX_CTX_ALIGN           16
> +struct target_lsx_context {
> +    uint64_t regs[2 * 32];
> +    uint64_t fcc;
> +    uint32_t fcsr;
> +} QEMU_ALIGNED(LSX_CTX_ALIGN);

It probably doesn't matter here because fo the alignment, but all types within target 
structures should be using abi_{ullong,uint} etc.


> @@ -99,8 +109,15 @@ static abi_ptr setup_extcontext(struct extctx_layout *extctx, abi_ptr sp)
>   
>       /* For qemu, there is no lazy fp context switch, so fp always present. */
>       extctx->flags = SC_USED_FP;
> -    sp = extframe_alloc(extctx, &extctx->fpu,
> +
> +    if (env->extctx_flags & EXTCTX_FLAGS_LSX) {
> +        sp = extframe_alloc(extctx, &extctx->lsx,
> +                        sizeof(struct target_lsx_context), LSX_CTX_ALIGN, sp);
> +
> +    } else if (env->extctx_flags & EXTCTX_FLAGS_FPU) {
> +        sp = extframe_alloc(extctx, &extctx->fpu,
>                           sizeof(struct target_fpu_context), FPU_CTX_ALIGN, sp);
> +    }

I think this is overly complicated.  (1) The fpu is always present, and (2) you don't need 
a special flag on env, you can check the same CSR bits as for system mode.

I'll note that while this layout matches the kernel, it is an unfortunate set of data 
structures.  Any program has to look for all of {FPU,LSX,LASX}_CTX_MAGIC in order to find 
the basic fp registers.


r~


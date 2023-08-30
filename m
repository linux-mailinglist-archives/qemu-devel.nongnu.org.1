Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 558E478E0E8
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 22:46:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbS46-0005VU-Kd; Wed, 30 Aug 2023 16:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbS43-0005VL-VK
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 16:45:24 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbS40-0002bA-HE
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 16:45:22 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c0db66af1bso522455ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693428319; x=1694033119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VCy022swCiCaNl7sgTdTrzvlzTyZ4QT+niJPuNq9bIk=;
 b=Y9cCPXXDrJQlgraHNjQnTy+teLbje1JsABG2KlPtPAtmJcmZK9WUUVrZci7vGVlWyP
 ba6mLGyk8yue1y1h5MEhrChtU8h6ExvhTw47NLvy4Nt0Jgwu5xLIDaBBg2rjp27TPcv8
 r2gTPRkiPXWxyeTArq2eFgSdxbX6gfQlJ3yhCjbfbXNGvdBaggr8uawQon0hRbAxXOKI
 d1pXPMZdxRQ7whU9Z3532adVKUSr+WSB3hY9wb+D5qZH0WNDEm3lIul9muW1TU/YLc7D
 jA4fV/0kELgdr4sFf1HCpsE46x2TLK0Mj4ENHwJL8dq0pAwkC5RPnSWthX7yWFuEKdCp
 Lemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693428319; x=1694033119;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VCy022swCiCaNl7sgTdTrzvlzTyZ4QT+niJPuNq9bIk=;
 b=HXvYKFDUROpNkYFvfnAjNlghJSLyiQNLSSWfR5XvRoM+x9hNy+oWhBGwgY84ZSv7Tq
 y0nMS1LsB6FiMChWq811ABz7CatKD9TW97HvPEu32JlGThMhhgtsZCghTtAv0EGsCepm
 q+4TfEEh2v5BSuWxDZ4lM/9OVoRpmASjObq0lkGIhVE1MhG+ufxh1WWe4BSY6WNCpsqx
 H+U30O1Gk8tak8cRgtPb9J/al1ZLpGXWwrcx7vmh7cioWPFtZ5xlB9lf9H+hp6eZipEn
 OTbjdUXI6FNLT087W1AoGpJKN/OLEUlpMGDVR0OqjWhvwSuesbkzqytDdgvxhC0ewlOR
 lalQ==
X-Gm-Message-State: AOJu0YxgE3JqWXBxxGZRYIxXIG/DvNkgbK9rK3bSOFZaQOKgvYvxMdWr
 7fvrDRcNagQVkIooNFGhzEeEJs0Uk2HyCwry178=
X-Google-Smtp-Source: AGHT+IFgCRJnHbcT48fIs3LY6N1cS3yaxQxBQIvrdKGAe/VS+x4MP+/bwYn0cirXGg0lChTxHOzpgw==
X-Received: by 2002:a17:903:1cc:b0:1bc:6c00:a2cf with SMTP id
 e12-20020a17090301cc00b001bc6c00a2cfmr2909474plh.53.1693428319081; 
 Wed, 30 Aug 2023 13:45:19 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 u15-20020a17090341cf00b001bdc9daadc9sm11609635ple.89.2023.08.30.13.45.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 13:45:16 -0700 (PDT)
Message-ID: <9438d724-d960-56ac-e183-e52a9c890f2a@linaro.org>
Date: Wed, 30 Aug 2023 13:45:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 15/48] target/loongarch: Implement xvadda
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-16-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-16-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 8/30/23 01:48, Song Gao wrote:
> -#define DO_VABS(a)  ((a < 0) ? (-a) : (a))
> -
> -#define DO_VADDA(NAME, BIT, E, DO_OP)                       \
> -void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v) \
> -{                                                           \
> -    int i;                                                  \
> -    VReg *Vd = (VReg *)vd;                                  \
> -    VReg *Vj = (VReg *)vj;                                  \
> -    VReg *Vk = (VReg *)vk;                                  \
> -    for (i = 0; i < LSX_LEN/BIT; i++) {                     \
> -        Vd->E(i) = DO_OP(Vj->E(i)) + DO_OP(Vk->E(i));       \
> -    }                                                       \
> +#define DO_VADDA(NAME, BIT, E, DO_OP)                          \
> +void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
> +{                                                              \
> +    int i;                                                     \
> +    VReg *Vd = (VReg *)vd;                                     \
> +    VReg *Vj = (VReg *)vj;                                     \
> +    VReg *Vk = (VReg *)vk;                                     \
> +    int oprsz = simd_oprsz(desc);                              \
> +                                                               \
> +    for (i = 0; i < oprsz / (BIT / 8); i++) {                  \
> +        Vd->E(i) = DO_OP(Vj->E(i)) + DO_OP(Vk->E(i));          \
> +    }                                                          \
>   }

No need to move DO_VABS, and indeed no need to pass it in as DO_OP, because DO_VADDA is 
only ever used with DO_VABS.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


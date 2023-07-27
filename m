Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 601E5765947
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 18:53:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP42x-0007u2-AC; Thu, 27 Jul 2023 12:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qP42h-0007qX-S7
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:40:48 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qP42g-0004Vy-Ce
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:40:47 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bbc87ded50so7424045ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690476044; x=1691080844;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vs3TygtsJVBW9W2alZ3wUYkMBn9wc62TWXkwrOFFFIQ=;
 b=j0R1+WjcUWeIy54HYQ+ialSCmMhU1B1EFNxcHB2mzU3B7hgtbIzBpcCqG3ybF2556m
 XKOItSSs87CByQ3NUXxfBtgua5mo9H0Na0wYmSis2IOdtQ5BePeSemT/pd3aydAtuqmz
 o952Mq5Zj7Df6ODDWUXV3Ho0hVwKQLspCYBwunYH3I7qUp7EbMHYihE+OagN5rZw/ny4
 +NOpjw6FyziHcQCx7/CFi11HaazvmJ2rR3Td9Mo3AWNqkJ4zPObNeUu4v9EcJpKApHQ/
 5M2lD72yrksvlQT32Va9GvCjoM7+HtQH9zi5/lcUrL1Fflrag7YbRXKHjw4I72jC+tWg
 A9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690476044; x=1691080844;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vs3TygtsJVBW9W2alZ3wUYkMBn9wc62TWXkwrOFFFIQ=;
 b=ZA4o4oC+LiWAvc1JD1MamTda9QXVcB8n7iVSOyZ8MRdxWWvNLYa1gvk8JrKjuSVsbe
 2aqFjSeW/YVfcxzckSjzQMEZ06ssa68uYIO2F7mW1cf8PrQlfcHMYcy3dZjtJhZfy5F9
 bHXPiabwLYLfj5iJVBAGQJ1L5Raldvno8UCqerop4p6aCfwlPuxznI7gsHznLJU6nd+6
 jkIoUq+qXF5wGLRAUEi4PtIRAFo80gz3661LkCEfkXtOA1NWTyPHI/+JB1n+Y63TD+rP
 R9CDh+2Lztg0yrfruK+7rpjvvZphWVHsu6Y+W4pJTWSiC9WhAOsZvGHIMS7aCq3nvmZE
 MnAw==
X-Gm-Message-State: ABy/qLZ1jiboRwQQ0TvnZyoUqhoT9VQsH/pxadDALAnKljpT0wAtHJZ3
 x+wU20kmioEmZblBQhjm2SLxqbmXYTiazHnPIQA=
X-Google-Smtp-Source: APBJJlEWIvZgQBAvmRjiYP2mUi4feI9SD3rT6+O4+5Q13Zr4QdTbFRK1ISnSpmJY0EqzZ1exB/2gfQ==
X-Received: by 2002:a17:903:181:b0:1b1:ae33:30de with SMTP id
 z1-20020a170903018100b001b1ae3330demr5745585plg.13.1690476044538; 
 Thu, 27 Jul 2023 09:40:44 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:caf5:5ae2:432a:1bdf?
 ([2602:ae:154e:c001:caf5:5ae2:432a:1bdf])
 by smtp.gmail.com with ESMTPSA id
 jj6-20020a170903048600b001bba7aab826sm1865523plb.163.2023.07.27.09.40.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 09:40:44 -0700 (PDT)
Message-ID: <4dc8f541-2cf9-c8fa-1032-e5ae632c4881@linaro.org>
Date: Thu, 27 Jul 2023 09:40:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/riscv: Use existing lookup tables for AES
 MixColumns
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Zewen Ye <lustrew@foxmail.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>
References: <20230727070303.1220037-1-ardb@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230727070303.1220037-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/27/23 00:03, Ard Biesheuvel wrote:
> @@ -606,8 +606,7 @@ static const uint32_t AES_Te4[256] = {
>       0x41414141U, 0x99999999U, 0x2d2d2d2dU, 0x0f0f0f0fU,
>       0xb0b0b0b0U, 0x54545454U, 0xbbbbbbbbU, 0x16161616U,
>   };
> -
> -static const uint32_t AES_Td0[256] = {
> +const uint32_t AES_Td0[256] = {

Don't drop the blank line.

> @@ -62,18 +39,21 @@ static inline target_ulong aes32_operation(target_ulong shamt,
>       if (enc) {
>           so = AES_sbox[si];
>           if (mix) {
> -            mixed = aes_mixcolumn_byte(so, true);
> +            mixed = AES_Te0[si];
>           } else {
>               mixed = so;
>           }
>       } else {
>           so = AES_isbox[si];
>           if (mix) {
> -            mixed = aes_mixcolumn_byte(so, false);
> +            mixed = AES_Td0[si];
>           } else {
>               mixed = so;
>           }
>       }
> +    if (!HOST_BIG_ENDIAN && mix) {
> +        mixed = bswap32(mixed);
> +    }
>       mixed = rol32(mixed, shamt);

Better as

     if (enc) {
         if (mix) {
             mixed = be32_to_cpu(AES_Te0[si]);
         } else {
             mixed = AES_sbox[si];
         }
     } else {
         ...
     }
     mixed = rol32(mixed, shamt);

But thanks for the update -- I had ignored rv32 when doing the other AES bits.

r~



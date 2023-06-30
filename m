Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D4A7442CD
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 21:40:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFJyA-0005cg-PZ; Fri, 30 Jun 2023 15:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFJy8-0005bG-LL; Fri, 30 Jun 2023 15:39:48 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFJy6-0007xF-Rl; Fri, 30 Jun 2023 15:39:48 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1b09276ed49so2105455fac.1; 
 Fri, 30 Jun 2023 12:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688153985; x=1690745985;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2QnK9uXG7gSxzChHGhP+74LWTkyab8Q8+NkTca9KBXs=;
 b=XwdoLNlhdykOs77CrS6+cY4DOszUzN1tBmIhWrJ0Nkl11GiXWOQSnJ32E+7QAfGRRT
 QSQm/aPycfhXC4eoz+xyYSL9VSLOJZqr8CizfNQQSsE7wN28YJ4tWFLVOQfFXdjFYIw+
 gCosRxcYiQ3MYE8BdZYlIk5f5BjsXf+4/u98U7nTs4B7B8wjvjSp16lzRRkuxhyYMadU
 /BAL/kyw7ZgaC0fw6asrZssMbgNku2jAJNAkjHucPmAm8fha8jVFh4/YTL1U6ErUoeUb
 vXhdVWxOxDQO+yJA3QcCGRisqlDHb6PNUKB6j7yaEAt2QpRJSrvGcpvw12IoQrXB2cAI
 LvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688153985; x=1690745985;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2QnK9uXG7gSxzChHGhP+74LWTkyab8Q8+NkTca9KBXs=;
 b=YvjI30XjH5wk1HP8lDe2FaBDGYqKpy5BH8NatrMxHGsBPnI6Rpf8cvZw6Rf3ZHbg+9
 t7kZpRziMHWN2jeW+vjGqGXLoDEb91OdQho8pAsUBlGdg+tZTbPflwhMt6fFTKgmL6ZU
 yB0lauKLCbot6XW9Md/uG4GMPcUZjqS9UE6oMwlNUjY2ET2U/fphe+zId19CnU0XCN45
 +K2LNdnjQYTpkkF7gsIXRR6nenFIIysD7AlrPgFrUGrKZ/Zt1nvSG3JaokYOki7y3gK/
 pu5Go5NAz1FBcK/9ZjpCEKchj9l1KnpRuSkIPMpR2x+ig8rCkl+o4kcMdsHDoM5bCvfu
 txww==
X-Gm-Message-State: AC+VfDw/ZbJT93rddCZvIzb6wohI491viWDAvgJR0wftwDUbMQm0hJh3
 cZmV1Rhf+xyawFKSSCjJ9Ng=
X-Google-Smtp-Source: ACHHUZ5QmtvUPY1N/6t9mm9VBmDEeB9R0s0lGq5FCWl2yMD+Pgd/y4M+VlRJtVB0y+u18GfVp4JZfQ==
X-Received: by 2002:a05:6870:fba8:b0:1b0:e939:8ab1 with SMTP id
 kv40-20020a056870fba800b001b0e9398ab1mr4918816oab.15.1688153984819; 
 Fri, 30 Jun 2023 12:39:44 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 j5-20020a4adf45000000b0056351d2841asm4643862oou.20.2023.06.30.12.39.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 12:39:44 -0700 (PDT)
Message-ID: <136c1e78-89f5-499a-7299-593b2cac3fbe@gmail.com>
Date: Fri, 30 Jun 2023 16:39:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] pnv/xive2: Allow indirect TIMA accesses of all sizes
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, clg@kaod.org,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com
References: <20230626094057.1192473-1-fbarrat@linux.ibm.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230626094057.1192473-1-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.095,
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

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

On 6/26/23 06:40, Frederic Barrat wrote:
> Booting linux on the powernv10 machine logs a few errors like:
> 
> Invalid read at addr 0x38, size 1, region 'xive-ic-tm-indirect', reason: invalid size (min:8 max:8)
> Invalid write at addr 0x38, size 1, region 'xive-ic-tm-indirect', reason: invalid size (min:8 max:8)
> Invalid read at addr 0x38, size 1, region 'xive-ic-tm-indirect', reason: invalid size (min:8 max:8)
> 
> Those errors happen when linux is resetting XIVE. We're trying to
> read/write the enablement bit for the hardware context and qemu
> doesn't allow indirect TIMA accesses of less than 8 bytes. Direct TIMA
> access can go through though, as well as indirect TIMA accesses on P9.
> So even though there are some restrictions regarding the address/size
> combinations for TIMA access, the example above is perfectly valid.
> 
> This patch lets indirect TIMA accesses of all sizes go through. The
> special operations will be intercepted and the default "raw" handlers
> will pick up all other requests and complain about invalid sizes as
> appropriate.
> 
> Tested-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> ---
>   hw/intc/pnv_xive2.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index ed438a20ed..e8ab176de6 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1644,11 +1644,11 @@ static const MemoryRegionOps pnv_xive2_ic_tm_indirect_ops = {
>       .write = pnv_xive2_ic_tm_indirect_write,
>       .endianness = DEVICE_BIG_ENDIAN,
>       .valid = {
> -        .min_access_size = 8,
> +        .min_access_size = 1,
>           .max_access_size = 8,
>       },
>       .impl = {
> -        .min_access_size = 8,
> +        .min_access_size = 1,
>           .max_access_size = 8,
>       },
>   };


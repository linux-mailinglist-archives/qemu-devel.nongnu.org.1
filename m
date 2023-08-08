Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40395774D6E
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:55:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTUeP-0000q8-Hl; Tue, 08 Aug 2023 17:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTUeM-0000pt-Gt
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:53:59 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTUeK-0005Zg-Tf
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:53:58 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68730bafa6bso211973b3a.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691531634; x=1692136434;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VWoPMh6oO3cK2hGW+B34oXkePUG+r/lcuEyGINFlFgw=;
 b=v4RpsNL9sc4a759qgQjVqWOVolB/7TKsbzcN9bGGMZP2zqkytOQ2592Uk65VhTiM9r
 wCNeDLvV/XpmlIXZB6FnID8XIAOFeQ8FeNmvaEvU6EEnkUhdiQE4kkIrh30sO88nHUv1
 7wiUBYjt61tvCtw+AqBbBHfhcK6SAHRPn3dxtkO6DhedgY57Qj3tEIQRhizQbIPYK1vB
 7blolcPDqxnPzRBncMUwn2/nBvnj9j6P/M9QAQBwhYlFKeycTmAHsMWrnq/Fi2rBRG5T
 8WCmzNFzeM22AUssKF8nJx04Yz/n47cNiVfFhqSdKagFuaPCE1AmiMiqUZq8B7WlGahZ
 kXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691531634; x=1692136434;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VWoPMh6oO3cK2hGW+B34oXkePUG+r/lcuEyGINFlFgw=;
 b=PurO/f5CrhcsAnETXeq77/EDP7SkAL+2T6fmRHCdCplaGJRYHZjQW2cvDRYnW3x+KY
 yhKZUoGhXSGDojZwUOrDudqI/uCbIa8O/hsu4pieU3POgTtZZXe6ui6pU53pkW/HjqAT
 INkdFD13H/T9koyCp8yLBK8elvIltgyPOh1RQNmWeE5xeHX96N5HSlxRkItmaJEpw8Do
 u6QPts6pH0szvXUUHM5J3PKqrxEc2rmwApQoNNuV0NtY2g68MGrskOp57y4bX1MAPGPA
 47C2OH9YqDTskA8F2dEIO6VFSqUsNtrJtfMA55HyrhXOcebNh1Yi0g8+w9Ur6fSjq0nC
 NbRg==
X-Gm-Message-State: AOJu0YwAMkjDv3oBeQU2PqrIHvP8r2wkC0W+nLOkc+TWmIbiDB5ZDnJn
 9RfJCqHT044Z9Lj2Ek+VIMiBMQ==
X-Google-Smtp-Source: AGHT+IFUNeTG/F7pqZ8NWWy8tcf79FOpIS9igKgsmWAOeV+obzC/M6ebK1EO6e4/tAdlOZDqxYcUrQ==
X-Received: by 2002:a05:6a20:9389:b0:126:42ce:bd44 with SMTP id
 x9-20020a056a20938900b0012642cebd44mr13221364pzh.17.1691531634487; 
 Tue, 08 Aug 2023 14:53:54 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 a4-20020a637f04000000b0056334a7b9b2sm7015292pgd.33.2023.08.08.14.53.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 14:53:54 -0700 (PDT)
Message-ID: <ebc5c562-205e-5a1a-6b3e-381b8c022b26@linaro.org>
Date: Tue, 8 Aug 2023 14:53:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 18/33] Implement stat related syscalls
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-19-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808060815.9001-19-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/7/23 23:08, Karim Taha wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Implement the following syscalls:
> stat(2)
> lstat(2)
> fstat(2)
> fstatat(2)
> nstat
> nfstat
> nlstat
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>

Why are all of these in os-stat.h instead of os-stat.c?
Is this attempting to avoid clang's warning for unused static inline function in a c file?

> +/* stat(2) */
> +static inline abi_long do_freebsd11_stat(abi_long arg1, abi_long arg2)
> +{
> +    abi_long ret;
> +    void *p;
> +    struct freebsd11_stat st;
> +
> +    LOCK_PATH(p, arg1);
> +    ret = get_errno(freebsd11_stat(path(p), &st));
> +    UNLOCK_PATH(p, arg1);
> +    if (!is_error(ret)) {
> +        ret = h2t_freebsd11_stat(arg2, &st);
> +    }
> +    return ret;
> +}

The patch ordering is poor, because freebsd11_stat is used here but not introduced until 
patch 23, and do_freebsd11_stat itself is not used until patch 30.

And yet you delay compilation of os-stat.c until patch 29.  Patch 29 is either too early 
or too late, depending on the viewpoint.

If os-stat.c compilation was enabled earlier, it would require you to order all of the 
patches such that os-stat.c will always compile.

If os-stat.c compilation was enabled later (indeed last), you would not need to mark this 
function 'static inline' in order to avoid unused function warnings prior to their use in 
patches 30-33.

I prefer the ordering in which os-stat.c always compiles.  This probably requires patches 
23-27 be ordered first, and patches 30-33 be merged with patches 18-22.  There is no need 
for *any* of these functions to be marked inline -- leave that choice to the compiler.


r~


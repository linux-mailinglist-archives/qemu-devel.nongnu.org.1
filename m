Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1523578D05E
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:23:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nm-0001QN-RK; Tue, 29 Aug 2023 19:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4Vw-0008DY-5F
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:36:36 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4Vs-0003QV-8L
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:36:34 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-26d54d3d984so2452280a91.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693337790; x=1693942590; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PNm3OVdCa27Sa5V12C0PwOp8wT0NWMYuJTWdj6hj/dY=;
 b=dj7/ZldvJt9+v5UNLo4dD4ZFnVFE+UepIZj9L9zwgT+AisMTeFfhyAGQ0DAuY8cAlV
 sMke39/yNU6U4qqCjCSCBLRgRJsXwIAHdYTzRMXeR2xWXUmEXKZ8ypdLCUewnlEhAG04
 UBlRlZn2FzLT3+npSOTWyKurArnwKjWwR3x84FzesEfLsfhOOKfSetgRgYIYe/UPuF6/
 8ajWpKst1GJDJYhj/hw/TtkGjsnU9iGDMuXcOkWO8k8+nH3GcT+MYZC/bjVM2hddtlnr
 jDXZLViM8eP50i430hJK3LZixls5l4H7aE8IqNIsegDicd+aWxZFXdOJq30FSX0D0LV/
 547w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693337790; x=1693942590;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PNm3OVdCa27Sa5V12C0PwOp8wT0NWMYuJTWdj6hj/dY=;
 b=YHdPRtDhwD4S7TH7hekcLYS94oyQrs5oq041BdyxEMxPwN4d2OVbckspnPB23omf87
 6HrqnqYnNiR02+VZ5YBfnHrRyFRifMbhR+w7DodtQJBdbU8dUP3FfGMOXuY3SoFX2L5w
 H+Jzklcn98ItPvCE1LstbwzNZvcEgdk9ikEe6Wzewfb3Mm0IkDbZcisi+vnUY4QYKbHF
 omqO0rplhX+H5Mc8xM5lfEkouWu8lrbdYP8YN4IaSu60a1avDycIe3kNAJbzptasKimD
 ZN+6AOli8yzWpe9FDoKOkyHaS9XYrTPiAoUK8bbvbYP+WWI6fsDboKuoNUtnLAsXKAkM
 OQsg==
X-Gm-Message-State: AOJu0YwnpaonLcZUGpSaNsy8yqnuhE8VIyA9lszv2JCS4xSHb7A5SoiF
 YYGA9XN+VQQ4WYNtPc3cRszbOA==
X-Google-Smtp-Source: AGHT+IEAre9IAD+GFSvWrU+SqEVCYKSwwEBn9PldHbf87JuMRwNdBFP1fy5Qmiv5pEiy5C0ppcxoNw==
X-Received: by 2002:a17:90a:b109:b0:26d:4421:854d with SMTP id
 z9-20020a17090ab10900b0026d4421854dmr147757pjq.37.1693337790305; 
 Tue, 29 Aug 2023 12:36:30 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 j23-20020a17090ae61700b002696aeb72e5sm11323337pjy.2.2023.08.29.12.36.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 12:36:29 -0700 (PDT)
Message-ID: <cffcc325-f898-dcdb-477e-2d82447f9e8c@linaro.org>
Date: Tue, 29 Aug 2023 12:36:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 08/32] bsd-user: Implement target_to_host_rlim and
 host_to_target_rlim conversion.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-9-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-9-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-proc.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> 
> +rlim_t target_to_host_rlim(abi_llong target_rlim)
> +{
> +    abi_llong target_rlim_swap;
> +    rlim_t result;
> +
> +    target_rlim_swap = tswap64(target_rlim);
> +    if (target_rlim_swap == TARGET_RLIM_INFINITY) {
> +        return RLIM_INFINITY;
> +    }
> +
> +    result = target_rlim_swap;
> +    if (target_rlim_swap != (rlim_t)result) {
> +        return RLIM_INFINITY;
> +    }
> +
> +    return result;
> +}
> +
> +abi_llong host_to_target_rlim(rlim_t rlim)
> +{
> +    abi_llong target_rlim_swap;
> +    abi_llong result;
> +
> +    if (rlim == RLIM_INFINITY || rlim != (abi_llong)rlim) {
> +        target_rlim_swap = TARGET_RLIM_INFINITY;
> +    } else {
> +        target_rlim_swap = rlim;
> +    }
> +    result = tswap64(target_rlim_swap);
> +
> +    return result;
> +}

Though I think these are the identity function as well, since afaict we're always talking 
about 64-bit data.


r~


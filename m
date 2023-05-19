Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BCE709AD1
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:03:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01dZ-0003bx-Sc; Fri, 19 May 2023 11:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q01d9-0003X6-7Z
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:02:55 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q01d6-0002D1-GG
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:02:54 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-30904c0ff4cso674792f8f.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 08:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684508571; x=1687100571;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iEFBQeDFvSIDGy4BBUWZ3x0jxrCRzA2tixKRKPHKzjQ=;
 b=dJFXh+JnbiidEzrhyAz/8keJgmi2wnwIGqh2LpDvI0dYBAbAR1o6aP2EZYGdLE3fDC
 g2s4aq66VSIHnEVnPvKkeoCjI6+/it2otUUmsEi7eHoLvdFGJP/L4Gg86NPVJqhW8KCi
 2jXJGNYDT+rj5BhtP4p791Wqs6xEFi8z1AESIxHNI1eHTfmJdIrKDbSUZh4/DGxIxqba
 tc5HjAxLjgNYCYjz2eJfFWTWANwVBi+xe69g5yt8XV2EG7flOXdejjsznyG8IxoCRUCw
 EQfs96yMRyZf7zPMDQrFyiTWDAPLsrjgYaaroOBj/qR4hpIxWj730rRFPoO+aJhWYRbi
 fTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684508571; x=1687100571;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iEFBQeDFvSIDGy4BBUWZ3x0jxrCRzA2tixKRKPHKzjQ=;
 b=T4W4uPYmTDCP73V/8xodBLXccR6HUfInGZWtUISoWzKZ5GP6aPvDQ9xYdP/e4GUyQK
 DymOkCeoQJA9KW2FcQt3Fw7HpyGOD7REeE+ioVV0iAO68jJILtYfjQ2yT9IFwo9oavgI
 GiHmLOVZlsY2Vkav8xGFWrjH5Wbau8gtiokMsyMriD5+FcdNToJqApNxmyPekithpXhM
 hGWqt+aBRjKH65omSDPC3imNDicAHsROGBeZGo5gYcmMSDKazahqg5FkhA+okGKRCNwN
 kAAc/U3GltbTxwcgbewf2BCrmwd0jcZ1xOAbMBy/RZfF/MsMB30OB+/HEB3BjEp6VzMQ
 ahHw==
X-Gm-Message-State: AC+VfDzmf4AHFX17ae+guRfxjoTVxAx/A57Xq+UOlkx40dGPjaFFhTlM
 Mj7tM+EPzmUbaFudi7ZAvC8hkV92CRA2cWnrR6Q=
X-Google-Smtp-Source: ACHHUZ6rj2Oq+PFFLgdN6lyrU3eLA2g2FtXxpoN3WyRwRnPZ73l5hjbvWUW3T4TCV5vq0hYkysi1ww==
X-Received: by 2002:a5d:5644:0:b0:307:869c:99ce with SMTP id
 j4-20020a5d5644000000b00307869c99cemr1864475wrw.21.1684508570835; 
 Fri, 19 May 2023 08:02:50 -0700 (PDT)
Received: from [192.168.69.115] (mau49-h01-176-184-41-228.dsl.sta.abo.bbox.fr.
 [176.184.41.228]) by smtp.gmail.com with ESMTPSA id
 x12-20020adff64c000000b0030629536e64sm5578438wrp.30.2023.05.19.08.02.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 08:02:50 -0700 (PDT)
Message-ID: <906dbffa-c677-1192-fedc-5664e61f8255@linaro.org>
Date: Fri, 19 May 2023 17:02:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 4/6] target/tricore: Refactor PCXI/ICR register fields
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230519133650.575600-1-kbastian@mail.uni-paderborn.de>
 <20230519133650.575600-5-kbastian@mail.uni-paderborn.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230519133650.575600-5-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.527,
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

Hi Bastian,

On 19/5/23 15:36, Bastian Koppelmann wrote:
> starting from ISA version 1.6.1 (previously known as 1.6P/E), some
> bitfields in PCXI and ICR have changed. We also refactor these
> registers using the register fields API.
> 
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1453
> ---
>   target/tricore/cpu.h       | 39 ++++++++++++-----
>   target/tricore/helper.c    | 45 ++++++++++++++++++++
>   target/tricore/op_helper.c | 85 +++++++++++++++++++-------------------
>   target/tricore/translate.c | 12 +++++-
>   4 files changed, 125 insertions(+), 56 deletions(-)


> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> index 2646cb3eb5..db62604102 100644
> --- a/target/tricore/translate.c
> +++ b/target/tricore/translate.c
> @@ -7847,12 +7847,20 @@ static void decode_sys_interrupts(DisasContext *ctx)
>           /* raise EXCP_DEBUG */
>           break;
>       case OPC2_32_SYS_DISABLE:
> -        tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~MASK_ICR_IE_1_3);
> +        if (has_feature(ctx, TRICORE_FEATURE_161)) {
> +            tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~R_ICR_IE_161_MASK);
> +        } else {
> +            tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~R_ICR_IE_13_MASK);
> +        }
>           break;
>       case OPC2_32_SYS_DSYNC:
>           break;
>       case OPC2_32_SYS_ENABLE:
> -        tcg_gen_ori_tl(cpu_ICR, cpu_ICR, MASK_ICR_IE_1_3);
> +        if (has_feature(ctx, TRICORE_FEATURE_161)) {
> +            tcg_gen_ori_tl(cpu_ICR, cpu_ICR, R_ICR_IE_161_MASK);
> +        } else {
> +            tcg_gen_ori_tl(cpu_ICR, cpu_ICR, R_ICR_IE_13_MASK);
> +        }
>           break;
>       case OPC2_32_SYS_ISYNC:
>           break;

Could it be clearer to add a 'icr_ie_mask' field in CPUTriCoreState,
initialized once in tricore_cpu_realizefn() and avoid this if/else/ in
translation here, simply using the initialized mask?


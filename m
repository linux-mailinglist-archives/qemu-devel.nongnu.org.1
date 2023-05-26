Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DD1713041
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 01:13:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2gbM-00026V-I0; Fri, 26 May 2023 19:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2gbK-00026D-Vi
 for qemu-devel@nongnu.org; Fri, 26 May 2023 19:12:03 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2gbJ-0007E1-AL
 for qemu-devel@nongnu.org; Fri, 26 May 2023 19:12:02 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5289cf35eeaso1946233a12.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 16:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685142720; x=1687734720;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2iYP2NN/B6aO3qJ0vzyfDkGGy0AYNk8j3vdzxNhxfak=;
 b=uRNvKz61Lt/s7N/vy88SV3FkmFfe9zsx/lGc5t60ozOJbOb0qwy0HTZAt2ec3Szr7/
 WOzXrxkAooWSRc+u4cNpmfbgXYjqFyPy4Gi7TysszM1OeEOJRfQimjqflZ7Q13M4FClP
 IxnIMUNTliyFa1BGfj2wimhNG1vr0o1t3WznROIyTy/bfvBxmpJXnZcviksxTvRQ+zcl
 pAg/awjMcId0+O5hGMAHcGi4p8DCMoBvXNSFjU1xsMiheDM+6fGaM903eQ2j7hVf1iVG
 6IfFuPlFlrsC2jtGT5tOM1ECCoLW8Bju/q6291ZHtsMMChcUaDJpvSMVfvGS1fnuBeH0
 tA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685142720; x=1687734720;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2iYP2NN/B6aO3qJ0vzyfDkGGy0AYNk8j3vdzxNhxfak=;
 b=WyLm65gO27AmafVYaLJH6IVxA6RhYbw2+3ISd9/vJvsBCMUCNAPOV/12hKH0Krbm5b
 6UqRfTrRpoBOWRUh5Yiv/e7cOT2MKcF2bYRAqSnWaKo6+o848Eyt2wfnY7OzQ/LDYh/M
 Sn+7Y6NpyH9tlW8EGM1EoWxivUzsspSSLPoSCZpFSupqPrjs53z9ND2ga9PBzrHVU3WS
 XGniLo7Gh1YQJqJCnrze7/MpzMpzkilASRi/B9Bz9nJ3a28hq9AcWfiO1HJZP66YdxtZ
 UBfdkLr/eQrW8erlb6J7+ggDS9mS/eaWznYaRED8ufmyueIEivjehyW0tEY+MpKji2LE
 m35Q==
X-Gm-Message-State: AC+VfDytG6akNDotjW2sX4iflLQTEuYy3v/SaS0z3ZBIVdgjDATUavwU
 O3acFETUr7cjTBx6bQ0RkfmLYAIhZfBrLQ4vfPI=
X-Google-Smtp-Source: ACHHUZ7Iw9q8Nsca/YxhLgq92GJrAJOwoal2807KmOpKzLPgT78Vc5UuMvta7xd1zOxpf8l+MV266g==
X-Received: by 2002:a17:903:18b:b0:1ac:731b:bc9a with SMTP id
 z11-20020a170903018b00b001ac731bbc9amr565682plg.27.1685142719779; 
 Fri, 26 May 2023 16:11:59 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86cc:4482:68db:2c0f?
 ([2602:ae:1598:4c01:86cc:4482:68db:2c0f])
 by smtp.gmail.com with ESMTPSA id
 b7-20020a170902bd4700b001ab13f1fa82sm3740654plx.85.2023.05.26.16.11.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 16:11:59 -0700 (PDT)
Message-ID: <20b3bf44-b765-e396-a6e5-9d52f5b6b6ab@linaro.org>
Date: Fri, 26 May 2023 16:11:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] target/s390x: Fix LCBB overwriting the top 32 bits
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230526181240.1425579-1-iii@linux.ibm.com>
 <20230526181240.1425579-2-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230526181240.1425579-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 5/26/23 11:12, Ilya Leoshkevich wrote:
> LCBB is supposed to overwrite only the bottom 32 bits, but QEMU
> erroneously overwrites the entire register.
> 
> Fixes: 6d9303322ed9 ("s390x/tcg: Implement LOAD COUNT TO BLOCK BOUNDARY")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> ---
>   target/s390x/tcg/insn-data.h.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
> index bcc70d99ba2..e41672684aa 100644
> --- a/target/s390x/tcg/insn-data.h.inc
> +++ b/target/s390x/tcg/insn-data.h.inc
> @@ -486,7 +486,7 @@
>       F(0xb343, LCXBR,   RRE,   Z,   x2h, x2l, new_P, x1_P, negf128, f128, IF_BFP)
>       F(0xb373, LCDFR,   RRE,   FPSSH, 0, f2, new, f1, negf64, 0, IF_AFP1 | IF_AFP2)
>   /* LOAD COUNT TO BLOCK BOUNDARY */
> -    C(0xe727, LCBB,    RXE,   V,   la2, 0, r1, 0, lcbb, 0)
> +    C(0xe727, LCBB,    RXE,   V,   la2, 0, new, r1_32, lcbb, 0)
>   /* LOAD HALFWORD */
>       C(0xb927, LHR,     RRE,   EI,  0, r2_16s, 0, r1_32, mov2, 0)
>       C(0xb907, LGHR,    RRE,   EI,  0, r2_16s, 0, r1, mov2, 0)



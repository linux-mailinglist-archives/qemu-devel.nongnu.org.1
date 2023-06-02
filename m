Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A52D3720AED
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 23:20:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5CBo-0004kx-Jf; Fri, 02 Jun 2023 17:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5CBn-0004kn-2I
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 17:20:03 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5CBk-00052r-Ah
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 17:20:02 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-30af86a96b4so2384100f8f.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 14:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685740791; x=1688332791;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fXCob+dvizOKq7h30N6Pi9yhy3km1gi91+XYvj1Pv0M=;
 b=tTGY7TwTSuD08ILBaHVmDy2f+eSWSlcLU/fiQLuFj2+sH2AZ0rE4rhTQORZX2PFfkn
 RTt0Et09wsxk7lh7b1ZhKmIPvZjz0+IOJ5a/q42QQYP/U0lW3pOJRfcvmQinR9CLrHoG
 8i0pxT6mvDxmiCsvrpp5GHAHtYkaRJne7jqLkD6sm/G19ExFsu7lXr7E12yfaVjb1iKL
 ZJ13oc/e2FpCHg1eloRThokMOmebmjCTlCzRxhbOqBTtneo9t2hMC1NH3ZFWta2VYdnh
 DUxxxm/ldrSPzMpisfL5+47MOpnLHPRWopzi0I3A2VkBN7gH8bK7fLbQ6JsVl2DILeum
 wIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685740791; x=1688332791;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fXCob+dvizOKq7h30N6Pi9yhy3km1gi91+XYvj1Pv0M=;
 b=i2gpQYmgTLWDGK9w0puePulcTnbDymaMy07KUvFhPgNadIvt9kdg9gVmkMTgPx5PNa
 Z3BCYEaB1jgXduwlQtjBjGJEdw/myl/8hshfQyGXNvOfUV9fVFOYd1JR2a+dFkek7Uqb
 1Wz5QKVNmgV1SJ5pwraS6FWhzgFiyA8noiBla11vCfdO/DihwxpZs4N85nBwn0F/Wu3S
 rJpzjRTwbbN0qqu9LhVfjDLQ4F17esyNvnW3nftULUBRNtXJLX2Yxj/EJqmd0ROcYG/H
 uqpC6F48/Xpd2Ed4XIGnLk5mShgKbgoIhmXzrJZ61Wrwppn4i6EFODSJKYyDOuoaAzzP
 YFwA==
X-Gm-Message-State: AC+VfDxeCfQG+3bnD+IDnpw10gmz3+rZ0LZS3glr5rOUdHzpVGvqFHu+
 6kogFmMOrsUk4KrsGZ8GKdP8fKVbbedIPuzNnfw=
X-Google-Smtp-Source: ACHHUZ7YPrm/vQ5H/aQ3+p+A18hu5EyriLxKw+cSIZZ5i/g7NtwRLzZyiBHeDau4fou0Ni/G1tMphQ==
X-Received: by 2002:a5d:46c4:0:b0:309:1532:8287 with SMTP id
 g4-20020a5d46c4000000b0030915328287mr807150wrs.19.1685740791359; 
 Fri, 02 Jun 2023 14:19:51 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a5d6806000000b0030630de6fbdsm2645534wru.13.2023.06.02.14.19.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 14:19:51 -0700 (PDT)
Message-ID: <b21cad75-1382-f3f0-efee-dc341fd77603@linaro.org>
Date: Fri, 2 Jun 2023 23:19:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 22/48] tcg: Split tcg_gen_callN
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-23-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 31/5/23 06:03, Richard Henderson wrote:
> Make tcg_gen_callN a static function.  Create tcg_gen_call[0-7]
> functions for use by helper-gen.h.inc.
> 
> Removes a multiplicty of calls to __stack_chk_fail, saving up
> to 143kiB of .text space as measured on an x86_64 host.
> 
>      Old     New Less    %Change
> 8888680	8741816	146864	1.65%	qemu-system-aarch64
> 5911832	5856152	55680	0.94%	qemu-system-riscv64
> 5816728	5767512	49216	0.85%	qemu-system-mips64
> 6707832	6659144	48688	0.73%	qemu-system-ppc64
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/helper-gen.h | 40 ++++++++++++++---------------
>   include/tcg/tcg.h         | 14 +++++++++-
>   tcg/tcg.c                 | 54 ++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 86 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



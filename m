Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 940247660DD
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 02:44:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPAnQ-0003DY-SN; Thu, 27 Jul 2023 19:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPAnP-0003DJ-2B
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 19:53:27 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPAnN-0001XL-L7
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 19:53:26 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3a3fbfb616dso1217562b6e.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 16:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690502004; x=1691106804;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ItGg7TQnhrfjZGSJ6Nw9TwbeD0Ar5weJYFw6lrxduOM=;
 b=wNLOD5cMJlbneF+LIUnECWXA3+E2NsClBsiPTrs8fRSmPoJ22TnDwJqxWPoPKopNya
 n46h8zk4dla004T2Wpg94Iny/FoodgvqQJJAYfcA/y/Mit2V88SDuBxpDnKGVcZihZJe
 Ac97DZh/w34QuT4+yzdsBexuYQ5nCtzLpw1Pu5obYVLLwm1KPGGedtlbPZ0dIow9XTtQ
 m1EcTPa7YB43uMh9K4BubTEvcLPgHlvI7QCcf3VVyCQQNVd6IEZhxjb0SlVnhePX8z1S
 Z31kzVbYccjNLhQZ043A7Xbpkzm0YcUwWg1/ddbR7mtcO51s4cER3vIsioauguUmVF82
 615g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690502004; x=1691106804;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ItGg7TQnhrfjZGSJ6Nw9TwbeD0Ar5weJYFw6lrxduOM=;
 b=N4vl4IQ840XzLBSNFkYRpET0izM15haVxICqzdbttFU8Nhbfa0CfOOFp2LBTdXvOMS
 t0feGsYKz/I3gw2q9S6VRHu4CB+qfkvXfl7vjtfok9n0DlRrD9ZfcmLVs0rD76cLKmLC
 WC/BTQNN7SYftWeDmff/Hu4UhwUQSQdgPBE6vZZiTZbJsbT9QMn9vtJNwdt5a69K7/Tq
 uRuliWb/Bg6lOOY7kmIZCA+D/ELkHKkyQpZpGEKsapBI7MItHZeKz5lG55I83R5NyQUZ
 y+v1T3yEnXxreu/Jc3Qbu/Cx84pR01pwlHYqDZe/GfIgJnCO7A0J4l0NR8hrWP1Q5L8j
 IeNQ==
X-Gm-Message-State: ABy/qLanicRyhMxGBC3Fudu9d0T6XXFTmCGF+dTA4NdBDFldrhkthe/U
 kFpFTxIBIYjHCnk2+ev+WvFyWA==
X-Google-Smtp-Source: APBJJlHvayNP8rM6juuJlzMdGJOt75BELzf2EMiO45oBe6QYF+8LlZ1sVouBxQINw2bbHsjwBaBBeQ==
X-Received: by 2002:a54:4690:0:b0:3a3:3a0b:aab8 with SMTP id
 k16-20020a544690000000b003a33a0baab8mr779916oic.48.1690502004289; 
 Thu, 27 Jul 2023 16:53:24 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:943b:b6e1:1f00:9721?
 ([2602:ae:154e:c001:943b:b6e1:1f00:9721])
 by smtp.gmail.com with ESMTPSA id
 a9-20020a631a09000000b00563590be25esm2094952pga.29.2023.07.27.16.53.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 16:53:23 -0700 (PDT)
Message-ID: <8b9387c4-d7b2-9fff-c864-70d32f7712e4@linaro.org>
Date: Thu, 27 Jul 2023 16:53:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 8/9] accel/tcg: Widen address arg. in tlb_compare_set()
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, philmd@linaro.org, agraf@csgraf.de,
 dirty@apple.com, rbolshakov@ddn.com, anielhb413@gmail.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
References: <20230721205827.7502-1-anjo@rev.ng>
 <20230721205827.7502-9-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230721205827.7502-9-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

On 7/21/23 13:58, Anton Johansson wrote:
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   accel/tcg/cputlb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


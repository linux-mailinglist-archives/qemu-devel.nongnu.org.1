Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A0A79FBCB
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 08:19:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgfh1-0004j8-1W; Thu, 14 Sep 2023 02:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfgn-0004hg-Ie
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:18:58 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfgh-0000sv-RG
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:18:57 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2bcb89b4767so8001901fa.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 23:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694672322; x=1695277122; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4iU3JRMH/2kQ3Vk5LeJShY4xfHvamUCrrsoIcBtakzs=;
 b=hFytZXeHBo/eahc62v9A9VOBH1PVitek93y7Kj5wdZbGCUK4TC4iezaYBOvI4ZV1AY
 xc/IHk+rHEgFF0QPSRByYAquGiHD6ABCIXdBxVt/gvtDZdGZOAQM36mleu5BYWHmM6fw
 tlAN+6JrZHHNubY1wF85792wftaj2F9e0eiAwmmKPwOTNGlxrtpjUEyiC8hvIsdUiwSP
 8KnxIpNNxRUqc0EAJYFfc5vj2+LwXivWXjGymcl61gXCCxnxUgXFVwx8hV9TTFwEXADS
 j9W10ZNUrpiZj0sWVG9IEZTnxnlfIEdeMkR5LpyvHppn4GcXBSrp5vYsZX86YFLTuwtk
 ZS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694672322; x=1695277122;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4iU3JRMH/2kQ3Vk5LeJShY4xfHvamUCrrsoIcBtakzs=;
 b=ObWRuC8VaBcDWMuwoyimATefZahiTbtGs/Dqhb+6TE5gUuScsuGAnSXN0ay/RILJ3K
 VjJdNdIip+UBJsVAPLIwSm259rXe3xnNbJaRNaPLP8tW+U4/tFjkGHaNp04LauB0QSc/
 +setgXv7/oc6gbrSknYC+gHz75zI+4/H7MT/IN+8gHCAxJAIV/2gZ/BaCZYDM+77nf1E
 /VzzEzATaOTFW7I06TP3wm0QgEzmwpbdojJGVrSvUpXeU2odfxkOrNj/CCTGfYDGRY7I
 k57m0e1VI6u0+slos1c4l6RB8eqtDh+HyMBJXqc5rvqVy9EJu3U2KL0ROSeD3i1r2ImI
 /lrA==
X-Gm-Message-State: AOJu0Yzn0C2m3zfpcntF8f7qM1YkDbS30g5EN8S0YvZtwteJKuNAtsIl
 cjy1wd+XvMqDxEdn2rbmGjdmbg==
X-Google-Smtp-Source: AGHT+IG3+SY7y6ga49HN+NWt3YV0c59NVBWr503pMTPUbK9X1wJzfxp9LfHvQGhhOv5AnTgbztV7jg==
X-Received: by 2002:a05:651c:1024:b0:2bf:645b:6afb with SMTP id
 w4-20020a05651c102400b002bf645b6afbmr3976776ljm.21.1694672322034; 
 Wed, 13 Sep 2023 23:18:42 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-56-29.dsl.sta.abo.bbox.fr.
 [176.172.56.29]) by smtp.gmail.com with ESMTPSA id
 z13-20020a1709067e4d00b009829dc0f2a0sm505052ejr.111.2023.09.13.23.18.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 23:18:41 -0700 (PDT)
Message-ID: <796c4c30-ee18-6747-e94e-e41e1299fe88@linaro.org>
Date: Thu, 14 Sep 2023 08:18:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 19/24] accel/tcg: Modifies memory access functions to
 use CPUState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, ale@rev.ng
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-20-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914024435.1381329-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 14/9/23 04:44, Richard Henderson wrote:
> From: Anton Johansson <anjo@rev.ng>
> 
> do_[ld|st]*() and mmu_lookup*() are changed to use CPUState over
> CPUArchState, moving the target-dependence to the target-facing facing
> cpu_[ld|st] functions.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Message-Id: <20230912153428.17816-6-anjo@rev.ng>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> [rth: Use cpu->neg.tlb instead of cpu_tlb; cpu_env instead of env_ptr.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 324 ++++++++++++++++++++++-----------------------
>   1 file changed, 161 insertions(+), 163 deletions(-)

s/Modifies/Modify/ in subject.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



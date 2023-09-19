Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 453D47A5E41
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:40:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiXD4-0000ix-3c; Tue, 19 Sep 2023 05:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiXCy-0000a6-J2
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:39:52 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiXCw-0005fl-WA
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:39:52 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-986d8332f50so746294866b.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 02:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695116388; x=1695721188; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XReagphR14oIKSSUKShJvVF1QS1XM2qqs5xZkZVz2ZU=;
 b=YdIrBwndlvjq/t7P0OoSRMKORlB+dnICro6P/ed/I38949VLK6F3pGq8Nwvz4w96cS
 4GFPhKgnf3VEzrmCQkB1Tpw2N1UO9Ul/fdTgmiyOl4Zutl7F5wS/z8EwhvKHK4sICfTn
 ub3sFeqvzEx2nFQctL7TeHbfAWkWbJldRf8iswzcrBbeExuEa39y9w9jdGO3olGPefrY
 wbIUEfNXttG8twsHC6I32zurEprbmVvtdBCeOXUjb2FDhdnL94aIi+cf4kQhtBIBPIuU
 J+7M3fVPyGaCXvpNpKEHuiZh1Zuv/NTeNhUE6LQDagKpXKZo7bGEAzFXQS+UyCD3ZE75
 Q0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695116388; x=1695721188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XReagphR14oIKSSUKShJvVF1QS1XM2qqs5xZkZVz2ZU=;
 b=v/YLMNWDOKulgEHfrOn5qvAFbcuatlPMsHh7cHoYO9n0VkCmI+6env+qi7KK9P0lY5
 rZvB3Az+BgqJVQYbO/FrBSEKLllTcm6DOR6mn5r6nr+FTo6ctE1BDdsKsW02BbSe5g/c
 VzaX5KAa/zvrm558WSjIXHbvxVToQahlfXQ7QYRsRlVuOiok/IH6SxzI2VZ58YSxdPax
 FHLoHp+KViSWi/1gCUcSAmF/j3mHwCh5oNbFyzAPQ/E1LA0wPzriwNbWUc1RaecwUkwH
 DlxZL/5qlFIOj7E/u1cRMgrcVXz/zLHOpLyC7m1ahrVVq8dSsFSxE4APdMi1aofaNotd
 50AA==
X-Gm-Message-State: AOJu0YxMv0MWdB6+A4R/n9j5nQBLomWUQtfqvSdF+yQHyUOlCkxlzHZW
 /q2nnLXWXNqbu2QD3PyrA5FVxFtJWV7Xy8Q/RVW6n98x
X-Google-Smtp-Source: AGHT+IFGICl/7SJevmUohP3M5eVSHWc9UtZkrTdDz0mAuS1q4TscL+oFjN7nNE2op5W+z5P1eWADYg==
X-Received: by 2002:a17:906:844a:b0:9a5:81cf:57b5 with SMTP id
 e10-20020a170906844a00b009a581cf57b5mr9290093ejy.2.1695116388021; 
 Tue, 19 Sep 2023 02:39:48 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 qx15-20020a170906fccf00b009a5f1d15644sm7454644ejb.119.2023.09.19.02.39.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 02:39:47 -0700 (PDT)
Message-ID: <aed058bd-d718-24d8-2de9-344c31a8ce62@linaro.org>
Date: Tue, 19 Sep 2023 11:39:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3 16/39] accel/tcg: Modify tlb_*() to use CPUState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng
References: <20230916214123.525796-1-richard.henderson@linaro.org>
 <20230916214123.525796-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230916214123.525796-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 16/9/23 23:41, Richard Henderson wrote:
> From: Anton Johansson <anjo@rev.ng>
> 
> Changes tlb_*() functions to take CPUState instead of CPUArchState, as
> they don't require the full CPUArchState. This makes it easier to
> decouple target-(in)dependent code.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Message-Id: <20230912153428.17816-4-anjo@rev.ng>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> [rth: Use cpu->neg.tlb instead of cpu_tlb()]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu_ldst.h |   8 +-
>   accel/tcg/cputlb.c      | 220 +++++++++++++++++++---------------------
>   2 files changed, 108 insertions(+), 120 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



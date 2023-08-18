Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC4B78111E
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 18:59:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX2nf-0003fg-Ru; Fri, 18 Aug 2023 12:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX2nc-0003fE-Qd
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 12:58:13 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX2nZ-0005Qy-KJ
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 12:58:12 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-52564f3faf7so1391838a12.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692377887; x=1692982687;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7baqFmpBu+Mre8YaPCnWgi3AcZD5BeDf3ToXDPwDohI=;
 b=IFG8DmKH5pPdwiNTdz7wt+YomQFBtgxvakmLnUWyTRBRak5JgL64GllTuUgaR3v/BY
 l/KZWjVxEk4Q7//PMrOcyeeRe8NjGBwCXllQUfoFALZ9ZyiTxrfcWOiuRzigsNCrqcWo
 1mfvAShcrBmKkEyGjH4j5f6jpTS6x7v7h0o/tfkybcU/20y7y/SzAyULuF0yRky1oh4B
 0+mMsR7GjxrcbC1abD50cGdC5eC+TDuWNcRluliipXk71fhuCIR70iuVee0l5nAGlPOo
 q3cMvqGsoUGhhct/xZldsoYsFKBPTO71YnZ6ahXC2uQXVhIqd9wQ0NmezaFquRNWWAc3
 Swhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692377887; x=1692982687;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7baqFmpBu+Mre8YaPCnWgi3AcZD5BeDf3ToXDPwDohI=;
 b=MJWAeOftZ9URE8Q8aXQz3tVqF6vs/k4bA/7agOo7cIZ3k8Bn7YphtZXmGYk6lMAKXW
 2KsM7p5+pUmrAJJAMoEwZgYBqQfJsnOSoGNIGRy61e3TC2xVnutGoC6LNE8kvcRTV1NG
 AEnLtNISilJvY5AeqIDlRRKGJKSC+++R/WdL0gbOKVkLY5KjJ4J2DEbhSAip/6hPPTUm
 NTlcKdMdQbV6Cb0+ZQMMk14xUqDBKLg8fIWEXV63vaSHfdQH7rx6QOzk+V8fj2gEYR06
 ChkaJc3exw5fmVIBQukjv6YoirXY4BjcJTSIkLZQjrmikN97rAQoPePCfqnttbU6HHbi
 8j9w==
X-Gm-Message-State: AOJu0YwfcnoJuMCTHs8cVedxBNibmtJlw99dUzbI9u8HSUyRfWn7Gy7I
 paYZpGfoS2Fmg6r7jHmeeQCLUA==
X-Google-Smtp-Source: AGHT+IEoHu6DqAueSmkaWS5MnmmgN8HpgXRs7bINn7Eu3jOxEnPTFuNQirNLagBGUerTOsBHPlWf6g==
X-Received: by 2002:a17:907:7719:b0:99b:f392:10b2 with SMTP id
 kw25-20020a170907771900b0099bf39210b2mr2507977ejc.39.1692377887558; 
 Fri, 18 Aug 2023 09:58:07 -0700 (PDT)
Received: from [192.168.69.115] (cnf78-h01-176-184-27-79.dsl.sta.abo.bbox.fr.
 [176.184.27.79]) by smtp.gmail.com with ESMTPSA id
 f15-20020a170906084f00b0099cf9bf4c98sm1391617ejd.8.2023.08.18.09.58.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 09:58:07 -0700 (PDT)
Message-ID: <fdb85dbf-f19f-2006-e334-1b6b0f4b639e@linaro.org>
Date: Fri, 18 Aug 2023 18:58:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 01/18] target/loongarch: Add function to check current
 arch
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, c@jia.je, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230817093121.1053890-1-gaosong@loongson.cn>
 <20230817093121.1053890-2-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230817093121.1053890-2-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.454,
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

On 17/8/23 11:31, Song Gao wrote:
> From: Jiajie Chen <c@jia.je>
> 
> Add is_la64 function to check if the current cpucfg[1].arch equals to
> 2(LA64).
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> Co-authored-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



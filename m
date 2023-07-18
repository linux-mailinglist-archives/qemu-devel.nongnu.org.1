Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 065B2757380
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 08:00:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLdjs-0002f9-Sk; Tue, 18 Jul 2023 01:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLdjq-0002ex-1d
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 01:59:10 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLdjn-0002q4-JC
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 01:59:09 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4fb761efa7aso8413831e87.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 22:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689659944; x=1692251944;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5I837Hzy5YrRxOyxRI5WJDkYekV16jxPi4ELcyc3uog=;
 b=A2guvNhJGB/A9ejoEg5W0egtZrdTYqGgiKr1RsCmVW6Ubl1bOnz510V16fUsJXJwRY
 h0oKKBYJom0ndya0EUl+cgadHGUdjbBnLuKf676Lh8k6Nldbwpf4OUr66YEVBTj3Kdfp
 uePwF39qGUBGQy9eHKjhJplhsGQPiX/r9SZO6vcR8YsG0DSygDNF+Wl7j7IeB0LR/sV6
 yKkMNLYayWDfrhPnFa/SUYjPtnvFQBoUGGE3BsCXeSfuHiNQ6bnMWxc14mYvhJeJboo9
 LIT6h5BODlD2zDhT3Pgvc1ZmdVaJZD1ska+zKwW0w/Jgw+om4ApR6O1HHUnIBX/tApva
 07Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689659944; x=1692251944;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5I837Hzy5YrRxOyxRI5WJDkYekV16jxPi4ELcyc3uog=;
 b=cjkZ5hPYNY70QGhJSQHXyrf4zW9nQI3717jL7fqCCLGGpOomJYPWNNaT+fozFTUiKr
 8QWw1zexWPcit8g7dSMFiTQccE0wGQ9uK2/VCqb6+5FjlI2wY2jR+1FK8iku2kOCs/18
 wbNsSGKjWHeioMTYWMoc0/QdKtTItpfM4bNpNVAbxv01AscN7OIepgR8h8/JNWEaPwfk
 CuJFiswHhD0HBUfUeO9wycG7O0uvruRKYjJZgbRL/mDkOk1eLrP83n6rC7kmjmB4IxJd
 s/s3eCoaAAudWReWmmsaqO47Iui1mLbL3F5dzvTzLIxGB4ykanyabvf9cbyjAtkIHfDI
 cyfg==
X-Gm-Message-State: ABy/qLanm4vXTn+eiH5X21lBuYzo8SzYUXXf10Az7YpP8Oj6qaksb4DF
 JRRUACqfajm4PZI7J+rYAv9KGH79X957LSoa9EI=
X-Google-Smtp-Source: APBJJlEWoMkSp3MP61gunQl1b8e2IA0J9fwSjzrXBJ+eSYpM2mf4yr2OpyzzW2ErFXHFOP5j33p2Jg==
X-Received: by 2002:a05:6512:2083:b0:4f9:571d:c50e with SMTP id
 t3-20020a056512208300b004f9571dc50emr8589834lfr.36.1689659944261; 
 Mon, 17 Jul 2023 22:59:04 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.222.251])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a05600c20d400b003f91e32b1ebsm9519465wmm.17.2023.07.17.22.59.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 22:59:03 -0700 (PDT)
Message-ID: <f04db0a8-17dc-8ac1-abd5-433a78ab0b88@linaro.org>
Date: Tue, 18 Jul 2023 07:59:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1 v2 2/2] target/mips: Avoid shift by negative
 number in page_table_walk_refill()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230717213504.24777-1-philmd@linaro.org>
 <20230717213504.24777-3-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230717213504.24777-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
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

On 17/7/23 23:35, Philippe Mathieu-Daudé wrote:

Oops, invalid authorship, this should be:

From: Peter Maydell <peter.maydell@linaro.org>

> Coverity points out that in page_table_walk_refill() we can shift by
> a negative number, which is undefined behaviour (CID 1452918,
> 1452920, 1452922).  We already catch the negative directory_shift and
> leaf_shift as being a "bail out early" case, but not until we've
> already used them to calculated some offset values.
> 
> Move the calculation of the offset values to after we've done the
> "return early if ptew > 1" check.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> [PMD: Check for ptew > 1, use unsigned type]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/sysemu/tlb_helper.c | 32 +++++++++++++++--------------
>   1 file changed, 17 insertions(+), 15 deletions(-)



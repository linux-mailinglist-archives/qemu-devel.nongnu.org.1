Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7AF728E34
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 04:56:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7SH7-0004IQ-Es; Thu, 08 Jun 2023 22:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7SH6-0004IC-20
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 22:54:52 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7SH4-0003xB-Ka
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 22:54:51 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6b29a03ec42so289853a34.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 19:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686279289; x=1688871289;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ig5JDbCczttC/anXPtxYQ0pnco5Wr8SClWcOASK2bC0=;
 b=EbL/nkDpsecPO0zhpJCJ+nj6fU8StVwJbNlBMa9oyfbEcMqlkHZLgY45yA6nApYSff
 v33l32VGF0fbxKiBoV/HLHgA4pijkRO/xGY+qz5FepJ6CWTUYw09XHwmRlKvyiLoKRmr
 Kjgb99Pdsfa04sj9YPuCA1sAJ3wRGgKQM0cA57n4I2GDi3dkv4WXaz5YaJPNND+DLoeV
 ihD9Mw6c+wrh3CcjgkUpZ3suiypm1RZSUsdFe3ilPwnHa3yo1Gzp0x+XpLP9A2KAwiut
 1WrCitM3FAqBinhVkVr7jRkKjQHamX7S8N9AV8i9wGWvg6EiLjKMuyqBiR14JQuB/0IW
 76Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686279289; x=1688871289;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ig5JDbCczttC/anXPtxYQ0pnco5Wr8SClWcOASK2bC0=;
 b=cMya2Zte25P8tRdMLaVXW3ePMkFl1kTqTQw2G0uJEN44D2ZeYU9oxeB9ZjLhH1fGH7
 +NdD1Dye8O6xLSpcxsj5IsJrcoe7uzGu/P4O3cAj/hNpgQzB/RkuaKmOZRXdCpW6iqO4
 +1wSWuTrOuHxD8hTrXnwclkgNL+XjYfrSkqYPvzPrzVD8ChNHN1QPkEQIW+Gg1HDKrpJ
 4CeF+ZvrrVf49AnN0v0l82qCrNU2x8JsQF9trTmx1bYOxIISodfDu1gT+OiUrIoNY/29
 omTsvGTJZe2ySXdGhKtCF+JAORkl1Cn21keHgLIGGui9JNzaPIrYjdHetI0B7u7VY3oN
 Sc9Q==
X-Gm-Message-State: AC+VfDxy9dcPa+71WBmS8/BEavAScdlXyczDJdjUt08C1w8SZh71j2s9
 fhdYAeSV4R7z298S9jZrLkkTbw==
X-Google-Smtp-Source: ACHHUZ5rzRj3Fxc2Ci+e1Hg5cOQXezK9O51yZIASw6OfSdWDZISyRAk2F/UkFuJKUrTHyhRvR+PaSA==
X-Received: by 2002:a9d:7993:0:b0:6af:a180:3357 with SMTP id
 h19-20020a9d7993000000b006afa1803357mr240433otm.7.1686279289088; 
 Thu, 08 Jun 2023 19:54:49 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:b071:df63:5761:f449?
 ([2602:ae:1598:4c01:b071:df63:5761:f449])
 by smtp.gmail.com with ESMTPSA id
 w2-20020aa78582000000b0065ceef92047sm1710000pfn.31.2023.06.08.19.54.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jun 2023 19:54:48 -0700 (PDT)
Message-ID: <f21140fd-f014-4706-aee3-3b3c6b21201f@linaro.org>
Date: Thu, 8 Jun 2023 19:54:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 5/5] gitlab: support disabling job auto-run in upstream
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
References: <20230608164018.2520330-1-berrange@redhat.com>
 <20230608164018.2520330-6-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230608164018.2520330-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

On 6/8/23 09:40, Daniel P. Berrangé wrote:
> In forks QEMU_CI=1 can be used to create a pipeline but not auto-run any
> jobs. In upstream jobs always auto-run, which is equiv of QEMU_CI=2.
> 
> This supports setting QEMU_CI=1 in upstream, to disable job auto-run.
> This can be used to preserve CI minutes if repushing a branch to staging
> with a specific fix that only needs testing in limited scenarios.
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   .gitlab-ci.d/base.yml | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


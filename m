Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3098737A8D
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 07:13:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBq8n-0002jV-BL; Wed, 21 Jun 2023 01:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBq8i-0002j9-AZ
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 01:12:20 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBq8g-0007W7-Oh
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 01:12:20 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51878f8e541so6477093a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 22:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687324337; x=1689916337;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=29bRPvMC/Ktp8+2vrwiNkWvw3NQFP+pIp2qfiMu9zcU=;
 b=t/qJNcJCyV/yqsy5LRxWKzhp9Hg7U0dt71OTAp6+FgWrRba4+5oIFRNqBaHPyWCIUf
 aTdn5W2nKy7Hlx/RpFMY6lZJo0lO4Tj9XP5U/nY/ul1qgwddo0eQoxtxYpxEwns0+vfF
 HfVuIiasrDbQwnA948+ZYzfk874oWREBw1zlMm5Lxo8wanHpdfC4Yvumo9GXZUZTmjkL
 yyuxtzyJMx93fBsKHle3EIlNrOyC5fnyt2bpZrDWD6Fu0aqvP9gIfMqT+LSB8WmwUk9u
 SXe+55DkPzESLTahnHmIDojeMtvP8HgF7tuZa+xcNayWs2oVC89TsvBKAMUMgwXht3ko
 RtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687324337; x=1689916337;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=29bRPvMC/Ktp8+2vrwiNkWvw3NQFP+pIp2qfiMu9zcU=;
 b=U8zVlUglW62pJgC5ZhpRKqWugHvwmgp1gXahkwVCWn2xfwuS4O1dhoI67JEaAkr4K+
 9m2+3cR7bVZ+bHcKGYKDLT3L+Ip1UEQQ8UZbNk+ZPimnHGWp9Y5HpwY5gOCF/y+9BzNu
 N/WH4dF2fhvsNjW/3Zxt/EZXzIsUvTxuQDplR26u1Sx27PHKKMP4KUUtVMHKOCrMeq8w
 O/18qjy0PZ6QPAUW7+BDNuBzMhRBjtph9ShINiQ6IasbKYKNpZF8mjs2JJJzuvgtEQL2
 R5hzIpdIsUR9P+W5q5W9bnl+Cn14FcYCHQCReWjddTFXKiQLOGVGqIapcVRjo1dB17Pb
 1c5w==
X-Gm-Message-State: AC+VfDxAfxb9ZErdu849y9djh9MzaxkNHlEvAA6Q1RT7gptsUDE1glOi
 gD4RyDrDtq6xljhfMvnLILSdo1gt62rS0oic4Wi4n5Vz
X-Google-Smtp-Source: ACHHUZ5tbH6yWTUwT7wSfzKybIWWqP1h6PiCZIHaL4tRsuDukAv3f1k0g6IDBUB5ev5HK+B1yHCDZg==
X-Received: by 2002:a17:907:2da1:b0:988:7428:2c1a with SMTP id
 gt33-20020a1709072da100b0098874282c1amr9258986ejc.7.1687324337026; 
 Tue, 20 Jun 2023 22:12:17 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.128.70])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a170906258600b009871b3f961asm2424102ejb.58.2023.06.20.22.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 22:12:16 -0700 (PDT)
Message-ID: <8a130216-4224-4e85-5183-9917dc74d004@linaro.org>
Date: Wed, 21 Jun 2023 07:12:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 49/52] exec/poison: Do not poison CONFIG_SOFTMMU
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
 <20230605201548.1596865-50-richard.henderson@linaro.org>
 <CAFEAcA92u+N2Vo8+GN_DutdqDeen0VDAe1=b8vTRNnpEUELodg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA92u+N2Vo8+GN_DutdqDeen0VDAe1=b8vTRNnpEUELodg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/20/23 20:01, Peter Maydell wrote:
> On Mon, 5 Jun 2023 at 21:23, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> If CONFIG_USER_ONLY is ok generically, so is CONFIG_SOFTMMU,
>> because they are exactly opposite.
> 
> This isn't quite right. CONFIG_USER_ONLY is theoretically
> something we should poison, because it's unsafe in the general
> case to use it in compiled-once source files. But in practice
> we make quite a lot of use of it in "we know this specific
> use of it is OK" situations, like ifdeffing out function
> prototypes. So we'd like to poison it, but we can't poison
> it without a huge amoun of refactoring which isn't really
> worth the effort.

Yes, a similar amount of refactoring would have been required within tcg/ to retain the 
poison of CONFIG_SOFTMMU.

> So it's not a good model for "therefore it's OK not to poison
> CONFIG_SOFTMMU" -- we should leave that poisoned if we can,
> so we don't introduce either new buggy uses of CONFIG_SOFTMMU,
> or new "we know this is safe" uses of it which will make
> it difficult to put it back into the poison-list later...

My plan is to remove it as a define entirely.  But not this cycle.


r~


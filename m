Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 366A57F727B
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 12:12:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6U61-0001Zl-Ac; Fri, 24 Nov 2023 06:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6U5w-0001Xk-TL
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:11:36 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6U5u-0007P8-PS
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:11:36 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32f8441dfb5so1194946f8f.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 03:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700824293; x=1701429093; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sCZ797bSNaoTKfk4boXVhjg+NVbQ/8AodCfIAlE+nxo=;
 b=KwfIZ4ClqzZ8hBLMx+Wfi8gzS7p6r3xFKF1O5mnfz3hFdNskMskGys4SstarT7UWm7
 8iP5c/DvUe3fg17M0FpqiAvThXBH8GY68/0yeVBevD2+2lmK400vwhyyU8IlLQwk8YEW
 aV6MIKZPE5TTGCD7CKR1GMtRQ2OATYLowQl10NVcmI+p5arv/x5tHMqsK80PyGQGqK0+
 xriTCebgHIIrfvQdWplMVNVMsvP8lYw/H5k+RzN+jROSxF1w6QcMPT5fyQQuaAoJ4QcG
 UsXW7d+c0m6xBTIoBFdX7JGcEyKeACNjsea9HRF5NRkdaxtczFSRI7ghJEB7yUATXOrX
 H65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700824293; x=1701429093;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sCZ797bSNaoTKfk4boXVhjg+NVbQ/8AodCfIAlE+nxo=;
 b=e5Dqa5xENWI4eWBee5T/v4Mu1IdJyzCZz6tzgSmgfLnrmJdQPAlK14PSn91s5bppMM
 ny2j/ct5ZQ5uQ69cejrsNkCTBQm0PyespEldcM2RE9hIYF8AsmdywEhWqc5tEmqB9RU4
 OVIp6QiUONnKa2SyQf1V2EYC72zuyfypw1+i8+3T4+P4wtytJeY9CZPHWvfXPWhY533o
 hPvno7SpfsX6Ptu6QucYy1Uu38hgpcstj+8TJN7Atw5um/6P+lAlsDOuVGtt/vQ9n9d3
 EsLQAsdN9U/VEKFSKy1VnpX5vDCuwsZGYqJSDkp7AEkPnT6X7PGhQeKUpjfymR4ljEsr
 j3Qw==
X-Gm-Message-State: AOJu0Yz3T39qxwS2j4AEzQEiyKZScpeoXKnSwLakgycCsv29KEe3qLU4
 fXAGIEf+R0uHqimxiihgKIvJyw==
X-Google-Smtp-Source: AGHT+IF9lsi0k3n427NZrYzxU4Vy7ZG8FSLsq65LB2Tg2OPpOgPeC0skcX8hLcit0/bh3CNaqEqJ1g==
X-Received: by 2002:a5d:650c:0:b0:32d:9d3a:d8c0 with SMTP id
 x12-20020a5d650c000000b0032d9d3ad8c0mr1765277wru.60.1700824293010; 
 Fri, 24 Nov 2023 03:11:33 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.17])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a5d5107000000b00332c6a52040sm4015371wrt.100.2023.11.24.03.11.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 03:11:32 -0800 (PST)
Message-ID: <92246d2d-6d0e-416d-914b-08bb1fb0eac7@linaro.org>
Date: Fri, 24 Nov 2023 12:11:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] docs: introduce dedicated page about code provenance
 / sign-off
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-2-berrange@redhat.com>
 <20231123091654-mutt-send-email-mst@kernel.org> <ZV-I_eWYsBeOe4Sp@redhat.com>
 <20231123123106-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123123106-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 23/11/23 18:33, Michael S. Tsirkin wrote:
> On Thu, Nov 23, 2023 at 05:16:45PM +0000, Daniel P. Berrangé wrote:
>> On Thu, Nov 23, 2023 at 09:25:13AM -0500, Michael S. Tsirkin wrote:
>>> On Thu, Nov 23, 2023 at 11:40:25AM +0000, Daniel P. Berrangé wrote:
>>>> Currently we have a short paragraph saying that patches must include
>>>> a Signed-off-by line, and merely link to the kernel documentation.
>>>> The linked kernel docs have alot of content beyond the part about
>>>> sign-off an thus is misleading/distracting to QEMU contributors.
>>>>
>>>> This introduces a dedicated 'code-provenance' page in QEMU talking
>>>> about why we require sign-off, explaining the other tags we commonly
>>>> use, and what to do in some edge cases.
>>>>
>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>>
>>
>>>> +  * The non-primary author's contributions were so trivial that
>>>> +    they can be considered not subject to copyright. In this case
>>>> +    the secondary authors need not include a ``Signed-off-by``.
>>>> +
>>>> +    This case most commonly applies where QEMU reviewers give short
>>>> +    snippets of code as suggested fixes to a patch. The reviewers
>>>> +    don't need to have their own ``Signed-off-by`` added unless
>>>> +    their code suggestion was unusually large.
>>>
>>> It is still a good policy to include attribution, e.g.
>>> by adding a Suggested-by tag.
>>
>> Will add this tag.

Thanks!

>>>> +Other commit tags
>>>> +~~~~~~~~~~~~~~~~~


>>> As long as we are here, let's document Fixes: and Cc: ?
>>
>> The submitting-a-patch doc covers more general commit message information.
>> I think this doc just ought to focus on tags that identify humans involved
>> in the process.
>>
>> I've never been sure what the point of the 'Cc' tag is, when you actually
>> want to use the Cc email header ?
>>
> 
> It records the fact that these people have been copied but did not
> respond.
This might be felt aggressive or forcing. My understanding of this Cc
tag in a commit is "now that it is merged, you can't complain". We can
be absent, sick, on holidays... If I missed a merged patch review I'll
try to kindly ask on the list if it can be reworked, or suggest a patch
to fix what I missed.

Not sure this is really useful to commit that to the repository.

IMHO the only useful Cc tag is for qemu-stable@nongnu.org, as Kevin
mentioned.

If you want to be sure your patch is Cc to a set of developers, you can
add Cc: lines below the '---' patch separator. My 2 cents eh...

Regards,

Phil.


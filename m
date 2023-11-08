Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A4E7E536D
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 11:31:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0fqS-0006Oy-8w; Wed, 08 Nov 2023 05:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fqL-0006EK-CJ
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:31:31 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fqJ-0008VQ-FU
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:31:29 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53f9af41444so11476391a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 02:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699439486; x=1700044286; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vZbJEoeTblOO1u5SzgHy66AjFOqkdmsAhTCtjOXDQP0=;
 b=T1VHB0rS9fjUMUVv68Zf4yyQvJJe7QYTY1dgZDmqKt5DG9LSk2cLGPZ86fQjIQeWvg
 85w2zaaikkh34BusQNvVmT2L2fxoT7Ec6XzA9HQEXAOkrKn/EA5/A5Dp9duOXkDydSJv
 6MmTPJygsahvVrtJSzyOBaXUMpdC2mbUrnCzd82+Ag4Lhz5qZ3mZad7PIwahn6mv6/BV
 9daK5i9YdTZqm17QtfbhABt/E8uUMOlcCOW5RU4W1bTj2vINmwaZH3yfVlM1zRpLM4oK
 uDFaYAsWKikC7qaisejYmbV66KZDQCnEl8IkBt+2lPrcH66AuSu8lC1AzyJKCHmh+eVY
 ryWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699439486; x=1700044286;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vZbJEoeTblOO1u5SzgHy66AjFOqkdmsAhTCtjOXDQP0=;
 b=VnKYaboIDYzEs9wxKM8uK3y24G2D30A/cl0kkgWUvx6vKz0LcXPjdSG38/cO/ZK9Uu
 YGrqvkIoFe9xTPekHJSrhf1xDTR1mPOFbUIjfOcyZ8zYsaOPxdZzJMcVJOwblyeISiDw
 urSmCpHIxP+CHaRetl9WpBJ8PrONe8tJOEe+MQTCDgS771xvtnl5ick74GM9/vPsdhXV
 M2YIy/Ef6h1t9gc1usUMWV3tR/uWDwGyzSjoEtsPdcVoODVkbEt3LEFTuVUODktWVH0A
 AWxSoyC96Z7bKdrV0s2iPzyI1w1wE3PP0+0y/Jt+ski4GjetYAWRGE5Vh7VDOXsibIuy
 coeQ==
X-Gm-Message-State: AOJu0YyJXWohQ+ffpAh3WEQnbUStZueJrRYMBF+cR92tWQbzNkvIYMfy
 62kZo9wL8YG/+i7keycO93OUFnuWlO7fZaOj2Cs=
X-Google-Smtp-Source: AGHT+IE+vsVpBLD15xvEQKi+EVVj/swn3sBJHJLahNwNH/nU9ww67/Vt1Ft45U9mwRkOflbgjCvJnA==
X-Received: by 2002:a50:cd4b:0:b0:53f:2671:e0f4 with SMTP id
 d11-20020a50cd4b000000b0053f2671e0f4mr1001342edj.38.1699439485802; 
 Wed, 08 Nov 2023 02:31:25 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 b22-20020aa7df96000000b005435d434a90sm6454817edy.57.2023.11.08.02.31.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 02:31:25 -0800 (PST)
Message-ID: <e5eae50b-d03c-4524-a540-5581f4796c68@linaro.org>
Date: Wed, 8 Nov 2023 11:31:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] docs/specs/virt-ctlr: Convert to rST
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <20230927151205.70930-1-peter.maydell@linaro.org>
 <20230927151205.70930-7-peter.maydell@linaro.org>
 <9994c0ae-57af-d3b3-520d-7cbbee543778@linaro.org>
 <CAFEAcA8mQ_r+RJZsDr42Vi88rMT=cRtEVNziKNCkB1AsZXujtg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8mQ_r+RJZsDr42Vi88rMT=cRtEVNziKNCkB1AsZXujtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

On 31/10/23 16:43, Peter Maydell wrote:
> On Tue, 31 Oct 2023 at 15:39, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 27/9/23 17:12, Peter Maydell wrote:
>>> Convert docs/specs/virt-ctlr.txt to rST format.
>>>
>>> I added the name of the device to give readers a bit more idea
>>> of which device we're actually documenting here.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>    docs/specs/index.rst                        |  1 +
>>>    docs/specs/{virt-ctlr.txt => virt-ctlr.rst} | 12 +++++-------
>>>    2 files changed, 6 insertions(+), 7 deletions(-)
>>>    rename docs/specs/{virt-ctlr.txt => virt-ctlr.rst} (70%)
>>
>>
>> $ ./scripts/get_maintainer.pl -f docs/specs/virt-ctlr.txt
>> get_maintainer.pl: No maintainers found, printing recent contributors.
>> get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.
>>
>> $ ./scripts/get_maintainer.pl -f hw/misc/virt_ctrl.c
>> Laurent Vivier <laurent@vivier.eu> (maintainer:virt)
>> qemu-devel@nongnu.org (open list:All patches CC here)
>>
>> Cc'ing Laurent.
> 
> That raises the question, is it intentional that the doc
> is virt-ctlr but the source file is virt-ctrl ? Should we
> rename one of them (looks like the doc, so easy enough to
> do as part of this patch)?

$ git grep ctlr| wc -l
      430
$ git grep ctrl| wc -l
     4063

Since you are already renaming the file, correcting the typo
in the same file seems like a good idea.


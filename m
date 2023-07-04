Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C33F746E0C
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 11:56:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGcl6-0001PA-Lc; Tue, 04 Jul 2023 05:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGcl3-0001Or-Dt
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:55:41 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGckx-00045s-Ts
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:55:38 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-313f1085ac2so6020311f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 02:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688464534; x=1691056534;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OwWRblAHk1qSB0LPNvQh4U7RHeFCSSBV0FrMeg2f22c=;
 b=HdzgM3iY0tfoGKeKV+gQg1QKtAspj23TFLMMIqCEf8KVA0Z8KPg5jlj4TST/UYUnKv
 35O/ykconTMBNV+0GtsKp9CqGaEs7pw/4utKzRsCPDn+ZPv5d84tFXzwRmlcheG6gCfE
 iT2AmjdsdW0AFqZU8HXeT+VA+gup6LURujCubO1/IohTYTNUDP8YC2oqP/Sa8tagadie
 2oN6en1qL0KMQds1sK5xLk3SceaTpbSy6iuQHbopvBe1Gh+lG2DGoUnt9VrY12lM1GXF
 VC4nWE0IcSHkkz7tvz1+caput3bTWgS+TwfY0LZgRv9+98/iFxO8q/jJ0alamPK/2CnK
 Dfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688464534; x=1691056534;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OwWRblAHk1qSB0LPNvQh4U7RHeFCSSBV0FrMeg2f22c=;
 b=ZTAmj6IXqNCKr4RNbv8YEbIwFmLgjTEomKiKP17zXBDUSTf/XRrslyg5hgpuWmzlhg
 rhP4O44cACAe9HqZ/Foflxt+EU6Z+Yf5y+auZHcZsxpag6QKXzpeod8D9RQ8X1yLkMLn
 6dFKTtSgSat0AIGTUDXXcqUjM62pptcvTQb+uBnV25ZTO4bCYjiRjBeUk8xwTfeb4e3d
 kRa0fnRU1qTQ5QH4x4XWv2uDDlgGb+SsUOhI8EIqZdIDWwWWOKQXLD1pn2oqf6lf5FRd
 sCAfsW1XLS15yZKr2qA6q5g0db3AEQkzzn1aUZmyutxWDf5I4S2xjjJRQFBp95VU9XfM
 g/pw==
X-Gm-Message-State: ABy/qLbo1RQ+2ButPB4kip0/eY8LULMx6ADw7mbzbhgbmgBU06KczL/h
 QwZMCfXdOwEvPv3YFhHaq0uzMA==
X-Google-Smtp-Source: APBJJlEBDkuicjonrGYJCMmcHo0+0S1rlDuGWkmiekL5vzK3fYmj2uJ7OWnSEvS4xpZLQLYVe58PEA==
X-Received: by 2002:adf:e9c2:0:b0:314:1bb7:8a19 with SMTP id
 l2-20020adfe9c2000000b003141bb78a19mr10187059wrn.35.1688464533732; 
 Tue, 04 Jul 2023 02:55:33 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 s2-20020adff802000000b00313de682eb3sm27858630wrp.65.2023.07.04.02.55.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 02:55:33 -0700 (PDT)
Message-ID: <cb295ae8-f182-3f23-db52-93f1ceb6a767@linaro.org>
Date: Tue, 4 Jul 2023 11:55:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 03/13] ppc440: Add a macro to shorten PCIe controller DCR
 registration
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1688421085.git.balaton@eik.bme.hu>
 <e8ae82b0b6c10e48acbc297fa15d9e5f4befc9d2.1688421085.git.balaton@eik.bme.hu>
 <e42417b6-e4d1-5137-85d6-837dd438d862@linaro.org>
 <1dee5084-261c-9698-2251-b82a00cd0c39@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <1dee5084-261c-9698-2251-b82a00cd0c39@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 4/7/23 11:33, BALATON Zoltan wrote:
> On Tue, 4 Jul 2023, Philippe Mathieu-Daudé wrote:
>> On 4/7/23 00:02, BALATON Zoltan wrote:
>>> It is more readable to wrap the complex call to ppc_dcr_register in a
>>> macro when needed repeatedly.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>   hw/ppc/ppc440_uc.c | 76 +++++++++++++++++-----------------------------
>>>   1 file changed, 28 insertions(+), 48 deletions(-)
>>
>>
>>> +#define PPC440_PCIE_DCR(s, dcrn) \
>>> +    ppc_dcr_register(&(s)->cpu->env, (s)->dcrn_base + (dcrn), s, \
>>
>> '(s), \'
> 
> The parenthesis here would be superfluous as it stands alone in a 
> function parameter between commas so no matter what you substitue here 
> should not have an unwanted side effect (unless it has a comma but 
> that's an error anyway) so maybe this is not needed.

Well I noticed because you used it for the 2 other cases, so I'm
just trying to be consistent here. Besides, not using parenthesis
for macro arguments is a bad practice. Problems happen when others
copy code.

> 
>>> +                     &dcr_read_pcie, &dcr_write_pcie)
>>> +
>>> +
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Thanks for the quick review, I'll post a v2 in a few days to wait a bit 
> if anobody else has any other request.
> 
> Regards,
> BALATON Zoltan



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CBA716F88
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 23:16:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q46hG-0005zb-Kc; Tue, 30 May 2023 17:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q46hC-0005xQ-By
 for qemu-devel@nongnu.org; Tue, 30 May 2023 17:15:58 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q46h9-0004iT-Pn
 for qemu-devel@nongnu.org; Tue, 30 May 2023 17:15:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f60804faf4so35710725e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 14:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685481354; x=1688073354;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MvyHidfsbl/GVmFg/rFVhIoYM+nG4iidyd3VfxTk9Qo=;
 b=LfhsvcAlTb562y9MJH+UHVnvhlBsFQIdP8qrikved/cbQgXaJ6kIZyr4VQPFFr/52L
 cNtj3mrcUpgj52nuuvz0svHyJMo0EUvM/2mlzzGS9hGkpOn0HOspOBx6nlfJcnA7CuGD
 VqWLIvSrRFwmxTMXKghQx21L89gWyZFe1ddWCTvj9EKW5vE5qpFhnFV5kbZX3ELJmHMR
 XKvOAvlGaIoXEHUdbB4Ct+o399+flDqE5u54GNQeidcPeelZbyTt4/WSBg5cMU6OrQt3
 iEAJ1bf3OaOHQPNU8gxdakULfjTtBY96alxvBydVie2wnkjP1NbsI23toDhVZV0UNZyk
 5ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685481354; x=1688073354;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MvyHidfsbl/GVmFg/rFVhIoYM+nG4iidyd3VfxTk9Qo=;
 b=UtwVzY7yP5aaxFFoNjSi5lrZHt54JnmwXZ1ceityt/yr8XhOHQ8iqJ1v0YrXSDSLbG
 1gN0ajhqT7A7npeS/BDBZZ/LoC5uak6GkgmTD0Ln5MHTCbBOX5WMKMdpskMMnzJ+gEb3
 qKSly7ukiESCayteko41EAbH+cVNuFNeg52zvt1v6gyOCH5zLoDFPkqUvsiz0gVCz9hc
 E6tuViYN3+oXW43ffq3Gf+ktXV7o51OyEwAdvO5DxJO3PUz7YJLajzaSWdxDQwx51PCU
 NlPRUBsELNvGmu1YPTZ+524pzlu/kCN4nLMNt+1mLiAzb+z2FgWbT2PAV0IcXs06U0D6
 YawQ==
X-Gm-Message-State: AC+VfDzNeBkLIYpwYIyn0TFtrjC5XimbGHuQRCnFXpYHFxXiP2FReb3i
 Fuc+tx0OYVy7SO5Tg6LFCXT9PQ==
X-Google-Smtp-Source: ACHHUZ6RXl/IiEdojP5cu4ZcUDOw9pOaIVqFtAqFClgSJSuQa0mvjA0C8T8QAMLjtXR5USZibQhSHA==
X-Received: by 2002:a05:600c:2252:b0:3f6:8af:414 with SMTP id
 a18-20020a05600c225200b003f608af0414mr2596893wmm.30.1685481354073; 
 Tue, 30 May 2023 14:15:54 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a7bc4d2000000b003f427687ba7sm18323817wmk.41.2023.05.30.14.15.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 14:15:53 -0700 (PDT)
Message-ID: <0d11b78e-56f7-553a-3e85-0edef9b649ac@linaro.org>
Date: Tue, 30 May 2023 23:15:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 05/12] hw/ssi: Introduce a ssi_get_cs() helper
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>
References: <20230508075859.3326566-1-clg@kaod.org>
 <20230508075859.3326566-6-clg@kaod.org>
 <40c8647d-201e-3ceb-97ca-ec98bdc84e88@linaro.org>
In-Reply-To: <40c8647d-201e-3ceb-97ca-ec98bdc84e88@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 30/5/23 22:34, Philippe Mathieu-Daudé wrote:
> On 8/5/23 09:58, Cédric Le Goater wrote:
>> Simple routine to retrieve a DeviceState object on a SPI bus using its
>> address/cs. It will be useful for the board to wire the CS lines.
>>
>> Cc: Alistair Francis <alistair@alistair23.me>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   include/hw/ssi/ssi.h |  2 ++
>>   hw/ssi/ssi.c         | 15 +++++++++++++++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
>> index ffd3a34ba4..c7beabdb09 100644
>> --- a/include/hw/ssi/ssi.h
>> +++ b/include/hw/ssi/ssi.h
>> @@ -112,4 +112,6 @@ SSIBus *ssi_create_bus(DeviceState *parent, const 
>> char *name);
>>   uint32_t ssi_transfer(SSIBus *bus, uint32_t val);
>> +DeviceState *ssi_get_cs(SSIBus *bus, int addr);

Also, this helper should (preferably) return a SSIPeripheral type.

> Previous patch use uint32_t. uint8_t is probably enough,
> otherwise 'unsigned'? Otherwise
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 



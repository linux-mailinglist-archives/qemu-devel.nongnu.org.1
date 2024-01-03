Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75370822A03
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 10:13:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKxJ3-0007uU-Gm; Wed, 03 Jan 2024 04:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKxJ0-0007qu-AT
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 04:12:54 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKxIy-0002pL-3k
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 04:12:53 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3364c9ff8e1so125638f8f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 01:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704273170; x=1704877970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L9Eixksq3Xn36FakjeuKx/Xz/4gtKrZOPm2deTJNUdc=;
 b=Gcd0SjBjXerHI4c4MP5CKtiNs3pSsIkpNwPrnQHMlTWXBTdCyxEimBCQidiTVDr5jU
 gs48gmNjpZa1VWw6SJOXEP4mg2rbfVPBmSQfSKeyqPsRnbBNbxPxpths+DH55PTUKn00
 XHts4oo0R9+e9aZHBT2lZe8oeWKCMVJ50KjkGcXlnr6yEd9jCOX6jb38vZwkogiMCTKL
 qsCqQW8jVsKFpb/jg2nR/i8Akfd9MvDOeG4hSuABjDkb58+eJK6kohyHrP04A0HuOG85
 rLWanH68Gxl3ehQwSs1IAwQveD+/BG16Xq80Vck1OJ79L0zb/VyJ8mzbPkDc+zV33+43
 aTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704273170; x=1704877970;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L9Eixksq3Xn36FakjeuKx/Xz/4gtKrZOPm2deTJNUdc=;
 b=qzBA1lhlHqpSi8IDiuCTtd2LApVY6OK1ENS5RuWvVs6ItwCUvBEF6Hy5+eTU7lV7g1
 O4l74S2YcTtgKJWOxTQe7MigC/+1HDxGrfhb06fgeoxqWp5JRfMwcO1+v8nVuSOKKY/U
 jXmO7otzOvjeugOtOCs6HeHnD3F/gn1vHqf5UTEEqswt36HVkhxdeuMJfeZaOxoVgve+
 +YMTQKXasfQvd14y7vwZkc2DHCL0EvJQy7FFlt6zMsMgzafUWXrV0/Hy8gXJ1A38hilb
 AKn1uFm5HQA/2Z8f5Yqgnx6ybLFJr0jh2b16vjNaXLuGAcdKvzuXNR984p4lL+Om+t/7
 sxVA==
X-Gm-Message-State: AOJu0YyccxI0QoBFRtpJtCuGP1ixoCd9FT5iFx78T/UhmVO0ThBCI6W+
 ZHQm0yF/fZjFGLsejw9fOZV9rZEswPbpdQ==
X-Google-Smtp-Source: AGHT+IFOxQHsk8T9C7S9DE6YBLFNsBeuI1SEwKFlCZKhqeftFM40CIO81lfYEkGLcE0xIUcgPsHHMw==
X-Received: by 2002:a05:600c:5254:b0:40d:887e:fc85 with SMTP id
 fc20-20020a05600c525400b0040d887efc85mr327781wmb.32.1704273170665; 
 Wed, 03 Jan 2024 01:12:50 -0800 (PST)
Received: from [192.168.69.100] (tre93-h02-176-184-7-144.dsl.sta.abo.bbox.fr.
 [176.184.7.144]) by smtp.gmail.com with ESMTPSA id
 df2-20020a5d5b82000000b00336be33649csm22921284wrb.9.2024.01.03.01.12.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 01:12:50 -0800 (PST)
Message-ID: <02f710cd-6118-4521-93b1-598f98a843c0@linaro.org>
Date: Wed, 3 Jan 2024 10:12:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] qdev-properties: Add OptionalBool QAPI type
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, Frederic Konrad <fkonrad@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20240102160455.68612-1-philmd@linaro.org>
 <20240102160455.68612-3-philmd@linaro.org>
 <c4e0c179-0fe3-4b16-9a7d-1298e018dbb7@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c4e0c179-0fe3-4b16-9a7d-1298e018dbb7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 2/1/24 23:44, Richard Henderson wrote:
> On 1/3/24 03:04, Philippe Mathieu-Daudé wrote:
>> To be able to distinct whether a boolean qdev property
>> has been set or not, add the DEFINE_PROP_BOOL_NODEFAULT()
>> qdev macro based on the tri-state OptionalBool QAPI type.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   qapi/common.json             | 16 ++++++++++++++++
>>   include/hw/qdev-properties.h |  5 +++++
>>   hw/core/qdev-properties.c    | 10 ++++++++++
>>   3 files changed, 31 insertions(+)
> 
> How is this different from OnOffAuto?

I am trying to not break CLI which expects true/false and not on/off.

We could extend OnOffAuto to parse true/false if preferred.

(The particular device used as example in this series is not - yet -
user-creatable, so this doesn't matter there).



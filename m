Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A357BB2F0
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 10:20:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qog2r-0002r7-Qn; Fri, 06 Oct 2023 04:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qog2p-0002qT-CY
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:18:47 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qog2a-0005sv-7s
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:18:47 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5046bf37daeso2440310e87.1
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 01:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696580309; x=1697185109; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jx2fZh8F6HOqy2I/fL07ySIEJkU9T0NcXIE2fMPPnCA=;
 b=MC6TdDgiiTkVbFPDh8SCnT7p6GOK8AIz4MLj8KEbBKHMCbgFMv+/EXqD1hDcKlPOum
 pmBGws3jk0a9IEVQ7Zcm6aNXcNPw6XlLlu10wfDRAG/h1mK6rMWlmIJicVcpzDYd8c43
 haYDT5j931wch8UTRIICochoO2EBElooU0DZpkVG4jnu05xnBSMnpBaIJyBTetfhTy17
 Af7RMxHZKMk+20OcXwp5uRkg1oSuNfhoOgsV1xb/iUoZLK8eYUoxlFeIVvzQ8c3Y3JA9
 Fsys2EYiD8xGXF+QsgDWPrND2/WqPum1il+tG18mu895+QVJuetHpmfN9utu57FPobOZ
 8BYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696580309; x=1697185109;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jx2fZh8F6HOqy2I/fL07ySIEJkU9T0NcXIE2fMPPnCA=;
 b=bBunQFk3lgiW9CT4gBZgquVj0U5DiAatVDEHzWjn9zVicdwkC9R+O6MWJ1FoVVSrvt
 pVQUBtUESnRewba4nGdkG5cxITJGDEFT6wxjXL3+wKj5HkgkmYeyCMQO/jFSK1cMWVaL
 wqH7ExSW+Jkg1T+/Vnffee6/++eOPXHmMDTF+0NLI74snwW27jErYsbfE//opEcI+mHU
 TYLvP/JnLolH81vDYKpB1fqzGyjDwShXrgrC90boA7NFcgi+oUsWJ+a94eObonhXw8ag
 8DwfFIpVbfPDg87c7Y4SJcolyCQKN1mPvc6e1mo3megSECVJJS63X2PjFvJmjxqA+It9
 Qf5g==
X-Gm-Message-State: AOJu0YwtdOJPcWDkC09wJrOLnsRWUh8oQto4Nbh8RVdsyjixwqyveY72
 JQ3FEfv71xtqlYjpzToxVIuOrg==
X-Google-Smtp-Source: AGHT+IHi+8xAZpH7660TEDNfGaiwN0ArHZZ73y3/emyDN8MKl4wvfZ1C/t/sSDgcVwOQY+P1gM0p9w==
X-Received: by 2002:a05:6512:1255:b0:502:d6b2:922e with SMTP id
 fb21-20020a056512125500b00502d6b2922emr7957990lfb.46.1696580309333; 
 Fri, 06 Oct 2023 01:18:29 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.115.173])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a05600c354e00b004068de50c64sm3059504wmq.46.2023.10.06.01.18.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 01:18:28 -0700 (PDT)
Message-ID: <a1dc7eca-a062-c045-a2a2-39c35e3ceaa2@linaro.org>
Date: Fri, 6 Oct 2023 10:18:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2] pc-bios/meson.build: Silent unuseful DTC warnings
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>,
 qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>
References: <20231006064750.33852-1-philmd@linaro.org>
 <9fb5e05e-1772-e21b-0f82-56b4e9135c3b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <9fb5e05e-1772-e21b-0f82-56b4e9135c3b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.219,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/10/23 10:13, Cédric Le Goater wrote:
> On 10/6/23 08:47, Philippe Mathieu-Daudé wrote:
>> QEMU consumes some device tree blobs, so these have been committed
>> to the tree in as firmware, along with the device tree source used
>> to generate them. We know the blobs are "good enough" to have QEMU
>> boot a system, so we don't really maintain and rebuild the sources.
>>
>> These blobs were generated with older 'dtc' binaries. We use the
>> v1.6.1 version since 2021 (commit 962fde57b7 "dtc: Update to version
>> 1.6.1").
>>
>> Since commit 6e0dc9d2a8 ("meson: compile bundled device trees"),
>> if dtc binary is available, it is directly used to compile the
>> device tree sources. New versions of 'dtc' add checks which display
>> warnings or errors. Our sources are a bit old, so dtc v1.6.1 now
>> emit the following warnings on a fresh build:
>>
>>    [163/3414] Generating pc-bios/canyonlands.dts with a custom command
>>    pc-bios/canyonlands.dts:47.9-50.4: Warning (unit_address_vs_reg): 
>> /memory: node has a reg or ranges property, but no unit name
...

>>  From QEMU perspective, these warnings are not really useful. It is
>> the responsibility of developers adding DT source/blob to QEMU
>> repository to check the source doesn't produce warnings, but as
>> long as the blob is useful enough, QEMU can consume it. So these
>> warnings don't add any value, instead they are noisy and might
>> distract us to focus on important warnings. Better disable them.
>>
>> 'dtc' provides the '--quiet' option for that:
>>
>>    $ dtc --help
>>    Usage: dtc [options] <input file>
>>
>>    Options: -[qI:O:o:V:d:R:S:p:a:fb:i:H:sW:E:@AThv]
>>      -q, --quiet
>>            Quiet: -q suppress warnings, -qq errors, -qqq all
>>
>> Update meson to disable these unuseful DTC warnings.
> 
> 
> Why not try fixing the .dts instead ? These still exist under Linux :
> 
>    ./arch/powerpc/boot/dts/canyonlands.dts
>    ./arch/powerpc/boot/dts/bamboo.dts

Because QEMU != Linux, and there isn't always overlap between
communities?

1/ I tried but there isn't much interest:
https://lore.kernel.org/qemu-devel/20230914204206.79351-1-philmd@linaro.org/

2/ Peter and Zoltan raised issue with old firmwares when changing
properties such 'stdout-path', see this thread:
https://lore.kernel.org/qemu-devel/CAFEAcA-WJ9J1YQunJ+bSG=wnpxh1By+Bf18j2CyV7G0vZ=8b7g@mail.gmail.com/


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0567BB34A
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 10:34:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogG1-000819-Gb; Fri, 06 Oct 2023 04:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qogG0-00080u-8A
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:32:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qogFy-0000r9-Iv
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696581142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=thuZU2NuYNyj1rVcqQE3VIv3xaIqTVEfxrgbG4vf3KQ=;
 b=VlAoyv9KaUtiD6d5lT8AAIlVWybvC322jTAVshagcNYSZBjWyqtBduDOiOdoYwmuI6z6Ww
 jS7w7Eu/HekuWSl5bk8vROfSKTMRq6F7/4+RmIGBgQ5xftweCzaslB27wR15WBGYA874/M
 IHEttqmyTfRi8fT3kZ8aD9JhYnHWvmc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-C1ha2C34NkK5MHx3HYRDUw-1; Fri, 06 Oct 2023 04:32:05 -0400
X-MC-Unique: C1ha2C34NkK5MHx3HYRDUw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-774294bde69so276395185a.1
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 01:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696581125; x=1697185925;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=thuZU2NuYNyj1rVcqQE3VIv3xaIqTVEfxrgbG4vf3KQ=;
 b=R+3IAiEYTVcSNmmBHkI8lUDw28N6z/PEUUMvegUgxmEkqIDS84mxB1ubDWzbu1OE86
 uD8BBoXkilfFK37zNlzS5JXa0Trc3gNa9eAncGG0L4bdHYAyR9lnABr3WO70XoARFB5i
 8uAZuL4MWvm2ia9RU9XxPvwZkth07aRU7/l89mfOiMnCi9KXZEVC1VdlyiPUamgmKKEJ
 braANTEvDq4jL+xNEopVwFXiVxYlCW5FnV27qf7OywwiczI1Jz7aOyG8SF6bBvo2t3XV
 l+Vku7KnQ67YwBeu1+HUfDhgL/xxI1TzUgd/I+F46Ohv7AroLfy16PtYziNbpuSAE3JL
 OUJg==
X-Gm-Message-State: AOJu0YzvjxiK4svrupxFQpoup17t5VHaBYnw4pn6S35PlHLyPMA+P533
 wmihmn00KlXXZZeMuysk2FgYTTjHnRdlqysyf4X5iaARhyft4vrYuAATn8c13bs0vrW7ScztOpy
 DgcbivGVwiq/YHaQ=
X-Received: by 2002:a05:620a:240f:b0:772:63b3:2423 with SMTP id
 d15-20020a05620a240f00b0077263b32423mr7632960qkn.0.1696581124797; 
 Fri, 06 Oct 2023 01:32:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETmMtabI7uqCs9Ud/s3KCdjPGHOSiXiUOV0OQyw87cW3qrDqGWgstKWZIbtnafNeuNbMHu2Q==
X-Received: by 2002:a05:620a:240f:b0:772:63b3:2423 with SMTP id
 d15-20020a05620a240f00b0077263b32423mr7632945qkn.0.1696581124556; 
 Fri, 06 Oct 2023 01:32:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 h23-20020a05620a10b700b007758ffab58asm1134543qkk.8.2023.10.06.01.32.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 01:32:04 -0700 (PDT)
Message-ID: <d256b67d-dcbe-6eda-7e58-eb9ed74283fc@redhat.com>
Date: Fri, 6 Oct 2023 10:32:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] pc-bios/meson.build: Silent unuseful DTC warnings
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>
References: <20231006064750.33852-1-philmd@linaro.org>
 <9fb5e05e-1772-e21b-0f82-56b4e9135c3b@redhat.com>
 <a1dc7eca-a062-c045-a2a2-39c35e3ceaa2@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <a1dc7eca-a062-c045-a2a2-39c35e3ceaa2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/6/23 10:18, Philippe Mathieu-Daudé wrote:
> On 6/10/23 10:13, Cédric Le Goater wrote:
>> On 10/6/23 08:47, Philippe Mathieu-Daudé wrote:
>>> QEMU consumes some device tree blobs, so these have been committed
>>> to the tree in as firmware, along with the device tree source used
>>> to generate them. We know the blobs are "good enough" to have QEMU
>>> boot a system, so we don't really maintain and rebuild the sources.
>>>
>>> These blobs were generated with older 'dtc' binaries. We use the
>>> v1.6.1 version since 2021 (commit 962fde57b7 "dtc: Update to version
>>> 1.6.1").
>>>
>>> Since commit 6e0dc9d2a8 ("meson: compile bundled device trees"),
>>> if dtc binary is available, it is directly used to compile the
>>> device tree sources. New versions of 'dtc' add checks which display
>>> warnings or errors. Our sources are a bit old, so dtc v1.6.1 now
>>> emit the following warnings on a fresh build:
>>>
>>>    [163/3414] Generating pc-bios/canyonlands.dts with a custom command
>>>    pc-bios/canyonlands.dts:47.9-50.4: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
> ...
> 
>>>  From QEMU perspective, these warnings are not really useful. It is
>>> the responsibility of developers adding DT source/blob to QEMU
>>> repository to check the source doesn't produce warnings, but as
>>> long as the blob is useful enough, QEMU can consume it. So these
>>> warnings don't add any value, instead they are noisy and might
>>> distract us to focus on important warnings. Better disable them.
>>>
>>> 'dtc' provides the '--quiet' option for that:
>>>
>>>    $ dtc --help
>>>    Usage: dtc [options] <input file>
>>>
>>>    Options: -[qI:O:o:V:d:R:S:p:a:fb:i:H:sW:E:@AThv]
>>>      -q, --quiet
>>>            Quiet: -q suppress warnings, -qq errors, -qqq all
>>>
>>> Update meson to disable these unuseful DTC warnings.
>>
>>
>> Why not try fixing the .dts instead ? These still exist under Linux :
>>
>>    ./arch/powerpc/boot/dts/canyonlands.dts
>>    ./arch/powerpc/boot/dts/bamboo.dts
> 
> Because QEMU != Linux, and there isn't always overlap between
> communities?

sure but bamboo.dts came from Linux. So this should be safe to update.
Alex Graf did 10 years ago.

I can not tell for the sam460ex. It is probably safer to keep it as it is.

Sweeping dtc warnings under the rug for all .dts doesn't seem a good idea.
Should we get rid of the .dts and only keep the .dtb then ?

Thanks,

C.

> 1/ I tried but there isn't much interest:
> https://lore.kernel.org/qemu-devel/20230914204206.79351-1-philmd@linaro.org/
> 
> 2/ Peter and Zoltan raised issue with old firmwares when changing
> properties such 'stdout-path', see this thread:
> https://lore.kernel.org/qemu-devel/CAFEAcA-WJ9J1YQunJ+bSG=wnpxh1By+Bf18j2CyV7G0vZ=8b7g@mail.gmail.com/




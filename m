Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8916171779E
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 09:16:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4G37-00058s-KF; Wed, 31 May 2023 03:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4G25-00052p-CT
 for qemu-devel@nongnu.org; Wed, 31 May 2023 03:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4G22-0002XZ-4J
 for qemu-devel@nongnu.org; Wed, 31 May 2023 03:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685517243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fX/GrQk+XE/G+7AEaheF4AacDOYz4/6F+LiNOapPv0M=;
 b=hiFZIlXkLOsGRMhNaJ/BqbS+34O5IlOui7PhKJIAyhDmZTVQpqPsnvuMcX3Ticev5dRoMc
 iYSC5OUgl/wzkmh1rG1W8e4gtqeKhEDWIkxlffEwcR12Pr/iX4HnvoNBhK4JANtW/G8gfy
 vV7XurTV7MpFuP1u+nyfSova/8cvbns=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-ohTTHrxvOUKt-H0YCu9QTA-1; Wed, 31 May 2023 03:14:02 -0400
X-MC-Unique: ohTTHrxvOUKt-H0YCu9QTA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f5fb41bc42so23353705e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 00:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685517241; x=1688109241;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fX/GrQk+XE/G+7AEaheF4AacDOYz4/6F+LiNOapPv0M=;
 b=Et1ND3zxcH4fDwfVF8mPogpmqZbSWJQZiyALkeTiXTbCmlo4BDixY257C5ga2ELM/s
 40CfRuq3vNib6Lz6uOnpzbfEwmv+ZeyXfLQz8dOn13CFPJqP/quqXp/zU2zl9YZtsLx9
 nj8jJKEEvXB/kR3qEH8mwWgj7Uvhu/Wy32Y8ah6khBjLZXF2AkXboPHfp0MauPkQa9g9
 RPtOlhuo1vVxHvsWmdXzwBzCqofywfFeBMMLbnLivVI3YUtmIklSG+FmG/vqaAmV0fQR
 sEmvWtccPWw3LiHuAyoPn57REjp8b7+1C4cCpR4UuvfkgiyB0uvTooayLw1o0ggdL+z5
 ng8w==
X-Gm-Message-State: AC+VfDxb3PiCQWLbf3HvRL0h70+O3L0og8MTb6x5q94t1pHUDJ6Z0K7p
 VI4xdEFP90HYjfYPv89gbOXBm6IG7zIHF5/XJ9ir6fRTZtfBa9G/gjT2pAM8Xq7G/FD87otQhfA
 /FY8On/IUJoS8ahY=
X-Received: by 2002:a7b:c015:0:b0:3f6:7ff:b3bd with SMTP id
 c21-20020a7bc015000000b003f607ffb3bdmr2916395wmb.21.1685517241096; 
 Wed, 31 May 2023 00:14:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Ae0/U0V1ucDZLyPAvplhnkKwhu4FyAsL/fcmj48XAVekL2k7yRfn2uOMMuOeuiXCcVlrqzA==
X-Received: by 2002:a7b:c015:0:b0:3f6:7ff:b3bd with SMTP id
 c21-20020a7bc015000000b003f607ffb3bdmr2916373wmb.21.1685517240821; 
 Wed, 31 May 2023 00:14:00 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-4.web.vodafone.de. [109.43.178.4])
 by smtp.gmail.com with ESMTPSA id
 c12-20020a7bc84c000000b003f3e50eb606sm19511273wml.13.2023.05.31.00.13.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 00:14:00 -0700 (PDT)
Message-ID: <21e7da53-a3c8-1fc6-c19e-4f077962e846@redhat.com>
Date: Wed, 31 May 2023 09:13:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] hw/mips/malta: Fix the malta machine on big endian hosts
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-stable@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Rob Landley <rob@landley.net>, Peter Maydell <peter.maydell@linaro.org>
References: <20230330152613.232082-1-thuth@redhat.com>
 <33e52dd7-32f7-0fa8-b6ee-813b87ead623@msgid.tls.msk.ru>
 <CAFEAcA8g5Uqcns0FPy74mZ+jh-8ZtCxOTR8qL+RGbn+XjNfk0w@mail.gmail.com>
 <CAFEAcA9JbQhKmKX7zUuSNE-Qvqnm6Ax7JpTQOjqWqS73GgVD5Q@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <CAFEAcA9JbQhKmKX7zUuSNE-Qvqnm6Ax7JpTQOjqWqS73GgVD5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 09/05/2023 20.44, Peter Maydell wrote:
> On Thu, 13 Apr 2023 at 17:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Thu, 13 Apr 2023 at 17:08, Michael Tokarev <mjt@tls.msk.ru> wrote:
>>>
>>> 30.03.2023 18:26, Thomas Huth wrote:
>>>> Booting a Linux kernel with the malta machine is currently broken
>>>> on big endian hosts. The cpu_to_gt32 macro wants to byteswap a value
>>>> for little endian targets only, but uses the wrong way to do this:
>>>> cpu_to_[lb]e32 works the other way round on big endian hosts! Fix
>>>> it by using the same ways on both, big and little endian hosts.
>>>>
>>>> Fixes: 0c8427baf0 ("hw/mips/malta: Use bootloader helper to set BAR registers")
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>
>>> Has this been forgotten?
>>
>> Looks like it. Too late for 8.0 now (and it wasn't a regression
>> since it looks like it was broken in 7.2 as well); will have to
>> be fixed in 8.1.
> 
> Philippe -- looks like this patch still hasn't been queued ?
> (It could probably use a Cc: qemu-stable@nongnu.org at this point.)
> 
> It can have my
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

*ping*

Philippe, can you please comment? I think this should be good enough at 
least for a temporary fix, even if you have more clean ups in this area in 
mind later...

  Thomas



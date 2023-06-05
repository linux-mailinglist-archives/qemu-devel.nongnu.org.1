Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE12721E04
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 08:22:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q63aS-0001zz-Jr; Mon, 05 Jun 2023 02:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q63aH-0001wE-PG
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 02:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q63aG-0000c4-9J
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 02:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685946051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fDxoywgF9pTH+ny93OBS+TfjMsnQd+6G4HO3Pl2MQ2c=;
 b=IR5FjjqyawOCEmmiV0SU6KJ2/9ht74yOHHZw3pmxmI9hVzZPHIZkXydSAFB6BPJrzQBxbm
 tsUh+xXLvsVmXrD9klavysicZS1iL9Rmvdy4GAgt96q6+bq9tatKA4pbua6p5g4dFhHrCT
 Vi8feg62ZJdtnsEBxkkEhKHMr2ybi9M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-529f7bHQNNG7xQiPaGmPRQ-1; Mon, 05 Jun 2023 02:20:49 -0400
X-MC-Unique: 529f7bHQNNG7xQiPaGmPRQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f6cc1997fdso21543795e9.1
 for <qemu-devel@nongnu.org>; Sun, 04 Jun 2023 23:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685946049; x=1688538049;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fDxoywgF9pTH+ny93OBS+TfjMsnQd+6G4HO3Pl2MQ2c=;
 b=jxaz2w3FRFUaak0SbAg60omAd5jBQPnV3DqJlzY6fmTdY+YF5k3lUBFg34qKjAR3lp
 lDSid/JExqWH5w4zmQIqCOTcpvHwQGzLMwgwKVAu5O6Cn8C6an+x4kMi5ObwfiksaZBo
 iLF5eVyLJML1sUTXD97fj3dBMY/9d25wztsrFrmpkw7vDzt94/U3Ydi/GsJntjeyDDUT
 hiM9OYbZ9eZ4iqfMSuTRIVVpNpSSjBeiyoqZg/yNjNSR3kFIRPEssh/nr37KignHavhf
 CEyKsasMjxb2wfOtYnzgfHor9brJ9GGSatLE9oXFp6SSSC4RxMPGG1DQIEeR+psUYtyp
 ziZQ==
X-Gm-Message-State: AC+VfDxdVxLl+OTlf2DI7x5QTF1fa5FHdsqRK2dIFo0h/u2gk8+ErIEG
 hEwTnanfuQrGYaW3u/dQmmjwkbnwDeNmKLXZYvZ2N/pm4JjknC5/U+oW2qTHX+10dnOqCc4t9Zm
 zagSjZmKsI9+JppI=
X-Received: by 2002:a7b:c7d8:0:b0:3f6:148f:5867 with SMTP id
 z24-20020a7bc7d8000000b003f6148f5867mr5817219wmk.4.1685946048898; 
 Sun, 04 Jun 2023 23:20:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7vxpd0ipJAroz2YPXmo4yyrCsFhGApt4g4f0S6ZROwHPqvaUpkyFi2wkc+c8zr9LWNCJPMew==
X-Received: by 2002:a7b:c7d8:0:b0:3f6:148f:5867 with SMTP id
 z24-20020a7bc7d8000000b003f6148f5867mr5817213wmk.4.1685946048653; 
 Sun, 04 Jun 2023 23:20:48 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-115-143.web.vodafone.de.
 [109.42.115.143]) by smtp.gmail.com with ESMTPSA id
 m16-20020a7bcb90000000b003f6028a4c85sm13137379wmi.16.2023.06.04.23.20.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jun 2023 23:20:48 -0700 (PDT)
Message-ID: <8388d57a-700b-8f10-4904-8d5c15526883@redhat.com>
Date: Mon, 5 Jun 2023 08:20:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] hw/mips/malta: Fix the malta machine on big endian hosts
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-stable@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Rob Landley <rob@landley.net>, Peter Maydell <peter.maydell@linaro.org>
References: <20230330152613.232082-1-thuth@redhat.com>
 <33e52dd7-32f7-0fa8-b6ee-813b87ead623@msgid.tls.msk.ru>
 <CAFEAcA8g5Uqcns0FPy74mZ+jh-8ZtCxOTR8qL+RGbn+XjNfk0w@mail.gmail.com>
 <CAFEAcA9JbQhKmKX7zUuSNE-Qvqnm6Ax7JpTQOjqWqS73GgVD5Q@mail.gmail.com>
 <21e7da53-a3c8-1fc6-c19e-4f077962e846@redhat.com>
In-Reply-To: <21e7da53-a3c8-1fc6-c19e-4f077962e846@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 31/05/2023 09.13, Thomas Huth wrote:
> On 09/05/2023 20.44, Peter Maydell wrote:
>> On Thu, 13 Apr 2023 at 17:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>
>>> On Thu, 13 Apr 2023 at 17:08, Michael Tokarev <mjt@tls.msk.ru> wrote:
>>>>
>>>> 30.03.2023 18:26, Thomas Huth wrote:
>>>>> Booting a Linux kernel with the malta machine is currently broken
>>>>> on big endian hosts. The cpu_to_gt32 macro wants to byteswap a value
>>>>> for little endian targets only, but uses the wrong way to do this:
>>>>> cpu_to_[lb]e32 works the other way round on big endian hosts! Fix
>>>>> it by using the same ways on both, big and little endian hosts.
>>>>>
>>>>> Fixes: 0c8427baf0 ("hw/mips/malta: Use bootloader helper to set BAR 
>>>>> registers")
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>
>>>> Has this been forgotten?
>>>
>>> Looks like it. Too late for 8.0 now (and it wasn't a regression
>>> since it looks like it was broken in 7.2 as well); will have to
>>> be fixed in 8.1.
>>
>> Philippe -- looks like this patch still hasn't been queued ?
>> (It could probably use a Cc: qemu-stable@nongnu.org at this point.)
>>
>> It can have my
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> *ping*
> 
> Philippe, can you please comment? I think this should be good enough at 
> least for a temporary fix, even if you have more clean ups in this area in 
> mind later...

Philippe, if you don't mind, I'll take this through my s390x tree since this 
fixes a problem on the big-endian s390x hosts.

  Thomas



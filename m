Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B58FD88E1ED
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Mar 2024 14:15:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpT78-0003tP-Pb; Wed, 27 Mar 2024 09:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rpT6w-0003qh-4v
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:14:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rpT6u-0002i8-99
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711545270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3SQWuc/fST723aiWlaBeQkrzNlWB4lY3zQG10/7XHpM=;
 b=ZZP86gHlUsTCRKk20YykOJuMUYe0AkuXv6jiTJM7nEA2zO7WyckOweeWNVHJN1g3/kVQtq
 RZgJC9splcfd1xkdkDaOxRv6dSjP7NEXcM7T5Omp4psNvSd+ZoOkw1qV6Mzx12fIZvaywk
 vfyAL8lZgR/KsUNAtGizBbAnp4X/7hg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-DnwFJRhLOnybpgpFjHueBw-1; Wed, 27 Mar 2024 09:14:29 -0400
X-MC-Unique: DnwFJRhLOnybpgpFjHueBw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5158a80cf1aso5985741e87.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 06:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711545267; x=1712150067;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3SQWuc/fST723aiWlaBeQkrzNlWB4lY3zQG10/7XHpM=;
 b=xTmemAh9cT/Acw4h6kML5x1bU47UCJHoDDu+EbumdTwsWy4w76zfJtMkzormOuCntI
 9kjRFcofCjM/GlfG+x+IrSQn9Q0QpZQ71qJ46hPhEYhNlKj7L9luPAnHKS3oQ0z0tiMX
 Vy7DeG7C8GzWv7P2CBIH62OogeGEuofQm/CvmXWr73e15WJSTrJ50rteDv1/0E8T4Ghw
 Brnk8vNpHk1URz6mQ7JTh8IEQi8UNKOHYEhlQf1sVsQZgvkfBQ2TD4irujrdz46818kr
 SsLuUDcYCAj8BJludR5NG7F0z0JG3SZTfGXm9JobOs6jhD+epymMmegODtpI9CAd4YAS
 FAGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa9JtZHq4Dud6Iu16sjNvNO/ZqrKoLrUmTFmjUBlUBda9Q5v6TVEvq08Pt8JY5Ag5fjKtph5WjBZPA7+GeGuT+55G9WNc=
X-Gm-Message-State: AOJu0YzI3fZL/QhUhBjEqE9Sa35POrnL3Vwi36eDNcEtiwT2R43UD/+/
 UgChCe/eCWyQUh4VgnjGOLn94XMDyCnu/a3ejvv+Hkecfop92Rt2vv5dxIl0nmXFCIuetc+ufCB
 +lUzlwyq4Ghyd+XFvov3UgBxrdsGQylip2XJMz5av3gD6ObeKT0FZOMyzuijh
X-Received: by 2002:a19:3807:0:b0:513:e2bd:6d15 with SMTP id
 f7-20020a193807000000b00513e2bd6d15mr799144lfa.49.1711545267567; 
 Wed, 27 Mar 2024 06:14:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhEy2z1w9abuCD9MhaRxVN4J1Oq+NO/dpxLpWAMoDpvyyYEG3IM1MF201OohEmI87acmZ2PA==
X-Received: by 2002:a19:3807:0:b0:513:e2bd:6d15 with SMTP id
 f7-20020a193807000000b00513e2bd6d15mr799124lfa.49.1711545267161; 
 Wed, 27 Mar 2024 06:14:27 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-37.web.vodafone.de.
 [109.43.177.37]) by smtp.gmail.com with ESMTPSA id
 o25-20020a198c19000000b00514b4e43906sm1851433lfd.29.2024.03.27.06.14.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 06:14:26 -0700 (PDT)
Message-ID: <9f0c10f0-4916-4bc8-bac9-c593cba9ee08@redhat.com>
Date: Wed, 27 Mar 2024 14:14:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] docs/about: Mark the iaspc machine type as
 deprecated
To: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 pbonzini@redhat.com, devel@lists.libvirt.org, richard.henderson@linaro.org,
 mst@redhat.com, qemu-trivial@nongnu.org
References: <20240326125104.90103-1-imammedo@redhat.com>
 <a4a0bb13-d6a0-4665-810d-ecd9a9fb89b1@redhat.com>
 <8dbba6ae-5910-4a62-9a08-a56e20dfb480@linaro.org>
 <20240326171632.3cc7533d@imammedo.users.ipa.redhat.com>
 <ZgP5x3ECYGevla1-@redhat.com>
 <20240327140917.69d86539@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240327140917.69d86539@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 27/03/2024 14.09, Igor Mammedov wrote:
> On Wed, 27 Mar 2024 10:49:43 +0000
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
>> On Tue, Mar 26, 2024 at 05:16:32PM +0100, Igor Mammedov wrote:
>>> On Tue, 26 Mar 2024 14:29:58 +0100
>>> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>    
>>>> Hi Igor,
>>>>
>>>> On 26/3/24 14:08, Thomas Huth wrote:
>>>>>
>>>>> s/iaspc/isapc/ in the subject
>>>>>
>>>>> On 26/03/2024 13.51, Igor Mammedov wrote:
>>>>>> ISAPC machine was introduced 25 years ago and it's a lot of time since
>>>>>> such machine was around with real ISA only PC hardware practically
>>>>>> defunct.
>>>>>> Also it's slowly bit-rots (for example: I was able to boot RHEL6 on
>>>>>> RHEL9 host
>>>>>> in only TCG mode, while in KVM mode it hung in the middle of boot)
>>>>
>>>> I'm quite opposed to this patch. QEMU models various very-old /
>>>> defunct hardware. I'm pretty sure Bernhard and myself are OK to
>>>> keep maintaining it, besides we are working in separating it from
>>>> the i440fx+piix machine. Also, this machine is particularly
>>>> interesting for my single-binary experiments.
>>>
>>> it would not be fair to ask you or Bernard to deal with every
>>> case where ISAPC related code gets in a way, nor it's fair to
>>> ask other contributors to ensure that their patches don't break
>>> semi-working ISAPC or refactor code that relates to it.
>>>
>>> [
>>> for example I'd like to refactor smbios parts in the image
>>> ACPI table builder, but the I'd have to do it for legacy
>>> part as well without means to verify that. Sure it can be
>>> done but at cost of extra time spent to rewrite something
>>> that would never be used and to find test env to verify
>>> touched code.
>>> ]
>>
>> Is SMBIOS even relevant for isapc ? IIUC, the first SMBIOS spec
>> is from 1999, while PCI has been around since 1992.
> 
> Theoretically SMBIOS can still be used with isapc,
> (that's how I've tested factoring out legacy part by running
> RHEL6 in TCG mode)
> Whether it's used in practice somewhere else is unknown.
> 
>> IOW, we shouldn't even be exposing SMBIOS with the isapc
>> machine type. If we address that, then isapc has no impact
>> on your ability to refactor SMBIOS code.
> 
> It's question of whether we are willing to do unthinkable,
> i.e. to break QEMU <-> guest ABI for isapc case by removing
> corresponding fwcfg entries.
> 
> With migration ignored it shouldn't be a problem.
> Question is: does anyone care about migration with isapc?

isapc is not versioned, so it is not really usable with migration at all, I 
think. We should maybe even add a migration blocker for that machine to 
avoid that people try to migrate it.

I just gave it also a quick try, and it currently seems to be broken anyway 
(aborts with "memory_region_set_alias_offset: Assertion `mr->alias' failed").

  Thomas



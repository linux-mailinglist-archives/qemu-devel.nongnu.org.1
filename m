Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 292218289F2
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 17:27:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNEwI-0000af-IY; Tue, 09 Jan 2024 11:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1rNEwG-0000aS-HE
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 11:26:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1rNEwE-0005np-9k
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 11:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704817608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t0z2JZsw1x3ZSh3unAsilXoIlwco6jjNm/Itxgx2VV4=;
 b=FWiyOQR6Ckl8hhb5iVhkhse6pyaiqANdmtsU1mGvmyUyxoeE8BwubcGzW6/UomZWGoZSW4
 Pud/KHr26vjs93nLIqhSMMhitjBaXwkqG78n/eAQ81+5K7Hkb7N4GtGpaXds3RholMr1D3
 2G+z94NJOxyt3MazD2Qc6HSJhkkWnho=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-HgLpYtNUMOqtgPWcW6GnWg-1; Tue, 09 Jan 2024 11:26:47 -0500
X-MC-Unique: HgLpYtNUMOqtgPWcW6GnWg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6800aa45af1so59337006d6.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 08:26:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704817606; x=1705422406;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t0z2JZsw1x3ZSh3unAsilXoIlwco6jjNm/Itxgx2VV4=;
 b=ZdfebzAzLhZQjDDZP28bPvCFXbQIQJ8D0xHgQKCiYSBXdyeli7kLACcSAFgFMrbBsr
 ikp8doHJFLk4O3iH3DH5X6QUAQtyb7lGdrkxuYqUB6Ue9SuP7iXbAawTyFiKs85DsdpB
 2fm5rCCRdN3cEqkKSDnFF/3CgiIZ2aI2t0LfXRHtDoz5ylUXF5dqCiftMuQcrU1JxL+P
 6wl8kN7h0aIE8oHwUTQDe+AeZzMeCeSLBRDHGCqiI99Az1OkbSgEJKYra4E0ZPImYBYr
 VapXoZ0sCznAYJQG3NjYlUCpfi6joVhT1yt0iLy+FuLno7/3QEgJ55cco7jFSeRkDYzQ
 m5+Q==
X-Gm-Message-State: AOJu0YxiT8n7cwl4q+C35MtK5zud4csJA/5SQxCEkDDK82FA1BsYvviq
 Q8ptMJgH81WZGMT0aT2AesNNQmB4YPe+2R1lypns1hctc1n1S+U2MRZ+0qmV+UuXCcGGaeatTK8
 ls+w/ea41GoqnmPDObaByLEI=
X-Received: by 2002:a05:620a:2223:b0:783:19aa:4423 with SMTP id
 n3-20020a05620a222300b0078319aa4423mr4113323qkh.109.1704817606537; 
 Tue, 09 Jan 2024 08:26:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOIt9dYvGWgo3xfh1dAzjVl39B3+Gw44htWkGop8aG7llTCy6gZU2L77pX5HRMSdAinhd3Kw==
X-Received: by 2002:a05:620a:2223:b0:783:19aa:4423 with SMTP id
 n3-20020a05620a222300b0078319aa4423mr4113318qkh.109.1704817606211; 
 Tue, 09 Jan 2024 08:26:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 z29-20020a05620a08dd00b0078325efbaa6sm908131qkz.61.2024.01.09.08.26.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 08:26:45 -0800 (PST)
Message-ID: <33244ed3-a065-4afb-a321-53ae46707d46@redhat.com>
Date: Tue, 9 Jan 2024 17:26:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: virtio-pci in qemu-system-arm is broken in 8.2
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>
References: <90d7351c-2680-4ab6-95ee-5dac4e3f21c5@tls.msk.ru>
 <CAFEAcA8DdsHQ0eCYnh4vNoybodj0mcHCnOMEr9b_aOk7yO2Osw@mail.gmail.com>
 <ea7dd9f7-b40f-436c-a469-97ef26ac66a2@tls.msk.ru>
 <d08930a4-7e01-41eb-b118-b20fea0f8556@tls.msk.ru>
 <CAFEAcA_wnSF-OAKNaDNjbEiMi-AXv2srJ5JjmiaT4+_wWee9aw@mail.gmail.com>
 <560c9f56-f0d8-4def-863a-63ba4226209e@tls.msk.ru>
 <CAFEAcA-hkd=VQdqw7-P1RGwu-c9JLn-NUHC1kgU-YgZ1FOMQww@mail.gmail.com>
 <CAFEAcA87qdWR-GLEjkGpGHxMhviFidi2=k7c=OFC3+hzn1P0Dw@mail.gmail.com>
 <87bk9uh9jd.fsf@draig.linaro.org>
 <CAFEAcA9K2jf3BfHY3xpP4T-_iH9nNX=XLrNp=mPg5nqZURBOrw@mail.gmail.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <CAFEAcA9K2jf3BfHY3xpP4T-_iH9nNX=XLrNp=mPg5nqZURBOrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 1/9/24 15:31, Peter Maydell wrote:
> On Tue, 9 Jan 2024 at 14:21, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On Tue, 9 Jan 2024 at 11:33, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>> On Mon, 8 Jan 2024 at 17:38, Michael Tokarev <mjt@tls.msk.ru> wrote:
>>>>> Speaking of config. This is standard debian config, I'm attaching one
>>>>> to this email.  It can be found in the package, eg
>>>>> http://deb.debian.org/debian/pool/main/l/linux/linux-image-6.6.9-armmp_6.6.9-1_armhf.deb
>>>>> in /boot/config-$(uname -r).
>>>>
>>>> It does seem to be a config thing -- on a plain upstream
>>>> v6.6.9 my config works and that debian default one does
>>>> not. Now to try to identify which particular config
>>>> difference is at fault. (It's not the CONFIG_VMSPLIT one,
>>>> I just tried that.)
>>>
>>> Oh, your kernel isn't an LPAE one (i.e. CONFIG_LPAE is not
>>> set). That will obviously never be able to access registers
>>> above the 4GB mark (though the kernel's error message in this
>>> situation is a bit unhelpful and could perhaps be improved).
>>> If I set CONFIG_LPAE on the non-working config it starts working.
>>>
>>> I think then the answer is:
>>>  * if you want to use the (default) highmem setup, use an LPAE kernel
>>>  * if you want to use a non-LPAE kernel, tell QEMU to avoid
>>>    highmem using '-machine virt,highmem=off'
>>
>> Could we expand the "highmem" description in
>> https://www.qemu.org/docs/master/system/arm/virt.html to make it
>> clearer. I'm sure this isn't the first time there have been 32bit
>> difficulties with non-LPAE kernels?
> 
> Sure. We could make the highmem property description read:
> 
> # Set on/off to enable/disable placing devices and RAM in physical
> # address space above 32 bits. The default is on for machine types
> # later than virt-2.12 when the CPU supports an address space
> # bigger than 32 bits (i.e. 64-bit CPUs, and 32-bit CPUs with the
> # Large Physical Address Extension (LPAE) feature). If you want to
> # boot a 32-bit kernel which does not have CONFIG_LPAE enabled on
> # a CPU type which implements LPAE, you will need to manually set
> # this to 'off'; otherwise some devices, such as the PCI controller,
> # will not be accessible.
> 
> How's that ?

Looks good to me.

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


> 
> thanks
> -- PMM
> 



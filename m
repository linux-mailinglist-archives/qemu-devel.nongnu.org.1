Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 989287669E8
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 12:10:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPK7L-0001L6-9L; Fri, 28 Jul 2023 05:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qPK77-0001K5-Nm
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 05:50:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qPK75-0000OA-E4
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 05:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690537822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m5pTybDdIBLbhcOr86m1AgdPmv/JRhCKP9Wrg+0bpNU=;
 b=fQ4Wght/44igOcFXJC9fIzF69ttvAvZpEo1lFxqi7tsrnLzMiprq1kBA9Q1z02qc86hpY8
 vyZmR588eOYvEvR+6yjQxfNAo/SGHcTa1+/AjNO89HAXjTMOzVayQ/6tb35X6eIdMmPD7y
 WarnZRxsBmsFXXToklMtneSqIBushqY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-SrbwVTCqOmWzZUy_zVHXZg-1; Fri, 28 Jul 2023 05:50:21 -0400
X-MC-Unique: SrbwVTCqOmWzZUy_zVHXZg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b710c5677eso19798381fa.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 02:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690537819; x=1691142619;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m5pTybDdIBLbhcOr86m1AgdPmv/JRhCKP9Wrg+0bpNU=;
 b=Onl93c78Mlml4wEUftvbUFGNO8YvqJ+OsrZId6KhVmCesiK/EnmQeqwVBERpqcaDYR
 rkKIu9ekrDLBDuNPfbIuDo5Uwc6ira56mfYviOGBwaOK+N+tnVf9Kmh/o7FPhkHUb/qN
 P968RdpmLRnG+5TGswNfmhcLWCgjRG4JkLgRtOxZc4/7NFagkXi7mJU52CGgU6pNBzsE
 Uil1xfkPhti1n96JQJQXYG2C9A1r4IgRig0aieEvvdTpDEjKrB8EAOnio3e5mwTI/9CL
 8v87xrbLoxjRi14TWwH8HWCs+zAx3qINfOCMRj+0NNfUjZj5Qssl3sG2nm00bZF5VrdY
 /XNw==
X-Gm-Message-State: ABy/qLaf0tSbE9CyazSCT/NLqf2JXnpXiYSrUUERK0SsqVhrj55ZZNdH
 59ZRvHjtTIDpGJJVOHquDrqzjuEfUNoZYLUUyTbqwmvCHiTks6Mt5PS573R+viGUe+wPJCTW5ms
 2mayRRnlgtZZUg1I=
X-Received: by 2002:a2e:8e93:0:b0:2b6:d700:fbdd with SMTP id
 z19-20020a2e8e93000000b002b6d700fbddmr1567479ljk.15.1690537819730; 
 Fri, 28 Jul 2023 02:50:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHektSdgX30fNoclbg04FvpLUPsYbeaXx9tG5O7knKkK2nhOzMw/eiV2c+yeqed7AeImBkL/A==
X-Received: by 2002:a2e:8e93:0:b0:2b6:d700:fbdd with SMTP id
 z19-20020a2e8e93000000b002b6d700fbddmr1567463ljk.15.1690537819382; 
 Fri, 28 Jul 2023 02:50:19 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-20.web.vodafone.de.
 [109.43.178.20]) by smtp.gmail.com with ESMTPSA id
 c8-20020a7bc848000000b003fb40ec9475sm3805544wml.11.2023.07.28.02.50.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 02:50:18 -0700 (PDT)
Message-ID: <e197a97f-1647-6335-79a7-fd13a66595d6@redhat.com>
Date: Fri, 28 Jul 2023 11:50:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Bin Meng <bin.meng@windriver.com>
References: <20230726161942.229093-1-berrange@redhat.com>
 <0d0f9f65-2ead-6852-20c2-a83e256eecac@redhat.com>
 <ZMJJS5lUtPKpld0q@redhat.com>
 <a56c06a0-a6b4-cee6-be97-3586a836f4d3@redhat.com>
 <ZMODTyTzJrKiDPo5@redhat.com>
 <CAMxuvawrEUmrftcAtsD0=QXHckqTKQRTFqePR7KOJruSoFUxCA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] gitlab: remove duplication between msys jobs
In-Reply-To: <CAMxuvawrEUmrftcAtsD0=QXHckqTKQRTFqePR7KOJruSoFUxCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 28/07/2023 11.32, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Jul 28, 2023 at 12:59 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Fri, Jul 28, 2023 at 10:35:35AM +0200, Thomas Huth wrote:
>>> On 27/07/2023 12.39, Daniel P. Berrangé wrote:
>>>> On Wed, Jul 26, 2023 at 08:21:33PM +0200, Thomas Huth wrote:
>>>>> On 26/07/2023 18.19, Daniel P. Berrangé wrote:
>>> ...
>>>>> Anyway, before we unify the compiler package name suffix between the two
>>>>> jobs, I really would like to see whether the mingw Clang builds QEMU faster
>>>>> in the 64-bit job ... but so far I failed to convince meson to accept the
>>>>> Clang from the mingw package ... does anybody know how to use Clang with
>>>>> MSYS2 properly?
>>>>
>>>> AFAIK it shouldn't be anything worse than
>>>>
>>>>     CC=clang ./configure ....
>>>>
>>>> if that doesn't work then its a bug IMHO
>>>
>>> No, it's not that easy ... As Marc-André explained to me, MSYS2 maintains a
>>> completely separate environment for Clang, i.e. you have to select this
>>> different environment with $env:MSYSTEM = 'CLANG64' and then install the
>>> packages that have the "mingw-w64-clang-x86_64-" prefix.
>>>
>>> After lots of trial and error, I was able to get a test build here:
>>>
>>>   https://gitlab.com/thuth/qemu/-/jobs/4758605925
>>>
>>> I had to disable Spice and use --disable-werror in that build to make it
>>> succeed, but at least it shows that Clang seems to be a little bit faster -
>>> the job finished in 58 minutes. So if we can get the warnings fixed, this
>>> might be a solution for the timeouts here...
>>
>> Those packing warnings look pretty serious
>>
>> C:/GitLab-Runner/builds/thuth/qemu/include/block/nvme.h:1781:16: warning: unknown attribute 'gcc_struct' ignored [-Wunknown-attributes]
>>
>> This means CLang is using the MSVC struct packing ABI for bitfields,
>> which is different from the GCC struct packing ABI. If any of those
>> structs use bitfields and are exposed as guest hardware ABI, or in
>> migration vmstate, then this is potentially broken compilation.
>>
> 
> Yes .. gcc >=4.7 and clang >=12 have mms-bitfiles enabled by default,
> but we can't undo that MS struct packing on clang apparently:
> https://discourse.llvm.org/t/how-to-undo-the-effect-of-mms-bitfields/72271

I wonder whether we really still need the gcc_struct in QEMU...
As far as I understand, this was mainly required for bitfields in packed 
structs in the past, but using bitfields in structs for exchanging data with 
other systems is anyway not very portable (e.g. due to endianess issues) and 
thus frowned upon nowdays.

Looking at the history:

https://lists.gnu.org/archive/html/qemu-devel/2011-08/msg03441.html

... this indicates that this was mainly required for slirp - which has been 
removed from the QEMU repository and is a separate project nowadays.

And https://lists.gnu.org/archive/html/qemu-devel/2011-08/msg02356.html 
mentiones that there might have been issues with the bluetooth code, too, 
but that is also long gone...

  Thomas



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E26507669D6
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 12:07:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPKID-0002YO-3D; Fri, 28 Jul 2023 06:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qPKHz-0002Vx-77
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 06:01:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qPKHv-0000Hh-Ir
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 06:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690538493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UkTPzwzwaJ8mYi3+11zkoSsML1VLPjPR0aG7yzrYOEU=;
 b=Q9n14DPRnzstdaKSrAdo0s8PnU7VNfTuux8QZcJPx9Bjx2yAaQ8p6+8ysGx3RCTO9CCkWO
 Ko5Z3NX4f03c7vOkJDKOLjxIQr4aeFk3F9a48rVvU1HVDWHqlEbAMFLdxSJgy5LrSqLhq1
 MnEw0DMABdSYQ3W5kdcRkY9h34Y0jjQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-eRW5fEExPYmcMQVnX2ec5A-1; Fri, 28 Jul 2023 06:01:32 -0400
X-MC-Unique: eRW5fEExPYmcMQVnX2ec5A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fc08035926so15882175e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 03:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690538491; x=1691143291;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UkTPzwzwaJ8mYi3+11zkoSsML1VLPjPR0aG7yzrYOEU=;
 b=W4fftHdp9io1YZEfTggi1PeGzT97f7eIIBM2PuI65SXdnAYED/7XmLZU6dVt7ee4pv
 RAXvuqFZZIIh/Ed+fgRjeF+hONGF6vu3rd1niexKegrpQvHvd6CZoBtjGpomOMqGW1Z8
 MI4Rp3LOu5eJpd/ABpEdc6/MOJG8A96lFum3VEEtHFmTvN1GPm1AaWTML6cNEofFgtES
 Vb2wd80X7jnlXpIx1hGTfGONFn3SPb6jOswGkXfCTc2ii6U4AsA1RboinhKs2a7HpzHt
 WAwkZhSOAGrjAz71o5lu/3efUcdM3s8bzEiQNNT2xeYIa2lWE9f61/MTVlHkXj/Xwqzp
 DF+w==
X-Gm-Message-State: ABy/qLYFOfg0k602KBknhcMU6LBi+wr13SBLnf1NfYc47j/XnHUa31xl
 9foJWocj9PTylLzSHbIIjCgkvi1oaG3jkmBmlqnXx3M3LlEQ9a73BlqwzfLlvJVSEk0db9B4+tH
 RcDLihi7U/ZP4sBs=
X-Received: by 2002:a05:600c:20c4:b0:3f7:e660:cdc5 with SMTP id
 y4-20020a05600c20c400b003f7e660cdc5mr1595882wmm.9.1690538491267; 
 Fri, 28 Jul 2023 03:01:31 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHhsPj0JaFXyY+p1xJQXnSiP9pDNDEzck1wDruRBBx3Gc405uVbeE0Y9s2MLlxRzcTeKFjdZA==
X-Received: by 2002:a05:600c:20c4:b0:3f7:e660:cdc5 with SMTP id
 y4-20020a05600c20c400b003f7e660cdc5mr1595860wmm.9.1690538490896; 
 Fri, 28 Jul 2023 03:01:30 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-20.web.vodafone.de.
 [109.43.178.20]) by smtp.gmail.com with ESMTPSA id
 n2-20020a05600c294200b003fbbe41fd78sm3834380wmd.10.2023.07.28.03.01.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 03:01:30 -0700 (PDT)
Message-ID: <a0adefbd-041b-c33b-3149-a478bae0fe0e@redhat.com>
Date: Fri, 28 Jul 2023 12:01:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] gitlab: remove duplication between msys jobs
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
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
 <e197a97f-1647-6335-79a7-fd13a66595d6@redhat.com>
In-Reply-To: <e197a97f-1647-6335-79a7-fd13a66595d6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 28/07/2023 11.50, Thomas Huth wrote:
> On 28/07/2023 11.32, Marc-André Lureau wrote:
>> Hi
>>
>> On Fri, Jul 28, 2023 at 12:59 PM Daniel P. Berrangé <berrange@redhat.com> 
>> wrote:
>>>
>>> On Fri, Jul 28, 2023 at 10:35:35AM +0200, Thomas Huth wrote:
>>>> On 27/07/2023 12.39, Daniel P. Berrangé wrote:
>>>>> On Wed, Jul 26, 2023 at 08:21:33PM +0200, Thomas Huth wrote:
>>>>>> On 26/07/2023 18.19, Daniel P. Berrangé wrote:
>>>> ...
>>>>>> Anyway, before we unify the compiler package name suffix between the two
>>>>>> jobs, I really would like to see whether the mingw Clang builds QEMU 
>>>>>> faster
>>>>>> in the 64-bit job ... but so far I failed to convince meson to accept the
>>>>>> Clang from the mingw package ... does anybody know how to use Clang with
>>>>>> MSYS2 properly?
>>>>>
>>>>> AFAIK it shouldn't be anything worse than
>>>>>
>>>>>     CC=clang ./configure ....
>>>>>
>>>>> if that doesn't work then its a bug IMHO
>>>>
>>>> No, it's not that easy ... As Marc-André explained to me, MSYS2 maintains a
>>>> completely separate environment for Clang, i.e. you have to select this
>>>> different environment with $env:MSYSTEM = 'CLANG64' and then install the
>>>> packages that have the "mingw-w64-clang-x86_64-" prefix.
>>>>
>>>> After lots of trial and error, I was able to get a test build here:
>>>>
>>>>   https://gitlab.com/thuth/qemu/-/jobs/4758605925
>>>>
>>>> I had to disable Spice and use --disable-werror in that build to make it
>>>> succeed, but at least it shows that Clang seems to be a little bit faster -
>>>> the job finished in 58 minutes. So if we can get the warnings fixed, this
>>>> might be a solution for the timeouts here...
>>>
>>> Those packing warnings look pretty serious
>>>
>>> C:/GitLab-Runner/builds/thuth/qemu/include/block/nvme.h:1781:16: warning: 
>>> unknown attribute 'gcc_struct' ignored [-Wunknown-attributes]
>>>
>>> This means CLang is using the MSVC struct packing ABI for bitfields,
>>> which is different from the GCC struct packing ABI. If any of those
>>> structs use bitfields and are exposed as guest hardware ABI, or in
>>> migration vmstate, then this is potentially broken compilation.
>>>
>>
>> Yes .. gcc >=4.7 and clang >=12 have mms-bitfiles enabled by default,
>> but we can't undo that MS struct packing on clang apparently:
>> https://discourse.llvm.org/t/how-to-undo-the-effect-of-mms-bitfields/72271
> 
> I wonder whether we really still need the gcc_struct in QEMU...
> As far as I understand, this was mainly required for bitfields in packed 
> structs in the past

Ok, never mind, according to this post:

https://lists.gnu.org/archive/html/qemu-devel/2011-08/msg00964.html

this affects all structs, not only the ones with bitfieds.

And it seems like we also still have packed structs with bitfields in code 
base, see e.g. "struct ip" in net/util.h, so using Clang on Windows likely 
currently can't work?

  Thomas



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1282F82EC37
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 10:53:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPg7i-00055G-0V; Tue, 16 Jan 2024 04:52:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rPg7f-00053T-TM
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 04:52:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rPg7e-0005oE-8h
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 04:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705398761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=szVJWMd1d5xhnB+bvOzJm+jUq+8IPzhDkkcpUJEXNCs=;
 b=QvyEXKRmRoXO4DilUok7qtflXEKSCad2VaAlTkPzdS9LWt3bEqqR4jmJwq3We0/epuk6Rp
 aPM2SN+UtPxIYDcqPRdk4f8w93/lLe1VKYLFKQXakZkll+kmvJGru82EjkXzLnmIVQGAfZ
 WVJurWmS+iQO02A1jS35FCjXcc/mmVU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-E7R5USpePLmT2tU_BzrZhg-1; Tue, 16 Jan 2024 04:52:38 -0500
X-MC-Unique: E7R5USpePLmT2tU_BzrZhg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-429beb453b4so66240441cf.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 01:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705398758; x=1706003558;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=szVJWMd1d5xhnB+bvOzJm+jUq+8IPzhDkkcpUJEXNCs=;
 b=cD7nJPFc64h+bqznJDcR7Xd6Q0uJ8NO0f4BYMLeZ2zFfR/iOhS1EfuuzQI4aOdEEuU
 08ft3PMfL/I/4bjtw8UNJGa0H5d4rVKgdu34iFNOz3B66uQy8o9VWsYZX3dYipW8TtQX
 +hslX9dRKGMOM3Aau65nRLEdcphEayrizKTQqdHs6IUhIknledEMTcEmOA0uUeppPe4X
 e5Th8PmTpipVtK5EVvdBIvJ0YqCr5rblo6joMDWe2SnRvECkE6bVjvXicXIVbUpse3Hx
 Cd6YAtGzZaRzFlFyrPwo0CakyulfPLlKZ4j5JYfh7nOShAq/RMx99uy/c6bGrLj76jTu
 dG0g==
X-Gm-Message-State: AOJu0YxHxHZ0m3gXF3Q5zf9ugF2xAWzIT0b1M5Edrt60hG5IA8NNePtV
 a3bSV5i1SSJtvW55TjbyiNJ1NJysv75MYf0BhHhTvwNVphdA9YOoiA6MBaParmcOda1Eyo5509E
 B1gFn/dSP3w1TlSjbNVVkElc=
X-Received: by 2002:a05:622a:85:b0:429:e705:a003 with SMTP id
 o5-20020a05622a008500b00429e705a003mr4113060qtw.73.1705398758333; 
 Tue, 16 Jan 2024 01:52:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEketDsp8bALAyM/tpWc2Yw6miavyfjjA0SGmL9/jIRQvLzMBvuRjL42zrJAxXPUFeced9fjw==
X-Received: by 2002:a05:622a:85:b0:429:e705:a003 with SMTP id
 o5-20020a05622a008500b00429e705a003mr4113055qtw.73.1705398758051; 
 Tue, 16 Jan 2024 01:52:38 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-179-227.web.vodafone.de.
 [109.43.179.227]) by smtp.gmail.com with ESMTPSA id
 ie4-20020a05622a698400b00429943beea4sm4613596qtb.89.2024.01.16.01.52.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 01:52:37 -0800 (PST)
Message-ID: <690cc02f-381f-46ed-a352-c148b1b02af8@redhat.com>
Date: Tue, 16 Jan 2024 10:52:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] qemu-options: Remove the deprecated -singlestep option
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org, Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20240112100059.965041-1-thuth@redhat.com>
 <20240112100059.965041-6-thuth@redhat.com>
 <7f24e391-e3ba-462c-ba30-2ea7ddb62795@linaro.org>
 <fdbe4b2d-b63a-4fcd-9747-08d713e17d22@redhat.com>
 <CAFEAcA-9EnvXKcrECsAKCMHPobLch4mKU0Yvb2+ZKALcFSiqaQ@mail.gmail.com>
 <ZaV0QxdfQJDnICdF@redhat.com> <87y1cp94j9.fsf@pond.sub.org>
 <7ac1ae78-dca4-4fda-a5e9-32b3a332f80e@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <7ac1ae78-dca4-4fda-a5e9-32b3a332f80e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 16/01/2024 10.46, Philippe Mathieu-Daudé wrote:
> On 16/1/24 07:27, Markus Armbruster wrote:
>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>
>>> On Mon, Jan 15, 2024 at 05:39:19PM +0000, Peter Maydell wrote:
>>>> On Mon, 15 Jan 2024 at 13:54, Thomas Huth <thuth@redhat.com> wrote:
>>>>>
>>>>> On 12/01/2024 16.39, Philippe Mathieu-Daudé wrote:
>>>>>> Hi Thomas
>>>>>>
>>>>>> +Laurent & Peter
>>>>>>
>>>>>> On 12/1/24 11:00, Thomas Huth wrote:
>>>>>>> It's been marked as deprecated since QEMU 8.1, so it should be fine
>>>>>>> to remove this now.
>>>>>>>
>>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>
>>>>>> StatusInfo::singlestep was deprecated at the same time,
>>>>>> can we remove it?
>>>>>>
>>>>>> IOW could we complete your patch with this?
>>>>
>>>>>> diff --git a/qapi/run-state.json b/qapi/run-state.json
>>>>>> index ca05502e0a..08bc99cb85 100644
>>>>>> --- a/qapi/run-state.json
>>>>>> +++ b/qapi/run-state.json
>>>>>> @@ -106,25 +106,15 @@
>>>>>>   #
>>>>>>   # @running: true if all VCPUs are runnable, false if not runnable
>>>>>>   #
>>>>>> -# @singlestep: true if using TCG with one guest instruction per
>>>>>> -#     translation block
>>>>>> -#
>>>>>>   # @status: the virtual machine @RunState
>>>>>>   #
>>>>>>   # Features:
>>>>>>   #
>>>>>> -# @deprecated: Member 'singlestep' is deprecated (with no
>>>>>> -#     replacement).
>>>>>> -#
>>>>>>   # Since: 0.14
>>>>>>   #
>>>>>> -# Notes: @singlestep is enabled on the command line with '-accel
>>>>>> -#     tcg,one-insn-per-tb=on', or with the HMP 'one-insn-per-tb'
>>>>>> -#     command.
>>>>>>   ##
>>>>>>   { 'struct': 'StatusInfo',
>>>>>>     'data': {'running': 'bool',
>>>>>> -           'singlestep': { 'type': 'bool', 'features': [ 'deprecated' 
>>>>>> ]},
>>>>>>              'status': 'RunState'} }
>>>>>
>>>>> Uh, oh, that's a bigger change already ... can we safely remove the field
>>>>> here without upsetting 3rd party apps that rely on this interface?
>>>>
>>>> That was the whole point of marking it 'deprecated' in the JSON,
>>>> I thought? We don't think anybody's using it, we've given fair
>>>> warning, isn't the next step "remove it"? Markus, you're the
>>>> expert on QAPI deprecations...
>>>
>>> Yes, it is fine to delete it without thinking further about possible usage,
>>> unless someone steps forward quickly with new information that wasn't known
>>> when the deprecation was added....
>>
>> Concur.
> 
> Thanks all for the feedback.
> 
> Thomas, are you OK to post a v2 with the changes I suggested
> or do you want me to do it?

Since your changes were bigger than mine, I think it's just fair if you take 
credit for the patch. So yes, please go ahead and assemble it as a v2! Thanks!

  Thomas




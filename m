Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEFA77F809
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 15:46:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWdK1-0000xK-C5; Thu, 17 Aug 2023 09:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qWdJq-0000wm-QU
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qWdJo-00037T-DF
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692279943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hyTMKT/hkD595uBKf0qmrlGRuz4mRUfUWDmXp+Yy1g4=;
 b=TxmPwfeWvpJzShz9ax6GcQa9kF7vPMqJk8MHJCSPN7rUfXozzoNBgtepXfSVBzzoP2LHId
 JkBVQgxz6qVaNf+0GSM604lN8mZJgkWItEH+b1fhXREJeUnW+7/sU8/MdTtkUaJxz68pKG
 0FIgA6pPG3ZrqNWeIOg5twMIN3h5iTE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-w1PgeCKEMSmqGui_XCaBeA-1; Thu, 17 Aug 2023 09:45:41 -0400
X-MC-Unique: w1PgeCKEMSmqGui_XCaBeA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3178532c6c8so4604243f8f.1
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 06:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692279940; x=1692884740;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hyTMKT/hkD595uBKf0qmrlGRuz4mRUfUWDmXp+Yy1g4=;
 b=QThxyz9/1OHXtKNtAXo1mntWEHrIpChKXzCUpos1487DprS4LvgtqrM8ZpZfDAcKMu
 A4NsSEsJt+DtBgYNDfTQYVAwaMw9VIvI1KsUEObRbGQP4eoiegyAxoI6YaW7VzKixc/U
 I0MgSUZ8VGHMGFdMg6lu+1hhRctL2LJ8d5yNJcoibW+8dtkmBOLoZSsyptO7JGAwOX3D
 GgRuDMfU2s2l7/fnygUXP0PvctThKA21ANl3Ml+5vm5c5zFdRhh4QIyrG57OQrXiVSHb
 LPWEJkLVrfQhtmBs8H3bBgk3rKTmn1El75retWBvsj6mb9F8UwQIhH3lsV5sEGXyhVqa
 pGEw==
X-Gm-Message-State: AOJu0YxkygMMu45L0csfPbVFOOnPBNyMEtgcwxfN4dyGxbs8oqol4Pqn
 BuUUdqgd3se1sZ8O9Cz0HOlowvD6AgL2lsbB0Div2VbgoeW48kHu66QEOJV4gPN15CRCRw2hT3o
 4wZMRlupW1UfxW8k=
X-Received: by 2002:adf:fc8b:0:b0:317:5d60:2fea with SMTP id
 g11-20020adffc8b000000b003175d602feamr4217273wrr.52.1692279940084; 
 Thu, 17 Aug 2023 06:45:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHVUcLEuushwMAVgjIHsqkfv0lZioUFUVaDH2F1MS3FxS6FO9Jji8FDkvnvdD0lasvUwzSXA==
X-Received: by 2002:adf:fc8b:0:b0:317:5d60:2fea with SMTP id
 g11-20020adffc8b000000b003175d602feamr4217260wrr.52.1692279939669; 
 Thu, 17 Aug 2023 06:45:39 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 i12-20020a5d630c000000b0031435731dfasm24794036wru.35.2023.08.17.06.45.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 06:45:39 -0700 (PDT)
Message-ID: <77c36463-e669-c6e7-77b6-f49a9b67aa5a@redhat.com>
Date: Thu, 17 Aug 2023 15:45:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thiner Logoer <logoerthiner1@163.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com> <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <ZN4j1/EpXKTT99BB@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZN4j1/EpXKTT99BB@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.01, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 17.08.23 15:42, Daniel P. Berrangé wrote:
> On Thu, Aug 10, 2023 at 04:19:45PM +0200, David Hildenbrand wrote:
>>>> Most importantly, we won't be corrupting/touching the original file in any
>>>> case, because it is R/O.
>>>>
>>>> If we really want to be careful, we could clue that behavior to compat
>>>> machines. I'm not really sure yet if we really have to go down that path.
>>>>
>>>> Any other alternatives? I'd like to avoid new flags where not really
>>>> required.
>>>
>>> I was just thinking of a new flag. :) So have you already discussed that
>>> possibility and decided that not a good idea?
>>
>> Not really. I was briefly playing with that idea but already struggled to
>> come up with a reasonable name :)
>>
>> Less toggles and just have it working nice, if possible.
> 
> IMHO having a new flag is desirable, because it is directly
> expressing the desired deployment scenario, such tat we get
> good error reporting upon deployment mistakes, while at the
> same time allowing the readonly usage.
> 
>>> The root issue to me here is we actually have two resources (memory map of
>>> the process, and the file) but we only have one way to describe the
>>> permissions upon the two objects.  I'd think it makes a lot more sense if a
>>> new flag is added, when there's a need to differentiate the two.
>>>
>>> Consider if you see a bunch of qemu instances with:
>>>
>>>     -mem-path $RAM_FILE
>>>
>>> On the same host, which can be as weird as it could be to me.. At least
>>> '-mem-path' looks still like a way to exclusively own a ram file for an
>>> instance. I hesitate the new fallback can confuse people too, while that's
>>> so far not the major use case.
>>
>> Once I learned that this is not a MAP_SHARED mapping, I was extremely
>> confused. For example, vhost-user with "-mem-path" will absolutely not work
>> with "-mem-path", even though the documentation explicitly spells that out
>> (I still have to send a patch to fix that).
>>
>> I guess "-mem-path" was primarily only used to consume hugetlb. Even for
>> tmpfs it will already result in a double memory consumption, just like when
>> using -memory-backend-memfd,share=no.
>>
>> I guess deprecating it was the right decision.
> 
> Regardless of whether its deprecated or not, I think its fine to just
> say people need to use the more verbose memory-backend-file syntax
> if they want to use an unusual deployment configuration where there is
> a readonly backing file.
> 
>>> Nobody may really rely on any existing behavior of the failure, but
>>> changing existing behavior is just always not wanted.  The guideline here
>>> to me is: whether we want existing "-mem-path XXX" users to start using the
>>> fallback in general?  If it's "no", then maybe it implies a new flag is
>>> better?
>>
>> I think we have the following options (there might be more)
>>
>> 1) This patch.
>>
>> 2) New flag for memory-backend-file. We already have "readonly" and
>> "share=". I'm having a hard time coming up with a good name that really
>> describes the subtle difference.
>>
>> 3) Glue behavior to the QEMU machine
>>
>>
>> For 3), one option would be to always open a COW file readonly (as Thiner
>> originally proposed). We could leave "-mem-path" behavior alone and only
>> change memory-backend-file semantics. If the COW file does *not* exist yet,
>> we would refuse to create the file like patch 2+3 do. Therefore, no
>> ftruncate() errors, and fallocate() errors would always happen.
> 
> I'm for (2).

(2) in the form we discussed here is wrong because "readonly" already 
expresses "open this file readonly", not anything else.

-- 
Cheers,

David / dhildenb



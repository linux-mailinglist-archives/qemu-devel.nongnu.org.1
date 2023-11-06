Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F7E7E1A76
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 07:47:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztNa-0001sa-FX; Mon, 06 Nov 2023 01:46:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qztNT-0001sA-Q6
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:46:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qztNS-0007wP-7p
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699253184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lnpsB3aZQmq90xWoSUBI9m4vTd5DV6nDULOcMBSv9N0=;
 b=RsTSPCX2z/1VVmnu3Tp+vVWEFw80O6IEbTnVpt9BJjJVy4Z+twLepZSVD9pWSD+gwSlEIt
 n2h50E13W89EgwtZvgKJDliXHk2CamErKB2N5qWXkctDQKZy0/mIRtzQbdLusRn20U4Tf7
 80nPgX3uF8htvRz03UgHcEGuX1aYD24=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-tDxm5OOGO36wJEyBgvRZCQ-1; Mon, 06 Nov 2023 01:46:22 -0500
X-MC-Unique: tDxm5OOGO36wJEyBgvRZCQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9d891685063so290565266b.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253181; x=1699857981;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lnpsB3aZQmq90xWoSUBI9m4vTd5DV6nDULOcMBSv9N0=;
 b=ttBjHnGZPsJVfKDEKmnuK9RQKBWPuuBxZHQ53I5QM6uD0ZE3Iwl5fZ9FYeyHqXMDVr
 Ea3/EmeS7VQPHbG/IiO9QyxnJ8yTnm+YrNs1xOCpWxO7VOL7aYZBb987B9k1KA8yNhXJ
 Dt6TBbaJrlOPOzfDT3r/WjZ9jD/SU/AXpkNQ7HUqPG81epuLLgXX1l+8p18Unt/6yJQA
 fMjH+jPGOQwHeF5jig4qpvQSlF2mQQKCtja5e63UE3BjLxSLFZo4q4fDKLspMi6UBjrV
 llnVYK48xn4HWXYBQ8vmGJ0Sp4joSHCUWMKpwZS2B2JCzg5kGDWYTPde4SwnAyRjEPlH
 UQMQ==
X-Gm-Message-State: AOJu0YwgMsEManfZr7jDL+hRXsYAURMtOu294vf8GcchIUA+1JpmqEgD
 43BzRPQQVWawjBQLF4tLMbNgGBld7JG2i4d0zSoL9xzz/BYtxyy6kPBc1wt4D1cVEYpDhJOKG/C
 Z12O3xtQ83EdYmyQ=
X-Received: by 2002:a17:907:a03:b0:9e0:dcf:17ec with SMTP id
 bb3-20020a1709070a0300b009e00dcf17ecmr2290859ejc.30.1699253181744; 
 Sun, 05 Nov 2023 22:46:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE33AdjywWiHor4ZOXmaeVArfMkELqsPIPkSs1k8t7VkrErV68AORWTHOPyRijuMxSN+Ymt9g==
X-Received: by 2002:a17:907:a03:b0:9e0:dcf:17ec with SMTP id
 bb3-20020a1709070a0300b009e00dcf17ecmr2290844ejc.30.1699253181437; 
 Sun, 05 Nov 2023 22:46:21 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-177-215.web.vodafone.de.
 [109.43.177.215]) by smtp.gmail.com with ESMTPSA id
 q6-20020a170906b28600b009a1dbf55665sm3730465ejz.161.2023.11.05.22.46.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 22:46:21 -0800 (PST)
Message-ID: <c9d79f3c-18ea-4163-94f4-beb4c11d1b4b@redhat.com>
Date: Mon, 6 Nov 2023 07:46:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] hmp: synchronize cpu state for lapic info
To: Markus Armbruster <armbru@redhat.com>,
 Dongli Zhang <dongli.zhang@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org, philmd@linaro.org,
 kkostiuk@redhat.com, berrange@redhat.com, dwmw@amazon.co.uk,
 pbonzini@redhat.com, joe.jin@oracle.com
References: <20231026211938.162815-1-dongli.zhang@oracle.com>
 <87edhc9inl.fsf@secure.mitica>
 <f0adae79-7c6c-3e52-3bd1-f2e094d4a735@oracle.com>
 <871qd8elu7.fsf@pond.sub.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <871qd8elu7.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On 02/11/2023 07.00, Markus Armbruster wrote:
> Dongli Zhang <dongli.zhang@oracle.com> writes:
> 
>> Hi Juan,
>>
>> On 10/30/23 09:31, Juan Quintela wrote:
>>> Dongli Zhang <dongli.zhang@oracle.com> wrote:
>>>> While the default "info lapic" always synchronizes cpu state ...
>>>>
>>>> mon_get_cpu()
>>>> -> mon_get_cpu_sync(mon, true)
>>>>     -> cpu_synchronize_state(cpu)
>>>>        -> ioctl KVM_GET_LAPIC (taking KVM as example)
>>>>
>>>> ... the cpu state is not synchronized when the apic-id is available as
>>>> argument.
>>>>
>>>> The cpu state should be synchronized when apic-id is available. Otherwise
>>>> the "info lapic <apic-id>" always returns stale data.
>>>>
>>>> Reference:
>>>> https://urldefense.com/v3/__https://lore.kernel.org/all/20211028155457.967291-19-berrange@redhat.com/__;!!ACWV5N9M2RV99hQ!KOLfuCesLC4T6ka9bjf4x6ncC34GPK9pVvWwOJhbwSZw2fwp3Mxlakk0fnR-NCoqRPKOX7X4SOAxozQBC7VQ$
>>>>
>>>> Cc: Joe Jin <joe.jin@oracle.com>
>>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>>> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
>>>
>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>>
>>> But I wonder how I did get CC'd on this patch O:-)
>>>
>>
>> Thank you very much!
>>
>> This component does not have a maintainer. I just blindly cc all suggested
>> reviewers :), in order to get it reviewed and merged.
>>
>> get_maintainer.pl: No maintainers found, printing recent contributors.
>> get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.
> 
> I posted a fix the other day:
> 
>      Subject: [PATCH] MAINTAINERS: Fully cover target/i386/*
>      Message-ID: <20231030085336.2681386-1-armbru@redhat.com>
>      https://lore.kernel.org/all/20231030085336.2681386-1-armbru@redhat.com/

I wrote a slightly better patch a month ago already (since these files do 
not only belong to TCG, but also to the other accelerators):

  https://lore.kernel.org/qemu-devel/20230929134551.395438-1-thuth@redhat.com/

Unfortunately, it got ignored so far :-(

  Thomas



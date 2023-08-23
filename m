Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83626785B51
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 17:00:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYpL8-0006VJ-4y; Wed, 23 Aug 2023 11:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYpKI-0004qf-EN
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:59:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYpKG-0008C3-UK
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692802756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qt89BsPnt8P8NAFbZcZcx/T1PBDtGqrnVgj6RBXsg/o=;
 b=A1nxGTltIX8JvFukVIkXOXf99bsE9pvNVlOxXG0DF8mXqEAbd9BFERPxfQe4vvS4mdd9wc
 BiZQjcu0sPMvIH+jECL6TsQG1M48gWbeBlYAAFv6H+1jML5lwiSURQyJrmXuGH10eTA3je
 jwUuLfY307ON9I8RnVUfhRTqCkBufuE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-TvbRTgItNRuX520N4irFaQ-1; Wed, 23 Aug 2023 10:59:15 -0400
X-MC-Unique: TvbRTgItNRuX520N4irFaQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fef698fb3cso13035145e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 07:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692802754; x=1693407554;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qt89BsPnt8P8NAFbZcZcx/T1PBDtGqrnVgj6RBXsg/o=;
 b=OdKHOnL5GeKMjJsknIrAsnqFq+93Ff/cAoSx4hTB7VmeXJoNJlmwBihQXCLd/ensgE
 9Bdv1OHjJn6s2ceo2XVzx35EbzNwlv02msRIaFPN5V3H2JXz8eGGERRWqiy8oL+ZzS2O
 U1nRxBoB/jyDuBgab7ONu0QfKSwjFUSYwp3F4o0O1+N6/ebC0txoaPVqTYp1SOUXTHvz
 uV9zzX+7IdTZfp1BEGK/av+kZOi5w8N0PKoM6ae7rHj9ohbLX3ShkAOLQ6TUEgLdshU3
 xvQPb6PhjLQbrEBydEyth+Est4Vj5DCqwk2MUwaLE+zNw2SPZi9c0DKun/BMF73E4nJb
 MhRw==
X-Gm-Message-State: AOJu0YxHAOkYy3gSmZM8SUwFBR+lHcsZM83fgnpSa1P5lhAImPuWG/go
 iUWEJ+UH7H8Pp61cnGBW+dWYxiCqhV9DDUl56GDlfs+Pwookqm27J4cU6bMyNTh7hCP9Z3msrGh
 sL8G8bD0SHyg2nBw=
X-Received: by 2002:a1c:7303:0:b0:3fe:23ec:2494 with SMTP id
 d3-20020a1c7303000000b003fe23ec2494mr9409560wmb.7.1692802753823; 
 Wed, 23 Aug 2023 07:59:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGAK09D67wm98uSKedpz0zTXIui1ZPRrL52OkUvscpN9+BdcQHj+vph7g4VU+jlD5E7B4NsA==
X-Received: by 2002:a1c:7303:0:b0:3fe:23ec:2494 with SMTP id
 d3-20020a1c7303000000b003fe23ec2494mr9409527wmb.7.1692802753437; 
 Wed, 23 Aug 2023 07:59:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:e700:4d5c:81e2:253e:e397?
 (p200300cbc70ce7004d5c81e2253ee397.dip0.t-ipconnect.de.
 [2003:cb:c70c:e700:4d5c:81e2:253e:e397])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a05600c294400b003fe2a40d287sm2608319wmd.1.2023.08.23.07.59.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 07:59:12 -0700 (PDT)
Message-ID: <85fcd6d9-d87c-68be-d053-93d69763fde6@redhat.com>
Date: Wed, 23 Aug 2023 16:59:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: ThinerLogoer <logoerthiner1@163.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Greg Kurz <groug@kaod.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230822114504.239505-1-david@redhat.com>
 <20230822114504.239505-4-david@redhat.com>
 <5537a603.478c.18a1da37f4a.Coremail.logoerthiner1@163.com>
 <049b3601-5d57-d772-8365-a3e9bf9f03bc@redhat.com>
 <79eeb4c6.8f5c.18a22dd8c80.Coremail.logoerthiner1@163.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 3/9] backends/hostmem-file: Add "rom" property to
 support VM templating with R/O files
In-Reply-To: <79eeb4c6.8f5c.18a22dd8c80.Coremail.logoerthiner1@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.684, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 23.08.23 16:47, ThinerLogoer wrote:
> At 2023-08-23 20:43:48, "David Hildenbrand" <david@redhat.com> wrote:
>>>> +        The ``rom`` option specifies whether to create Read Only Memory (ROM)
>>>> +        that cannot be modified by the VM. If set to ``on``, the VM cannot
>>>> +        modify the memory. If set to ``off``, the VM can modify the memory.
>>>> +        If set to ``auto`` (default), the value of the ``readonly`` property
>>>> +        is used. This option is primarily helpful for VM templating, where we
>>>> +        want to open a file readonly (``readonly=on``) and allow private
>>>> +        modifications of the memory by the VM (``share=off``, ``rom=off``).
>>>> +
>>>>       ``-object memory-backend-ram,id=id,merge=on|off,dump=on|off,share=on|off,prealloc=on|off,size=size,host-nodes=host-nodes,policy=default|preferred|bind|interleave``
>>>>           Creates a memory backend object, which can be used to back the
>>>>           guest RAM. Memory backend objects offer more control than the
>>>
>>> In one word, I'd suggest advertising the existence of "rom" option more invasively, whenever
>>> private file mapping is used.
>>>
>>> IMHO you should probably be more invasive here to warn unconditionally when
>>> the memory backend file is going to be opened readwrite but is mapped non shared.
>>
>> As Daniel said, we should not add new warnings for sane use cases. But we can indeed give a hint when opening the file failed, see below.
>>
> 
> Well I don't think it's completely sane use cases though we can keep it for backward
> compatibility.

Well, yes, but these are sane use cases that have been using that way of 
dealing with files forever. We cannot simply change their usage, 
unfortunately.

Having that said, your important use case is currently VM templating. 
Note that that's not what the many other QEMU users actually do.

So I can understand why you want a different behavior and more hints; 
but we have to balance a bit here (after all, I'm writing documentation 
how to do VM templating for a reason ;) ).

[...]
>>>
>>> When the file is readonly, the error message is:
>>> ```
>>> qemu-system-x86_64: can't open backing store pc.ram for guest RAM: Permission denied
>>> ```
>>>
>>> This should be probably helpful if qemu found that the file exists as a regular file and
>>> is mapped private, to say something like
>>>
>>> ```
>>> qemu-system-x86_64: can't open backing store pc.ram for guest RAM: Permission denied
>>> tip: mapping is private and ram file is probably readonly, maybe you should append "readonly=on,rom=off"
>>> to "-object memory-backend-file,..." option list. see documentation xxx for details
>>> ```
>>
>> What about the following, if we can indeed open the file R/O and we're dealing witha  private mapping:
>>
>> qemu-system-x86_64: can't open backing store tmp-file for guest RAM: Permission denied
>> Consider opening the backing store read-only using '-object memory-backend-file,readonly=on,rom=off,...' (see "VM templating" documentation)
>>
>> ?
> 
> This is good. Wording might need improvement. (Are qemu error messages always this cold?)

Maybe. Maybe just my writing style :P

Looking at most error_append_hint(), they are fairly neutral/cold.

-- 
Cheers,

David / dhildenb



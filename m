Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C53AC3BE9
	for <lists+qemu-devel@lfdr.de>; Mon, 26 May 2025 10:43:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTQc-0001ll-Rp; Mon, 26 May 2025 04:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJTQa-0001lQ-Fp
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJTQX-0006aM-Qf
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748249000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=s8DE80Td/nxvKj2swsElwBivZTPZIAQDtr4/zFJZS/s=;
 b=KUxslVCrKoq1HC7vBcRyZ5cvIE27trfG3/bCfv4rl5lFgra+ZcLPffyefms5YHyB2ponm3
 JQZ9LeKpdU1nmJcj1IMEbXFrtCHsvQbkL58log6BfAYWdwDyJS+C7ee8Jdm6Gpz6nEzzzm
 ttNwyl4rI78zN7Naj7oh8Bn9K9wIb00=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-QiNmxIGdOFqZ2bP92Wo_XA-1; Mon, 26 May 2025 04:43:19 -0400
X-MC-Unique: QiNmxIGdOFqZ2bP92Wo_XA-1
X-Mimecast-MFC-AGG-ID: QiNmxIGdOFqZ2bP92Wo_XA_1748248998
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-442cd12d151so16584555e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 01:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748248998; x=1748853798;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s8DE80Td/nxvKj2swsElwBivZTPZIAQDtr4/zFJZS/s=;
 b=ChaYMDSEy/C+wiCAoILVyhhoUV2BAXWPYFRNTmZxuXYZzrA11dfQ3qc6GV++rAfNkW
 jbRqpEXOKHHnPhfnqO26eFuxedFwTcRvLC62WLePL/VsxHWR0E3ZOPquzo3BZj6MR01z
 9iYXNoAFN45wYq5lc+KFrWjaMUCWyhgHy5xdaGdX3Z4bSsix/Wu9cpgqivV5tJcApsgm
 jDIts9bRFLB28pP7RImXBrfKY/TTOWZ3mXCPzCLSut+eivl0C0oOOfNj3y7xfUKFEA24
 oQ58rW99h3VeY6j75QXbdJKZ9lUDtCKQg1nGhrqf1fx42bwdx/8NMASEFLQ7oW9o9HgM
 i88Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJx3xDuzSYxmP3T9Sa6D9+AwX6qzIhpl0qLCoYHH5s3ewZnbCepDIibhg0lFTANmw7oi0wjh0owDZf@nongnu.org
X-Gm-Message-State: AOJu0Yz1A6sTK9/TNO/FaBZTc+hMMKZc74oU96S5N8lUKGrF6emSwgp1
 PXjngCwYkeHqFctefs3W+kz9TbjKUi2jkMQaTryLdFPOCfs1PTecIvcNTSi6omXlSox1gRqOPXH
 3PNwqmnJpyGaZZ9cRu3TDZDczN23026BPMs0wOcz5TYl7QCgPFH1eHieJ
X-Gm-Gg: ASbGncvk8ZjUTLtRLmhlQUpJx04bJK3H/cf3gXXQZMJiHWgIn3eG2ENpD/v/vTZcnJx
 zosUy/L/bEifAulWVbXkV+w0dYz0eGE5JH66jUQSuXJh77oW3E0mDSq+fQ+bE/lTQmhFJlhvJcA
 w1vK+vU2O4jBYqAsVgT8wFkOFNZ1dXKMpmRN5TU6H4v+9SyNutOed3BjhQ9cUu5/5cRTtrONKdB
 VS9FuFsDci+ghV/hl9GmOu6FPfnk9JKxVE+VGEFO3pkuPFQnFpa1BRafSw7qKRSZm54OghUN+IO
 CNQ7C86BUmOotQmCSM8/Y9rXZlqJyO1HBgUuMQy3S6Ou6P3ESA==
X-Received: by 2002:a05:600c:8487:b0:44b:eb56:1d45 with SMTP id
 5b1f17b1804b1-44c921a8058mr81194805e9.15.1748248997955; 
 Mon, 26 May 2025 01:43:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuGXMCwLKrluuqwLRKVwvfi6IxAHr04AnloorJMNPhLZVD/PS4tEa1P1Ji7lmVaIg+dzH3zA==
X-Received: by 2002:a05:600c:8487:b0:44b:eb56:1d45 with SMTP id
 5b1f17b1804b1-44c921a8058mr81194415e9.15.1748248997593; 
 Mon, 26 May 2025 01:43:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca9417dsm34028717f8f.101.2025.05.26.01.43.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 01:43:17 -0700 (PDT)
Message-ID: <0d300bd0-7c9e-4f14-bb85-877da56fdc9d@redhat.com>
Date: Mon, 26 May 2025 10:43:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/4] hw/vfio/ap: Storing event information for an
 AP configuration change event
To: Anthony Krowiak <akrowiak@linux.ibm.com>,
 Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com
References: <20250512180230.50129-1-rreyes@linux.ibm.com>
 <20250512180230.50129-4-rreyes@linux.ibm.com>
 <7d1699d4-6d7d-4de3-a0bc-6dd345d9c2dd@redhat.com>
 <31cc61cf-d2f9-45ea-b825-623ae619c298@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <31cc61cf-d2f9-45ea-b825-623ae619c298@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/22/25 20:55, Anthony Krowiak wrote:
> 
> 
> 
> On 5/22/25 9:30 AM, Cédric Le Goater wrote:
>> On 5/12/25 20:02, Rorie Reyes wrote:
>>> These functions can be invoked by the function that handles interception
>>> of the CHSC SEI instruction for requests indicating the accessibility of
>>> one or more adjunct processors has changed.
>>>
>>> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
>>> ---
>>>   hw/vfio/ap.c                 | 39 ++++++++++++++++++++++++++++++++++++
>>>   include/hw/s390x/ap-bridge.h | 22 ++++++++++++++++++++
>>>   2 files changed, 61 insertions(+)
>>>
>>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>>> index 5ea5dd9cca..4f88f80c54 100644
>>> --- a/hw/vfio/ap.c
>>> +++ b/hw/vfio/ap.c
>>> @@ -96,6 +96,45 @@ static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
>>>     }
>>>   +int ap_chsc_sei_nt0_get_event(void *res)
>>> +{
>>> +    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
>>> +    APConfigChgEvent *cfg_chg_event;
>>> +
>>> +    if (!ap_chsc_sei_nt0_have_event()) {
>>> +        return 1;
>>> +    }
>>> +
>>> +    cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
>>> +    memset(nt0_res, 0, sizeof(*nt0_res));
>>> +
>>> +    QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
>>
>> btw, I don't know if this was discussed. Are we OK to manipulate the
>> 'cfg_chg_events' construct withou locking ?
> 
> This has never been discussed, but it's an interesting question. The
> ap_chsc_sei_nt0_get_event and ap_chsc_sei_nt0_have_event functions
> are called as a result of a SIE exit to handle interception of a
> CHSC SEI instruction. Handling of the intercepted instructions is
> done under the Big QEMU Lock (see kvm_arch_handle_exit in target/s390x/kvm/kvm.c),
> so presumably no other processes will get access to these functions
> until the instruction is handled.
> 
> On the other hand, the vfio_cfg_chg_notifier_handler function that handles the eventfd
> indicating the guest's AP configuration has been changed by the host device driver
> adds  APConfigChgEvent objects to this queue. If, however, you think about the flow,
> when the notifier handler gets called to handle an AP config changed event, it
> queues a channel request word (CRW) indicating there is an SEI pending. Consequently,
> the ap_chsc_sei_nt0_get_event and ap_chsc_sei_nt0_have_event functions will get called
> only after the guest receives the CRW event and executes the CHSC SEI instruction. Since
> the Big QEMU Lock is taken when the CHSC SE instruction is intercepted, it can not proceed
> until whatever the holding process releases it; so for that flow, it seems highly likely if not
> impossible for conflict given the event will always be added to the queue before an attempt
> can be made to retrieve it.
> 
> Having gone through this dissertation, I don't see how it can hurt to lock the queue when
> it is being accessed and would certainly make things bullet proof. What is your opinion?

In that case, let's keep it simple (no mutex) and add a assert(bql_locked())
statement where we think the bql should be protecting access to shared
resources.

Thanks,

C.



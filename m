Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8216793715
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 10:22:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdnnQ-0002fE-EL; Wed, 06 Sep 2023 04:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdnnP-0002eX-6k
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 04:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdnnK-0003S7-U6
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 04:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693988510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tbon2s8hkyBwqsAxqgp+dtbH79tQJO+hQK4DGPmqEzs=;
 b=QfEqOhq8TG47fuYc9u7BxuiSxhd/Nqet+w8+NexaU+3k8srca6WQnbXETJqwAkvdMbhNpz
 2tWpPZW6Xep8VRMMbZzjbujemPIUWW2VFkEOiLHyY1objyDghklsVXrbxWDAQl93z+Ttt7
 uEPHwpC1NAQgwEhO3b+8kXAv3OyTaiA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-1bX4LLjROPWElZP8lU4BSg-1; Wed, 06 Sep 2023 04:21:48 -0400
X-MC-Unique: 1bX4LLjROPWElZP8lU4BSg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-402c46c4a04so20523755e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 01:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693988507; x=1694593307;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tbon2s8hkyBwqsAxqgp+dtbH79tQJO+hQK4DGPmqEzs=;
 b=G5Z8/f1Ywm+kzXRqfHOovffCAo/G8nJNFah7wlIrrCk4xIgKhnX2qS8Oc0szFqPjeK
 oownPoz6Bj5Vn6/YoXEH9N7MXPFkWlvE4J4wgiBVdHbwduofhIJrj4FNXoFKTACdKniY
 P3SBMfXay+cCxpWqsjSusrNvolI7YOF9bzqVfpx2E1XTAohE07o7vnfb3hBffb7cp+UM
 P909T/3pKnUxB/f0QGmsaSDGYz/xtdDt3T7w6wvpN+gQVn0AmufZ40atm+GBH8TMb6RD
 nDx5b18pAcB/p61nUc0b2AA3rkiWj1VbN3bK9Y5G5gH4AF7sfx8zWrMyTVw6iha51GFh
 K2hQ==
X-Gm-Message-State: AOJu0YzMvu/Dw7am+S9qB4RTDkeRm1SPBDBkc57u+8r73M8aKXXGMpus
 QmobxJKtcRevgDnQIP6tHLe0HBhRcYJ9FEEBaEYxPy4/fIAAisowm++jeMzWzqX8WAqR452w7ss
 vKXIP72Q5dk4ayO8=
X-Received: by 2002:a7b:c3d0:0:b0:3fa:8db4:91ec with SMTP id
 t16-20020a7bc3d0000000b003fa8db491ecmr1539411wmj.10.1693988507541; 
 Wed, 06 Sep 2023 01:21:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/NGS7eW1c91zClRcAqjxS3Fu0aQSDixXKTcxg5szWUYJ2DRhAxVsNtvLBQziWqSZwulkVgA==
X-Received: by 2002:a7b:c3d0:0:b0:3fa:8db4:91ec with SMTP id
 t16-20020a7bc3d0000000b003fa8db491ecmr1539389wmj.10.1693988507250; 
 Wed, 06 Sep 2023 01:21:47 -0700 (PDT)
Received: from [10.33.192.187] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a05600c00c200b003fe3674bb39sm19065795wmm.2.2023.09.06.01.21.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 01:21:46 -0700 (PDT)
Message-ID: <eb7a0ed0-250e-c4cd-f862-5f5dd3c7fc13@redhat.com>
Date: Wed, 6 Sep 2023 10:21:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
References: <20230901155812.2696560-1-nsg@linux.ibm.com>
 <20230901155812.2696560-4-nsg@linux.ibm.com>
 <f97e26f0-8a43-eef7-b228-5fa5f3f0bffc@redhat.com>
 <4df5a37496ed0a0912926f19406efcce114beaf1.camel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v22 03/20] target/s390x/cpu topology: handle STSI(15) and
 build the SYSIB
In-Reply-To: <4df5a37496ed0a0912926f19406efcce114beaf1.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 05/09/2023 17.25, Nina Schoetterl-Glausch wrote:
> On Tue, 2023-09-05 at 15:26 +0200, Thomas Huth wrote:
>> On 01/09/2023 17.57, Nina Schoetterl-Glausch wrote:
>>> From: Pierre Morel <pmorel@linux.ibm.com>
>>>
>>> On interception of STSI(15.1.x) the System Information Block
>>> (SYSIB) is built from the list of pre-ordered topology entries.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>>> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>>> ---
...
>>> +/**
>>> + * s390_topology_fill_list_sorted:
>>> + *
>>> + * Loop over all CPU and insert it at the right place
>>> + * inside the TLE entry list.
>>> + * Fill the S390Topology list with entries according to the order
>>> + * specified by the PoP.
>>> + */
>>> +static void s390_topology_fill_list_sorted(S390TopologyList *topology_list)
>>> +{
>>> +    CPUState *cs;
>>> +    S390TopologyEntry sentinel;
>>> +
>>> +    QTAILQ_INIT(topology_list);
>>> +
>>> +    sentinel.id.id = cpu_to_be64(UINT64_MAX);

Since you don't do swapping for entry->id.id below, why do you do it here?

>>> +    QTAILQ_INSERT_HEAD(topology_list, &sentinel, next);
>>> +
>>> +    CPU_FOREACH(cs) {
>>> +        s390_topology_id id = s390_topology_from_cpu(S390_CPU(cs));
>>> +        S390TopologyEntry *entry, *tmp;
>>> +
>>> +        QTAILQ_FOREACH(tmp, topology_list, next) {
>>> +            if (id.id == tmp->id.id) {
>>> +                entry = tmp;
>>> +                break;
> 
> I think I'll add a comment here.
> 
> /*
>   * Earlier bytes have higher order -> big endian.
>   * E.g. an entry with higher drawer number should be later in the list,
>   * no matter the later fields (book, socket, etc)
>   */

Ugh, so this swapping is not due to real endianness issues, but just due to 
ordering? ... that's very ugly! I'd prefer to be more verbose and compare 
book by book, drawer by drawer, etc. instread. Or is this function that 
performance critical that we must save every possible CPU cycle here?

  Thomas


> 
>>> +            } else if (be64_to_cpu(id.id) < be64_to_cpu(tmp->id.id)) {
>>> +                entry = g_malloc0(sizeof(*entry));
>>
>> Maybe nicer to use g_new0 here instead?
> 
> I don't think it makes much of a difference.
> 
>>
>>> +                entry->id.id = id.id;
>>
>> Should this get a cpu_to_be64() ?
> 
> No, there is no interpretation of the value here, just a copy.
>>
>>> +                QTAILQ_INSERT_BEFORE(tmp, entry, next);
>>> +                break;
>>> +            }
>>> +        }
>>> +        s390_topology_add_cpu_to_entry(entry, S390_CPU(cs));
>>> +    }
>>> +
>>> +    QTAILQ_REMOVE(topology_list, &sentinel, next);
>>> +}
>>
>>    Thomas
>>
>>
> 



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B4D7D0A55
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 10:14:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtkdF-0007Wa-0i; Fri, 20 Oct 2023 04:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtkdB-0007U4-RT
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 04:13:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtkcw-0003kF-K1
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 04:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697789581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=04xXji+LJxvI6UY2tLIqTDZW0bqxMCV1T+WLcuQs1GA=;
 b=LfFvE+wPjNH8R6I8kzUGzSJFOsCgg85eghYkWYtCtaguEYDT5M+juo0F5B1xabBYDpuuCl
 XGCiG0K7NZ/a7FnJ2VZvfKOKfFjxqC5rDlpAIysP4YlqU48eoKNviA/KM5dg2PmlivXBmD
 1HnA56RrYeRApRToxFEyG5opv/5JmBQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-HuJNdZkuNR6Fpb9F_XBIZg-1; Fri, 20 Oct 2023 04:12:59 -0400
X-MC-Unique: HuJNdZkuNR6Fpb9F_XBIZg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-778a455f975so61863885a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 01:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697789579; x=1698394379;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=04xXji+LJxvI6UY2tLIqTDZW0bqxMCV1T+WLcuQs1GA=;
 b=tKzBOwRNVk9e1WkwtVqngJTZvbJaU4rD31YlkLUjJ3Fajplsc4iu8ZR1Owtys9Mw/J
 XJRK1ls8FQrn1gLh3+EJAUC25fBoeTPB1Vo1710M1dkfwLZCwfcISK1qqM41cs0+wfR8
 1iEnfeWcg6rVDt/oIYvtvvRcdIQJNT2sq4KS+5jNO0agZ3uUWhX5P+i+hdoWJfmbkU6J
 xZ4uqupfzckyfNWv0K6lqj4mZMY7mu3BAOu3g5NWkPHuws5cVZSaAiUUWHOqE6EZ+wuk
 GQyh7GdzUYWT5kSNwWjR+NaEt2mZ/igFXNmngFQgmTwSqt7NnvAAukd7kelkKavYevkj
 T9mw==
X-Gm-Message-State: AOJu0YwKfvyQemSWmMXHZAfbI7tS+3yiJBPqt7zqv9JwaHvJMf8qTQtK
 k7q6sDG2A5u64yXwnSdKsUQTSgYLK6K7rY0KcHNV76iwLN8bZoX+bbbUimP+Pi48HPNJAQFPx/P
 h3wvWAs28thyHxQo=
X-Received: by 2002:a05:6214:f61:b0:66d:8524:ebf0 with SMTP id
 iy1-20020a0562140f6100b0066d8524ebf0mr1258175qvb.15.1697789579385; 
 Fri, 20 Oct 2023 01:12:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1F/XT3OyhRJsUUjj9cBGFYwAQvtNg3lAv1bm94gj2S6iRXR86FnX8dq54L9iiXDhR8D0mGw==
X-Received: by 2002:a05:6214:f61:b0:66d:8524:ebf0 with SMTP id
 iy1-20020a0562140f6100b0066d8524ebf0mr1258140qvb.15.1697789579072; 
 Fri, 20 Oct 2023 01:12:59 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-141.web.vodafone.de.
 [109.43.176.141]) by smtp.gmail.com with ESMTPSA id
 i6-20020a05620a404600b007742c6823a3sm426203qko.108.2023.10.20.01.12.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 01:12:58 -0700 (PDT)
Message-ID: <fefe37b5-640c-4967-9dc6-ebae0c097b65@redhat.com>
Date: Fri, 20 Oct 2023 10:12:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] RFC migration: icp/server is a mess
Content-Language: en-US
To: Greg Kurz <groug@kaod.org>, Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, qemu-s390x@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Farman <farman@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Corey Minyard <minyard@acm.org>,
 Leonardo Bras <leobras@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Halil Pasic
 <pasic@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20231019190831.20363-1-quintela@redhat.com>
 <20231019190831.20363-8-quintela@redhat.com> <20231019233958.17abb488@bahia>
 <875y313g4b.fsf@secure.mitica> <20231020100626.57debfa4@bahia>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231020100626.57debfa4@bahia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 20/10/2023 10.06, Greg Kurz wrote:
> On Fri, 20 Oct 2023 09:30:44 +0200
> Juan Quintela <quintela@redhat.com> wrote:
> 
>> Greg Kurz <groug@kaod.org> wrote:
>>> On Thu, 19 Oct 2023 21:08:25 +0200
>>> Juan Quintela <quintela@redhat.com> wrote:
>>>
>>>> Current code does:
>>>> - register pre_2_10_vmstate_dummy_icp with "icp/server" and instance
>>>>    dependinfg on cpu number
>>>> - for newer machines, it register vmstate_icp with "icp/server" name
>>>>    and instance 0
>>>> - now it unregisters "icp/server" for the 1st instance.
>>>>
>>>> This is wrong at many levels:
>>>> - we shouldn't have two VMSTATEDescriptions with the same name
>>>> - In case this is the only solution that we can came with, it needs to
>>>>    be:
>>>>    * register pre_2_10_vmstate_dummy_icp
>>>>    * unregister pre_2_10_vmstate_dummy_icp
>>>>    * register real vmstate_icp
>>>>
>>>> As the initialization of this machine is already complex enough, I
>>>> need help from PPC maintainers to fix this.
>>>>
>>>> Volunteers?
>>>>
>>>> CC: Cedric Le Goater <clg@kaod.org>
>>>> CC: Daniel Henrique Barboza <danielhb413@gmail.com>
>>>> CC: David Gibson <david@gibson.dropbear.id.au>
>>>> CC: Greg Kurz <groug@kaod.org>
>>>>
>>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>>> ---
>>>>   hw/ppc/spapr.c | 7 ++++++-
>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index cb840676d3..8531d13492 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -143,7 +143,12 @@ static bool pre_2_10_vmstate_dummy_icp_needed(void *opaque)
>>>>   }
>>>>   
>>>>   static const VMStateDescription pre_2_10_vmstate_dummy_icp = {
>>>> -    .name = "icp/server",
>>>> +    /*
>>>> +     * Hack ahead.  We can't have two devices with the same name and
>>>> +     * instance id.  So I rename this to pass make check.
>>>> +     * Real help from people who knows the hardware is needed.
>>>> +     */
>>>> +    .name = "pre-2.10-icp/server",
>>>>       .version_id = 1,
>>>>       .minimum_version_id = 1,
>>>>       .needed = pre_2_10_vmstate_dummy_icp_needed,
>>>
>>> I guess this fix is acceptable as well and a lot simpler than
>>> reverting the hack actually. Outcome is the same : drop
>>> compat with pseries-2.9 and older.
>>>
>>> Reviewed-by: Greg Kurz <groug@kaod.org>
>>
>> I fully agree with you here.
>> The other options given on this thread is deprecate that machines, but I
>> would like to have this series sooner than 2 releases.
> 
> Yeah and, especially, the deprecation of all these machine types is
> itself a massive chunk of work as it will call to identify and
> remove other related workarounds as well. Given that pretty much
> everyone working in PPC/PAPR moved away, can the community handle
> such a big change ?

I think you could treat that as two work items. First the deprecation and 
removal of old machine types. Second the (optional) cleanups. If we don't 
immediately manage to find and remove each and every possible spot that 
could be cleaned up after the removal of the machine types, so be it. But 
better at least *start* to remove the old cruft, beginning with the machine 
type, than dragging this stuff along forever.

  Thomas



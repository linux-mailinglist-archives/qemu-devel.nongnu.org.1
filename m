Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 581D77CDD47
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:29:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6bB-0004iu-6h; Wed, 18 Oct 2023 09:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6b4-0004ig-0y
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:28:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6az-00045J-Vk
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697635701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ns51uTmFzS4BIC2HXprJBcjA/lnxaRRjCfWVlsgWGIU=;
 b=IIZb55Eob3L99KOiDkBa57HBn2OUgJQLDXvV1vc67v9hhOXUv247fScxzG+wxmp1vQU/u4
 luYaZ1mHSOB7Q4doV4csL1MMcIF4amEoKLOlY8BFGp0ZY1eFRkAj3d80Du6nzuG4ypz6EP
 S01/9GY2hRBJet/siwu7UP8OQNSLPJ0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-9R52IJY_OKu5-UcK291D0g-1; Wed, 18 Oct 2023 09:28:19 -0400
X-MC-Unique: 9R52IJY_OKu5-UcK291D0g-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-41cb577d45aso15223031cf.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697635699; x=1698240499;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ns51uTmFzS4BIC2HXprJBcjA/lnxaRRjCfWVlsgWGIU=;
 b=TdVKkimGccr0wL6VRo7hhcHVPXsmQuIMG5Uvnm6BF8NMgZds8A7Z8UWzYD8Iv7QKw5
 /sg1cAph5c4ARLoJ0pAZSCPo9UuEV2ELwI4vlU23wvywU1cxBOSGAVXz6d9OOWJDecyo
 s4k/yBDQtnDFdzEZ8nIu8FGQuyu/+kKZG7+NM3CBmykcSsK22ZdMY1fhzlFk3HR4HMMS
 aI8CFlcBq4Te2BuzAdu32/xiFN/XK89wXoSH3J67t2+iVOR1pHJq+voyS4quJMjGU+Xw
 PonP79dsMwV7EofAi6tdHK8hzT+rMTllFPThO8YiiFUc5CxJKpuXcw+1BstbAmRYgiSh
 iWlw==
X-Gm-Message-State: AOJu0YxkubALVPPCsnX56xG7ZTOJz+14Q6z1TGM/lTMDULD2P4DUGRaH
 knJ2JaXazi4pgH/CWhAxd6OGRXog+cHxDsSWU0DOUo8o45TQKECCKiCd7N7s+MKQSCHhiBVObhI
 5R2OeY6ms1wmoKTg=
X-Received: by 2002:ac8:7c52:0:b0:418:804:340d with SMTP id
 o18-20020ac87c52000000b004180804340dmr6142399qtv.48.1697635699423; 
 Wed, 18 Oct 2023 06:28:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2+M5yu4jaO9Ror4wUS6i38LK2tHEe3qmGNqJ9hvsDcaslncw39DcjMWVJglhRoI0FvnqxkQ==
X-Received: by 2002:ac8:7c52:0:b0:418:804:340d with SMTP id
 o18-20020ac87c52000000b004180804340dmr6142384qtv.48.1697635699159; 
 Wed, 18 Oct 2023 06:28:19 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-141.web.vodafone.de.
 [109.43.176.141]) by smtp.gmail.com with ESMTPSA id
 c8-20020a05622a058800b004181234dd1dsm522870qtb.96.2023.10.18.06.28.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 06:28:18 -0700 (PDT)
Message-ID: <eaf2569d-e9fb-45e0-a463-4055c41e0342@redhat.com>
Date: Wed, 18 Oct 2023 15:28:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/about: Mark the old pc-i440fx-2.0 - 2.3 machine
 types as deprecated
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231006075247.403364-1-thuth@redhat.com>
 <20231018091534-mutt-send-email-mst@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20231018091534-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18/10/2023 15.17, Michael S. Tsirkin wrote:
> On Fri, Oct 06, 2023 at 09:52:47AM +0200, Thomas Huth wrote:
>> As we've seen in the past, it's useful for deprecating old machine
>> types to finally be able to get of legacy code or do other clean-ups
>> (see e.g. commit ea985d235b868047 that was used to drop the PCI code in
>> the 128k bios binaries to free some precious space in those binaries).
>>
>> So let's continue deprecating the oldest pc machine types. QEMU 2.3
>> has been released 8 years ago, so that's plenty of time since such
>> machine types have been used by default, thus deprecating pc-i440fx-2.0
>> up to pc-i440fx-2.3 should be fine nowadays.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   docs/about/deprecated.rst | 8 ++++++++
>>   hw/i386/pc_piix.c         | 1 +
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index e43de9c183..c016bb9b20 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -277,6 +277,14 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
>>   better reflects the way this property affects all random data within
>>   the device tree blob, not just the ``kaslr-seed`` node.
>>   
>> +``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2)
>> +'''''''''''''''''''''''''''''''''''''''''''''''''''''
>> +
>> +These old machine types are quite neglected nowadays and thus might have
>> +various pitfalls with regards to live migration. Use a newer machine type
>> +instead.
>> +
>> +
>>   Backend options
>>   ---------------
> 
> Wait a sec. Which tree is this against?

It should be against master. The patch still applies cleanly for me... could 
you please double-check whether your master branch is up to date?

> I don't see this context ever since:
> 
> commit f59fb1889f480b0324a7ed0404a68ad5a0ad4f6c
> Author: Thomas Huth <thuth@redhat.com>
> Date:   Mon Jan 17 20:16:39 2022 +0100
> 
>      hw/i386/pc_piix: Mark the machine types from version 1.4 to 1.7 as deprecated

It's the context that has been left after Paolo moved the previous entries 
from deprecated.rst to removed-features.rst:

  https://gitlab.com/thuth/qemu/-/commit/ea985d235b868047cb4d8cb5657bc

> Also, do we intentionally keep 1.8 and 1.9 as not deprecated?

There never was a QEMU version 1.8 or 1.9, so there were never such machine 
types.

  Thomas




Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB80377964B
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 19:40:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUW78-0003rZ-Ki; Fri, 11 Aug 2023 13:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qUW71-0003qm-PJ
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 13:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qUW6x-0002hk-U1
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 13:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691775582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMJC0+wdHw8S6EHdoCIQ/0U3+crzTI5VlyaqHDJ5918=;
 b=WNzY9agECpJm1ZSoZwfLbGn04k7Yz2qnmFF6F6/b+p6K9Hw3QCtWqE2ME5KO/8i91Wrx2P
 WRvnEGS5yl2WAGKw9GZ5W7R+3GUkYo5B/8ubSlC0TNClrf8vg+99v7FDD5xoSN1O7aNdgr
 XOZ89hCZicWNHsAxw66DCfCtnkd3ixk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-rsiqQA-SPN-FkRnZ-2FeuA-1; Fri, 11 Aug 2023 13:39:41 -0400
X-MC-Unique: rsiqQA-SPN-FkRnZ-2FeuA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe661c0323so14434425e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 10:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691775579; x=1692380379;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZMJC0+wdHw8S6EHdoCIQ/0U3+crzTI5VlyaqHDJ5918=;
 b=aa1jAf2HhzS4SPJbx2N+x6EfgCFYNxURj4l/whblLsdL2CxgordmwG2P38Qv9tWl78
 9DpIQqP3qNCJI5q5GTykVHWSM6zS2VurDaMooIorKad6ORGOzVKqr6VwbgROPsI3Jkv1
 HwW7vhko0eWbDgm22AF6tNDeS7UOGR9Foa74IgF2/CuOoWixkri44V5vylXejM35IOWZ
 Vvaec1J/l/LjgggmLWmMNoYss1TsQiuM08FvYefqPKBZBYgC9B8r2IEe3PK+ca00tde8
 LnPTs6CGYifN8rtdmBkNPh14nFJOuNiG+g8ONGayEUffVz5MW/aRI8NomMkWKzMtdkCT
 4wqw==
X-Gm-Message-State: AOJu0Yy5U8uB57vvDKtuN2tTauEkZty6gfXMi6mI0f4CK+UTRdf/4T5F
 9Xqe+Ote7fGe2PW4g1UKOmR+KpwoqUf04r5ybijy+0vLXTXR3geF/MqBsT5VsalcAQPmyRunBQp
 9qqaOWY4TUTIw29c=
X-Received: by 2002:a7b:cc8d:0:b0:3f4:d18f:b2fb with SMTP id
 p13-20020a7bcc8d000000b003f4d18fb2fbmr2121615wma.8.1691775579588; 
 Fri, 11 Aug 2023 10:39:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsEBrj5jwV+gWTyOdgZEeYJCeFqp0bxX4MNo/RPGS+nZy/3F8pEUGgQCqfNP81SKvYgw9bbA==
X-Received: by 2002:a7b:cc8d:0:b0:3f4:d18f:b2fb with SMTP id
 p13-20020a7bcc8d000000b003f4d18fb2fbmr2121599wma.8.1691775579143; 
 Fri, 11 Aug 2023 10:39:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:3000:973c:c367:3012:8b20?
 (p200300cbc71a3000973cc36730128b20.dip0.t-ipconnect.de.
 [2003:cb:c71a:3000:973c:c367:3012:8b20])
 by smtp.gmail.com with ESMTPSA id
 n12-20020a7bcbcc000000b003fe557829ccsm8674610wmi.28.2023.08.11.10.39.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Aug 2023 10:39:38 -0700 (PDT)
Message-ID: <23397e32-4631-6160-d501-8dfa521a890f@redhat.com>
Date: Fri, 11 Aug 2023 19:39:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: ThinerLogoer <logoerthiner1@163.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 libvir-list@redhat.com
References: <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n> <9feaf960-637b-9392-3c8f-9e1ba1a7ca40@redhat.com>
 <996a69ff-e2dc-0ed0-2ac8-33fd53bd02c2@redhat.com> <ZNZez9ICBBf+D/d2@x1n>
 <e07f29a3-482a-3fcb-7aff-c88827c41385@redhat.com> <ZNZgRq22IXyqpun7@x1n>
 <b1630542-475a-f5de-bf79-f6519e01a350@redhat.com> <ZNZn29wEXUyD5Cc2@x1n>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
In-Reply-To: <ZNZn29wEXUyD5Cc2@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.972, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 11.08.23 18:54, Peter Xu wrote:
> On Fri, Aug 11, 2023 at 06:25:14PM +0200, David Hildenbrand wrote:
>> On 11.08.23 18:22, Peter Xu wrote:
>>> On Fri, Aug 11, 2023 at 06:17:05PM +0200, David Hildenbrand wrote:
>>>> We wouldn't touch "-mem-path".
>>>
>>> But still the same issue when someone uses -object memory-backend-file for
>>> hugetlb, mapping privately, expecting ram discard to work?
>>>
>>> Basically I see that example as, "hugetlb" in general made the private
>>> mapping over RW file usable, so forbidden that anywhere may take a risk.
>>
>> These users can be directed to using hugetlb
>>
>> a) using MAP_SHARED
>> b) using memory-backend-memfd, if MAP_PRIVATE is desired
>>
>> Am I missing any important use case? Are we being a bit to careful about
>> virtio-balloon and postcopy simply not being available for these corner
>> cases?
> 
> The current immediate issue is not really mem=rw + fd=rw + private case
> (which was a known issue), but how to make mem=rw + fd=ro + private work
> for ThinnerBloger, iiuc.
> 
> I'd just think it safer to expose that cap to solve problem A (vm
> templating) without affecting problem B (fallcate-over-private not working
> right), when B is uncertain.

Right, and I'm thinking about if B is worth the effort.

> 
> I'm also copy Daniel & libvirt list in case there's quick comment from
> there. Say, maybe libvirt never use private mapping on hugetlb files over
> memory-backend-file at all, then it's probably fine.

libvirt certainly allows setting <access mode="shared"/> with <source 
type="file">.

Could be that they also end up mapping "<hugepages>" to 
memory-backend-file instead of memory-backend-memfd (e.g., compatibility 
with older kernels?).

> 
> In all cases, you and Igor should have the final grasp; no stand on a
> strong opinon from my side.

I do value your opinion, so I'm still trying to figure out if there are 
sane use cases that really need a new parameter. Let's recap:

When opening the file R/O, resulting in fallocate() refusing to work:
* virtio-balloon will fail to discard RAM but continue to "be alive"
* virtio-mem will discard any private pages, but cannot free up disk
   blocks using fallocate.
* postcopy would fail early

Postcopy:
* Works on shmem (MAP_SHARED / MAP_PRIVATE)
* Works on hugetlb (MAP_SHARED / MAP_PRIVATE)
* Does not work on file-backed memory (including MAP_PRIVATE)

We can ignore virtio-mem for now. What remains is postcopy and 
virtio-balloon.

memory-backend-file with MAP_PRIVATE on shmem/tmpfs results in a double 
memory consumption, so we can mostly cross that out as "sane use case". 
Rather make such users aware of that :D

memory-backend-file with MAP_PRIVATE on hugetlb works. virtio-balloon is 
not really compatible with hugetlb, free-page-reporting might work 
(although quite non-nonsensical). So postcopy as the most important use 
case remains.

memory-backend-file with MAP_PRIVATE on file-backed memory works. 
postcopy does not apply. virtio-balloon should work I guess.


So the two use cases that are left are:
* postcopy with hugetlb would fail
* virtio-balloon with file-backed memory cannot free up disk blocks

Am I missing a case?

-- 
Cheers,

David / dhildenb



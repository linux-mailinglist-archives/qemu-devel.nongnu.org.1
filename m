Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C59F37AA9C6
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 09:10:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjaJ2-0004mC-7Z; Fri, 22 Sep 2023 03:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjaIy-0004jc-Q0
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:10:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjaIv-000857-PP
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695366620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Td4/Q9tc/kCcThoBN9cPyeNhNr581R6+KIqYHVDADZA=;
 b=WwQNxRU5R0XIqC2OeWp/czi/SjYfhjt9TBZDjh1Hhz8uzrZugT2/WUjo+DNk8zj32T09e+
 Slini8rk2nGxyzJVV03BtfT9HYAAGzNIR1RyJxnO6U0eW6BJ2mC9mrgcVULEQ81dgYsDfS
 tr6MF1bwjxNWjeN1pSE8anfzOdy+9xo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-FoYd8wnUOm20H8Opd4ZyJw-1; Fri, 22 Sep 2023 03:10:18 -0400
X-MC-Unique: FoYd8wnUOm20H8Opd4ZyJw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe182913c5so14176105e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 00:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695366617; x=1695971417;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Td4/Q9tc/kCcThoBN9cPyeNhNr581R6+KIqYHVDADZA=;
 b=h6FO1hgUc6tDJSSB4jTCnAOx3xiXSDP+0wm14Tv7tEbEsU4vuOo8D7QDmvsG2NoSJH
 5bdhg3al/+eHByWv0/3b5Hpo+sxDSVfnZWScMKJ28y7lLcfZc+tM4ArFQiYULzmedLgF
 d+1TnPL0A98Zf1ZPySYN4h4ot9rE5gnN5QaqGlfz3fLtMfpYVZXAu5eM1Tik8pXHqkHo
 EgTNS3cF189nmI7cKCMupMj7rUxi4lu5g24F5Jfs2wizHctYl7cLLe5Oa8iyo0lF4QqX
 hHf3AQSim3ySk95YQ0VYLBvtUh+CHHz9yyH6lTUNaDCJOAU9xHc03UsVQA6YlbJayl6C
 +BLw==
X-Gm-Message-State: AOJu0Yyovx9YYShj2rgrDBpR2DMjM5VUK56exOSx9RDRU7xrSQUlbVAr
 Khzl1W33FOFj07Zf5EKsCFQSz8DJzvjWWgZIaX7WMz3C3v9FQUQGZmEWzxxohwr/64m0b1O9rAt
 0sNMyrc/8OubAINMUk1L8c0E=
X-Received: by 2002:a7b:c44c:0:b0:403:442:5421 with SMTP id
 l12-20020a7bc44c000000b0040304425421mr7139593wmi.4.1695366617218; 
 Fri, 22 Sep 2023 00:10:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAxomf4h1ro8C6sRgiCNzMWwZXlyTRvBg3Cw4FUwNCPoMNI247nrTxr/f28pbjXF0e8BUUNw==
X-Received: by 2002:a7b:c44c:0:b0:403:442:5421 with SMTP id
 l12-20020a7bc44c000000b0040304425421mr7139571wmi.4.1695366616743; 
 Fri, 22 Sep 2023 00:10:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:7100:dfaf:df8b:54b9:7303?
 (p200300cbc71a7100dfafdf8b54b97303.dip0.t-ipconnect.de.
 [2003:cb:c71a:7100:dfaf:df8b:54b9:7303])
 by smtp.gmail.com with ESMTPSA id
 11-20020a05600c248b00b003fee567235bsm6718056wms.1.2023.09.22.00.10.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 00:10:16 -0700 (PDT)
Message-ID: <0ce93270-a1a9-df9a-761a-618b92ccef3b@redhat.com>
Date: Fri, 22 Sep 2023 09:10:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 00/21] QEMU gmem implemention
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
 isaku.yamahata@gmail.com, Claudio Fontana <cfontana@suse.de>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
 <fe9f3d19-df01-01e6-a253-f7fe5bdea41f@redhat.com>
 <ZQOu+OE8LWtLTyno@google.com>
 <103096a6-f4b5-d88a-2aac-07dcc86825d6@redhat.com>
 <ace06668-81fd-3153-5b93-30b0b82aea46@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ace06668-81fd-3153-5b93-30b0b82aea46@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 22.09.23 09:03, Xiaoyao Li wrote:
> On 9/21/2023 5:11 PM, David Hildenbrand wrote:
>>>>> 3. What is KVM_X86_SW_PROTECTED_VM going to look like? and do we
>>>>> need it?
>>>>>
>>>>
>>>> Why implement it when you have to ask others for a motivation? 😉
>>>>
>>>> Personally, I'm not sure if it is really useful, especially in this
>>>> state.
>>>
>>> Yeah, as of today, KVM_X86_SW_PROTECTED_VM is mainly a development
>>> vehicle,
>>> e.g. so that testing gmem doesn't require TDX/SNP hardware, debugging
>>> gmem guests
>>> isn't brutally painful, etc.
>>>
>>> Longer term, I have aspirations of being able to back most VMs with
>>> gmem, but
>>> that's going to require quite a bit more work, e.g. gmem needs to be
>>> mappable
>>> (when hardware allows it) so that gmem doesn't all but require double
>>> mapping,
>>> KVM obviously needs to be able to read/write gmem, etc.
>>>
>>> The value proposition is that having a guest-first memory type will
>>> allow KVM to
>>> optimize and harden gmem in ways that wouldn't be feasible for a more
>>> generic
>>> memory implementation.  E.g. memory isn't mapped into host userspace
>>> by default
>>> (makes it harder to accidentally corrupt the guest), the guest can
>>> have *larger*
>>> mappings than host userspace, guest memory can be served from a
>>> dedicated pool
>>> (similar-ish to hugetlb), the pool can be omitted from the direct map,
>>> etc.
>>>
>> Thanks for that information. Personally, I don't believe "to back most
>> VMs with gmem", but that's a different discussion.
>>
>> As a development vehicle to get TDX up and running it might be very
>> valuable indeed. But it doesn't necessarily have to be merged in QEMU
>> for that case -- especially in a semi-finished form.
> 
> It's true and I agree with it. I'll drop the KVM_X86_SW_PROTECTED_VM
> part in next version.
> 
> How would you like this series to proceed in next version? only the
> patches of gmem support without a user? or together with next QEMU TDX
> series?

Makes sense to me. GMEM series can be a prereq for QEMU TDX.

-- 
Cheers,

David / dhildenb



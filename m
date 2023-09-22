Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5257E7AA9D3
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 09:11:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjaJs-0005Wr-67; Fri, 22 Sep 2023 03:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjaJo-0005WS-PI
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:11:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjaJn-00006D-9s
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695366673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UFNwEiXcFSjpvjHc3z5XjBokxCgPL9Ikt3S3AYhjxmg=;
 b=FmQHIafpobTqayFpRy+5oIDYC8/Adz5OC6RwajSn15vbYlpPi698zVX+ZSZUM11P8L0wBn
 GVKye/i3jB/G3sQ8BaLiOGnLbu25Xp2eGCx8rDJnukh5xbaLywJM/UfsF88/NNBm/ccaoy
 5CDOKjyY1C6axobBDd+0Lg/k5hnYG4k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-FiaV6HE2MAGIBrrXzrJQwA-1; Fri, 22 Sep 2023 03:11:11 -0400
X-MC-Unique: FiaV6HE2MAGIBrrXzrJQwA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-314256aedcbso1211078f8f.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 00:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695366671; x=1695971471;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UFNwEiXcFSjpvjHc3z5XjBokxCgPL9Ikt3S3AYhjxmg=;
 b=HPHRBQAgwkwANQ1dRGSBFj8UhtP7UhU91y1MdEU/Polga8OYGWI+oVGhnPWv7I3wEy
 R+W/Iqk/OFel5GUZQosSDjE7Yz32rBPdGqtzfzngi9aryhqqqUkPm+6VFL6TfHKBydpw
 sbNKBkrheCvQ2NX7bSrOJ5VyjGvlUBTHWCyXh7GFrxfFiGiBc3P6G3Dfsnwa/ySkNopj
 AE5y+ItjITpkR6DWflHvwAOKAWw36lU4GM+XVzZa0kpRt0M4nxmk9trpUcQCduZLgZnV
 s+hcOtbpLxwC3H6RUvYmzPjcrizhggxQ9T9GbJSAYRgXxUIKFrrjb8QkaCLkD/KK5s79
 mldg==
X-Gm-Message-State: AOJu0YzaqpFQEKnxH9MWHJtahMY6lUwMymZv31ip99pgCYmLsqAx9nh5
 Ss69xSlDZk4ikgxHRU0Dbqr8ZkpShzhgTSijlKDD5S0ZqAZUOFLO3SCjjH2tIkIAVcLH9Y0HtB3
 2OUFqcJo8dsGoZAU=
X-Received: by 2002:a5d:674b:0:b0:321:56af:5ef9 with SMTP id
 l11-20020a5d674b000000b0032156af5ef9mr7141188wrw.70.1695366670856; 
 Fri, 22 Sep 2023 00:11:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOeCSf8ZFg/EoCi9LkN9QWr/WmQE7XBq7TZBFIu93EVlLq6FjR1pA4a905mxBSMyORw9fylA==
X-Received: by 2002:a5d:674b:0:b0:321:56af:5ef9 with SMTP id
 l11-20020a5d674b000000b0032156af5ef9mr7141162wrw.70.1695366670485; 
 Fri, 22 Sep 2023 00:11:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:7100:dfaf:df8b:54b9:7303?
 (p200300cbc71a7100dfafdf8b54b97303.dip0.t-ipconnect.de.
 [2003:cb:c71a:7100:dfaf:df8b:54b9:7303])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a05600c11c900b003feef82bbefsm3817779wmi.29.2023.09.22.00.11.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 00:11:10 -0700 (PDT)
Message-ID: <9bf45e57-a1be-50c6-fecd-23bbfb8e7c62@redhat.com>
Date: Fri, 22 Sep 2023 09:11:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 07/21] i386/pc: Drop pc_machine_kvm_type()
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
 <20230914035117.3285885-8-xiaoyao.li@intel.com>
 <b5ebeeac-9f0f-eb57-b5e2-4c03698e5ee4@redhat.com>
 <11ada91d-4054-2ce9-9a3b-4d182106e860@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <11ada91d-4054-2ce9-9a3b-4d182106e860@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 22.09.23 02:24, Xiaoyao Li wrote:
> On 9/21/2023 4:51 PM, David Hildenbrand wrote:
>> On 14.09.23 05:51, Xiaoyao Li wrote:
>>> pc_machine_kvm_type() was introduced by commit e21be724eaf5 ("i386/xen:
>>> add pc_machine_kvm_type to initialize XEN_EMULATE mode") to do Xen
>>> specific initialization by utilizing kvm_type method.
>>>
>>> commit eeedfe6c6316 ("hw/xen: Simplify emulated Xen platform init")
>>> moves the Xen specific initialization to pc_basic_device_init().
>>>
>>> There is no need to keep the PC specific kvm_type() implementation
>>> anymore.
>>
>> So we'll fallback to kvm_arch_get_default_type(), which simply returns 0.
>>
>>> On the other hand, later patch will implement kvm_type()
>>> method for all x86/i386 machines to support KVM_X86_SW_PROTECTED_VM.
>>>
>>
>> ^ I suggest dropping that and merging that patch ahead-of-time as a
>> simple cleanup.
> 
> I suppose the "that" here means "this patch", right?


With that I meant that paragraph "On the other hand, later patch ...".

-- 
Cheers,

David / dhildenb



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 605527A8739
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 16:38:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiyLH-0006D9-8Z; Wed, 20 Sep 2023 10:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiyKn-00060y-TG
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 10:37:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiyKl-00028e-OT
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 10:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695220662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlq3VkBDAxx+UjHYCFzjOoTvzQT81SMPJV0LfgL/qPA=;
 b=Q0jzNGOiVU3NtukRcaVV+dBV+RtNPCs6CbpSc5HALH7HrbAktis7bGfiKPjIkTx+2uRU02
 snNWcr/SFB1XomVb2TEkrwt41bbY8zm8uefEnBOKwblK9ZrAqampc8mWjH/sHBpbRNX+gS
 j/dgc9K09ztEdQSPjsLT5+Q6oSwMSOI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-vDuJi5VXOjCBjvxc93oNuA-1; Wed, 20 Sep 2023 10:37:40 -0400
X-MC-Unique: vDuJi5VXOjCBjvxc93oNuA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-321677c0c89so1327118f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 07:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695220659; x=1695825459;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zlq3VkBDAxx+UjHYCFzjOoTvzQT81SMPJV0LfgL/qPA=;
 b=UWCk5HaXjUVDHkrBsvJaQalwbxjBjP9RC2YUAEpvnWE0HU+4l4qkRBwOrm2CD9i4zc
 vapM+MlGWFBMqQ++HAdCA3VYFEcy0/UHKWc1Nf69BXY/5onkpfFqCrwttQnf1fSDh4TR
 QZkkbr6AXbBUpFrVy7QSn5YlTPz08qLt02IboR9c/jmH1gNXgXtH4DColMz+ktxZMAS2
 xdThcG77mdJzkH6dXGc2bUnx3Xj9IpoqdDSXuwraqXBRHf0shRY1h8tgazBycSIduQkg
 hR5YTDKo1/fiqLT3Ptoa4ACmnUKZT4Yo78ejKXEHjOxN4HMeOCdpw3uNauq03wkGMPWd
 sIHg==
X-Gm-Message-State: AOJu0YxByqj/lfhvuImOe1kA509xAWyvyaJ9XYsAjgIMUwn31pQ9gbtg
 DhAhYSVMWX3SJChPsV33wuSJEScSxSb0wqLTaVzfTgUeLaxhoYdExahZNx+pju5FNZdQGwNiK4F
 VK/u/ivdurTDEXl4=
X-Received: by 2002:adf:d0ca:0:b0:317:5d3d:c9df with SMTP id
 z10-20020adfd0ca000000b003175d3dc9dfmr2502556wrh.18.1695220659489; 
 Wed, 20 Sep 2023 07:37:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf+51aOLzrkPF34PeABVEpjaMEBK7fHn4+QjePH2TZCT8NykDAtUFDJp9i3G5so9YKLNfbEA==
X-Received: by 2002:adf:d0ca:0:b0:317:5d3d:c9df with SMTP id
 z10-20020adfd0ca000000b003175d3dc9dfmr2502535wrh.18.1695220659038; 
 Wed, 20 Sep 2023 07:37:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:8600:dad5:13bb:38a9:3010?
 (p200300cbc70b8600dad513bb38a93010.dip0.t-ipconnect.de.
 [2003:cb:c70b:8600:dad5:13bb:38a9:3010])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a5d6b07000000b0031f3780ce60sm18555247wrw.7.2023.09.20.07.37.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Sep 2023 07:37:38 -0700 (PDT)
Message-ID: <091a40cb-ec26-dd79-aa26-191dc59c03e6@redhat.com>
Date: Wed, 20 Sep 2023 16:37:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 03/21] HostMem: Add private property and associate
 it with RAM_KVM_GMEM
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
 <20230914035117.3285885-4-xiaoyao.li@intel.com> <8734zazeag.fsf@pond.sub.org>
 <d0e7e2f8-581d-e708-5ddd-947f2fe9676a@intel.com>
 <878r91nvy4.fsf@pond.sub.org>
 <da598ffc-fa47-3c25-64ea-27ea90d712aa@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <da598ffc-fa47-3c25-64ea-27ea90d712aa@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 20.09.23 16:35, Xiaoyao Li wrote:
> On 9/20/2023 3:30 PM, Markus Armbruster wrote:
>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>
>>> On 9/19/2023 5:46 PM, Markus Armbruster wrote:
>>>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>>>
>>>>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>>>>
>>>>> Add a new property "private" to memory backends. When it's set to true,
>>>>> it indicates the RAMblock of the backend also requires kvm gmem.
>>>> Can you add a brief explanation why you need the property?
>>>
>>> It provides a mechanism for user to specify whether the memory can serve as private memory (need request kvm gmem).
>>
>> Yes, but why would a user want such memory?
>>
> 
> Because KVM demands it for confidential guest, e.g., TDX guest. KVM
> demands that the mem slot needs to have KVM_MEM_PRIVATE set and has
> valid gmem associated if the guest accesses it as private memory.

I think as long as there is no demand to have a TDX guest with this 
property be set to "off", then just don't add it.

With a TDX VM, it will can be implicitly active. If we ever have to 
disable it for selective memory backends, we can add the property and 
have something like on/off/auto. For now it would be "auto".

-- 
Cheers,

David / dhildenb



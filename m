Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D28093CE92
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Jul 2024 09:10:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXF4c-0001O6-Kt; Fri, 26 Jul 2024 03:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sXF4b-0001NX-5a
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 03:09:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sXF4Y-0007Kx-N3
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 03:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721977739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ghwuio5+/SgiDjfFr/JTBXvbe6xBSz8IkBHhgtGDYhE=;
 b=D3cVzo73z8jEQvsPjdLNpuzepGCPiguWwFAdShAmWP5ehn0gZgoXcaElyozMBqQy+dLDCW
 i/TwPcLFJZKiZ42LsxTcirVlxNW/UNGW9bKzlDXp95xdP0TL7rPopFkPjtTXam+p6iBPPz
 3t1vqhxUUDiX3l+Korx+Qsq4xH3861E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-Ju583f4NMTGJiFwVVdNR6g-1; Fri, 26 Jul 2024 03:08:55 -0400
X-MC-Unique: Ju583f4NMTGJiFwVVdNR6g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4280645e3e0so11481435e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 00:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721977734; x=1722582534;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Ghwuio5+/SgiDjfFr/JTBXvbe6xBSz8IkBHhgtGDYhE=;
 b=wOgJodHfFwP6dShN6ycyLwSrPoi4p8VocLkRXQ1HOX87S8H6zm0UrT5wJgsk8G2haa
 hNRKHu40qzDjJO6N5vHrWmh/uUcfxkzLYEEIqoCCeJgrvWdkhvW/tYZOeFW8V6QkrjMn
 CmA7q8hGHcAH86wdTJbWNwpqBhHpyir3al2vWK5VYdGJVQX9t3OD+CW3zSQangKn7d6r
 4PYmpc9keqzW9d08RWVLDG3z6tC0dbljbrZDLNvVWtfiUtibSsTof/JpDhbRVZUi3U/b
 aUTGx+djMoBm1YQnT2SaieW63HUR1L6fJmTvDfcRBdrCVw7fcC1TqI9HVP2z5kszBKg7
 wk5Q==
X-Gm-Message-State: AOJu0Yx2DE6pHyZDis6ZDSUt3+XpHxgfSQAqH3p/EIMC9bHfVucRukTW
 MIIz7brAmeBTOzjg7bHirBqWKGCwT7ox0fZwK9eCi1IOPxOJdMeq6AmBFbmHpYz9o0ACO3rGIUj
 PJtS8HxJP4UG3IMA9dCZj+sqhqNMaR/+EG/826qEqRaN/wRmuKA4o
X-Received: by 2002:a05:600c:1c99:b0:426:5440:854a with SMTP id
 5b1f17b1804b1-42805503f76mr30822225e9.1.1721977733842; 
 Fri, 26 Jul 2024 00:08:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe02C44YkJFBggkgPtghWCAuOmFtiVibExAnOgRn40gMf6add/iq48j1Ye0koyKDnsJmmIgg==
X-Received: by 2002:a05:600c:1c99:b0:426:5440:854a with SMTP id
 5b1f17b1804b1-42805503f76mr30821975e9.1.1721977733312; 
 Fri, 26 Jul 2024 00:08:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:a600:7ca0:23b3:d48a:97c7?
 (p200300cbc713a6007ca023b3d48a97c7.dip0.t-ipconnect.de.
 [2003:cb:c713:a600:7ca0:23b3:d48a:97c7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280574ad97sm63590185e9.24.2024.07.26.00.08.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 00:08:52 -0700 (PDT)
Message-ID: <c9556944-16e4-4eb0-b9cd-56426099f813@redhat.com>
Date: Fri, 26 Jul 2024 09:08:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] Enable shared device assignment
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "Qiang, Chenyi" <chenyi.qiang@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Wang, Wei W" <wei.w.wang@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
 "Wu, Hao" <hao.wu@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
References: <20240725072118.358923-1-chenyi.qiang@intel.com>
 <ace9bb98-1415-460f-b8f5-e50607fbce20@redhat.com>
 <BN9PR11MB527635939C0A2A0763E326A58CB42@BN9PR11MB5276.namprd11.prod.outlook.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <BN9PR11MB527635939C0A2A0763E326A58CB42@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 26.07.24 07:02, Tian, Kevin wrote:
>> From: David Hildenbrand <david@redhat.com>
>> Sent: Thursday, July 25, 2024 10:04 PM
>>
>>> Open
>>> ====
>>> Implementing a RamDiscardManager to notify VFIO of page conversions
>>> causes changes in semantics: private memory is treated as discarded (or
>>> hot-removed) memory. This isn't aligned with the expectation of current
>>> RamDiscardManager users (e.g. VFIO or live migration) who really
>>> expect that discarded memory is hot-removed and thus can be skipped
>> when
>>> the users are processing guest memory. Treating private memory as
>>> discarded won't work in future if VFIO or live migration needs to handle
>>> private memory. e.g. VFIO may need to map private memory to support
>>> Trusted IO and live migration for confidential VMs need to migrate
>>> private memory.
>>
>> "VFIO may need to map private memory to support Trusted IO"
>>
>> I've been told that the way we handle shared memory won't be the way
>> this is going to work with guest_memfd. KVM will coordinate directly
>> with VFIO or $whatever and update the IOMMU tables itself right in the
>> kernel; the pages are pinned/owned by guest_memfd, so that will just
>> work. So I don't consider that currently a concern. guest_memfd private
>> memory is not mapped into user page tables and as it currently seems it
>> never will be.
> 
> Or could extend MAP_DMA to accept guest_memfd+offset in place of
> 'vaddr' and have VFIO/IOMMUFD call guest_memfd helpers to retrieve
> the pinned pfn.

In theory yes, and I've been thinking of the same for a while. Until 
people told me that it is unlikely that it will work that way in the future.

> 
> IMHO it's more the TIO arch deciding whether VFIO/IOMMUFD needs
> to manage the mapping of the private memory instead of the use of
> guest_memfd.
> 
> e.g. SEV-TIO, iiuc, introduces a new-layer page ownership tracker (RMP)
> to check the HPA after the IOMMU walks the existing I/O page tables.
> So reasonably VFIO/IOMMUFD could continue to manage those I/O
> page tables including both private and shared memory, with a hint to
> know where to find the pfn (host page table or guest_memfd).
> 
> But TDX Connect introduces a new I/O page table format (same as secure
> EPT) for mapping the private memory and further requires sharing the
> secure-EPT between CPU/IOMMU for private. Then it appears to be
> a different story.

Yes. This seems to be the future and more in-line with 
in-place/in-kernel conversion as e.g., pKVM wants to have it. If you 
want to avoid user space altogether when doing shared<->private 
conversions, then letting user space manage the IOMMUs is not going to work.


If we ever have to go down that path (MAP_DMA of guest_memfd), we could 
have two RAMDiscardManager for a RAM region, just like we have two 
memory backends: one for shared memory populate/discard (what this 
series tries to achieve), one for private memory populate/discard.

The thing is, that private memory will always have to be special-cased 
all over the place either way, unfortunately.

-- 
Cheers,

David / dhildenb



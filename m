Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 546CCABB7F2
	for <lists+qemu-devel@lfdr.de>; Mon, 19 May 2025 10:54:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGwGX-0003ff-2G; Mon, 19 May 2025 04:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uGwGU-0003fI-3y
 for qemu-devel@nongnu.org; Mon, 19 May 2025 04:54:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uGwGR-0000oc-JV
 for qemu-devel@nongnu.org; Mon, 19 May 2025 04:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747644865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=j2suVxLSiSy1mzuk6wt2esJOsGgr2N/Q910i2Xe5O2o=;
 b=d/FVT+gqgzJEP62WrogggBYvU6ogf0PPCEOkJno5+db4KQknAc1NAyXnP+sElQCIqQbhnq
 A4yWKkaDMtiS6tgTMNhtY7/DuT7jS/DR24N4GqWxHaq5I5/iabp/mmIawbeomYOq13sHgC
 yZRWA6NmG+G53XdCDVXwXSfeH9njSfo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-3LW97kK_OZOm97GbrBh09A-1; Mon, 19 May 2025 04:54:22 -0400
X-MC-Unique: 3LW97kK_OZOm97GbrBh09A-1
X-Mimecast-MFC-AGG-ID: 3LW97kK_OZOm97GbrBh09A_1747644861
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a0db717b55so2872285f8f.3
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 01:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747644861; x=1748249661;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j2suVxLSiSy1mzuk6wt2esJOsGgr2N/Q910i2Xe5O2o=;
 b=kNL69OqlZDMWqVQInIWVGHDyv5592J4D9s03DBVYuYZpCZJ2oimyLuU9DrZKzWt3mR
 Er2jkMEEo/qWcZv/loD76WbMYpjYcwFzG2DmaHQ9+avH0U9ufjrnfwGNirJJBdrA6510
 K5VLI5XjV2Rfzytu/B01FXuRgWzACH5Sslb9qT6eiDRoaYNa8M2Zm5Ogd4nmTtukA4pj
 Yk9Q/Pomg7ZSjuXWbo4fw4QVW9AlC+w5nLaG/W+kqiXOOBiBiyvbZSpQj6DkPmFQMxXe
 wLLaarG4IxXk1e/wGwKpjS7piiz5bzB1EYRy2KoTbUzm7j/1vwZHILdjCbkE9WFLSp2g
 By+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC49OYNaYNUCDxb2T+BfjLaFQyHla5p9xzXOyAD8+IONwinvrBE/YJaNCPnRn+WUTvx+ddJg4weklV@nongnu.org
X-Gm-Message-State: AOJu0YxPbSSk0blVbCrFmV6tH47SrGtlxTFjik3UOkwAsEwojF5TqJbm
 0YvXpfaFTWYRiUhRJX0ldyXZ2XXFTIXRz6bzGV9dQKRSlC0RUyY80UfnBJ3kbjvJRrtNaYPOu4L
 10Hn+TUuqz5yV0/BIDW9c3TQK0Y2hZJGDF/7sLrH7L0LmSrtnMZX7O1JJ
X-Gm-Gg: ASbGncsOrmj8X5/Z5ypzPLM0mi+mTL4ng44/16jVOb/fs5CCVIzkNqzbgh6ewAka2t5
 a1q6eVzV3tvbv/rgybA873nju76SkMHIRxqt0YsMqfBUCgywJTNWFRMkBt6yNBcuOtz/XbdptJp
 hS2hPDiLhJiL+AHKc16kkmF8WPRL0gCDg63c0QkkFwWrW7+F2rx/2Y0dxBJQEZSmnd0VyO7DIkQ
 bMFyHWvn3+DpBMtT9+Jx7BfEWVTJHXHPe9lQfPjzVI1MHsYrkvhunt8uw19x1yGbxcmHrJ57BUb
 yBzn2A1Fpc57kkfGtnI2Y7cudlUBg57JoiXltlstfCLPMBu9PQ==
X-Received: by 2002:a05:6000:1ac8:b0:3a3:6f40:3d85 with SMTP id
 ffacd0b85a97d-3a36f403df2mr2033746f8f.37.1747644860998; 
 Mon, 19 May 2025 01:54:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHWoyF3fpuaIUD4vURlh/+a/vbcGccNl06bB+sMd1WfeNVeZU+yd+ZilNGNh/+jh9kIP2oQA==
X-Received: by 2002:a05:6000:1ac8:b0:3a3:6f40:3d85 with SMTP id
 ffacd0b85a97d-3a36f403df2mr2033728f8f.37.1747644860593; 
 Mon, 19 May 2025 01:54:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a360b0b766sm11612481f8f.56.2025.05.19.01.54.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 01:54:19 -0700 (PDT)
Message-ID: <15c1e96e-6d37-40e4-9667-767b37fddadd@redhat.com>
Date: Mon, 19 May 2025 10:54:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 00/42] Live update: vfio and iommufd
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, John Levon <john.levon@nutanix.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1ad33986-dac9-4d89-ae54-e2ba31cee748@redhat.com>
 <e13a8672-9c76-4739-89fc-91033b0a031a@oracle.com>
 <0f6632dc-7751-417f-a37d-b476a47ae60f@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <0f6632dc-7751-417f-a37d-b476a47ae60f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/16/25 21:48, Steven Sistare wrote:
> On 5/16/2025 1:17 PM, Steven Sistare wrote:
>> On 5/16/2025 12:37 PM, Cédric Le Goater wrote:
>>> Steve,
>>>
>>> + John
>>>
>>> On 5/12/25 17:32, Steve Sistare wrote:
>>>> Support vfio and iommufd devices with the cpr-transfer live migration mode.
>>>> Devices that do not support live migration can still support cpr-transfer,
>>>> allowing live update to a new version of QEMU on the same host, with no loss
>>>> of guest connectivity.
>>>>
>>>> No user-visible interfaces are added.
>>>>
>>>> For legacy containers:
>>>>
>>>> Pass vfio device descriptors to new QEMU.  In new QEMU, during vfio_realize,
>>>> skip the ioctls that configure the device, because it is already configured.
>>>>
>>>> Use VFIO_DMA_UNMAP_FLAG_VADDR to abandon the old VA's for DMA mapped
>>>> regions, and use VFIO_DMA_MAP_FLAG_VADDR to register the new VA in new
>>>> QEMU and update the locked memory accounting.  The physical pages remain
>>>> pinned, because the descriptor of the device that locked them remains open,
>>>> so DMA to those pages continues without interruption.  Mediated devices are
>>>> not supported, however, because they require the VA to always be valid, and
>>>> there is a brief window where no VA is registered.
>>>>
>>>> Save the MSI message area as part of vfio-pci vmstate, and pass the interrupt
>>>> and notifier eventfd's to new QEMU.  New QEMU loads the MSI data, then the
>>>> vfio-pci post_load handler finds the eventfds in CPR state, rebuilds vector
>>>> data structures, and attaches the interrupts to the new KVM instance.  This
>>>> logic also applies to iommufd containers.
>>>>
>>>> For iommufd containers:
>>>>
>>>> Use IOMMU_IOAS_MAP_FILE to register memory regions for DMA when they are
>>>> backed by a file (including a memfd), so DMA mappings do not depend on VA,
>>>> which can differ after live update.  This allows mediated devices to be
>>>> supported.
>>>>
>>>> Pass the iommufd and vfio device descriptors from old to new QEMU.  In new
>>>> QEMU, during vfio_realize, skip the ioctls that configure the device, because
>>>> it is already configured.
>>>>
>>>> In new QEMU, call ioctl(IOMMU_IOAS_CHANGE_PROCESS) to update mm ownership and
>>>> locked memory accounting.
>>>>
>>>> Patches 4 to 12 are specific to legacy containers.
>>>> Patches 25 to 41 are specific to iommufd containers.
>>>
>>> For v4, could you please send a first "part I" with patches [1-20] ?
>>> I think these are reviewed, or nearly, and could be merged quickly.
> 
> Just to help you keep track, these are the remaining vfio patches for you
> to review before I send V4:
> 
>    vfio/container: recover from unmap-all-vaddr failure

yes. I haven't read your other replies yet.

>    vfio-pci: preserve MSI
>    vfio-pci: preserve INTx

IRQ changes are for later because they conflit with vfio-user.

Thanks,

C.



> 
> - Steve
> 
>>> Even if the "Live update: vfio and iommufd" series is not fully
>>> reviewed yet, there are good signs that it will before the end of
>>> the QEMU 10.1 cycle. The same applies to vfio-user.
>>>
>>> We need to bring together the proposals changing memory_get_xlat_addr().
>>> It's important as it is blocking both the vfio-user series and yours.
>>> This can be done in parallel.
>>>
>>> Then we can address the iommufd part.
>>
>> OK.  I was already preparing memory_get_xlat_addr when I received your email.
>>
>> - Steve
>>
> 



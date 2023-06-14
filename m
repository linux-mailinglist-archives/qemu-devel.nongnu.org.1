Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A46B72F8BB
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 11:11:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9MW1-0002VI-L8; Wed, 14 Jun 2023 05:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q9MW0-0002V2-0G
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 05:10:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q9MVy-00077q-Cb
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 05:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686733805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8HURIhnaM69iRttU1+pKgIm0TAFPtJYpzFlhjrQhN60=;
 b=O4CfmT8C+tT8Ns+XwxVlhHP4qCx6DG5ao74GRWdf0IQrudMC9GkeXnU4lHEc0rv0oinQHV
 nOu59RlkBmuDLVEpPM6qRRX3vmmqzd10SJfwKvZmCddcGuusl8rhOh7JiAIwiOB8JrRVuW
 K9su6kTNifng9Nqaor+gc/xGJcFbi4E=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-hxDD5A7tMHeLOoWMG4iOPA-1; Wed, 14 Jun 2023 05:10:04 -0400
X-MC-Unique: hxDD5A7tMHeLOoWMG4iOPA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4edc7406cbaso1370633e87.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 02:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686733802; x=1689325802;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8HURIhnaM69iRttU1+pKgIm0TAFPtJYpzFlhjrQhN60=;
 b=MA4DNnIX7JJgdCkIJM59ywvzl4jKCO7wW3hmXFOhMTGODf9rWcTwTsS1ElVN74I7Zo
 +SZ7p2OhZA9aIaDK8FElN41WZrf3TMm3v0VHK8yXuXNwtseRVKesU7o/5QC+PcsXbbci
 MKwJXcjDZbt0kwgXRiVFqkwQX8YsucmgFQzctgJ040LZqhqqzeAbV9lhmPO31mhhKwaR
 0m3AbYFHxMHZ1qsyk75nvpLq0Bv76kbG+E8BvyergUfRKNpfhH7Mw97oFEZgBSNhI71g
 0/W+vcHl0bnHkdrlhcYln8bGRvvyYZ33rA/6PYEb8ApkbxyV1R/QGyoK/7zl/y6MSNZg
 uy/g==
X-Gm-Message-State: AC+VfDwAFRG8CEct/CLO0nMdH5KjT05WmzMVm6+3Byx06px9yv5kuHuW
 GHX/IwGIFkKvX8SFzAO8c9IR5uUSeRjC+g7H/+CXCYfsKF7bgiRwf52TFACaD9/MJftQxpZWbf6
 VfAmsyYHk17WqzxF4IIv9d2lu8jBMYJ/ooAYc+YDAndcCp80UvK1Ks3YYdw85n2JbLd/Up8M=
X-Received: by 2002:a05:6512:286:b0:4f6:3ab6:3d9e with SMTP id
 j6-20020a056512028600b004f63ab63d9emr7691113lfp.59.1686733802725; 
 Wed, 14 Jun 2023 02:10:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5aGhXJ0bTPYvv3F9EEWFY8KyxFfstNJ8eIPqnfv8VadgfEJ4YQ3R23QtatFgsguP+U/SfiBQ==
X-Received: by 2002:a05:6512:286:b0:4f6:3ab6:3d9e with SMTP id
 j6-20020a056512028600b004f63ab63d9emr7691080lfp.59.1686733802254; 
 Wed, 14 Jun 2023 02:10:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:b200:7d03:23db:ad5:2d21?
 (p200300cbc704b2007d0323db0ad52d21.dip0.t-ipconnect.de.
 [2003:cb:c704:b200:7d03:23db:ad5:2d21])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a7bc8c9000000b003f8140763c7sm11729459wml.30.2023.06.14.02.10.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 02:10:01 -0700 (PDT)
Message-ID: <83978976-1b13-8300-19b0-7b3c24be556c@redhat.com>
Date: Wed, 14 Jun 2023 11:10:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 00/10] memory-device: Some cleanups
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230601121447.272487-1-david@redhat.com>
 <20230601121447.272487-2-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230601121447.272487-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.098, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 01.06.23 14:14, David Hildenbrand wrote:
> Working on adding multi-memslot support for virtio-mem (teaching memory
> device code about memory devices that can consume multiple memslots), I
> have some preparatory cleanups in my queue that make sense independent of
> the actual memory-device/virtio-mem extensions.
> 
> v2 -> v3:
> - "memory-device: Introduce machine_memory_devices_init()"
> -- Declare the function in hw/boards.h
> - "hw/loongarch/virt: Use machine_memory_devices_init()"
> -- Use VIRT_HIGHMEM_BASE
> -- No need to include memory-device.h
> - "hw/i386/pc: Remove PC_MACHINE_DEVMEM_REGION_SIZ"
> -- Add more details why it's ok to the patch description
> - Adjust to memory_devices_init() -> machine_memory_devices_init()
> - Add RBs
> 
> v1 -> v2:
> - Allocate ms->device_memory only if the size > 0.
> - Split it up and include more cleanups
> 
> David Hildenbrand (10):
>    memory-device: Unify enabled vs. supported error messages
>    memory-device: Introduce machine_memory_devices_init()
>    hw/arm/virt: Use machine_memory_devices_init()
>    hw/ppc/spapr: Use machine_memory_devices_init()
>    hw/loongarch/virt: Use machine_memory_devices_init()
>    hw/i386/pc: Use machine_memory_devices_init()
>    hw/i386/acpi-build: Rely on machine->device_memory when building SRAT
>    hw/i386/pc: Remove PC_MACHINE_DEVMEM_REGION_SIZE
>    memory-device: Refactor memory_device_pre_plug()
>    memory-device: Track used region size in DeviceMemoryState
> 
>   hw/arm/virt.c          |  9 +-----
>   hw/i386/acpi-build.c   |  9 ++----
>   hw/i386/pc.c           | 36 +++-------------------
>   hw/loongarch/virt.c    | 12 ++------
>   hw/mem/memory-device.c | 69 +++++++++++++++++++-----------------------
>   hw/ppc/spapr.c         | 37 +++++++++++-----------
>   hw/ppc/spapr_hcall.c   |  2 +-
>   include/hw/boards.h    |  4 +++
>   include/hw/i386/pc.h   |  1 -
>   9 files changed, 67 insertions(+), 112 deletions(-)
> 

Any further comments? If not, I'm planning on taking this through my 
memory-device tree.

-- 
Cheers,

David / dhildenb



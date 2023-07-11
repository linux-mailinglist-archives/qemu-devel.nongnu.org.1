Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BA374EB4B
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 11:57:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJA6D-0002We-Br; Tue, 11 Jul 2023 05:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJA6A-0002Vs-Sp
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 05:55:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJA68-0006mu-UP
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 05:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689069356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DzsbIMpcdxaHltEiCTHwV8Dsk+inxl58VAQnRcIdVOM=;
 b=Pv3Kth82Y6R4lLsWiuR8ClXECM2LxkEwCemnp6sdrsb9cyR14Z/ZrQa+HGx5B9WKaKQ4WA
 fzO+ZUjARYpq2bFurSwY587Tg6npY5luW8rGHlZKEzdfxi7hB3jBC80A8EXZ6lOjGOA1O9
 iRzKiFUkkx2EyRC48aTWqzyB7sbcaYQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-0TwjRZV-OLKNbvdsQr24Xg-1; Tue, 11 Jul 2023 05:55:54 -0400
X-MC-Unique: 0TwjRZV-OLKNbvdsQr24Xg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-314291caa91so3123736f8f.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 02:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689069353; x=1691661353;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DzsbIMpcdxaHltEiCTHwV8Dsk+inxl58VAQnRcIdVOM=;
 b=T/BCA8Aa663vs1zOc+fAxOXwT2UMBEhnYei+VXH/KRWl51rx+xrjil+d6TcV61Q6w8
 xYgVI9d8Yn+YdGgeTQPqhbt8in4DPYEnW9kyzfytZTJj+Dk3irLFMwLJn6cF7O/Fd9zw
 Ywkdz7OSrfApaMXurbqSfBcYovxd1x9DAQ/d6cU7GGm9jFLW8klr0O2WCiAYTkY5x+J3
 RIz15lbBcHB2vIvLdD8RVKgeZUlcDcQEXlD2acmMTetdbCsSlgP888d1oqkdHB1rUgNr
 T12xI1x8MaTEZ3NZUZWvdD/fzw/QxJBcMptu+8U+r2qwJzcBqXUevS554iEL4hAEOLzg
 Cm2w==
X-Gm-Message-State: ABy/qLZSrl9L23wzGUB5Zy8FoBH4PrGpPQybEB1weOkTDgkTY4kwBHl0
 Y0YkNCZCQCMnS8TDdR4zuADuLVtQ2XjpAtG5NzFa57IMsLeKdM5I7k6Ag3Ng90GyrsQaKGhybCY
 Zt1+qu9caMexQ0SA=
X-Received: by 2002:a5d:5386:0:b0:314:1e60:a1da with SMTP id
 d6-20020a5d5386000000b003141e60a1damr14435050wrv.30.1689069353703; 
 Tue, 11 Jul 2023 02:55:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHZOjVjqehTaU83izDrZ/g70LqYKNO3UiWv+tS8K7JKKUN2DAp1SjHZtHeFGK922Xw1Cdwp9w==
X-Received: by 2002:a5d:5386:0:b0:314:1e60:a1da with SMTP id
 d6-20020a5d5386000000b003141e60a1damr14435037wrv.30.1689069353386; 
 Tue, 11 Jul 2023 02:55:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:4000:13ad:ed64:37e6:115d?
 (p200300cbc745400013aded6437e6115d.dip0.t-ipconnect.de.
 [2003:cb:c745:4000:13ad:ed64:37e6:115d])
 by smtp.gmail.com with ESMTPSA id
 t1-20020a5d49c1000000b0031444673643sm1785494wrs.57.2023.07.11.02.55.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 02:55:51 -0700 (PDT)
Message-ID: <b5c777e4-c9a9-00bb-37be-f468a8845348@redhat.com>
Date: Tue, 11 Jul 2023 11:55:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/7] arm/virt: Use virtio-md-pci (un)plug functions
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Gavin Shan <gshan@redhat.com>, Mario Casquero <mcasquer@redhat.com>
References: <20230710100714.228867-1-david@redhat.com>
 <20230710100714.228867-4-david@redhat.com>
 <20230710173933-mutt-send-email-mst@kernel.org>
 <b9351bf7-cabd-784c-bebc-a18a9b3f4bc1@redhat.com>
 <20230711044647-mutt-send-email-mst@kernel.org>
 <840d704e-879e-5d13-5bef-038d275e038d@redhat.com>
Organization: Red Hat
In-Reply-To: <840d704e-879e-5d13-5bef-038d275e038d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 11.07.23 11:22, David Hildenbrand wrote:
> On 11.07.23 10:47, Michael S. Tsirkin wrote:
>> On Tue, Jul 11, 2023 at 10:32:31AM +0200, David Hildenbrand wrote:
>>> On 10.07.23 23:40, Michael S. Tsirkin wrote:
>>>>> @@ -2855,12 +2796,11 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>>>>>                                          SYS_BUS_DEVICE(dev));
>>>>>             }
>>>>>         }
>>>>> +
>>>>>         if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>>>>>             virt_memory_plug(hotplug_dev, dev, errp);
>>>>> -    }
>>>>> -
>>>>> -    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
>>>>> -        virt_virtio_md_pci_plug(hotplug_dev, dev, errp);
>>>>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>>>>> +        virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
>>>>>         }
>>>>>         if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>>>>
>>>>
>>>> How is this supposed to link if virtio-md is disabled at compile time?
>>>>
>>>
>>> Good point.
>>>
>>> The old code unconditionally enabled MEM_DEVICE, so we never required subs
>>> for that.
>>>
>>> We either need stubs or have to wrap this in #ifdef.
>>>
>>> Stubs sound cleaner.
>>
>> That is what we usually do, yes.
>>
> 
> I'm testing with the following:
> 
> 
> diff --git a/stubs/meson.build b/stubs/meson.build
> index a56645e2f7..160154912c 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -65,3 +65,4 @@ else
>    endif
>    stub_ss.add(files('semihost-all.c'))
>    stub_ss.add(when: 'CONFIG_VFIO_USER_SERVER', if_false: files('vfio-user-obj.c'))
> +stub_ss.add(when: 'CONFIG_VIRTIO_MD', if_false: files('virtio_md_pci.c'))

Needs to be

diff --git a/stubs/meson.build b/stubs/meson.build
index a56645e2f7..f16a365731 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -60,6 +60,7 @@ if have_system
    stub_ss.add(files('semihost.c'))
    stub_ss.add(files('usb-dev-stub.c'))
    stub_ss.add(files('xen-hw-stub.c'))
+  stub_ss.add(files('virtio_md_pci.c'))
  else
    stub_ss.add(files('qdev.c'))
  endif


Otherwise it still fails when building for multiple targets.

-- 
Cheers,

David / dhildenb



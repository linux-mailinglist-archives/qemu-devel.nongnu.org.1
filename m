Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D82917BBD7D
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 19:10:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qooKp-0002TV-8W; Fri, 06 Oct 2023 13:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qooKm-0002RY-Q8
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 13:09:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qooKl-0000dv-Cv
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 13:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696612190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wBrKdjxyA5gc6cgDEyTN/dpYyZHaWkYK3zp2HkdeLuM=;
 b=dcoLEGMMMhgDZ76BJFb33b3lDnPIy0sC+V2QCkHlud0bshcd0mMSgwtVwMqt9urew1fOH5
 KXGXHK94Szg4zjymVW/7Mhd7U0fynagTh1bs8ROQ+LDDJJcJbZ6caM3iDR9GrEakV+71/1
 BNxSewilGvXPKTWj5KxFczWfoi6+ybk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-SiXbqF5kPVaI94Dlmy9aZQ-1; Fri, 06 Oct 2023 13:09:48 -0400
X-MC-Unique: SiXbqF5kPVaI94Dlmy9aZQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-41975c9e66fso37676031cf.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 10:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696612188; x=1697216988;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wBrKdjxyA5gc6cgDEyTN/dpYyZHaWkYK3zp2HkdeLuM=;
 b=llkjvLGnnEGF7DMKuUilxFZWfIcy/wVF18R9cOLonbCjO/4jSnfhamnpdQ9uce5uja
 RQH8KplMGVrdmSA9/q8o4iyViZJNy2KHYK/oS5xod4MSbEvTbLp+rg71+UpOfvRJVFls
 gNWBcOjGIdWS8SpTwQIDSvDc04cXFu0AU2f8qRjkXgPtW73d+NJ3z4daEjsFdh+o7k3F
 tVK7bQNg7IzyG5qaK6DPXpVD1yINLzflhoThb/KdboQVPUDo7q5X6/DVmAlTARcwMFRL
 VArG/4+fXbHKyEn9/RxXMN66Z4i4LtNYBl/MDc91LzTQ1uAT9dlZ6Of3EO/vwSaudIwB
 kZAg==
X-Gm-Message-State: AOJu0YzZNFAg6BYFo/8gMLpIFtnUf03JCaQJuoQBkvdqYIA9M25E3DDZ
 u0I19ogRe2jKD9DJcy8gOQIyi01jLCS/eCL5E/GeLNIWtwBqy+Sv44ujD6O9QVIsykd8VTgMSsl
 1kGFEU2ReEXGkvJE=
X-Received: by 2002:ac8:7fc8:0:b0:417:fa23:4f40 with SMTP id
 b8-20020ac87fc8000000b00417fa234f40mr8068621qtk.33.1696612188459; 
 Fri, 06 Oct 2023 10:09:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEopv4GZT2f4IlJFQmVLT8Pe5MPFlmIzXLnSXoJNAotWIQgi3pxgi9MQ7jFwc64urkwjNGLhA==
X-Received: by 2002:ac8:7fc8:0:b0:417:fa23:4f40 with SMTP id
 b8-20020ac87fc8000000b00417fa234f40mr8068594qtk.33.1696612188214; 
 Fri, 06 Oct 2023 10:09:48 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891?
 ([2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891])
 by smtp.gmail.com with ESMTPSA id
 e1-20020ac81301000000b0040331a24f16sm1413232qtj.3.2023.10.06.10.09.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 10:09:47 -0700 (PDT)
Message-ID: <bcf861f4-50a7-495c-3497-87454fc99492@redhat.com>
Date: Fri, 6 Oct 2023 19:09:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 01/15] hw/pci: Add a pci_setup_iommu_ops() helper
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Avihai Horon <avihaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-2-joao.m.martins@oracle.com>
 <18343982-d554-61b4-fb17-b6955245e9b0@redhat.com>
 <db965f35-e568-44bb-9da4-2c2888928eb8@oracle.com>
 <d09a2778-8097-b6a7-b570-7d36bf29d9d5@redhat.com>
 <4f3eccb0-a3ff-4acf-a849-d54ee8d66eaf@oracle.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <4f3eccb0-a3ff-4acf-a849-d54ee8d66eaf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.797, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

Hello Joao,

>>>> I think you should first convert all PHBs to PCIIOMMUOps to avoid all the
>>>> tests as below and adapt pci_setup_iommu_ops() with the new parameter.
>>>>
>>>
>>> OK, that's Yi's original patch:
>>>
>>> https://lore.kernel.org/all/20210302203827.437645-5-yi.l.liu@intel.com/
>>>
>>> I went with this one is that 1) it might take eons to get every single IOMMU
>>> maintainer ack; and 2) it would allow each IOMMU to move at its own speed
>>> specially as I can't test most of the other ones. essentially iterative, rather
>>> than invasive change? Does that make sense?
>>
>> I think it is ok to make global changes to replace a function by a struct
>> of ops. This is not major (unless the extra indirection has a major perf
>> impact on some platforms).
> 
> It should be a mechanical change. As the pci_setup_iommu_ops() should be
> functionally equivalent to pci_setup_iommu() [...]

Thanks for going back to the previous proposal.

>> Getting acks from everyone will be difficultsince some PHBs are orphans.
> 
> [...] This is what gets me a bit hesitant

orphans shouldn't be an issue, nor the PPC emulated machines. We will see
what other maintainers have to say.

Thanks,

C.
  



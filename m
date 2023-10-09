Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0867BDD04
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 15:02:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpptw-0004tk-BH; Mon, 09 Oct 2023 09:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qppte-0004W3-9n
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qpptc-0002Ik-Gf
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696856523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Nh7cET3A+CC0BjflUqO1FbDssazI7KcjGNe75mn9OI=;
 b=Air2xdD07vsgi6gTCnSfTKrStqMHCloMGaSBm8eULWG4jndPGz/QrEBgWr5ReuvAKyx+ad
 d04LpegzAAj5ILCtj1Fm0178KRAFjNTKWYq/qQZmwmyf43FW9YM8txXdU/8nfDaD4JY/fS
 U62Urr4Mawf7VQHsWWexe5N0LchhdOk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-wz9hKl2hPKeLlH9JOHFX3w-1; Mon, 09 Oct 2023 09:02:02 -0400
X-MC-Unique: wz9hKl2hPKeLlH9JOHFX3w-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-65b0d478deaso58138546d6.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 06:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696856521; x=1697461321;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Nh7cET3A+CC0BjflUqO1FbDssazI7KcjGNe75mn9OI=;
 b=k8wvnD5ot/tWA8EkLayCXdMZRq1xTfad7bDK+tljTIL7nEdtLZH8HRM+IICCV5TTy5
 eiZoWlnUOfC9ELcbxjEmAI2e//MXPhvpEb9CavQje9ABPgo9grDxOpTaA7TBe+jJNmBS
 jv0pfdtxvyrzWIbdZAAS2zk9ACOseMbU6xLMfmIucg6zBBSTAYXEoKhoU3qIny4OO2HU
 3wvW3CDCPKNkepFNaaC3TgV9iKZZVZ1UMx0vibJqu2aFEGWr1wfU9YsY0DfrtVPve6Iy
 JwxA6xQkjQ9lC+9zTF2JJm7GoQdRn73JTzOz7IDGjOWqoLh+3Eznmos5EPYOvJJ3+QzF
 tBBg==
X-Gm-Message-State: AOJu0YzGOiIGAWt6xrwPxNA2hW/m+m3Xfj0CCPVctOEq7VOhFes9TzdZ
 vWlNJlXwR8q80prIa/qePf6dzbli7zGbUPBOqHOuUACoTJb8jN101OEAnWsQLTTTMNBWRDAwp6J
 595Pl6zEnTOhjzp90o9xqE2M=
X-Received: by 2002:a0c:cc01:0:b0:64f:50c2:d57a with SMTP id
 r1-20020a0ccc01000000b0064f50c2d57amr15865084qvk.28.1696856521518; 
 Mon, 09 Oct 2023 06:02:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECGdar6lg6tzJw2OtECFpsp1uTad6eMHITNqgm8OR0C5ld0qPeblJNk0HVKDxRsfivI2MgZw==
X-Received: by 2002:a0c:cc01:0:b0:64f:50c2:d57a with SMTP id
 r1-20020a0ccc01000000b0064f50c2d57amr15865064qvk.28.1696856521284; 
 Mon, 09 Oct 2023 06:02:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a05620a039100b0077412ca0ae1sm3494098qkm.65.2023.10.09.06.01.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 06:02:00 -0700 (PDT)
Message-ID: <c560109e-3c0a-9968-d558-c5d8136921db@redhat.com>
Date: Mon, 9 Oct 2023 15:01:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 01/15] hw/pci: Add a pci_setup_iommu_ops() helper
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
 <bcf861f4-50a7-495c-3497-87454fc99492@redhat.com>
 <648aad32-cd8c-4a78-9ade-76c900baa6f9@oracle.com>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <648aad32-cd8c-4a78-9ade-76c900baa6f9@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 10/6/23 19:59, Joao Martins wrote:
> On 06/10/2023 18:09, Cédric Le Goater wrote:
>>>> Getting acks from everyone will be difficultsince some PHBs are orphans.
>>>
>>> [...] This is what gets me a bit hesitant
>>
>> orphans shouldn't be an issue, nor the PPC emulated machines. We will see
>> what other maintainers have to say.
> 
> How about this as a compromise: to have a separate patch at the end of the
> series that converts every other PHB? This way the rest can iterate, while we
> await maintainers feedback without potentially blocking everything else.

In patch [1], impacted files are :

* PCIIOMMUFunc -> PCIIOMMUOps change in models

   hw/ppc/spapr_pci.c       (David)  R-b
   hw/i386/intel_iommu.c    (Peter Xu) R-b
   hw/arm/smmu-common.c     (Eric)
   hw/virtio/virtio-iommu.c (Eric)
   hw/pci-host/pnv_phb3.c   (Cédric)
   hw/pci-host/pnv_phb4.c   (Cédric)
   hw/pci-host/designware.c (Peter M.)
   hw/pci-host/prep.c       (Hervé)
   hw/pci-host/sabre.c      (Mark)
   hw/s390x/s390-pci-bus.c  (Thomas)
   hw/alpha/typhoon.c       (Richard)
   hw/hppa/dino.c           (Richard)

* Common PCI

   hw/pci/pci.c             (Michael)
   include/hw/pci/pci.h     (Michael)
   include/hw/pci/pci_bus.h (Michael)

* Orphans
  
   hw/i386/amd_iommu.c      (Orphan)
   hw/ppc/ppc440_pcix.c     (Orphan)
   hw/pci-host/ppce500.c    (Orphan)

I will add my R-b on the PPC parts I maintain. The rest doesn't seem it
would raise issues and if so, it should be quick to have since the change
is simple.

[1] https://lore.kernel.org/all/20210302203827.437645-5-yi.l.liu@intel.com/

> 
> Also, one other patch I'll add to this series at the end is this one:
> 
> https://lore.kernel.org/qemu-devel/20230908120521.50903-1-joao.m.martins@oracle.com/
> 
> This way the vIOMMU series is a complete thing for old and new guests, as
> opposed to just new.

Ok good. Let's have it.

Thanks,

C.



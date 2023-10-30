Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9E27DB598
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 10:01:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxO8h-00044O-B6; Mon, 30 Oct 2023 05:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxO8d-000446-1c
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 05:00:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxO8b-0000nl-Dy
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 05:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698656443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mIvlXeKAfordDFurZYpq0zI1no6TDdEFWSvQlA90vmo=;
 b=Qh9sDlVcOBUNoxHeSEC59cQNvusLVymZscc0LOo8VifvwxxIHx8JQ4kWkaaiCr5GiskDxg
 xOzTqqdMaW6rWvvOUNHhG0FmUIdR9w2/vyHDlE+njW7nw3PSvW2oGQoCurbQvw2FloahX3
 6UYPKDlrft7reZY0YmZOm/dkhTVnWnc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-rdZyv80tOy2DWV1reW2phA-1; Mon, 30 Oct 2023 05:00:41 -0400
X-MC-Unique: rdZyv80tOy2DWV1reW2phA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-778964b7c8bso539729285a.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 02:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698656441; x=1699261241;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mIvlXeKAfordDFurZYpq0zI1no6TDdEFWSvQlA90vmo=;
 b=sV34WU0IYydVQSXdSw8IwH5cQFVnBSmPJHtqX00em3Std68BJZ5RXBY1qCROocdi9C
 KD9tvGUhtE87riJaOBr0pahxIEP35KZz0msK9xC0gdKmuaEiEFHyqk+Ho8AiDiHd3Xnp
 O9vKlzt6g0rs5/w1nFvEtdTDVF5Cd94+z1MS8JyNWd4TPF/O2tLQxZN179l0RVtveyn9
 Js8gzBh5jJYVRn5eP7ecJUrySmNK4J4SDurVP5IumSdjzntDf78ydvIPaEsLCnU6mwiU
 E61DkAU9zXFMKbkzUpBAfMmltvIxBYNUtawjhbXZburvg2V2qD/0JjBLd9KL1KHNlBYd
 NXrQ==
X-Gm-Message-State: AOJu0YzXnchBE0VjQMUMSlFqg8o3vlAU3AT2LWQC2kU+3bzt+9VKvbfu
 zLjQAxwn+uAdBG0YR/5tlZecqB1QqFgFq9PGAYIeVL+AL6xznVNpcQ0yqY+7hb87wtjyV3xMPim
 ZE5DmCN9jTWfSAzyuw8m1f6m+wu2tZWV+cM0TbWHfD+xnboKDQ/OW0qxqFicSeJPUlPhm1N0=
X-Received: by 2002:a05:6214:2687:b0:66f:bb11:2475 with SMTP id
 gm7-20020a056214268700b0066fbb112475mr11113597qvb.6.1698656440771; 
 Mon, 30 Oct 2023 02:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4IULm3sEpNeDgLTENSiFjsxjk2xRNAThLNUSKQ67j/qSZHu5/rTQR23rH5UPgFfjdi4xP0w==
X-Received: by 2002:a05:6214:2687:b0:66f:bb11:2475 with SMTP id
 gm7-20020a056214268700b0066fbb112475mr11113552qvb.6.1698656440459; 
 Mon, 30 Oct 2023 02:00:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a0ce14b000000b0065823d20381sm3241993qvl.8.2023.10.30.02.00.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 02:00:39 -0700 (PDT)
Message-ID: <e0946db3-75b0-4d20-bfbf-a827cbb68ae9@redhat.com>
Date: Mon, 30 Oct 2023 10:00:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] hw/pci: modify pci_setup_iommu() to set PCIIOMMUOps
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>, Yi Liu <yi.l.liu@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20231023082416.180262-1-clg@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231023082416.180262-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.478,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/23/23 10:24, Cédric Le Goater wrote:
> From: Yi Liu <yi.l.liu@intel.com>
> 
> This patch modifies pci_setup_iommu() to set PCIIOMMUOps
> instead of setting PCIIOMMUFunc. PCIIOMMUFunc is used to
> get an address space for a PCI device in vendor specific
> way. The PCIIOMMUOps still offers this functionality. But
> using PCIIOMMUOps leaves space to add more iommu related
> vendor specific operations.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Hervé Poussineau <hpoussin@reactos.org>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Cc: Jagannathan Raman <jag.raman@oracle.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Helge Deller <deller@gmx.de>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> [ clg: - refreshed on latest QEMU
>         - included hw/remote/iommu.c
>         - documentation update
>         - asserts in pci_setup_iommu()
>         - removed checks on iommu_bus->iommu_ops->get_address_space
>         - included Elroy PCI host (PA-RISC) ]
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>   Hello,
> 
>   Initially sent by Yi Liu as part of series "intel_iommu: expose
>   Shared Virtual Addressing to VMs" [1], this patch would also simplify
>   the changes Joao wants to introduce in "vfio: VFIO migration support
>   with vIOMMU" [2].
> 
>   Has anyone objections ?
> 
>   Thanks,
> 
>   C.
> 
>   [1] https://lore.kernel.org/qemu-devel/20210302203827.437645-5-yi.l.liu@intel.com/
>   [2] https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/


Applied to vfio-next.

Thanks,

C.



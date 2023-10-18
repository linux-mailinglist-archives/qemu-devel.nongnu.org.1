Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5A17CDCB1
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:07:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6GO-0003HH-Tz; Wed, 18 Oct 2023 09:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6GM-0003Gp-8Q
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:07:02 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6GK-0007mE-7O
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:07:02 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-53e2308198eso10775207a12.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697634417; x=1698239217; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=InBhXZDxFDmM7NR1t7WFW6depBIdokbP7326PUBCHis=;
 b=yKBw6JvDN9Adf+9afc0U2DwLVzpvjVmkywzv944SXiJS2l1LOnbm42cwopboXu6LT6
 jcOEa/MEXO0i1If8MZPlN1S2HQByDNSe/xuGdpnkHyji6lJ/WbwWbBrE9qraCJjFgadz
 qQHLj9PbsfhIBCS7MxXdwRoVwpXZTJsNQto62KMNUWdpi8EF0nsQWdMl3qhz5R3hfCyx
 1yd7X/w+aGPWa9/ISbCakhAu8dQVfIVDzJ84dWlTCEOzX9VVfvvlUW+2ZLdPPHrlHJ47
 +iRhA6ML5CqZjNlSkT8899lPjdZFrwPNHqANPI0dVi+yjtEx11hAyyfmZi2DZvr1Fv8+
 JP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697634417; x=1698239217;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=InBhXZDxFDmM7NR1t7WFW6depBIdokbP7326PUBCHis=;
 b=BDREphv7/0wxcvj4dNFMBSErXbZ44UxQX5CL3ztIpx0KCunDYNLrcEW8Jx/Dmju1An
 qOQRW+VXrjKCBIxKBZsbzzoXef2LiywLEpb36MKM0LLJyp3FVH9nnHyEiXNjApXtt7zU
 Ymd0s6Xcg7sgzMwZH8AMBwlQgSWkYLVQlL8c8BJ/lND2SeNlMO2MRZoISaiG8hitn9MF
 XVngHh8GlmZNr0mFjUdy2v3ahpCZsxbvbIQcp6ntQtrwaBycZgJvCAaQW+EF4KCXgPc0
 y1cvlMYmr3djN2O1nM/rkC66B4CPEtxZxDWg85Otlzdli9Ucxg0FGZtkGvE33XmyC8YD
 9eVw==
X-Gm-Message-State: AOJu0YyUEf/05Qpx/AXOuTHOjk/me+aLIO/6ZoWNTWxVyM19HvLOzB7h
 qek3Q/NFKcWZdvCKrflf45aS9+QsjnS7TzU4LWI=
X-Google-Smtp-Source: AGHT+IEwuXNqwj54yZ6zF0xl/AF35yRrz4mC/CYDTUVIyElfQV767ZSl48o8fgj/+jYzyvWeqasupQ==
X-Received: by 2002:a05:6402:5186:b0:53e:3ba1:d40e with SMTP id
 q6-20020a056402518600b0053e3ba1d40emr4276384edd.26.1697634416853; 
 Wed, 18 Oct 2023 06:06:56 -0700 (PDT)
Received: from [192.168.69.115]
 (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr. [176.171.218.149])
 by smtp.gmail.com with ESMTPSA id
 f17-20020a50a6d1000000b0052ffc2e82f1sm2894874edc.4.2023.10.18.06.06.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 06:06:56 -0700 (PDT)
Message-ID: <17eb43f1-7a85-70d4-ca50-a824c2e06cd9@linaro.org>
Date: Wed, 18 Oct 2023 15:06:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2] hw/pci: modify pci_setup_iommu() to set PCIIOMMUOps
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>, Liu Yi L <yi.l.liu@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
References: <20231017161404.615145-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231017161404.615145-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 17/10/23 18:14, Cédric Le Goater wrote:
> From: Liu Yi L <yi.l.liu@intel.com>
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
> Cc: "Hervé Poussineau" <hpoussin@reactos.org>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Cc: Jagannathan Raman <jag.raman@oracle.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> [ clg: - refreshed on latest QEMU
>         - included hw/remote/iommu.c   ]
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---


>   include/hw/pci/pci.h     |  7 +++++--
>   include/hw/pci/pci_bus.h |  2 +-
>   hw/alpha/typhoon.c       |  6 +++++-
>   hw/arm/smmu-common.c     |  6 +++++-
>   hw/i386/amd_iommu.c      |  6 +++++-
>   hw/i386/intel_iommu.c    |  6 +++++-
>   hw/pci-host/designware.c |  6 +++++-
>   hw/pci-host/dino.c       |  6 +++++-
>   hw/pci-host/pnv_phb3.c   |  6 +++++-
>   hw/pci-host/pnv_phb4.c   |  6 +++++-
>   hw/pci-host/ppce500.c    |  6 +++++-
>   hw/pci-host/raven.c      |  6 +++++-
>   hw/pci-host/sabre.c      |  6 +++++-
>   hw/pci/pci.c             | 18 +++++++++++++-----
>   hw/ppc/ppc440_pcix.c     |  6 +++++-
>   hw/ppc/spapr_pci.c       |  6 +++++-
>   hw/remote/iommu.c        |  6 +++++-
>   hw/s390x/s390-pci-bus.c  |  8 ++++++--
>   hw/virtio/virtio-iommu.c |  6 +++++-
>   19 files changed, 100 insertions(+), 25 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



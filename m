Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 996678309F9
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:46:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ86M-0001ev-NE; Wed, 17 Jan 2024 10:45:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ86J-0001ef-6v
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:45:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ86H-00042R-4c
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705506307;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SHNvBAfIhmSz+dWZk79EbMxpakGwaYh03jXcsiG5qpU=;
 b=XnOLSlpFHIp/AjDTUCtZAm94rRLbQY18rSKeMKtm+yVRtYYTmWSXTBy+bkm22vTnzcPJRd
 5q5/8UMqwF+o/v+etRy2NdNam0E5JoUUxDJ1WEPdIHXwJf9pV25O3c+mjsPBCqfkUW0cmZ
 S/KZFRf5RXRnK65gZ5kjfZOibbn0amY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-UqQoHGK3O2CWgRoGs7v0ig-1; Wed, 17 Jan 2024 10:45:05 -0500
X-MC-Unique: UqQoHGK3O2CWgRoGs7v0ig-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4297db4eba1so120611831cf.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 07:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705506305; x=1706111105;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SHNvBAfIhmSz+dWZk79EbMxpakGwaYh03jXcsiG5qpU=;
 b=fMPCqnYaROV/8o9jV8t5FgSgeL4T2gLdkKplcEwadZ4Wl0UTvaRrUXnA8YcpKn3K3r
 feOM3vZPSxqWe/WzQwJXpMziBAeFtrtOzPeIIX+JPvXabPvsbLh3/D/wNxzPpWMyo+XF
 DI2Meh2yZ5IfGL6n3m2DIeAaKPdUTnS6bDXcqBc5gs1suRwKWDjdLqhu1ydc7xLc2OuO
 579KzNAjCTjfK8Zg8XR6U7jsdEhgeEORBwvtn/K5cyhpD7ZSQ9swBCqJjlhBPyX42l/l
 wKCY6YjQmC6CGjcDryFXYzTOaEeQWBxMEGYXf9B1fEiPKFFkQPvbqrf0QqyrCA4u2E5C
 pIQw==
X-Gm-Message-State: AOJu0Yx8FNNfiTB/m0xdujrPbWPjmef12z1rTYsK9iZULU2Ogw1ZVsGK
 CbET8BDYdH2EeI3Z7Hut7nFPnec7Od56/hjqrGif3TtebOOp5X2O29ZGXTGwzPhVRQ2GO+lD0D+
 c/ZcZifQtShbjin8NUV1+DHU=
X-Received: by 2002:ac8:7e83:0:b0:42a:77a:b95e with SMTP id
 w3-20020ac87e83000000b0042a077ab95emr2915095qtj.99.1705506305325; 
 Wed, 17 Jan 2024 07:45:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEabsLkHPBUx2yj8005rcs8TUcbamkkhup4nwLLQacRyqb3gvBrEd1tB9/Vj7BerfxQBL+0QA==
X-Received: by 2002:ac8:7e83:0:b0:42a:77a:b95e with SMTP id
 w3-20020ac87e83000000b0042a077ab95emr2915085qtj.99.1705506304997; 
 Wed, 17 Jan 2024 07:45:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 eh18-20020a05622a579200b00425b3fd33f2sm5887965qtb.90.2024.01.17.07.45.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 07:45:03 -0800 (PST)
Message-ID: <4db1ddc3-efef-47ff-bc34-4cb3eb3fc5e9@redhat.com>
Date: Wed, 17 Jan 2024 16:44:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv1 3/6] intel_iommu: add set/unset_iommu_device callback
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-4-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240115101313.131139-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Zhenzhong,

On 1/15/24 11:13, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
>
> This adds set/unset_iommu_device() implementation in Intel vIOMMU.
> In set call, IOMMUFDDevice is recorded in hash table indexed by
> PCI BDF.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/i386/intel_iommu.h | 10 +++++
>  hw/i386/intel_iommu.c         | 79 +++++++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+)
>
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 7fa0a695c8..c65fdde56f 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -62,6 +62,7 @@ typedef union VTD_IR_TableEntry VTD_IR_TableEntry;
>  typedef union VTD_IR_MSIAddress VTD_IR_MSIAddress;
>  typedef struct VTDPASIDDirEntry VTDPASIDDirEntry;
>  typedef struct VTDPASIDEntry VTDPASIDEntry;
> +typedef struct VTDIOMMUFDDevice VTDIOMMUFDDevice;
>  
>  /* Context-Entry */
>  struct VTDContextEntry {
> @@ -148,6 +149,13 @@ struct VTDAddressSpace {
>      IOVATree *iova_tree;
>  };
>  
> +struct VTDIOMMUFDDevice {
> +    PCIBus *bus;
> +    uint8_t devfn;
> +    IOMMUFDDevice *idev;
> +    IntelIOMMUState *iommu_state;
> +};
> +
Just wondering whether we shouldn't reuse the VTDAddressSpace to store
the idev, if any. How have you made your choice. What will it become
when PASID gets added?
>  struct VTDIOTLBEntry {
>      uint64_t gfn;
>      uint16_t domain_id;
> @@ -292,6 +300,8 @@ struct IntelIOMMUState {
>      /* list of registered notifiers */
>      QLIST_HEAD(, VTDAddressSpace) vtd_as_with_notifiers;
>  
> +    GHashTable *vtd_iommufd_dev;             /* VTDIOMMUFDDevice */
> +
>      /* interrupt remapping */
>      bool intr_enabled;              /* Whether guest enabled IR */
>      dma_addr_t intr_root;           /* Interrupt remapping table pointer */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index ed5677c0ae..95faf697eb 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -237,6 +237,13 @@ static gboolean vtd_as_equal(gconstpointer v1, gconstpointer v2)
>             (key1->pasid == key2->pasid);
>  }
>  
> +static gboolean vtd_as_idev_equal(gconstpointer v1, gconstpointer v2)
> +{
> +    const struct vtd_as_key *key1 = v1;
> +    const struct vtd_as_key *key2 = v2;
> +
> +    return (key1->bus == key2->bus) && (key1->devfn == key2->devfn);
> +}
>  /*
>   * Note that we use pointer to PCIBus as the key, so hashing/shifting
>   * based on the pointer value is intended. Note that we deal with
> @@ -3812,6 +3819,74 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>      return vtd_dev_as;
>  }
>  
> +static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int32_t devfn,
> +                                    IOMMUFDDevice *idev, Error **errp)
> +{
> +    IntelIOMMUState *s = opaque;
> +    VTDIOMMUFDDevice *vtd_idev;
> +    struct vtd_as_key key = {
> +        .bus = bus,
> +        .devfn = devfn,
> +    };
> +    struct vtd_as_key *new_key;
> +
> +    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
> +
> +    /* None IOMMUFD case */
> +    if (!idev) {
> +        return 0;
> +    }
> +
> +    vtd_iommu_lock(s);
> +
> +    vtd_idev = g_hash_table_lookup(s->vtd_iommufd_dev, &key);
> +
> +    if (vtd_idev) {
> +        error_setg(errp, "IOMMUFD device already exist");
> +        return -1;
> +    }
> +
> +    new_key = g_malloc(sizeof(*new_key));
> +    new_key->bus = bus;
> +    new_key->devfn = devfn;
> +
> +    vtd_idev = g_malloc0(sizeof(VTDIOMMUFDDevice));
> +    vtd_idev->bus = bus;
> +    vtd_idev->devfn = (uint8_t)devfn;
> +    vtd_idev->iommu_state = s;
> +    vtd_idev->idev = idev;
> +
> +    g_hash_table_insert(s->vtd_iommufd_dev, new_key, vtd_idev);
> +
> +    vtd_iommu_unlock(s);
> +
> +    return 0;
> +}
> +
> +static void vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int32_t devfn)
> +{
> +    IntelIOMMUState *s = opaque;
> +    VTDIOMMUFDDevice *vtd_idev;
> +    struct vtd_as_key key = {
> +        .bus = bus,
> +        .devfn = devfn,
> +    };
> +
> +    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
> +
> +    vtd_iommu_lock(s);
> +
> +    vtd_idev = g_hash_table_lookup(s->vtd_iommufd_dev, &key);
> +    if (!vtd_idev) {
> +        vtd_iommu_unlock(s);
> +        return;
> +    }
> +
> +    g_hash_table_remove(s->vtd_iommufd_dev, &key);
> +
> +    vtd_iommu_unlock(s);
> +}
> +
>  /* Unmap the whole range in the notifier's scope. */
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>  {
> @@ -4107,6 +4182,8 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>  
>  static PCIIOMMUOps vtd_iommu_ops = {
>      .get_address_space = vtd_host_dma_iommu,
> +    .set_iommu_device = vtd_dev_set_iommu_device,
> +    .unset_iommu_device = vtd_dev_unset_iommu_device,
>  };
>  
>  static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
> @@ -4230,6 +4307,8 @@ static void vtd_realize(DeviceState *dev, Error **errp)
>                                       g_free, g_free);
>      s->vtd_address_spaces = g_hash_table_new_full(vtd_as_hash, vtd_as_equal,
>                                        g_free, g_free);
> +    s->vtd_iommufd_dev = g_hash_table_new_full(vtd_as_hash, vtd_as_idev_equal,
> +                                               g_free, g_free);
>      vtd_init(s);
>      pci_setup_iommu(bus, &vtd_iommu_ops, dev);
>      /* Pseudo address space under root PCI bus. */
Thanks

Eric



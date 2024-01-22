Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B7F836C91
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 18:10:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRxns-0004jq-8m; Mon, 22 Jan 2024 12:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rRxno-0004j9-Ig
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:09:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rRxnm-00070Y-Ju
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705943377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ntkdy9w0sLgOPfn4eHou58NKZrNs7rnjlb7VfLNIRZk=;
 b=aI5TbQ0RH7PyN3HQFKl/AoTBj1qAMnIS89KIcFnwQsrm6luWwCSSZLOH4vPB4Ha+wmxF6j
 JdfYgH285x0WgCrPXwkJA797MmCIvNUU4C3rcE1obaHELwuT16+KgnGM3Dvq16rz7do3bg
 vohVe1RTr26kDOj905unj8FUcSbUIXI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-WHAo2LzVOuiFZKPwg5IeNQ-1; Mon, 22 Jan 2024 12:09:36 -0500
X-MC-Unique: WHAo2LzVOuiFZKPwg5IeNQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-78389fe6defso617099785a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 09:09:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705943375; x=1706548175;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ntkdy9w0sLgOPfn4eHou58NKZrNs7rnjlb7VfLNIRZk=;
 b=pBWS8TRxlH6+jWuyMZWLJta5ew5+lFbLDUWTG86usMgNd/i5eWVHy6Sx98966hMTkz
 0WzCEXF3Exglgak+eTOkPZWDoIvPyQ/l1SVPo+LyP7e7slf1N6VBeMgp2zWjT72RRRy4
 752s3Jq6+HaWgfpLzRJpvjIq2pPt7+GhDgmdSEzXrXMI5jzfz7bitDmfdMoavR8hSH68
 ygW/vfyGJIOfkoFSLrssc7386XwH+IihJECc+CDQE1Je8IJGgM3TAUMrYha3c61xuaHr
 fqDUFzIzm/ln0tWPKjJIIZzXu1JzZWT3wklWVbCK0kauCBiqrGpBBVU770apEEfdc4GJ
 nflA==
X-Gm-Message-State: AOJu0YyyqZbdwVNu4M1aXhUbnNgA70KAV+iwoYEYyRPpYdjPGHVj/hda
 HgxxJtKKPPXnK9se3Dd5oozxgkMEqQZYo2XdTMJ5hK/u+LHcUNQ1rMs08JlNrx1iE+2Fv695arO
 2h3kVUdLrjaweTXjyE5Sp7WuSrVEyk0Fh082bE4tNExNGeuOrWlLu
X-Received: by 2002:a05:620a:40d5:b0:783:70c7:3519 with SMTP id
 g21-20020a05620a40d500b0078370c73519mr7222427qko.100.1705943374960; 
 Mon, 22 Jan 2024 09:09:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2h/6Mc/5KqaNyaKH47PaDsmpEK2bBAHPIS97EhuHtmYKqaUO+EyyptgSYbRzmVnbfVeHbHw==
X-Received: by 2002:a05:620a:40d5:b0:783:70c7:3519 with SMTP id
 g21-20020a05620a40d500b0078370c73519mr7222403qko.100.1705943374543; 
 Mon, 22 Jan 2024 09:09:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 i24-20020ae9ee18000000b0078381f65e5asm2272453qkg.34.2024.01.22.09.09.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 09:09:32 -0800 (PST)
Message-ID: <64d09a08-cf9f-4020-86c7-b0a41eddc572@redhat.com>
Date: Mon, 22 Jan 2024 18:09:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv1 3/6] intel_iommu: add set/unset_iommu_device callback
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-4-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240115101313.131139-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

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
>   include/hw/i386/intel_iommu.h | 10 +++++
>   hw/i386/intel_iommu.c         | 79 +++++++++++++++++++++++++++++++++++
>   2 files changed, 89 insertions(+)
> 
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 7fa0a695c8..c65fdde56f 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -62,6 +62,7 @@ typedef union VTD_IR_TableEntry VTD_IR_TableEntry;
>   typedef union VTD_IR_MSIAddress VTD_IR_MSIAddress;
>   typedef struct VTDPASIDDirEntry VTDPASIDDirEntry;
>   typedef struct VTDPASIDEntry VTDPASIDEntry;
> +typedef struct VTDIOMMUFDDevice VTDIOMMUFDDevice;
>   
>   /* Context-Entry */
>   struct VTDContextEntry {
> @@ -148,6 +149,13 @@ struct VTDAddressSpace {
>       IOVATree *iova_tree;
>   };
>   
> +struct VTDIOMMUFDDevice {
> +    PCIBus *bus;
> +    uint8_t devfn;
> +    IOMMUFDDevice *idev;
> +    IntelIOMMUState *iommu_state;
> +};

Does the VTDIOMMUFDDevice definition need to be public ?

>   struct VTDIOTLBEntry {
>       uint64_t gfn;
>       uint16_t domain_id;
> @@ -292,6 +300,8 @@ struct IntelIOMMUState {
>       /* list of registered notifiers */
>       QLIST_HEAD(, VTDAddressSpace) vtd_as_with_notifiers;
>   
> +    GHashTable *vtd_iommufd_dev;             /* VTDIOMMUFDDevice */
> +
>       /* interrupt remapping */
>       bool intr_enabled;              /* Whether guest enabled IR */
>       dma_addr_t intr_root;           /* Interrupt remapping table pointer */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index ed5677c0ae..95faf697eb 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -237,6 +237,13 @@ static gboolean vtd_as_equal(gconstpointer v1, gconstpointer v2)
>              (key1->pasid == key2->pasid);
>   }
>   
> +static gboolean vtd_as_idev_equal(gconstpointer v1, gconstpointer v2)
> +{
> +    const struct vtd_as_key *key1 = v1;
> +    const struct vtd_as_key *key2 = v2;
> +
> +    return (key1->bus == key2->bus) && (key1->devfn == key2->devfn);
> +}
>   /*
>    * Note that we use pointer to PCIBus as the key, so hashing/shifting
>    * based on the pointer value is intended. Note that we deal with
> @@ -3812,6 +3819,74 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>       return vtd_dev_as;
>   }
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

Can we move the assert earlier in the call stack ?
pci_device_get_iommu_bus_devfn() looks like a good place.

> +
> +    /* None IOMMUFD case */
> +    if (!idev) {
> +        return 0;
> +    }

Can we move this test in the helper ? (Looks like an error to me).


Thanks,

C.


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
>   /* Unmap the whole range in the notifier's scope. */
>   static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>   {
> @@ -4107,6 +4182,8 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>   
>   static PCIIOMMUOps vtd_iommu_ops = {
>       .get_address_space = vtd_host_dma_iommu,
> +    .set_iommu_device = vtd_dev_set_iommu_device,
> +    .unset_iommu_device = vtd_dev_unset_iommu_device,
>   };
>   
>   static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
> @@ -4230,6 +4307,8 @@ static void vtd_realize(DeviceState *dev, Error **errp)
>                                        g_free, g_free);
>       s->vtd_address_spaces = g_hash_table_new_full(vtd_as_hash, vtd_as_equal,
>                                         g_free, g_free);
> +    s->vtd_iommufd_dev = g_hash_table_new_full(vtd_as_hash, vtd_as_idev_equal,
> +                                               g_free, g_free);
>       vtd_init(s);
>       pci_setup_iommu(bus, &vtd_iommu_ops, dev);
>       /* Pseudo address space under root PCI bus. */



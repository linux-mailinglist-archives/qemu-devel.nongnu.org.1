Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5CBAA9378
	for <lists+qemu-devel@lfdr.de>; Mon,  5 May 2025 14:43:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBvA7-0004zq-Hp; Mon, 05 May 2025 08:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBvA4-0004zA-7s
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBvA1-00055Z-MW
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746448983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jpi/zsFok/nWN/BIVV5tSaDLWHR9/q5Udz9XZqcN8Xo=;
 b=MbL3pjwlOvX9QTzfwpgAVBUVekUctjnrmEKQ24DPp1RoldRJ0dQF/FiU2pl9l4g+Szl0zq
 B++Sr2PFR/IHYCeKy6PGm72c12rfg7GHUC7h+3iHRCOHRh1uzkEtMnSIdh/2MDiiSlYvT0
 F61d1p3WLbh2pL3RyoXOVoKPyWaqZ+I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-IOWcNDsnMoGmOzNu11nidw-1; Mon, 05 May 2025 08:43:01 -0400
X-MC-Unique: IOWcNDsnMoGmOzNu11nidw-1
X-Mimecast-MFC-AGG-ID: IOWcNDsnMoGmOzNu11nidw_1746448981
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3912fe32a30so1263751f8f.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 05:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746448981; x=1747053781;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jpi/zsFok/nWN/BIVV5tSaDLWHR9/q5Udz9XZqcN8Xo=;
 b=MTJubOHL4oOXfsdDQoCq4C2ps7+TdcLj3tjX6c53gcPkrVJWCatuw0Zx+g3cqMYw4r
 WDAFqe6f/k7Ub6fnujNyI4qLdigdFT4c36oGA0FvPTW+aXElQ57x437fL5jNC6f1j+S/
 /bykiGVFl0iAcYv3eZMdNUw7qFyIoc9ZSn242T+zogyyFlL8iSrCTfAGVSXPLOvJcNzX
 I3UHpFDjPb1SlO40GxUFvX1rPwLaYL8WEdegOwHHegvUXbG+VIXuK2CQvtBOr5WP4Wf7
 hCliUWfNW0xi3/gAbuZynHcnZkujoIq3iN2nOBwH+FzNcuK7zpnAP1evzK0gr+M0IF2K
 KfPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7evbe6ed+zpfHTiEAkE2AjcRXciyXY/MHwOeuIkikWfpuT0EXQ9UNJBiYD+Nb/2ou7GvoswaORTsK@nongnu.org
X-Gm-Message-State: AOJu0YxTJqh4I5cswc6P9r6LmFyPBpvFpGUI4PiQklVHQtEySsdoBufA
 QbY8rUeUoNEgXvyWcN0tp7wgvm9KHEwqj35C53+Q2U11HQw06nJbRDeGo/YkQcFTdJ+FZ2oECL1
 dORHufSAgIr/51o8atebYLHdOe1YCiEYqdDJDFDyJZ1T4ybVRJo8n
X-Gm-Gg: ASbGncsUxlZU/wqMCePHmW0Z54nyWmSpLyZVp8FrrtgZXAB+cYvYv3qFqmMIAi44nNI
 6V/p0sA0v0z0KCnDMFXTk8rQ9PAHryEPQ3fEf7Ks9dHzeUS48gCYzYpGn0z6qjbQL0LMgXcxB4m
 gRXWu4MG2msjCBlILfcmtF/BB1K7dwwQCvz0yZJCmnPU4geSl1ZjhggNW8w4l6esgjwMxIoLewl
 gyqHCrPFOfGq2J1s6TxBpcaTblPeiX6BVozos1xeuVwZ0aqGM9+KQHboSRad5BMpUNKffMxGS2a
 bVDeIZjuO3VjA9fUpl0tFKBYoEhZ6TQJLf0qLBcEOAgn1EiOhA==
X-Received: by 2002:a05:6000:240b:b0:39c:1257:febb with SMTP id
 ffacd0b85a97d-3a099aefed3mr9923018f8f.59.1746448980681; 
 Mon, 05 May 2025 05:43:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwHTMFomVHE5nXs+9jsDFqALQY2lfD0jvBARBys2dfWgeOT6npnB41QoeMfvfXw7qs2b4Vnw==
X-Received: by 2002:a05:6000:240b:b0:39c:1257:febb with SMTP id
 ffacd0b85a97d-3a099aefed3mr9922976f8f.59.1746448980160; 
 Mon, 05 May 2025 05:43:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b178absm10480645f8f.97.2025.05.05.05.42.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 05:42:59 -0700 (PDT)
Message-ID: <bc0e2300-0183-4f48-8974-babd00a02bdd@redhat.com>
Date: Mon, 5 May 2025 14:42:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] vfio: add vfio-pci-base class
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
 <20250430194003.2793823-14-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250430194003.2793823-14-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/30/25 21:40, John Levon wrote:
> Split out parts of TYPE_VFIO_PCI into a base TYPE_VFIO_PCI_BASE,
> although we have not yet introduced another subclass, so all the
> properties have remained in TYPE_VFIO_PCI.
> 
> Note that currently there is no need for additional data for
> TYPE_VFIO_PCI, so it shares the same C struct type as
> TYPE_VFIO_PCI_BASE, VFIOPCIDevice.


Looks better. One nit below.


> Originally-by: John Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/device.c |  2 +-
>   hw/vfio/pci.c    | 62 +++++++++++++++++++++++++++++++-----------------
>   hw/vfio/pci.h    | 12 ++++++++--
>   3 files changed, 51 insertions(+), 25 deletions(-)
> 
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index ceb7bbebda..70d75b271f 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -395,7 +395,7 @@ bool vfio_device_hiod_create_and_realize(VFIODevice *vbasedev,
>   VFIODevice *vfio_get_vfio_device(Object *obj)
>   {
>       if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
> -        return &VFIO_PCI(obj)->vbasedev;
> +        return &VFIO_PCI_BASE(obj)->vbasedev;
>       } else {
>           return NULL;
>       }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 5e811d5d6a..8d29b4552f 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -241,7 +241,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
>   
>   static void vfio_intx_routing_notifier(PCIDevice *pdev)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       PCIINTxRoute route;
>   
>       if (vdev->interrupt != VFIO_INT_INTx) {
> @@ -514,7 +514,7 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
>   static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>                                      MSIMessage *msg, IOHandler *handler)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       VFIOMSIVector *vector;
>       int ret;
>       bool resizing = !!(vdev->nr_vectors < nr + 1);
> @@ -620,7 +620,7 @@ static int vfio_msix_vector_use(PCIDevice *pdev,
>   
>   static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       VFIOMSIVector *vector = &vdev->msi_vectors[nr];
>   
>       trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
> @@ -1196,7 +1196,7 @@ static const MemoryRegionOps vfio_vga_ops = {
>    */
>   static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       VFIORegion *region = &vdev->bars[bar].region;
>       MemoryRegion *mmap_mr, *region_mr, *base_mr;
>       PCIIORegion *r;
> @@ -1242,7 +1242,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
>    */
>   uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
>   
> @@ -1276,7 +1276,7 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
>   void vfio_pci_write_config(PCIDevice *pdev,
>                              uint32_t addr, uint32_t val, int len)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       uint32_t val_le = cpu_to_le32(val);
>       int ret;
> @@ -3129,7 +3129,7 @@ static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
>   static void vfio_realize(PCIDevice *pdev, Error **errp)
>   {
>       ERRP_GUARD();
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       int i, ret;
>       char uuid[UUID_STR_LEN];
> @@ -3300,7 +3300,7 @@ error:
>   
>   static void vfio_instance_finalize(Object *obj)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(obj);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
>   
>       vfio_display_finalize(vdev);
>       vfio_bars_finalize(vdev);
> @@ -3318,7 +3318,7 @@ static void vfio_instance_finalize(Object *obj)
>   
>   static void vfio_exitfn(PCIDevice *pdev)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>   
>       vfio_unregister_req_notifier(vdev);
> @@ -3342,7 +3342,7 @@ static void vfio_exitfn(PCIDevice *pdev)
>   
>   static void vfio_pci_reset(DeviceState *dev)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(dev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
>   
>       trace_vfio_pci_reset(vdev->vbasedev.name);
>   
> @@ -3382,7 +3382,7 @@ post_reset:
>   static void vfio_instance_init(Object *obj)
>   {
>       PCIDevice *pci_dev = PCI_DEVICE(obj);
> -    VFIOPCIDevice *vdev = VFIO_PCI(obj);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>   
>       device_add_bootindex_property(obj, &vdev->bootindex,
> @@ -3403,6 +3403,31 @@ static void vfio_instance_init(Object *obj)
>       pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
>   }
>   
> +static void vfio_pci_base_dev_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
> +
> +    dc->desc = "VFIO PCI base device";
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    pdc->exit = vfio_exitfn;
> +    pdc->config_read = vfio_pci_read_config;
> +    pdc->config_write = vfio_pci_write_config;
> +}
> +
> +static const TypeInfo vfio_pci_base_dev_info = {
> +    .name = TYPE_VFIO_PCI_BASE,
> +    .parent = TYPE_PCI_DEVICE,
> +    .instance_size = 0,
> +    .abstract = true,
> +    .class_init = vfio_pci_base_dev_class_init,
> +    .interfaces = (const InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { }
> +    },
> +};
> +
>   static PropertyInfo vfio_pci_migration_multifd_transfer_prop;
>   
>   static const Property vfio_pci_dev_properties[] = {
> @@ -3473,7 +3498,8 @@ static const Property vfio_pci_dev_properties[] = {
>   #ifdef CONFIG_IOMMUFD
>   static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
>   {
> -    vfio_device_set_fd(&VFIO_PCI(obj)->vbasedev, str, errp);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
> +    vfio_device_set_fd(&vdev->vbasedev, str, errp);
>   }
>   #endif
>   
> @@ -3488,11 +3514,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
>       object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
>   #endif
>       dc->desc = "VFIO-based PCI device assignment";
> -    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>       pdc->realize = vfio_realize;
> -    pdc->exit = vfio_exitfn;
> -    pdc->config_read = vfio_pci_read_config;
> -    pdc->config_write = vfio_pci_write_config;
>   
>       object_class_property_set_description(klass, /* 1.3 */
>                                             "host",
> @@ -3617,16 +3639,11 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
>   
>   static const TypeInfo vfio_pci_dev_info = {
>       .name = TYPE_VFIO_PCI,
> -    .parent = TYPE_PCI_DEVICE,
> +    .parent = TYPE_VFIO_PCI_BASE,
>       .instance_size = sizeof(VFIOPCIDevice),
>       .class_init = vfio_pci_dev_class_init,
>       .instance_init = vfio_instance_init,
>       .instance_finalize = vfio_instance_finalize,
> -    .interfaces = (const InterfaceInfo[]) {
> -        { INTERFACE_PCIE_DEVICE },
> -        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> -        { }
> -    },
>   };
>   
>   static const Property vfio_pci_dev_nohotplug_properties[] = {
> @@ -3673,6 +3690,7 @@ static void register_vfio_pci_dev_type(void)
>       vfio_pci_migration_multifd_transfer_prop = qdev_prop_on_off_auto;
>       vfio_pci_migration_multifd_transfer_prop.realized_set_allowed = true;
>   
> +    type_register_static(&vfio_pci_base_dev_info);
>       type_register_static(&vfio_pci_dev_info);
>       type_register_static(&vfio_pci_nohotplug_dev_info);
>   }
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index f835b1dbc2..32a65cc1ae 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -118,8 +118,13 @@ typedef struct VFIOMSIXInfo {
>       bool noresize;
>   } VFIOMSIXInfo;
>   
> -#define TYPE_VFIO_PCI "vfio-pci"
> -OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI)
> +/*
> + * TYPE_VFIO_PCI_BASE is an abstract type used to share code
> + * between VFIO implementations that use a kernel driver
> + * with those that use user sockets.
> + */
> +#define TYPE_VFIO_PCI_BASE "vfio-pci-base"
> +OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_BASE)
>   
>   struct VFIOPCIDevice {
>       PCIDevice pdev;
> @@ -187,6 +192,9 @@ struct VFIOPCIDevice {
>       Notifier irqchip_change_notifier;
>   };
>   
> +#define TYPE_VFIO_PCI "vfio-pci"
> +/* TYPE_VFIO_PCI shares struct VFIOPCIDevice. */

Please keep the TYPE_VFIO definitions together.


Thanks,

C.


> +
>   /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
>   static inline bool vfio_pci_is(VFIOPCIDevice *vdev, uint32_t vendor, uint32_t device)
>   {



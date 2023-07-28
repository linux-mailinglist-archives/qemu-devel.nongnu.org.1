Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB6D766722
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 10:30:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPIot-0007GA-8T; Fri, 28 Jul 2023 04:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qPIoo-0007Fm-OS
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 04:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qPIon-0005BR-05
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 04:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690532843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/P410bnaGTWH1nEMlSkcmNlv/dmgNwvFxSRvwojwdNM=;
 b=Z4qHgkRalSjnUOMd8PHaqA4WCElnKxPF6MIX4Gtg7ESw6ihIc9NMPabjxXJqzJMwGB94fB
 eWCn6CBVb2JifTOOgK70EtlliBNltOmqlXL6IS0fDzew3GdEGTRlX1U1c4+rwxRUIFg+Oc
 7idLVvsuUlbThLXClhZ7L4XBl8lnNJo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-qE5Ts0CLNTay-EmtQSvNiQ-1; Fri, 28 Jul 2023 04:27:21 -0400
X-MC-Unique: qE5Ts0CLNTay-EmtQSvNiQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4fb7b4be07bso1663923e87.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 01:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690532840; x=1691137640;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/P410bnaGTWH1nEMlSkcmNlv/dmgNwvFxSRvwojwdNM=;
 b=FojW1ARSSWDTaOZB/A21Xu5RCxbmLXkSY3+coOA1llDTuAD+EV/HtqPYncxgAmz187
 k2wAzv/O3r0igkVz3FcBH6Q24xf4VGZmsynvH++31PdY8/3tKXvVTcCLnumXXtixJn27
 FToZD03ne31prD449NyDWhdlWvFxIml+/bLIWX0msmEF0TygOA68VkoWHXwgb9gpYmk0
 q6tQWhY/SHw0DN0q6KpZqAZTxAWigUdjPtI3xvooxDUNIPrSz71kSp9U23Ganc2bn0ww
 /E9rwJZJI1TXotGsKDR9+K3koKAUZYhQDDQmyQRJNTKVhsF3mxVfE67STTeTpZ2NdVpL
 qZ7A==
X-Gm-Message-State: ABy/qLavsdopSxYKC7Zt9dIxWKpW0PQjtF9kpLgMu33MMFT7Jb8BdEeh
 apYVtNLsnGNo0kX4EnsRVCaVlQbjw69zJ9d/aNsyuHe36e7E6ptcwQB4EO/YvytEwwCCZaBbJrJ
 x7W/nxzpUsrfM66k=
X-Received: by 2002:a05:6512:3d2a:b0:4f8:5f32:b1da with SMTP id
 d42-20020a0565123d2a00b004f85f32b1damr1390377lfv.24.1690532839879; 
 Fri, 28 Jul 2023 01:27:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFeyjYzdCvB44DdZO6xqBlU2+VOqa03HGm9qGstNqTr67bpnNMfmu8K6yAkfRRYH2/5zrfp7w==
X-Received: by 2002:a05:6512:3d2a:b0:4f8:5f32:b1da with SMTP id
 d42-20020a0565123d2a00b004f85f32b1damr1390358lfv.24.1690532839448; 
 Fri, 28 Jul 2023 01:27:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 p5-20020adfcc85000000b003144b50034esm4117154wrj.110.2023.07.28.01.27.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 01:27:18 -0700 (PDT)
Message-ID: <e6d47754-9d2b-20bc-55b0-ed6685f7b3b2@redhat.com>
Date: Fri, 28 Jul 2023 10:27:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC v1 1/3] vfio/pci: detect the support of dynamic MSI-X
 allocation
Content-Language: en-US
To: "Liu, Jing2" <jing2.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "Chatre, Reinette" <reinette.chatre@intel.com>
References: <20230727072410.135743-1-jing2.liu@intel.com>
 <20230727072410.135743-2-jing2.liu@intel.com>
 <20230727112457.1422f285.alex.williamson@redhat.com>
 <DS0PR11MB8114C864A2D55951DD621214A906A@DS0PR11MB8114.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <DS0PR11MB8114C864A2D55951DD621214A906A@DS0PR11MB8114.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 7/28/23 10:09, Liu, Jing2 wrote:
> Hi Alex,
> 
> Thanks very much for reviewing the patches.
> 
>> On July 28, 2023 1:25 AM, Alex Williamson <alex.williamson@redhat.com> wrote:
>>
>> On Thu, 27 Jul 2023 03:24:08 -0400
>> Jing Liu <jing2.liu@intel.com> wrote:
>>
>>> From: Reinette Chatre <reinette.chatre@intel.com>
>>>
>>> Kernel provides the guidance of dynamic MSI-X allocation support of
>>> passthrough device, by clearing the VFIO_IRQ_INFO_NORESIZE flag to
>>> guide user space.
>>>
>>> Fetch and store the flags from host for later use to determine if
>>> specific flags are set.
>>>
>>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>>> Signed-off-by: Jing Liu <jing2.liu@intel.com>
>>> ---
>>>   hw/vfio/pci.c        | 12 ++++++++++++
>>>   hw/vfio/pci.h        |  1 +
>>>   hw/vfio/trace-events |  2 ++
>>>   3 files changed, 15 insertions(+)
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index
>>> a205c6b1130f..0c4ac0873d40 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -1572,6 +1572,7 @@ static void vfio_msix_early_setup(VFIOPCIDevice
>>> *vdev, Error **errp)
>>>
>>>   static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error
>>> **errp)  {
>>> +    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
>>>       int ret;
>>>       Error *err = NULL;
>>>
>>> @@ -1624,6 +1625,17 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int
>> pos, Error **errp)
>>>           memory_region_set_enabled(&vdev->pdev.msix_table_mmio, false);
>>>       }
>>>
>>> +    irq_info.index = VFIO_PCI_MSIX_IRQ_INDEX;
>>> +    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
>>> +    if (ret) {
>>> +        /* This can fail for an old kernel or legacy PCI dev */
>>> +        trace_vfio_msix_setup_get_irq_info_failure(strerror(errno));
>>
>> We only call vfio_msix_setup() if the device has an MSI-X capability, so the
>> "legacy PCI" portion of this comment seems unjustified.
>> Otherwise the GET_IRQ_INFO ioctl has always existed, so I'd also question the
>> "old kernel" part of this comment.
> 
> Oh, yes, I just realize that only VFIO_PCI_ERR_IRQ_INDEX and
> VFIO_PCI_REQ_IRQ_INDEX were added later in include/uapi/linux/vfio.h. Thus,
> this ioctl() with MSIX index would not fail by the old-kernel or legacy-PCI reason.
> Thanks for pointing out this to me.
> 
> We don't currently sanity test the device
>> exposed MSI-X info versus that reported by GET_IRQ_INFO, but it seems valid to
>> do so.
> 
> Do we want to keep the check of possible failure from kernel (e.g., -EFAULT) and report
> the error code back to caller? Maybe like this,
> 
> static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
> {
>      ....
>      msix->entries = (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
> 
>      ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
>      if (ret < 0) {
>          error_setg_errno(errp, -ret, "failed to get MSI-X IRQ INFO");
>          return;
>      } else {
>          vdev->msix->noresize = !!(irq_info.flags & VFIO_IRQ_INFO_NORESIZE);
>      }
>      ...
>      trace_vfio_msix_early_setup(vdev->vbasedev.name, pos, msix->table_bar,
>                                  msix->table_offset, msix->entries, vdev->msix->noresize);

In the trace event, please ouput irq_info.flags since it gives more
information on the value returned by the kernel.

>      ....
> }
> 
>> I'd expect this to happen in vfio_msix_early_setup() though, especially
>> since that's where the remainder of VFIOMSIXInfo is setup.
> 
>>
>>> +    } else {
>>> +        vdev->msix->irq_info_flags = irq_info.flags;
>>> +    }
>>> +    trace_vfio_msix_setup_irq_info_flags(vdev->vbasedev.name,
>>> +                                         vdev->msix->irq_info_flags);
>>> +
>>>       return 0;
>>>   }
>>>
>>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h index
>>> a2771b9ff3cc..ad34ec56d0ae 100644
>>> --- a/hw/vfio/pci.h
>>> +++ b/hw/vfio/pci.h
>>> @@ -113,6 +113,7 @@ typedef struct VFIOMSIXInfo {
>>>       uint32_t table_offset;
>>>       uint32_t pba_offset;
>>>       unsigned long *pending;
>>> +    uint32_t irq_info_flags;
>>
>> Why not simply pull out a "noresize" bool?  Thanks,
>>
> Will change to a bool type.

I would simply cache the KVM flags value under VFIOMSIXInfo as you
did and add an helper. Both work the same but the intial proposal
keeps more information. This is minor.

Thanks,

C.
  
> 
> Thanks,
> Jing
> 
>> Alex
>>
>>>   } VFIOMSIXInfo;
>>>
>>>   #define TYPE_VFIO_PCI "vfio-pci"
>>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events index
>>> ee7509e68e4f..7d4a398f044d 100644
>>> --- a/hw/vfio/trace-events
>>> +++ b/hw/vfio/trace-events
>>> @@ -28,6 +28,8 @@ vfio_pci_read_config(const char *name, int addr, int
>>> len, int val) " (%s, @0x%x,  vfio_pci_write_config(const char *name, int addr, int
>> val, int len) " (%s, @0x%x, 0x%x, len=0x%x)"
>>>   vfio_msi_setup(const char *name, int pos) "%s PCI MSI CAP @0x%x"
>>>   vfio_msix_early_setup(const char *name, int pos, int table_bar, int offset, int
>> entries) "%s PCI MSI-X CAP @0x%x, BAR %d, offset 0x%x, entries %d"
>>> +vfio_msix_setup_get_irq_info_failure(const char *errstr)
>> "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
>>> +vfio_msix_setup_irq_info_flags(const char *name, uint32_t flags) " (%s) MSI-X
>> irq info flags 0x%x"
>>>   vfio_check_pcie_flr(const char *name) "%s Supports FLR via PCIe cap"
>>>   vfio_check_pm_reset(const char *name) "%s Supports PM reset"
>>>   vfio_check_af_flr(const char *name) "%s Supports FLR via AF cap"
> 



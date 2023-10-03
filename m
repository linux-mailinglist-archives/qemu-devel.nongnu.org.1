Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4701B7B6925
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:37:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnedu-0007MG-O7; Tue, 03 Oct 2023 08:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnedt-0007Jf-4L
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:36:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnedo-0000Ns-4e
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696336603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7DiQZmdBVVOvSDXeXaCqZRxS0C9Crh6A+SVmHxT9CgU=;
 b=L6J4LDeciv4hep/03BVlYKTDlWmDjbKfbdrMeKC8iWiYmVe6eMKBYRYkntuDAcjgb9aEvj
 X83gsJyScPKpPyTxredj8uhqKWLSvICrgPRAfuwuSa12QctUN05BvS0PuVsSuz6Y2Vsk0M
 3oy3yvYxTmCKFK5M8d/rb+CfiKrwr9w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-4TkllkbzPE6qKDj4AMNbHw-1; Tue, 03 Oct 2023 08:36:38 -0400
X-MC-Unique: 4TkllkbzPE6qKDj4AMNbHw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE0493806701;
 Tue,  3 Oct 2023 12:36:37 +0000 (UTC)
Received: from [10.39.192.186] (unknown [10.39.192.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A1DB4040FE;
 Tue,  3 Oct 2023 12:36:35 +0000 (UTC)
Message-ID: <3862d365-af1a-5bde-10cb-0b9d29244124@redhat.com>
Date: Tue, 3 Oct 2023 14:36:34 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 5/5] hw/vfio: add ramfb migration support
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 kraxel@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20231003085644.1220326-1-marcandre.lureau@redhat.com>
 <20231003085644.1220326-6-marcandre.lureau@redhat.com>
 <7df9e19a-4ead-516c-21b3-04d8e899d7e7@redhat.com>
 <CAJ+F1C+=5uUjdO-DY9iAR0zL+XoPmY7NBjgV3AwvJV6sRqTGfQ@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <CAJ+F1C+=5uUjdO-DY9iAR0zL+XoPmY7NBjgV3AwvJV6sRqTGfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/3/23 12:47, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Oct 3, 2023 at 2:17 PM Cédric Le Goater <clg@redhat.com> wrote:
>>
>> On 10/3/23 10:56, marcandre.lureau@redhat.com wrote:
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> Add a "VFIODisplay" subsection whenever "x-ramfb-migrate" is turned on.
>>>
>>> Turn it off by default on machines <= 8.1 for compatibility reasons.
>>
>>
>> This change breaks linking on various platforms with :
>>
>> /usr/bin/ld: libqemu-xtensa-softmmu.fa.p/hw_vfio_display.c.o:(.data.rel+0x50): undefined reference to `ramfb_vmstate'
>>
>> Some stubs updates are missing it seems..
>>
> 
> diff --git a/stubs/ramfb.c b/stubs/ramfb.c
> index 48143f3354..cf64733b10 100644
> --- a/stubs/ramfb.c
> +++ b/stubs/ramfb.c
> @@ -2,6 +2,8 @@
>  #include "qapi/error.h"
>  #include "hw/display/ramfb.h"
> 
> +const VMStateDescription ramfb_vmstate = {};
> +
> 
> 
> And I think we should also change the "needed" condition to:
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 4689f2e5c1..b327844764 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2613,7 +2613,7 @@ static bool vfio_display_needed(void *opaque)
>      VFIOPCIDevice *vdev = opaque;
> 
>      /* the only thing that justifies the VFIODisplay sub-section atm */
> -    return vdev->ramfb_migrate != ON_OFF_AUTO_OFF;
> +    return vdev->enable_ramfb && vdev->ramfb_migrate != ON_OFF_AUTO_OFF;
>  }
> 

Exactly, this was one of my comments in review.

(But, see there -- I think the other formulation is easier to read and
understand.)

Laszlo

> 
> 
>> Thanks,
>>
>> C.
>>
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>   hw/vfio/pci.h     |  3 +++
>>>   hw/core/machine.c |  1 +
>>>   hw/vfio/display.c | 23 +++++++++++++++++++++++
>>>   hw/vfio/pci.c     | 32 ++++++++++++++++++++++++++++++++
>>>   4 files changed, 59 insertions(+)
>>>
>>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>>> index 2d836093a8..fd06695542 100644
>>> --- a/hw/vfio/pci.h
>>> +++ b/hw/vfio/pci.h
>>> @@ -173,6 +173,7 @@ struct VFIOPCIDevice {
>>>       bool no_kvm_ioeventfd;
>>>       bool no_vfio_ioeventfd;
>>>       bool enable_ramfb;
>>> +    OnOffAuto ramfb_migrate;
>>>       bool defer_kvm_irq_routing;
>>>       bool clear_parent_atomics_on_exit;
>>>       VFIODisplay *dpy;
>>> @@ -226,4 +227,6 @@ void vfio_display_reset(VFIOPCIDevice *vdev);
>>>   int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
>>>   void vfio_display_finalize(VFIOPCIDevice *vdev);
>>>
>>> +extern const VMStateDescription vfio_display_vmstate;
>>> +
>>>   #endif /* HW_VFIO_VFIO_PCI_H */
>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>> index 47a07d1d9b..f2f8940a85 100644
>>> --- a/hw/core/machine.c
>>> +++ b/hw/core/machine.c
>>> @@ -32,6 +32,7 @@
>>>
>>>   GlobalProperty hw_compat_8_1[] = {
>>>       { "ramfb", "x-migrate", "off" },
>>> +    { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" }
>>>   };
>>>   const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
>>>
>>> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
>>> index bec864f482..de5bf71dd1 100644
>>> --- a/hw/vfio/display.c
>>> +++ b/hw/vfio/display.c
>>> @@ -542,3 +542,26 @@ void vfio_display_finalize(VFIOPCIDevice *vdev)
>>>       vfio_display_edid_exit(vdev->dpy);
>>>       g_free(vdev->dpy);
>>>   }
>>> +
>>> +static bool migrate_needed(void *opaque)
>>> +{
>>> +    /*
>>> +     * If we are here, it's because vfio_display_needed(), which is only true
>>> +     * when dpy->ramfb_migrate atm.
>>> +     *
>>> +     * If the migration condition is changed, we should check here if
>>> +     * ramfb_migrate is true. (this will need a way to lookup the associated
>>> +     * VFIOPCIDevice somehow, or fields to be moved, ..)
>>> +     */
>>> +    return true;
>>> +}
>>> +
>>> +const VMStateDescription vfio_display_vmstate = {
>>> +    .name = "VFIODisplay",
>>> +    .version_id = 1,
>>> +    .minimum_version_id = 1,
>>> +    .needed = migrate_needed,
>>> +    .fields = (VMStateField[]) {
>>> +        VMSTATE_STRUCT_POINTER(ramfb, VFIODisplay, ramfb_vmstate, RAMFBState),
>>> +    }
>>> +};
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index 3b2ca3c24c..4689f2e5c1 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -2608,6 +2608,25 @@ static bool vfio_msix_present(void *opaque, int version_id)
>>>       return msix_present(pdev);
>>>   }
>>>
>>> +static bool vfio_display_needed(void *opaque)
>>> +{
>>> +    VFIOPCIDevice *vdev = opaque;
>>> +
>>> +    /* the only thing that justifies the VFIODisplay sub-section atm */
>>> +    return vdev->ramfb_migrate != ON_OFF_AUTO_OFF;
>>> +}
>>> +
>>> +const VMStateDescription vmstate_vfio_display = {
>>> +    .name = "VFIOPCIDevice/VFIODisplay",
>>> +    .version_id = 1,
>>> +    .minimum_version_id = 1,
>>> +    .needed = vfio_display_needed,
>>> +    .fields = (VMStateField[]){
>>> +        VMSTATE_STRUCT_POINTER(dpy, VFIOPCIDevice, vfio_display_vmstate, VFIODisplay),
>>> +        VMSTATE_END_OF_LIST()
>>> +    }
>>> +};
>>> +
>>>   const VMStateDescription vmstate_vfio_pci_config = {
>>>       .name = "VFIOPCIDevice",
>>>       .version_id = 1,
>>> @@ -2616,6 +2635,10 @@ const VMStateDescription vmstate_vfio_pci_config = {
>>>           VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
>>>           VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
>>>           VMSTATE_END_OF_LIST()
>>> +    },
>>> +    .subsections = (const VMStateDescription*[]) {
>>> +        &vmstate_vfio_display,
>>> +        NULL
>>>       }
>>>   };
>>>
>>> @@ -3275,6 +3298,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>>           if (!vfio_migration_realize(vbasedev, errp)) {
>>>               goto out_deregister;
>>>           }
>>> +        if (vbasedev->enable_migration == ON_OFF_AUTO_OFF) {
>>> +            if (vdev->ramfb_migrate == ON_OFF_AUTO_AUTO) {
>>> +                vdev->ramfb_migrate = ON_OFF_AUTO_OFF;
>>> +            } else if (vdev->ramfb_migrate == ON_OFF_AUTO_ON) {
>>> +                error_setg(errp, "x-ramfb-migrate requires migration");
>>> +                goto out_deregister;
>>> +            }
>>> +        }
>>>       }
>>>
>>>       vfio_register_err_notifier(vdev);
>>> @@ -3484,6 +3515,7 @@ static const TypeInfo vfio_pci_dev_info = {
>>>
>>>   static Property vfio_pci_dev_nohotplug_properties[] = {
>>>       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
>>> +    DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate, ON_OFF_AUTO_AUTO),
>>>       DEFINE_PROP_END_OF_LIST(),
>>>   };
>>>
>>
>>
> 
> 



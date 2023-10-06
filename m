Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8143C7BB0AA
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 06:05:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoc47-0003lf-RP; Fri, 06 Oct 2023 00:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qoc44-0003lF-Hl
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 00:03:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qoc40-0002xT-Ri
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 00:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696565018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4CZmKyBrZsvy2OW9Qtch8+gzbsK5GDBLXy6VeenbJw8=;
 b=Kr7ThcYQQMK6d3pzKnUvw6uiuj47g8h2ymrT17zCLTTUg4+pgP+ozNvGQps14Z7uHD4Ew1
 17WcJXpZd7jU7L0vA64P1CnwIu0BI4CsgcPn/2tr9mOlAoom6qdva1GdFYwjGbw8OGEVQI
 jK0TiZG+ItzsVPZpWzonCNnn1IYtiCo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-694-aembry7BP46lnmZ4DgTv8w-1; Fri, 06 Oct 2023 00:03:35 -0400
X-MC-Unique: aembry7BP46lnmZ4DgTv8w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51A2A1C0636E;
 Fri,  6 Oct 2023 04:03:34 +0000 (UTC)
Received: from [10.39.192.10] (unknown [10.39.192.10])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B6C2492C37;
 Fri,  6 Oct 2023 04:03:32 +0000 (UTC)
Message-ID: <d04abcb2-7d1c-0ec7-bf7b-0ea3baea1e28@redhat.com>
Date: Fri, 6 Oct 2023 06:03:31 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/3] hw/vfio: add ramfb migration support
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231005113027.1827078-1-marcandre.lureau@redhat.com>
 <20231005113027.1827078-4-marcandre.lureau@redhat.com>
 <6bfe37d7-eefb-08f7-0f74-e89b41fb8af3@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <6bfe37d7-eefb-08f7-0f74-e89b41fb8af3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/5/23 18:34, Cédric Le Goater wrote:
> On 10/5/23 13:30, marcandre.lureau@redhat.com wrote:
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Add a "VFIODisplay" subsection whenever "x-ramfb-migrate" is turned on.
>>
>> Turn it off by default on machines <= 8.1 for compatibility reasons.
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   hw/vfio/pci.h     |  3 +++
>>   hw/core/machine.c |  1 +
>>   hw/vfio/display.c | 20 ++++++++++++++++++++
>>   hw/vfio/pci.c     | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>   stubs/ramfb.c     |  2 ++
>>   5 files changed, 70 insertions(+)
>>
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index 2d836093a8..fd06695542 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -173,6 +173,7 @@ struct VFIOPCIDevice {
>>       bool no_kvm_ioeventfd;
>>       bool no_vfio_ioeventfd;
>>       bool enable_ramfb;
>> +    OnOffAuto ramfb_migrate;
>>       bool defer_kvm_irq_routing;
>>       bool clear_parent_atomics_on_exit;
>>       VFIODisplay *dpy;
>> @@ -226,4 +227,6 @@ void vfio_display_reset(VFIOPCIDevice *vdev);
>>   int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
>>   void vfio_display_finalize(VFIOPCIDevice *vdev);
>>   +extern const VMStateDescription vfio_display_vmstate;
>> +
>>   #endif /* HW_VFIO_VFIO_PCI_H */
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index e4361e3d48..f2c59a293c 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -33,6 +33,7 @@
>>     GlobalProperty hw_compat_8_1[] = {
>>       { "ramfb", "x-migrate", "off" },
>> +    { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" }
>>   };
>>   const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
>>   diff --git a/hw/vfio/display.c b/hw/vfio/display.c
>> index bec864f482..0bdb807642 100644
>> --- a/hw/vfio/display.c
>> +++ b/hw/vfio/display.c
>> @@ -542,3 +542,23 @@ void vfio_display_finalize(VFIOPCIDevice *vdev)
>>       vfio_display_edid_exit(vdev->dpy);
>>       g_free(vdev->dpy);
>>   }
>> +
>> +static bool migrate_needed(void *opaque)
>> +{
>> +    VFIODisplay *dpy = opaque;
>> +    bool ramfb_exists = dpy->ramfb != NULL;
>> +
>> +    /* see vfio_display_migration_needed() */
>> +    assert(ramfb_exists);
>> +    return ramfb_exists;
>> +}
>> +
>> +const VMStateDescription vfio_display_vmstate = {
>> +    .name = "VFIODisplay",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = migrate_needed,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_STRUCT_POINTER(ramfb, VFIODisplay, ramfb_vmstate,
>> RAMFBState),
>> +    }
>> +};
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 3b2ca3c24c..d2ede2f1a2 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2608,6 +2608,32 @@ static bool vfio_msix_present(void *opaque, int
>> version_id)
>>       return msix_present(pdev);
>>   }
>>   +static bool vfio_display_migration_needed(void *opaque)
>> +{
>> +    VFIOPCIDevice *vdev = opaque;
>> +
>> +    /*
>> +     * We need to migrate the VFIODisplay object if ramfb *migration*
>> was
>> +     * explicitly requested (in which case we enforced both ramfb=on and
>> +     * display=on), or ramfb migration was left at the default "auto"
>> +     * setting, and *ramfb* was explicitly requested (in which case we
>> +     * enforced display=on).
>> +     */
>> +    return vdev->ramfb_migrate == ON_OFF_AUTO_ON ||
>> +        (vdev->ramfb_migrate == ON_OFF_AUTO_AUTO &&
>> vdev->enable_ramfb);> +}
>> +
>> +const VMStateDescription vmstate_vfio_display = {
>> +    .name = "VFIOPCIDevice/VFIODisplay",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = vfio_display_migration_needed,
>> +    .fields = (VMStateField[]){
>> +        VMSTATE_STRUCT_POINTER(dpy, VFIOPCIDevice,
>> vfio_display_vmstate, VFIODisplay),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>   const VMStateDescription vmstate_vfio_pci_config = {
>>       .name = "VFIOPCIDevice",
>>       .version_id = 1,
>> @@ -2616,6 +2642,10 @@ const VMStateDescription
>> vmstate_vfio_pci_config = {
>>           VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
>>           VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
>>           VMSTATE_END_OF_LIST()
>> +    },
>> +    .subsections = (const VMStateDescription*[]) {
>> +        &vmstate_vfio_display,
>> +        NULL
>>       }
>>   };
>>   @@ -3271,6 +3301,19 @@ static void vfio_realize(PCIDevice *pdev,
>> Error **errp)
>>           }
>>       }
>>   +    if (vdev->ramfb_migrate == ON_OFF_AUTO_ON &&
>> !vdev->enable_ramfb) {
>> +        error_setg(errp, "x-ramfb-migrate requires ramfb=on");
> 
> This is a case where QEMU would be run from the command line. Could we
> ouput a warning and force "ramfb_migrate" to OFF in that case ? since
> the machine would still run.

Sounds like a valid idea to me:

- consistency between x-ramfb-migrate and ramfb would be maintained

- x-* properties are not meant as user interface, so QEMU doesn't
guarantee anything about them, AIUI

Laszlo

> 
> Thanks,
> 
> C.
> 
> 
>> +        goto out_deregister;
>> +    }
>> +    if (vbasedev->enable_migration == ON_OFF_AUTO_OFF) {
>> +        if (vdev->ramfb_migrate == ON_OFF_AUTO_AUTO) {
>> +            vdev->ramfb_migrate = ON_OFF_AUTO_OFF;
>> +        } else if (vdev->ramfb_migrate == ON_OFF_AUTO_ON) {
>> +            error_setg(errp, "x-ramfb-migrate requires
>> enable-migration");
>> +            goto out_deregister;
>> +        }
>> +    }
>> +
>>       if (!pdev->failover_pair_id) {
>>           if (!vfio_migration_realize(vbasedev, errp)) {
>>               goto out_deregister;
>> @@ -3484,6 +3527,7 @@ static const TypeInfo vfio_pci_dev_info = {
>>     static Property vfio_pci_dev_nohotplug_properties[] = {
>>       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
>> +    DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice,
>> ramfb_migrate, ON_OFF_AUTO_AUTO),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   diff --git a/stubs/ramfb.c b/stubs/ramfb.c
>> index 48143f3354..cf64733b10 100644
>> --- a/stubs/ramfb.c
>> +++ b/stubs/ramfb.c
>> @@ -2,6 +2,8 @@
>>   #include "qapi/error.h"
>>   #include "hw/display/ramfb.h"
>>   +const VMStateDescription ramfb_vmstate = {};
>> +
>>   void ramfb_display_update(QemuConsole *con, RAMFBState *s)
>>   {
>>   }
> 



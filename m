Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C427BF3BF
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:05:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq6mf-0008BD-TA; Tue, 10 Oct 2023 03:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qq6me-0008Az-6K
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:04:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qq6mP-0001xm-HS
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696921422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLjnn0XDm873tGKnn8xr5ZTaEt/mtGq9uVHDd28gOR0=;
 b=BBIPr//vHGEB9C3jQIjmSC/ftfmwu46MLP34TwCDw8z/gwNffFTwzHS+ov/odgg5xp0qux
 dmePhemEcVSNRK+F3KnV2M8FUVqFr4QKmZ3rDhjBwZdRPiuvo5qOFau7txLQCnslMkOsjC
 nfCOPH/L6JYV500r8ojhs+PczKoQY40=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-xPPlqMsrMkqb6XMQ2ygSgA-1; Tue, 10 Oct 2023 03:03:31 -0400
X-MC-Unique: xPPlqMsrMkqb6XMQ2ygSgA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7756d4d252cso713642485a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 00:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696921411; x=1697526211;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iLjnn0XDm873tGKnn8xr5ZTaEt/mtGq9uVHDd28gOR0=;
 b=WeCNOmWQy1uitwIDxCMJWW8IxOG2iGlTlMFOMfLEAySvtdLyW8dlrQD99yu5Vh3VHk
 tdw88fIkIfzgrFO4zG/R2HnDFUw7owJGqWtvpF8HwOdR2xQKvU1NKGKNPD8/W/Kv2QcM
 bff3qahPRhJKhrHojusuF7IsIAQmgUl7bRUfmDTxDaJS5pTkSVi0+W2MKeCS2yQXziPK
 /aifsdITlmtxHY7ucDFm3o2FEpg1xIP8wabTfXBxYJB0IxQ8MyVXJuVPqlAEtIir0vnc
 /H/6EG1t29Squz9LpIMWtDmWHmWNTeFxea0cnuX4KbBsnOB8YBqKVt2G/zuJbZT5v1EX
 qOtQ==
X-Gm-Message-State: AOJu0YzcxOC1KY/8L0WO3CKOD9wEQCMCnnMA6ut8B1wUQpUk1Qqkjgwt
 7UhSnFBx3DTVP0GJkqalTA33tRpaQSDdb0vxJwVNf7uSMahQK05Zp9XQ9BZvpLCYZYpDtqeLp13
 +QfDXBqg+DpDk/8c=
X-Received: by 2002:a05:620a:e14:b0:76d:984c:9d01 with SMTP id
 y20-20020a05620a0e1400b0076d984c9d01mr15520211qkm.33.1696921410737; 
 Tue, 10 Oct 2023 00:03:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqtGJd3drflIuDRbu+rhs32oGxQ+qIzXv1gL5vo97oXqXJ5Kp9zqeVkMDJYmfrZbVHtxMhQw==
X-Received: by 2002:a05:620a:e14:b0:76d:984c:9d01 with SMTP id
 y20-20020a05620a0e1400b0076d984c9d01mr15520199qkm.33.1696921410369; 
 Tue, 10 Oct 2023 00:03:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 y6-20020a37e306000000b0077413b342e9sm4090407qki.128.2023.10.10.00.03.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 00:03:29 -0700 (PDT)
Message-ID: <40e84da6-a8cc-b4ea-4a81-0d0fded690dc@redhat.com>
Date: Tue, 10 Oct 2023 09:03:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 3/3] hw/vfio: add ramfb migration support
Content-Language: en-US
To: Laszlo Ersek <lersek@redhat.com>, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231009063247.119333-1-marcandre.lureau@redhat.com>
 <20231009063247.119333-4-marcandre.lureau@redhat.com>
 <a9f3a4e4-5084-897c-a9de-df80f5302e76@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <a9f3a4e4-5084-897c-a9de-df80f5302e76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/9/23 12:19, Laszlo Ersek wrote:
> On 10/9/23 08:32, marcandre.lureau@redhat.com wrote:
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Add a "VFIODisplay" subsection whenever "x-ramfb-migrate" is turned on.
>>
>> Turn it off by default on machines <= 8.1 for compatibility reasons.
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>> ---
>>   hw/vfio/pci.h     |  3 +++
>>   hw/core/machine.c |  1 +
>>   hw/vfio/display.c | 21 +++++++++++++++++++++
>>   hw/vfio/pci.c     | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>   stubs/ramfb.c     |  2 ++
>>   5 files changed, 71 insertions(+)
>>
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index 2d836093a8..fd06695542 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -173,6 +173,7 @@ struct VFIOPCIDevice {
>>       bool no_kvm_ioeventfd;
>>       bool no_vfio_ioeventfd;
>>       bool enable_ramfb;
>> +    OnOffAuto ramfb_migrate;
>>       bool defer_kvm_irq_routing;
>>       bool clear_parent_atomics_on_exit;
>>       VFIODisplay *dpy;
>> @@ -226,4 +227,6 @@ void vfio_display_reset(VFIOPCIDevice *vdev);
>>   int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
>>   void vfio_display_finalize(VFIOPCIDevice *vdev);
>>   
>> +extern const VMStateDescription vfio_display_vmstate;
>> +
>>   #endif /* HW_VFIO_VFIO_PCI_H */
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 6305f2d7a4..05aef2cf9f 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -35,6 +35,7 @@
>>   GlobalProperty hw_compat_8_1[] = {
>>       { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
>>       { "ramfb", "x-migrate", "off" },
>> +    { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" }
>>   };
>>   const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
>>   
>> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
>> index bec864f482..2739ba56ec 100644
>> --- a/hw/vfio/display.c
>> +++ b/hw/vfio/display.c
>> @@ -542,3 +542,24 @@ void vfio_display_finalize(VFIOPCIDevice *vdev)
>>       vfio_display_edid_exit(vdev->dpy);
>>       g_free(vdev->dpy);
>>   }
>> +
>> +static bool migrate_needed(void *opaque)
>> +{
>> +    VFIODisplay *dpy = opaque;
>> +    bool ramfb_exists = dpy->ramfb != NULL;
>> +
>> +    /* see vfio_display_migration_needed() */
>> +    assert(ramfb_exists);
>> +    return ramfb_exists;
>> +}
>> +
>> +const VMStateDescription vfio_display_vmstate = {
>> +    .name = "VFIODisplay",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = migrate_needed,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_STRUCT_POINTER(ramfb, VFIODisplay, ramfb_vmstate, RAMFBState),
>> +        VMSTATE_END_OF_LIST(),
>> +    }
>> +};
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 3b2ca3c24c..e44ed21180 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2608,6 +2608,32 @@ static bool vfio_msix_present(void *opaque, int version_id)
>>       return msix_present(pdev);
>>   }
>>   
>> +static bool vfio_display_migration_needed(void *opaque)
>> +{
>> +    VFIOPCIDevice *vdev = opaque;
>> +
>> +    /*
>> +     * We need to migrate the VFIODisplay object if ramfb *migration* was
>> +     * explicitly requested (in which case we enforced both ramfb=on and
>> +     * display=on), or ramfb migration was left at the default "auto"
>> +     * setting, and *ramfb* was explicitly requested (in which case we
>> +     * enforced display=on).
>> +     */
>> +    return vdev->ramfb_migrate == ON_OFF_AUTO_ON ||
>> +        (vdev->ramfb_migrate == ON_OFF_AUTO_AUTO && vdev->enable_ramfb);
>> +}
>> +
>> +const VMStateDescription vmstate_vfio_display = {
>> +    .name = "VFIOPCIDevice/VFIODisplay",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = vfio_display_migration_needed,
>> +    .fields = (VMStateField[]){
>> +        VMSTATE_STRUCT_POINTER(dpy, VFIOPCIDevice, vfio_display_vmstate, VFIODisplay),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>   const VMStateDescription vmstate_vfio_pci_config = {
>>       .name = "VFIOPCIDevice",
>>       .version_id = 1,
>> @@ -2616,6 +2642,10 @@ const VMStateDescription vmstate_vfio_pci_config = {
>>           VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
>>           VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
>>           VMSTATE_END_OF_LIST()
>> +    },
>> +    .subsections = (const VMStateDescription*[]) {
>> +        &vmstate_vfio_display,
>> +        NULL
>>       }
>>   };
>>   
>> @@ -3271,6 +3301,19 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>           }
>>       }
>>   
>> +    if (vdev->ramfb_migrate == ON_OFF_AUTO_ON && !vdev->enable_ramfb) {
>> +        warn_report("x-ramfb-migrate=on but ramfb=off");
>> +        vdev->ramfb_migrate = ON_OFF_AUTO_OFF;
> 
> the warning could give a hint about the resultant action taken (i.e.,
> forcing off x-ramfb-migrate), but don't repost just for that; it's a nit.

yes.

How about :

         warn_report("x-ramfb-migrate=on but ramfb=off. Forcing x-ramfb-migrate to off.");

I can amend the patch if you agree.

Thanks,

C.

> My R-b stands.
> 
> Thanks
> Laszlo
> 
>> +    }
>> +    if (vbasedev->enable_migration == ON_OFF_AUTO_OFF) {
>> +        if (vdev->ramfb_migrate == ON_OFF_AUTO_AUTO) {
>> +            vdev->ramfb_migrate = ON_OFF_AUTO_OFF;
>> +        } else if (vdev->ramfb_migrate == ON_OFF_AUTO_ON) {
>> +            error_setg(errp, "x-ramfb-migrate requires enable-migration");
>> +            goto out_deregister;
>> +        }
>> +    }
>> +
>>       if (!pdev->failover_pair_id) {
>>           if (!vfio_migration_realize(vbasedev, errp)) {
>>               goto out_deregister;
>> @@ -3484,6 +3527,7 @@ static const TypeInfo vfio_pci_dev_info = {
>>   
>>   static Property vfio_pci_dev_nohotplug_properties[] = {
>>       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
>> +    DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate, ON_OFF_AUTO_AUTO),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   
>> diff --git a/stubs/ramfb.c b/stubs/ramfb.c
>> index 48143f3354..cf64733b10 100644
>> --- a/stubs/ramfb.c
>> +++ b/stubs/ramfb.c
>> @@ -2,6 +2,8 @@
>>   #include "qapi/error.h"
>>   #include "hw/display/ramfb.h"
>>   
>> +const VMStateDescription ramfb_vmstate = {};
>> +
>>   void ramfb_display_update(QemuConsole *con, RAMFBState *s)
>>   {
>>   }
> 



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4001F7BA20A
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 17:12:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoQ0J-0008Es-Gm; Thu, 05 Oct 2023 11:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qoQ0I-0008Ef-1A
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:11:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qoQ0F-0000Rr-Sl
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696518663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Lo8x5QUmG21Iu4TvA3S6+svq8moJHxytHfY7BREn9I=;
 b=aZ/wSC9LhZytxd40xknBnN2F7EBNgY5MLUwnbgRkjKiipV7r4s/96Ifwc4/WN4ESXzy4IT
 dtBnP6zyMAjoIycgaHqY1Y41ZBcMlNt/wkU+LNyeTITsT+kcTlZ+pdsxDoqhqJr/zgKk6V
 /gyCbUOl4layE2/sP4mLIU7o2O51cfY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-G8WMz6moPWOavyuYriH2Zw-1; Thu, 05 Oct 2023 11:11:00 -0400
X-MC-Unique: G8WMz6moPWOavyuYriH2Zw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-774335cb98cso114137385a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 08:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696518660; x=1697123460;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Lo8x5QUmG21Iu4TvA3S6+svq8moJHxytHfY7BREn9I=;
 b=v8O67Vz3uga+URD1aOOM41f58hJWYo1D0tmC3s/0tt1g7N5DilwxB92TTuGq+HlWL7
 ZpAcoOcEvj0Tl8IAHUx+6k5fnBh54yySA2tldG2p2W35X4QW8bmsP3+cF1vyJXN6cZhx
 uKTtiwg0jXTSiVlfJrApeAnEAtLjcaFSn3Y9Y2kiNqqAc+i7DelGRbtiHqGes8bhPuE+
 vQY3ZkCgkX4pwL/ccDGxJ7E0LbGHTu+9otv9oXu9bPJLd761LpbacEvPcHgsTelVV3pw
 KSXbjT18k8niMGm5/ZyLvg6KJ9aqc73zCoqgwiR3tqw6Djq9RUFt2E7z5vntJzYTJP5L
 uI1w==
X-Gm-Message-State: AOJu0YyHZ1POTO68PvbID5kp+qOFuQgJbu502dPNVT4hbO5wocSb6OzN
 j5aonS3qztw5iw8PP/CSjvynX3And/u0A3aov8sBPeJK43P9bqkxYsZ7HUTSmADGTuMQ4RlYdZf
 Tk63Z/sOkOFs3rsg=
X-Received: by 2002:a05:620a:2404:b0:773:a9f7:eaf1 with SMTP id
 d4-20020a05620a240400b00773a9f7eaf1mr6927372qkn.21.1696518660158; 
 Thu, 05 Oct 2023 08:11:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKMUTIXdzZnlcPlORsqx9e691yJmm6Gmxx0SD2SlGq892230g+8v9k8ptEWcL9CpC/7Gv2PA==
X-Received: by 2002:a05:620a:2404:b0:773:a9f7:eaf1 with SMTP id
 d4-20020a05620a240400b00773a9f7eaf1mr6927339qkn.21.1696518659885; 
 Thu, 05 Oct 2023 08:10:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 x13-20020a05620a14ad00b007756736aed7sm545303qkj.106.2023.10.05.08.10.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 08:10:59 -0700 (PDT)
Message-ID: <552cfc35-102b-f4ed-b666-e41611cf996c@redhat.com>
Date: Thu, 5 Oct 2023 17:10:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 3/3] hw/vfio: add ramfb migration support
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, lersek@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231005113027.1827078-1-marcandre.lureau@redhat.com>
 <20231005113027.1827078-4-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231005113027.1827078-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 10/5/23 13:30, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Add a "VFIODisplay" subsection whenever "x-ramfb-migrate" is turned on.
> 
> Turn it off by default on machines <= 8.1 for compatibility reasons.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/vfio/pci.h     |  3 +++
>   hw/core/machine.c |  1 +
>   hw/vfio/display.c | 20 ++++++++++++++++++++
>   hw/vfio/pci.c     | 44 ++++++++++++++++++++++++++++++++++++++++++++
>   stubs/ramfb.c     |  2 ++
>   5 files changed, 70 insertions(+)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 2d836093a8..fd06695542 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -173,6 +173,7 @@ struct VFIOPCIDevice {
>       bool no_kvm_ioeventfd;
>       bool no_vfio_ioeventfd;
>       bool enable_ramfb;
> +    OnOffAuto ramfb_migrate;
>       bool defer_kvm_irq_routing;
>       bool clear_parent_atomics_on_exit;
>       VFIODisplay *dpy;
> @@ -226,4 +227,6 @@ void vfio_display_reset(VFIOPCIDevice *vdev);
>   int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
>   void vfio_display_finalize(VFIOPCIDevice *vdev);
>   
> +extern const VMStateDescription vfio_display_vmstate;
> +
>   #endif /* HW_VFIO_VFIO_PCI_H */
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index e4361e3d48..f2c59a293c 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -33,6 +33,7 @@
>   
>   GlobalProperty hw_compat_8_1[] = {
>       { "ramfb", "x-migrate", "off" },
> +    { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" }
>   };
>   const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
>   
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index bec864f482..0bdb807642 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -542,3 +542,23 @@ void vfio_display_finalize(VFIOPCIDevice *vdev)
>       vfio_display_edid_exit(vdev->dpy);
>       g_free(vdev->dpy);
>   }
> +
> +static bool migrate_needed(void *opaque)
> +{
> +    VFIODisplay *dpy = opaque;
> +    bool ramfb_exists = dpy->ramfb != NULL;
> +
> +    /* see vfio_display_migration_needed() */
> +    assert(ramfb_exists);
> +    return ramfb_exists;
> +}
> +
> +const VMStateDescription vfio_display_vmstate = {
> +    .name = "VFIODisplay",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = migrate_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_STRUCT_POINTER(ramfb, VFIODisplay, ramfb_vmstate, RAMFBState),

This vfio_display_vmstate lacks :

  VMSTATE_END_OF_LIST()

Thanks,

C.

> +    }
> +};
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 3b2ca3c24c..d2ede2f1a2 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2608,6 +2608,32 @@ static bool vfio_msix_present(void *opaque, int version_id)
>       return msix_present(pdev);
>   }
>   
> +static bool vfio_display_migration_needed(void *opaque)
> +{
> +    VFIOPCIDevice *vdev = opaque;
> +
> +    /*
> +     * We need to migrate the VFIODisplay object if ramfb *migration* was
> +     * explicitly requested (in which case we enforced both ramfb=on and
> +     * display=on), or ramfb migration was left at the default "auto"
> +     * setting, and *ramfb* was explicitly requested (in which case we
> +     * enforced display=on).
> +     */
> +    return vdev->ramfb_migrate == ON_OFF_AUTO_ON ||
> +        (vdev->ramfb_migrate == ON_OFF_AUTO_AUTO && vdev->enable_ramfb);
> +}
> +
> +const VMStateDescription vmstate_vfio_display = {
> +    .name = "VFIOPCIDevice/VFIODisplay",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = vfio_display_migration_needed,
> +    .fields = (VMStateField[]){
> +        VMSTATE_STRUCT_POINTER(dpy, VFIOPCIDevice, vfio_display_vmstate, VFIODisplay),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   const VMStateDescription vmstate_vfio_pci_config = {
>       .name = "VFIOPCIDevice",
>       .version_id = 1,
> @@ -2616,6 +2642,10 @@ const VMStateDescription vmstate_vfio_pci_config = {
>           VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
>           VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
>           VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription*[]) {
> +        &vmstate_vfio_display,
> +        NULL
>       }
>   };
>   
> @@ -3271,6 +3301,19 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>           }
>       }
>   
> +    if (vdev->ramfb_migrate == ON_OFF_AUTO_ON && !vdev->enable_ramfb) {
> +        error_setg(errp, "x-ramfb-migrate requires ramfb=on");
> +        goto out_deregister;
> +    }
> +    if (vbasedev->enable_migration == ON_OFF_AUTO_OFF) {
> +        if (vdev->ramfb_migrate == ON_OFF_AUTO_AUTO) {
> +            vdev->ramfb_migrate = ON_OFF_AUTO_OFF;
> +        } else if (vdev->ramfb_migrate == ON_OFF_AUTO_ON) {
> +            error_setg(errp, "x-ramfb-migrate requires enable-migration");
> +            goto out_deregister;
> +        }
> +    }
> +
>       if (!pdev->failover_pair_id) {
>           if (!vfio_migration_realize(vbasedev, errp)) {
>               goto out_deregister;
> @@ -3484,6 +3527,7 @@ static const TypeInfo vfio_pci_dev_info = {
>   
>   static Property vfio_pci_dev_nohotplug_properties[] = {
>       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
> +    DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate, ON_OFF_AUTO_AUTO),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> diff --git a/stubs/ramfb.c b/stubs/ramfb.c
> index 48143f3354..cf64733b10 100644
> --- a/stubs/ramfb.c
> +++ b/stubs/ramfb.c
> @@ -2,6 +2,8 @@
>   #include "qapi/error.h"
>   #include "hw/display/ramfb.h"
>   
> +const VMStateDescription ramfb_vmstate = {};
> +
>   void ramfb_display_update(QemuConsole *con, RAMFBState *s)
>   {
>   }



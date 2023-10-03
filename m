Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B10D57B6628
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 12:16:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qncRk-0007Tl-GL; Tue, 03 Oct 2023 06:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qncRj-0007TQ-7M
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 06:16:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qncRf-0004S3-C1
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 06:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696328162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NKxkb9notpFN5HSbDam62W6IRowaRiQGN1tuwNUahPQ=;
 b=dn4qiDvfMWxtmfY4i9XkmIMAAZZh2GqEB3bMMlw3whdgFeyD+RS7jNZRDPuT3qhoJDGg9O
 b0EL/xaYXJQmTWY6+/o4cfP5Zzgau01E+soB6GNjGeaPO9RX07S9EZLHVcs5Ta1KYDamie
 bafnnlu/F5fMvp2JCtE1Ly7pFTrO17I=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-ayqLY1GqPe6lZE2mPE-Tjw-1; Tue, 03 Oct 2023 06:15:51 -0400
X-MC-Unique: ayqLY1GqPe6lZE2mPE-Tjw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-65afa60d118so9254256d6.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 03:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696328151; x=1696932951;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NKxkb9notpFN5HSbDam62W6IRowaRiQGN1tuwNUahPQ=;
 b=vfEsQJlrWXF42C55uIKYGoZ8MzxR+kh7Pr+PjKZIS3RKi79tSauc8k1wz1u/p0T+G3
 r9Duu0bKBFfX1qPob4221NZuMr6QxnKbwqUmnpgFLSK04A+BNnZzHBa6YZ7TVVtt6BeT
 88s+STnJsZLIvZLKETZIyAbLDAt8z2ug5BGgI+Ve2SVEKoend6pYAc879SN/uZze4FHG
 rY7RFUyhQ+7vrCwGObbtZoq15qdncC8At1/w7QjhBf6/Rmi3SNINK5cRdPuWg1K7JanJ
 U6ea85xHh0611zQzXj+LZhVlvTLEPyQSsw22oTmmqbil6jFOsZqT/udD9M26RLPGFEsM
 0zxw==
X-Gm-Message-State: AOJu0Yy+a2IecYTAXqduONV2lLhX+i8dJd5dXCOqey/JC8ajHy+VkDwC
 arbZJEeb5qtMskfkocndipXnoPMuxdrPiBRatKW+nq8LjrHkluSrQnObUqa8MaMvZS11OKipVpq
 UuN0eCOVBh5w81/E=
X-Received: by 2002:a0c:e3d3:0:b0:668:ecef:b997 with SMTP id
 e19-20020a0ce3d3000000b00668ecefb997mr2500043qvl.41.1696328150911; 
 Tue, 03 Oct 2023 03:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkUTSqUc/A2xCuyLODF4IzDJFXXg+T6CzXumMaSApC0V/j87d9gYghWE1R2FSCBOTr+XUlUQ==
X-Received: by 2002:a0c:e3d3:0:b0:668:ecef:b997 with SMTP id
 e19-20020a0ce3d3000000b00668ecefb997mr2500024qvl.41.1696328150530; 
 Tue, 03 Oct 2023 03:15:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 f14-20020a0caa8e000000b006516780a0a5sm347401qvb.117.2023.10.03.03.15.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 03:15:50 -0700 (PDT)
Message-ID: <7df9e19a-4ead-516c-21b3-04d8e899d7e7@redhat.com>
Date: Tue, 3 Oct 2023 12:15:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 5/5] hw/vfio: add ramfb migration support
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, lersek@redhat.com,
 kraxel@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20231003085644.1220326-1-marcandre.lureau@redhat.com>
 <20231003085644.1220326-6-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231003085644.1220326-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.321, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 10/3/23 10:56, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Add a "VFIODisplay" subsection whenever "x-ramfb-migrate" is turned on.
> 
> Turn it off by default on machines <= 8.1 for compatibility reasons.


This change breaks linking on various platforms with :

/usr/bin/ld: libqemu-xtensa-softmmu.fa.p/hw_vfio_display.c.o:(.data.rel+0x50): undefined reference to `ramfb_vmstate'

Some stubs updates are missing it seems..

Thanks,

C.

> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/vfio/pci.h     |  3 +++
>   hw/core/machine.c |  1 +
>   hw/vfio/display.c | 23 +++++++++++++++++++++++
>   hw/vfio/pci.c     | 32 ++++++++++++++++++++++++++++++++
>   4 files changed, 59 insertions(+)
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
> index 47a07d1d9b..f2f8940a85 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -32,6 +32,7 @@
>   
>   GlobalProperty hw_compat_8_1[] = {
>       { "ramfb", "x-migrate", "off" },
> +    { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" }
>   };
>   const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
>   
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index bec864f482..de5bf71dd1 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -542,3 +542,26 @@ void vfio_display_finalize(VFIOPCIDevice *vdev)
>       vfio_display_edid_exit(vdev->dpy);
>       g_free(vdev->dpy);
>   }
> +
> +static bool migrate_needed(void *opaque)
> +{
> +    /*
> +     * If we are here, it's because vfio_display_needed(), which is only true
> +     * when dpy->ramfb_migrate atm.
> +     *
> +     * If the migration condition is changed, we should check here if
> +     * ramfb_migrate is true. (this will need a way to lookup the associated
> +     * VFIOPCIDevice somehow, or fields to be moved, ..)
> +     */
> +    return true;
> +}
> +
> +const VMStateDescription vfio_display_vmstate = {
> +    .name = "VFIODisplay",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = migrate_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_STRUCT_POINTER(ramfb, VFIODisplay, ramfb_vmstate, RAMFBState),
> +    }
> +};
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 3b2ca3c24c..4689f2e5c1 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2608,6 +2608,25 @@ static bool vfio_msix_present(void *opaque, int version_id)
>       return msix_present(pdev);
>   }
>   
> +static bool vfio_display_needed(void *opaque)
> +{
> +    VFIOPCIDevice *vdev = opaque;
> +
> +    /* the only thing that justifies the VFIODisplay sub-section atm */
> +    return vdev->ramfb_migrate != ON_OFF_AUTO_OFF;
> +}
> +
> +const VMStateDescription vmstate_vfio_display = {
> +    .name = "VFIOPCIDevice/VFIODisplay",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = vfio_display_needed,
> +    .fields = (VMStateField[]){
> +        VMSTATE_STRUCT_POINTER(dpy, VFIOPCIDevice, vfio_display_vmstate, VFIODisplay),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   const VMStateDescription vmstate_vfio_pci_config = {
>       .name = "VFIOPCIDevice",
>       .version_id = 1,
> @@ -2616,6 +2635,10 @@ const VMStateDescription vmstate_vfio_pci_config = {
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
> @@ -3275,6 +3298,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>           if (!vfio_migration_realize(vbasedev, errp)) {
>               goto out_deregister;
>           }
> +        if (vbasedev->enable_migration == ON_OFF_AUTO_OFF) {
> +            if (vdev->ramfb_migrate == ON_OFF_AUTO_AUTO) {
> +                vdev->ramfb_migrate = ON_OFF_AUTO_OFF;
> +            } else if (vdev->ramfb_migrate == ON_OFF_AUTO_ON) {
> +                error_setg(errp, "x-ramfb-migrate requires migration");
> +                goto out_deregister;
> +            }
> +        }
>       }
>   
>       vfio_register_err_notifier(vdev);
> @@ -3484,6 +3515,7 @@ static const TypeInfo vfio_pci_dev_info = {
>   
>   static Property vfio_pci_dev_nohotplug_properties[] = {
>       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
> +    DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate, ON_OFF_AUTO_AUTO),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   



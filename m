Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C5A7B5424
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 15:39:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnJ7s-00084y-8T; Mon, 02 Oct 2023 09:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnJ7q-00084q-OW
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 09:38:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnJ7p-0006Ez-0u
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 09:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696253895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XD9buUI08OV8TNlyZhL2e52n2V2SvRoDek2lQtNbVTI=;
 b=D0DWRgyC6w4eqMN2VHWDa2xx/95eX8XFLdLqVosdr7SPVofYrKUs/ub3AR58MerzSEExZq
 9c0szgLZW/SHVZcmyY9PrUFT04/WvVhSrJOZiDUXPnsCIin3RqGSRZtZC+zVJwKMbyP5wQ
 nniMtBK6sys19R2Ol1h3mXPr6VbpPYw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-5SKZrILLNEqGFr0o4hFU3w-1; Mon, 02 Oct 2023 09:38:14 -0400
X-MC-Unique: 5SKZrILLNEqGFr0o4hFU3w-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7740c3506b9so3213467385a.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 06:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696253893; x=1696858693;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XD9buUI08OV8TNlyZhL2e52n2V2SvRoDek2lQtNbVTI=;
 b=fm4/3qXFf5FHfL/TePHCKxiuFkzLn54+zt/nYw5jQ/9/Pp9d/nQCug/gW2660oqN89
 XlU4Nn1F3XUMffbN96HDyixjlTHenqncaaUwcEY6Xvb3jOUsfy2zaaq+ppjX0LNfxp6T
 HENyrZwKI/IEhzs51bt9F7sZw5dpMa9Xv6ALNe7wHLzjpGufRZyHmI2/lQmi3c8rFdFX
 fpqetwP5l/F/13kv58O9dDmCPud/cFkyMyjHHRykp7tLMIz8rkaq3H2gUH9c0J8zbSjZ
 RL7CS6WiQx4Uyvi/Sy7PNlMMlQAzrC0rZRisOlV+zEPGRKzvEfA5qA3/HnNDSJ9XIHG1
 ciCw==
X-Gm-Message-State: AOJu0YwpVviDWL2bCJ0pMfHufjb1WMnyL9qtR5tFvcl+UdnVvTPwaJJb
 DmCY1VJ54BWMJLwxmKLLq3EZYk2x0Z0WHF8b5DniyzG9opmvaMnM/zQXvUoDGL1gFRZauz9LzXl
 7FwsziPRDvkbyRqk=
X-Received: by 2002:a05:6214:14b2:b0:64f:9333:13bc with SMTP id
 bo18-20020a05621414b200b0064f933313bcmr12626240qvb.23.1696253893752; 
 Mon, 02 Oct 2023 06:38:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI+EDQlZWmjQyKJYRJCynGwis0ClkLvx1Cl5IR0OahbNSvuu7dRQJdxeuNVD3i+YoVvTA6Dw==
X-Received: by 2002:a05:6214:14b2:b0:64f:9333:13bc with SMTP id
 bo18-20020a05621414b200b0064f933313bcmr12626225qvb.23.1696253893484; 
 Mon, 02 Oct 2023 06:38:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a05620a038900b0076cb1eff83csm3416010qkm.5.2023.10.02.06.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 06:38:13 -0700 (PDT)
Message-ID: <f0e4b89b-b88b-edfa-7855-fa41d5c72b69@redhat.com>
Date: Mon, 2 Oct 2023 15:38:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/5] ramfb: make migration conditional
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, lersek@redhat.com,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231002111154.1002655-1-marcandre.lureau@redhat.com>
 <20231002111154.1002655-5-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231002111154.1002655-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.321, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 10/2/23 13:11, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> RAMFB migration was unsupported until now, let's make it conditional.
> The following patch will prevent machines <= 8.1 to migrate it.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Maybe localize the new 'ramfb_migrate' attribute close to 'enable_ramfb'
in VFIOPCIDevice. Anyhow,

Acked-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.h                 | 1 +
>   include/hw/display/ramfb.h    | 2 +-
>   hw/display/ramfb-standalone.c | 8 +++++++-
>   hw/display/ramfb.c            | 6 ++++--
>   hw/vfio/display.c             | 4 ++--
>   hw/vfio/pci.c                 | 1 +
>   stubs/ramfb.c                 | 2 +-
>   7 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 2d836093a8..671cc78912 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -156,6 +156,7 @@ struct VFIOPCIDevice {
>       OnOffAuto display;
>       uint32_t display_xres;
>       uint32_t display_yres;
> +    bool ramfb_migrate;
>       int32_t bootindex;
>       uint32_t igd_gms;
>       OffAutoPCIBAR msix_relo;
> diff --git a/include/hw/display/ramfb.h b/include/hw/display/ramfb.h
> index b33a2c467b..40063b62bd 100644
> --- a/include/hw/display/ramfb.h
> +++ b/include/hw/display/ramfb.h
> @@ -4,7 +4,7 @@
>   /* ramfb.c */
>   typedef struct RAMFBState RAMFBState;
>   void ramfb_display_update(QemuConsole *con, RAMFBState *s);
> -RAMFBState *ramfb_setup(Error **errp);
> +RAMFBState *ramfb_setup(bool migrate, Error **errp);
>   
>   /* ramfb-standalone.c */
>   #define TYPE_RAMFB_DEVICE "ramfb"
> diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
> index 8c0094397f..6bbd69ccdf 100644
> --- a/hw/display/ramfb-standalone.c
> +++ b/hw/display/ramfb-standalone.c
> @@ -15,6 +15,7 @@ struct RAMFBStandaloneState {
>       SysBusDevice parent_obj;
>       QemuConsole *con;
>       RAMFBState *state;
> +    bool migrate;
>   };
>   
>   static void display_update_wrapper(void *dev)
> @@ -37,9 +38,13 @@ static void ramfb_realizefn(DeviceState *dev, Error **errp)
>       RAMFBStandaloneState *ramfb = RAMFB(dev);
>   
>       ramfb->con = graphic_console_init(dev, 0, &wrapper_ops, dev);
> -    ramfb->state = ramfb_setup(errp);
> +    ramfb->state = ramfb_setup(ramfb->migrate, errp);
>   }
>   
> +static Property ramfb_properties[] = {
> +    DEFINE_PROP_BOOL("migrate", RAMFBStandaloneState, migrate,  true),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
>   static void ramfb_class_initfn(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -48,6 +53,7 @@ static void ramfb_class_initfn(ObjectClass *klass, void *data)
>       dc->realize = ramfb_realizefn;
>       dc->desc = "ram framebuffer standalone device";
>       dc->user_creatable = true;
> +    device_class_set_props(dc, ramfb_properties);
>   }
>   
>   static const TypeInfo ramfb_info = {
> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index 4aaaa7d653..73e08d605f 100644
> --- a/hw/display/ramfb.c
> +++ b/hw/display/ramfb.c
> @@ -135,7 +135,7 @@ static const VMStateDescription vmstate_ramfb = {
>       }
>   };
>   
> -RAMFBState *ramfb_setup(Error **errp)
> +RAMFBState *ramfb_setup(bool migrate, Error **errp)
>   {
>       FWCfgState *fw_cfg = fw_cfg_find();
>       RAMFBState *s;
> @@ -147,7 +147,9 @@ RAMFBState *ramfb_setup(Error **errp)
>   
>       s = g_new0(RAMFBState, 1);
>   
> -    vmstate_register(NULL, 0, &vmstate_ramfb, s);
> +    if (migrate) {
> +        vmstate_register(NULL, 0, &vmstate_ramfb, s);
> +    }
>       rom_add_vga("vgabios-ramfb.bin");
>       fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
>                                NULL, ramfb_fw_cfg_write, s,
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index bec864f482..3f6b251ccd 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -356,7 +356,7 @@ static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
>                                             &vfio_display_dmabuf_ops,
>                                             vdev);
>       if (vdev->enable_ramfb) {
> -        vdev->dpy->ramfb = ramfb_setup(errp);
> +        vdev->dpy->ramfb = ramfb_setup(vdev->ramfb_migrate, errp);
>       }
>       vfio_display_edid_init(vdev);
>       return 0;
> @@ -483,7 +483,7 @@ static int vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
>                                             &vfio_display_region_ops,
>                                             vdev);
>       if (vdev->enable_ramfb) {
> -        vdev->dpy->ramfb = ramfb_setup(errp);
> +        vdev->dpy->ramfb = ramfb_setup(vdev->ramfb_migrate, errp);
>       }
>       return 0;
>   }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 3b2ca3c24c..6575b8f32d 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3484,6 +3484,7 @@ static const TypeInfo vfio_pci_dev_info = {
>   
>   static Property vfio_pci_dev_nohotplug_properties[] = {
>       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
> +    DEFINE_PROP_BOOL("ramfb-migrate", VFIOPCIDevice, ramfb_migrate,  true),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> diff --git a/stubs/ramfb.c b/stubs/ramfb.c
> index 48143f3354..8869a5db09 100644
> --- a/stubs/ramfb.c
> +++ b/stubs/ramfb.c
> @@ -6,7 +6,7 @@ void ramfb_display_update(QemuConsole *con, RAMFBState *s)
>   {
>   }
>   
> -RAMFBState *ramfb_setup(Error **errp)
> +RAMFBState *ramfb_setup(bool migrate, Error **errp)
>   {
>       error_setg(errp, "ramfb support not available");
>       return NULL;



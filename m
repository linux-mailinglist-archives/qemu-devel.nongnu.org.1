Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7087B5556
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:40:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnK5l-0005Ya-VC; Mon, 02 Oct 2023 10:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnK5j-0005PQ-Sr
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:40:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnK5i-0000uy-0y
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696257608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I1gbmfrmnZnm7RewWmRwDrnW1gC1keb5+kfdUzz2zHc=;
 b=CerPZXN+5Yqd2kkkkz2Rr4SgHbsMs6R5R7lqfpX7f/etYevfAiR/j1ZZGjcz6/K6OXnGPK
 eF9UO5m47F7Dqt5ppcP7W5bTvrPFHUQJWM3jtFvDSocV0NbV3DnMIrDU1IS5ePC5rPTcvd
 pk8M59RULmjWbbEn/mFJIv1I6EHTfkA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-qZzl959BN5qvwIsYxgWM6g-1; Mon, 02 Oct 2023 10:40:07 -0400
X-MC-Unique: qZzl959BN5qvwIsYxgWM6g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20B041C0CCA0
 for <qemu-devel@nongnu.org>; Mon,  2 Oct 2023 14:40:06 +0000 (UTC)
Received: from [10.39.194.43] (unknown [10.39.194.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E174E40C2064;
 Mon,  2 Oct 2023 14:40:04 +0000 (UTC)
Message-ID: <333c9cfb-5c95-970d-2151-0e3847624391@redhat.com>
Date: Mon, 2 Oct 2023 16:40:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/5] ramfb: make migration conditional
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231002111154.1002655-1-marcandre.lureau@redhat.com>
 <20231002111154.1002655-5-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20231002111154.1002655-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> ---
>  hw/vfio/pci.h                 | 1 +
>  include/hw/display/ramfb.h    | 2 +-
>  hw/display/ramfb-standalone.c | 8 +++++++-
>  hw/display/ramfb.c            | 6 ++++--
>  hw/vfio/display.c             | 4 ++--
>  hw/vfio/pci.c                 | 1 +
>  stubs/ramfb.c                 | 2 +-
>  7 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 2d836093a8..671cc78912 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -156,6 +156,7 @@ struct VFIOPCIDevice {
>      OnOffAuto display;
>      uint32_t display_xres;
>      uint32_t display_yres;
> +    bool ramfb_migrate;
>      int32_t bootindex;
>      uint32_t igd_gms;
>      OffAutoPCIBAR msix_relo;
> diff --git a/include/hw/display/ramfb.h b/include/hw/display/ramfb.h
> index b33a2c467b..40063b62bd 100644
> --- a/include/hw/display/ramfb.h
> +++ b/include/hw/display/ramfb.h
> @@ -4,7 +4,7 @@
>  /* ramfb.c */
>  typedef struct RAMFBState RAMFBState;
>  void ramfb_display_update(QemuConsole *con, RAMFBState *s);
> -RAMFBState *ramfb_setup(Error **errp);
> +RAMFBState *ramfb_setup(bool migrate, Error **errp);
>  
>  /* ramfb-standalone.c */
>  #define TYPE_RAMFB_DEVICE "ramfb"
> diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
> index 8c0094397f..6bbd69ccdf 100644
> --- a/hw/display/ramfb-standalone.c
> +++ b/hw/display/ramfb-standalone.c
> @@ -15,6 +15,7 @@ struct RAMFBStandaloneState {
>      SysBusDevice parent_obj;
>      QemuConsole *con;
>      RAMFBState *state;
> +    bool migrate;
>  };
>  
>  static void display_update_wrapper(void *dev)
> @@ -37,9 +38,13 @@ static void ramfb_realizefn(DeviceState *dev, Error **errp)
>      RAMFBStandaloneState *ramfb = RAMFB(dev);
>  
>      ramfb->con = graphic_console_init(dev, 0, &wrapper_ops, dev);
> -    ramfb->state = ramfb_setup(errp);
> +    ramfb->state = ramfb_setup(ramfb->migrate, errp);
>  }
>  
> +static Property ramfb_properties[] = {
> +    DEFINE_PROP_BOOL("migrate", RAMFBStandaloneState, migrate,  true),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
>  static void ramfb_class_initfn(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -48,6 +53,7 @@ static void ramfb_class_initfn(ObjectClass *klass, void *data)
>      dc->realize = ramfb_realizefn;
>      dc->desc = "ram framebuffer standalone device";
>      dc->user_creatable = true;
> +    device_class_set_props(dc, ramfb_properties);
>  }
>  
>  static const TypeInfo ramfb_info = {
> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index 4aaaa7d653..73e08d605f 100644
> --- a/hw/display/ramfb.c
> +++ b/hw/display/ramfb.c
> @@ -135,7 +135,7 @@ static const VMStateDescription vmstate_ramfb = {
>      }
>  };
>  
> -RAMFBState *ramfb_setup(Error **errp)
> +RAMFBState *ramfb_setup(bool migrate, Error **errp)
>  {
>      FWCfgState *fw_cfg = fw_cfg_find();
>      RAMFBState *s;
> @@ -147,7 +147,9 @@ RAMFBState *ramfb_setup(Error **errp)
>  
>      s = g_new0(RAMFBState, 1);
>  
> -    vmstate_register(NULL, 0, &vmstate_ramfb, s);
> +    if (migrate) {
> +        vmstate_register(NULL, 0, &vmstate_ramfb, s);
> +    }
>      rom_add_vga("vgabios-ramfb.bin");
>      fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
>                               NULL, ramfb_fw_cfg_write, s,
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index bec864f482..3f6b251ccd 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -356,7 +356,7 @@ static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
>                                            &vfio_display_dmabuf_ops,
>                                            vdev);
>      if (vdev->enable_ramfb) {
> -        vdev->dpy->ramfb = ramfb_setup(errp);
> +        vdev->dpy->ramfb = ramfb_setup(vdev->ramfb_migrate, errp);
>      }
>      vfio_display_edid_init(vdev);
>      return 0;
> @@ -483,7 +483,7 @@ static int vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
>                                            &vfio_display_region_ops,
>                                            vdev);
>      if (vdev->enable_ramfb) {
> -        vdev->dpy->ramfb = ramfb_setup(errp);
> +        vdev->dpy->ramfb = ramfb_setup(vdev->ramfb_migrate, errp);
>      }
>      return 0;
>  }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 3b2ca3c24c..6575b8f32d 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3484,6 +3484,7 @@ static const TypeInfo vfio_pci_dev_info = {
>  
>  static Property vfio_pci_dev_nohotplug_properties[] = {
>      DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
> +    DEFINE_PROP_BOOL("ramfb-migrate", VFIOPCIDevice, ramfb_migrate,  true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/stubs/ramfb.c b/stubs/ramfb.c
> index 48143f3354..8869a5db09 100644
> --- a/stubs/ramfb.c
> +++ b/stubs/ramfb.c
> @@ -6,7 +6,7 @@ void ramfb_display_update(QemuConsole *con, RAMFBState *s)
>  {
>  }
>  
> -RAMFBState *ramfb_setup(Error **errp)
> +RAMFBState *ramfb_setup(bool migrate, Error **errp)
>  {
>      error_setg(errp, "ramfb support not available");
>      return NULL;

I'm not a seasoned migration reviewer, so -- apologies for the churn --
I'd prefer if this patch were split in three:

- First patch: ramfb_setup() update. All callers pass in constant
"false". Stub updated.

- Second patch: new property for vfio-pci-nohotplug, hooked up to
ramfb_setup() for real.

- Third patch: new property for ramfb-standalone, hooked up to
ramfb_setup() for real.

Without this separation, the hunks are just heaped together in the
patch, and I'm having a hard time understanding the data flow.

Again, apologies that I'm requesting this for a very small patch.

Thanks,
Laszlo



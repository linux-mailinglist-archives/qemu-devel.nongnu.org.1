Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE44AE39E3
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Jun 2025 11:23:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTdOV-0006Jc-Dd; Mon, 23 Jun 2025 05:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1uTdOL-0006IC-FR
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 05:23:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1uTdOI-0008OU-CE
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 05:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750670581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VSgSGwq8wrw3DnPUbktkgQZidTx6uhtariuiUH0CA0=;
 b=OHxlUTTTq7pBl1qB4rk/iptE4lSponruiCpAVONV6tTPsauRFDAK6GxcnhjN79AzrNUgPp
 1Xl8zyxwpnhmsFaLhAkSayrAjpXI1Vkc1hZSAIRirSFS9hSokYtAyAeqyElJLhQ82C/n6L
 h4oJaGdiOIuY/aaliWkplhrIwm37gkc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-HGBb6LQVMlqC0iJlYx-_MA-1; Mon, 23 Jun 2025 05:21:01 -0400
X-MC-Unique: HGBb6LQVMlqC0iJlYx-_MA-1
X-Mimecast-MFC-AGG-ID: HGBb6LQVMlqC0iJlYx-_MA_1750670457
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45359bfe631so21439985e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 02:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750670456; x=1751275256;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7VSgSGwq8wrw3DnPUbktkgQZidTx6uhtariuiUH0CA0=;
 b=R+cycFyLjfXT+PwmvNmtRKCfUfwZ4iARi419siHLMZxWY/+wyOCqA6ajzkHprXpVoS
 k1i+Jh1SCg8eVDG1m2iwjMkTEFeiGsa3el84XRWk2Ng6tlxzlQU/+gatPxMEXAVhsTCB
 OWg/JnCkJetmBWnOqOwaaTid8YjutaYU0N2gBkGyOudX3mlM6DYjI2bu6VfP4sYyPnNE
 T5pcn1f14QPBGBDV0R3FO75PSjNSm0x12T6dKUXwA/BhsQY3CohHC0HDM9zHiXl19HEn
 QkeozpQVioJtmxLIY77WayXBzC4GXnXF4D6g1a5givL+fhSz44ymucvu3ioMa6f8sPFp
 oDAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfbPbKgFZB3wAu1dtZ0q2zDj5xvcB37b7UipxdNloF28ExkzI5aitg4tIuedEWZZhzNdGmU3mfK67i@nongnu.org
X-Gm-Message-State: AOJu0YzuXhd+zf+t5YWr4QtDWHAAvqNWZOPt6tFkPjyOY0FnhevYUZxD
 QiQnBFGQ6vc6pTGaIJrtvWuAmhn/DSVXCUri7/VCEZD+UbnAd7PtNpIFCz7FqQh/1yfHROrO3Qn
 hKfv7eq0p99jr2lTG9YVhX9eiw5ILMQTfYVyPR3xlop/2sdDPxN4ywCmY
X-Gm-Gg: ASbGncvnz0UMQLhACZLkX96xXtrsxA7RYCBdLmlBK2b7dvJebSE+uZFQ71KFOhUFyP1
 I8uTlwcJD9FjXQmZw99QSu1W23BsP9Wm09iYUBuOw6MwECtObY3XthVawzpfnnGG7O4pRtFgFea
 apUIyuGMHRgvXUVw99cCqiKLqZS+abR7AtEr6+bviW7ZyEfgb+73qLu1fLzElLUznalmLChD5aQ
 bFWf3eUWo7AfDwKbgTxm5UMjzVzfgX32Lm+EIyfsZKpnTNvNt7LCploG7Zd6RPnsBT+p0fu00NY
 nxnyB4Ca8dKLVMiwqwaI5SdIOTvVPG9nAYCGwO8XODbGSEEBxlfPOIMxcyzit1Ik
X-Received: by 2002:a05:6000:22c1:b0:3a5:3b03:3bc6 with SMTP id
 ffacd0b85a97d-3a6d1322bdcmr10431204f8f.28.1750670456494; 
 Mon, 23 Jun 2025 02:20:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq7mAeNuppUuYYV3/demhTJt4ngGSI7EwbRRfvcoZScbGRcZGkDlpTd8fLvB1XFXiCuPxYfQ==
X-Received: by 2002:a05:6000:22c1:b0:3a5:3b03:3bc6 with SMTP id
 ffacd0b85a97d-3a6d1322bdcmr10431179f8f.28.1750670456068; 
 Mon, 23 Jun 2025 02:20:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535eac8e0asm137760265e9.23.2025.06.23.02.20.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 02:20:55 -0700 (PDT)
Message-ID: <8c1870b3-d13d-4918-b0f6-6f41659a807d@redhat.com>
Date: Mon, 23 Jun 2025 11:20:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] ramfb: Add property to control if load the romfile
Content-Language: en-US
To: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250617030521.2109305-1-shahuang@redhat.com>
 <20250617030521.2109305-2-shahuang@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20250617030521.2109305-2-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi Shaoqin,
On 6/17/25 5:05 AM, Shaoqin Huang wrote:
> Now the ramfb will load the vgabios-ramfb.bin unconditionally, but only
Currently the ramfb device loads ...
> the x86 need the vgabios-ramfb.bin, this can cause that when use the
> release package on arm64 it can't find the vgabios-ramfb.bin.
> 
> Because only seabios will use the vgabios-ramfb.bin, load the rom logic
> is x86-specific. For other !x86 platforms, the edk2 ships an EFI driver
> for ramfb, so they don't need to load the romfile.
> 
> So add a new property use_legacy_x86_rom in both ramfb and vfio_pci
was renamed with - instead of _
> device, because the vfio display also use the ramfb_setup() to load
> the vgabios-ramfb.bin file.
> 
> After have this property, the machine type can set the compatibility to
> not load the vgabios-ramfb.bin if the arch doesn't need it.

Please add in the commit message that for now the default value is true
but it will be turned off by default in subsequent patch when compats
get properly handled.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  hw/display/ramfb-standalone.c | 4 +++-
>  hw/display/ramfb-stubs.c      | 2 +-
>  hw/display/ramfb.c            | 6 ++++--
>  hw/vfio/display.c             | 4 ++--
>  hw/vfio/pci.c                 | 1 +
>  hw/vfio/pci.h                 | 1 +
>  include/hw/display/ramfb.h    | 2 +-
>  7 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
> index 1be106b57f..af1175bf96 100644
> --- a/hw/display/ramfb-standalone.c
> +++ b/hw/display/ramfb-standalone.c
> @@ -17,6 +17,7 @@ struct RAMFBStandaloneState {
>      QemuConsole *con;
>      RAMFBState *state;
>      bool migrate;
> +    bool use_legacy_x86_rom;
>  };
>  
>  static void display_update_wrapper(void *dev)
> @@ -39,7 +40,7 @@ static void ramfb_realizefn(DeviceState *dev, Error **errp)
>      RAMFBStandaloneState *ramfb = RAMFB(dev);
>  
>      ramfb->con = graphic_console_init(dev, 0, &wrapper_ops, dev);
> -    ramfb->state = ramfb_setup(errp);
> +    ramfb->state = ramfb_setup(ramfb->use_legacy_x86_rom, errp);
>  }
>  
>  static bool migrate_needed(void *opaque)
> @@ -62,6 +63,7 @@ static const VMStateDescription ramfb_dev_vmstate = {
>  
>  static const Property ramfb_properties[] = {
>      DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,  true),
> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState, use_legacy_x86_rom, true),
>  };
>  
>  static void ramfb_class_initfn(ObjectClass *klass, void *data)
> diff --git a/hw/display/ramfb-stubs.c b/hw/display/ramfb-stubs.c
> index cf64733b10..b83551357b 100644
> --- a/hw/display/ramfb-stubs.c
> +++ b/hw/display/ramfb-stubs.c
> @@ -8,7 +8,7 @@ void ramfb_display_update(QemuConsole *con, RAMFBState *s)
>  {
>  }
>  
> -RAMFBState *ramfb_setup(Error **errp)
> +RAMFBState *ramfb_setup(bool romfile, Error **errp)
>  {
>      error_setg(errp, "ramfb support not available");
>      return NULL;
> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index 8c0f907673..9a17d97d07 100644
> --- a/hw/display/ramfb.c
> +++ b/hw/display/ramfb.c
> @@ -135,7 +135,7 @@ const VMStateDescription ramfb_vmstate = {
>      }
>  };
>  
> -RAMFBState *ramfb_setup(Error **errp)
> +RAMFBState *ramfb_setup(bool romfile, Error **errp)
>  {
>      FWCfgState *fw_cfg = fw_cfg_find();
>      RAMFBState *s;
> @@ -147,7 +147,9 @@ RAMFBState *ramfb_setup(Error **errp)
>  
>      s = g_new0(RAMFBState, 1);
>  
> -    rom_add_vga("vgabios-ramfb.bin");
> +    if (romfile) {
> +        rom_add_vga("vgabios-ramfb.bin");
> +    }
>      fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
>                               NULL, ramfb_fw_cfg_write, s,
>                               &s->cfg, sizeof(s->cfg), false);
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index ea87830fe0..8bfd8eb1e3 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -365,7 +365,7 @@ static bool vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
>                                            &vfio_display_dmabuf_ops,
>                                            vdev);
>      if (vdev->enable_ramfb) {
> -        vdev->dpy->ramfb = ramfb_setup(errp);
> +        vdev->dpy->ramfb = ramfb_setup(vdev->use_legacy_x86_rom, errp);
>          if (!vdev->dpy->ramfb) {
>              return false;
>          }
> @@ -494,7 +494,7 @@ static bool vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
>                                            &vfio_display_region_ops,
>                                            vdev);
>      if (vdev->enable_ramfb) {
> -        vdev->dpy->ramfb = ramfb_setup(errp);
> +        vdev->dpy->ramfb = ramfb_setup(vdev->use_legacy_x86_rom, errp);
>          if (!vdev->dpy->ramfb) {
>              return false;
>          }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 7f1532fbed..ff0d93fae0 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3564,6 +3564,7 @@ static const TypeInfo vfio_pci_dev_info = {
>  
>  static const Property vfio_pci_dev_nohotplug_properties[] = {
>      DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice, use_legacy_x86_rom, true),
>      DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
>                              ON_OFF_AUTO_AUTO),
>  };
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index d94ecaba68..713956157e 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -177,6 +177,7 @@ struct VFIOPCIDevice {
>      bool no_kvm_ioeventfd;
>      bool no_vfio_ioeventfd;
>      bool enable_ramfb;
> +    bool use_legacy_x86_rom;
>      OnOffAuto ramfb_migrate;
>      bool defer_kvm_irq_routing;
>      bool clear_parent_atomics_on_exit;
> diff --git a/include/hw/display/ramfb.h b/include/hw/display/ramfb.h
> index a7e0019144..172aa6dc89 100644
> --- a/include/hw/display/ramfb.h
> +++ b/include/hw/display/ramfb.h
> @@ -6,7 +6,7 @@
>  /* ramfb.c */
>  typedef struct RAMFBState RAMFBState;
>  void ramfb_display_update(QemuConsole *con, RAMFBState *s);
> -RAMFBState *ramfb_setup(Error **errp);
> +RAMFBState *ramfb_setup(bool romfile, Error **errp);
>  
>  extern const VMStateDescription ramfb_vmstate;
>  
Thanks

Eric



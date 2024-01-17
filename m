Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C934B830414
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 12:02:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ3gX-0002bG-Al; Wed, 17 Jan 2024 06:02:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rQ3gV-0002ar-Jd
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 06:02:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rQ3gT-0008OV-8D
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 06:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705489321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a43VCGzEZLsAOXrSgqbKHHU5IKciDQXp51n6UHcVEUM=;
 b=jUKw3DxXfloGLF0A8nZU08fYWZ2WXq52PwMVDwgyz3vap7lgHQWOWOvIGFAUS59Zt19htz
 o1ae2qnumik/PFQZd7sFiA3Ak7IoZGYaxRw4kZ6BYIVqXH436fdFAtzD/3S2l3/DXrEazj
 hLTq7aDGnJrg/9sAkPLM9GhaUujluDw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-c_cfBJCHPVSuJftZjHd2Eg-1; Wed, 17 Jan 2024 06:01:59 -0500
X-MC-Unique: c_cfBJCHPVSuJftZjHd2Eg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7832a94b051so1071349185a.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 03:01:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705489319; x=1706094119;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a43VCGzEZLsAOXrSgqbKHHU5IKciDQXp51n6UHcVEUM=;
 b=H/1qUtfD8ECkBfBAurhHndhBhiEWxUXbHQw0Em3lL/CfquaHOvsiI6yNbl5KE1irC5
 4ekO+7O9/ESjKahic+5F4/r5bCNQedlPXbe3CHhHfPbxvHvxGtupRh+GgpO0ykubXjPe
 bDt1sZaxlaGSooeihc3oY+kNzrSKizkgXD5VgJP0oVVpjZmOjb+nRThtlxBXeiWD9YJV
 90cLApVvT5NxzSRCTapgQqFeCbokm1l3+6/Jn8LRdeTBzmpDy4/6CcpZzfFDybyAjp/Y
 S5ZbQMrn6Ayr6qktM6AY0tvDWrNKXKzLGIITaYR2mM5fbFA14FNnNt876u/s2+n99QeY
 ly/Q==
X-Gm-Message-State: AOJu0YxgqWEPSPgjhkk0FXOnHvf73ntl3a18PSSr8GmVJrlpKVO8W01C
 N5ofQC3uLeqk2GiuLLgi7J1SeTrXPaLOONTOifqh/9GPt21MXffrM0SVMSIkD4q5os2ALyzTTWO
 qXhFl88APlqdQWFijeFnXeSU=
X-Received: by 2002:ae9:c20d:0:b0:783:7618:4c4c with SMTP id
 j13-20020ae9c20d000000b0078376184c4cmr277447qkg.139.1705489319074; 
 Wed, 17 Jan 2024 03:01:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7bv5iIA/GJvjPM5W5Owr6FesmB7iCqpRzE5rvHYiJn4soAGlWNf+M7noHfvaxUVochMUT/Q==
X-Received: by 2002:ae9:c20d:0:b0:783:7618:4c4c with SMTP id
 j13-20020ae9c20d000000b0078376184c4cmr277432qkg.139.1705489318817; 
 Wed, 17 Jan 2024 03:01:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a37c401000000b00783189b0aeasm4423920qki.46.2024.01.17.03.01.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 03:01:58 -0800 (PST)
Message-ID: <66735e9f-a4fb-474f-abec-6c83d36f921e@redhat.com>
Date: Wed, 17 Jan 2024 12:01:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] s390x/pci: drive ISM reset from subsystem reset
Content-Language: en-US
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
References: <20240116223157.73752-1-mjrosato@linux.ibm.com>
 <20240116223157.73752-4-mjrosato@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240116223157.73752-4-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Adding Alex,

On 1/16/24 23:31, Matthew Rosato wrote:
> ISM devices are sensitive to manipulation of the IOMMU, so the ISM device
> needs to be reset before the vfio-pci device is reset (triggering a full
> UNMAP).  In order to ensure this occurs, trigger ISM device resets from
> subsystem_reset before triggering the PCI bus reset (which will also
> trigger vfio-pci reset).  This only needs to be done for ISM devices
> which were enabled for use by the guest.
> Further, ensure that AIF is disabled as part of the reset event.
> 
> Fixes: ef1535901a ("s390x: do a subsystem reset before the unprotect on reboot")
> Fixes: 03451953c7 ("s390x/pci: reset ISM passthrough devices on shutdown and system reset")
> Reported-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c         | 26 +++++++++++++++++---------
>   hw/s390x/s390-virtio-ccw.c      |  2 ++
>   include/hw/s390x/s390-pci-bus.h |  1 +
>   3 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 347580ebac..3e57d5faca 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -151,20 +151,12 @@ static void s390_pci_shutdown_notifier(Notifier *n, void *opaque)
>       pci_device_reset(pbdev->pdev);
>   }
>   
> -static void s390_pci_reset_cb(void *opaque)
> -{
> -    S390PCIBusDevice *pbdev = opaque;
> -
> -    pci_device_reset(pbdev->pdev);
> -}
> -
>   static void s390_pci_perform_unplug(S390PCIBusDevice *pbdev)
>   {
>       HotplugHandler *hotplug_ctrl;
>   
>       if (pbdev->pft == ZPCI_PFT_ISM) {
>           notifier_remove(&pbdev->shutdown_notifier);
> -        qemu_unregister_reset(s390_pci_reset_cb, pbdev);
>       }
>   
>       /* Unplug the PCI device */
> @@ -1132,7 +1124,6 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>               if (pbdev->pft == ZPCI_PFT_ISM) {
>                   pbdev->shutdown_notifier.notify = s390_pci_shutdown_notifier;
>                   qemu_register_shutdown_notifier(&pbdev->shutdown_notifier);
> -                qemu_register_reset(s390_pci_reset_cb, pbdev);
>               }
>           } else {
>               pbdev->fh |= FH_SHM_EMUL;
> @@ -1279,6 +1270,23 @@ static void s390_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pdev,
>       pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, s->bus_no, 1);
>   }
>   
> +void s390_pci_ism_reset(void)
> +{
> +    S390pciState *s = s390_get_phb();
> +
> +    S390PCIBusDevice *pbdev, *next;
> +
> +    /* Trigger reset event for each passthrough ISM device currently in-use */
> +    QTAILQ_FOREACH_SAFE(pbdev, &s->zpci_devs, link, next) {
> +        if (pbdev->interp && pbdev->pft == ZPCI_PFT_ISM &&
> +            pbdev->fh & FH_MASK_ENABLE) {
> +            s390_pci_kvm_aif_disable(pbdev);
> +
> +            pci_device_reset(pbdev->pdev);
> +        }
> +    }
> +}


Could we instead define a VFIOPCIDevice::resetfn handler for these
ISM devices (1014:04ed) ? This would be cleaner if possible.

If so, as a prerequisite, we would need to introduce in a little VFIO
helper to define custom reset handlers.

Thanks,

C.




> +
>   static void s390_pcihost_reset(DeviceState *dev)
>   {
>       S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 1169e20b94..4de04f7e9f 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -118,6 +118,8 @@ static void subsystem_reset(void)
>       DeviceState *dev;
>       int i;
>   
> +    s390_pci_ism_reset();
> +
>       for (i = 0; i < ARRAY_SIZE(reset_dev_types); i++) {
>           dev = DEVICE(object_resolve_path_type("", reset_dev_types[i], NULL));
>           if (dev) {
> diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
> index 435e788867..2c43ea123f 100644
> --- a/include/hw/s390x/s390-pci-bus.h
> +++ b/include/hw/s390x/s390-pci-bus.h
> @@ -401,5 +401,6 @@ S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
>                                                 const char *target);
>   S390PCIBusDevice *s390_pci_find_next_avail_dev(S390pciState *s,
>                                                  S390PCIBusDevice *pbdev);
> +void s390_pci_ism_reset(void);
>   
>   #endif



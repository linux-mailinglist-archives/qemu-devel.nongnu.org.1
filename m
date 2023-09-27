Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7977B0233
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 12:51:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlS7G-0002w7-U1; Wed, 27 Sep 2023 06:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qlS7F-0002vp-8I
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:50:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qlS7D-0005d2-GR
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695811797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xJrWw9k00eazkwptYjGnVs6d6BLTD5IwaHyXPdskJZU=;
 b=EokeBNl8qBfOuIFyBIx87OiBXGYhE8ks2m5HXM9ff2zWFnwD6/w0R4VSFiZE+JIUBj+/Cw
 JQMlcjrWKvgdrKXrVfUeHUx3I9n677LUEH15/dC5sVI0SS4JSch6ZjFOoAayyT/n3uevtm
 R3tub37Fx5hGg9ihPPhY4iPhqw0/F+g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-fcJE5TrIPjCe3A87NvUGIg-1; Wed, 27 Sep 2023 06:49:55 -0400
X-MC-Unique: fcJE5TrIPjCe3A87NvUGIg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40592bb4d11so57744695e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 03:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695811795; x=1696416595;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xJrWw9k00eazkwptYjGnVs6d6BLTD5IwaHyXPdskJZU=;
 b=xGRLpVqE3UAPjVq8fW5DIqqmO5qW7manegoTLlVAZ+5ErSgeqFaNr0+JBUJFeQzvVL
 imicwqLSGfupHOLAVysBo2Hu9oxule7W46cHmmF8MqTLE8CX7v99UrqFN+EyNsbE1MPZ
 DkioupEJl8Ln7jtyD3627CWK6jw+HvqZhKggaWnSpcM9Lci7p4NbiHZkdVZnZGXVq1QZ
 Hcc/MSZLFUFEdffkenQ0w1+XPqirno03SWLvgq9AT9Ri0leAK46kGN7kGrD0eyi3CuDZ
 UT4C/O2e4jBu5C6yrEvHJ86EuPtelLrO6rBjsSkFojAUUvoKhu76z8Su0GM9BN8BVG1Y
 UHcg==
X-Gm-Message-State: AOJu0YyEJcsjs7upUzeg3rEKut3h27r+KFAlOX757CTLs4X8vo5Bq14r
 4U0k40lBCyYcp7V+dJXNLVJ4WzG6nrJLIObmt6dGqcciJXaFl7oL0LOkCl+tSOBLjpfAZ0nM4QC
 8s77jltA/2kbfZ7Y=
X-Received: by 2002:a5d:4d46:0:b0:314:3a4b:6cc6 with SMTP id
 a6-20020a5d4d46000000b003143a4b6cc6mr1426683wru.53.1695811794840; 
 Wed, 27 Sep 2023 03:49:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETUlPSVOPn2RU3gbiScNLvGgp4KF1jFwfiVbJcLGJjPqMYWRbpCH2wqXuSQ/8WVtniQkNAiA==
X-Received: by 2002:a5d:4d46:0:b0:314:3a4b:6cc6 with SMTP id
 a6-20020a5d4d46000000b003143a4b6cc6mr1426655wru.53.1695811794404; 
 Wed, 27 Sep 2023 03:49:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:6900:3a06:bd5:2f7b:e6eb?
 (p200300cbc74969003a060bd52f7be6eb.dip0.t-ipconnect.de.
 [2003:cb:c749:6900:3a06:bd5:2f7b:e6eb])
 by smtp.gmail.com with ESMTPSA id
 a13-20020adff7cd000000b0031ad5fb5a0fsm1883761wrq.58.2023.09.27.03.49.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 03:49:54 -0700 (PDT)
Message-ID: <fa0b04e5-33ff-6ba8-db17-4e46640ecc08@redhat.com>
Date: Wed, 27 Sep 2023 12:49:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 7/7] hw/i386/pc: Support hv-balloon
Content-Language: en-US
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
References: <cover.1693240836.git.maciej.szmigiero@oracle.com>
 <9f11c6afb4271a31b6fe276931ecdf6923bf2877.1693240836.git.maciej.szmigiero@oracle.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <9f11c6afb4271a31b6fe276931ecdf6923bf2877.1693240836.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 28.08.23 18:48, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Add the necessary plumbing for the hv-balloon driver to the PC machine.
> 
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/i386/Kconfig |  1 +
>   hw/i386/pc.c    | 22 ++++++++++++++++++++++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 9051083c1e78..349cf0d32fad 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -45,6 +45,7 @@ config PC
>       select ACPI_VMGENID
>       select VIRTIO_PMEM_SUPPORTED
>       select VIRTIO_MEM_SUPPORTED
> +    select HV_BALLOON_SUPPORTED
>   
>   config PC_PCI
>       bool
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 54838c0c411d..d979479cab5e 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -28,6 +28,7 @@
>   #include "hw/i386/pc.h"
>   #include "hw/char/serial.h"
>   #include "hw/char/parallel.h"
> +#include "hw/hyperv/hv-balloon.h"
>   #include "hw/i386/topology.h"
>   #include "hw/i386/fw_cfg.h"
>   #include "hw/i386/vmport.h"
> @@ -93,6 +94,7 @@
>   #include "hw/i386/kvm/xen_evtchn.h"
>   #include "hw/i386/kvm/xen_gnttab.h"
>   #include "hw/i386/kvm/xen_xenstore.h"
> +#include "hw/mem/memory-device.h"
>   #include "sysemu/replay.h"
>   #include "target/i386/cpu.h"
>   #include "e820_memory_layout.h"
> @@ -1494,6 +1496,21 @@ static void pc_memory_unplug(HotplugHandler *hotplug_dev,
>       error_propagate(errp, local_err);
>   }
>   
> +static void pc_hv_balloon_pre_plug(HotplugHandler *hotplug_dev,
> +                                   DeviceState *dev, Error **errp)
> +{
> +    /* The vmbus handler has no hotplug handler; we should never end up here. */
> +    g_assert(!dev->hotplugged);
> +    memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev), NULL,
> +                           errp);
> +}
> +
> +static void pc_hv_balloon_plug(HotplugHandler *hotplug_dev,
> +                               DeviceState *dev, Error **errp)
> +{
> +    memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
> +}
> +


Maybe we want to have hv_balloon_pre_plug() and hv_balloon_plug(), but 
this here should be good enough for now.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



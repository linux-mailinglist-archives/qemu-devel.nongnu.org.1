Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E75A4F908
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Mar 2025 09:42:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpkKO-0008Ri-9N; Wed, 05 Mar 2025 03:42:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpkKL-0008R4-BF
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:42:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpkKJ-0001cw-GB
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741164122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=axRfMKhEuWaewQJTB596rYovmpqlLcNMmQralZ90Y6k=;
 b=XaH+v08UXoxMF1ROz/sw+t3t8W2MS5XlQbUWVtDWsMFx+IT8UbaBihGu1c79S3r6iiVlyH
 WQ2DaZokgfuSFUAjr9wytfLf0/ZQNDgZVmYVZ5NRQM6x+r6w43uh8RrK+pzvSU3zfBJpVI
 s3jqO+H0h8+BY6A2yDJe67zN+AFELoI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595--jTjOnOSORmmK1VEKeaqwQ-1; Wed, 05 Mar 2025 03:41:58 -0500
X-MC-Unique: -jTjOnOSORmmK1VEKeaqwQ-1
X-Mimecast-MFC-AGG-ID: -jTjOnOSORmmK1VEKeaqwQ_1741164117
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-390fc428a45so1580824f8f.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 00:41:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741164117; x=1741768917;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axRfMKhEuWaewQJTB596rYovmpqlLcNMmQralZ90Y6k=;
 b=tEvle1zS3qS+HS0dqOlHRw3dMj8+6/WPt954OXwQj9i9Oldh9ub9O2bAt0ngGs8HAP
 h25pn57yHn2t8y5h686B8YXDaACm1LO9HkbUlDXJeOh0NSFO5ecdlMQYNbVy33RCxY4D
 ZdzORi+Nh7I+B4fiaZat7EP6e1LgEHsi50/+9dLbn2UD1oxHMQGCRG05ooCKcwyzw4b4
 VkfYxhL28k129bbECiNKKaI0bR2L/0Bi9FWFCIfQv++y/Z5SYntLo/VdMiZ+dv0yzPN6
 maDS4ICHxtU/YHXvlYGlCATApUD9jHqOvQJ34tPICZzKZMkRVVv5Fg7d0DC5aYQKmKdO
 ckKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYuxWiyL7U43aTGW/u3mQyA0LRtEzfz0XPQzzr6UJssM5bjEdMhUqoxz2DwliVFeAo5bVa6b3B13X5@nongnu.org
X-Gm-Message-State: AOJu0Yw6tMWJqLIXYm2gWQqgSH8Ishq2F03tWM95gd5opTHbo9z+surH
 eeqrhFtB7AKckjYFbDQrbNa0EEn03RSqg34qBLfmSxw2whaZMG6oUNu9S2DfDwVrPPdbcxrna9H
 i3cb7+qwG0wnTOApjyzVGD5PZlTG49WetoJCc3pgsmMA25/uR1I51
X-Gm-Gg: ASbGncvf5A9mCNJm0tb5jGaLVl1JUrdL+Vy+oQrQ8oE4tgYwglndCkIZVh+OB0nsw4u
 Bx9OBlv1gN6YpGIaCKHAWhwF1mClJLXqT+pCC1NPQWRMVzt5n+f+7GNfroV8m8db6InTew7FW9I
 i//J8NYPcatfdAkOB8L2G4nhZzuQnQo4PRH/2Wern+WHNMNaplSu2aKICMuS5ooOhwa99nhkQ/T
 0nixjRg/NdgcmfHixftcVgbuQ9T6nC3UyxAdW41XwIR4+6cFW52ueottAiMax+k60riqbVYtAbU
 e8SCeAyQol6AHBjO41UDyOHkUBIINxo4TFW+a+2BHUkBjZ7XHpbsrg==
X-Received: by 2002:adf:f0c2:0:b0:390:d6ab:6c49 with SMTP id
 ffacd0b85a97d-3911f7bda9amr1604971f8f.35.1741164117099; 
 Wed, 05 Mar 2025 00:41:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFW4xQ/ykJSk0M02fYaJFyFfHiuvqdXmoUbqAJFWsDWigkDud6UFQUFPCF16lB8tY2AYHT1lQ==
X-Received: by 2002:adf:f0c2:0:b0:390:d6ab:6c49 with SMTP id
 ffacd0b85a97d-3911f7bda9amr1604950f8f.35.1741164116689; 
 Wed, 05 Mar 2025 00:41:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485e61csm20564998f8f.98.2025.03.05.00.41.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 00:41:56 -0800 (PST)
Message-ID: <dca5f3b6-2793-4fcd-9ce5-c7be7e186d2f@redhat.com>
Date: Wed, 5 Mar 2025 09:41:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 32/36] vfio/migration: Make
 x-migration-multifd-transfer VFIO property mutable
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <f2f2d66bda477da3e6cb8c0311006cff36e8651d.1741124640.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <f2f2d66bda477da3e6cb8c0311006cff36e8651d.1741124640.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 3/4/25 23:03, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> DEFINE_PROP_ON_OFF_AUTO() property isn't runtime-mutable so using it
> would mean that the source VM would need to decide upfront at startup
> time whether it wants to do a multifd device state transfer at some
> point.
> 
> Source VM can run for a long time before being migrated so it is
> desirable to have a fallback mechanism to the old way of transferring
> VFIO device state if it turns to be necessary.
> 
> This brings this property to the same mutability level as ordinary
> migration parameters, which too can be adjusted at the run time.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/migration-multifd.c |  4 ++++
>   hw/vfio/pci.c               | 20 +++++++++++++++++---
>   2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index aacddc503bb8..233724710b37 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -485,6 +485,10 @@ bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp)
>   {
>       VFIOMigration *migration = vbasedev->migration;
>   
> +    /*
> +     * Make a copy of this setting at the start in case it is changed
> +     * mid-migration.
> +     */
>       if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
>           migration->multifd_transfer = vfio_multifd_transfer_supported();
>       } else {
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 6d6f889f59c5..21605bac2fb0 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3353,6 +3353,8 @@ static void vfio_instance_init(Object *obj)
>       pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
>   }
>   
> +static PropertyInfo vfio_pci_migration_multifd_transfer_prop;
> +
>   static const Property vfio_pci_dev_properties[] = {
>       DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
>       DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
> @@ -3377,9 +3379,10 @@ static const Property vfio_pci_dev_properties[] = {
>                       VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>       DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>                               vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
> -    DEFINE_PROP_ON_OFF_AUTO("x-migration-multifd-transfer", VFIOPCIDevice,
> -                            vbasedev.migration_multifd_transfer,
> -                            ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP("x-migration-multifd-transfer", VFIOPCIDevice,
> +                vbasedev.migration_multifd_transfer,
> +                vfio_pci_migration_multifd_transfer_prop, OnOffAuto,
> +                .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),
>       DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>                        vbasedev.migration_events, false),
>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
> @@ -3480,6 +3483,17 @@ static const TypeInfo vfio_pci_nohotplug_dev_info = {
>   
>   static void register_vfio_pci_dev_type(void)
>   {
> +    /*
> +     * Ordinary ON_OFF_AUTO property isn't runtime-mutable, but source VM can
> +     * run for a long time before being migrated so it is desirable to have a
> +     * fallback mechanism to the old way of transferring VFIO device state if
> +     * it turns to be necessary.
> +     * The following makes this type of property have the same mutability level
> +     * as ordinary migration parameters.
> +     */
> +    vfio_pci_migration_multifd_transfer_prop = qdev_prop_on_off_auto;
> +    vfio_pci_migration_multifd_transfer_prop.realized_set_allowed = true;
> +
>       type_register_static(&vfio_pci_dev_info);
>       type_register_static(&vfio_pci_nohotplug_dev_info);
>   }
> 



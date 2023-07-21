Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA61075C6A0
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 14:11:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMows-00085T-DW; Fri, 21 Jul 2023 08:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qMown-000817-FM
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 08:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qMowk-0005Y7-OC
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 08:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689941361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05yRIha2VU2TGof5BPaVUS8odmqGjgyox9V6hqBe0u8=;
 b=aTI0ZjBPGyBOOkiRw94QzBtzJVelIqNtVbkume1FKirOvvOAAnDKRYgBKFA4XoQXycs6dB
 hM1ShHsSLb7tJ5h1hs8V8sux+6FmEonxMEGk6ZE48POVrQxOgvbIvzhU7Zjg1SIoEx6AOr
 MMnKw2gZjyWJHrECEYwUMA78o6P1S+k=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-HcuSyl8KPXiRQR9k6sfjNw-1; Fri, 21 Jul 2023 08:09:20 -0400
X-MC-Unique: HcuSyl8KPXiRQR9k6sfjNw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-5eee6742285so23077006d6.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 05:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689941359; x=1690546159;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=05yRIha2VU2TGof5BPaVUS8odmqGjgyox9V6hqBe0u8=;
 b=jUoHD9pgKY6UFzMuz6k4+xiXIkZLxZbPz3I5jDEw9C7QrJiWoUOJpqswdn5BRD2ktw
 zlocNbliE8KmtGzWHpr/H2MJBM+D416+48vSUS5dwVfJAKVh/mln2XWIBA7ymrqqrbGa
 4iHvYITQRGNuUaRni0jM4PFWF8k+l4E3+EdUBBeGnrvmNV6FIcGfNAxMKo+Kr9em7K2e
 mWZKgdIuhhZiaOGr3i5EB8ny2qYyAAegy8bdofAGEnq9akS5tmeNvNJTqb9/wleZGZ5R
 rAtmymH8ynXhmKOadaOQhiRhwqjbE+vlnDLbDtBO5eWmu1YhId9fueXo2nk9d3bbpUiy
 GqDw==
X-Gm-Message-State: ABy/qLZrYYSIs975XC9njaz7/szk/Kq/nF9AGFDXPLYQoSkJl2veT8BE
 ojxHATeIFN9hwd/h2s22IhLo0Y9NbKc0fIqMwEJrTIhpITM0ocLF6/PIqaz07Uk+Olg1XqtP26q
 GpVC81op4Bk2NlhU=
X-Received: by 2002:a05:622a:15c1:b0:403:dba5:4266 with SMTP id
 d1-20020a05622a15c100b00403dba54266mr1949133qty.32.1689941359558; 
 Fri, 21 Jul 2023 05:09:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGVitI+ISDD4JawQkizEAjabWCukr5OlO2y/XI7HjTlcW1Vv0g5tchXWlb2YvFh238mhw419A==
X-Received: by 2002:a05:622a:15c1:b0:403:dba5:4266 with SMTP id
 d1-20020a05622a15c100b00403dba54266mr1949112qty.32.1689941359282; 
 Fri, 21 Jul 2023 05:09:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:9283:b79f:cbb3:327a?
 ([2a01:e0a:9e2:9000:9283:b79f:cbb3:327a])
 by smtp.gmail.com with ESMTPSA id
 e7-20020ac81307000000b004053d6d7a26sm1169092qtj.40.2023.07.21.05.09.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 05:09:18 -0700 (PDT)
Message-ID: <be007d5b-1679-3389-8d6b-daee5be72c63@redhat.com>
Date: Fri, 21 Jul 2023 14:09:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 6/6] vfio/migration: Allow migration of multiple
 P2P supporting devices
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>
References: <20230716081541.27900-1-avihaih@nvidia.com>
 <20230716081541.27900-7-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230716081541.27900-7-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/16/23 10:15, Avihai Horon wrote:
> Now that P2P support has been added to VFIO migration, allow migration
> of multiple devices if all of them support P2P migration.
> 
> Single device migration is allowed regardless of P2P migration support.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   hw/vfio/common.c | 26 ++++++++++++++++++--------
>   1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 7c3d636025..753b320739 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -363,21 +363,31 @@ bool vfio_mig_active(void)
>   
>   static Error *multiple_devices_migration_blocker;
>   
> -static unsigned int vfio_migratable_device_num(void)
> +/*
> + * Multiple devices migration is allowed only if all devices support P2P
> + * migration. Single device migration is allowed regardless of P2P migration
> + * support.
> + */
> +static bool vfio_should_block_multiple_devices_migration(void)

Could we revert the logic and call the routine :

   vfio_multiple_devices_migration_is_supported()

I think it would be clearer in the callers.  This is minor.

Thanks,

C.

>   {
>       VFIOGroup *group;
>       VFIODevice *vbasedev;
>       unsigned int device_num = 0;
> +    bool all_support_p2p = true;
>   
>       QLIST_FOREACH(group, &vfio_group_list, next) {
>           QLIST_FOREACH(vbasedev, &group->device_list, next) {
>               if (vbasedev->migration) {
>                   device_num++;
> +
> +                if (!(vbasedev->migration->mig_flags & VFIO_MIGRATION_P2P)) {
> +                    all_support_p2p = false;
> +                }
>               }
>           }
>       }
>   
> -    return device_num;
> +    return !all_support_p2p && device_num > 1;
>   }
>   
>   int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
> @@ -385,19 +395,19 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>       int ret;
>   
>       if (multiple_devices_migration_blocker ||
> -        vfio_migratable_device_num() <= 1) {
> +        !vfio_should_block_multiple_devices_migration()) {
>           return 0;
>       }
>   
>       if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
> -        error_setg(errp, "Migration is currently not supported with multiple "
> -                         "VFIO devices");
> +        error_setg(errp, "Multiple VFIO devices migration is supported only if "
> +                         "all of them support P2P migration");
>           return -EINVAL;
>       }
>   
>       error_setg(&multiple_devices_migration_blocker,
> -               "Migration is currently not supported with multiple "
> -               "VFIO devices");
> +               "Multiple VFIO devices migration is supported only if all of "
> +               "them support P2P migration");
>       ret = migrate_add_blocker(multiple_devices_migration_blocker, errp);
>       if (ret < 0) {
>           error_free(multiple_devices_migration_blocker);
> @@ -410,7 +420,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>   void vfio_unblock_multiple_devices_migration(void)
>   {
>       if (!multiple_devices_migration_blocker ||
> -        vfio_migratable_device_num() > 1) {
> +        vfio_should_block_multiple_devices_migration()) {
>           return;
>       }
>   



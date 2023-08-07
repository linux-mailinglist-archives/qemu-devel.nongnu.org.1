Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B897729DB
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 17:54:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT2Y5-0004lp-87; Mon, 07 Aug 2023 11:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qT2Y3-0004ld-LO
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:53:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qT2Y2-0001Wd-2a
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691423612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dMEEBCHM+6NXEWJD8Tzfo2lde4LBTTi3faB5JB1JUHo=;
 b=cvwxisSPipsFv2mzseN4Wxl6gycU4DX43frW5Lo9SD7dBaxMkAF8aj8MYdA8WipvrI0qNp
 uAjbqb+xC/q/XhVq2P7VdwZxPzK5GzLnS/PAFDPCZ0BSoNDJIJfCgdx2rG+Q1oEQjcgmch
 1qpnj2Dgc+hkIjajOrruZfsY+0pTgik=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-q8VwzTO3P4eoeWPFv3aNBA-1; Mon, 07 Aug 2023 11:53:30 -0400
X-MC-Unique: q8VwzTO3P4eoeWPFv3aNBA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7659d103147so624846585a.3
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 08:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691423610; x=1692028410;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dMEEBCHM+6NXEWJD8Tzfo2lde4LBTTi3faB5JB1JUHo=;
 b=AMa+eYhXFPotlDPfDsVsvKH4h0dgEoFj0hAeqBD+ajccuYSRJKNasCHp2mOFq1O3OT
 qmeH9FMApa/VX/8ORmdIFU0bKgzTFCGcHRN48RTzs4mjygZ6wUnZGixvmyRM0BrASNrU
 H+zLynNBiFgm7HuUnZ2KKpsvYAJ4ZUigIa7aD9/uHHhrXpymTZNIv2hLlZLArq4hM1NG
 /CjQFqtYWer+Z4F8hn5jnFgcRVXRbBhmkEA5Q8gJKm18q/JXdHWYpq6ou1+If82NHfup
 YGE0dHfc263k4cSFZsN7rKdQVT6WP5CbGPoJMRwWCxfvnn9tmbn98f3JpoeziYhfQYSD
 JZTA==
X-Gm-Message-State: AOJu0YyOsQDRCYCWSWbCprEbcRomYvqnDZPCIpYNvNh2pBI9Mu+hEGCZ
 TJd5NTPIBVpvlfBDkjxmF5gTw7EUpWwwX2pYHbf7M0p5LgLfh1DBoIDxb4oZrawnbUxQZx1ef17
 SDQ2Gp+5AnElcjKs=
X-Received: by 2002:a05:620a:29d3:b0:76c:e6c8:9386 with SMTP id
 s19-20020a05620a29d300b0076ce6c89386mr14215433qkp.60.1691423610145; 
 Mon, 07 Aug 2023 08:53:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmV4FN1TgoBSirp4wXI55XV63poKlclg+303vOojGlCOBNb9ZKri/vpVeZeBefDnMyiFUWNg==
X-Received: by 2002:a05:620a:29d3:b0:76c:e6c8:9386 with SMTP id
 s19-20020a05620a29d300b0076ce6c89386mr14215397qkp.60.1691423609792; 
 Mon, 07 Aug 2023 08:53:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0?
 ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a05620a110f00b0076d08d5f93asm767452qkk.60.2023.08.07.08.53.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 08:53:29 -0700 (PDT)
Message-ID: <cc6d0b1c-036f-00f8-41fb-6ef1c59cafa2@redhat.com>
Date: Mon, 7 Aug 2023 17:53:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 v3 1/6] vfio/migration: Move from STOP_COPY to
 STOP in vfio_save_cleanup()
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20230802081449.2528-1-avihaih@nvidia.com>
 <20230802081449.2528-2-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230802081449.2528-2-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.809, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

[ Adding Juan and Peter for their awareness ]

On 8/2/23 10:14, Avihai Horon wrote:
> Changing the device state from STOP_COPY to STOP can take time as the
> device may need to free resources and do other operations as part of the
> transition. Currently, this is done in vfio_save_complete_precopy() and
> therefore it is counted in the migration downtime.
> 
> To avoid this, change the device state from STOP_COPY to STOP in
> vfio_save_cleanup(), which is called after migration has completed and
> thus is not part of migration downtime.

What bothers me is that this looks like a device specific optimization
and we are loosing the error part.

I wonder if we could use the PRECOPY_NOTIFY_CLEANUP notifier instead and
modify qemu_savevm_state_cleanup() to return the error which could then
be handled by the caller.


No need to resend the whole series. I think 2-6 are good for merge, I will
probably push them on vfio-next when -rc3 is out.

Thanks,

C.

  
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   hw/vfio/migration.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 2674f4bc47..8acd182a8b 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -383,6 +383,19 @@ static void vfio_save_cleanup(void *opaque)
>       VFIODevice *vbasedev = opaque;
>       VFIOMigration *migration = vbasedev->migration;
>   
> +    /*
> +     * Changing device state from STOP_COPY to STOP can take time. Do it here,
> +     * after migration has completed, so it won't increase downtime.
> +     */
> +    if (migration->device_state == VFIO_DEVICE_STATE_STOP_COPY) {
> +        /*
> +         * If setting the device in STOP state fails, the device should be
> +         * reset. To do so, use ERROR state as a recover state.
> +         */
> +        vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP,
> +                                 VFIO_DEVICE_STATE_ERROR);
> +    }
> +
>       g_free(migration->data_buffer);
>       migration->data_buffer = NULL;
>       migration->precopy_init_size = 0;
> @@ -508,12 +521,6 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>           return ret;
>       }
>   
> -    /*
> -     * If setting the device in STOP state fails, the device should be reset.
> -     * To do so, use ERROR state as a recover state.
> -     */
> -    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP,
> -                                   VFIO_DEVICE_STATE_ERROR);
>       trace_vfio_save_complete_precopy(vbasedev->name, ret);
>   
>       return ret;



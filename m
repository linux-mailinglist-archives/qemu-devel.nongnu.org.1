Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E041768680
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 18:47:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQ9F9-0007mN-Bp; Sun, 30 Jul 2023 12:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qQ9Ey-0007lw-K5
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 12:25:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qQ9Eq-0008OA-4q
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 12:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690734341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+gJmVn2BwTDwqdgjEoNnqmrolSKLANb5EDmdM2Rnl4=;
 b=MZiiPLgEkHXndIiW7Sld7TPMk3nJt/WFlQ+1Z3tL91U4Cal9z+1dSlq6IyXXKwx2qH1zyM
 VHkPHXVOlaG22E4hsBGi8NfJ+iJMEWaAnySnt0P56tq4plFEr2fOPJlm7zPezcvF//foh7
 L77Peanae2I94gs54G/c/FWVFgq2nK8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-ch04V72HNpmxgEruHOYyCg-1; Sun, 30 Jul 2023 12:25:38 -0400
X-MC-Unique: ch04V72HNpmxgEruHOYyCg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b9bcf13746so29316501fa.0
 for <qemu-devel@nongnu.org>; Sun, 30 Jul 2023 09:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690734337; x=1691339137;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9+gJmVn2BwTDwqdgjEoNnqmrolSKLANb5EDmdM2Rnl4=;
 b=Oha/vNXkgXBWdOR8qFYXM14DzSG2vpZwB0YzKP6oDkTtP3AwPzR0wAgvfQUDyxVZwR
 JViX4BLyUxS6vePUP09JANEX7LVkQ/iSzHk/fm1WI33MDtyyZ+H1lHmpKmcbsT15D7l2
 I4nXZqq91pVnZ+JNNjoaGhRzburCJz4P+Tvp2vIvcLOA7Y6ldbET71tiE4ZqsyocrQ9D
 BTYvKcikFW1TEZwPL/JoIHkxwRTrbGwfi88M25L0Cf2C//gqeW0AbuCxJqVtZ6Ai7SpV
 jFGQYbedukU6o1BMJtmd3DSxbwqaN6hw0om8wa2wJBg+PSa1oE6Knz+QctLO1wdKzl3S
 zeQQ==
X-Gm-Message-State: ABy/qLaW10IxT3RwM9scbTtSTxxlggi9kdUepc+fmxW9He3nr+HEQ7n8
 jUT6OOslgASn1RMRArF7we8FYDA9WQqJSeKrSEBeMWXkijt9WermlsW16/HkesDeur26IdBLf7N
 9eLFwGk0IbIcecFw=
X-Received: by 2002:a2e:b0d1:0:b0:2b9:acad:b4b2 with SMTP id
 g17-20020a2eb0d1000000b002b9acadb4b2mr4737745ljl.6.1690734337136; 
 Sun, 30 Jul 2023 09:25:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHJvn/8QZMlqLwPqi1O2HZvuGXIa9J5UK+jGrkLgj6gcQhYmsumRGg8A65wyCvUkUJ6XWpMkw==
X-Received: by 2002:a2e:b0d1:0:b0:2b9:acad:b4b2 with SMTP id
 g17-20020a2eb0d1000000b002b9acadb4b2mr4737735ljl.6.1690734336843; 
 Sun, 30 Jul 2023 09:25:36 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891?
 ([2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891])
 by smtp.gmail.com with ESMTPSA id
 b10-20020a5d4b8a000000b003175f00e555sm10322701wrt.97.2023.07.30.09.25.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jul 2023 09:25:36 -0700 (PDT)
Message-ID: <dc2365df-4e71-e2d8-988d-f74431800123@redhat.com>
Date: Sun, 30 Jul 2023 18:25:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 1/6] vfio/migration: Move from STOP_COPY to STOP
 in vfio_save_cleanup()
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>
References: <20230716081541.27900-1-avihaih@nvidia.com>
 <20230716081541.27900-2-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230716081541.27900-2-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
> Changing the device state from STOP_COPY to STOP can take time as the
> device may need to free resources and do other operations as part of the
> transition. Currently, this is done in vfio_save_complete_precopy() and
> therefore it is counted in the migration downtime.
> 
> To avoid this, change the device state from STOP_COPY to STOP in
> vfio_save_cleanup(), which is called after migration has completed and
> thus is not part of migration downtime.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Have you tried this series with vGPUs ? If so, are there any improvement
to report ?

Thanks,

C.

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



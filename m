Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44893715988
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 11:09:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3vLI-0005Or-8U; Tue, 30 May 2023 05:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q3vLG-0005Nz-0G
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q3vLE-00032x-9Q
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685437710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AssS62W1x9CgXENVl9JrHFXt0c31e0c6Caolmap8AdQ=;
 b=Pu6wReOCTpM7khmsffCNGg+Ct4Ahp6VBAb1yre4Z3o3J7iYu4t8gmononnwcRoky08G2DB
 ETs19cKBuzeh/Fpd53OhUcRsuOQpJko3V0e7JZbX7K+Y2ftdhu9nHH7qVsc3LHao2nKBG8
 i57GNRquQiSn824/KxWN0MpyAnO56rI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-7jpkWzJUO5uVAEd9Q3K1Kg-1; Tue, 30 May 2023 05:08:28 -0400
X-MC-Unique: 7jpkWzJUO5uVAEd9Q3K1Kg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30793c16c78so5877796f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 02:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685437708; x=1688029708;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AssS62W1x9CgXENVl9JrHFXt0c31e0c6Caolmap8AdQ=;
 b=USQMRy7+eb0J/hHgvbLXdHDcHb+hBB3KZG0ilIOmiBCTSx1QjBmF/sCEGlyPM/GP2f
 hRC2i0l4BzUZoGnLwDv6HKcqhCRoehLxjOdiTqGs1lXtMBaGEqwcm6Kt//HwQLEJPrMS
 WiWzVfobMOWi9r8mVWZ3M0FBVVZViCxDH7rCEV84LYGEWtRKpyokOh3VBN4ummIxc9Vn
 4amjqlFV/5vPipiwjvdntcDsSTvHuJdDidthlz4BP3CQ5cL6yw5z3gKkff99Ld3iOIZA
 2GyQHNJyoUUSDLMiTTknwD3pec0LwAJEgcqHaHgfKpoy5wvkWzBroIxWI249rpi3Cx37
 vgMg==
X-Gm-Message-State: AC+VfDz3Yq3ERnKIo3Tci3Fui7DCb7Ls842sIJMykj9/8VWGaYEIx1GC
 OwJ7DEEPlMvRbA9Uj9TAA2SwkRLTpSXmZxKAd3mlxsxflIk6fghvRrTO3/7NfkSNxev3WvLFKzy
 theBEnpDpgVDBhDA=
X-Received: by 2002:a5d:4b44:0:b0:30a:efd3:66a with SMTP id
 w4-20020a5d4b44000000b0030aefd3066amr1114536wrs.40.1685437707902; 
 Tue, 30 May 2023 02:08:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4x+b9nPK7ooBwc8JcXypeowd2GIU2z9cGM8zYnfjXQQ4KGHmF4oBqjJVW5o83IT95GQUzYoQ==
X-Received: by 2002:a5d:4b44:0:b0:30a:efd3:66a with SMTP id
 w4-20020a5d4b44000000b0030aefd3066amr1114512wrs.40.1685437707634; 
 Tue, 30 May 2023 02:08:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0?
 ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
 by smtp.gmail.com with ESMTPSA id
 f4-20020adff984000000b0030ae849c70csm2577766wrr.37.2023.05.30.02.08.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 02:08:27 -0700 (PDT)
Message-ID: <61006d5c-f45b-16ef-c280-66bf379f708f@redhat.com>
Date: Tue, 30 May 2023 11:08:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 6/9] vfio/migration: Store VFIO migration flags in
 VFIOMigration
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230528140652.8693-1-avihaih@nvidia.com>
 <20230528140652.8693-7-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230528140652.8693-7-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/28/23 16:06, Avihai Horon wrote:
> VFIO migration flags are queried once in vfio_migration_init(). Store
> them in VFIOMigration so they can be used later to check the device's
> migration capabilities without re-querying them.
> 
> This will be used in the next patch to check if the device supports
> precopy migration.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> ---
>   include/hw/vfio/vfio-common.h | 1 +
>   hw/vfio/migration.c           | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index eed244f25f..5f29dab839 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -66,6 +66,7 @@ typedef struct VFIOMigration {
>       int data_fd;
>       void *data_buffer;
>       size_t data_buffer_size;
> +    uint64_t mig_flags;
>   } VFIOMigration;
>   
>   typedef struct VFIOAddressSpace {
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 235978fd68..8d33414379 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -603,6 +603,7 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>       migration->vbasedev = vbasedev;
>       migration->device_state = VFIO_DEVICE_STATE_RUNNING;
>       migration->data_fd = -1;
> +    migration->mig_flags = mig_flags;
>   
>       vbasedev->dirty_pages_supported = vfio_dma_logging_supported(vbasedev);
>   



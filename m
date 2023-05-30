Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF547159A7
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 11:14:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3vPx-0006hJ-Eq; Tue, 30 May 2023 05:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q3vPv-0006gq-AN
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q3vPt-0005vR-Q2
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685438001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I4WWQrAeZvfYQSTPsNgVd3IjtcuOS6fGhmgHxLa1ghk=;
 b=IsKF5Wgvrgkr1tNYZTsgOo+oSbtqLLmBTrvVSJRQt2J5btdWmH9qO8riDl1YDrTGl6Qn0z
 gf8qa2XozHKzfBLIZs+uynBQmtPOWb3khFeofEDLJAScqh8GBwvstqurbqctbh7QyD3U8J
 tHUfngHzXw3IBfi09f/WZn6xBe0Cqlc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-8BKjoaXQN5mo4ND5W4QfGA-1; Tue, 30 May 2023 05:13:19 -0400
X-MC-Unique: 8BKjoaXQN5mo4ND5W4QfGA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f6089a9689so26478105e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 02:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685437998; x=1688029998;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I4WWQrAeZvfYQSTPsNgVd3IjtcuOS6fGhmgHxLa1ghk=;
 b=bTNrjJ29RmDZxN2UfUDX6p2FOY68+DgqMdlaRvNJXitjlxIJn7JniMPONE/0qdCgY8
 vvj/Ht77QXBTKmth/wLox/t2Ms8eykvGKkI2eKTR66EljyIKrwWI/7SmJ89IU+ztzB7o
 55NxeRhk30uoZeIgXrlpPWn9GkjwQQFlRlkZ7xYAa22MWfYaTefyjLlsVwUMWfnMHE7e
 IT7/yZF0omvFtt6NozpyhZqeeaY51u/ZHKbqY1Xs0pgEoM0GSVu7coj7s0kID5+px5EQ
 n20mrjcPZ6FM20iJ0VfA2Yu6OXeESEmYkD+X7IpiPBHAB1pQbYOzhgg3ooU3RPiW7zZN
 JYTg==
X-Gm-Message-State: AC+VfDwdUcWDAbTMo/QRIy56tt4D3jaAqLGrtxqGH6SN6F35kZDMNb6w
 j1E7t0bldHQ3NLgomPyqSLtf1qcXiJ6zVdLPrS3y6FZx655XhhYrKAhvsKcLembX3VMgWx/Wbb6
 2RKKPRXp/4d1HkfY=
X-Received: by 2002:adf:dd92:0:b0:30a:b46a:a443 with SMTP id
 x18-20020adfdd92000000b0030ab46aa443mr982062wrl.51.1685437998670; 
 Tue, 30 May 2023 02:13:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4XbI40cjgCxRWDqe1ouHV7cvmaPUJnKncRqU3VHbIlGfiETFLfg0dTr5auRSM0soSv5+bRdQ==
X-Received: by 2002:adf:dd92:0:b0:30a:b46a:a443 with SMTP id
 x18-20020adfdd92000000b0030ab46aa443mr982034wrl.51.1685437998371; 
 Tue, 30 May 2023 02:13:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0?
 ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
 by smtp.gmail.com with ESMTPSA id
 b2-20020a5d4b82000000b0030aec5e020fsm2549112wrt.86.2023.05.30.02.13.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 02:13:17 -0700 (PDT)
Message-ID: <c46934cc-057b-04d9-65cf-9c2f2599367f@redhat.com>
Date: Tue, 30 May 2023 11:13:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 8/9] vfio/migration: Add x-allow-pre-copy VFIO device
 property
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
 <20230528140652.8693-9-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230528140652.8693-9-avihaih@nvidia.com>
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
> Add a new VFIO device property x-allow-pre-copy to keep migration
> compatibility to/from older QEMU versions that don't have VFIO pre-copy
> support.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> ---
>   include/hw/vfio/vfio-common.h | 1 +
>   hw/core/machine.c             | 1 +
>   hw/vfio/migration.c           | 3 ++-
>   hw/vfio/pci.c                 | 2 ++
>   4 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 1db901c194..a53ecbe2e0 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -146,6 +146,7 @@ typedef struct VFIODevice {
>       VFIOMigration *migration;
>       Error *migration_blocker;
>       OnOffAuto pre_copy_dirty_page_tracking;
> +    bool allow_pre_copy;
>       bool dirty_pages_supported;
>       bool dirty_tracking;
>   } VFIODevice;
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 1000406211..64ac3fe38e 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -41,6 +41,7 @@
>   
>   GlobalProperty hw_compat_8_0[] = {
>       { "migration", "multifd-flush-after-each-section", "on"},
> +    { "vfio-pci", "x-allow-pre-copy", "false" },
>   };
>   const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
>   
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index d8f6a22ae1..cb6923ed3f 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -323,7 +323,8 @@ static bool vfio_precopy_supported(VFIODevice *vbasedev)
>   {
>       VFIOMigration *migration = vbasedev->migration;
>   
> -    return migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
> +    return vbasedev->allow_pre_copy &&
> +           migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
>   }
>   
>   /* ---------------------------------------------------------------------- */
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 73874a94de..c69813af7f 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3335,6 +3335,8 @@ static Property vfio_pci_dev_properties[] = {
>       DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", VFIOPCIDevice,
>                               vbasedev.pre_copy_dirty_page_tracking,
>                               ON_OFF_AUTO_ON),
> +    DEFINE_PROP_BOOL("x-allow-pre-copy", VFIOPCIDevice,
> +                     vbasedev.allow_pre_copy, true),
>       DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
>                               display, ON_OFF_AUTO_OFF),
>       DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),



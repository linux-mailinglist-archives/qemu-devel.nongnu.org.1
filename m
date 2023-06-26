Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 387A173DBE8
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 11:57:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDiyD-0007Jn-MH; Mon, 26 Jun 2023 05:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qDiy4-0007GT-LU
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qDiy3-0007EI-5W
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687773426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qCwzg9D06FwE2fmy0TgIIrP4Lrek8gCH9OFqQizCxCk=;
 b=Iv3wz3hKP+SdsalYKbZF+spj4hKlWLprog3Bh8QkVIioxSamdQR5DmPLhd2YxSSeg6byT/
 XtnDjTyN4rGB9D/5Qw/1d9hND2mUT+iumKGeBDSTmxI+yV2YT7Eytn9B6O4cRa/boj1t0+
 QhQqvqMRDx8SiAtUsBK5T2MtxYodgBs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-eXX46pYXPRG9qjIBDCQ1vA-1; Mon, 26 Jun 2023 05:56:59 -0400
X-MC-Unique: eXX46pYXPRG9qjIBDCQ1vA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-635ddb30491so16112656d6.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 02:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687773417; x=1690365417;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qCwzg9D06FwE2fmy0TgIIrP4Lrek8gCH9OFqQizCxCk=;
 b=jqp9ji2/BplXrvQDJ0gYiihIkAroTDkvyocbZLBB+OC0hIp6LQNUWjSUAeSgy6+CbS
 9JLo16pe1KfaFVwVPXjBDa3ttHjKmErI4XRSCEQIJoWu+H+z6yNJLJcC7PDU3NzN3cqR
 /g8hUg7+sVCDVDniIldlFSUER/jqiiLgmNU8tUWOd5I52OKlWRM93sNIiN6oGC7HGWaW
 R/8l3G7bddNgHIZPYO0ciBS+xSHq0TpECGc3Hu5XAhqB5VR/2wt4VZcrJ22W91RJ/T5Z
 r3AD2P7bqEwR7wA4jY8WWhTQoesAfxdDp45lvkQxIxLr3OXifEbmoKIuutLscFNAlPFd
 ufag==
X-Gm-Message-State: AC+VfDy8apPlxb+otvMCZlYUXwwca7+LDn650K13RgqxvnaIYJXOH6F1
 uUElpVC4+k8ECx4YNeKXYKLLF/a2CsVOtWx0KG6YSJKbG+eEyA3RIab+0M8BlPRDVA+RUAq3Zvj
 oQM4XumaFGTDNVz8=
X-Received: by 2002:a05:6214:f23:b0:631:e696:7b6 with SMTP id
 iw3-20020a0562140f2300b00631e69607b6mr30086002qvb.53.1687773417313; 
 Mon, 26 Jun 2023 02:56:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7mFd+BQvJCaa99DY445JOwv2fjzetUT1Vuy8AwLfO+zdV3i+0lH+Xiayh9rO5SOpdh9m41EQ==
X-Received: by 2002:a05:6214:f23:b0:631:e696:7b6 with SMTP id
 iw3-20020a0562140f2300b00631e69607b6mr30085980qvb.53.1687773417055; 
 Mon, 26 Jun 2023 02:56:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 cy11-20020a05621418cb00b0062febc332f0sm2970555qvb.130.2023.06.26.02.56.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 02:56:56 -0700 (PDT)
Message-ID: <3b6a527f-351c-8979-c15b-0dc0a8fdea11@redhat.com>
Date: Mon, 26 Jun 2023 11:56:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] vfio/migration: Move from STOP_COPY to STOP in
 vfio_save_cleanup()
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230626082353.18535-1-avihaih@nvidia.com>
 <20230626082353.18535-2-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230626082353.18535-2-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
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

On 6/26/23 10:23, Avihai Horon wrote:
> Changing the device state from STOP_COPY to STOP can take time as the
> device may need to free resources and do other operations as part of the
> transition. Currently, this is done in vfio_save_complete_precopy() and
> therefore it is counted in the migration downtime.
> 
> To avoid this, change the device state from STOP_COPY to STOP in
> vfio_save_cleanup(), which is called after migration has completed and
> thus is not part of migration downtime.

That's optimization and
  
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   hw/vfio/migration.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index acbf0bb7ab..a8bfbe4b89 100644
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

we loose the possible returned error. Let's keep that change for later.

Thanks,

C.


>       trace_vfio_save_complete_precopy(vbasedev->name, ret);
>   
>       return ret;



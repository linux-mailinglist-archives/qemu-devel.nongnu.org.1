Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A6FA457AA
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Feb 2025 09:07:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnCQv-00040Q-VT; Wed, 26 Feb 2025 03:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnCQs-0003zz-FO
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 03:06:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnCQq-0000Hq-5Y
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 03:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740557173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JT1qBWlvfPX0hXRA09gP6Bvkmf0R0U+A8VM/liuMjbw=;
 b=Xl3+iZF1pNa8FspG/yI5TdQtViI37TTk1amKoHoSP0Sr8OaRjgYPW3Bl0KYLRRKF5Ichg+
 dZZ9iA2drgotba+4erygYqT2chRh9n3L7phR2gWSqf++j1beKDFOj3qtFc65s0pGjR7sv7
 +1exO3GutPHDCPw0fc3Rq4eCPBNRCKg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-aamWXZBPMhmGBQKtpBuqoQ-1; Wed, 26 Feb 2025 03:06:10 -0500
X-MC-Unique: aamWXZBPMhmGBQKtpBuqoQ-1
X-Mimecast-MFC-AGG-ID: aamWXZBPMhmGBQKtpBuqoQ_1740557169
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-439a0e28cfaso35044215e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 00:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740557169; x=1741161969;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JT1qBWlvfPX0hXRA09gP6Bvkmf0R0U+A8VM/liuMjbw=;
 b=J7b90atOwyAUEKst1OXGYouXO6Iegmw5mqCO6ZstOO9kCv/I0y3/L22cNKkFHUCG6M
 WG0M7gJI8L76JRMmsS0YEdCa1umXLvKqyDKTzSpqfLBJr6evbl67oJ+8w/GjcYgr4NwW
 jVy2/BDaq+lxOqOU66+vdnT7wtP0KgumjIzo2w+73JXq5guX7U/PU9R/ggnDUlsMB2lV
 oSzt4/YLbxddkLBHcDD5uvUmPf3V8UAuKKS8ntDJdzL/9DaRwSzZgRBIokZ52dGvwW8o
 bvFCmL+nELQfiuSHfRrHvJU7b6L9f5srqVdMvfIUpkpCuLtlLuhE125k7K2n/sojm7l0
 fNkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjLL4MdkG/+L6LUQbw/co4IKVJbT7gATXfE2Sr4iEvSgHARAfKC0jba3yOCfFKbyIM82vmsA/oYYc9@nongnu.org
X-Gm-Message-State: AOJu0YxnQpnlYmL2qSVFIVfUGXSiuJ+itZbVGMvSYjbv6ZvkGj7b/dP3
 HP5tQq+yOD/qZaaJL60VlYSk/s+07lGllYB3zi8EfgdHElyLeXJID12RtDdnQ80nEV2IOqqpyhD
 CbGj61A9TSKOgNE6RclitSI/p53vUC+D5Q5/YcnX4bS3g0nlLD0+i
X-Gm-Gg: ASbGnctD8tP07woNsLYWo2YJZAFs9oySWmO5rPzozf3w3YYA1ZvfQE826JAZIiXBwdE
 XvpTzGWb70dBbR7WVcioN1//C/JFFboPSb4hM/F6xQUKdCbFpyUX91XNNrPpd0KDIHufeHVZJyS
 ykNi0fM1IVuLXF8sfo/HKkwN/AyGQqj/Pnkfc3sofeKnbgc+njyU21gIk35MNSnSKBQ24kw7WVf
 y7Yg1WfzF7wSTfHGPcShoCh41bYp4e2OmLiFnriOYCoJnhkzaTnqqrVfinpLWb1or9pLNYa4ErH
 I+KJcDi86c8lG4OK2rIDsoC096OvCCJ0gidxEcoDed0CYuUn7t+4ZkBr1AY=
X-Received: by 2002:a05:600c:1989:b0:439:a6db:1824 with SMTP id
 5b1f17b1804b1-43ab0f4271cmr66219325e9.16.1740557168871; 
 Wed, 26 Feb 2025 00:06:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGi8ZK2pmJMdieitCs48uyz2URPPbk3Y9neJkvZam0zxMR7Mg9z69VU41/uSgvBMkEP5xeBkw==
X-Received: by 2002:a05:600c:1989:b0:439:a6db:1824 with SMTP id
 5b1f17b1804b1-43ab0f4271cmr66218925e9.16.1740557168447; 
 Wed, 26 Feb 2025 00:06:08 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:a732:5611:7f59:8bb3?
 ([2a01:cb19:9004:d500:a732:5611:7f59:8bb3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba52bc20sm12493035e9.2.2025.02.26.00.06.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 00:06:07 -0800 (PST)
Message-ID: <96fd8777-0be4-4e0b-86f7-dd663f5a83b6@redhat.com>
Date: Wed, 26 Feb 2025 09:06:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/36] vfio/migration: Add vfio_add_bytes_transferred()
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <e2983df564f37f346d0a9413bf602856249bb3b3.1739994627.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <e2983df564f37f346d0a9413bf602856249bb3b3.1739994627.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2/19/25 21:34, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This way bytes_transferred can also be incremented in other translation
> units than migration.c.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Looks good. Just a small aesthetic issue.

> ---
>   hw/vfio/migration.c           | 7 ++++++-
>   include/hw/vfio/vfio-common.h | 1 +
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 5532787be63b..e9645cb9d088 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -391,7 +391,7 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
>       qemu_put_be64(f, data_size);
>       qemu_put_buffer(f, migration->data_buffer, data_size);
> -    qatomic_add(&bytes_transferred, data_size);
> +    vfio_add_bytes_transferred(data_size);
>   
>       trace_vfio_save_block(migration->vbasedev->name, data_size);
>   
> @@ -1021,6 +1021,11 @@ void vfio_reset_bytes_transferred(void)
>       qatomic_set(&bytes_transferred, 0);
>   }
>   
> +void vfio_add_bytes_transferred(unsigned long val)

vfio_migration_add_bytes_transferred()


Thanks,

C.



> +{
> +    qatomic_add(&bytes_transferred, val);
> +}
> +
>   /*
>    * Return true when either migration initialized or blocker registered.
>    * Currently only return false when adding blocker fails which will
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index ac35136a1105..70f2a1891ed1 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -274,6 +274,7 @@ void vfio_unblock_multiple_devices_migration(void);
>   bool vfio_viommu_preset(VFIODevice *vbasedev);
>   int64_t vfio_mig_bytes_transferred(void);
>   void vfio_reset_bytes_transferred(void);
> +void vfio_add_bytes_transferred(unsigned long val);
>   bool vfio_device_state_is_running(VFIODevice *vbasedev);
>   bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
>   
> 



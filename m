Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAAE827EEF
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 07:53:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN5ya-0004bc-68; Tue, 09 Jan 2024 01:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rN5yY-0004bS-8Y
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 01:52:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rN5yW-0000C5-6b
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 01:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704783154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6AZ7/4rjepQVbBUe+UdV4NDnvjz9ZmKVQEjkdzhEMbw=;
 b=bxmY+33NKTSEEuTRV71/+l0wfcH4b1M5Q6jHdO4/Jp0ywbE5yhX5C4qLVVWqvjiHd/Gbdb
 WHOXKA6U2mC8UKqqYMF9Kg+rZcgb9FE1Xskg0BJGLZ3U09JNiOHPtPuq86U5S3Oi6B9CKz
 l6sy9zq5Yxq68cXGEPuvn1ldV2bEBo0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-gQdl5yNvMS6k8uFUHbwZoQ-1; Tue, 09 Jan 2024 01:52:27 -0500
X-MC-Unique: gQdl5yNvMS6k8uFUHbwZoQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7832b5fc14bso66793385a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 22:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704783147; x=1705387947;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6AZ7/4rjepQVbBUe+UdV4NDnvjz9ZmKVQEjkdzhEMbw=;
 b=P2matrF7iQXfG/gWI//yFTipFkmkzVfI/MdUF6D5xq7TyiNNnRr+u8VgLz74+Niv/l
 bPl3vOvRYKuSjdBpp5l31FB+Y7fL3Zzaw8adspTBvWeDsQqsKaHqFb+80Et1rD3B/xAo
 YVuvsF/bDhSY/HDT5JEdpwXPXpFzzNyhwMDDl0nKj2iEi4F4Zq2kOdbMK4t6HHLDapn7
 jELLxdhFcmfUJSoE5QRiQlCxYYiSKOooU+mdnZA/61gqYFaMM0RY6NgomrOF0tjXi1BO
 cbrmGGEEy1O85lJfM7vdMJqR8/rbwTFd+4A4sInZMFiWYR28fysgTAWsJv8GbEq61dSV
 ycMA==
X-Gm-Message-State: AOJu0YxE9zAZBj7knitZaQa+R9k2DytFtFBhCC+OaSo/jaZtX14aZXRW
 BjKpS3D5CvXshQapAsMftqbJ9j1pB66eIy92nJ0gCa8/JM7Op9CushnFP80mjIAgawQddMVimVF
 mlBe+5xwP2/6k9CKowSzyUts=
X-Received: by 2002:a05:620a:3713:b0:781:e427:c877 with SMTP id
 de19-20020a05620a371300b00781e427c877mr5162608qkb.94.1704783147366; 
 Mon, 08 Jan 2024 22:52:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8O/E/E9ss+Tod/p/hoCchh48qXvA0D4yMvt7qJKaFsGCzBgGMdGRLOOQ2F9NeP8n3/fEcKA==
X-Received: by 2002:a05:620a:3713:b0:781:e427:c877 with SMTP id
 de19-20020a05620a371300b00781e427c877mr5162602qkb.94.1704783147083; 
 Mon, 08 Jan 2024 22:52:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a05620a102600b00781b37f8468sm569026qkk.13.2024.01.08.22.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 22:52:26 -0800 (PST)
Message-ID: <edae1e22-d1f0-49a9-ac91-c5492bc015c7@redhat.com>
Date: Tue, 9 Jan 2024 07:52:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] docs/migration: Create migration/ directory
Content-Language: en-US
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240109064628.595453-1-peterx@redhat.com>
 <20240109064628.595453-2-peterx@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240109064628.595453-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/9/24 07:46, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Migration documentation is growing into a single file too large.  Create a
> sub-directory for it for a split.
> 
> We also already have separate vfio/virtio documentations, move it all over
> into the directory.
> 
> Note that the virtio one is still not yet converted to rST.  That is a job
> for later.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   docs/devel/index-internals.rst                            | 2 +-
>   docs/devel/{migration.rst => migration/main.rst}          | 0
>   docs/devel/{vfio-migration.rst => migration/vfio.rst}     | 0
>   docs/devel/{virtio-migration.txt => migration/virtio.txt} | 0
>   4 files changed, 1 insertion(+), 1 deletion(-)
>   rename docs/devel/{migration.rst => migration/main.rst} (100%)
>   rename docs/devel/{vfio-migration.rst => migration/vfio.rst} (100%)
>   rename docs/devel/{virtio-migration.txt => migration/virtio.txt} (100%)
> 
> diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
> index 3def4a138b..a41d62c1eb 100644
> --- a/docs/devel/index-internals.rst
> +++ b/docs/devel/index-internals.rst
> @@ -11,7 +11,7 @@ Details about QEMU's various subsystems including how to add features to them.
>      block-coroutine-wrapper
>      clocks
>      ebpf_rss
> -   migration
> +   migration/main
>      multi-process
>      reset
>      s390-cpu-topology
> diff --git a/docs/devel/migration.rst b/docs/devel/migration/main.rst
> similarity index 100%
> rename from docs/devel/migration.rst
> rename to docs/devel/migration/main.rst
> diff --git a/docs/devel/vfio-migration.rst b/docs/devel/migration/vfio.rst
> similarity index 100%
> rename from docs/devel/vfio-migration.rst
> rename to docs/devel/migration/vfio.rst
> diff --git a/docs/devel/virtio-migration.txt b/docs/devel/migration/virtio.txt
> similarity index 100%
> rename from docs/devel/virtio-migration.txt
> rename to docs/devel/migration/virtio.txt



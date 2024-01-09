Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CA6827F2C
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 08:21:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN6Ph-0002uh-Jd; Tue, 09 Jan 2024 02:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rN6Pf-0002qP-RU
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 02:20:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rN6Pd-0004Kj-EJ
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 02:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704784836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=StEuiYwVS0eWRayOtU2drBYa9WbmybnXn9B6UiBYGts=;
 b=c/sOqdiUQBEEpRV7Ietudy74dtVVUlkI1/XIyo8cy4Ama0lGE5HJzJoLSs1QO+l2VqQIT5
 BldD8Ijz/XN9FNX80DebLVtYs3vPw2sjaHzmBxHDjx524rwMVKnp8gITr8+OqUJtQXWFjm
 7OLG8jkXRuPaaaQGzQsMClRgg7qe1+E=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-g6exD1bROZOFFRSN21qLKw-1; Tue, 09 Jan 2024 02:20:33 -0500
X-MC-Unique: g6exD1bROZOFFRSN21qLKw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7831f409539so260825285a.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 23:20:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704784833; x=1705389633;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=StEuiYwVS0eWRayOtU2drBYa9WbmybnXn9B6UiBYGts=;
 b=I8WUMz7sqaWuECOwUq+LUMALkK47AoSxXG1Ga/aGDpdkv3p2dRUIof7kvIT15pmm3p
 2aii3WPPD+MMhBrOlk0aGMlxbpHFcVYNmrRh6nglzFrP4pKiW19wLJhb/bxULtayG/6z
 Lm+DARyNeoqiNL8sPpMtSBooZ1bB43I141N9UkpYp9cwMUcd9MvymL+Uff2fUZt9Dfbi
 ioT2znWzfRWuFxy04mOVsdtRws/1Q+3KNPXEzwBmJ5uz/DIPOwGhPFpJ+kVEQ/xapv3N
 A0L5BBLs/5chnEutMH422eYPfnlX0y50vctsSTgq3jljYEiA/P7/PyItpJpjJKP41V+u
 ajsw==
X-Gm-Message-State: AOJu0Yz3yIw3v7Fl8nQk0HhMhoJojxpi8E4HKvMe/3khaz/L7GKxG8OK
 F401KaoAwUqRPmPzq+IqQMD0Ucgnvujys1nJDjOiv/AzbSpDcvdJQIxjHIk9Cnt04bOnCjf2imr
 Pnh77VlMwV9LG07ACfAoV6dE=
X-Received: by 2002:a05:620a:c4f:b0:781:6b43:1203 with SMTP id
 u15-20020a05620a0c4f00b007816b431203mr5992646qki.155.1704784833508; 
 Mon, 08 Jan 2024 23:20:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+1YKnXdiHtrqYWFIpplKyxA+Om3HeE9W8eBzt045bXEB8n203M2PYxu3+Hl2khWr7v2mHAQ==
X-Received: by 2002:a05:620a:c4f:b0:781:6b43:1203 with SMTP id
 u15-20020a05620a0c4f00b007816b431203mr5992640qki.155.1704784833280; 
 Mon, 08 Jan 2024 23:20:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 n19-20020a05620a223300b00783148d1269sm582626qkh.62.2024.01.08.23.20.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 23:20:33 -0800 (PST)
Message-ID: <64950b00-98f0-4031-b2a3-ca9bfeda7ce5@redhat.com>
Date: Tue, 9 Jan 2024 08:20:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] docs/migration: Further move vfio to be feature of
 migration
Content-Language: en-US
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240109064628.595453-1-peterx@redhat.com>
 <20240109064628.595453-10-peterx@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240109064628.595453-10-peterx@redhat.com>
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
> Move it one layer down, so taking VFIO-migration as a feature for
> migration.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   docs/devel/migration/features.rst | 1 +
>   docs/devel/migration/index.rst    | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
> index e257d0d100..dea016f707 100644
> --- a/docs/devel/migration/features.rst
> +++ b/docs/devel/migration/features.rst
> @@ -8,3 +8,4 @@ Migration has plenty of features to support different use cases.
>   
>      postcopy
>      dirty-limit
> +   vfio
> diff --git a/docs/devel/migration/index.rst b/docs/devel/migration/index.rst
> index 7cf62541b9..2479e8ecb7 100644
> --- a/docs/devel/migration/index.rst
> +++ b/docs/devel/migration/index.rst
> @@ -10,6 +10,5 @@ QEMU live migration works.
>      main
>      features
>      compatibility
> -   vfio
>      virtio
>      best-practises



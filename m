Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD6E9AB399
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Oct 2024 18:14:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3HW2-0003YD-LH; Tue, 22 Oct 2024 12:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3HW0-0003Y4-Pl
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:13:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3HVx-0001yX-Uo
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729613625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L9QYmTS+Ln1jp+A4fzI8kexisUAKery8D79VBrsWvnw=;
 b=WyGP8r1HgodZv+URBook6iHoEB6ucx937TR8KGgm16ds6shaSqh5FByvh+UZLVrd9v0i+x
 NXFF6g6nQ7ZZNEj5me+tGhiLLeJP5nR79JFdVgvb9bc/3fR5OdcdJSeWHfpU90dWBEyZWB
 2wp90xJfAyayX63Na5Zjq2c36qWFW60=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-Us1UVHvVPrumeG3yjoyrJw-1; Tue, 22 Oct 2024 12:13:43 -0400
X-MC-Unique: Us1UVHvVPrumeG3yjoyrJw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315e8e9b1cso30104655e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 09:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729613622; x=1730218422;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9QYmTS+Ln1jp+A4fzI8kexisUAKery8D79VBrsWvnw=;
 b=PAhezCvgrPamhqcSoUrMtdJOLJsOM6Iv2QfHQB9x7zXatu8BnoXm+8pnLTFERn0BkR
 PliF5TiAyDro4R32rL2MY1CIhelC+V3WG6hs7RoTqiiETNzTCptKCG7T3oSP6/hc058b
 zIekfkJhFKKCLPpAVs93S7j43S2O3y0nZqvRKjLiLxzfUkUi4rqqnmoeh010B7TLgsMD
 bcsfLY6jotvJOseDbird5vlILC5te0X5ijJ+t+MNuoMFqDgB8uREgwWUGBCwmmvbK/Ik
 cAC+mKLdQAOoomdOqYS5+Mi9bbAcxWzgibOYmWy9MHBplojupwI4W31KKodiiASWhXj9
 l4WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNw3LK+7yaMfnQSe5g0ChMOvmHryv2Dn8/YTZfiDZwQYQ97H8ZgY7gbzUdFxRq2uJHfg2deBYVxb1L@nongnu.org
X-Gm-Message-State: AOJu0Yw+0Dwv1lfbZFhniqZt57BiPHRHIfacct1k6MKEShjI1LNQp+2W
 6wqbh0G9tFV6X6Tnu3Hw4wlrXsGLSpjfstbJMcldSFDy4qUmBOEfO1OOG18RQ98Bzw5dVn5YAcv
 ltnnwYDbSV6lo7X48LO2a3v43QQ+rYb3B6XRzgBwcF84ZDnaPxc+t
X-Received: by 2002:a05:600c:3590:b0:431:4a82:97f2 with SMTP id
 5b1f17b1804b1-4317bd7f68fmr25812615e9.6.1729613622292; 
 Tue, 22 Oct 2024 09:13:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZuzvDOjK+XoUaw4Qc5xxAAe43+lg6r6CgCVYRVt1YLVmmvtSnjZPPNzBsHveGnDLhBJR+4Q==
X-Received: by 2002:a05:600c:3590:b0:431:4a82:97f2 with SMTP id
 5b1f17b1804b1-4317bd7f68fmr25812415e9.6.1729613621897; 
 Tue, 22 Oct 2024 09:13:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f570d86sm94139225e9.8.2024.10.22.09.13.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 09:13:41 -0700 (PDT)
Message-ID: <a737618d-c02e-4cf1-b980-bb6b4a516c15@redhat.com>
Date: Tue, 22 Oct 2024 18:13:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] migration: Unexport dirty_bitmap_mig_init() in misc.h
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20241022160720.1013543-1-peterx@redhat.com>
 <20241022160720.1013543-3-peterx@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20241022160720.1013543-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/22/24 18:07, Peter Xu wrote:
> It's only used within migration/, so it shouldn't be exported.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/migration/misc.h | 3 ---
>   migration/migration.h    | 4 ++++
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 8d6812b8c7..e0e88b1c0c 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -131,7 +131,4 @@ bool migration_incoming_postcopy_advised(void);
>   /* True if background snapshot is active */
>   bool migration_in_bg_snapshot(void);
>   
> -/* migration/block-dirty-bitmap.c */
> -void dirty_bitmap_mig_init(void);
> -
>   #endif
> diff --git a/migration/migration.h b/migration/migration.h
> index 7dc59c5e8d..0956e9274b 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -552,4 +552,8 @@ int migration_rp_wait(MigrationState *s);
>   void migration_rp_kick(MigrationState *s);
>   
>   void migration_bitmap_sync_precopy(bool last_stage);
> +
> +/* migration/block-dirty-bitmap.c */
> +void dirty_bitmap_mig_init(void);
> +
>   #endif



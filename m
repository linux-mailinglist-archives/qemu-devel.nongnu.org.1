Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE97827F30
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 08:21:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN6Ps-00034G-Ac; Tue, 09 Jan 2024 02:20:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rN6Pr-00033l-25
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 02:20:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rN6Pp-0004QS-Et
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 02:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704784848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dv3aIFpAeg3bzO8FwcRdcQNZ3lpsEqXst6jpekqIEEM=;
 b=Iep/uYLfRxa3oEPCH78eo3H/OF8MYFYTnWUodVvdNvBrXwz2jsykXVHdlJGiHFCKxoi3aW
 AyBYoa395xZiMamJEA2hhKhqLE64icW7UNa/zyEZsJviAlAftQWDcVC45A34+81nI07Us8
 5TKLCFZ6ZaTQg7r+J2p0mJGmqfQJmvE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-Iu7L2OwmNUWy51G6eqapgw-1; Tue, 09 Jan 2024 02:20:47 -0500
X-MC-Unique: Iu7L2OwmNUWy51G6eqapgw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7832023ed21so157597885a.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 23:20:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704784846; x=1705389646;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dv3aIFpAeg3bzO8FwcRdcQNZ3lpsEqXst6jpekqIEEM=;
 b=sXcTlU/5YG2jLiyLMMFWLFMp89gcTtunJQbDkUx13syqZLcwmQ7d8L3TAaf4b6nu8P
 tFBHQ1Y9Tv6XyW8COQRFm+gkiysViKKfYfhefKQGu8pdLxQ60p1MASVnYhs3dlC6VAPb
 g0+z2sYQ2qVwVkj1krPiCj87mRK19Cqip/JM3K+ccmaziObuVR+aYj55HTvhUkm6D9+T
 /c87fXD08cZGf0bydVtVawBoyhePUQ6WgrhShCe+gr+xnAI67XNRWsiBKhuyXaqc1Frl
 200pAJ3Yd/NgTWVUtLUNrum9No5m07qhlExI4vWD9QnFUfnfbTMhaE8XEGjgN5YUaMUG
 jeuQ==
X-Gm-Message-State: AOJu0YzeZBGQEhHsmNOfAhdkhgDlmMSIqtklbIbBOGgitsJtb/RGCSo9
 oSOekawozA74liSToUe3irDVby2mGb1fN6kuku8hKX68yqA+isSAFJwk9E1Ag9DaeU1Li3ylyii
 eUZcu9CUtrL7JyaKWP0ZCWDs=
X-Received: by 2002:a05:620a:2804:b0:783:10d6:214c with SMTP id
 f4-20020a05620a280400b0078310d6214cmr4623956qkp.104.1704784846730; 
 Mon, 08 Jan 2024 23:20:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdNKnJ+B6Y2davvH96I+Y+VHLQSeRF2OCg+hexHvB9HEn+ZenrZBUm761ls+OQaRkBlM3/pA==
X-Received: by 2002:a05:620a:2804:b0:783:10d6:214c with SMTP id
 f4-20020a05620a280400b0078310d6214cmr4623949qkp.104.1704784846513; 
 Mon, 08 Jan 2024 23:20:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 n19-20020a05620a223300b00783148d1269sm582626qkh.62.2024.01.08.23.20.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 23:20:46 -0800 (PST)
Message-ID: <6488c364-8817-4aab-b1c6-f8caf7fc7b35@redhat.com>
Date: Tue, 9 Jan 2024 08:20:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] docs/migration: Further move virtio to be feature
 of migration
Content-Language: en-US
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240109064628.595453-1-peterx@redhat.com>
 <20240109064628.595453-11-peterx@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240109064628.595453-11-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
> Move it one layer down, so taking Virtio-migration as a feature for
> migration.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
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
> index dea016f707..a9acaf618e 100644
> --- a/docs/devel/migration/features.rst
> +++ b/docs/devel/migration/features.rst
> @@ -9,3 +9,4 @@ Migration has plenty of features to support different use cases.
>      postcopy
>      dirty-limit
>      vfio
> +   virtio
> diff --git a/docs/devel/migration/index.rst b/docs/devel/migration/index.rst
> index 2479e8ecb7..7b7a706e35 100644
> --- a/docs/devel/migration/index.rst
> +++ b/docs/devel/migration/index.rst
> @@ -10,5 +10,4 @@ QEMU live migration works.
>      main
>      features
>      compatibility
> -   virtio
>      best-practises



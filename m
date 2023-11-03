Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8047E04DA
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 15:44:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyvOq-0001BX-6f; Fri, 03 Nov 2023 10:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qyvOo-0001B9-E3
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 10:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qyvOm-0000oT-Qi
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 10:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699022628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xh+XKFJTovaMmDCS6pDgecZB7Y/BCdUcgmgImvRB+tE=;
 b=NvRf29FyMKE2m5BincF38CHyj2oMoBQ0v0nBsioBZhDk9HbAjoo8St6ZO372uQsJpmuP8m
 MEU4DmU7vIJ/8JhT1zd0tAW0W/j5YbG+IddGlYbcLkCH1lzeF/I1JgwXVAcWgnqN2ftB0/
 0hgAxGI7XkzxI3U3rcmZa8yagUQ0AyM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-toX9obl4PdShPNxW9mdqYw-1; Fri, 03 Nov 2023 10:43:46 -0400
X-MC-Unique: toX9obl4PdShPNxW9mdqYw-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-5b0c27d504fso16542177b3.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 07:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699022625; x=1699627425;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xh+XKFJTovaMmDCS6pDgecZB7Y/BCdUcgmgImvRB+tE=;
 b=uv89VpUzQ7K2MAC+DrXRY+4Y8dGH0LuASmCYdnJyohAGwGUCZwDLDkylm23q4RG/Am
 mRhmx2NNvvyNzxNUnO/rTn/bo3/aghfkqgBJTVw5WSsUlWl3Hvmj2ZhqaI8JBMNmWWT1
 88P/rh3+FzCLWjUybEKHHCEkwGRZRPVFiq0UyiXxfNnrx6jUctaDT820uBbzB36iUX7V
 Ggpo10xLl50wfiQL8Aqm4u7/HFRheE9nK6kOMjGL6VdE5EIAjyBqGv+Qpl/1+QvdkKZO
 SRKFPi0vaNZoUERe13C75J70Mdk2HCFwsASDEDiDg+pF3QcZRtip6X42FAJ7mYBNwJrx
 /00A==
X-Gm-Message-State: AOJu0Yxaw7YSX5oD8qXekfvCLQPEB7kbkzUlOHPPTWCkJilitcrb96zh
 PRr8AcrcNyFU9W4ArND6VA00ZBaX2pFXUFwei0PNsb/k6e+/x+Xg4cSdgGXlouUbOjwBJWDCY2E
 +yOqL0gqZfkrbOC8cAvuHZIycQpzTslI=
X-Received: by 2002:a05:690c:f93:b0:5a8:1767:1fef with SMTP id
 df19-20020a05690c0f9300b005a817671fefmr2654662ywb.9.1699022625782; 
 Fri, 03 Nov 2023 07:43:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB8Dy/jE1TjWDyitIMM1OHnPpx8NEqUrpYU9P6ywdXw0nTbeLN6CfBmJqBe90wpqUG/v3nEw/mXvPFQ8VRhng=
X-Received: by 2002:a05:690c:f93:b0:5a8:1767:1fef with SMTP id
 df19-20020a05690c0f9300b005a817671fefmr2654645ywb.9.1699022625523; Fri, 03
 Nov 2023 07:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698195059.git.yin31149@gmail.com>
 <626449eb303207de408126b3dc7c155cd72b028b.1698195059.git.yin31149@gmail.com>
In-Reply-To: <626449eb303207de408126b3dc7c155cd72b028b.1698195059.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 3 Nov 2023 15:43:09 +0100
Message-ID: <CAJaqyWfqHRBREeOpviKCb4MdxMVN06b2HeiBhSSQ1vM0STSuxA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] vdpa: Allow VIRTIO_NET_F_RSS in SVQ
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
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

On Wed, Oct 25, 2023 at 3:08=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> Enable SVQ with VIRTIO_NET_F_RSS feature.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
> v5:
>   - no changes
>
> v4: https://lore.kernel.org/all/4ee7f3f339469f41626ca2c3ac7b1c574ebce901.=
1697904740.git.yin31149@gmail.com/
>   - no code changes
>
> v3: https://lore.kernel.org/all/2d2a378291bfac4144a0c0c473cf80415bb580b3.=
1693299194.git.yin31149@gmail.com/
>
>  net/vhost-vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index a4cc1381fc..d0614d7954 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -122,6 +122,7 @@ static const uint64_t vdpa_svq_device_features =3D
>      /* VHOST_F_LOG_ALL is exposed by SVQ */
>      BIT_ULL(VHOST_F_LOG_ALL) |
>      BIT_ULL(VIRTIO_NET_F_HASH_REPORT) |
> +    BIT_ULL(VIRTIO_NET_F_RSS) |
>      BIT_ULL(VIRTIO_NET_F_RSC_EXT) |
>      BIT_ULL(VIRTIO_NET_F_STANDBY) |
>      BIT_ULL(VIRTIO_NET_F_SPEED_DUPLEX);
> --
> 2.25.1
>



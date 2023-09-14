Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7873479F8D9
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 05:25:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgcxR-0001aj-Sa; Wed, 13 Sep 2023 23:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qgcxP-0001a9-Br
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:23:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qgcxN-0001w9-Sn
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694661832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vneL+oq3xwfR9ocFQ/2uBrhTiGeyAJTp2HiPgIyQ4Gs=;
 b=b7faouWZMcnOVI2wenR++oyu8KR7YyS3qNFY7q7Ch7u199WnDWcVe647oTl5PeFM5rXdw+
 v+NZrYYOeM98Yr4oWcjA+QRkLViLUd1v9spLF5us1h2vyqYIsrlakBCZ0RknlcVtZ+qXBm
 nMJya7SIJdaxLwLwEZoFQrQRhMX7kd4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-tTfiDgThMf-rIgCebqwqxg-1; Wed, 13 Sep 2023 23:23:51 -0400
X-MC-Unique: tTfiDgThMf-rIgCebqwqxg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-501c70f247cso539043e87.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 20:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694661829; x=1695266629;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vneL+oq3xwfR9ocFQ/2uBrhTiGeyAJTp2HiPgIyQ4Gs=;
 b=o4arwTN9JAqWyqMM0rCG35lSebZZ692ScWPeZplyVtNicRYhK5xLs2UgH5f7Ypxnfp
 tGYKklGkU76iIofM+JTjhxw+gmumoLDPzpIPE37dbkRl6ToyUhst8h5gydi264YJ9LXD
 Mvlnuaub6QdbsYxGl/vqS2cnazL4ArZe078CZueW11V2ybGzlIPrna59iD7QaeiUucCG
 XidDKC9PPpZnl82SiE83fV/kKjKhFTP6EbsfT+Z1byBtZzAyMNlEE81oZDaZx67RHa/E
 gHQlW3X+FKZlwb7wdBGs/RJCUkmAuNdK2tcwlKY/JJeD32r6EHPI0sodTos4Gf6h0+0y
 +W0Q==
X-Gm-Message-State: AOJu0Yzj67wdqcQZlALIE5e74wjeQHZyVIc2PlIz47xsBazACIyTeU3a
 Lub0CUgzGAJV+g5pzwh6dja8laoJNxV9zef7x/XeDgG21G8+Kt4wu2gAK++/yfD/EKSXjhf/Jva
 9JMU+mS2oVNL+ddwEk0EQUjUD3AphVj4=
X-Received: by 2002:a05:6512:2018:b0:500:a408:dbd with SMTP id
 a24-20020a056512201800b00500a4080dbdmr3187795lfb.55.1694661829243; 
 Wed, 13 Sep 2023 20:23:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkA0SvxcAtI1W8G0uz5Pf7FUlV4BuOwPdbWZtW4KhAUYithgpuXxw1TpJ4SJUTWD/G6FTuPGr64xDGfxIPGUU=
X-Received: by 2002:a05:6512:2018:b0:500:a408:dbd with SMTP id
 a24-20020a056512201800b00500a4080dbdmr3187785lfb.55.1694661828934; Wed, 13
 Sep 2023 20:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230913123408.2819185-1-eperezma@redhat.com>
In-Reply-To: <20230913123408.2819185-1-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Sep 2023 11:23:37 +0800
Message-ID: <CACGkMEur1FEqDiH9ZY7hfds6eVeQFqMhyDdgFzU-O+nf2JqR5Q@mail.gmail.com>
Subject: Re: [PATCH] vdpa net: zero vhost_vdpa iova_tree pointer at cleanup
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Lei Yang <leiyang@redhat.com>, 
 Shannon Nelson <snelson@pensando.io>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, yama@redhat.com, 
 Hawkins Jiawei <yin31149@gmail.com>, Cindy Lu <lulu@redhat.com>,
 qemu-stable@nongnu.org, 
 Dragos Tatulea <dtatulea@nvidia.com>, si-wei.liu@oracle.com, 
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 13, 2023 at 8:34=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Not zeroing it causes a SIGSEGV if the live migration is cancelled, at
> net device restart.
>
> This is caused because CVQ tries to reuse the iova_tree that is present
> in the first vhost_vdpa device at the end of vhost_vdpa_net_cvq_start.
> As a consequence, it tries to access an iova_tree that has been already
> free.
>
> Fixes: 00ef422e9fbf ("vdpa net: move iova tree creation from init to star=
t")
> Reported-by: Yanhui Ma <yama@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  net/vhost-vdpa.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 34202ca009..1714ff4b11 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -385,6 +385,8 @@ static void vhost_vdpa_net_client_stop(NetClientState=
 *nc)
>      dev =3D s->vhost_vdpa.dev;
>      if (dev->vq_index + dev->nvqs =3D=3D dev->vq_index_end) {
>          g_clear_pointer(&s->vhost_vdpa.iova_tree, vhost_iova_tree_delete=
);
> +    } else {
> +        s->vhost_vdpa.iova_tree =3D NULL;
>      }
>  }
>
> --
> 2.39.3
>



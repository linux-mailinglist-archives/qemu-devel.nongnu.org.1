Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB6680D3A6
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 18:24:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCjzP-00066m-M0; Mon, 11 Dec 2023 12:22:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCjzM-00063x-UN
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:22:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCjzE-0002nY-2M
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:22:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702315350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMmeZo4jee3JsWbeSe6gT15KUOFOJdwvEYwwetuFxBQ=;
 b=RQ8joTCyMr8bOKwr0YsHUqm+KWwCHNfg396YTGIMjIrStS+zJRjyUHVgZhKyaGkbMSuHn6
 929PSKbU87nwgul77aNVhRdqJb+RrCnAwgOON75ee9/W9q2CMcZV+KTxH2JMDBPaxzUrme
 Rpolq5DieuTikn3qGQCarJx/YjexU1k=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-aPpgBUy9OxiSSfokKf33hQ-1; Mon, 11 Dec 2023 12:22:27 -0500
X-MC-Unique: aPpgBUy9OxiSSfokKf33hQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-db53b5f9b52so4894940276.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 09:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702315347; x=1702920147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OMmeZo4jee3JsWbeSe6gT15KUOFOJdwvEYwwetuFxBQ=;
 b=MiVxLd+9dRNssseKIruSWU7EM/Fe0WJpi3/+CZsDUJhkP92vuFInZNp3EqJolSU72J
 +DSgFVUF0qwTNaGVe8lyXSzQ00rKeuSjUbo6yy/y/qapBAtx7Wv+/hVD5I4Sa32fX4TJ
 MNqP98EK1FO4mlteRzgDw75hljTiQB0uC0U6ll2dJM1Hmw6wlIeUVE52XsbJTkMxhDF9
 ZNbmXg6HYCpm+4t4QZsng6EdUdL+IKolBA9ZLyxE4dupHr/3WuH55QtBvNrfY9cKq1yb
 M3okYlL5pwHAzz7q0KMxEGkhROvhqwMzVcny+qIXQj86oUvy+g7Et9MUOiC0+lO3XZyl
 YpFw==
X-Gm-Message-State: AOJu0YwtcvwB9SvPZG+5aOJwicMygCp9/VzQy9TqEMKW/k8J8hnrml8p
 6G5Eq8kLri9zQDud5ljxLeYvHDBKPIfJIVt4Eju+kVP0B19oP+/8Spza1x4d5jCajCoZ/2ySCty
 cbrZUietzKRed3WRp41TiqmEx43f+Fmg=
X-Received: by 2002:a25:556:0:b0:db7:dacf:61fd with SMTP id
 83-20020a250556000000b00db7dacf61fdmr2808580ybf.79.1702315347123; 
 Mon, 11 Dec 2023 09:22:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhjahkFn7Fj83cjtxRt8RAIa/YAbI3vbVsNRI8kWZcJtvXjTSfl4xW/KW2lwpIv+PJ4m5+NSWqsaSnXUfSPac=
X-Received: by 2002:a25:556:0:b0:db7:dacf:61fd with SMTP id
 83-20020a250556000000b00db7dacf61fdmr2808572ybf.79.1702315346846; Mon, 11 Dec
 2023 09:22:26 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-15-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-15-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Dec 2023 18:21:50 +0100
Message-ID: <CAJaqyWcH6V-KdZ+dKoJbAEXgfuHUKp29Gpwb_0WtqzqB-3h2pQ@mail.gmail.com>
Subject: Re: [PATCH 14/40] vdpa: convert iova_tree to ref count based
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Dec 7, 2023 at 7:50=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> So that it can be freed from vhost_vdpa_cleanup on
> the last deref. The next few patches will try to
> make iova tree life cycle not depend on memory
> listener, and there's possiblity to keep iova tree
> around when memory mapping is not changed across
> device reset.
>

Title and commit description does not match with the patch, I guess it
is because the reference count was at iova_tree some time in the past
but you decided to move to VhostVDPAShared.

But this code should be merged with previous patches, because we have
an asymmetry here and some bug will arise if the guest reset the
device: allocating at device start, but freeing at cleanup instead of
stop.

> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  net/vhost-vdpa.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index a126e5c..7b8f047 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -238,6 +238,8 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
>      }
>      if (--s->vhost_vdpa.shared->refcnt =3D=3D 0) {
>          qemu_close(s->vhost_vdpa.shared->device_fd);
> +        g_clear_pointer(&s->vhost_vdpa.shared->iova_tree,
> +                        vhost_iova_tree_delete);
>          g_free(s->vhost_vdpa.shared);
>      }
>      s->vhost_vdpa.shared =3D NULL;
> @@ -461,19 +463,12 @@ static int vhost_vdpa_net_data_load(NetClientState =
*nc)
>  static void vhost_vdpa_net_client_stop(NetClientState *nc)
>  {
>      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> -    struct vhost_dev *dev;
>
>      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
>
>      if (s->vhost_vdpa.index =3D=3D 0) {
>          migration_remove_notifier(&s->migration_state);
>      }
> -
> -    dev =3D s->vhost_vdpa.dev;
> -    if (dev->vq_index + dev->nvqs =3D=3D dev->vq_index_end) {
> -        g_clear_pointer(&s->vhost_vdpa.shared->iova_tree,
> -                        vhost_iova_tree_delete);
> -    }
>  }
>
>  static int vhost_vdpa_net_load_setup(NetClientState *nc, NICState *nic)
> --
> 1.8.3.1
>



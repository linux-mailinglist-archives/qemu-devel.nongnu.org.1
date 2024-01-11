Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F7882A8D8
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 09:16:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNqDu-0004lu-IV; Thu, 11 Jan 2024 03:15:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNqDm-0004iw-Ea
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:15:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNqDk-0007cz-Kc
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704960923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3AH2KQFqmkMHh57+I3YSsN9U+Y4+PrBU45llohfhEQU=;
 b=OBr4KTTvECFRL9Y74lLQEHduf72oYH6CKgSzgjvNhx6oKhDDU0G81Rw7ZCrZ7CLOjjQr8C
 0lCFunkX9VsHmotDCvVzIOwT/2eKyZG9Cs9RfPIbWW6znlCz/zlSQ19LVjQ36M7KjFNHRB
 UfcXbFb6faJSNqxzT2xcaQpcrwmaJA0=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-gjw2jEx5NNyq3lITPq35SA-1; Thu, 11 Jan 2024 03:15:22 -0500
X-MC-Unique: gjw2jEx5NNyq3lITPq35SA-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6d9e845c0fbso3735774b3a.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 00:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704960921; x=1705565721;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3AH2KQFqmkMHh57+I3YSsN9U+Y4+PrBU45llohfhEQU=;
 b=W9L75zCYG/rJghWFmu2/7fwrjQA2Fq6bzoNOL6FcgY58dEC99EHstEYj+orehg73OT
 fqvgxpgsBJrRowiFCTcPqZmqNAXnEvzGyJeVKzeZ6vftdGeeEovM353g88EFXXgQId80
 yk9DR+7KkV4v13K6D3BADZwNxAwMrRjxgOcau0i4m5fs715sCxgKq4dpbzNwmx5tAoNJ
 cFrBR8+vpo7pNGeiSdN2s5p3m9AFifgtlrcbJAzBFvEXdeH3lK4lzEGW9B1tgACrT3T2
 dMArc2vFY4XbPrlBSFgNHWvm8FcLRzdi2p469WBN8Jp3zW2HkWnlcHby1yOcfNvW15hz
 Q0OQ==
X-Gm-Message-State: AOJu0Yw8CyO2Vtejro+ghZ++940gn3iPkeINflIkLN3dW42pX+n3ng2W
 R9P3T2jhjIzZ+0wi05RvK6D57UIJ0sPTh/dJI/yHGWrDJQDRZWAzs0/1KA8tqzm8lnhWBO5oJS7
 taAatbnEka81XdADamoTljWpyxvLFTYdfOGzrZdM=
X-Received: by 2002:a62:e815:0:b0:6d9:a00b:c357 with SMTP id
 c21-20020a62e815000000b006d9a00bc357mr730729pfi.31.1704960921363; 
 Thu, 11 Jan 2024 00:15:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMg9E3VHuJOLJeHHsZvjREv7paIsHE22cZ1F25D+TpJ21c9+QNUv63lZOOMRpBgATQZqL8s4CS3NnomnNAjGA=
X-Received: by 2002:a62:e815:0:b0:6d9:a00b:c357 with SMTP id
 c21-20020a62e815000000b006d9a00bc357mr730719pfi.31.1704960921101; Thu, 11 Jan
 2024 00:15:21 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-15-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-15-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 16:15:10 +0800
Message-ID: <CACGkMEsUscj3fgbv1SsPCC+XP4VDtqE9=Pi+NGC7aZSV4muA5w@mail.gmail.com>
Subject: Re: [PATCH 14/40] vdpa: convert iova_tree to ref count based
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Dec 8, 2023 at 2:50=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> So that it can be freed from vhost_vdpa_cleanup on
> the last deref. The next few patches will try to
> make iova tree life cycle not depend on memory
> listener, and there's possiblity to keep iova tree
> around when memory mapping is not changed across
> device reset.
>
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

Could be part of the put() as well.

Thanks

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



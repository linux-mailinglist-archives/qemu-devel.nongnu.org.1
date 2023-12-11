Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C73980CB2C
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 14:38:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCgTZ-0003SI-6Z; Mon, 11 Dec 2023 08:37:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCgTW-0003Rv-SB
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:37:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCgTV-0003LR-EU
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702301852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZSUJzBLknPFqzf+lk06I4KiQacjra2qsoWKIYTk6Yjs=;
 b=G3H/VO05SgUVbxRHVROqZyGi/01p603oWbUA9uQ701deEMKzVP5PTro8JTwV+buGePSMhe
 WtTyD2XwyhXspoAGfmx1bjRqrE0kEaTVnQPXRUdH3GUEiM5XPLo1HY10webLBWEehAq9U3
 Jpwu/nUbbrI9hM7R0Af4SQ/Gfk5ShkY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-eirIq5oIO9S8ixTctCZpOQ-1; Mon, 11 Dec 2023 08:37:31 -0500
X-MC-Unique: eirIq5oIO9S8ixTctCZpOQ-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-5d6b751dabcso38119757b3.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 05:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702301850; x=1702906650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZSUJzBLknPFqzf+lk06I4KiQacjra2qsoWKIYTk6Yjs=;
 b=hqIz1v1o0f6uI61Fb0VyN5SbxkBHkqfAc3EL0CmW/SOG0FoOn+ArMyv9D9IUNMT2iz
 cVO4rY19fBGxxaD4M4Uiwc7bcKq3djziDSNjL3c7oaDpTnqikjXZo//4YUuCTXV8t6JQ
 XBvvwp9Jm82ti9ib0Hs4J7A61AHN7j367KXIiR/vN74o16ICuINonB5kYFz28tHFylrW
 s7/k2aODbL1tIUQYVnGX0gLWni3IoPe2E3oH3L4Zibzt/Mj8kSY48YtiaL4PLCSI1m/c
 MOlW3V2sBITaSrnP2Wq8U0Vm8xhm02IykLMhwA5BBx4crL2gkoolDoNOGo3bxoMG715F
 duWw==
X-Gm-Message-State: AOJu0Yw2VwiI6LZY4KKwvXA1x1D4zFJp0uDbFZuHtw3/GFYXu52jTxiG
 IU9nA1U3KicSgqkFmvy9CWyjz1A5QwnS5a1dfoc1lTkEVSOWZXZbivXyBTrS7qwCJmOLUG1D9yN
 hLbNhjTe4d6dWDOd5cb1kbHpN4Ju9Klw=
X-Received: by 2002:a05:6902:1a4a:b0:db8:145f:8282 with SMTP id
 cy10-20020a0569021a4a00b00db8145f8282mr1731847ybb.32.1702301850508; 
 Mon, 11 Dec 2023 05:37:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYzchfKVlb22hW8OJHd4NfHe8NlysjJ3SWDEfTYAF3XsY0x2alalqkvyzNG1KnOgpgzF4p5QCkRQszdMdO5zk=
X-Received: by 2002:a05:6902:1a4a:b0:db8:145f:8282 with SMTP id
 cy10-20020a0569021a4a00b00db8145f8282mr1731838ybb.32.1702301850258; Mon, 11
 Dec 2023 05:37:30 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-12-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-12-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Dec 2023 14:36:54 +0100
Message-ID: <CAJaqyWeY+jMMY6YgsH__ZSk3owg7qWGY1r89yJgXZkgUEPGsnQ@mail.gmail.com>
Subject: Re: [PATCH 11/40] vdpa: factor out vhost_vdpa_last_dev
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

On Thu, Dec 7, 2023 at 7:50=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Generalize duplicated condition check for the last vq of vdpa
> device to a common function.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

We can also send this separately,

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  hw/virtio/vhost-vdpa.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 30dff95..2b1cc14 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -593,6 +593,11 @@ static bool vhost_vdpa_first_dev(struct vhost_dev *d=
ev)
>      return v->index =3D=3D 0;
>  }
>
> +static bool vhost_vdpa_last_dev(struct vhost_dev *dev)
> +{
> +    return dev->vq_index + dev->nvqs =3D=3D dev->vq_index_end;
> +}
> +
>  static int vhost_vdpa_get_dev_features(struct vhost_dev *dev,
>                                         uint64_t *features)
>  {
> @@ -1432,7 +1437,7 @@ static int vhost_vdpa_dev_start(struct vhost_dev *d=
ev, bool started)
>          goto out_stop;
>      }
>
> -    if (dev->vq_index + dev->nvqs !=3D dev->vq_index_end) {
> +    if (!vhost_vdpa_last_dev(dev)) {
>          return 0;
>      }
>
> @@ -1467,7 +1472,7 @@ static void vhost_vdpa_reset_status(struct vhost_de=
v *dev)
>  {
>      struct vhost_vdpa *v =3D dev->opaque;
>
> -    if (dev->vq_index + dev->nvqs !=3D dev->vq_index_end) {
> +    if (!vhost_vdpa_last_dev(dev)) {
>          return;
>      }
>
> --
> 1.8.3.1
>



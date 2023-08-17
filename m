Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C03B77F459
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 12:34:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWaKE-0004F4-KQ; Thu, 17 Aug 2023 06:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qWaKB-0004El-Ft
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 06:33:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qWaK9-0002Qz-Dh
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 06:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692268432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JwSPQfjbrrlfHIe3A1IjoPmHcc8ZolPlh9NkqpMgNQk=;
 b=OVbO85BHrKrBGLi4X5Ve798ZHzNKCik67nPnYFo57l4MCTDMTOC7FyPb9RkV9J/d6w1K8u
 3vXHC+HhiRRQpZpQsjmXGyo8ikoLUbVNpQ0LCvfQhOayXZJTE4Qk771xJP/YE0VOOZK4ym
 Vintp9++XRk6aiMnf3bkNMwymx2tgLQ=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-hFxwqHg6PweKHjlXgieMyQ-1; Thu, 17 Aug 2023 06:33:51 -0400
X-MC-Unique: hFxwqHg6PweKHjlXgieMyQ-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-d71f505d21dso1407705276.3
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 03:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692268431; x=1692873231;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JwSPQfjbrrlfHIe3A1IjoPmHcc8ZolPlh9NkqpMgNQk=;
 b=LplJMhDyA099Ay3ZulkEr6kTjvcwnpnrsylcd1kz01nPQqurpr87ltFDIArE3hgMt0
 PcwvSR8mHkz2xGsJiSjYrI2fTa8l4Omgei5DKRbwaYL5oY6k2T2TmcUZ8HDoXR/ZWUwm
 NpHLgR/DZ1hX3YSsdlF/SrdvkRAsWxbGyb3SVJ5ApzGk7wb+iU2PEb/fQpwSHJL0iE18
 D99nYeMvusU8iIg0HbxOBShVJhOHTrRN90vrrrDN2i894M/5bJEFAYrGjt7O261zXVsl
 afpbLgK1Z97ZblbGu29UUwH/YSmCQp6QQF7x88s9YImoG4DVmDzae5x2OWE4rC7kKskp
 7rjQ==
X-Gm-Message-State: AOJu0YweVjgoKPBdU3tFPCT3yGNHD0GwemNwl5d6U/Q2s1sgGihdlVOs
 i1Qwal5vzi+Yzb19GwCnuZUEYgum+2Gr+ZgrO+bBZilIw/M/9xlNpOVAh704wTlRkhr7kW5AyIj
 waM0MT6uJ5bJErQ3FTKRKv3npgIux2gI=
X-Received: by 2002:a25:8912:0:b0:d05:f537:da99 with SMTP id
 e18-20020a258912000000b00d05f537da99mr3829548ybl.46.1692268430881; 
 Thu, 17 Aug 2023 03:33:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKFGNxDk4By05fh2D71sGI6xDx2m8ri7s/vDg92PvAEa24BIMXtQIjxWI3N8MqT45j0yE/HLq5wwK/J9zefZA=
X-Received: by 2002:a25:8912:0:b0:d05:f537:da99 with SMTP id
 e18-20020a258912000000b00d05f537da99mr3829537ybl.46.1692268430640; Thu, 17
 Aug 2023 03:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688743107.git.yin31149@gmail.com>
 <cd522e06a4371e9d6b8a1c1a86f90a92401d56e8.1688743107.git.yin31149@gmail.com>
In-Reply-To: <cd522e06a4371e9d6b8a1c1a86f90a92401d56e8.1688743107.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 17 Aug 2023 12:33:14 +0200
Message-ID: <CAJaqyWcO7D3m+R-qsCk+Lcw7YtA9BE6O1zoG_QpPJgJy8YCcfg@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] vdpa: Accessing CVQ header through its structure
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
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

On Fri, Jul 7, 2023 at 5:27=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com> =
wrote:
>
> We can access the CVQ header through `struct virtio_net_ctrl_hdr`,
> instead of accessing it through a `uint8_t` pointer,
> which improves the code's readability and maintainability.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  net/vhost-vdpa.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index e80d4b4ef3..a84eb088a0 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -928,6 +928,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShad=
owVirtqueue *svq,
>  {
>      VhostVDPAState *s =3D opaque;
>      size_t in_len;
> +    const struct virtio_net_ctrl_hdr *ctrl;
>      virtio_net_ctrl_ack status =3D VIRTIO_NET_ERR;
>      /* Out buffer sent to both the vdpa device and the device model */
>      struct iovec out =3D {
> @@ -943,7 +944,9 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShad=
owVirtqueue *svq,
>      out.iov_len =3D iov_to_buf(elem->out_sg, elem->out_num, 0,
>                               s->cvq_cmd_out_buffer,
>                               vhost_vdpa_net_cvq_cmd_len());
> -    if (*(uint8_t *)s->cvq_cmd_out_buffer =3D=3D VIRTIO_NET_CTRL_ANNOUNC=
E) {
> +
> +    ctrl =3D s->cvq_cmd_out_buffer;
> +    if (ctrl->class =3D=3D VIRTIO_NET_CTRL_ANNOUNCE) {
>          /*
>           * Guest announce capability is emulated by qemu, so don't forwa=
rd to
>           * the device.
> --
> 2.25.1
>



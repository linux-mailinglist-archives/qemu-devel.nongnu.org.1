Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE106780F67
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:40:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX1aS-0008OM-29; Fri, 18 Aug 2023 11:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qX1aO-0008Nm-Fz
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qX1aM-0007Io-7x
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692373224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yGAv3BnJOM1ifrNjN5trOHlOIRKW3ApzJzX9kVxcGuQ=;
 b=ik2QzzywXVyJVwY8pvBc999gYfMwVqfdzStAXmlSFu0KXN29uHb8fvp8E5apJslbs3OVym
 rSBdAG0WV4cJfz20TETlq+za51JrxSd0eg0NeNcKzQtt/CjBt+e38j8KekT4P5XIU7n1+l
 SAE41jlUwU6Gtt452dhkSJrZlu3D9Xc=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-7GDc7jfQOKOQIgfoA1nTuA-1; Fri, 18 Aug 2023 11:40:23 -0400
X-MC-Unique: 7GDc7jfQOKOQIgfoA1nTuA-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-d6412374defso1211539276.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 08:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692373222; x=1692978022;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yGAv3BnJOM1ifrNjN5trOHlOIRKW3ApzJzX9kVxcGuQ=;
 b=gayPqBLXK9YGryZ7I7VXR9s/rFLnjA9iLkDTp4v83WbSuGxx7QTm7A2DW+UywHo3Fd
 zi6a/KI5IXbciknn13rMd612PMl6d/Cq/9A8phLzn4a2JqKbVZdKrJfBGA9t7LMNeZQF
 7M2WUgTS0EJSDA7NDdsTrgKi1kSmjwCwfhU9iNNtP4AIGWTLH1UZBBl/BdW1MIMC/L+a
 KjuI3PhsoV2V/6TLkL4aKSnjXqdE7A5QgMGEFzeDVtb0cVwXLwUR0/7P9tmmjCzbAt7R
 W1ZwQqxlp7PAZvhIxstbNc53NRZtRSsh1S6gCBnbVCwKqyb3672w+OdFiJR+2s9/WJTd
 uHkQ==
X-Gm-Message-State: AOJu0YxEuUKiILFEwpRDYeA8H4lejpg0HoK4kNQnd8zQ5uU6Ls9lyPLA
 M4alE5fuzQkIB1dIF2YT0LEXNzJ40YUHAGrIHX+D5pFznasArGhFefH7ObNz4yKhKPbarFvcgfu
 vOfPKzk1PR1/JIuok15Dy1O8d/wy7ii4=
X-Received: by 2002:a25:da57:0:b0:d62:9b77:a41a with SMTP id
 n84-20020a25da57000000b00d629b77a41amr3112219ybf.31.1692373222693; 
 Fri, 18 Aug 2023 08:40:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs1pAbT40s33hnEIg0kcocBPoNshs8NkXPL9A/otZ7lDoBxtZOh0Z+amM5Qt4HBH3y0WiMl072OlrlDjMOg88=
X-Received: by 2002:a25:da57:0:b0:d62:9b77:a41a with SMTP id
 n84-20020a25da57000000b00d629b77a41amr3112207ybf.31.1692373222461; Fri, 18
 Aug 2023 08:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689748694.git.yin31149@gmail.com>
 <428a8fac2a29b37757fa15ca747be93c0226cb1f.1689748694.git.yin31149@gmail.com>
In-Reply-To: <428a8fac2a29b37757fa15ca747be93c0226cb1f.1689748694.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 18 Aug 2023 17:39:46 +0200
Message-ID: <CAJaqyWe42ykMaiwkdCOWXmtwD=p9F7gCj_TKypwOOU+yjYSdtg@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] vdpa: Avoid using vhost_vdpa_net_load_*() outside
 vhost_vdpa_net_load()
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

On Wed, Jul 19, 2023 at 9:54=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> Next patches in this series will refactor vhost_vdpa_net_load_cmd()
> to iterate through the control commands shadow buffers, allowing QEMU
> to send CVQ state load commands in parallel at device startup.
>
> Considering that QEMU always forwards the CVQ command serialized
> outside of vhost_vdpa_net_load(), it is more elegant to send the
> CVQ commands directly without invoking vhost_vdpa_net_load_*() helpers.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>  net/vhost-vdpa.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index dd71008e08..ae8f59adaa 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1098,12 +1098,14 @@ static NetClientInfo net_vhost_vdpa_cvq_info =3D =
{
>   */
>  static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState *s=
,
>                                                         VirtQueueElement =
*elem,
> -                                                       struct iovec *out=
)
> +                                                       struct iovec *out=
,
> +                                                       struct iovec *in)
>  {
>      struct virtio_net_ctrl_mac mac_data, *mac_ptr;
>      struct virtio_net_ctrl_hdr *hdr_ptr;
>      uint32_t cursor;
>      ssize_t r;
> +    uint8_t on =3D 1;
>
>      /* parse the non-multicast MAC address entries from CVQ command */
>      cursor =3D sizeof(*hdr_ptr);
> @@ -1151,7 +1153,16 @@ static int vhost_vdpa_net_excessive_mac_filter_cvq=
_add(VhostVDPAState *s,
>       * filter table to the vdpa device, it should send the
>       * VIRTIO_NET_CTRL_RX_PROMISC CVQ command to enable promiscuous mode
>       */
> -    r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC, 1);
> +    cursor =3D 0;
> +    hdr_ptr =3D out->iov_base;
> +    out->iov_len =3D sizeof(*hdr_ptr) + sizeof(on);
> +    assert(out->iov_len < vhost_vdpa_net_cvq_cmd_page_len());
> +
> +    hdr_ptr->class =3D VIRTIO_NET_CTRL_RX;
> +    hdr_ptr->cmd =3D VIRTIO_NET_CTRL_RX_PROMISC;
> +    cursor +=3D sizeof(*hdr_ptr);
> +    *(uint8_t *)(out->iov_base + cursor) =3D on;
> +    r =3D vhost_vdpa_net_cvq_add(s, out, 1, in, 1);

Can this be done with iov_from_buf?

>      if (unlikely(r < 0)) {
>          return r;
>      }
> @@ -1264,7 +1275,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostSh=
adowVirtqueue *svq,
>           * the CVQ command direclty.
>           */
>          dev_written =3D vhost_vdpa_net_excessive_mac_filter_cvq_add(s, e=
lem,
> -                                                                  &out);
> +                                                                  &out, =
&in);
>          if (unlikely(dev_written < 0)) {
>              goto out;
>          }
> --
> 2.25.1
>



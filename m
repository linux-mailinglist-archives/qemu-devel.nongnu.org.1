Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CEF77F328
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 11:25:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWZF6-00051B-67; Thu, 17 Aug 2023 05:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qWZEs-00050r-7k
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 05:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qWZEo-0006Uk-Gx
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 05:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692264257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dPTc4oLD58fX9luk2IenOom3i7NVb4+j9MkaWlUQ64=;
 b=gWw37p+aECoTV/RReYQYVFq0MUbeNJ02nAfKMhs2qmwoNjKyGcm9bLhJ8VCPAq72xfnIAh
 i0BNy2u29x8mykhbBo80jwvsk5DJS91be/5unLQpjB5iFyBJj17Xrw3dSVHwihMDXTfS36
 tquMvVDtCr0gxSHzRmxYEOKQtUCxigE=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-9KhUiGNCPM2KT4f9x_rCSg-1; Thu, 17 Aug 2023 05:24:15 -0400
X-MC-Unique: 9KhUiGNCPM2KT4f9x_rCSg-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-d6b66b41232so3935715276.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 02:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692264254; x=1692869054;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2dPTc4oLD58fX9luk2IenOom3i7NVb4+j9MkaWlUQ64=;
 b=h5NYK1JiKZH03pdErj2GplfeEyTvw4Wo9ny0b2LVUuf4mcykxxtfDnAuQVPsyOUFZh
 N6F0n19nt7h+R5Ms+WNwSGa6tpyhFuzpNwxQ+/JOrhhKFEOjt1eLkCz/ZS3EbqYd/7d5
 j28VU2M8MVK7v+eTIGOHkPH133k1ynpCgAb3KiXTIauXAjyPjPP/vrve+BNVf8SiRjAF
 xOizgftUZFoRESqbpoUgyATgp+o/P0VqCRFBjYp0ny2qkDgaL3Hf9wSaK0A7g1RocYmL
 l/wXXnI/NhF1w6DUJHOYKRmULYAPWi7k17Jb6FGpKmh0PbBcf8HTDfflg9NI108ZlOmo
 fEdw==
X-Gm-Message-State: AOJu0Yx/Z3HUCTiFHn55u1cwk/VyhK4Vh3Uu+FsabLdcA0I74yEpas+J
 OKTZNF0DeM3iZfXUmZSmsV57QF40yu3ghmesLitV5hVwQsc1lrEJLS52yi9JO5z/RrElJheW/Yp
 m67HUV5TGQ3hQOZW/fUPrZfK8ePEbs1E=
X-Received: by 2002:a25:457:0:b0:d0a:fbef:1590 with SMTP id
 84-20020a250457000000b00d0afbef1590mr4024460ybe.37.1692264254727; 
 Thu, 17 Aug 2023 02:24:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFG7DPVN+d+Y1mne/PNt/UstE/ggO9Bl79ngDc8pxd4P4GriqxiGB3VuXrSuirQ8Z+RtjdSW4OJGXk8juf3WA=
X-Received: by 2002:a25:457:0:b0:d0a:fbef:1590 with SMTP id
 84-20020a250457000000b00d0afbef1590mr4024443ybe.37.1692264254421; Thu, 17 Aug
 2023 02:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688743107.git.yin31149@gmail.com>
 <3482cc50eebd13db4140b8b5dec9d0cc25b20b1b.1688743107.git.yin31149@gmail.com>
In-Reply-To: <3482cc50eebd13db4140b8b5dec9d0cc25b20b1b.1688743107.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 17 Aug 2023 11:23:38 +0200
Message-ID: <CAJaqyWeZxv6Lf8QEAmw_Ge_BGbPJdDvsGNnze4uavqXhPZQChQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] vdpa: Use iovec for vhost_vdpa_net_load_cmd()
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
> According to VirtIO standard, "The driver MUST follow
> the VIRTIO_NET_CTRL_MAC_TABLE_SET command by a le32 number,
> followed by that number of non-multicast MAC addresses,
> followed by another le32 number, followed by that number
> of multicast addresses."
>
> Considering that these data is not stored in contiguous memory,
> this patch refactors vhost_vdpa_net_load_cmd() to accept
> scattered data, eliminating the need for an addtional data copy or
> packing the data into s->cvq_cmd_out_buffer outside of
> vhost_vdpa_net_load_cmd().
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
> v3:
>   - rename argument name to `data_sg` and `data_num`
>   - use iov_to_buf() suggested by Eugenio
>
> v2: https://lore.kernel.org/all/6d3dc0fc076564a03501e222ef1102a6a7a643af.=
1688051252.git.yin31149@gmail.com/
>   - refactor vhost_vdpa_load_cmd() to accept iovec suggested by
> Eugenio
>
>  net/vhost-vdpa.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 373609216f..31ef6ad6ec 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -620,29 +620,38 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAStat=
e *s, size_t out_len,
>  }
>
>  static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
> -                                       uint8_t cmd, const void *data,
> -                                       size_t data_size)
> +                                       uint8_t cmd, const struct iovec *=
data_sg,
> +                                       size_t data_num)
>  {
>      const struct virtio_net_ctrl_hdr ctrl =3D {
>          .class =3D class,
>          .cmd =3D cmd,
>      };
> +    size_t data_size =3D iov_size(data_sg, data_num);
>
>      assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl))=
;
>
> +    /* pack the CVQ command header */
>      memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
> -    memcpy(s->cvq_cmd_out_buffer + sizeof(ctrl), data, data_size);
>
> -    return vhost_vdpa_net_cvq_add(s, sizeof(ctrl) + data_size,
> +    /* pack the CVQ command command-specific-data */
> +    iov_to_buf(data_sg, data_num, 0,
> +               s->cvq_cmd_out_buffer + sizeof(ctrl), data_size);
> +
> +    return vhost_vdpa_net_cvq_add(s, data_size + sizeof(ctrl),

Nit, any reason for changing the order of the addends? sizeof(ctrl) +
data_size ?

>                                    sizeof(virtio_net_ctrl_ack));
>  }
>
>  static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n=
)
>  {
>      if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_MAC_AD=
DR)) {
> +        const struct iovec data =3D {
> +            .iov_base =3D (void *)n->mac,

Assign to void should always be valid, no need for casting here.

> +            .iov_len =3D sizeof(n->mac),
> +        };
>          ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CT=
RL_MAC,
>                                                    VIRTIO_NET_CTRL_MAC_AD=
DR_SET,
> -                                                  n->mac, sizeof(n->mac)=
);
> +                                                  &data, 1);
>          if (unlikely(dev_written < 0)) {
>              return dev_written;
>          }
> @@ -665,9 +674,13 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>      }
>
>      mq.virtqueue_pairs =3D cpu_to_le16(n->curr_queue_pairs);
> +    const struct iovec data =3D {
> +        .iov_base =3D &mq,
> +        .iov_len =3D sizeof(mq),
> +    };
>      dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_MQ,
> -                                          VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SE=
T, &mq,
> -                                          sizeof(mq));
> +                                          VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SE=
T,
> +                                          &data, 1);
>      if (unlikely(dev_written < 0)) {
>          return dev_written;
>      }
> @@ -706,9 +719,13 @@ static int vhost_vdpa_net_load_offloads(VhostVDPASta=
te *s,
>      }
>
>      offloads =3D cpu_to_le64(n->curr_guest_offloads);
> +    const struct iovec data =3D {
> +        .iov_base =3D &offloads,
> +        .iov_len =3D sizeof(offloads),
> +    };
>      dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_GUEST_OFF=
LOADS,
>                                            VIRTIO_NET_CTRL_GUEST_OFFLOADS=
_SET,
> -                                          &offloads, sizeof(offloads));
> +                                          &data, 1);
>      if (unlikely(dev_written < 0)) {
>          return dev_written;
>      }

Apart from that:

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!



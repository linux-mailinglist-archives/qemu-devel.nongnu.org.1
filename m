Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8DF7473F5
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:20:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGgrY-0008PZ-P2; Tue, 04 Jul 2023 10:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qGgrW-0008PQ-Js
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:18:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qGgrU-0004JD-2h
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688480314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JL/YJUoZofwGSaSAsZ7jDVOURJDFziH5dyjrWMG6IQw=;
 b=cf+4CKjg/Sv+2i3EbdhhvCi3H8zwqI/3Mnzeb2nuXaMlxGOP2aQ+fszCG8ydlsIn4Vlvd7
 jkPLK3R3bUr9pq52dCW4icvC1Oryg2xuGE0Ks93EAAV0JU49klimDomW3fbjvshja6WxJY
 c8VkZIL0vLrFb0+b3RDPNB23Z6/DMQo=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-NKpxUdpeMS2nCLf3wv459w-1; Tue, 04 Jul 2023 10:18:33 -0400
X-MC-Unique: NKpxUdpeMS2nCLf3wv459w-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-bfe702f99b8so5894832276.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688480313; x=1691072313;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JL/YJUoZofwGSaSAsZ7jDVOURJDFziH5dyjrWMG6IQw=;
 b=J2QJGO1OaVjYR/nijU3AQ39WSVTUhaGNIqypOeevU1p8kBJ0X8cp48Xxw4NXCd2/vI
 mq+FarDklfcUvClb14tTN8OT5nYgvYX2ugI9JeZYRiNvv94URfaxM8vHkqH3hu+STaMO
 wdGHhPpRcnzEWpaOrQ5UxLLF9o7JYfGV9nqEjbAyBopZsOgs7FNAOoTZIFf4BySxHdG0
 cNAVnMIAY4mJdl6bfzG0fIU3YQFoFEJr9LYp/8mmhg1Q+yQjx5S5zXe2iqKFvQWshZdU
 NfgqHNpw9MOEeCcvslYKWIX/7dG6Cc1vpe4gRs/ehsfu3KxtERQ6fvf9bk7LfWFpUJSE
 bF0Q==
X-Gm-Message-State: ABy/qLbOfB4de3Ycsbfr6ZDuZ+pxwsLIIZMbbhvFxegOpdnu5/vXU+Vr
 kUzcbLiJmvypS1dHiTnCmQWlnOhRODrSh/Za0mgcFHK0MQz4N32MAdtAVhCWNDBjJWrKvEWPOay
 dfmjtB3lsBmJVUIaoNiLOKEaOlQacEl1OijDadMI6qg==
X-Received: by 2002:a25:a287:0:b0:c1a:2928:74ab with SMTP id
 c7-20020a25a287000000b00c1a292874abmr11605722ybi.31.1688480312791; 
 Tue, 04 Jul 2023 07:18:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFhhEjAvRF1j4yAAgUNx42zYTzb6Nuy9nQWVPyRDXra/CMfM/nN9ou8XEwJlOVrDg0w2q8Vx/wAd42CZNr4Zyo=
X-Received: by 2002:a25:a287:0:b0:c1a:2928:74ab with SMTP id
 c7-20020a25a287000000b00c1a292874abmr11605708ybi.31.1688480312507; Tue, 04
 Jul 2023 07:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688051252.git.yin31149@gmail.com>
 <6d3dc0fc076564a03501e222ef1102a6a7a643af.1688051252.git.yin31149@gmail.com>
In-Reply-To: <6d3dc0fc076564a03501e222ef1102a6a7a643af.1688051252.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 4 Jul 2023 16:17:56 +0200
Message-ID: <CAJaqyWc2OXN9dnTV3Fmsu6=WErgxNbZ4sZ3Fxkyb18uXXJSB=A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/4] vdpa: Use iovec for vhost_vdpa_net_load_cmd()
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Thu, Jun 29, 2023 at 5:25=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com>=
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
> v2:
>   - refactor vhost_vdpa_load_cmd() to accept iovec suggested by
> Eugenio
>
>  net/vhost-vdpa.c | 42 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 10 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 6f6a5c6df6..0bd1c7817c 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -620,29 +620,43 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAStat=
e *s, size_t out_len,
>  }
>
>  static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
> -                                       uint8_t cmd, const void *data,
> -                                       size_t data_size)
> +                                       uint8_t cmd, const struct iovec *=
data,
> +                                       size_t data_len)
>  {
>      const struct virtio_net_ctrl_hdr ctrl =3D {
>          .class =3D class,
>          .cmd =3D cmd,
>      };
> +    void *cursor =3D s->cvq_cmd_out_buffer;
>
> -    assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl))=
;
> +    /* pack the CVQ command header */
> +    assert(sizeof(ctrl) < vhost_vdpa_net_cvq_cmd_page_len() -
> +                          (cursor - s->cvq_cmd_out_buffer));
> +    memcpy(cursor, &ctrl, sizeof(ctrl));
> +    cursor +=3D sizeof(ctrl);
>
> -    memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
> -    memcpy(s->cvq_cmd_out_buffer + sizeof(ctrl), data, data_size);
> +    /* pack the CVQ command command-specific-data */
> +    for (int i =3D 0; i < data_len; ++i) {
> +        assert(data[i].iov_len < vhost_vdpa_net_cvq_cmd_page_len() -
> +                                 (cursor - s->cvq_cmd_out_buffer));
> +        memcpy(cursor, data[i].iov_base, data[i].iov_len);
> +        cursor +=3D data[i].iov_len;
> +    }

Can we replace all of the above by iov_to_buf?

>
> -    return vhost_vdpa_net_cvq_add(s, sizeof(ctrl) + data_size,
> +    return vhost_vdpa_net_cvq_add(s, cursor - s->cvq_cmd_out_buffer,
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
> @@ -665,9 +679,13 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
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
> @@ -706,9 +724,13 @@ static int vhost_vdpa_net_load_offloads(VhostVDPASta=
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
> --
> 2.25.1
>



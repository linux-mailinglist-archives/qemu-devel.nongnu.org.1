Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D76A67B78D1
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 09:35:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwOX-00068M-EG; Wed, 04 Oct 2023 03:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qnwOV-00065r-AU
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qnwOS-0004Es-Rm
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696404843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6afriAIYFf2D4KsGakkmV7GcA4HGH/FO1QjI70OKrXk=;
 b=As8BzV4sguLxf+B6qWpXPdOOCbi6p+Mt01dLs5f7xv2qz+Pmzqtq73d16v7mfiQkHjouya
 /BR/2oID8JamkRMr+Ssj55yAn3+g4slbnh1K7Dpr9vCHgNTAbjbxWjnr2xYMV7862zCMaW
 QuTrO5We7K4due87wMMvh41lDn88RC4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-YBgHzhv2Mc-JakK5SWlSEg-1; Wed, 04 Oct 2023 03:33:51 -0400
X-MC-Unique: YBgHzhv2Mc-JakK5SWlSEg-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-5a21c283542so27098127b3.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 00:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696404831; x=1697009631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6afriAIYFf2D4KsGakkmV7GcA4HGH/FO1QjI70OKrXk=;
 b=qP1uks1NgQUl8wqEv33ILSQogzoiO39ya04NLgKUBkh6nYHu4f+4ybmEY51Tus0bWo
 wrj3WjFogL1pn0iKREbCBYrjBFxXKzGb5d95BIEfI4uCB/gz495Kdvh9pvl3Oz3blH2K
 6Wavd7a1XMHV2F4fz4TCiyKCBsMzEvREXQSK0yLirpit4zQXNLktnddM+YvnLhpfRkkE
 vXJo62o0mg0qqQSBm4+CPeJwb8/oeTIM/P9sc4z5AcV6yr+/Ud50Bs6Pf9VVakm4I7o1
 zoqcjPvdQd2YeWaQzOVu1Cz2YZhgFS4DrgJ5LcOxDMZjArcTZbiv/DLnnsHRbfPHzZHI
 ZEUg==
X-Gm-Message-State: AOJu0YzE0Ctuxvc9XUmCvk8jmrkeKebi0MFTFtLTAqy3fqExVkBed+WW
 7CGRYXaCeH7lVVCVvhHsLJMBVQeHUNt6KIsICj4ib1V09e5500ENJlEFcg2CxJvCecaKj69829t
 ZWkc+cDoqd123FiVXzfZqALv6nSUcoMo=
X-Received: by 2002:a81:6d17:0:b0:5a1:d398:ff7a with SMTP id
 i23-20020a816d17000000b005a1d398ff7amr1693812ywc.13.1696404831080; 
 Wed, 04 Oct 2023 00:33:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExWxy0BEmt72f41BI27y5IGPU8u4WWolh7Fc7sMSfj2+E3nO6e6pwQbdjAUQzQbEfHzzhBccD/U8GrhHfOgis=
X-Received: by 2002:a81:6d17:0:b0:5a1:d398:ff7a with SMTP id
 i23-20020a816d17000000b005a1d398ff7amr1693794ywc.13.1696404830664; Wed, 04
 Oct 2023 00:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693287885.git.yin31149@gmail.com>
 <f25fea0b0aed78bad2dd5744a4cc5538243672e6.1693287885.git.yin31149@gmail.com>
In-Reply-To: <f25fea0b0aed78bad2dd5744a4cc5538243672e6.1693287885.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 4 Oct 2023 09:33:14 +0200
Message-ID: <CAJaqyWdHkenU+VVZbnBP3Duuj3CLKL7x0ahb-pBrdfJ+Ydro5g@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] vdpa: Send cvq state load commands in parallel
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 leiyang@redhat.com, 18801353760@163.com
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

On Tue, Aug 29, 2023 at 7:55=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> This patch enables sending CVQ state load commands
> in parallel at device startup by following steps:
>
>   * Refactor vhost_vdpa_net_load_cmd() to iterate through
> the control commands shadow buffers. This allows different
> CVQ state load commands to use their own unique buffers.
>
>   * Delay the polling and checking of buffers until either
> the SVQ is full or control commands shadow buffers are full.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1578
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
> v4:
>   - refactor argument `cmds_in_flight` to `len` for
> vhost_vdpa_net_svq_full()
>   - check the return value of vhost_vdpa_net_svq_poll()
> in vhost_vdpa_net_svq_flush() suggested by Eugenio
>   - use iov_size(), vhost_vdpa_net_load_cursor_reset()
> and iov_discard_front() to update the cursors instead of
> accessing it directly according to Eugenio
>
> v3: https://lore.kernel.org/all/3a002790e6c880af928c6470ecbf03e7c65a68bb.=
1689748694.git.yin31149@gmail.com/
>
>  net/vhost-vdpa.c | 155 +++++++++++++++++++++++++++++------------------
>  1 file changed, 97 insertions(+), 58 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index a71e8c9090..818464b702 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -646,6 +646,31 @@ static void vhost_vdpa_net_load_cursor_reset(VhostVD=
PAState *s,
>      in_cursor->iov_len =3D vhost_vdpa_net_cvq_cmd_page_len();
>  }
>
> +/*
> + * Poll SVQ for multiple pending control commands and check the device's=
 ack.
> + *
> + * Caller should hold the BQL when invoking this function.
> + *
> + * @s: The VhostVDPAState
> + * @len: The length of the pending status shadow buffer
> + */
> +static ssize_t vhost_vdpa_net_svq_flush(VhostVDPAState *s, size_t len)
> +{
> +    /* Device uses a one-byte length ack for each control command */
> +    ssize_t dev_written =3D vhost_vdpa_net_svq_poll(s, len);
> +    if (unlikely(dev_written !=3D len)) {
> +        return -EIO;
> +    }
> +
> +    /* check the device's ack */
> +    for (int i =3D 0; i < len; ++i) {
> +        if (s->status[i] !=3D VIRTIO_NET_OK) {
> +            return -EIO;
> +        }
> +    }
> +    return 0;
> +}
> +
>  static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s,
>                                         struct iovec *out_cursor,
>                                         struct iovec *in_cursor, uint8_t =
class,
> @@ -660,10 +685,30 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPASta=
te *s,
>             cmd_size =3D sizeof(ctrl) + data_size;
>      struct iovec out, in;
>      ssize_t r;
> +    unsigned dummy_cursor_iov_cnt;
>
>      assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl))=
;
> +    if (vhost_vdpa_net_svq_available_slots(s) < 2 ||
> +        iov_size(out_cursor, 1) < cmd_size) {
> +        /*
> +         * It is time to flush all pending control commands if SVQ is fu=
ll
> +         * or control commands shadow buffers are full.
> +         *
> +         * We can poll here since we've had BQL from the time
> +         * we sent the descriptor.
> +         */
> +        r =3D vhost_vdpa_net_svq_flush(s, in_cursor->iov_base -
> +                                     (void *)s->status);
> +        if (unlikely(r < 0)) {
> +            return r;
> +        }
> +
> +        vhost_vdpa_net_load_cursor_reset(s, out_cursor, in_cursor);
> +    }
> +

It would be great to merge this flush with the one at
vhost_vdpa_net_load. We would need to return ENOSPC or similar and
handle it there.

But it would make it more difficult to iterate through the loading of
the different parameters, so I think it can be done on top.

>      /* Each CVQ command has one out descriptor and one in descriptor */
>      assert(vhost_vdpa_net_svq_available_slots(s) >=3D 2);
> +    assert(iov_size(out_cursor, 1) >=3D cmd_size);
>

Same here, I think we can avoid the assertion, right?

Apart from that,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

>      /* Prepare the buffer for out descriptor for the device */
>      iov_copy(&out, 1, out_cursor, 1, 0, cmd_size);
> @@ -681,11 +726,13 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPASta=
te *s,
>          return r;
>      }
>
> -    /*
> -     * We can poll here since we've had BQL from the time
> -     * we sent the descriptor.
> -     */
> -    return vhost_vdpa_net_svq_poll(s, 1);
> +    /* iterate the cursors */
> +    dummy_cursor_iov_cnt =3D 1;
> +    iov_discard_front(&out_cursor, &dummy_cursor_iov_cnt, cmd_size);
> +    dummy_cursor_iov_cnt =3D 1;
> +    iov_discard_front(&in_cursor, &dummy_cursor_iov_cnt, sizeof(*s->stat=
us));
> +
> +    return 0;
>  }
>
>  static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n=
,
> @@ -697,15 +744,12 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *=
s, const VirtIONet *n,
>              .iov_base =3D (void *)n->mac,
>              .iov_len =3D sizeof(n->mac),
>          };
> -        ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, i=
n_cursor,
> -                                                  VIRTIO_NET_CTRL_MAC,
> -                                                  VIRTIO_NET_CTRL_MAC_AD=
DR_SET,
> -                                                  &data, 1);
> -        if (unlikely(dev_written < 0)) {
> -            return dev_written;
> -        }
> -        if (*s->status !=3D VIRTIO_NET_OK) {
> -            return -EIO;
> +        ssize_t r =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
> +                                               VIRTIO_NET_CTRL_MAC,
> +                                               VIRTIO_NET_CTRL_MAC_ADDR_=
SET,
> +                                               &data, 1);
> +        if (unlikely(r < 0)) {
> +            return r;
>          }
>      }
>
> @@ -750,15 +794,12 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *=
s, const VirtIONet *n,
>              .iov_len =3D mul_macs_size,
>          },
>      };
> -    ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cu=
rsor,
> +    ssize_t r =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
>                                  VIRTIO_NET_CTRL_MAC,
>                                  VIRTIO_NET_CTRL_MAC_TABLE_SET,
>                                  data, ARRAY_SIZE(data));
> -    if (unlikely(dev_written < 0)) {
> -        return dev_written;
> -    }
> -    if (*s->status !=3D VIRTIO_NET_OK) {
> -        return -EIO;
> +    if (unlikely(r < 0)) {
> +        return r;
>      }
>
>      return 0;
> @@ -770,7 +811,7 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>                                    struct iovec *in_cursor)
>  {
>      struct virtio_net_ctrl_mq mq;
> -    ssize_t dev_written;
> +    ssize_t r;
>
>      if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_MQ)) {
>          return 0;
> @@ -781,15 +822,12 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s=
,
>          .iov_base =3D &mq,
>          .iov_len =3D sizeof(mq),
>      };
> -    dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
> -                                          VIRTIO_NET_CTRL_MQ,
> -                                          VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SE=
T,
> -                                          &data, 1);
> -    if (unlikely(dev_written < 0)) {
> -        return dev_written;
> -    }
> -    if (*s->status !=3D VIRTIO_NET_OK) {
> -        return -EIO;
> +    r =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
> +                                   VIRTIO_NET_CTRL_MQ,
> +                                   VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET,
> +                                   &data, 1);
> +    if (unlikely(r < 0)) {
> +        return r;
>      }
>
>      return 0;
> @@ -801,7 +839,7 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAStat=
e *s,
>                                          struct iovec *in_cursor)
>  {
>      uint64_t offloads;
> -    ssize_t dev_written;
> +    ssize_t r;
>
>      if (!virtio_vdev_has_feature(&n->parent_obj,
>                                   VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
> @@ -829,15 +867,12 @@ static int vhost_vdpa_net_load_offloads(VhostVDPASt=
ate *s,
>          .iov_base =3D &offloads,
>          .iov_len =3D sizeof(offloads),
>      };
> -    dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
> -                                          VIRTIO_NET_CTRL_GUEST_OFFLOADS=
,
> -                                          VIRTIO_NET_CTRL_GUEST_OFFLOADS=
_SET,
> -                                          &data, 1);
> -    if (unlikely(dev_written < 0)) {
> -        return dev_written;
> -    }
> -    if (*s->status !=3D VIRTIO_NET_OK) {
> -        return -EIO;
> +    r =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
> +                                   VIRTIO_NET_CTRL_GUEST_OFFLOADS,
> +                                   VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET,
> +                                   &data, 1);
> +    if (unlikely(r < 0)) {
> +        return r;
>      }
>
>      return 0;
> @@ -853,16 +888,12 @@ static int vhost_vdpa_net_load_rx_mode(VhostVDPASta=
te *s,
>          .iov_base =3D &on,
>          .iov_len =3D sizeof(on),
>      };
> -    ssize_t dev_written;
> +    ssize_t r;
>
> -    dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
> -                                          VIRTIO_NET_CTRL_RX,
> -                                          cmd, &data, 1);
> -    if (unlikely(dev_written < 0)) {
> -        return dev_written;
> -    }
> -    if (*s->status !=3D VIRTIO_NET_OK) {
> -        return -EIO;
> +    r =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
> +                                VIRTIO_NET_CTRL_RX, cmd, &data, 1);
> +    if (unlikely(r < 0)) {
> +        return r;
>      }
>
>      return 0;
> @@ -1019,15 +1050,12 @@ static int vhost_vdpa_net_load_single_vlan(VhostV=
DPAState *s,
>          .iov_base =3D &vid,
>          .iov_len =3D sizeof(vid),
>      };
> -    ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cu=
rsor,
> -                                                  VIRTIO_NET_CTRL_VLAN,
> -                                                  VIRTIO_NET_CTRL_VLAN_A=
DD,
> -                                                  &data, 1);
> -    if (unlikely(dev_written < 0)) {
> -        return dev_written;
> -    }
> -    if (unlikely(*s->status !=3D VIRTIO_NET_OK)) {
> -        return -EIO;
> +    ssize_t r =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
> +                                           VIRTIO_NET_CTRL_VLAN,
> +                                           VIRTIO_NET_CTRL_VLAN_ADD,
> +                                           &data, 1);
> +    if (unlikely(r < 0)) {
> +        return r;
>      }
>
>      return 0;
> @@ -1096,6 +1124,17 @@ static int vhost_vdpa_net_load(NetClientState *nc)
>          return r;
>      }
>
> +    /*
> +     * We need to poll and check all pending device's used buffers.
> +     *
> +     * We can poll here since we've had BQL from the time
> +     * we sent the descriptor.
> +     */
> +    r =3D vhost_vdpa_net_svq_flush(s, in_cursor.iov_base - (void *)s->st=
atus);
> +    if (unlikely(r)) {
> +        return r;
> +    }
> +
>      return 0;
>  }
>
> --
> 2.25.1
>



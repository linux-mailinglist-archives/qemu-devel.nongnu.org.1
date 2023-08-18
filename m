Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF477811F4
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:28:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX3GM-0003QF-9b; Fri, 18 Aug 2023 13:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qX3GK-0003Q4-5k
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qX3GH-0003z6-CD
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692379668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=clnCBxlTgpW9aVJsvzZebFxwfT5onc39XDyU6msNJdY=;
 b=IfznOCz9yDfl9CUmqIdT51EpX9JkdR5jaj7IxKaWOo+VKUVpQyNcTf5eYwedOCBg14482R
 TLM7XVnxPX/yLGsBPlN2WM8IIrFNAjqS4yGlV3PcoDO6cvO/vAvFUA6q5T1KOhyxchk2q/
 gx7CZXe9H/q7AXY1senO4dApCwV92xs=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-y_08kUU8MB2twBlRDXptmg-1; Fri, 18 Aug 2023 13:27:46 -0400
X-MC-Unique: y_08kUU8MB2twBlRDXptmg-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-d63e5f828a0so1433133276.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692379666; x=1692984466;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=clnCBxlTgpW9aVJsvzZebFxwfT5onc39XDyU6msNJdY=;
 b=XkqkXCFAeTNKgJuAiDHElpvRRa/8vY/FgKbyhYDqzqFtq2UadEVi/mjQ4s9k7NsW1W
 6kn5TIMyjdv4qL44VW2nLVj5l8Cl0Bw0BjDjam6xZ1qMTKxYYabg9oFmJUMS+haRRgH7
 yYIfuBJl48ZWSJ97XaJHnjfk1ubwS+EJymzM7pmTRS+4qLD5ajAviN2B8QT1wsiVJv14
 sEHJ4YhvyYw3Yeraa7gLl8PbPuG/QbKGwwgrggiNl3hYyYQaw2eyajs+MmkG9k68gO7c
 bUI8rwfvABPjBDStWHFsnZYqP1Hymzj1CAqQGUynbNbhkcZa8SbOs6XrHoK8vtoRsaFr
 pmEA==
X-Gm-Message-State: AOJu0YwvStBCdGuDr0NCSkd9qQT+M1VY/dlGnaF61qdGpB+R+uQ/nLsQ
 G2sHaV1TUtNGqplRbtVCj0itgPsI0bdLaEPKRG7vSG69Rpl9aN+wwxzNNlyU0hMetOQ0NMRxVeW
 v081Pn+XsSsrcvINbkhjFgYIN2fHO4TY=
X-Received: by 2002:a05:6902:1348:b0:d62:d067:4f68 with SMTP id
 g8-20020a056902134800b00d62d0674f68mr3488104ybu.23.1692379665858; 
 Fri, 18 Aug 2023 10:27:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPSdwtK7GkDAqD1hbOXS+6KfbNHUK7DM4ikHXi5yrQ2bSSwQYcK2nW2YlVl+ZPWrky9SEi5G7gN8xv4GJ9lgo=
X-Received: by 2002:a05:6902:1348:b0:d62:d067:4f68 with SMTP id
 g8-20020a056902134800b00d62d0674f68mr3488087ybu.23.1692379665571; Fri, 18 Aug
 2023 10:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689748694.git.yin31149@gmail.com>
 <3a002790e6c880af928c6470ecbf03e7c65a68bb.1689748694.git.yin31149@gmail.com>
In-Reply-To: <3a002790e6c880af928c6470ecbf03e7c65a68bb.1689748694.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 18 Aug 2023 19:27:09 +0200
Message-ID: <CAJaqyWc0UAiTo4u4ps_vSLYVJb1KHEUn+c7MEPf2vNuWRFMCiQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] vdpa: Send cvq state load commands in parallel
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
>  net/vhost-vdpa.c | 157 +++++++++++++++++++++++++++++------------------
>  1 file changed, 96 insertions(+), 61 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 795c9c1fd2..1ebb58f7f6 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -633,6 +633,26 @@ static uint16_t vhost_vdpa_net_svq_available_slots(V=
hostVDPAState *s)
>      return vhost_svq_available_slots(svq);
>  }
>
> +/*
> + * Poll SVQ for multiple pending control commands and check the device's=
 ack.
> + *
> + * Caller should hold the BQL when invoking this function.
> + */
> +static ssize_t vhost_vdpa_net_svq_flush(VhostVDPAState *s,
> +                                        size_t cmds_in_flight)
> +{
> +    vhost_vdpa_net_svq_poll(s, cmds_in_flight);
> +
> +    /* Device should and must use only one byte ack each control command=
 */
> +    assert(cmds_in_flight < vhost_vdpa_net_cvq_cmd_page_len());
> +    for (int i =3D 0; i < cmds_in_flight; ++i) {
> +        if (s->status[i] !=3D VIRTIO_NET_OK) {
> +            return -EIO;
> +        }
> +    }
> +    return 0;
> +}
> +
>  static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, void **out_cur=
sor,
>                                         void **in_cursor, uint8_t class,
>                                         uint8_t cmd, const struct iovec *=
data_sg,
> @@ -642,19 +662,41 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPASta=
te *s, void **out_cursor,
>          .class =3D class,
>          .cmd =3D cmd,
>      };
> -    size_t data_size =3D iov_size(data_sg, data_num);
> +    size_t data_size =3D iov_size(data_sg, data_num),
> +           left_bytes =3D vhost_vdpa_net_cvq_cmd_page_len() -
> +                        (*out_cursor - s->cvq_cmd_out_buffer);
>      /* Buffers for the device */
>      struct iovec out =3D {
> -        .iov_base =3D *out_cursor,
>          .iov_len =3D sizeof(ctrl) + data_size,
>      };
>      struct iovec in =3D {
> -        .iov_base =3D *in_cursor,
>          .iov_len =3D sizeof(*s->status),
>      };
>      ssize_t r;
>
> -    assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl))=
;
> +    if (sizeof(ctrl) > left_bytes || data_size > left_bytes - sizeof(ctr=
l) ||

I'm ok with this code, but maybe we can simplify the code if we use
two struct iovec as cursors instead of a void **? I think functions
like iov_size and iov_copy already take care of a few checks here.

Apart from that it would be great to merge this call to
vhost_vdpa_net_svq_flush, but I find it very hard to do unless we
scatter it through all callers of vhost_vdpa_net_load_cmd.

Apart from the minor comments I think the series is great, thanks!

> +        vhost_vdpa_net_svq_available_slots(s) < 2) {
> +        /*
> +         * It is time to flush all pending control commands if SVQ is fu=
ll
> +         * or control commands shadow buffers are full.
> +         *
> +         * We can poll here since we've had BQL from the time
> +         * we sent the descriptor.
> +         */
> +        r =3D vhost_vdpa_net_svq_flush(s, *in_cursor - (void *)s->status=
);
> +        if (unlikely(r < 0)) {
> +            return r;
> +        }
> +
> +        *out_cursor =3D s->cvq_cmd_out_buffer;
> +        *in_cursor =3D s->status;
> +        left_bytes =3D vhost_vdpa_net_cvq_cmd_page_len();
> +    }
> +
> +    out.iov_base =3D *out_cursor;
> +    in.iov_base =3D *in_cursor;
> +
> +    assert(data_size <=3D left_bytes - sizeof(ctrl));
>      /* Each CVQ command has one out descriptor and one in descriptor */
>      assert(vhost_vdpa_net_svq_available_slots(s) >=3D 2);
>
> @@ -670,11 +712,11 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPASta=
te *s, void **out_cursor,
>          return r;
>      }
>
> -    /*
> -     * We can poll here since we've had BQL from the time
> -     * we sent the descriptor.
> -     */
> -    return vhost_vdpa_net_svq_poll(s, 1);
> +    /* iterate the cursors */
> +    *out_cursor +=3D out.iov_len;
> +    *in_cursor +=3D in.iov_len;
> +
> +    return 0;
>  }
>
>  static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n=
,
> @@ -685,15 +727,12 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *=
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
> @@ -738,15 +777,12 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *=
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
> @@ -757,7 +793,7 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>                                    void **out_cursor, void **in_cursor)
>  {
>      struct virtio_net_ctrl_mq mq;
> -    ssize_t dev_written;
> +    ssize_t r;
>
>      if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_MQ)) {
>          return 0;
> @@ -768,15 +804,12 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s=
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
> @@ -787,7 +820,7 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAStat=
e *s,
>                                          void **out_cursor, void **in_cur=
sor)
>  {
>      uint64_t offloads;
> -    ssize_t dev_written;
> +    ssize_t r;
>
>      if (!virtio_vdev_has_feature(&n->parent_obj,
>                                   VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
> @@ -815,15 +848,12 @@ static int vhost_vdpa_net_load_offloads(VhostVDPASt=
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
> @@ -838,15 +868,12 @@ static int vhost_vdpa_net_load_rx_mode(VhostVDPASta=
te *s,
>          .iov_base =3D &on,
>          .iov_len =3D sizeof(on),
>      };
> -    ssize_t dev_written;
> +    ssize_t r;
>
> -    dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
> -                                          VIRTIO_NET_CTRL_RX, cmd, &data=
, 1);
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
> @@ -1001,15 +1028,12 @@ static int vhost_vdpa_net_load_single_vlan(VhostV=
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
> @@ -1078,6 +1102,17 @@ static int vhost_vdpa_net_load(NetClientState *nc)
>          return r;
>      }
>
> +    /*
> +     * We need to poll and check all pending device's used buffers.
> +     *
> +     * We can poll here since we've had BQL from the time
> +     * we sent the descriptor.
> +     */
> +    r =3D vhost_vdpa_net_svq_flush(s, in_cursor - (void *)s->status);
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



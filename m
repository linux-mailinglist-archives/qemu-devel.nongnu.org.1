Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC581705F30
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 07:23:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz9cN-0001kM-VC; Wed, 17 May 2023 01:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1pz9cI-0001kA-7T
 for qemu-devel@nongnu.org; Wed, 17 May 2023 01:22:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1pz9cF-0004it-ON
 for qemu-devel@nongnu.org; Wed, 17 May 2023 01:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684300942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0YBFvPO+51c1oOuMxe/QumeMeteVb69tOjZq2b5Vun4=;
 b=MZF4GDb3RgR316OJo0+QJDXCOfvSuafBYQTP9YLRS/L06yj0OcjFvLmGTphLktC8PMKV63
 Vs9uu3CzG0x47HzFbuxQIdnrtqNU6DBkCs1r4wTnzmkUbEJ/5g5QtVJEfGcqPPBV4UF5DL
 24SpKdCtV3S163m4EJso3S+EzwTZyuE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-V910r-2nPZ2FyGb8Le_UmQ-1; Wed, 17 May 2023 01:22:19 -0400
X-MC-Unique: V910r-2nPZ2FyGb8Le_UmQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ad94975f84so1441581fa.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 22:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684300938; x=1686892938;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0YBFvPO+51c1oOuMxe/QumeMeteVb69tOjZq2b5Vun4=;
 b=NUFsVePHzo7bKs/2RO40wM2VMRRUxYIR4SFIvy2RWOMcUGdCnwy3C0jn9thZbscEMD
 r8kZOSxEfMjHoo88HO39UUUALLrjW2Rlf/j8BiE6xhMb1wE+5NYha8spoaXa+amfDBaO
 pOgsiAtQijnnwqUy9n/XZFknTpNBpCit7x44LLYtR6d4E1ikY5LF/em3z3MGrupsR2vw
 NCIGAF5hGGa3qi6W1BB8f5KdRr4wKoX73Kkj7HrN7oxmza0LQjq76shz0HcbXgc6S3gk
 ZS9YP6MXb9pKlUDcD/OtxdfzbBOfjHFpsOHsxzY03GGtK90Xi5Qc2oOVgkBFfOFLc+Iv
 Tueg==
X-Gm-Message-State: AC+VfDwdnK9tKtH3OlDasaeHFdWnxQ7PPj+wdIiTAjS04tt/b+WCbt7u
 loiUxVo+vEMfsvbOQmuqCA8JbulYfGwLEsU1HZDgdsP2Qs9eN+WOnbhsFe/IRvbtoVp8BAJnJpv
 a6az7RTzfbL5nVlnBPomK+U+slng5TQ0=
X-Received: by 2002:ac2:4e63:0:b0:4f0:1a32:ca23 with SMTP id
 y3-20020ac24e63000000b004f01a32ca23mr7723490lfs.40.1684300938415; 
 Tue, 16 May 2023 22:22:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5OmZucQp8UmLTaLuPPauANSId9MnTMA/+YZXpPccy5tapUEAc9GqDQ3SJHplAchHK/BhUBFH4sfL3Wme6+omg=
X-Received: by 2002:ac2:4e63:0:b0:4f0:1a32:ca23 with SMTP id
 y3-20020ac24e63000000b004f01a32ca23mr7723481lfs.40.1684300938015; Tue, 16 May
 2023 22:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683371965.git.yin31149@gmail.com>
 <7d800315d04359d0bb91f61ec348eda1bdb972be.1683371965.git.yin31149@gmail.com>
In-Reply-To: <7d800315d04359d0bb91f61ec348eda1bdb972be.1683371965.git.yin31149@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 May 2023 13:22:06 +0800
Message-ID: <CACGkMEuj=HY0YWHoXcw+qBLm4ctfTgj3P5cfWbueVFrOP1B2uQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vdpa: send CVQ state load commands in parallel
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: eperezma@redhat.com, 18801353760@163.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, May 6, 2023 at 10:07=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> This patch introduces the vhost_vdpa_net_cvq_add() and
> refactors the vhost_vdpa_net_load*(), so that QEMU can
> send CVQ state load commands in parallel.
>
> To be more specific, this patch introduces vhost_vdpa_net_cvq_add()
> to add SVQ control commands to SVQ and kick the device,
> but does not poll the device used buffers. QEMU will not
> poll and check the device used buffers in vhost_vdpa_net_load()
> until all CVQ state load commands have been sent to the device.
>
> What's more, in order to avoid buffer overwriting caused by
> using `svq->cvq_cmd_out_buffer` and `svq->status` as the
> buffer for all CVQ state load commands when sending
> CVQ state load commands in parallel, this patch introduces
> `out_cursor` and `in_cursor` in vhost_vdpa_net_load(),
> pointing to the available buffer for in descriptor and
> out descriptor, so that different CVQ state load commands can
> use their unique buffer.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1578
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>  net/vhost-vdpa.c | 152 +++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 120 insertions(+), 32 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 10804c7200..14e31ca5c5 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -590,6 +590,44 @@ static void vhost_vdpa_net_cvq_stop(NetClientState *=
nc)
>      vhost_vdpa_net_client_stop(nc);
>  }
>
> +/**
> + * vhost_vdpa_net_cvq_add() adds SVQ control commands to SVQ,
> + * kicks the device but does not poll the device used buffers.
> + *
> + * Return the number of elements added to SVQ if success.
> + */
> +static int vhost_vdpa_net_cvq_add(VhostVDPAState *s,
> +                                void **out_cursor, size_t out_len,

Can we track things like cursors in e.g VhostVDPAState ?

> +                                virtio_net_ctrl_ack **in_cursor, size_t =
in_len)
> +{
> +    /* Buffers for the device */
> +    const struct iovec out =3D {
> +        .iov_base =3D *out_cursor,
> +        .iov_len =3D out_len,
> +    };
> +    const struct iovec in =3D {
> +        .iov_base =3D *in_cursor,
> +        .iov_len =3D sizeof(virtio_net_ctrl_ack),
> +    };
> +    VhostShadowVirtqueue *svq =3D g_ptr_array_index(s->vhost_vdpa.shadow=
_vqs, 0);
> +    int r;
> +
> +    r =3D vhost_svq_add(svq, &out, 1, &in, 1, NULL);
> +    if (unlikely(r !=3D 0)) {
> +        if (unlikely(r =3D=3D -ENOSPC)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: No space on device queue=
\n",
> +                          __func__);
> +        }
> +        return r;
> +    }
> +
> +    /* Update the cursor */
> +    *out_cursor +=3D out_len;
> +    *in_cursor +=3D 1;
> +
> +    return 1;
> +}
> +
>  /**
>   * vhost_vdpa_net_cvq_add_and_wait() adds SVQ control commands to SVQ,
>   * kicks the device and polls the device used buffers.
> @@ -628,69 +666,82 @@ static ssize_t vhost_vdpa_net_cvq_add_and_wait(Vhos=
tVDPAState *s,
>      return vhost_svq_poll(svq);
>  }
>
> -static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
> -                                       uint8_t cmd, const void *data,
> -                                       size_t data_size)
> +
> +/**
> + * vhost_vdpa_net_load_cmd() restores the NIC state through SVQ.
> + *
> + * Return the number of elements added to SVQ if success.
> + */
> +static int vhost_vdpa_net_load_cmd(VhostVDPAState *s,
> +                                void **out_cursor, uint8_t class, uint8_=
t cmd,
> +                                const void *data, size_t data_size,
> +                                virtio_net_ctrl_ack **in_cursor)
>  {
>      const struct virtio_net_ctrl_hdr ctrl =3D {
>          .class =3D class,
>          .cmd =3D cmd,
>      };
>
> -    assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl))=
;
> +    assert(sizeof(ctrl) < vhost_vdpa_net_cvq_cmd_page_len() -
> +                          (*out_cursor - s->cvq_cmd_out_buffer));
> +    assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl) =
-
> +                       (*out_cursor - s->cvq_cmd_out_buffer));
>
> -    memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
> -    memcpy(s->cvq_cmd_out_buffer + sizeof(ctrl), data, data_size);
> +    memcpy(*out_cursor, &ctrl, sizeof(ctrl));
> +    memcpy(*out_cursor + sizeof(ctrl), data, data_size);
>
> -    return vhost_vdpa_net_cvq_add_and_wait(s, sizeof(ctrl) + data_size,
> -                                  sizeof(virtio_net_ctrl_ack));
> +    return vhost_vdpa_net_cvq_add(s, out_cursor, sizeof(ctrl) + data_siz=
e,
> +                                  in_cursor, sizeof(virtio_net_ctrl_ack)=
);
>  }
>
> -static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n=
)
> +/**
> + * vhost_vdpa_net_load_mac() restores the NIC mac through SVQ.
> + *
> + * Return the number of elements added to SVQ if success.
> + */
> +static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n=
,
> +                            void **out_cursor, virtio_net_ctrl_ack **in_=
cursor)
>  {
>      uint64_t features =3D n->parent_obj.guest_features;
>      if (features & BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR)) {
> -        ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CT=
RL_MAC,
> -                                                  VIRTIO_NET_CTRL_MAC_AD=
DR_SET,
> -                                                  n->mac, sizeof(n->mac)=
);
> -        if (unlikely(dev_written < 0)) {
> -            return dev_written;
> -        }
> -
> -        return *s->status !=3D VIRTIO_NET_OK;
> +        return vhost_vdpa_net_load_cmd(s, out_cursor, VIRTIO_NET_CTRL_MA=
C,
> +                                       VIRTIO_NET_CTRL_MAC_ADDR_SET,
> +                                       n->mac, sizeof(n->mac), in_cursor=
);
>      }
>
>      return 0;
>  }
>
> -static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
> -                                  const VirtIONet *n)
> +/**
> + * vhost_vdpa_net_load_mac() restores the NIC mq state through SVQ.
> + *
> + * Return the number of elements added to SVQ if success.
> + */
> +static int vhost_vdpa_net_load_mq(VhostVDPAState *s, const VirtIONet *n,
> +                            void **out_cursor, virtio_net_ctrl_ack **in_=
cursor)
>  {
>      struct virtio_net_ctrl_mq mq;
>      uint64_t features =3D n->parent_obj.guest_features;
> -    ssize_t dev_written;
>
>      if (!(features & BIT_ULL(VIRTIO_NET_F_MQ))) {
>          return 0;
>      }
>
>      mq.virtqueue_pairs =3D cpu_to_le16(n->curr_queue_pairs);
> -    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_MQ,
> -                                          VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SE=
T, &mq,
> -                                          sizeof(mq));
> -    if (unlikely(dev_written < 0)) {
> -        return dev_written;
> -    }
> -
> -    return *s->status !=3D VIRTIO_NET_OK;
> +    return vhost_vdpa_net_load_cmd(s, out_cursor, VIRTIO_NET_CTRL_MQ,
> +                                   VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET,
> +                                   &mq, sizeof(mq), in_cursor);
>  }
>
>  static int vhost_vdpa_net_load(NetClientState *nc)
>  {
>      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> +    VhostShadowVirtqueue *svq;
> +    void *out_cursor;
> +    virtio_net_ctrl_ack *in_cursor;
>      struct vhost_vdpa *v =3D &s->vhost_vdpa;
>      const VirtIONet *n;
> -    int r;
> +    ssize_t cmds_in_flight =3D 0, dev_written, r;
>
>      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
>
> @@ -699,14 +750,51 @@ static int vhost_vdpa_net_load(NetClientState *nc)
>      }
>
>      n =3D VIRTIO_NET(v->dev->vdev);
> -    r =3D vhost_vdpa_net_load_mac(s, n);
> +    out_cursor =3D s->cvq_cmd_out_buffer;
> +    in_cursor =3D s->status;
> +
> +    r =3D vhost_vdpa_net_load_mac(s, n, &out_cursor, &in_cursor);
>      if (unlikely(r < 0))
>          return r;
>      }
> -    r =3D vhost_vdpa_net_load_mq(s, n);
> -    if (unlikely(r)) {
> +    cmds_in_flight +=3D r;
> +
> +    r =3D vhost_vdpa_net_load_mq(s, n, &out_cursor, &in_cursor);
> +    if (unlikely(r < 0)) {
>          return r;
>      }
> +    cmds_in_flight +=3D r;
> +
> +    /* Poll for all used buffer from device */
> +    svq =3D g_ptr_array_index(s->vhost_vdpa.shadow_vqs, 0);
> +    while (cmds_in_flight > 0) {
> +        /*
> +         * We can poll here since we've had BQL from the time we sent th=
e
> +         * descriptor. Also, we need to take the answer before SVQ pulls
> +         * by itself, when BQL is released
> +         */
> +        dev_written =3D vhost_svq_poll(svq);

I'd tweak vhost_svq_poll to accept cmds_in_flight.

Thanks

> +
> +        if (unlikely(!dev_written)) {
> +            /*
> +             * vhost_svq_poll() return 0 when something wrong, such as
> +             * QEMU waits for too long time or no available used buffer
> +             * from device, and there is no need to continue polling
> +             * in this case.
> +             */
> +            return -EINVAL;
> +        }
> +
> +        --cmds_in_flight;
> +    }
> +
> +    /* Check the buffers written by device */
> +    for (virtio_net_ctrl_ack *status =3D s->status; status < in_cursor;
> +         ++status) {
> +        if (*status !=3D VIRTIO_NET_OK) {
> +            return -EINVAL;
> +        }
> +    }
>
>      return 0;
>  }
> --
> 2.25.1
>



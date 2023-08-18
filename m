Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F00F780F05
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:24:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX1KN-0004wy-8o; Fri, 18 Aug 2023 11:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qX1KL-0004wW-B8
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:23:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qX1KI-0002tG-UT
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692372230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SdOZ05YXJlMtz0K7UVqLJBpd0BB/64a0kbX6UcalSV0=;
 b=J4mEQqJUtZRw8EKe+RpA9J4OBKeX+pi/tu7NfTX9C7AOVuOMA8Mv9kjcOrtwIEyqeExuZn
 dcUi6ImtWKO+GEkCOE9FYRTXcwMLWRlxEJNytmKrOPs9oWCfjq4aMANMWwPKrOXxfsO1v8
 2bD8KVsxBL15L8wQnSB8CCltZjLTIgI=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-Xj-NujzTMpaiCuf7nQjfFw-1; Fri, 18 Aug 2023 11:23:48 -0400
X-MC-Unique: Xj-NujzTMpaiCuf7nQjfFw-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-d637af9a981so1223297276.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 08:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692372228; x=1692977028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SdOZ05YXJlMtz0K7UVqLJBpd0BB/64a0kbX6UcalSV0=;
 b=QQDQIW6wQEcIjy6R7hErmiWCKlVU1Yy2vMi7aqAuWn/R/u/VhiYGli2ymHcP5ozL/3
 o6W3SeJyq3a5rBrWj5RJqWWo5LYNmqyNC9OEDeB46vys4kdq0E4LEbgTs229o/iSI/pG
 H9zo7zsKDSuoM+MtudeTFLPNVIqVqqwGGDIsUipNjxPWrKsvjWC4819O39DyojkRSa8o
 fy+yekskeTpUKizlWBEjLYGErLZTPqvPmLUxEQIZ+plNX/mMP8DEOQj5zB+u4vRrIsMD
 r1fe9PFh0pcSfUJiDGICCl6Y5YPiZmD4qtyyEX7jt4seQNtmn0AUWGvFCFC10Cno6In1
 eSbQ==
X-Gm-Message-State: AOJu0YwwL7JBdkNwwYaYomryF6Rcs1NJExnDeGAlkgDRiT+nOEoLFHDQ
 9mMeJgQjAqMyC6lhEZIOr6mWUpTFgWa+QoAHI3MoEjrMtCpqk4ea4v/2tOie2gOar2UXyOgCsgc
 U4v5ug1nejvYCiSC2DfkGCDLBvv9MLnc=
X-Received: by 2002:a25:8388:0:b0:d5c:4d20:6245 with SMTP id
 t8-20020a258388000000b00d5c4d206245mr3108425ybk.21.1692372227934; 
 Fri, 18 Aug 2023 08:23:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzPMoLX3hu5JP5zKo6hNirI4hRzgYwz8+fLixe3MwFtnHYcacWhqR/QyRjLDICHJOm61PC5hDNrie/eUmNgNg=
X-Received: by 2002:a25:8388:0:b0:d5c:4d20:6245 with SMTP id
 t8-20020a258388000000b00d5c4d206245mr3108409ybk.21.1692372227630; Fri, 18 Aug
 2023 08:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689748694.git.yin31149@gmail.com>
 <b1d473772ec4bcb254ab0d12430c9b1efe758606.1689748694.git.yin31149@gmail.com>
In-Reply-To: <b1d473772ec4bcb254ab0d12430c9b1efe758606.1689748694.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 18 Aug 2023 17:23:11 +0200
Message-ID: <CAJaqyWeGSdnv-s0X=ZqhQPw7tQ7BtjJuvD_1e5nqbCyN-tFknA@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] vdpa: Use iovec for vhost_vdpa_net_cvq_add()
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
> Next patches in this series will no longer perform an
> immediate poll and check of the device's used buffers
> for each CVQ state load command. Consequently, there
> will be multiple pending buffers in the shadow VirtQueue,
> making it a must for every control command to have its
> own buffer.
>
> To achieve this, this patch refactor vhost_vdpa_net_cvq_add()
> to accept `struct iovec`, which eliminates the coupling of
> control commands to `s->cvq_cmd_out_buffer` and `s->status`,
> allowing them to use their own buffer.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>  net/vhost-vdpa.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index d1dd140bf6..6b16c8ece0 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -596,22 +596,14 @@ static void vhost_vdpa_net_cvq_stop(NetClientState =
*nc)
>      vhost_vdpa_net_client_stop(nc);
>  }
>
> -static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState *s, size_t out_len,
> -                                      size_t in_len)
> +static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState *s,
> +                                      struct iovec *out_sg, size_t out_n=
um,
> +                                      struct iovec *in_sg, size_t in_num=
)
>  {
> -    /* Buffers for the device */
> -    const struct iovec out =3D {
> -        .iov_base =3D s->cvq_cmd_out_buffer,
> -        .iov_len =3D out_len,
> -    };
> -    const struct iovec in =3D {
> -        .iov_base =3D s->status,
> -        .iov_len =3D sizeof(virtio_net_ctrl_ack),
> -    };
>      VhostShadowVirtqueue *svq =3D g_ptr_array_index(s->vhost_vdpa.shadow=
_vqs, 0);
>      int r;
>
> -    r =3D vhost_svq_add(svq, &out, 1, &in, 1, NULL);
> +    r =3D vhost_svq_add(svq, out_sg, out_num, in_sg, in_num, NULL);
>      if (unlikely(r !=3D 0)) {
>          if (unlikely(r =3D=3D -ENOSPC)) {
>              qemu_log_mask(LOG_GUEST_ERROR, "%s: No space on device queue=
\n",
> @@ -637,6 +629,15 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAStat=
e *s, uint8_t class,
>          .cmd =3D cmd,
>      };
>      size_t data_size =3D iov_size(data_sg, data_num);
> +    /* Buffers for the device */
> +    struct iovec out =3D {
> +        .iov_base =3D s->cvq_cmd_out_buffer,
> +        .iov_len =3D sizeof(ctrl) + data_size,
> +    };
> +    struct iovec in =3D {
> +        .iov_base =3D s->status,
> +        .iov_len =3D sizeof(*s->status),
> +    };
>
>      assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl))=
;
>
> @@ -647,8 +648,7 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState=
 *s, uint8_t class,
>      iov_to_buf(data_sg, data_num, 0,
>                 s->cvq_cmd_out_buffer + sizeof(ctrl), data_size);
>
> -    return vhost_vdpa_net_cvq_add(s, data_size + sizeof(ctrl),
> -                                  sizeof(virtio_net_ctrl_ack));
> +    return vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
>  }
>
>  static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n=
)
> @@ -1222,9 +1222,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostSh=
adowVirtqueue *svq,
>      struct iovec out =3D {
>          .iov_base =3D s->cvq_cmd_out_buffer,
>      };
> -    /* in buffer used for device model */
> -    const struct iovec in =3D {
> -        .iov_base =3D &status,
> +    struct iovec in =3D {

What if instead of reusing "in" we declare a new struct iovec in the
condition that calls vhost_vdpa_net_cvq_add? Something in the line of
"device_in".

I'm also ok with this code, but splitting them would reduce the
possibility of sending the wrong one to the device / virtio device
model by mistake.

Thanks!

>          .iov_len =3D sizeof(status),
>      };
>      ssize_t dev_written =3D -EINVAL;
> @@ -1232,6 +1230,8 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostSh=
adowVirtqueue *svq,
>      out.iov_len =3D iov_to_buf(elem->out_sg, elem->out_num, 0,
>                               s->cvq_cmd_out_buffer,
>                               vhost_vdpa_net_cvq_cmd_page_len());
> +    /* In buffer used for the vdpa device */
> +    in.iov_base =3D s->status;
>
>      ctrl =3D s->cvq_cmd_out_buffer;
>      if (ctrl->class =3D=3D VIRTIO_NET_CTRL_ANNOUNCE) {
> @@ -1260,7 +1260,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostSh=
adowVirtqueue *svq,
>              goto out;
>          }
>      } else {
> -        dev_written =3D vhost_vdpa_net_cvq_add(s, out.iov_len, sizeof(st=
atus));
> +        dev_written =3D vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
>          if (unlikely(dev_written < 0)) {
>              goto out;
>          }
> @@ -1276,6 +1276,8 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostSh=
adowVirtqueue *svq,
>      }
>
>      status =3D VIRTIO_NET_ERR;
> +    /* In buffer used for the device model */
> +    in.iov_base =3D &status;
>      virtio_net_handle_ctrl_iov(svq->vdev, &in, 1, &out, 1);
>      if (status !=3D VIRTIO_NET_OK) {
>          error_report("Bad CVQ processing in model");
> --
> 2.25.1
>



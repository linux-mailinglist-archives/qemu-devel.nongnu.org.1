Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FE27B7021
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:43:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjOS-00044L-Fc; Tue, 03 Oct 2023 13:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qnjOD-0003vp-83
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qnjO1-0000fG-5U
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696354815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uvrdf3gqUbibwPFS+eC7WMu1xGFolI1XejGVeRPU4Xw=;
 b=Du5WvuxzePHxaii/wycUaZOsbgA/EMk+umLvy1cjG66CNrMN7rh81a/Z1maLYqdaG1a47S
 YAmecO7O86nLst7A8OHXw5d4tz3jI30yHhnns+chmSAoFaxVB8VfdvY5fvSU4OJTvohaVb
 VkghsBiIbIOFz3vhBhtD6xW8B1f/okQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-xF-n7lVAP52e5XBv4WPsgA-1; Tue, 03 Oct 2023 13:40:03 -0400
X-MC-Unique: xF-n7lVAP52e5XBv4WPsgA-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-5a213b4d0efso16639597b3.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354802; x=1696959602;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uvrdf3gqUbibwPFS+eC7WMu1xGFolI1XejGVeRPU4Xw=;
 b=VoY/ZTowDwyhAXsBS8UQvcEw5qUchEfMNabsvmoooMpPyGQ3adm0AE1VQkzaJqVieD
 P1X4z7eNMSs/xJK+aIAoiTM6+6RgIMt/GZEGWk+bZoVNRDdKPyhQ3Tx2hU3AFqL0Dbc+
 6ctjLxBVY8O1eY/gK6j4+7v706dc1mlV7z+pgrnu5dU34A82aIm036t/7VgCsZ1GTesq
 i8R628fb2kx4vY8Gst9h5FXSICzHwiy6XN8O6+XbYoIMvs+enG02bzdm7aceksk5c5xz
 6YhvlzsUgK3TM5Pl/juDEnBxHtuSJY4pGfF3D2zQm2fof/ittZh/RUzXTIJ05jG4qCHv
 aWIA==
X-Gm-Message-State: AOJu0Yzi6H0tf39EqYYwllC9frXg2+5/smpmo818zoNFDaUx1o5uW0Zw
 fObrMYVZ7DQ7d7Skm4NHTdF5nT0RUlo0Vmrlzw1QOGh80sPgdQd0pAS4BzGNZgz8BRr1EaBhnzD
 vUA0LEMQZTBqsYFwSDv9sowUPc+j232Y=
X-Received: by 2002:a81:4f8f:0:b0:576:7dfc:e73e with SMTP id
 d137-20020a814f8f000000b005767dfce73emr244476ywb.32.1696354802585; 
 Tue, 03 Oct 2023 10:40:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHjdh1L/QBdGfyYRWNt+U/6I6FNmXFCD0dRAqaFwYoAE/l4qIn+2BRY05DozWbfAllXJK/hKVqyzTCQCslI4g=
X-Received: by 2002:a81:4f8f:0:b0:576:7dfc:e73e with SMTP id
 d137-20020a814f8f000000b005767dfce73emr244457ywb.32.1696354802305; Tue, 03
 Oct 2023 10:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693287885.git.yin31149@gmail.com>
 <5e090c2af922192f5897ba7072df4d9e4754e1e0.1693287885.git.yin31149@gmail.com>
In-Reply-To: <5e090c2af922192f5897ba7072df4d9e4754e1e0.1693287885.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 3 Oct 2023 19:39:26 +0200
Message-ID: <CAJaqyWc0Geen+o8fPb4mbn-krYgHvQyYT-y_oYiKCwtwp-M8LQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] vdpa: Use iovec for vhost_vdpa_net_cvq_add()
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 leiyang@redhat.com, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
> v4:
>   - split `in` to `vdpa_in` and `model_in` instead of reusing `in`
> in vhost_vdpa_net_handle_ctrl_avail() suggested by Eugenio
>
> v3: https://lore.kernel.org/all/b1d473772ec4bcb254ab0d12430c9b1efe758606.=
1689748694.git.yin31149@gmail.com/
>
>  net/vhost-vdpa.c | 39 ++++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 3acda8591a..a875767ee9 100644
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
> +                                    const struct iovec *out_sg, size_t o=
ut_num,
> +                                    const struct iovec *in_sg, size_t in=
_num)
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
> +    const struct iovec out =3D {
> +        .iov_base =3D s->cvq_cmd_out_buffer,
> +        .iov_len =3D sizeof(ctrl) + data_size,
> +    };
> +    const struct iovec in =3D {
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
> @@ -1222,10 +1222,15 @@ static int vhost_vdpa_net_handle_ctrl_avail(Vhost=
ShadowVirtqueue *svq,
>          .iov_base =3D s->cvq_cmd_out_buffer,
>      };
>      /* in buffer used for device model */
> -    const struct iovec in =3D {
> +    const struct iovec model_in =3D {
>          .iov_base =3D &status,
>          .iov_len =3D sizeof(status),
>      };
> +    /* in buffer used for vdpa device */
> +    const struct iovec vdpa_in =3D {
> +        .iov_base =3D s->status,
> +        .iov_len =3D sizeof(*s->status),
> +    };
>      ssize_t dev_written =3D -EINVAL;
>
>      out.iov_len =3D iov_to_buf(elem->out_sg, elem->out_num, 0,
> @@ -1259,7 +1264,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostSh=
adowVirtqueue *svq,
>              goto out;
>          }
>      } else {
> -        dev_written =3D vhost_vdpa_net_cvq_add(s, out.iov_len, sizeof(st=
atus));
> +        dev_written =3D vhost_vdpa_net_cvq_add(s, &out, 1, &vdpa_in, 1);
>          if (unlikely(dev_written < 0)) {
>              goto out;
>          }
> @@ -1275,7 +1280,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostSh=
adowVirtqueue *svq,
>      }
>
>      status =3D VIRTIO_NET_ERR;
> -    virtio_net_handle_ctrl_iov(svq->vdev, &in, 1, &out, 1);
> +    virtio_net_handle_ctrl_iov(svq->vdev, &model_in, 1, &out, 1);
>      if (status !=3D VIRTIO_NET_OK) {
>          error_report("Bad CVQ processing in model");
>      }
> --
> 2.25.1
>



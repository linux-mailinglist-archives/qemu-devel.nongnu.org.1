Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD11723529
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 04:19:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6MGC-0000Sd-BJ; Mon, 05 Jun 2023 22:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q6MGA-0000SU-Bj
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 22:17:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q6MG8-0000jn-Ur
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 22:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686017840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i7Oyas2Md+1Mp2AOmcQN/MVGZOio7HFsyi2LmjXmUSQ=;
 b=fNiV+lFTPhFdBiq3ow9ea33/kG1KLVfflAngt3aANAcqDv0UTK7zTAFSVuKPr+Qj0atvBT
 W5C0LeUqEi54MJ/6lf1x3BBIMZkoW7mak87KX5wNp7Hbb5holZC24z/1KWJDANH9iCazV1
 /HJmki6ZxCIMaDEDOzTNVWIXxxdqc0k=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-QtB9gvjCMIygKHAxgHoROA-1; Mon, 05 Jun 2023 22:17:17 -0400
X-MC-Unique: QtB9gvjCMIygKHAxgHoROA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f62d8e527bso1082363e87.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 19:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686017836; x=1688609836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i7Oyas2Md+1Mp2AOmcQN/MVGZOio7HFsyi2LmjXmUSQ=;
 b=hqi2yuFHHRcYevOSzh4FatF4q5gNJFmK/twTlhOHMoawlzLkFUhgQArgWGjETRtXe+
 jbFYCqnoFspDDapLcX8f6MS+vaDzkE59a4kCpX6yjr2zejQ7V1Dx3oC/EQTXTVJh1u8n
 8Eps31pUy2O+/Wl++Zf2hoNqKZ4S/+s8iInOIqtgmES9NSYbYSiWgFH9xmwgiJqIOfzs
 7aTlwPUQVuLmN4Tt7RTXysYW3rdfpXR7d3FuYp6hRRK6D1Ge6F3XmhNsxaZKDgxz/bRs
 khoA8kIwnSvjcUTtB3mNcPxROYHJM3ittw2tRDeqgoILELPkI6//nszrm99j+LM8Llq5
 Z+uA==
X-Gm-Message-State: AC+VfDxNCt52c16NKB+tp49kkffT9o5krgfM9pnuEneNCA+1Kc7cueUU
 ++cIWKRFK6eoZzDi+9so7k3yS7+DTMC9f+2e52Zz37+HP+taN2UE67cD9W5wcDagrgOoZLDgrWw
 qm/8V5zguebgJGOiLV+9aBAbmjkPWSPA=
X-Received: by 2002:ac2:59db:0:b0:4f4:b28f:6b9c with SMTP id
 x27-20020ac259db000000b004f4b28f6b9cmr353482lfn.29.1686017835836; 
 Mon, 05 Jun 2023 19:17:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5UMw7OGyaS4vqcaz910tYYnGV8SGy8UlRGpGU1jIm3mhycAbfp0I3FGN0XEqJObblTjl5+tbGK0pJkmThz0rw=
X-Received: by 2002:ac2:59db:0:b0:4f4:b28f:6b9c with SMTP id
 x27-20020ac259db000000b004f4b28f6b9cmr353474lfn.29.1686017835553; Mon, 05 Jun
 2023 19:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230605142125.3881859-1-lvivier@redhat.com>
In-Reply-To: <20230605142125.3881859-1-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Jun 2023 10:17:04 +0800
Message-ID: <CACGkMEuXaY-2tYfWcL_7KXG7Ax-PQXBDQO=Qcj=VJo=ah+gZ4w@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: correctly report maximum tx_queue_size value
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jun 5, 2023 at 10:22=E2=80=AFPM Laurent Vivier <lvivier@redhat.com>=
 wrote:
>
> Maximum value for tx_queue_size depends on the backend type.
> 1024 for vDPA/vhost-user, 256 for all the others.
>
> The value is returned by virtio_net_max_tx_queue_size() to set the
> parameter:
>
>     n->net_conf.tx_queue_size =3D MIN(virtio_net_max_tx_queue_size(n),
>                                     n->net_conf.tx_queue_size);
>
> But the parameter checking uses VIRTQUEUE_MAX_SIZE (1024).
>
> So the parameter is silently ignored and ethtool reports a different
> value than the one provided by the user.
>
>    ... -netdev tap,... -device virtio-net,tx_queue_size=3D1024
>
>     # ethtool -g enp0s2
>     Ring parameters for enp0s2:
>     Pre-set maximums:
>     RX:         256
>     RX Mini:    n/a
>     RX Jumbo:   n/a
>     TX:         256
>     Current hardware settings:
>     RX:         256
>     RX Mini:    n/a
>     RX Jumbo:   n/a
>     TX:         256
>
>    ... -netdev vhost-user,... -device virtio-net,tx_queue_size=3D2048
>
>     Invalid tx_queue_size (=3D 2048), must be a power of 2 between 256 an=
d 1024
>
> With this patch the correct maximum value is checked and displayed.
>
> For vDPA/vhost-user:
>
>     Invalid tx_queue_size (=3D 2048), must be a power of 2 between 256 an=
d 1024
>
> For all the others:
>
>     Invalid tx_queue_size (=3D 512), must be a power of 2 between 256 and=
 256
>
> Fixes: 2eef278b9e63 ("virtio-net: fix tx queue size for !vhost-user")
> Cc: mst@redhat.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Queued.

Thanks

> ---
>  hw/net/virtio-net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 6df6b7329d25..e9905aac83ad 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3630,12 +3630,12 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
>      }
>
>      if (n->net_conf.tx_queue_size < VIRTIO_NET_TX_QUEUE_MIN_SIZE ||
> -        n->net_conf.tx_queue_size > VIRTQUEUE_MAX_SIZE ||
> +        n->net_conf.tx_queue_size > virtio_net_max_tx_queue_size(n) ||
>          !is_power_of_2(n->net_conf.tx_queue_size)) {
>          error_setg(errp, "Invalid tx_queue_size (=3D %" PRIu16 "), "
>                     "must be a power of 2 between %d and %d",
>                     n->net_conf.tx_queue_size, VIRTIO_NET_TX_QUEUE_MIN_SI=
ZE,
> -                   VIRTQUEUE_MAX_SIZE);
> +                   virtio_net_max_tx_queue_size(n));
>          virtio_cleanup(vdev);
>          return;
>      }
> --
> 2.39.2
>
>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C700705E96
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 06:13:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz8Wx-0006NH-AW; Wed, 17 May 2023 00:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1pz8Wu-0006Mn-Hk
 for qemu-devel@nongnu.org; Wed, 17 May 2023 00:12:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1pz8Ws-0004tS-Sx
 for qemu-devel@nongnu.org; Wed, 17 May 2023 00:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684296765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ECE4ULOA2cRjqTVeCLtCZWETC4scbQ7lYX3GFFUMbU=;
 b=JAVV/ohWTKv47oR1j6bgGbiLpfj6luTQBzQ5x3mWZmggul9uJN7DPjTc6hJdnZmJzQ6/X1
 cwuvAUHWJ8A6PUXLvISsexdRbteoQBX6WEB8KOfTqxqbU77NhPy2dNwFa8StgrLJndlPRF
 5vIoVyA2zwa+db2tfywzN5pWa2Qh7rI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-wtZtcWLGNtyV8STin11-Yw-1; Wed, 17 May 2023 00:12:43 -0400
X-MC-Unique: wtZtcWLGNtyV8STin11-Yw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ac8e10abafso821921fa.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 21:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684296762; x=1686888762;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ECE4ULOA2cRjqTVeCLtCZWETC4scbQ7lYX3GFFUMbU=;
 b=iXZirB9e0TgeQJ0vjPOZBfxkfI1mzvyJS34z7kKmkZbG7T0Nj34jgbV0QsVl94+LZS
 wPtUNUSUgTT7pc+fMEP90L9i20NyAUM6VFwO5RstVspGFaJ94vZgwbnp9T/zN2tW0HxG
 AvWG/JgNNqUKzdDQ0oqfOaOav2dhlo07UZfXdkUq14GiYYgyA+2TmRLbgI0omogCi4H0
 5f3kBL0qAjL/oHcrosrWkB7QFHgXII6wiw1L5fEfBVv+wHYbhgDianJ+68kSodUwJIdj
 geE7xN6ezaS5Z1ZnS9M16mIkZN8jS7BP/e+wXVlCGXtcF8ff1K+GmaHOjokOe0BqvbDV
 NvUg==
X-Gm-Message-State: AC+VfDyHJ2OFH091PYF5ifl2dIV9VhRxTGuO47bRPkq8t8fOWpqkquJB
 IDyZ1CrbAFFIsbm1icXd0w1exvUO62n3n/PPzIfd/fAuZt3xmjOhlhmQHj4kB17pSJsL4OCyjw5
 yLa8UIKpvaDQENfhLLdPV+tdF3h8Ekrc=
X-Received: by 2002:a2e:94cd:0:b0:2ac:8000:1ea0 with SMTP id
 r13-20020a2e94cd000000b002ac80001ea0mr8194204ljh.26.1684296762105; 
 Tue, 16 May 2023 21:12:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7hI/w0XoM+pLrWQOtLMQm/pRhnHUsDOruPBish0w4m9yPwB8uKOIZcYCpOydlpcQMZzlJyI072YW+roh35PZI=
X-Received: by 2002:a2e:94cd:0:b0:2ac:8000:1ea0 with SMTP id
 r13-20020a2e94cd000000b002ac80001ea0mr8194198ljh.26.1684296761786; Tue, 16
 May 2023 21:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683371965.git.yin31149@gmail.com>
 <fbaa1630a3cf8d08c59c2e273d53f055da8292b3.1683371965.git.yin31149@gmail.com>
In-Reply-To: <fbaa1630a3cf8d08c59c2e273d53f055da8292b3.1683371965.git.yin31149@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 May 2023 12:12:30 +0800
Message-ID: <CACGkMEttwMJ6J6LegqYg-yobWbXnFvmVTCBFXKv40=AZ2Ov6fw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vdpa: rename vhost_vdpa_net_cvq_add()
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
> We want to introduce a new version of vhost_vdpa_net_cvq_add() that
> does not poll immediately after forwarding custom buffers
> to the device, so that QEMU can send all the SVQ control commands
> in parallel instead of serialized.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>  net/vhost-vdpa.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 99904a0da7..10804c7200 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -590,8 +590,14 @@ static void vhost_vdpa_net_cvq_stop(NetClientState *=
nc)
>      vhost_vdpa_net_client_stop(nc);
>  }
>
> -static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState *s, size_t out_len,
> -                                      size_t in_len)
> +/**
> + * vhost_vdpa_net_cvq_add_and_wait() adds SVQ control commands to SVQ,
> + * kicks the device and polls the device used buffers.
> + *
> + * Return the length written by the device.
> + */
> +static ssize_t vhost_vdpa_net_cvq_add_and_wait(VhostVDPAState *s,

Nit: is it better to use "poll" or "sync" other than wait?

Other than this:

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> +                                    size_t out_len, size_t in_len)
>  {
>      /* Buffers for the device */
>      const struct iovec out =3D {
> @@ -636,7 +642,7 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState=
 *s, uint8_t class,
>      memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
>      memcpy(s->cvq_cmd_out_buffer + sizeof(ctrl), data, data_size);
>
> -    return vhost_vdpa_net_cvq_add(s, sizeof(ctrl) + data_size,
> +    return vhost_vdpa_net_cvq_add_and_wait(s, sizeof(ctrl) + data_size,
>                                    sizeof(virtio_net_ctrl_ack));
>  }
>
> @@ -753,7 +759,8 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShad=
owVirtqueue *svq,
>          dev_written =3D sizeof(status);
>          *s->status =3D VIRTIO_NET_OK;
>      } else {
> -        dev_written =3D vhost_vdpa_net_cvq_add(s, out.iov_len, sizeof(st=
atus));
> +        dev_written =3D vhost_vdpa_net_cvq_add_and_wait(s, out.iov_len,
> +                                                      sizeof(status));
>          if (unlikely(dev_written < 0)) {
>              goto out;
>          }
> --
> 2.25.1
>



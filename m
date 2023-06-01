Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5899719F61
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 16:14:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4j3b-0007LH-BI; Thu, 01 Jun 2023 10:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q4j3Z-0007Kk-BE
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:13:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q4j3X-0005MJ-UF
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685628815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JD8Yi9qf+cljXkw14unXmIW6zIHBiWUj/e0lGabcqqY=;
 b=IUIhNPn7460yGWKfLarjOODnOShTNefg8zaTZDvvEGDMOGhqTKhCEojDTttNLN0BUBVM5j
 XFCQStOjCkZJfUBhszOVqC5zt+jOf/BiYQD9K8X4kBJv27SWK83BKZxCga0vK6pn350yRE
 KsPYjb+T14E12H6XDAiwypowJCW7fT4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-68LeBsAUMgOhN3gKr16VNA-1; Thu, 01 Jun 2023 10:13:33 -0400
X-MC-Unique: 68LeBsAUMgOhN3gKr16VNA-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6af6fcdd0dfso712953a34.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 07:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685628813; x=1688220813;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JD8Yi9qf+cljXkw14unXmIW6zIHBiWUj/e0lGabcqqY=;
 b=faRFBmlsJavM9bo8F7L2SRiWJSFZjuqrI/k15D6z92DLF8BJ74keqZrOqXO65HoQxD
 wC8CD5PMkly9fzsdZMjqLJkOM0IDT2PBBAY6RA4XplxVVA/2t8fM6RWvPEfU3NmgSS7/
 w9eCte7GwOqvlVuycjIfnlH6MS9CIvWdMTm6T3ihbMknwhmOqOqGjuLel5+97zwzP9ND
 OszfRhl91US+2Ce4H8CKvkaweKukKG8jhAnR1oOGyUPnWAgo6x1CigDDAaYAeB65KcmW
 H+GCYaqrWEsekR1xLuWZgw/frF5z+rsyh/zMkFinvNp3cXRAkdj/Y/k669kOo5aHdPxH
 bdJQ==
X-Gm-Message-State: AC+VfDzcCK840/2qdt1FFF0a6CbcTA8kEmvOFaDw40R3XT5c3YXZAoDR
 bM2yzGbMnRP6jZ/naeIAgPPPOTKitTNZr+/L++kXluf0Wt6qE3CTnyZlnrf36TitmPwye+DdMyo
 UaUmzVn0BrUwI8Jk7CEr5U3J2RrYGgCA=
X-Received: by 2002:a05:6358:7e9e:b0:127:bde9:1a5d with SMTP id
 o30-20020a0563587e9e00b00127bde91a5dmr2883233rwn.25.1685628812871; 
 Thu, 01 Jun 2023 07:13:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6xCEQJpcZe0gQmxkVnesCKJMdkZc3EtCD9kMcPnR5tt3T9evIPX2nno0wfz4qktKfDkQLigw7WeQZ8ZJnsgig=
X-Received: by 2002:a05:6358:7e9e:b0:127:bde9:1a5d with SMTP id
 o30-20020a0563587e9e00b00127bde91a5dmr2883219rwn.25.1685628812592; Thu, 01
 Jun 2023 07:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685623090.git.yin31149@gmail.com>
 <afa2e25ae333dba5867e3d839fba785d5d3508c0.1685623090.git.yin31149@gmail.com>
In-Reply-To: <afa2e25ae333dba5867e3d839fba785d5d3508c0.1685623090.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 1 Jun 2023 16:12:56 +0200
Message-ID: <CAJaqyWcS6enrAxwcGsi2qVt+7pHOkZg4E+t-=rmvsdPFbN-S6w@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] vdpa: Add vhost_vdpa_net_load_offloads()
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

On Thu, Jun 1, 2023 at 3:49=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com> =
wrote:
>
> This patch introduces vhost_vdpa_net_load_offloads() to
> restore offloads state at device's startup.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>  net/vhost-vdpa.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index e907a3c792..0e647886d1 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -678,6 +678,40 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>      return *s->status !=3D VIRTIO_NET_OK;
>  }
>
> +static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
> +                                        const VirtIONet *n)
> +{
> +    uint64_t offloads;
> +    ssize_t dev_written;
> +
> +    if (!virtio_vdev_has_feature(&n->parent_obj,
> +                                 VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
> +        return 0;
> +    }
> +
> +    offloads =3D cpu_to_le64(n->curr_guest_offloads);

n->curr_guest_offloads is already stored in CPU order, we should only
byte-swap it by the time of sending.

Thanks!

> +
> +    if (offloads =3D=3D virtio_net_supported_guest_offloads(n)) {
> +        /*
> +         * According to VirtIO standard, "Upon feature negotiation
> +         * corresponding offload gets enabled to preserve
> +         * backward compatibility."
> +         * So we do not need to send this CVQ command if the guest
> +         * also enables all supported offloads.
> +         */
> +        return 0;
> +    }
> +
> +    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_GUEST_OFF=
LOADS,
> +                                          VIRTIO_NET_CTRL_GUEST_OFFLOADS=
_SET,
> +                                          &offloads, sizeof(offloads));
> +    if (unlikely(dev_written < 0)) {
> +        return dev_written;
> +    }
> +
> +    return *s->status !=3D VIRTIO_NET_OK;
> +}
> +
>  static int vhost_vdpa_net_load(NetClientState *nc)
>  {
>      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> @@ -700,6 +734,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
>      if (unlikely(r)) {
>          return r;
>      }
> +    r =3D vhost_vdpa_net_load_offloads(s, n);
> +    if (unlikely(r)) {
> +        return r;
> +    }
>
>      return 0;
>  }
> --
> 2.25.1
>



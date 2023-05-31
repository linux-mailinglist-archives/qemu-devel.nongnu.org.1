Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6CD717354
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 03:48:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Aw4-0000BJ-Hi; Tue, 30 May 2023 21:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q4Aw1-0000B7-QJ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 21:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q4Aw0-0000XM-De
 for qemu-devel@nongnu.org; Tue, 30 May 2023 21:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685497651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MreRlCo3Jeq3esacjfmtre7PKmUoEf1jLKzdOt91U1c=;
 b=DkHiLLnfhnkkmMBRSaRo/EnYpT/4Rwv3qK3RoDgV0LxcW1dqEjuuaqvL3DmdjO+cKf8HZQ
 vkzMmujqOQCXfE2F9KZtzwHLRgv9YlKBpMVM7RnvmSyBhoWFPIHLQNhmr0ztaSz+eGqgKW
 Em3mxPSiBJ/ms/oD5Jip195s+YwVeG4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-6to9jKwhPWW0QPGPyltkKg-1; Tue, 30 May 2023 21:47:29 -0400
X-MC-Unique: 6to9jKwhPWW0QPGPyltkKg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2af1774bf66so26266251fa.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 18:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685497648; x=1688089648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MreRlCo3Jeq3esacjfmtre7PKmUoEf1jLKzdOt91U1c=;
 b=JuxVTabxFtYr8Xb8uMpRgu9V+1MuuI8YXv8w31f1w+anOak43N333hwqeha6Yk00RF
 r0eoaAbpPKhVI+k7Q5yzdT7Vfj6CnoKhUrIHjLu3pH6tDMDoD6hNdTNt4+v+FtdQRqFF
 Bf+8pALoUxuiVXB8vSut2jc6gEmRDCznCYCCuc//Hmru0OdDUDRnCp1Re7KAFe7scoVs
 n1TVe49udbudVp2F+JDplyNq6XRO22v2i8goV0E7DiF+mKRsIcao5YPDDfcnSb3Iyavc
 PvGHHNZmVHR2tVwAqjaD28K0P/IGXtSZDGN080Ms3C36jZ+N1KklNjAuY3lGlZspK50U
 pSew==
X-Gm-Message-State: AC+VfDzpbmK28EBglWR2vnaz4kyNRC+bjPfxYPkQk6ptbeOJ52PAZpr6
 e4c67eyEzN1WA+rvQZLN5CjJPTx8+IWedZacrOeyH84XjESTqXqdZGo5P31MapbHS5hkyOiCPir
 vLxnvHcBtrHhDz0RbN6DIE6kbSfkU34w=
X-Received: by 2002:a2e:8881:0:b0:2af:22a0:81ec with SMTP id
 k1-20020a2e8881000000b002af22a081ecmr1724888lji.27.1685497648074; 
 Tue, 30 May 2023 18:47:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4SOtnB1dF0/S3MeCgMw0jtZQyL5C1s5/HoJX1IHdmeOkzuTbCx3fTQ/LcmqE/VsHTGs49CgXKDptETZ8iRKaU=
X-Received: by 2002:a2e:8881:0:b0:2af:22a0:81ec with SMTP id
 k1-20020a2e8881000000b002af22a081ecmr1724882lji.27.1685497647818; Tue, 30 May
 2023 18:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685359572.git.yin31149@gmail.com>
 <ab861a8237c5e337bb0f969e1e8e761bc73901d5.1685359572.git.yin31149@gmail.com>
In-Reply-To: <ab861a8237c5e337bb0f969e1e8e761bc73901d5.1685359572.git.yin31149@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 May 2023 09:47:16 +0800
Message-ID: <CACGkMEvza0nAWqbQ1-KiLGRRxSxYvJoTrtTgUPV-KQpSuJFB6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: Add vhost_vdpa_net_load_offloads
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: eperezma@redhat.com, 18801353760@163.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

On Mon, May 29, 2023 at 9:18=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> This patch introduces vhost_vdpa_net_load_offloads() to
> restore offloads state at device's startup.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>  net/vhost-vdpa.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 37cdc84562..682c749b19 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -680,6 +680,28 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>      return *s->status !=3D VIRTIO_NET_OK;
>  }
>
> +static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
> +                                        const VirtIONet *n)
> +{
> +    uint64_t features, offloads;
> +    ssize_t dev_written;
> +
> +    features =3D n->parent_obj.guest_features;

Any reason you need to do tricks like this instead of using
virtio_xxx_has_features()?

> +    if (!(features & BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))) {
> +        return 0;
> +    }
> +
> +    offloads =3D cpu_to_le64(n->curr_guest_offloads);
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
> @@ -702,6 +724,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
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



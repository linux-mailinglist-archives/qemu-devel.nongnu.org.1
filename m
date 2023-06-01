Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD03271A060
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 16:38:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4jRF-0002aC-Uf; Thu, 01 Jun 2023 10:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q4jRD-0002Wv-Dz
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q4jRB-0001gK-SE
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685630281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J69dTFaLgIsGNbW9/tbMrGxrpYaWHuQ0cDuJekAHrnI=;
 b=EUSpHwdioT1ignywXGjjpRgFXOIrbaO0jAUvNXxIv64iklIKGqZ5i4zvjvVlqcifdz+R3E
 yASPnJNmdXzqLmsuCoutAgnXospazpOHJakPo+yx3On3AWzCwDS/vK+B1PJon55NiUnv7l
 emhfxMsugyT8QrOI/duUBRkUlUTuJKs=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-Q5p-9DIsPCO61R2olJ1LDA-1; Thu, 01 Jun 2023 10:37:59 -0400
X-MC-Unique: Q5p-9DIsPCO61R2olJ1LDA-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-ba8338f20bdso1379181276.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 07:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685630279; x=1688222279;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J69dTFaLgIsGNbW9/tbMrGxrpYaWHuQ0cDuJekAHrnI=;
 b=DXoJzLJwwyG6c1AfADaKp70x5PEl5SEi+3EWluMdBBJUaZW+yN3GG1XnKBLGZSLfow
 3JuJsKfpyHRA6qHM2dkBUzLiMzMOqRPua07ppxoFdZictX7WiAqdRCnfq48NioWZyaW1
 4gU4GUdm4JrdFMMBYH8sevUatIXDLV/73F4rmc1BadvTcRP9HjJhSs/xaWLRNeHEQzTC
 aEG8wi55ESgJzHOe2NnvrgNiSFFYtvdMl9Qnb7eic/7e9N0qWsGv30Mx6qp/bWKHaD1X
 tvhoBp6vAdaQ7HRBBzPuH4733xGgcFPCxE4WUzSEN9CPV3FxuVXOh5DBO8nqqezCDL/d
 nR1Q==
X-Gm-Message-State: AC+VfDx8gAy+Fxgnd9vt/SC2i6TAqJEkE7M2miWpivuSO+GCVmDCrXAb
 NZqpkl72ktOhlUQkqDlJlqTR45xDD3EtzG6p6OfYtJvMqVS7z+lIHLyadajIdyQTR5c92EBM6h0
 nUym7K+IwH27aUrIfN58xIC6d1Tiu/BU=
X-Received: by 2002:a25:bc50:0:b0:bad:e86:8fda with SMTP id
 d16-20020a25bc50000000b00bad0e868fdamr127381ybk.22.1685630279376; 
 Thu, 01 Jun 2023 07:37:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5e2WgWi+Z1ovycZev3F1MWeQBOLg6wby6Bts0BiO77INt5IpLkxZtUGAfjnNleIl7nSqw2wCt5iZvlbe4HdD8=
X-Received: by 2002:a25:bc50:0:b0:bad:e86:8fda with SMTP id
 d16-20020a25bc50000000b00bad0e868fdamr127369ybk.22.1685630279122; Thu, 01 Jun
 2023 07:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685623090.git.yin31149@gmail.com>
 <68226edccea8d6e51ea3f2da26d5ff2da2abc224.1685623090.git.yin31149@gmail.com>
In-Reply-To: <68226edccea8d6e51ea3f2da26d5ff2da2abc224.1685623090.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 1 Jun 2023 16:37:23 +0200
Message-ID: <CAJaqyWcE0UgUYL8hwGNFNTOvqa8aSYF-_FoTc4+dYC0j+A5LwQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] virtio-net: expose
 virtio_net_supported_guest_offloads()
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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
> To support restoring offloads state in vdpa, need to expose
> the function virtio_net_supported_guest_offloads().
> QEMU uses this function to get the guest supported offloads
> and no needs to send the corresponding CVQ command if guest

doesn't need to send?

> enables all supported features.
>

Good! I'd add the same message as the next patch's comment, to signal
it is because the device has already enabled by default:

+         * According to VirtIO standard, "Upon feature negotiation
+         * corresponding offload gets enabled to preserve
+         * backward compatibility."
+         * So we do not need to send this CVQ command if the guest
+         * also enables all supported offloads.

Thanks!


> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>  hw/net/virtio-net.c            | 2 +-
>  include/hw/virtio/virtio-net.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 7b27dad6c4..7e8897a8bc 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -874,7 +874,7 @@ static uint64_t virtio_net_guest_offloads_by_features=
(uint32_t features)
>      return guest_offloads_mask & features;
>  }
>
> -static inline uint64_t virtio_net_supported_guest_offloads(const VirtION=
et *n)
> +uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
>      return virtio_net_guest_offloads_by_features(vdev->guest_features);
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
> index ef234ffe7e..5f5dcb4572 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -227,5 +227,6 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
>                                    unsigned out_num);
>  void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
>                                     const char *type);
> +uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n);
>
>  #endif
> --
> 2.25.1
>



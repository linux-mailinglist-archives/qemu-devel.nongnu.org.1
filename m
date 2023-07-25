Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA92760AB7
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 08:45:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOBlx-00045D-30; Tue, 25 Jul 2023 02:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qOBle-00044V-00
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 02:43:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qOBlc-0005z0-9w
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 02:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690267411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f41a2EIE277jevUdj1TGX09GS4/0K7LqHcmSKThs/kg=;
 b=PFwyIkEw6jopVjqBo17d93dpQ7dRJ+NIpfryt1+kHpBwd/sx1h2cTe+KdzAojyidCD2Fmd
 GZZjRuy6S6sPdoGlOXd8a0tDHEUAWKyDHV6hvSNju32/uot5+t7VonvYrEqimBBPyTlECr
 C9ddYOhEDo7rcVQHs9iytoF+TNXMxUs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-zyFbPV5iMCWR2LBz9OxWzw-1; Tue, 25 Jul 2023 02:43:29 -0400
X-MC-Unique: zyFbPV5iMCWR2LBz9OxWzw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b708e49042so42541451fa.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 23:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690267406; x=1690872206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f41a2EIE277jevUdj1TGX09GS4/0K7LqHcmSKThs/kg=;
 b=OuWrE4AG/qJO46T3pi+wdQj0WxjxxLF6ROttFbY1EI0gERuZhjgBAeIf3AbF3Qf5gB
 dr9SDN4ioU4LyC3ScP8OAuLXo7wemlVNETyUdSQbqOY8VQxbh2DRownp3Whxl77pshaP
 fx+T2ybYHvmavbpG+kJ3GjcsWVQtI3WBsTV+04SPlwLrG2plaEaATISjfSTtyfeBLhQZ
 cHWz/wwxTmulZPgYlk0mctDa8S2Jet48PeZwklGhMlBmV4FscQT4pA0VRDdQdcIBvb9+
 ZGXcG9Ph7DFRrshv5o2GXRHLGkpIyUnJVBDr0YD+ejCypQ3+vTTZjl1gmpZxcJxJlK6I
 YgDA==
X-Gm-Message-State: ABy/qLb2vS0SIJ+GHcVLdmWFUr+qCYYnIymNyB0S0n0G7WN4Ueocn/p1
 lLWudBnZgcKyjxfm8xu+ZrigdyFDpW9/c/tyIj0lIUi78bg7V/UKo4yjwh+M6oZmmIxqzKPd1KN
 hBGvEkAxkUPIcOK8Sv3AgtsyzhKAHV6Mab5XA5tB66A==
X-Received: by 2002:a2e:9d15:0:b0:2b6:cca1:9760 with SMTP id
 t21-20020a2e9d15000000b002b6cca19760mr7088185lji.27.1690267406327; 
 Mon, 24 Jul 2023 23:43:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGk/SW5DJcRzO9OURtbGa27hLEqUBmbnL/J714jZAAx+ZsCJlK/sTj+kvjT1NyaycIB/3brJT2ncKkgT42T2Gw=
X-Received: by 2002:a2e:9d15:0:b0:2b6:cca1:9760 with SMTP id
 t21-20020a2e9d15000000b002b6cca19760mr7088172lji.27.1690267406014; Mon, 24
 Jul 2023 23:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690100802.git.yin31149@gmail.com>
 <95af0d013281282f48ad3f47f6ad1ac4ca9e52eb.1690100802.git.yin31149@gmail.com>
In-Reply-To: <95af0d013281282f48ad3f47f6ad1ac4ca9e52eb.1690100802.git.yin31149@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jul 2023 14:43:14 +0800
Message-ID: <CACGkMEu8E-a3Go=N-BHwqht03ZW2pAh2mNntVh7X6n7TQUwzpg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] virtio-net: do not reset vlan filtering at
 set_features
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: mst@redhat.com, eperezma@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sun, Jul 23, 2023 at 5:27=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> From: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> This function is called after virtio_load, so all vlan configuration is
> lost in migration case.
>
> Just allow all the vlan-tagged packets if vlan is not configured, and
> trust device reset to clear all filtered vlans.
>
> Fixes: 0b1eaa8803 ("virtio-net: Do not filter VLANs without F_CTRL_VLAN")
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Reviewed-by: Hawkins Jiawei <yin31149@gmail.com>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  hw/net/virtio-net.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 7102ec4817..d20d5a63cd 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1006,9 +1006,7 @@ static void virtio_net_set_features(VirtIODevice *v=
dev, uint64_t features)
>          vhost_net_save_acked_features(nc->peer);
>      }
>
> -    if (virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
> -        memset(n->vlans, 0, MAX_VLAN >> 3);
> -    } else {
> +    if (!virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
>          memset(n->vlans, 0xff, MAX_VLAN >> 3);
>      }
>
> --
> 2.25.1
>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D2173D021
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 12:38:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDN7r-0001mg-Gl; Sun, 25 Jun 2023 06:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qDN7q-0001mS-15
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 06:37:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qDN7o-0001oT-3o
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 06:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687689463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dp1MfnbCajGD1j/voF28U+AM9RUDLnKUu6B0KAGiJSg=;
 b=S8V1/sc1gPPN0XA9J6VnuB2eXZah8/somHXlqWtW4wYyLSjCNZtwzwKbFzVwrw5Hj5SNv1
 mE+G69pMrwxFqK2wZ2IMeFNWO9aAOMRaKBJta2qd9TaXrsphONAAXcFHsIa0Il+xRHk1HU
 x7yQf/fDkZ3H16LuKoz04UzEufPzLdU=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-OLoKrmDsM5m3ldRL21Lelw-1; Sun, 25 Jun 2023 06:37:41 -0400
X-MC-Unique: OLoKrmDsM5m3ldRL21Lelw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-564fb1018bcso31230847b3.0
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 03:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687689461; x=1690281461;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dp1MfnbCajGD1j/voF28U+AM9RUDLnKUu6B0KAGiJSg=;
 b=InQPECmlXqUpXVuV6+lU0aZaHueO6XiHGmOOB5V9jMaFsdftJxrQOaye6Je4lZM19J
 FZw03g1hfG7ZLwcZJmsB4G1bLyxYHcnvu7gjKA+dxStZ7ietL2czp4SehXSSr6mXIbgf
 xMX16wkgU3KEjyl8NphyEpFSbh7FdiUqtwc9eZJfz20nX2q+8K7FdUu5+oL/3NL0qAsT
 aOfZbT03GnydNfB7FFEyGYapnuH/FQLZspulhoMG22RAS9SmwRQxt/I/oalQsVuwW1eU
 4ELBATSdC5ufB50DMs7c7CRPhQYLFd1r03c6E3hhR6IfZizIjRAM5rKOhxlE5GHGqpmP
 3phQ==
X-Gm-Message-State: AC+VfDzMC+OwgiHwS0FgfsT48v203X2VXEuvawDbG4FezSNQN9kpIVWQ
 F1fYTVKubXt21dadMeGbxs3x8/eDfwHDVEVnbyeBqRmpjbSCrNBxQfagKLfZREl0MseIro7rbTO
 PFXkv17f0cURWXOsk32zcvY7wpiQJz7o=
X-Received: by 2002:a81:4e81:0:b0:570:7b60:147b with SMTP id
 c123-20020a814e81000000b005707b60147bmr22931813ywb.50.1687689461245; 
 Sun, 25 Jun 2023 03:37:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7+8oJdtsU7uYxm+Y9Jud3ddlXE2depGvq2ibhfnHxjKNedYTZcIRBBrecYMXlTGXM1QApQW3tWgzlTiD7LQr0=
X-Received: by 2002:a81:4e81:0:b0:570:7b60:147b with SMTP id
 c123-20020a814e81000000b005707b60147bmr22931805ywb.50.1687689461025; Sun, 25
 Jun 2023 03:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687402580.git.yin31149@gmail.com>
 <00f72fe154a882fd6dc15bc39e3a1ac63f9dadce.1687402580.git.yin31149@gmail.com>
In-Reply-To: <00f72fe154a882fd6dc15bc39e3a1ac63f9dadce.1687402580.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Sun, 25 Jun 2023 12:37:05 +0200
Message-ID: <CAJaqyWcS+WN4vyKb4gNLarUsFKbt3hgQ5e9vDe2bGWSz3bue2g@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] vdpa: Restore MAC address filtering state
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Jun 22, 2023 at 5:02=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> This patch refactors vhost_vdpa_net_load_mac() to
> restore the MAC address filtering state at device's startup.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>  net/vhost-vdpa.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index ecfa8852b5..10264d3e96 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -651,8 +651,45 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s=
, const VirtIONet *n)
>          if (unlikely(dev_written < 0)) {
>              return dev_written;
>          }
> +        if (*s->status !=3D VIRTIO_NET_OK) {
> +            return -EINVAL;
> +        }

I think this part should go in its individual patch, explaining why it
is needed and with corresponding Fixes tag.

> +    }
> +
> +    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)) {
> +        /* Load the MAC address filtering */
> +        uint32_t uni_entries =3D n->mac_table.first_multi,
> +                 uni_macs_size =3D uni_entries * ETH_ALEN,
> +                 uni_size =3D sizeof(struct virtio_net_ctrl_mac) + uni_m=
acs_size,
> +                 mul_entries =3D n->mac_table.in_use - uni_entries,
> +                 mul_macs_size =3D mul_entries * ETH_ALEN,
> +                 mul_size =3D sizeof(struct virtio_net_ctrl_mac) + mul_m=
acs_size,
> +                 data_size =3D uni_size + mul_size;
> +        void *data =3D g_malloc(data_size);

If we keep this part, please use g_autofree here [1].

But I think it is not worth copying all the data actually. Maybe it is
worth it to convert vhost_vdpa_net_load_cmd to const iovec?

Thanks!

[1] https://www.qemu.org/docs/master/devel/style#automatic-memory-deallocat=
ion

> +        struct virtio_net_ctrl_mac *ctrl_mac;
> +
> +        /* Pack the non-multicast(unicast) MAC addresses */
> +        ctrl_mac =3D data;
> +        ctrl_mac->entries =3D cpu_to_le32(uni_entries);
> +        memcpy(ctrl_mac->macs, n->mac_table.macs, uni_macs_size);
> +
> +        /* Pack the multicast MAC addresses */
> +        ctrl_mac =3D data + uni_size;
> +        ctrl_mac->entries =3D cpu_to_le32(mul_entries);
> +        memcpy(ctrl_mac->macs, &n->mac_table.macs[uni_macs_size],
> +               mul_macs_size);
> +
> +        ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CT=
RL_MAC,
> +                                                  VIRTIO_NET_CTRL_MAC_TA=
BLE_SET,
> +                                                  data, data_size);
> +        g_free(data);
>
> -        return *s->status !=3D VIRTIO_NET_OK;
> +        if (unlikely(dev_written < 0)) {
> +            return dev_written;
> +        }
> +        if (*s->status !=3D VIRTIO_NET_OK) {
> +            return -EINVAL;
> +        }
>      }
>
>      return 0;
> --
> 2.25.1
>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D35B977F438
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 12:20:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWa76-0006fV-G5; Thu, 17 Aug 2023 06:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qWa74-0006a4-Eq
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 06:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qWa71-0004ck-Uq
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 06:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692267619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kto+SHxtTmm6leAC0FAgG+sA5wmi06kqhsGhSnbwdQ0=;
 b=Vgi9t+7ANc2eTvsEYXCCsJGfLe3/TSdW4DBjpCEtru4/64He8pmPAm3NT41u8SDtkEsoCX
 S1ofZD7+8SeD4gOSL0AMS7cnMO5m8cjOgRErGhdrddts/gIH8TnDp3f38XuGxAW79G2aSL
 wd7/lG8eedarQ63qv28JUj9BqTSdSCg=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-qa8xIBFOM-OTqyNLEHyQmQ-1; Thu, 17 Aug 2023 06:20:17 -0400
X-MC-Unique: qa8xIBFOM-OTqyNLEHyQmQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-d637af9a981so8190289276.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 03:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692267617; x=1692872417;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kto+SHxtTmm6leAC0FAgG+sA5wmi06kqhsGhSnbwdQ0=;
 b=A8fYmp/aoJuQJ1ly9CWMbDPNw/KmBRky9Z19dxd5ULvBPtlNstcLHYioKVq2/mbr8G
 OnUEGc6rIEi8zpgf1jnRVRGlAAPkgvs/DLUGRibpLh9RgHoLi4pHeDDQmykq/f43OjW7
 WadAklFy90jpPhGaCJvrrWYC/d3dLmw6LLLe5RDVQsIklyah5RhzOwEmnlIO/2S3/ZtH
 DRj8eD4B9kaAyVFiH4MOIoAxTEWuDw8uC5izwe7FPBSNqCk2FgL328uFSf/GO2AgqcGf
 eLzDKc4TNtJtn3+RHAFEPPuInJL6dX2Vgw6EyFCq78qK6X5iEMHIF9ouJjsoX68lRtLh
 p8NQ==
X-Gm-Message-State: AOJu0YxPJL2JLpXd7BGgWzug6gH/HdXgEzpU2RlDR5a6XYOAr8moW40H
 1Du0M0mzC/x4lNh94HOHPP+2zQm274kAv0WGeTBvpcjINigRsrDNp4ugjwLU+gvd4bxISbGAV6J
 I6E7/+8VTw3psjoVdQpl2XYg47yz67Pg=
X-Received: by 2002:a25:143:0:b0:d10:17c9:2f0d with SMTP id
 64-20020a250143000000b00d1017c92f0dmr3815494ybb.2.1692267616944; 
 Thu, 17 Aug 2023 03:20:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkVeUNeiVAmOOH40seQ7r8srH75NUP0H3YQ/kxFCP+IuznGeU9fZBSJc+tKQXmmZrcEaHKGBT7amimTlJjWkM=
X-Received: by 2002:a25:143:0:b0:d10:17c9:2f0d with SMTP id
 64-20020a250143000000b00d1017c92f0dmr3815481ybb.2.1692267616678; Thu, 17 Aug
 2023 03:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688743107.git.yin31149@gmail.com>
 <804cedac93e19ba3b810d52b274ca5ec11469f09.1688743107.git.yin31149@gmail.com>
In-Reply-To: <804cedac93e19ba3b810d52b274ca5ec11469f09.1688743107.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 17 Aug 2023 12:19:40 +0200
Message-ID: <CAJaqyWe=74NoCUU4nk4oBpGOV6zRsUSJjhPp+TRCZYNnFndOzw@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] vdpa: Restore packet receive filtering state
 relative with _F_CTRL_RX feature
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Fri, Jul 7, 2023 at 5:27=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com> =
wrote:
>
> This patch introduces vhost_vdpa_net_load_rx_mode()
> and vhost_vdpa_net_load_rx() to restore the packet
> receive filtering state in relation to
> VIRTIO_NET_F_CTRL_RX feature at device's startup.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
> v3:
>   - return early if mismatch the condition suggested by Eugenio
>   - remove the `on` variable suggested by Eugenio
>
> v2: https://lore.kernel.org/all/d9d7641ef25d7a4477f8fc4df8cba026380dab76.=
1688051252.git.yin31149@gmail.com/
>   - avoid sending CVQ command in default state suggested by Eugenio
>
> v1: https://lore.kernel.org/all/86eeddcd6f6b04e5c1e44e901ddea3b1b8b6c183.=
1687402580.git.yin31149@gmail.com/
>
>  net/vhost-vdpa.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 7189ccafaf..e80d4b4ef3 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -788,6 +788,87 @@ static int vhost_vdpa_net_load_offloads(VhostVDPASta=
te *s,
>      return 0;
>  }
>
> +static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
> +                                       uint8_t cmd,
> +                                       uint8_t on)
> +{
> +    const struct iovec data =3D {
> +        .iov_base =3D &on,
> +        .iov_len =3D sizeof(on),
> +    };
> +    return vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_RX,
> +                                   cmd, &data, 1);
> +}
> +
> +static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
> +                                  const VirtIONet *n)
> +{
> +    ssize_t dev_written;
> +
> +    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)) =
{
> +        return 0;
> +    }
> +
> +    /*
> +     * According to virtio_net_reset(), device turns promiscuous mode
> +     * on by default.
> +     *
> +     * Addtionally, according to VirtIO standard, "Since there are
> +     * no guarantees, it can use a hash filter or silently switch to
> +     * allmulti or promiscuous mode if it is given too many addresses.".
> +     * QEMU marks `n->mac_table.uni_overflow` if guest sets too many
> +     * non-multicast MAC addresses, indicating that promiscuous mode
> +     * should be enabled.
> +     *
> +     * Therefore, QEMU should only send this CVQ command if the
> +     * `n->mac_table.uni_overflow` is not marked and `n->promisc` is off=
,
> +     * which sets promiscuous mode on, different from the device's defau=
lts.
> +     *
> +     * Note that the device's defaults can mismatch the driver's
> +     * configuration only at live migration.
> +     */
> +    if (!n->mac_table.uni_overflow && !n->promisc) {
> +        dev_written =3D vhost_vdpa_net_load_rx_mode(s,
> +                                            VIRTIO_NET_CTRL_RX_PROMISC, =
0);
> +        if (unlikely(dev_written < 0)) {
> +            return dev_written;
> +        }
> +        if (*s->status !=3D VIRTIO_NET_OK) {
> +            return -EIO;
> +        }
> +    }
> +
> +    /*
> +     * According to virtio_net_reset(), device turns all-multicast mode
> +     * off by default.
> +     *
> +     * According to VirtIO standard, "Since there are no guarantees,
> +     * it can use a hash filter or silently switch to allmulti or
> +     * promiscuous mode if it is given too many addresses.". QEMU marks
> +     * `n->mac_table.multi_overflow` if guest sets too many
> +     * non-multicast MAC addresses.
> +     *
> +     * Therefore, QEMU should only send this CVQ command if the
> +     * `n->mac_table.multi_overflow` is marked or `n->allmulti` is on,
> +     * which sets all-multicast mode on, different from the device's def=
aults.
> +     *
> +     * Note that the device's defaults can mismatch the driver's
> +     * configuration only at live migration.
> +     */
> +    if (n->mac_table.multi_overflow || n->allmulti) {
> +        dev_written =3D vhost_vdpa_net_load_rx_mode(s,
> +                                            VIRTIO_NET_CTRL_RX_ALLMULTI,=
 1);
> +        if (unlikely(dev_written < 0)) {
> +            return dev_written;
> +        }
> +        if (*s->status !=3D VIRTIO_NET_OK) {
> +            return -EIO;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  static int vhost_vdpa_net_load(NetClientState *nc)
>  {
>      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> @@ -814,6 +895,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
>      if (unlikely(r)) {
>          return r;
>      }
> +    r =3D vhost_vdpa_net_load_rx(s, n);
> +    if (unlikely(r)) {
> +        return r;
> +    }
>
>      return 0;
>  }
> --
> 2.25.1
>



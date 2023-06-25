Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C6473D02D
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 12:51:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDNJG-0006jF-RO; Sun, 25 Jun 2023 06:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qDNJF-0006ix-8o
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 06:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qDNJB-0004kR-LS
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 06:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687690168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZOajQiJ30jS2XwvI81zvx6VDZVkmF4tHB6dL8oAABEM=;
 b=G79kzGdXkuwy/KJdcFfxTT+ojfHnuycF83S3wK/i2EHWtRQ5iwcT48Sl57WXPwPKMgDKMn
 miiCBo+UN8Lcxj5V5Kfv5rVga23/i4+pP5FLUkS1Dtgfdaz5Cwzk1A6D9hdwNVP5S5IWxX
 rtAn1JzfYEVwTSE9P/VwM8VAyU8B578=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-O4_rgttrO9yeuapX9FgCOg-1; Sun, 25 Jun 2023 06:49:26 -0400
X-MC-Unique: O4_rgttrO9yeuapX9FgCOg-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-bd6df68105cso3133125276.2
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 03:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687690165; x=1690282165;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZOajQiJ30jS2XwvI81zvx6VDZVkmF4tHB6dL8oAABEM=;
 b=dfRAW/YCmUEzjYFjs+/1xmQE4v+c+obDBpbGuV4qPzC6CNisGMLCPNQ2AtzhUnq08/
 rxR+QJnX5aeMo3v/dMEhpjc9lAyVnX8qwfLTmuY7nXvv7VmfzWxQIdYtHmb9MsJL/T5A
 UhfcKgvs5OLLXojc13H7MfL1l2RzqL4v6xHyypfK45yMxSHxWmALrbnqpC4jMAJGLh+C
 U+w7fGEv13QNgMnM2BXuQbD9Xunnd2H4hjtNJ0zTvU701bj46Z3YdTZqkJgBQ95cOIoP
 D/5qBOKn2bPt7TCkGFfbjILw3bYEbOrfkztVOtk0OIzkWHY6wudRBbYmgTkAoNiMMLXS
 mwvA==
X-Gm-Message-State: AC+VfDwHlF4yNDISp9VpEEF2TWR92nJJqXJ0SQlqqjul8rrKHM2b5Igo
 gmJeGVT7uUaED4DXiEMPqxgCjbQc91D9OqrrdR4OIspwPj4Zh8Yog3mSUdUbI4aWqqhUaHdDtlp
 6j0Z8DRygCjREbxwp4XW533ogNmJcRuw9LjhCA8qDvg==
X-Received: by 2002:a25:6652:0:b0:c0f:ab2d:a9a1 with SMTP id
 z18-20020a256652000000b00c0fab2da9a1mr4091319ybm.46.1687690165697; 
 Sun, 25 Jun 2023 03:49:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7cfiO7sFCDFZQgfyVjqdye6BChVhmt6A09sp2xzNldQ8Mmo6kYu+DkIspFWxwI3RVVVWDi/hA+H+m0Z+q+qbE=
X-Received: by 2002:a25:6652:0:b0:c0f:ab2d:a9a1 with SMTP id
 z18-20020a256652000000b00c0fab2da9a1mr4091312ybm.46.1687690165478; Sun, 25
 Jun 2023 03:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230622010651.22698-1-yin31149@gmail.com>
In-Reply-To: <20230622010651.22698-1-yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Sun, 25 Jun 2023 12:48:49 +0200
Message-ID: <CAJaqyWfr6XTz7qhMfYR7kJW_A409N7x6hcYQd2ypUD_p6kyc_g@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Increase out buffer size for CVQ commands
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Thu, Jun 22, 2023 at 3:07=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> According to the VirtIO standard, "Since there are no guarantees,
> it can use a hash filter or silently switch to
> allmulti or promiscuous mode if it is given too many addresses."
> To achive this, QEMU ignores MAC addresses and marks `mac_table.x_overflo=
w`
> in the device internal state in virtio_net_handle_mac()
> if the guest sets more than `MAC_TABLE_ENTRIES` MAC addresses
> for the filter table.
>
> However, the problem is that QEMU never marks the `mac_table.x_overflow`
> for the vdpa device internal state when the guest sets more than
> `MAC_TABLE_ENTRIES` MAC addresses.
>
> To be more specific, currently QEMU offers a buffer size of
> vhost_vdpa_net_cvq_cmd_len() for CVQ commands, which represents the size =
of
> VIRTIO_NET_CTRL_MAC_TABLE_SET command with a maximum `MAC_TABLE_ENTRIES`
> MAC addresses.
>
> Consequently, if the guest sets more than `MAC_TABLE_ENTRIES` MAC address=
es,
> QEMU truncates the CVQ command data and copies this incomplete command
> into the out buffer. In this situation, virtio_net_handle_mac() fails the
> integrity check and returns VIRTIO_NET_ERR instead of marking
> `mac_table.x_overflow` and returning VIRTIO_NET_OK, since the copied
> CVQ command in the buffer is incomplete and flawed.
>
> This patch solves this problem by increasing the buffer size to
> vhost_vdpa_net_cvq_cmd_page_len(), which represents the size of the buffe=
r
> that is allocated and mmaped. Therefore, everything should work correctly
> as long as the guest sets fewer than `(vhost_vdpa_net_cvq_cmd_page_len() =
-
> sizeof(struct virtio_net_ctrl_hdr)
> - 2 * sizeof(struct virtio_net_ctrl_mac)) / ETH_ALEN` MAC addresses.
>
> Considering the highly unlikely scenario for the guest setting more than
> that number of MAC addresses for the filter table, this patch should
> work fine for the majority of cases. If there is a need for more than tho=
es
> entries, we can increase the value for vhost_vdpa_net_cvq_cmd_page_len()
> in the future, mapping more than one page for command output.
>
> Fixes: 7a7f87e94c ("vdpa: Move command buffers map to start of net device=
")
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>  net/vhost-vdpa.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 5a72204899..ecfa8852b5 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -784,9 +784,18 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostSha=
dowVirtqueue *svq,
>      };
>      ssize_t dev_written =3D -EINVAL;
>
> +    /*
> +     * This code truncates the VIRTIO_NET_CTRL_MAC_TABLE_SET CVQ command
> +     * and prevents QEMU from marking `mac_table.x_overflow` in the devi=
ce
> +     * internal state in virtio_net_handle_mac() if the guest sets more =
than
> +     * `(vhost_vdpa_net_cvq_cmd_page_len() - sizeof(struct virtio_net_ct=
rl_hdr)
> +     * - 2 * sizeof(struct virtio_net_ctrl_mac)) / ETH_ALEN` MAC address=
es for
> +     * filter table.
> +     * However, this situation is considered rare, so it is acceptable.

I think we can also fix this situation. If it fits in one page, we can
still send the same page to the device and virtio_net_handle_ctrl_iov.
If it does not fit in one page, we can clear all mac filters with
VIRTIO_NET_CTRL_RX_ALLUNI and / or VIRTIO_NET_CTRL_RX_ALLMULTI.

Thanks!

> +     */
>      out.iov_len =3D iov_to_buf(elem->out_sg, elem->out_num, 0,
>                               s->cvq_cmd_out_buffer,
> -                             vhost_vdpa_net_cvq_cmd_len());
> +                             vhost_vdpa_net_cvq_cmd_page_len());
>      if (*(uint8_t *)s->cvq_cmd_out_buffer =3D=3D VIRTIO_NET_CTRL_ANNOUNC=
E) {
>          /*
>           * Guest announce capability is emulated by qemu, so don't forwa=
rd to
> --
> 2.25.1
>



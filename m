Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E9577F4DA
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 13:17:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWaya-0006x6-4r; Thu, 17 Aug 2023 07:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qWayW-0006oP-Ll
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 07:15:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qWayQ-0005PH-22
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 07:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692270915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ksXD372QrpZiwv2XQa7qLISBNCYuB9WO20sGEUxN9sU=;
 b=CfeMlu6qnuYCo36KhW8ExmkCc2ZY16DPclZVHk5iwh/8Z/e3BppX5EtX02+dtqtxsghmVA
 uMu2cuQOy/Ln4Vokzbrfv3czEAjQgYIQGawxJG3n9AKJUuhynkgxQCGWXhKkPt5R0CredK
 NJgAjNdM6P27EhPjC0lO2LBJ8viOC28=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-XjeDqhlAN9SXJFBUg4tNMQ-1; Thu, 17 Aug 2023 07:15:14 -0400
X-MC-Unique: XjeDqhlAN9SXJFBUg4tNMQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-40fdb989957so104719951cf.3
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 04:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692270913; x=1692875713;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ksXD372QrpZiwv2XQa7qLISBNCYuB9WO20sGEUxN9sU=;
 b=DrshLUZxl1/JEaOnL6qt+a64uLA896sg5UoPZ+XwGPd63xZSn9a3XRio3oOlur/gEW
 wgiRNDy2ozMl1nbIFu5+yn+C4xaR97XCs1buiQNAcGpcz9sj1l0v+X23ENtz8WftCL8k
 fZTSZ1iVNHZFNLBCnRYDrBfWbg21bB6buo2wcQwn8KtctS5vD+OUrur97xdKS4eozymt
 +J5sgsoPrXmP0lgBZEpkQ+Sy+FA8jqX2QyqaOmanReUd0pN3ZGdhmtS7QDN6COjO8d96
 vRDtdjaM7wuLH6sUUBW5pYoJUL5S2N7DZVPf2slfM7kpF2D7hAZKW6b1aO/HUT4UQ9V/
 YwGw==
X-Gm-Message-State: AOJu0YxQHRTW6ileSpwnBzrWHcTUSebFV3K4baWTy+Q4wnCPfplYMRQz
 eW+pK6Eh8gp/EQa0nE1V177+JbasH+f8Y2fw876sLlg8wUSINB+kPfnXFCyZoVYeR2ZPNFGUbHR
 AmT0+iFjCZiNaU8WXtZo+5SX6vqJ8nh3B+P0Eo5Tu6Q==
X-Received: by 2002:a25:e693:0:b0:d0f:ea4b:1dff with SMTP id
 d141-20020a25e693000000b00d0fea4b1dffmr4013497ybh.8.1692270568578; 
 Thu, 17 Aug 2023 04:09:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDqXD4dTHRp6APAgTsvRFYxD69i0CkaEM/w4RGZiex2LZ0lDuhjEOBqsl0cZejr5RBWr0MA9LIDpW3BCEU4kM=
X-Received: by 2002:a25:e693:0:b0:d0f:ea4b:1dff with SMTP id
 d141-20020a25e693000000b00d0fea4b1dffmr4013481ybh.8.1692270568269; Thu, 17
 Aug 2023 04:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688743107.git.yin31149@gmail.com>
 <267e15e4eed2d7aeb9887f193da99a13d22a2f1d.1688743107.git.yin31149@gmail.com>
In-Reply-To: <267e15e4eed2d7aeb9887f193da99a13d22a2f1d.1688743107.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 17 Aug 2023 13:08:52 +0200
Message-ID: <CAJaqyWeb5Xu0JaPCg_S_Ay_92NpwsSZR808rTYWcuU1_Aw1EeA@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] vdpa: Avoid forwarding large CVQ command failures
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

On Fri, Jul 7, 2023 at 5:28=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com> =
wrote:
>
> Due to the size limitation of the out buffer sent to the vdpa device,
> which is determined by vhost_vdpa_net_cvq_cmd_len(), excessive CVQ
> command is truncated in QEMU. As a result, the vdpa device rejects
> this flawd CVQ command.
>
> However, the problem is that, the VIRTIO_NET_CTRL_MAC_TABLE_SET
> CVQ command has a variable length, which may exceed
> vhost_vdpa_net_cvq_cmd_len() if the guest sets more than
> `MAC_TABLE_ENTRIES` MAC addresses for the filter table.
>
> This patch solves this problem by following steps:
>
>   * Increase the out buffer size to vhost_vdpa_net_cvq_cmd_page_len(),
> which represents the size of the buffer that is allocated and mmaped.
> This ensures that everything works correctly as long as the guest
> sets fewer than `(vhost_vdpa_net_cvq_cmd_page_len() -
> sizeof(struct virtio_net_ctrl_hdr)
> - 2 * sizeof(struct virtio_net_ctrl_mac)) / ETH_ALEN` MAC addresses.
>     Considering the highly unlikely scenario for the guest setting
> more than that number of MAC addresses for the filter table, this
> should work fine for the majority of cases.
>
>   * If the CVQ command exceeds vhost_vdpa_net_cvq_cmd_page_len(),
> instead of directly sending this CVQ command, QEMU should send
> a VIRTIO_NET_CTRL_RX_PROMISC CVQ command to vdpa device. Addtionally,
> a fake VIRTIO_NET_CTRL_MAC_TABLE_SET command including
> (`MAC_TABLE_ENTRIES` + 1) non-multicast MAC addresses and
> (`MAC_TABLE_ENTRIES` + 1) multicast MAC addresses should be provided
> to the device model.
>     By doing so, the vdpa device turns promiscuous mode on, aligning
> with the VirtIO standard. The device model marks
> `n->mac_table.uni_overflow` and `n->mac_table.multi_overflow`,
> which aligns with the state of the vdpa device.
>
> Note that the bug cannot be triggered at the moment, since
> VIRTIO_NET_F_CTRL_RX feature is not enabled for SVQ.
>
> Fixes: 7a7f87e94c ("vdpa: Move command buffers map to start of net device=
")
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  net/vhost-vdpa.c | 162 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 161 insertions(+), 1 deletion(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index a84eb088a0..a4ff6c52b7 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -916,6 +916,148 @@ static NetClientInfo net_vhost_vdpa_cvq_info =3D {
>      .check_peer_type =3D vhost_vdpa_check_peer_type,
>  };
>
> +/*
> + * Forward the excessive VIRTIO_NET_CTRL_MAC_TABLE_SET CVQ command to
> + * vdpa device.
> + *
> + * Considering that QEMU cannot send the entire filter table to the
> + * vdpa device, it should send the VIRTIO_NET_CTRL_RX_PROMISC CVQ
> + * command to enable promiscuous mode to receive all packets,
> + * according to VirtIO standard, "Since there are no guarantees,
> + * it can use a hash filter or silently switch to allmulti or
> + * promiscuous mode if it is given too many addresses.".
> + *
> + * Since QEMU ignores MAC addresses beyond `MAC_TABLE_ENTRIES` and
> + * marks `n->mac_table.x_overflow` accordingly, it should have
> + * the same effect on the device model to receive
> + * (`MAC_TABLE_ENTRIES` + 1) or more non-multicast MAC addresses.
> + * The same applies to multicast MAC addresses.
> + *
> + * Therefore, QEMU can provide the device model with a fake
> + * VIRTIO_NET_CTRL_MAC_TABLE_SET command with (`MAC_TABLE_ENTRIES` + 1)
> + * non-multicast MAC addresses and (`MAC_TABLE_ENTRIES` + 1) multicast
> + * MAC addresses. This ensures that the device model marks
> + * `n->mac_table.uni_overflow` and `n->mac_table.multi_overflow`,
> + * allowing all packets to be received, which aligns with the
> + * state of the vdpa device.
> + */
> +static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState *s=
,
> +                                                       VirtQueueElement =
*elem,
> +                                                       struct iovec *out=
)
> +{
> +    struct virtio_net_ctrl_mac mac_data, *mac_ptr;
> +    struct virtio_net_ctrl_hdr *hdr_ptr;
> +    uint32_t cursor;
> +    ssize_t r;
> +
> +    /* parse the non-multicast MAC address entries from CVQ command */
> +    cursor =3D sizeof(*hdr_ptr);
> +    r =3D iov_to_buf(elem->out_sg, elem->out_num, cursor,
> +                   &mac_data, sizeof(mac_data));
> +    if (unlikely(r !=3D sizeof(mac_data))) {
> +        /*
> +         * If the CVQ command is invalid, we should simulate the vdpa de=
vice
> +         * to reject the VIRTIO_NET_CTRL_MAC_TABLE_SET CVQ command
> +         */
> +        *s->status =3D VIRTIO_NET_ERR;
> +        return sizeof(*s->status);
> +    }
> +    cursor +=3D sizeof(mac_data) + le32_to_cpu(mac_data.entries) * ETH_A=
LEN;
> +
> +    /* parse the multicast MAC address entries from CVQ command */
> +    r =3D iov_to_buf(elem->out_sg, elem->out_num, cursor,
> +                   &mac_data, sizeof(mac_data));
> +    if (r !=3D sizeof(mac_data)) {
> +        /*
> +         * If the CVQ command is invalid, we should simulate the vdpa de=
vice
> +         * to reject the VIRTIO_NET_CTRL_MAC_TABLE_SET CVQ command
> +         */
> +        *s->status =3D VIRTIO_NET_ERR;
> +        return sizeof(*s->status);
> +    }
> +    cursor +=3D sizeof(mac_data) + le32_to_cpu(mac_data.entries) * ETH_A=
LEN;
> +
> +    /* validate the CVQ command */
> +    if (iov_size(elem->out_sg, elem->out_num) !=3D cursor) {
> +        /*
> +         * If the CVQ command is invalid, we should simulate the vdpa de=
vice
> +         * to reject the VIRTIO_NET_CTRL_MAC_TABLE_SET CVQ command
> +         */
> +        *s->status =3D VIRTIO_NET_ERR;
> +        return sizeof(*s->status);
> +    }
> +
> +    /*
> +     * According to VirtIO standard, "Since there are no guarantees,
> +     * it can use a hash filter or silently switch to allmulti or
> +     * promiscuous mode if it is given too many addresses.".
> +     *
> +     * Therefore, considering that QEMU is unable to send the entire
> +     * filter table to the vdpa device, it should send the
> +     * VIRTIO_NET_CTRL_RX_PROMISC CVQ command to enable promiscuous mode
> +     */
> +    r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC, 1);
> +    if (unlikely(r < 0)) {
> +        return r;
> +    }
> +    if (*s->status !=3D VIRTIO_NET_OK) {
> +        return sizeof(*s->status);
> +    }
> +
> +    /*
> +     * QEMU should also send a fake VIRTIO_NET_CTRL_MAC_TABLE_SET CVQ
> +     * command to the device model, including (`MAC_TABLE_ENTRIES` + 1)
> +     * non-multicast MAC addresses and (`MAC_TABLE_ENTRIES` + 1)
> +     * multicast MAC addresses.
> +     *
> +     * By doing so, the device model can mark `n->mac_table.uni_overflow=
`
> +     * and `n->mac_table.multi_overflow`, enabling all packets to be
> +     * received, which aligns with the state of the vdpa device.
> +     */
> +    cursor =3D 0;
> +    uint32_t fake_uni_entries =3D MAC_TABLE_ENTRIES + 1,
> +             fake_mul_entries =3D MAC_TABLE_ENTRIES + 1,
> +             fake_cvq_size =3D sizeof(struct virtio_net_ctrl_hdr) +
> +                             sizeof(mac_data) + fake_uni_entries * ETH_A=
LEN +
> +                             sizeof(mac_data) + fake_mul_entries * ETH_A=
LEN;
> +
> +    assert(fake_cvq_size < vhost_vdpa_net_cvq_cmd_page_len());
> +    out->iov_len =3D fake_cvq_size;
> +
> +    /* pack the header for fake CVQ command */
> +    hdr_ptr =3D out->iov_base + cursor;
> +    hdr_ptr->class =3D VIRTIO_NET_CTRL_MAC;
> +    hdr_ptr->cmd =3D VIRTIO_NET_CTRL_MAC_TABLE_SET;
> +    cursor +=3D sizeof(*hdr_ptr);
> +
> +    /*
> +     * Pack the non-multicast MAC addresses part for fake CVQ command.
> +     *
> +     * According to virtio_net_handle_mac(), QEMU doesn't verify the MAC
> +     * addresses provieded in CVQ command. Therefore, only the entries
> +     * field need to be prepared in the CVQ command.
> +     */
> +    mac_ptr =3D out->iov_base + cursor;
> +    mac_ptr->entries =3D cpu_to_le32(fake_uni_entries);
> +    cursor +=3D sizeof(*mac_ptr) + fake_uni_entries * ETH_ALEN;
> +
> +    /*
> +     * Pack the multicast MAC addresses part for fake CVQ command.
> +     *
> +     * According to virtio_net_handle_mac(), QEMU doesn't verify the MAC
> +     * addresses provieded in CVQ command. Therefore, only the entries
> +     * field need to be prepared in the CVQ command.
> +     */
> +    mac_ptr =3D out->iov_base + cursor;
> +    mac_ptr->entries =3D cpu_to_le32(fake_mul_entries);
> +
> +    /*
> +     * Simulating QEMU poll a vdpa device used buffer
> +     * for VIRTIO_NET_CTRL_MAC_TABLE_SET CVQ command
> +     */
> +    return sizeof(*s->status);
> +}
> +
>  /**
>   * Validate and copy control virtqueue commands.
>   *
> @@ -943,7 +1085,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostSha=
dowVirtqueue *svq,
>
>      out.iov_len =3D iov_to_buf(elem->out_sg, elem->out_num, 0,
>                               s->cvq_cmd_out_buffer,
> -                             vhost_vdpa_net_cvq_cmd_len());
> +                             vhost_vdpa_net_cvq_cmd_page_len());
>
>      ctrl =3D s->cvq_cmd_out_buffer;
>      if (ctrl->class =3D=3D VIRTIO_NET_CTRL_ANNOUNCE) {
> @@ -953,6 +1095,24 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostSh=
adowVirtqueue *svq,
>           */
>          dev_written =3D sizeof(status);
>          *s->status =3D VIRTIO_NET_OK;
> +    } else if (unlikely(ctrl->class =3D=3D VIRTIO_NET_CTRL_MAC &&
> +                        ctrl->cmd =3D=3D VIRTIO_NET_CTRL_MAC_TABLE_SET &=
&
> +                        iov_size(elem->out_sg, elem->out_num) > out.iov_=
len)) {
> +        /*
> +         * Due to the size limitation of the out buffer sent to the vdpa=
 device,
> +         * which is determined by vhost_vdpa_net_cvq_cmd_page_len(), exc=
essive
> +         * MAC addresses set by the driver for the filter table can caus=
e
> +         * truncation of the CVQ command in QEMU. As a result, the vdpa =
device
> +         * rejects the flawed CVQ command.
> +         *
> +         * Therefore, QEMU must handle this situation instead of sending
> +         * the CVQ command direclty.
> +         */
> +        dev_written =3D vhost_vdpa_net_excessive_mac_filter_cvq_add(s, e=
lem,
> +                                                                  &out);
> +        if (unlikely(dev_written < 0)) {
> +            goto out;
> +        }
>      } else {
>          dev_written =3D vhost_vdpa_net_cvq_add(s, out.iov_len, sizeof(st=
atus));
>          if (unlikely(dev_written < 0)) {
> --
> 2.25.1
>



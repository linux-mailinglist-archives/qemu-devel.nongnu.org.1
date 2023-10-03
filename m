Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1327B7046
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:50:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjWN-0005DL-1m; Tue, 03 Oct 2023 13:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qnjWK-0005CY-Pg
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:49:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qnjWJ-0002Ab-0c
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696355358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uB57zDfbJdIcmMcFrMTrQ0eJbAuG8ZS90+aomXqGtWQ=;
 b=PPpcEYRVu0BabnUZMXz/utkz1a+x1FIMUAGCss/kI8UvgiLdYOtlXlf578zotbl6plB2kx
 iuC4rTuYFMC0jaXzg8RUP6zb9Ow1SfJhceyhCLAxzmm9etcY4fpSoXJorCIpLVeXdwQ30U
 OLt1d/ea382C0+aB/t7vykuu/KI2d0M=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-vq65U3HxNT-NOfkpx3Wc3w-1; Tue, 03 Oct 2023 13:49:06 -0400
X-MC-Unique: vq65U3HxNT-NOfkpx3Wc3w-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-d8486b5e780so1392708276.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696355326; x=1696960126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uB57zDfbJdIcmMcFrMTrQ0eJbAuG8ZS90+aomXqGtWQ=;
 b=pUfEIrejDMyoR+mS2pPgVbR6/OHdDXin/RjNU/MnuWXYEo1Jeahrzo2eYnbN6F8wU0
 PIhZ3RvYckbR81Lc36tSgeRHIyD+tQ97bydnffvWu4lUHLSPdVXdAilxWWXJPD48sPRY
 an3UVaX0PKraxTZzPlBkKzyI6RWCX+W6FNRaPk8pmvRgkmVxtbRak7lqqK5g7UK8Rzgr
 yQLawPDQpJliJ7xAuMgSw4pD26s7EbnoTN0pMBTjTMH+t6S2dwxf2S0WlMsPgHrd9teZ
 xlM7oCsy9Teh+5qM1Hat3fqXULKTH8NJgTp3Bnua5UN2cD12yy3bfaJXxCS3qRQZfMKK
 kJhg==
X-Gm-Message-State: AOJu0Ywh7nU+50OOW3yStPeIbayCz63/jZLmiHuSukVIyWBtZJ34aklF
 G5Sx7u5wqfk3TbFGX70gxNc8GlD67nNeLu1OXpJTsT7roKWROJNhgB8XzXIcmtN2+Ab03+Pj77P
 MeUD54E755vxEtiJd/I6Lep+vnsussJs=
X-Received: by 2002:a25:abec:0:b0:d89:4829:6a63 with SMTP id
 v99-20020a25abec000000b00d8948296a63mr13454942ybi.65.1696355326569; 
 Tue, 03 Oct 2023 10:48:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH10YPVVfYGkeRglDuia6FeS4xE62qjDrFpfqM8kl6iUnmXZgeKgZXGQKrMYC7x2hswPKNFGtWpMtPC68Q+N7I=
X-Received: by 2002:a25:abec:0:b0:d89:4829:6a63 with SMTP id
 v99-20020a25abec000000b00d8948296a63mr13454927ybi.65.1696355326314; Tue, 03
 Oct 2023 10:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693287885.git.yin31149@gmail.com>
 <a56d91c3cc2ab46f9be1770074c920f5375ddb5e.1693287885.git.yin31149@gmail.com>
In-Reply-To: <a56d91c3cc2ab46f9be1770074c920f5375ddb5e.1693287885.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 3 Oct 2023 19:48:10 +0200
Message-ID: <CAJaqyWc8AiT0+OQffff22AkSMuwqB3EOJOVh=OknFKY0XL0FJg@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] vdpa: Avoid using vhost_vdpa_net_load_*() outside
 vhost_vdpa_net_load()
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 leiyang@redhat.com, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 29, 2023 at 7:55=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> Next patches in this series will refactor vhost_vdpa_net_load_cmd()
> to iterate through the control commands shadow buffers, allowing QEMU
> to send CVQ state load commands in parallel at device startup.
>
> Considering that QEMU always forwards the CVQ command serialized
> outside of vhost_vdpa_net_load(), it is more elegant to send the
> CVQ commands directly without invoking vhost_vdpa_net_load_*() helpers.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
> v4:
>   - pack CVQ command by iov_from_buf() instead of accessing
> `out` directly suggested by Eugenio
>
> v3: https://lore.kernel.org/all/428a8fac2a29b37757fa15ca747be93c0226cb1f.=
1689748694.git.yin31149@gmail.com/
>
>  net/vhost-vdpa.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index e6342b213f..7c67063469 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1097,12 +1097,14 @@ static NetClientInfo net_vhost_vdpa_cvq_info =3D =
{
>   */
>  static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState *s=
,
>                                                         VirtQueueElement =
*elem,
> -                                                       struct iovec *out=
)
> +                                                       struct iovec *out=
,
> +                                                       const struct iove=
c *in)
>  {
>      struct virtio_net_ctrl_mac mac_data, *mac_ptr;
>      struct virtio_net_ctrl_hdr *hdr_ptr;
>      uint32_t cursor;
>      ssize_t r;
> +    uint8_t on =3D 1;
>
>      /* parse the non-multicast MAC address entries from CVQ command */
>      cursor =3D sizeof(*hdr_ptr);
> @@ -1150,7 +1152,15 @@ static int vhost_vdpa_net_excessive_mac_filter_cvq=
_add(VhostVDPAState *s,
>       * filter table to the vdpa device, it should send the
>       * VIRTIO_NET_CTRL_RX_PROMISC CVQ command to enable promiscuous mode
>       */
> -    r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC, 1);
> +    cursor =3D 0;

I think this is redundant, as "cursor" is not used by the new code and
it is already set to 0 before its usage, isn't it?

> +    hdr_ptr =3D out->iov_base;
> +    out->iov_len =3D sizeof(*hdr_ptr) + sizeof(on);
> +    assert(out->iov_len < vhost_vdpa_net_cvq_cmd_page_len());
> +

I think we can assume this assertion is never hit, as out->iov_len is
controlled by this function.

Apart from these nits,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> +    hdr_ptr->class =3D VIRTIO_NET_CTRL_RX;
> +    hdr_ptr->cmd =3D VIRTIO_NET_CTRL_RX_PROMISC;
> +    iov_from_buf(out, 1, sizeof(*hdr_ptr), &on, sizeof(on));
> +    r =3D vhost_vdpa_net_cvq_add(s, out, 1, in, 1);
>      if (unlikely(r < 0)) {
>          return r;
>      }
> @@ -1268,7 +1278,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostSh=
adowVirtqueue *svq,
>           * the CVQ command direclty.
>           */
>          dev_written =3D vhost_vdpa_net_excessive_mac_filter_cvq_add(s, e=
lem,
> -                                                                  &out);
> +                                                            &out, &vdpa_=
in);
>          if (unlikely(dev_written < 0)) {
>              goto out;
>          }
> --
> 2.25.1
>



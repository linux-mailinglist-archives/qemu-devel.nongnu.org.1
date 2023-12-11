Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 718D980C7C9
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 12:19:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCeIu-0004BX-Im; Mon, 11 Dec 2023 06:18:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCeIs-00049p-5b
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 06:18:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCeIp-0001WN-Hl
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 06:18:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702293502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DRqvE7bKGbafijET+faWGY7wW8OnARB6iIzfm/qkLrA=;
 b=EB871kVJjYg/7wa54J9Tr09/zVzVoqZBUYeqmcE8p6DqA4OBkti/ubxRp4PQt+sg15ZQjN
 eAw47Rv5dQNaRmeaLyDLy5FEkzg9NOk/wDUaXnX8/Ktrasl6tNosi6dCsjxj36hC7eAVZ4
 TSz3GIUUaPjooRF63do3mcnVagruAuI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-f3wyuHBdP4SM5FfY97IK6Q-1; Mon, 11 Dec 2023 06:18:21 -0500
X-MC-Unique: f3wyuHBdP4SM5FfY97IK6Q-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-5d942a656b7so52329627b3.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 03:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702293500; x=1702898300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DRqvE7bKGbafijET+faWGY7wW8OnARB6iIzfm/qkLrA=;
 b=EULYdSIDEw8UKpfbPP+XLBTtnsoWSGzfnt8dBi6Zxv7uMYNUmiP8DFytfe7/dBCJQw
 RTf5ECbjwxV6TrfV+9WsP4G8w7PvgOh7jx/MbxbbbFxSLy9i3USXwswboFgV835ZyIbD
 ifTO2lo2TU4PErdu88n+/BBrHSJ9qANLi174hpWIcGNiTzK0DKnYRV3ojf+ZldeaSBGR
 mtpocFqj75b0fafXOP5ZjnSkmB1SYebsnHrULxbQmEzdo45U1KRE+jV0uqXByH6/jDzF
 GgMXC1AkBBJhpRG2Z1LnBL3QFtSwMOiOX6IL1BG1Lg3VrQma8dcb6ecwGFYV8cuIHnSB
 6jzQ==
X-Gm-Message-State: AOJu0Yy7iOZdnyLjzRSedtojktP5trYY1QU+dCrXfGo4moJixFhiZptx
 X/y4L2kS+ZyekG09y5xpZq5TuwaTC1HnWkYsZJwI6O1Z57yF/h4KOnPQ/3pTkGpOIGVoQJSHI+F
 k6A8wO28FwwiOPZkkc16KtJdUdc1lRJc=
X-Received: by 2002:a81:6f8b:0:b0:5d7:9aac:36fc with SMTP id
 k133-20020a816f8b000000b005d79aac36fcmr3275805ywc.69.1702293500546; 
 Mon, 11 Dec 2023 03:18:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHinqv+Ju5I2Ew9LSWgj8c+wN1Nb372OxgBb1tApbW0Q98drc9K/oSZQtPO+seOVDVz2PXWCu1ost9CdQ8snTk=
X-Received: by 2002:a81:6f8b:0:b0:5d7:9aac:36fc with SMTP id
 k133-20020a816f8b000000b005d79aac36fcmr3275798ywc.69.1702293500299; Mon, 11
 Dec 2023 03:18:20 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-7-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-7-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Dec 2023 12:17:44 +0100
Message-ID: <CAJaqyWcHxgKA1UXb6yLx0t0c0MsH1y23bBRgN6r8Z+XktWRA7w@mail.gmail.com>
Subject: Re: [PATCH 06/40] vhost: make svq work with gpa without iova
 translation
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Dec 7, 2023 at 7:50=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Make vhost_svq_vring_write_descs able to work with GPA directly
> without going through iova tree for translation. This will be
> needed in the next few patches where the SVQ has dedicated
> address space to host its virtqueues. Instead of having to
> translate qemu's VA to IOVA via the iova tree, with dedicated
> or isolated address space for SVQ descriptors, the IOVA is
> exactly same as the guest GPA space where translation would
> not be needed any more.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  hw/virtio/vhost-shadow-virtqueue.c | 35 +++++++++++++++++++++++---------=
---
>  1 file changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index fc5f408..97ccd45 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -136,8 +136,8 @@ static bool vhost_svq_translate_addr(const VhostShado=
wVirtqueue *svq,
>   * Return true if success, false otherwise and print error.
>   */
>  static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwadd=
r *sg,
> -                                        const struct iovec *iovec, size_=
t num,
> -                                        bool more_descs, bool write)
> +                                        const struct iovec *iovec, hwadd=
r *addr,
> +                                        size_t num, bool more_descs, boo=
l write)
>  {
>      uint16_t i =3D svq->free_head, last =3D svq->free_head;
>      unsigned n;
> @@ -149,8 +149,15 @@ static bool vhost_svq_vring_write_descs(VhostShadowV=
irtqueue *svq, hwaddr *sg,
>          return true;
>      }
>
> -    ok =3D vhost_svq_translate_addr(svq, sg, iovec, num);
> -    if (unlikely(!ok)) {
> +    if (svq->iova_tree) {
> +        ok =3D vhost_svq_translate_addr(svq, sg, iovec, num);
> +        if (unlikely(!ok)) {
> +            return false;
> +        }
> +    } else if (!addr) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "No translation found for vaddr 0x%p\n",
> +                      iovec[0].iov_base);
>          return false;
>      }
>
> @@ -161,7 +168,7 @@ static bool vhost_svq_vring_write_descs(VhostShadowVi=
rtqueue *svq, hwaddr *sg,
>          } else {
>              descs[i].flags =3D flags;
>          }
> -        descs[i].addr =3D cpu_to_le64(sg[n]);
> +        descs[i].addr =3D cpu_to_le64(svq->iova_tree ? sg[n] : addr[n]);
>          descs[i].len =3D cpu_to_le32(iovec[n].iov_len);
>
>          last =3D i;
> @@ -173,9 +180,10 @@ static bool vhost_svq_vring_write_descs(VhostShadowV=
irtqueue *svq, hwaddr *sg,
>  }
>
>  static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
> -                                const struct iovec *out_sg, size_t out_n=
um,
> -                                const struct iovec *in_sg, size_t in_num=
,
> -                                unsigned *head)
> +                                const struct iovec *out_sg, hwaddr *out_=
addr,
> +                                size_t out_num,
> +                                const struct iovec *in_sg, hwaddr *in_ad=
dr,
> +                                size_t in_num, unsigned *head)
>  {
>      unsigned avail_idx;
>      vring_avail_t *avail =3D svq->vring.avail;
> @@ -191,13 +199,14 @@ static bool vhost_svq_add_split(VhostShadowVirtqueu=
e *svq,
>          return false;
>      }
>
> -    ok =3D vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, in_num=
 > 0,
> -                                     false);
> +    ok =3D vhost_svq_vring_write_descs(svq, sgs, out_sg, out_addr, out_n=
um,
> +                                     in_num > 0, false);
>      if (unlikely(!ok)) {
>          return false;
>      }
>
> -    ok =3D vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, false, t=
rue);
> +    ok =3D vhost_svq_vring_write_descs(svq, sgs, in_sg, in_addr, in_num,
> +                                     false, true);
>      if (unlikely(!ok)) {
>          return false;
>      }
> @@ -258,7 +267,9 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const st=
ruct iovec *out_sg,
>          return -ENOSPC;
>      }
>
> -    ok =3D vhost_svq_add_split(svq, out_sg, out_num, in_sg, in_num, &qem=
u_head);
> +    ok =3D vhost_svq_add_split(svq, out_sg, elem ? elem->out_addr : NULL=
,
> +                             out_num, in_sg, elem ? elem->in_addr : NULL=
,
> +                             in_num, &qemu_head);

This function is using in_sg and out_sg intentionally as CVQ buffers
do not use VirtQueueElement addressing. You can check calls at
net/vhost-vdpa.c for more info. The right place for this change is
actually vhost_svq_add_element, and I suggest checking for
svq->iova_tree as the rest of the patch.

Apart from that,

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

>      if (unlikely(!ok)) {
>          return -EINVAL;
>      }
> --
> 1.8.3.1
>



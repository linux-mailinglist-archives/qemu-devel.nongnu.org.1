Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6609382A85E
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 08:32:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNpXx-0007be-T0; Thu, 11 Jan 2024 02:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNpXq-0007Y6-8r
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:32:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNpXm-0003cP-78
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704958321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ax7oh+01qsdGQNUVt/z25iCgrqtidWp6XOCwFq7RlII=;
 b=U2H4rYzBxtiIMhCzolVoIJSAnL1fmhwKbn5E3UG6waOu/aUHbDoeIY+wudPw2uGEdtnZb/
 RuS4yDOl01t8QlKUEvJw0gcNuWc83saWTLJaKhxKOR+8iQwNBFIojFaLSYOyTdwpzwh74w
 QS1OiZ7OIY93/kcY13qmgJLK+Wyprfs=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-0Bo0TFBnM8KoNEYbQDJvKA-1; Thu, 11 Jan 2024 02:31:59 -0500
X-MC-Unique: 0Bo0TFBnM8KoNEYbQDJvKA-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3bbacb61978so4125114b6e.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 23:31:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704958319; x=1705563119;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ax7oh+01qsdGQNUVt/z25iCgrqtidWp6XOCwFq7RlII=;
 b=US7w/BEJH3EEkw8iJSKvh0voCCJ8BvV6S80iBAcfaMMrt4rk0oWzvY8mrQgvEZyBd5
 ZwnmbxA8fYCuIbrVcmu6RHoeaOfA+cqF2mRiRqlmFEn2CfLVx0gTmb3MjYVd58qAdkDj
 Ki0l0c4vHetL+R6HsKazGRyXQLPU2iORtDkxhxdpcI+8hBrCiGOXcEp7NLWB1MmCRxLy
 TN989/N3vg5LSg34nNiiga5Sw+j1iNScLyKhgcMmG65i76+L75LwPeTDIbM/zUO0k23P
 FmgNEgSioBqp1A8tHm/F7JDVTUQHSl1Oe0OIvKKn9aV3+Zf4RS5XcmsAkS5Iu0FXOF7C
 gJVA==
X-Gm-Message-State: AOJu0Yw2SUTgH30WlJMK3XDEVmE4Admd3ibB+A3Uh5ZIDqTlMlbYCfwZ
 gha/yJDTtMNYO8BomN2GHK7tpdztMLCfJX70m/8mQ4jDTY0dNvVGEViFwkN9maiYSNQZQOOEf26
 K3OsCH37OXKbDsHwXr6ETaDD8hUMrYP6qm/ceMFw=
X-Received: by 2002:a05:6808:10c5:b0:3bd:5308:371c with SMTP id
 s5-20020a05680810c500b003bd5308371cmr703266ois.87.1704958319048; 
 Wed, 10 Jan 2024 23:31:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESgFj0uZn2PgUF3l6UrXDt2Lc0Jv0DcPfxpy5Saby4WbIM2G81dOPy29eglEDbq3LeVAslew/DYXRdJ3r/O+w=
X-Received: by 2002:a05:6808:10c5:b0:3bd:5308:371c with SMTP id
 s5-20020a05680810c500b003bd5308371cmr703259ois.87.1704958318805; Wed, 10 Jan
 2024 23:31:58 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-7-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-7-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 15:31:47 +0800
Message-ID: <CACGkMEv=EVdE2MGTqS5bzVFkxmX=jr+cTpWSKkmegtr+MS3ZLg@mail.gmail.com>
Subject: Re: [PATCH 06/40] vhost: make svq work with gpa without iova
 translation
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Dec 8, 2023 at 2:50=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
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

So the idea is when shadow virtqueue can work directly for GPA, there
won't be an iova_tree here?

If yes, I think we need a comment around iova_tree or here to explain this.

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

Or maybe a helper and do the switch there with the comments.

Thanks

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
>      if (unlikely(!ok)) {
>          return -EINVAL;
>      }
> --
> 1.8.3.1
>



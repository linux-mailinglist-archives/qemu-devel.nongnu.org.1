Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF3382A928
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 09:31:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNqSh-0005YC-HP; Thu, 11 Jan 2024 03:30:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNqSc-0005Vc-QU
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:30:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNqSa-0006mR-Jl
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704961843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bilEEIW32jOimN5+zJQy7hhqrXVuVooym0WZ/ZxJA1o=;
 b=fIhWldI94sAoJ6JEh/M7Yt29scv0eAHoTexvggxBfFVsCOgugQ62GXtnlC5s6xj+ZT68M7
 DVJ3M1EXsdNA39WfAcwL+jUOMpxUILtM1N0q/hhwiqfEqkwTLOcLaqta1ewYLer/2Vagbv
 KBsYAWnndKRz9LA7kn9douDNAX032b4=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-E4aQYw1wPLiCnqIEcSvbJA-1; Thu, 11 Jan 2024 03:30:42 -0500
X-MC-Unique: E4aQYw1wPLiCnqIEcSvbJA-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3bd4b623e4aso2530254b6e.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 00:30:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704961841; x=1705566641;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bilEEIW32jOimN5+zJQy7hhqrXVuVooym0WZ/ZxJA1o=;
 b=ABKLmn3sJ6gnvzaSPHbsKyudgKNvpqOk1HS4vbxv8PNg9Rt0Ta3ZwB69N5cyQedCUf
 CzXRamP+P+dB1ev5qxeI0PN6cXDizRIQiZwJDoYdmUMfy5qTYxG55gkAwJ30y0IoMp06
 5r9bOwcwzyzaFNlkza3IHca+fIscy8S/EfmzLFy/Un6Dxz8DLyJ2SIzPWkjpnLq69I7f
 ppa78QhQypuGcQajQR1VaD2+EN9dZc5krCz9MeSgBG4/EyR+5tcyqvWmD/pQkyMv9p5x
 RIlrGSx/qH0aBS40+VoM5ruXhLBVPJyWe+R+o+ZGDnrxvyPQk2M4v/NJvET+xnF08e83
 5CIw==
X-Gm-Message-State: AOJu0YxCiVfVTHqiZiLdSeuQ0P8/au8JmSUI9AhmhsPilwJ7Dk74uQ5b
 +dRmks3Z1iD1AaSH7ix+bBe2vOfYSouJAQEOiFFd1mre1zDWzIgjy8SodudB7twWhMJMONpb4iG
 vDCTPlTQDgToqNS37yZJTOyEmjmL+D5lbLPWElDY=
X-Received: by 2002:a05:6808:38ce:b0:3bd:5507:3a2e with SMTP id
 el14-20020a05680838ce00b003bd55073a2emr500953oib.87.1704961841561; 
 Thu, 11 Jan 2024 00:30:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETebHPAFALgKqMrVSrH5cU8LPGsSumArL1AxXKWMPvZ5yEVOnxygCPNDtvzMrSVRshNORINyHWbFMjawKPC8Q=
X-Received: by 2002:a05:6808:38ce:b0:3bd:5507:3a2e with SMTP id
 el14-20020a05680838ce00b003bd55073a2emr500947oib.87.1704961841374; Thu, 11
 Jan 2024 00:30:41 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-21-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-21-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 16:30:29 +0800
Message-ID: <CACGkMEtoExzYP57PT-W14wh+B9j3DGTu-FQd+dYW5zWP4oaUYQ@mail.gmail.com>
Subject: Re: [PATCH 20/40] vdpa: avoid mapping flush across reset
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

On Fri, Dec 8, 2023 at 2:52=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Leverage the IOTLB_PERSIST and DESC_ASID features to achieve
> a slightly light weight reset path, without resorting to
> suspend and resume. Not as best but it offers significant
> time saving too, which should somehow play its role in live
> migration down time reduction by large.
>
> It benefits two cases:
>   - normal virtio reset in the VM, e.g. guest reboot, don't
>     have to tear down all iotlb mapping and set up again.
>   - SVQ switching, in which data vq's descriptor table and
>     vrings are moved to a different ASID than where its
>     buffers reside. Along with the use of persistent iotlb,
>     it would save substantial time from pinning and mapping
>     unneccessarily when moving descriptors on to or out of
>     shadow mode.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Looks good to me.

Thanks

> ---
>  hw/virtio/vhost-vdpa.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 31e0a55..47c764b 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -633,6 +633,7 @@ static int vhost_vdpa_init(struct vhost_dev *dev, voi=
d *opaque, Error **errp)
>                                       0x1ULL << VHOST_BACKEND_F_IOTLB_BAT=
CH |
>                                       0x1ULL << VHOST_BACKEND_F_IOTLB_ASI=
D |
>                                       0x1ULL << VHOST_BACKEND_F_DESC_ASID=
 |
> +                                     0x1ULL << VHOST_BACKEND_F_IOTLB_PER=
SIST |
>                                       0x1ULL << VHOST_BACKEND_F_SUSPEND;
>      int ret;
>
> @@ -1493,8 +1494,6 @@ static void vhost_vdpa_maybe_flush_map(struct vhost=
_dev *dev)
>
>  static void vhost_vdpa_reset_status(struct vhost_dev *dev)
>  {
> -    struct vhost_vdpa *v =3D dev->opaque;
> -
>      if (!vhost_vdpa_last_dev(dev)) {
>          return;
>      }
> @@ -1502,9 +1501,7 @@ static void vhost_vdpa_reset_status(struct vhost_de=
v *dev)
>      vhost_vdpa_reset_device(dev);
>      vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
>                                 VIRTIO_CONFIG_S_DRIVER);
> -    memory_listener_unregister(&v->shared->listener);
> -    v->shared->listener_registered =3D false;
> -
> +    vhost_vdpa_maybe_flush_map(dev);
>  }
>
>  static int vhost_vdpa_set_log_base(struct vhost_dev *dev, uint64_t base,
> --
> 1.8.3.1
>



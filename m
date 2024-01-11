Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D7C82A6A8
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 04:52:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNm6K-0007aP-18; Wed, 10 Jan 2024 22:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNm6H-0007a2-8v
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 22:51:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNm6F-0000QD-PM
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 22:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704945082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0dHqlWi3iRIcbMuQ+n+oquRbuSL8vxCdRuIe5b54cNw=;
 b=d/U4203epVC/+scgSOiBVozTLnQiLLP8IS8VR+aLHW1Kd0dd1wF9AvHDh001m4X5Rc+ZDA
 a+5AA0nkRRpr1MTsJ5Iphjntp79cXGelFKpJxswF98pvL5w66ixoMT2B7Mk2+3Gz1XKnCR
 yoQ6xP4TVwcFXrx5AJGbNKI9D91bytY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-bvZzsvZkOBWoPeDAeMGcKg-1; Wed, 10 Jan 2024 22:51:20 -0500
X-MC-Unique: bvZzsvZkOBWoPeDAeMGcKg-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6d9fc850ddbso4911918b3a.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 19:51:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704945079; x=1705549879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0dHqlWi3iRIcbMuQ+n+oquRbuSL8vxCdRuIe5b54cNw=;
 b=Yl5sI6+bfbllWOI5/ePV0bmI1ND+qeoxNZlXHUMjgOmAQzFVFZsMmMI57frWgwPehy
 CvxSFNxT+N0x0GRGFKjCBH82yDY6pLineFtAqFNM3z0fr2Q8/cnwRKFeaOm8rSviTbv7
 swXz8MbvDV9fEkZBk517Rgk4N+8AEOhG4z2mkhDlvslMMpt8ypShaeNcuYyg/YieH+Ot
 z+aI84G7Te1mSkuMLQBKt8yWuvYSXntPVOA3xfqc9bzGg//B7GQqHModtS5RmVhI+B16
 vhKDooJ+pqsNBC8WIfEWQqHlAbMz8UQZjjPrLyyr/kTu7qRKpYfL43AItIRA5K8/Vcze
 cHSQ==
X-Gm-Message-State: AOJu0YwP/Q7f8t9YKl91MVAAJQTSXJVToLbw5PhOSvnLr+MplwcLhS52
 uEUkeV1P53S18goIl06ll0OfdVMEhaiClUG+8swcSVS8zEvX308RzRrLy7Ao9g0rkvzSQ8ERWLu
 SPUw+nk56OyqEMicXejxl8rBKo9QaMZk7xpH6cS0=
X-Received: by 2002:a05:6a20:9781:b0:199:c09d:3717 with SMTP id
 hx1-20020a056a20978100b00199c09d3717mr477698pzc.125.1704945079314; 
 Wed, 10 Jan 2024 19:51:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxBM0bohkDPFd270IE5MNDpcabiN+6VEVnosm8KX+pnIqRdwUgJfE9fYo//cgIkAVleHe2JhIgYX623XSbqiw=
X-Received: by 2002:a05:6a20:9781:b0:199:c09d:3717 with SMTP id
 hx1-20020a056a20978100b00199c09d3717mr477684pzc.125.1704945078991; Wed, 10
 Jan 2024 19:51:18 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-3-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-3-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 11:51:07 +0800
Message-ID: <CACGkMEsoKWLYDcVN57Cpe4sBHwk22JL+1RU7=+nHsJZDu7f0QA@mail.gmail.com>
Subject: Re: [PATCH 02/40] vdpa: add vhost_vdpa_get_vring_desc_group
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
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

On Fri, Dec 8, 2023 at 2:50=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Internal API to get the descriptor group index for a specific virtqueue
> through the VHOST_VDPA_GET_VRING_DESC_GROUP ioctl.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  net/vhost-vdpa.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 90f4128..887c329 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -471,6 +471,25 @@ static int64_t vhost_vdpa_get_vring_group(int device=
_fd, unsigned vq_index,
>      return state.num;
>  }
>
> +static int64_t vhost_vdpa_get_vring_desc_group(int device_fd,
> +                                               unsigned vq_index,
> +                                               Error **errp)
> +{
> +    struct vhost_vring_state state =3D {
> +        .index =3D vq_index,
> +    };
> +    int r =3D ioctl(device_fd, VHOST_VDPA_GET_VRING_DESC_GROUP, &state);
> +
> +    if (unlikely(r < 0)) {
> +        r =3D -errno;
> +        error_setg_errno(errp, errno, "Cannot get VQ %u descriptor group=
",
> +                         vq_index);
> +        return r;
> +    }
> +
> +    return state.num;
> +}
> +
>  static int vhost_vdpa_set_address_space_id(struct vhost_vdpa *v,
>                                             unsigned vq_group,
>                                             unsigned asid_num)
> --
> 1.8.3.1
>



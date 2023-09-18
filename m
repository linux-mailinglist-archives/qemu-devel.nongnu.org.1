Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A42C77A453C
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:57:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiA4K-0001cv-H0; Mon, 18 Sep 2023 04:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qiA4A-0001SM-AS
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:57:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qiA45-0000SO-On
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695027429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bRIRQCSacffDE9iJjSkoOgsBpJ+0SmwzBi8ymqjR58g=;
 b=FaVzjVmybS38atc36q9uD1bN2b8wOtSd3BHtIwN3Tcu1Maunl06Qx0jyRNjGgSGm60tTjs
 FGlwbX4SIgFOrjIUAGNDKxTs2DqsZ/f9pmC37SX8tw/M/sQ7Za+nyZaU4TJRx2+lPB9pwf
 2ooT1971g34fTC0nJ+c+b7u3cIzLw0Q=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-XnPtGL_lPmGm2_mU2yf90A-1; Mon, 18 Sep 2023 04:57:07 -0400
X-MC-Unique: XnPtGL_lPmGm2_mU2yf90A-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-502e2bc6595so4769854e87.3
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 01:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695027425; x=1695632225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bRIRQCSacffDE9iJjSkoOgsBpJ+0SmwzBi8ymqjR58g=;
 b=R4Oy4haTCHGEHSYM6MaV0ghO2dabzL+u1Xw7CHB+tifYUjMuA/rY75UxH7hD7cmQ3m
 10mhAAHlM1yLGX67tOou4SDkEcBlVgdwEO62DTXc3BLvgE35jIcNuiOBwDHaE5b9aiBS
 4eXP2rJCXtotXx4yAlBU7iiweFm6F6+vc8HNBcFxsZVTEDDtlodgPT0eUzanfSWSh4QH
 CSyY5Bn0+6OfH5UVBu9qGK27dgYy1epivYpxkMa4zxBQ3gZw3U/P6WdRLS/nUiITM6er
 HcMOEepZg1Rzo7D95U+1Evranh3CAwKLEgpPBLeJ0YHwvrqG+xXWHWwYLb73vAZI0bH1
 cl5Q==
X-Gm-Message-State: AOJu0YzOr8DwiiE2OXIdW8Ayq+kv0MxGJGQz3QH++6yV2+TwHRMwvGxR
 hvqm+Vuo1rKJJQm1+u72XQNQP4fQR1iblWYKdCiRNOygF4MAkzDz4QLMNhRhpuJEKZDDIFK/RBd
 gtB6depLaheQ3HP5c3iPppLkIX3VtLYQMMC+B8e2MbBTO
X-Received: by 2002:a05:6512:4003:b0:500:b63f:4db3 with SMTP id
 br3-20020a056512400300b00500b63f4db3mr8985468lfb.35.1695027425025; 
 Mon, 18 Sep 2023 01:57:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnvMn8bXXph9hzIxg/1ZVjQ3yJSjS3P1w79Jo7e8EkIYZehVQB21QTM+n8gwf1y5dnvjE361TDVcnnSgPfKwY=
X-Received: by 2002:a05:6512:4003:b0:500:b63f:4db3 with SMTP id
 br3-20020a056512400300b00500b63f4db3mr8985453lfb.35.1695027424728; Mon, 18
 Sep 2023 01:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230915170322.3076956-1-eperezma@redhat.com>
 <20230915170322.3076956-4-eperezma@redhat.com>
In-Reply-To: <20230915170322.3076956-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Sep 2023 16:56:53 +0800
Message-ID: <CACGkMEtorjo8CVsLP2TB7hOZT3AK69uzEN0NsTYGmE0J-=i23w@mail.gmail.com>
Subject: Re: [PATCH 3/3] vdpa net: follow VirtIO initialization properly at
 cvq isolation probing
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Hawkins Jiawei <yin31149@gmail.com>, si-wei.liu@oracle.com,
 Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Sat, Sep 16, 2023 at 1:03=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> This patch solves a few issues.  The most obvious is that the feature
> set was done previous to ACKNOWLEDGE | DRIVER status bit set.  Current
> vdpa devices are permissive with this, but it is better to follow the
> standard.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  net/vhost-vdpa.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 51d8144070..4b30325977 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1270,8 +1270,7 @@ static int vhost_vdpa_probe_cvq_isolation(int devic=
e_fd, uint64_t features,
>      uint64_t backend_features;
>      int64_t cvq_group;
>      uint8_t status =3D VIRTIO_CONFIG_S_ACKNOWLEDGE |
> -                     VIRTIO_CONFIG_S_DRIVER |
> -                     VIRTIO_CONFIG_S_FEATURES_OK;
> +                     VIRTIO_CONFIG_S_DRIVER;
>      int r;
>
>      ERRP_GUARD();
> @@ -1286,15 +1285,22 @@ static int vhost_vdpa_probe_cvq_isolation(int dev=
ice_fd, uint64_t features,
>          return 0;
>      }
>
> +    r =3D ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
> +    if (unlikely(r)) {
> +        error_setg_errno(errp, -r, "Cannot set device status");
> +        goto out;
> +    }
> +
>      r =3D ioctl(device_fd, VHOST_SET_FEATURES, &features);
>      if (unlikely(r)) {
> -        error_setg_errno(errp, errno, "Cannot set features");
> +        error_setg_errno(errp, -r, "Cannot set features");
>          goto out;
>      }
>

Spec requires a re-read ?

"
Re-read device status to ensure the FEATURES_OK bit is still set:
otherwise, the device does not support our subset of features and the
device is unusable.
"

Thanks

> +    status |=3D VIRTIO_CONFIG_S_FEATURES_OK;
>      r =3D ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
>      if (unlikely(r)) {
> -        error_setg_errno(errp, -r, "Cannot set status");
> +        error_setg_errno(errp, -r, "Cannot set device status");
>          goto out;
>      }
>
> --
> 2.39.3
>



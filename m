Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 741DE8197C3
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 05:26:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFo9S-0006jx-Bz; Tue, 19 Dec 2023 23:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rFo99-0006jS-Ns
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 23:25:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rFo96-0002N8-Qu
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 23:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703046321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l6tcioI9vASLrfBRGoA6/zkTh4WmOO18ucvOqcV6zg0=;
 b=TLdn6bNED2phl4zMaYR/NJGXpxSstDHghCqgasiKOJgxmAhfzIamH50BazmDZue1salXjH
 M/CZL3Tb8oZZRjSctkAbHoylZ3IUaAVGjCZeI2WH/sBFj1j8nXX3E29pcwnUaY7ZAtyenf
 B9L1lRY8pJF8kAxuXLxUKsxSBF6g0VA=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-ccurwzYLN36DPf7oI56VkA-1; Tue, 19 Dec 2023 23:25:19 -0500
X-MC-Unique: ccurwzYLN36DPf7oI56VkA-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6da6041afddso4717520a34.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 20:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703046319; x=1703651119;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l6tcioI9vASLrfBRGoA6/zkTh4WmOO18ucvOqcV6zg0=;
 b=tV82sFD9tCk9n/TylCM4Vk+WcofR8Gu2OlnYyrQXO4guusc0CX887Vz4r/gMiF6nyY
 OPZqClFZX37U+wrqyBXtmx+/mjF7+igSsYMHwYeO0VxRmx4v3OdSGh2b+p1V/ie3emSK
 SLzehM655k/Y2n3Pm8NGgyTrZ0+za4Y5d8aszqrxF0e5JrHHBGx+rCk4vnywmiAZe+dI
 EgJXXtwEqn1xxBjrAFNkYZ0jvwYYWGIUknvHQZO4IXH3oMMs4DqVPUj5degSbubyDHM8
 lZINMypQdeWzsalV4EcX7iaPg+6zrJ3aZnbUE/R/mEUSGbUMIXAcBOF9mGxTIZVNXdn5
 3fGQ==
X-Gm-Message-State: AOJu0YwRSjEzXQx3ywLqmlFwY/Z45zoOuI4MpQFAiVB5zpy6LeFDiyrs
 TRtt1DZeOuC258jaGud/LXedPuPGGaOwp2DRHTvfUKYLpX8jp49LyZ5r9zF1c/CrgBmDMFgKjc5
 ilNnwVPqq1OqRZqJFedmmap8UxnRCpa4=
X-Received: by 2002:a9d:7444:0:b0:6db:ab21:d005 with SMTP id
 p4-20020a9d7444000000b006dbab21d005mr716278otk.69.1703046318967; 
 Tue, 19 Dec 2023 20:25:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1a7JAP5UvduIjOxYlMCF7zIAXI0hbXqxKLEUFjpdxDjR002xbza+lr4ietseFvT79+T1N3Ms+6MjZhxMRUh8=
X-Received: by 2002:a9d:7444:0:b0:6db:ab21:d005 with SMTP id
 p4-20020a9d7444000000b006dbab21d005mr716273otk.69.1703046318780; Tue, 19 Dec
 2023 20:25:18 -0800 (PST)
MIME-Version: 1.0
References: <20231215172830.2540987-1-eperezma@redhat.com>
 <20231215172830.2540987-2-eperezma@redhat.com>
In-Reply-To: <20231215172830.2540987-2-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 12:25:07 +0800
Message-ID: <CACGkMEtxq=GZMHkaY61uucyRfUmnB7ZJu9B5U=bJ0p4ekxf81w@mail.gmail.com>
Subject: Re: [PATCH for 9.0 01/12] vdpa: do not set virtio status bits if
 unneeded
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 si-wei.liu@oracle.com, 
 Lei Yang <leiyang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Sat, Dec 16, 2023 at 1:28=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Next commits will set DRIVER and ACKNOWLEDGE flags repeatedly in the
> case of a migration destination.  Let's save ioctls with this.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  hw/virtio/vhost-vdpa.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 7500c2fc82..cc252fc2d8 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -510,6 +510,10 @@ static int vhost_vdpa_add_status(struct vhost_dev *d=
ev, uint8_t status)
>      if (ret < 0) {
>          return ret;
>      }
> +    if ((s & status) =3D=3D status) {
> +        /* Don't set bits already set */
> +        return 0;
> +    }
>
>      s |=3D status;
>
> --
> 2.39.3
>



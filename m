Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF12E77B1DE
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 08:58:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVRXD-0004i9-Np; Mon, 14 Aug 2023 02:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qVRX7-0004Jn-4X
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 02:58:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qVRX3-0005Xg-5J
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 02:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691996307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0t8BGM5qFv3I4be0V9QgJoGR+yPmSI/yf1QQ3pHbjYQ=;
 b=MpqslSKKqbZrL1ictwsWGH2HwZNKtuPw2bE8xNABYx3SClek4ISS8X2ckfMie04F8pXEFO
 BG4OlTYBzj3N2N5uRokbnhHnAwMJ4n8zpVX/iqoHGUJr0eMPwIOztwC6I2PUFzAgsRLnE+
 3v1AZrrHPWNMNL4LSuaSLGAcm+D9cJg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-FND5WHfpOZiuta0DjSNoVg-1; Mon, 14 Aug 2023 02:58:26 -0400
X-MC-Unique: FND5WHfpOZiuta0DjSNoVg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ba37b5519fso39677511fa.2
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 23:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691996304; x=1692601104;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0t8BGM5qFv3I4be0V9QgJoGR+yPmSI/yf1QQ3pHbjYQ=;
 b=MHgnVvt16cflh/3PZMzi1cV7kH7cpFA3gMOUZjN7Po1dUdUGX9A/kk9u/0b9XrUZCm
 80Ju2efvrZ6G6Mj3iIobi6k354ejE9q88lR7GVkaMUu0M6j3elaw8/nKsHuDEUmopxf+
 0929XIucjdzmePgN8HhaF7sH+5f8E/asrSBiOwwqoErZsnGSvky5pSt0+jKTCvM9CpKg
 92tFrO0vOS5Q2bWOi1zMgm49sB0XCHEyU9QiMUsvqN9LK/H0lcQTMAu3eS7KFciBCl/S
 3Aid5qrrSdtb6ev1Hlkcz8s4blkPs7XvqX/mIeTr7lE1YOv0uNYTslny/OVyk/rZ/JWX
 2wNw==
X-Gm-Message-State: AOJu0YzXFEppABJ/p5fv8LSdx/1dU7g5fkGt4znz37MajZHYZT+9IURf
 Rvf9193i2cPfiPUQD5a5mSyaSM1JipppevYKZro1jFZx4aQoCcRJTJ/RLCQiaZGsiez6QU9oSoE
 HickcJPPQP5VbDzTOj4JeAWHcQ1BtgJQ=
X-Received: by 2002:a05:651c:110:b0:2b6:ecdd:16cf with SMTP id
 a16-20020a05651c011000b002b6ecdd16cfmr5417554ljb.40.1691996304606; 
 Sun, 13 Aug 2023 23:58:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkNz8IAl+o3e2XMcrgJMYPdfDBvnLlIRMwfX3psIilU6637kxQZFcSPs+OH9HjNrg2zJpjjLRKbkozywWQSl8=
X-Received: by 2002:a05:651c:110:b0:2b6:ecdd:16cf with SMTP id
 a16-20020a05651c011000b002b6ecdd16cfmr5417541ljb.40.1691996304448; Sun, 13
 Aug 2023 23:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230810153611.3410882-1-eperezma@redhat.com>
 <20230810153611.3410882-6-eperezma@redhat.com>
In-Reply-To: <20230810153611.3410882-6-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Aug 2023 14:58:13 +0800
Message-ID: <CACGkMEuWJjE97tFw9HE_4F3n4hEbQTMSfp2q3adXLK6yWoCDCA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] vdpa: remove net cvq migration blocker
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, si-wei.liu@oracle.com, 
 Parav Pandit <parav@mellanox.com>, Gautam Dawar <gdawar@xilinx.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cindy Lu <lulu@redhat.com>, Harpreet Singh Anand <hanand@xilinx.com>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Hawkins Jiawei <yin31149@gmail.com>, Shannon Nelson <snelson@pensando.io>,
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Aug 10, 2023 at 11:36=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>
> Now that we have add migration blockers if the device does not support
> all the needed features, remove the general blocker applied to all net
> devices with CVQ.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  net/vhost-vdpa.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 3bf60f9431..6bb56f7d94 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1413,18 +1413,6 @@ static NetClientState *net_vhost_vdpa_init(NetClie=
ntState *peer,
>          s->vhost_vdpa.shadow_vq_ops =3D &vhost_vdpa_net_svq_ops;
>          s->vhost_vdpa.shadow_vq_ops_opaque =3D s;
>          s->cvq_isolated =3D cvq_isolated;
> -
> -        /*
> -         * TODO: We cannot migrate devices with CVQ and no x-svq enabled=
 as
> -         * there is no way to set the device state (MAC, MQ, etc) before
> -         * starting the datapath.
> -         *
> -         * Migration blocker ownership now belongs to s->vhost_vdpa.
> -         */
> -        if (!svq) {
> -            error_setg(&s->vhost_vdpa.migration_blocker,
> -                       "net vdpa cannot migrate with CVQ feature");
> -        }
>      }
>      ret =3D vhost_vdpa_add(nc, (void *)&s->vhost_vdpa, queue_pair_index,=
 nvqs);
>      if (ret) {
> --
> 2.39.3
>



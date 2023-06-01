Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEE6719F71
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 16:15:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4j4h-000804-5i; Thu, 01 Jun 2023 10:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q4j4e-0007zJ-Ku
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:14:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q4j4d-0005Sk-5Y
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685628882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6C3tEoUDeXJBr+78cFarY1ZZvQpwQ6aCaqKlQ272WTw=;
 b=i66ZbkJR/dDQ5H1j//gnMtbfOdoo9W3+gP3bxvMGy1ZvArsT2VZsPlwEvZEPCX1GrLCiuP
 CQ3o9FLOtvuRt58oYoZOXOoMUtNDDTWSGTr9kUGb+N4PHvEbGYSTDL9GrTJcTtYkzIizMY
 Ky3csBltkb8WZKNRxCtYLYbxgjHCNb0=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-VgEmLjtgPXKGQraGxhsa-A-1; Thu, 01 Jun 2023 10:14:41 -0400
X-MC-Unique: VgEmLjtgPXKGQraGxhsa-A-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-1a28b6037f8so134736fac.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 07:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685628880; x=1688220880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6C3tEoUDeXJBr+78cFarY1ZZvQpwQ6aCaqKlQ272WTw=;
 b=XU2Z6Fn/fmlSqJPmo4kQFlMizr/jLRN+m23c5OccLc2mDiievYLin+McHASMhif0Ky
 eJROGfRJIa7ez90ygEl4RkxOEaQfNdwalAyqAv+jiljs2DuNT4ziRmXkjOF8m6fkmUwd
 bc6LE46Zde2soVvpGz8coZE74Chn3zi21P3o0QCXy8eKKfHiNWHnP7onJ+TfOzCZuJdz
 1HDxOgLgxf7UDi3adGNWzmxnMDRiU9uWCEyy32qwGHbjx45RXMW1RQr+WhTcP3Uq5lbj
 W/MhwXn3lpVmSPorHhsHTWL9w7xiLs12OvKVKvK450u4zB4gCezhPmoOixqB7ARDc2RI
 MVlQ==
X-Gm-Message-State: AC+VfDyy6AAPC7MF3UbXcTaAaAVhiJbMvGno9UoK5FfVzG3EuN455Ht9
 BjBr+FxI+3L2/APR5W9H1kUFJHlMEj1vnI8ECRzYLYw9bYPunwrOGGkPiMiIP/pEuI+grAbWFOE
 h3+FG2xY1x+cjZ73ldlAqqH+1hXsSCfo=
X-Received: by 2002:a05:6870:910a:b0:18f:170:ae14 with SMTP id
 o10-20020a056870910a00b0018f0170ae14mr7761718oae.34.1685628880570; 
 Thu, 01 Jun 2023 07:14:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6yvv6le2r+GlGFc4F24zpySx6rzYOFVqsKLeB26ZtfaEiZELA6lLfJYVs0cxVp151hIXPndksrIT3p/ro52KM=
X-Received: by 2002:a05:6870:910a:b0:18f:170:ae14 with SMTP id
 o10-20020a056870910a00b0018f0170ae14mr7761705oae.34.1685628880351; Thu, 01
 Jun 2023 07:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685623090.git.yin31149@gmail.com>
 <894aff17408eb129254cb7f8e5aec45502f4412d.1685623090.git.yin31149@gmail.com>
In-Reply-To: <894aff17408eb129254cb7f8e5aec45502f4412d.1685623090.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 1 Jun 2023 16:14:04 +0200
Message-ID: <CAJaqyWcW8qT7B97YfGgv-P-9GsS-LqaKb4nk=XBSh1gUdKgJoA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] include/hw/virtio: make some VirtIODevice const
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 1, 2023 at 3:49=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com> =
wrote:
>
> The VirtIODevice structure is not modified in
> virtio_vdev_has_feature(). Therefore, make it const
> to allow this function to accept const variables.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>

Reviewed-by: Eugenio P=C3=A9rez Martin <eperezma@redhat.com>

> ---
>  include/hw/virtio/virtio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index af86ed7249..0492d26900 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -402,7 +402,7 @@ static inline bool virtio_has_feature(uint64_t featur=
es, unsigned int fbit)
>      return !!(features & (1ULL << fbit));
>  }
>
> -static inline bool virtio_vdev_has_feature(VirtIODevice *vdev,
> +static inline bool virtio_vdev_has_feature(const VirtIODevice *vdev,
>                                             unsigned int fbit)
>  {
>      return virtio_has_feature(vdev->guest_features, fbit);
> --
> 2.25.1
>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADFE719F82
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 16:16:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4j5i-0000sv-5z; Thu, 01 Jun 2023 10:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q4j5e-0000rc-If
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q4j5d-0005lP-6O
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685628944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qgk5oZloqkyAFa9FbEzI+HD1RT7LIt4K3BNeJPYrQyQ=;
 b=WrAWP5iUw3K/TvTKYz863cn5Ks0ncdMn/TXDT26o8BVmPvelfTwPpMNpjrcd/U6zxWtVmq
 HxWR28+Tx5phkJlWKXUI61gMemIxti9ffoKuTH0Vs9w7LFy3C9N970KBdHiFsWayblCDZB
 gMwxwsDxmHzyjiixrd7ycOjwlfuuLbo=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-KJQe6h3aNUKExfOMgI7rHw-1; Thu, 01 Jun 2023 10:15:32 -0400
X-MC-Unique: KJQe6h3aNUKExfOMgI7rHw-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-55551c962dbso575056eaf.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 07:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685628930; x=1688220930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qgk5oZloqkyAFa9FbEzI+HD1RT7LIt4K3BNeJPYrQyQ=;
 b=Ba6kqbJXnzrEVkf93QlZWn1bw5DsxsE6/3QA+gZ1U7PhZ935IlTu3zStfMWX0qnbWW
 ju5ZxT+0qysBAd3C0eUpaXLwth8WbCa/+2uY8g05AouiPvRcKluiTQPU6pH00xoy46CB
 x7dPe4WAn6OlgU8D3we6nExuO2wgTK31Q6/Jv+OAd7+OE4olr5tceEXC068S30ZL/nRK
 tgOdjg4BuTyKSgSuiXwE0l/O1+Vkg3Z2pgBaH0Qj9Fo/zHzO6yfBQlod0ashCTCcLdYg
 6iu8LhtbH5rL0RXsr4VOGp0PFo/aSUx/q91DV0d7qpsiXAQeTdnnNIn3loM0RIt5Jyad
 5CoA==
X-Gm-Message-State: AC+VfDxjypr/xt9UzcSYEK3PHRz4ATmLYki2dd+NEeCvFyhET9XTBS1+
 lrqhExwMNlfdU07AayGZuBmZin40mXZamfROy8jjtPzSHe1hzk4C5IQ4YXq9He/sy9S68F4Dhs/
 3phzxUBqQwAfjJf69smNtJnUNbYkcN6c=
X-Received: by 2002:a05:6358:5923:b0:121:3f96:d40b with SMTP id
 g35-20020a056358592300b001213f96d40bmr2751650rwf.32.1685628930696; 
 Thu, 01 Jun 2023 07:15:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ48mELKlKoc05skoM4Ej6TrT/SIXiFpDu2z39JlTEvL8MwlGBTVwzL5+XlAan/RMniU0+/JYi0hkYN+UB/Gczw=
X-Received: by 2002:a05:6358:5923:b0:121:3f96:d40b with SMTP id
 g35-20020a056358592300b001213f96d40bmr2751630rwf.32.1685628930400; Thu, 01
 Jun 2023 07:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685623090.git.yin31149@gmail.com>
 <51fcd0b95186ef215825d420efe04e3ab9593936.1685623090.git.yin31149@gmail.com>
In-Reply-To: <51fcd0b95186ef215825d420efe04e3ab9593936.1685623090.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 1 Jun 2023 16:14:54 +0200
Message-ID: <CAJaqyWc3VnJsfuhALLVa0P8wBAqNBCamK2eyesGfQzk171+YYw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] vdpa: reuse virtio_vdev_has_feature()
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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
> We can use virtio_vdev_has_feature() instead of manually
> accessing the features.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  net/vhost-vdpa.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 37cdc84562..e907a3c792 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -643,8 +643,7 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState=
 *s, uint8_t class,
>
>  static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n=
)
>  {
> -    uint64_t features =3D n->parent_obj.guest_features;
> -    if (features & BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR)) {
> +    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_MAC_AD=
DR)) {
>          ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CT=
RL_MAC,
>                                                    VIRTIO_NET_CTRL_MAC_AD=
DR_SET,
>                                                    n->mac, sizeof(n->mac)=
);
> @@ -662,10 +661,9 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>                                    const VirtIONet *n)
>  {
>      struct virtio_net_ctrl_mq mq;
> -    uint64_t features =3D n->parent_obj.guest_features;
>      ssize_t dev_written;
>
> -    if (!(features & BIT_ULL(VIRTIO_NET_F_MQ))) {
> +    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_MQ)) {
>          return 0;
>      }
>
> --
> 2.25.1
>



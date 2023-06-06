Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9D472348F
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 03:34:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6LZY-0002MB-3Q; Mon, 05 Jun 2023 21:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q6LZX-0002Lz-1b
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 21:33:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q6LZV-0001KL-Mm
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 21:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686015196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vBIklHh+baLp1J/9sN6NLPt4eYVRdDZSuZIrRnWsdjU=;
 b=VEEQiiSBrtPrsAHsXjuy69qQ7m6grmjfGV4R173wGlIhnIm6g6zmd4JBhDQ8UE3ptoaMec
 yu3vHoiLqFsLwrEmkPwwhea3bB8Pm7Di8z5zUMESJsCSP+pQ7yMFY28ArlVw96PCb8L1T5
 jrM77HNJ713V9SXi+lzlOh/NkCb447o=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-rt000X4XPf23ZPqQZif7vg-1; Mon, 05 Jun 2023 21:33:09 -0400
X-MC-Unique: rt000X4XPf23ZPqQZif7vg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b1bfb15f44so14324581fa.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 18:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686015188; x=1688607188;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vBIklHh+baLp1J/9sN6NLPt4eYVRdDZSuZIrRnWsdjU=;
 b=NGe65Wb+VjORxwFSBGoGTw2WHSDAnerSSP8hJGAe3eG90Payx5IDykks9YgVMaPnfE
 kev9HF0UrnSvtk7rFXseG2+VNlQQ1bNe0hjqnWN0zvcO3PGo5lBUefveSCuzuQBQEFOd
 CQjRXn9RGXkV5xLCAuKEOKh6EmY8B/m6Z9EtZ86si1poA4oe0DhB08J6OFdcBi159n9/
 tpsraWAsbnuXKsxfw52miAKqSXoTqEmkjhg7dGEUV4G+lceY8/LRmo6+t2NedcLAdcI2
 VMApGHejZIZ68o/nGstHpV0u8iD0E/lM9r7J4nNNsgYF0w+q0OjAX6VC1kL9AmsFiSvY
 AOyw==
X-Gm-Message-State: AC+VfDzRgjmnGY+mJy4SS8UObSWzquWH1iMoVkv+rJubAf1QFmkVqAPl
 ScO+RKhxlDzhpGOQ+cZtSYP+swYxum1jodJqDhyyA8EkTm5Rz2jU0krueBWBt4ZosTl3F9+vMwZ
 c/65ZdbnFMaeZ5PbEke4JOxu5KVGaV4E=
X-Received: by 2002:a2e:870c:0:b0:2aa:481b:b439 with SMTP id
 m12-20020a2e870c000000b002aa481bb439mr598790lji.21.1686015188035; 
 Mon, 05 Jun 2023 18:33:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5fuo467jL4Xj9U9KYez8CLLDKwdIHP9IMUqehZFxRQQ0mfUxJIqLntHcfc9F65I1ngqy7xwixsaSiI3i9Hpsk=
X-Received: by 2002:a2e:870c:0:b0:2aa:481b:b439 with SMTP id
 m12-20020a2e870c000000b002aa481bb439mr598787lji.21.1686015187895; Mon, 05 Jun
 2023 18:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230602173328.1917385-1-eperezma@redhat.com>
In-Reply-To: <20230602173328.1917385-1-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Jun 2023 09:32:56 +0800
Message-ID: <CACGkMEufxwhQQHQYW+3ZA+4fbYhAsPOGbcrPkzB8tVGCGXf1Fw@mail.gmail.com>
Subject: Re: [PATCH] vdpa: mask _F_CTRL_GUEST_OFFLOADS for vhost vdpa devices
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Cindy Lu <lulu@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Hawkins Jiawei <yin31149@gmail.com>,
 Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Sat, Jun 3, 2023 at 1:33=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> QEMU does not emulate it so it must be disabled as long as the backend
> does not support it.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  net/vhost-vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 5360924ba0..427a57dd6f 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -54,6 +54,7 @@ const int vdpa_feature_bits[] =3D {
>      VIRTIO_F_VERSION_1,
>      VIRTIO_NET_F_CSUM,
>      VIRTIO_NET_F_GUEST_CSUM,
> +    VIRTIO_NET_F_CTRL_GUEST_OFFLOADS,
>      VIRTIO_NET_F_GSO,
>      VIRTIO_NET_F_GUEST_TSO4,
>      VIRTIO_NET_F_GUEST_TSO6,
> --
> 2.31.1
>



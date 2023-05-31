Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A83717355
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 03:48:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4AwP-0000DR-7V; Tue, 30 May 2023 21:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q4AwN-0000Cw-C4
 for qemu-devel@nongnu.org; Tue, 30 May 2023 21:47:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q4AwM-0000Xo-0f
 for qemu-devel@nongnu.org; Tue, 30 May 2023 21:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685497672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c2FLyZ27ha/DvUCXX9zWlwzcQo9m4OJyM5eglx+La9w=;
 b=WgY6C8xaBYP54WVqSRSXh+WLiwEogf4LH8CBXrVypmqMivBl5c1dBpa/NP6mAVC3b24pRx
 4oBhT8NLoTzLPZUQGZYirdkgltW5uA5PiXMtyDqjXfxbj+Mn/hoFHZmOJOnAIlq7So2uBe
 aJ+vQ4BZ0abjAHPfXIy1r6WzqVECbwM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-95QqKRv1NbKtY6JXTtvPIg-1; Tue, 30 May 2023 21:47:50 -0400
X-MC-Unique: 95QqKRv1NbKtY6JXTtvPIg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f381431472so3518405e87.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 18:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685497669; x=1688089669;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c2FLyZ27ha/DvUCXX9zWlwzcQo9m4OJyM5eglx+La9w=;
 b=POm4/ASL4EQpxKC1VZSKk2XqwmhrJ0oMwfj9akNpSn8B5mdI9IBKqQ3gvBp8CU4bgf
 VGAwD6flTzGtft5pMLqKFBd8Kz0aEWgRBhRpxx2yh+krsGBHkKrY9ydeVlyqYrAIoXQ7
 4JNz69kqNefv1a8P8qWS8DztSRmJXd/kWzNoHzqGbXiGpWQ7mWCAcYJPDvNFUnC6oeVx
 7uPpUbc/PdOabgwcPQdgks/WC5sij0RFECEPRsQZnrMC3zFSfRtYHLZn0MTMXfSzIOJv
 zWZ+rhsxE0oH/gCCImSMxHkI5j1JNBO/G573U1ia2i7R7MBB/MLCDqzpWZkPrV/RKkx8
 QsAQ==
X-Gm-Message-State: AC+VfDwlovNmXzlpQpNAHsHWLiQlxmGaMD6Mu5G/qRwAdGwyb+SIdYeE
 WIZEcE9BYfaL8A5hkcp92Jt/AV/hQKW3VI7T7+0JVovDLMR7LSXxQ9e62ngpLD3X3kLyUSwzoys
 NQAhQ5V6wS4gbZuCpvYgWyzksH3877lrqFoDJNTDC0g==
X-Received: by 2002:a2e:c52:0:b0:2a2:47a8:728b with SMTP id
 o18-20020a2e0c52000000b002a247a8728bmr1852737ljd.13.1685497668863; 
 Tue, 30 May 2023 18:47:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7cSXos/F1+IqoCALqqbX0Bv4bRpKh6ng/ZkAznNffjIG/0CXoEg1OuypxaCmOiACMHR19iqBmJ3sn5jbY638I=
X-Received: by 2002:a2e:c52:0:b0:2a2:47a8:728b with SMTP id
 o18-20020a2e0c52000000b002a247a8728bmr1852732ljd.13.1685497668610; Tue, 30
 May 2023 18:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685359572.git.yin31149@gmail.com>
 <77af042566b6f3fb10e3bd454962b52c3b60f12c.1685359572.git.yin31149@gmail.com>
In-Reply-To: <77af042566b6f3fb10e3bd454962b52c3b60f12c.1685359572.git.yin31149@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 May 2023 09:47:37 +0800
Message-ID: <CACGkMEtijf0N0ENUvVh9a9B+zKwQ3xsODjYcGxLQb=NaoLjJ=Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] vdpa: Allow VIRTIO_NET_F_CTRL_GUEST_OFFLOADS in SVQ
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: eperezma@redhat.com, 18801353760@163.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

On Mon, May 29, 2023 at 9:18=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> Enable SVQ with VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  net/vhost-vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 682c749b19..cc52b7f0ad 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -85,6 +85,7 @@ const int vdpa_feature_bits[] =3D {
>  static const uint64_t vdpa_svq_device_features =3D
>      BIT_ULL(VIRTIO_NET_F_CSUM) |
>      BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |
> +    BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) |
>      BIT_ULL(VIRTIO_NET_F_MTU) |
>      BIT_ULL(VIRTIO_NET_F_MAC) |
>      BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) |
> --
> 2.25.1
>



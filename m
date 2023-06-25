Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6AE73D03C
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 12:56:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDNPS-0000yg-QT; Sun, 25 Jun 2023 06:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qDNPQ-0000yQ-Ue
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 06:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qDNPP-0006QF-Ek
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 06:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687690554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wyZE/+g+Uaor3zibESLTWNv8dMJ2AGKO3M0jTSzra3M=;
 b=dU0eYlGKK8313BjtC4QU1MM0eqPjkAh3ZkButBaQa4PjwOqjEV0M2z8D+u4UFTftm4doD8
 m0GD8MiJBeFAzNMyjXMlKbIjPx2Ts4mCgH91ZZYMRdUNlrBp/3Ttr1eV+x3VjL/4Y6nTKH
 o7147TQyXFZKCD586IRv2o/4eT7OjVc=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-n9fAeR3AOlOazbEYbAcYWg-1; Sun, 25 Jun 2023 06:55:49 -0400
X-MC-Unique: n9fAeR3AOlOazbEYbAcYWg-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-bd69bb4507eso3287113276.2
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 03:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687690549; x=1690282549;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wyZE/+g+Uaor3zibESLTWNv8dMJ2AGKO3M0jTSzra3M=;
 b=fna22xaODGKpL0VIWOV9js4gCYYN/Bek5+n4bsCmmsmwCe6h/2Re5jlgWiZuc70DMq
 yZmyplQL+Hyzs1kP7VGq63tW8yEHev3CNumerqLHGd1XgFuqIH3woGQJhYDDFXG9n5j5
 U2/v+SgD4GE1o9XMwPVeCzqk6SVOZ8kBa1Op4Sdv73IPkK0NXbg0T+Mj1RlP7wgH+en1
 gdv4x2w++DPISUj53n+jYSJpKUYBH/ha42Wi2Z11s/OtyoAOmdVNEUtklLr5z773BWZt
 BI2S3BPo1Fyw4+Lwd98Kq5tROHlVQYeCQMChqpUu/jKbRDjEOxsFsih4iGNVEf0ZtsQq
 uojQ==
X-Gm-Message-State: AC+VfDxj1xocOeYCl+5l5PVd05HcwGaZHJs4Q/nni66LD4CwnUhNWXJB
 BVuinhehouivO1pwcN8cZtdnLchI7O6N9wXd40gOpDtHLZfObQdSXsjM42zn2yYXe2RJZpCIT1U
 1Jy3FOw9x4qNw93Ac7jiv6SQbbvGV5Zo=
X-Received: by 2002:a25:ec0d:0:b0:c17:2db6:21c with SMTP id
 j13-20020a25ec0d000000b00c172db6021cmr3012904ybh.8.1687690549293; 
 Sun, 25 Jun 2023 03:55:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7eH3qt3LW6Bg0C9AaMPVWzeM+ApG1D9hveGGvg9n+x82Dz4jEiZXyVMDIkoP4uiqrIPcJCnTea6cXwQKm4uVk=
X-Received: by 2002:a25:ec0d:0:b0:c17:2db6:21c with SMTP id
 j13-20020a25ec0d000000b00c172db6021cmr3012898ybh.8.1687690549106; Sun, 25 Jun
 2023 03:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687524532.git.yin31149@gmail.com>
 <c070a6a0f17afa6d1a00481d076b2e6fdb4d13f1.1687524532.git.yin31149@gmail.com>
In-Reply-To: <c070a6a0f17afa6d1a00481d076b2e6fdb4d13f1.1687524532.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Sun, 25 Jun 2023 12:55:13 +0200
Message-ID: <CAJaqyWdmSkCf61xC+p9N3BB7QYTXZW1zrisD8w2FAvpL_g_wew@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] vdpa: Allow VIRTIO_NET_F_CTRL_RX_EXTRA in SVQ
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Jun 23, 2023 at 3:26=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> Enable SVQ with VIRTIO_NET_F_CTRL_RX_EXTRA feature.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  net/vhost-vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 9b929762c5..cdfe8e454e 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -100,6 +100,7 @@ static const uint64_t vdpa_svq_device_features =3D
>      BIT_ULL(VIRTIO_NET_F_STATUS) |
>      BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
>      BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
> +    BIT_ULL(VIRTIO_NET_F_CTRL_RX_EXTRA) |
>      BIT_ULL(VIRTIO_NET_F_MQ) |
>      BIT_ULL(VIRTIO_F_ANY_LAYOUT) |
>      BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |
> --
> 2.25.1
>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 879367D8F80
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:16:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwH3u-0001wo-H3; Fri, 27 Oct 2023 03:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qwH3p-0001wO-Jh
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 03:15:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qwH3n-0008Al-RJ
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 03:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698390910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+aEfsPEpoqSBYCeQVdFqNEVvDsq50Qdpd+0L20hLWQ=;
 b=TctfLCvseCrCG9/HpPz2/a5k5Ac5Wqz5bzLkS7rxX7RS41okjO4nBRxLdMQioeDFIA7BLE
 s00aG4KkF656b6KNSHG2URe3P4xu5ZQQAaNF+VG3nnFAjEfIdhboFLjczjdzFOCdE7PCZi
 gH/F+LOqxU7RlKTsct8Keb+0DPxYPg8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-bwWCcgsONyaS_IPUc8Y4mA-1; Fri, 27 Oct 2023 03:15:08 -0400
X-MC-Unique: bwWCcgsONyaS_IPUc8Y4mA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5079630993dso1986143e87.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 00:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698390907; x=1698995707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R+aEfsPEpoqSBYCeQVdFqNEVvDsq50Qdpd+0L20hLWQ=;
 b=wui3un26vGO+lpZhlR1WgDAfxGcQXB2wcem4XS9+Buq/a/nfK0MnM6sBc0nKhR/Chb
 LuVqBZkyqmyOmHVf6/lu04FOeTbRoBt7L6ck8yOOCkZ0F/s0SyQjfAZwmSlHwXrmtFZr
 kFatQJFCfwwQbQpXawDtc9m5sb1+nXyYQbj8k642Bcau9PIYB9JsLPxsuk2tmMNDxSEj
 9kizGrkFxhDLthyJDFNznJKHlUha9BTQbg21FqJwm6H/nuqkEVRCKlcux6s5xZah9IAe
 Qs+7XSILWm9MuZO4qnC+wTiDPvaQDbjsV269gfmI2DSXu8yJ368wW+BgAkMPMxhLBeQ2
 j8sw==
X-Gm-Message-State: AOJu0Yz+ODRycrRTNFwSrihvYuMoqDqSX5oQ5AyGLK2ci1Z3LlYEDBt3
 vj15g8guCtOLUAM+VWe/A1/R5pfT/fkz4+4HZUGu7k/8J0/oNv/Lbk8gh0UDvUpLxiGbDovlExb
 hOz2COYKHvJj9KsqMu13pnmW2WQ0W6q8=
X-Received: by 2002:a05:6512:36c9:b0:507:a671:3230 with SMTP id
 e9-20020a05651236c900b00507a6713230mr981356lfs.16.1698390907491; 
 Fri, 27 Oct 2023 00:15:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOadWMjw/Zhk72bAnaXu2Ycq8UG5V8lYlbRENFYzvt0GDkywhDW9xdsaS1JR77lHae9iLU0CKSYHduGpzfkts=
X-Received: by 2002:a05:6512:36c9:b0:507:a671:3230 with SMTP id
 e9-20020a05651236c900b00507a6713230mr981346lfs.16.1698390907167; Fri, 27 Oct
 2023 00:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
 <20231017040932.62997-16-akihiko.odaki@daynix.com>
In-Reply-To: <20231017040932.62997-16-akihiko.odaki@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Oct 2023 15:14:56 +0800
Message-ID: <CACGkMEuA5azGUQzyCe=4xq+YfV60PuiOajhJ=1HOXoG9Gege5g@mail.gmail.com>
Subject: Re: [PATCH v5 15/21] virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 17, 2023 at 12:14=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> virtio-net can report hash values even if the peer does not have a
> virtio-net header.

Do we need a compat flag for this?

Thanks

>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/net/virtio-net.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index c6a92ba3db..dc2b7b8ee7 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -763,8 +763,6 @@ static uint64_t virtio_net_get_features(VirtIODevice =
*vdev, uint64_t features,
>          virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO4);
>          virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
>          virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
> -
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
>      }
>
>      if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
> --
> 2.42.0
>



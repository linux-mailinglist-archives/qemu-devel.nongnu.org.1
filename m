Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6B47E0492
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 15:19:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyv1D-0003Ic-AT; Fri, 03 Nov 2023 10:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qyv0v-0003E5-65
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 10:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qyv0m-0002f8-6M
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 10:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699021138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+30kyaHZ1KGC4l+463f0VC0JPFRvELxQfgTo1BGI5Pg=;
 b=KcCO8bmYc62jP0xysPuin85o6/5xOm0Fe9YhSLdKlxOQJlqNC+26+x/2zsouXvGog01Lhc
 5JYDw+prvtxOxkY2Jx36cdQG9mqFHL/BnQVjKX2+6z/LxxGoPzu3crQofH2GnusQAracqh
 dRQmCL8IA0FYe5lhNS4qJCv4saEUzso=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-ykV4ZQjlMNiF56aKtQ9BnA-1; Fri, 03 Nov 2023 10:18:57 -0400
X-MC-Unique: ykV4ZQjlMNiF56aKtQ9BnA-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-da033914f7cso2453777276.0
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 07:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699021137; x=1699625937;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+30kyaHZ1KGC4l+463f0VC0JPFRvELxQfgTo1BGI5Pg=;
 b=Dy+Wulqsp7UwCVcHZV2SX1zB5u51A/SkrISA7/rEGO88dm3Db1x4T/+LtPK+wFsulA
 1gbGAFiD8Y9Tlrf7eCFDtdi5a+bGl9jWNOjGcB/Ek+74bNoql4Bl6ZACVlSq9KBbhqiS
 TeBFraT7GJ9z3gT6P5u0ansQ+PKyaEkZCOAHmzcuxSwqsXtqThxBL6b0yImmpLIw3GuK
 VfNyfnLuXBDYWV2ZHqUHaErBlQXl6xZYjBLZqCwleKkYIREWp91auxwO5iEsdO6MxXea
 Pkcg5VtoTB8b4HMUDCafa4L+Y4EoMDYgj9TaUDPWa1nTp86bWrfELJQsyS338Bs0csAl
 aLNw==
X-Gm-Message-State: AOJu0Yx6Pv2Mtjna7KtHz+2+LLq+0UHjBOzqNCsl/rCoCoJroDnHJ53x
 4e3AOY4wknvDh+nufAcFSoYvQUX/t3jk8Y09CCrNj4detbokFv9LIVr1IM58g3Gpn1fcSNi6WS8
 5EoY/+ENQuPi3EnxaFvCE5iX38OTc89U=
X-Received: by 2002:a25:d016:0:b0:da0:c49a:5fe2 with SMTP id
 h22-20020a25d016000000b00da0c49a5fe2mr21925748ybg.24.1699021136945; 
 Fri, 03 Nov 2023 07:18:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVtAOwAlcLPvIGkPc0alD5ad7H2U1sejhXdAu7juZkOr92q+DBOvCwUwdIomnthdR/KMP99O00MIJ4/axAYBM=
X-Received: by 2002:a25:d016:0:b0:da0:c49a:5fe2 with SMTP id
 h22-20020a25d016000000b00da0c49a5fe2mr21925734ybg.24.1699021136724; Fri, 03
 Nov 2023 07:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698194366.git.yin31149@gmail.com>
 <d66b0aee501cdad7954231900c35a11cad1e13db.1698194366.git.yin31149@gmail.com>
In-Reply-To: <d66b0aee501cdad7954231900c35a11cad1e13db.1698194366.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 3 Nov 2023 15:18:20 +0100
Message-ID: <CAJaqyWc2=hbzfDhtAKPn9vebNnmz5EQoK=ecwU0-xbcEBuwwTw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] vdpa: Allow VIRTIO_NET_F_HASH_REPORT in SVQ
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
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

On Wed, Oct 25, 2023 at 3:02=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> Enable SVQ with VIRTIO_NET_F_HASH_REPORT feature.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
> v4:
>   - no changes
>
> v3: https://lore.kernel.org/all/c3b69f0a65600722c1e4d3aa14d53a71e8ffb888.=
1697902949.git.yin31149@gmail.com/
>   - no code changes
>
> v2: https://lore.kernel.org/all/a67d4abc2c8c5c7636addc729daa5432fa8193bd.=
1693297766.git.yin31149@gmail.com/
>
>  net/vhost-vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index e59d40b8ae..54f748d49d 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -121,6 +121,7 @@ static const uint64_t vdpa_svq_device_features =3D
>      BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |
>      /* VHOST_F_LOG_ALL is exposed by SVQ */
>      BIT_ULL(VHOST_F_LOG_ALL) |
> +    BIT_ULL(VIRTIO_NET_F_HASH_REPORT) |
>      BIT_ULL(VIRTIO_NET_F_RSC_EXT) |
>      BIT_ULL(VIRTIO_NET_F_STANDBY) |
>      BIT_ULL(VIRTIO_NET_F_SPEED_DUPLEX);
> --
> 2.25.1
>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C075D77B1DF
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 08:58:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVRXB-000451-6e; Mon, 14 Aug 2023 02:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qVRWo-000436-HR
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 02:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qVRWn-0005UU-2v
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 02:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691996292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wy1dE4ABuWoAQ18fmIjxN2lADQZWKFejEEyMyet+050=;
 b=f43bdzOkUMxtAGt+FOuvnIHdNAt9fXIy4OxAHRhNebvqphX7GlapE9luCcMu2gPxK1c2TO
 2gxdW91fIdfujkywTUmetr1W02YK7yZYU6UBC2YSj7YnFl5uB2JLentzxi4oWS+iveLK/e
 jfrO1e8mvsWti2HiUMg/MOY/bfBFsiE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-_zc83vxuO56mw2D6hZmGsg-1; Mon, 14 Aug 2023 02:58:10 -0400
X-MC-Unique: _zc83vxuO56mw2D6hZmGsg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4fe1d8bd885so2784252e87.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 23:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691996289; x=1692601089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wy1dE4ABuWoAQ18fmIjxN2lADQZWKFejEEyMyet+050=;
 b=EuPYJVVkXaBShiJNj5K14jrJvfP+He9goeI4ozC1f3OgO2E0xkUralNxrWtH/+kNra
 TsGPX6NKYq46Wmu+YW/BQRCQ5VKjzMbfUUrqb/+YURo61FckZNfm6uhoHPDWlURdcbjX
 zpgs/pLTiA3bleolLgeqhjW9LZ311ExVIbkwE1bG+fbvQQsqCYL6xSp2ModYHPEfOKjp
 spWQm5JpiTLIPxzCvtb84d27eqZZozHFJLbfptYx9XeXwnLvAi5BvgiRjdNBRBeBAMEa
 Q3h95mY7kfiCzMm+r32Hqm8wyh8CXxaFAemO71uzMPw7rAOckQSifrsIkF1dIYcJ85J+
 53SA==
X-Gm-Message-State: AOJu0YwJe5nP1c/c6u93Y5RUiBa6rsgVITEcgp0eC9EhoJ8wXgigRxbo
 MzuxdWIJbs72jzyPAq2z54AyHZPLAUktLi25xAN5fG8b313JUQNcA9peFycXkLmcRnqNgMF/o+T
 YAiGqmObkfSY6p5OTVYrcgkvXmeYlhmw=
X-Received: by 2002:a05:651c:1064:b0:2b9:dd64:8415 with SMTP id
 y4-20020a05651c106400b002b9dd648415mr3872088ljm.24.1691996289536; 
 Sun, 13 Aug 2023 23:58:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb2LiZ2OXZTnLYseJLMYkkV1JmRmEzf5WYf+tPt9Sa65YWnr9yFCqiKQB/RtJWUsfhPjt7JFfGV0PR8U4/b/w=
X-Received: by 2002:a05:651c:1064:b0:2b9:dd64:8415 with SMTP id
 y4-20020a05651c106400b002b9dd648415mr3872069ljm.24.1691996289187; Sun, 13 Aug
 2023 23:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230810153611.3410882-1-eperezma@redhat.com>
 <20230810153611.3410882-4-eperezma@redhat.com>
In-Reply-To: <20230810153611.3410882-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Aug 2023 14:57:58 +0800
Message-ID: <CACGkMEvdUdhr3u3pKR1V8mByXtJxD_4zZ69VQ+NPx4LE-6Boew@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] vdpa: rename vhost_vdpa_net_load to
 vhost_vdpa_net_cvq_load
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
> Next patches will add the corresponding data load.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  net/vhost-vdpa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index a772540250..9251351b4b 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -965,7 +965,7 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>      return 0;
>  }
>
> -static int vhost_vdpa_net_load(NetClientState *nc)
> +static int vhost_vdpa_net_cvq_load(NetClientState *nc)
>  {
>      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
>      struct vhost_vdpa *v =3D &s->vhost_vdpa;
> @@ -1004,7 +1004,7 @@ static NetClientInfo net_vhost_vdpa_cvq_info =3D {
>      .size =3D sizeof(VhostVDPAState),
>      .receive =3D vhost_vdpa_receive,
>      .start =3D vhost_vdpa_net_cvq_start,
> -    .load =3D vhost_vdpa_net_load,
> +    .load =3D vhost_vdpa_net_cvq_load,
>      .stop =3D vhost_vdpa_net_cvq_stop,
>      .cleanup =3D vhost_vdpa_cleanup,
>      .has_vnet_hdr =3D vhost_vdpa_has_vnet_hdr,
> --
> 2.39.3
>



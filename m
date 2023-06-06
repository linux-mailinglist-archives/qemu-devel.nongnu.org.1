Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 941DF723490
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 03:34:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6LYu-0002IU-3k; Mon, 05 Jun 2023 21:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q6LYr-0002I6-U6
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 21:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q6LYq-0001FW-Gb
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 21:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686015154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hlHuC3goTxkrnduXxJjcCl1AA5evZXvdgMcw39lduis=;
 b=LG4ODNXqRuh98c9LjeAAw7QvatnhOGVA+om5A/UX9c4wKllw8g1xrSaIyP1pLNnXUQgNVq
 3Fb3ryqIPL95TMXikkEZpjdHvDnfUWEWsj2WZHHhkSK66AUSuXPQdaO5nZ58XHg5rW6kXC
 NLc4ukXGHBTy9IMb82xLymOBCOIiHrk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-xUZeluU-OVmUFrDcWmkkoA-1; Mon, 05 Jun 2023 21:32:33 -0400
X-MC-Unique: xUZeluU-OVmUFrDcWmkkoA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b1c60977e3so14352971fa.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 18:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686015151; x=1688607151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hlHuC3goTxkrnduXxJjcCl1AA5evZXvdgMcw39lduis=;
 b=g1hvvDEzDkpyHctHpoGxCxtkafZGHCGyg/wnr7Dqa1E07k5AiFNNuzUtgg2JoeRVSk
 Astg4PNmuW8bPuVOYg6HfYUkNHuMoNH/QmVD/JPV2Z8MhlXXugJXAuUzc7NZ5xneLDwt
 non5nfAe/PKbD0kGfw1RZO+vGKZIwkW/DkMEJbjcJj0biTd3/I+AYWy+UwgdiXpV16Ft
 o4N/4cel3ykiF2+TDFvbXIQbAGfEIohG6x+DiYoDiHyrpbF43Nf1R1V5W9DAbpNrWmFK
 zAuPMMzLHcmyrvA4DV6cz4daTzftoZW9FtJcy2C967o6gspxVcE7uezh13kGaGC7hO1W
 pOkw==
X-Gm-Message-State: AC+VfDym+PqpK4a7VGEEMCwgF0HJ8hCMOruDWswgwlbFPoFl5yU7+9tu
 8J7HMhW1hFCEjgz/vgqvXoQhMIdCfAhIM2g+bga7DdR/FXDU4Cnrn3Jz+lL2Da3yiQKXjVfs6BP
 BaahQAdlZIkYCOs/8V+EVM5fV4cR1UtM=
X-Received: by 2002:a2e:90cd:0:b0:2a7:a719:5943 with SMTP id
 o13-20020a2e90cd000000b002a7a7195943mr470153ljg.40.1686015151718; 
 Mon, 05 Jun 2023 18:32:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5k3hvhIgACEeA68MRn/ouKVxLOr7NsXIbkWtoBtdjavhuvBON89v2ol8EOFHPpQY+uuX+e8KBlyPPVpumUJ+E=
X-Received: by 2002:a2e:90cd:0:b0:2a7:a719:5943 with SMTP id
 o13-20020a2e90cd000000b002a7a7195943mr470149ljg.40.1686015151421; Mon, 05 Jun
 2023 18:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230602173451.1917999-1-eperezma@redhat.com>
In-Reply-To: <20230602173451.1917999-1-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Jun 2023 09:32:20 +0800
Message-ID: <CACGkMEsgnMjYYxyXy3ERet=oXyYD4Z8ULL4w+hK4yhUJTRYWsw@mail.gmail.com>
Subject: Re: [PATCH] vdpa: fix not using CVQ buffer in case of error
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Cindy Lu <lulu@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Hawkins Jiawei <yin31149@gmail.com>
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

On Sat, Jun 3, 2023 at 1:35=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> Bug introducing when refactoring.  Otherway, the guest never received
> the used buffer.
>
> Fixes: be4278b65fc1 ("vdpa: extract vhost_vdpa_net_cvq_add from vhost_vdp=
a_net_handle_ctrl_avail")
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  net/vhost-vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 16d47f7b3c..5360924ba0 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -807,7 +807,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShad=
owVirtqueue *svq,
>      }
>
>      if (*s->status !=3D VIRTIO_NET_OK) {
> -        return VIRTIO_NET_ERR;
> +        goto out;
>      }
>
>      status =3D VIRTIO_NET_ERR;
> --
> 2.31.1
>



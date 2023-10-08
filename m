Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EF37BCCD0
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:49:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpNaZ-0000TF-L5; Sun, 08 Oct 2023 02:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qpNaX-0000T7-CB
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qpNaV-0007Vl-Rv
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696747706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wgytnCkC+g/jtBTpH9HFj9V1cXa+bTuwmjGk38hoKZU=;
 b=RM4cEpKfNF3SeJX8JyfGUWu0bzYiE+5XCe2s+MBPFvJCh2DNMILBie3BfKUWOK/e+t/WgG
 ma5AYGbEZw1qkQR58rAXG26pZrDOb6vpwkWd05Y8d9T5Yt3XKPfaUhI8Yk8FfIJIPzReqB
 0uHspcDeWL+UB51/OUV9Ko7nlNHH+i0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-2ITPKVX4NVm40jzZXGvWTQ-1; Sun, 08 Oct 2023 02:48:14 -0400
X-MC-Unique: 2ITPKVX4NVm40jzZXGvWTQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-51bee352ffcso2675052a12.1
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 23:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696747692; x=1697352492;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wgytnCkC+g/jtBTpH9HFj9V1cXa+bTuwmjGk38hoKZU=;
 b=xO1lyurDUZmHP/mjrxM94WCqij3E9k5mGl6S9MgSuh9UpMJpcK4/uk8cPgC4EmOlVj
 hSWLmhFcQ7lhOXQAHwC/bNCPJrcdeI8bmQPSJioqVCFEFxu/CGkrDkrPQ8UOJj04hop6
 J59pvZNHglvFNo1qOaVU0gUyPOYJRjhwLkKmtBByZfjxCov9QfTdP2AmgdsOnkF+t1X3
 HaoFwW4LAvAQx5OBHOtju28ryCIqr4VolGliJ26xPBnU/kopGcrXekPPDxMCsyJceYFD
 R6zJaJfPBWuPg3od8esdWHq9leUZNQzzJw9n/00fbI0mSTpxAcYtVXyiBmVYTud5zHU1
 2QMg==
X-Gm-Message-State: AOJu0Yyb2j7zpO228DH/6Lvj5jzvwcbSBAuozG2B4EyWFgoRonASMjQ2
 PhmbyNocxOPwNDrhDvvZRu+8L/qzxp0vOzKYwh5yoT2l9em5c0BHyDk6y57QMy6pD8xI9ZLCeFp
 mGqg3rpP0hUmVbLRHHreyVmF0tRmi6IsD2BHg07Sq6A==
X-Received: by 2002:a05:6402:b35:b0:530:7ceb:334 with SMTP id
 bo21-20020a0564020b3500b005307ceb0334mr10520417edb.3.1696747691825; 
 Sat, 07 Oct 2023 23:48:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF48MyRrhK/CM327C+MVx34Uji1f7SBu6b6S/aOZsKaIX2q4ouRNjhr2EYEvaHz66vflNCP1PVXW0+8KErEayA=
X-Received: by 2002:a05:6402:b35:b0:530:7ceb:334 with SMTP id
 bo21-20020a0564020b3500b005307ceb0334mr10520412edb.3.1696747691572; Sat, 07
 Oct 2023 23:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231006173518.539085-1-thuth@redhat.com>
In-Reply-To: <20231006173518.539085-1-thuth@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 8 Oct 2023 10:47:59 +0400
Message-ID: <CAMxuvaz3DDSG_eoLDt0PNQNQxLiuyvY51VCuxw0kowPzohVd_w@mail.gmail.com>
Subject: Re: [PATCH] contrib/vhost-user-gpu: Fix compiler warning when
 compiling with -Wshadow
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
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

On Fri, Oct 6, 2023 at 9:35=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrote=
:
>
> Rename some variables to avoid compiler warnings when compiling
> with -Wshadow=3Dlocal.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  contrib/vhost-user-gpu/vugpu.h          | 8 ++++----
>  contrib/vhost-user-gpu/vhost-user-gpu.c | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vugp=
u.h
> index 509b679f03..5cede45134 100644
> --- a/contrib/vhost-user-gpu/vugpu.h
> +++ b/contrib/vhost-user-gpu/vugpu.h
> @@ -164,12 +164,12 @@ struct virtio_gpu_ctrl_command {
>  };
>
>  #define VUGPU_FILL_CMD(out) do {                                \
> -        size_t s;                                               \
> -        s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,  \
> +        size_t s_;                                              \
> +        s_ =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0, \
>                         &out, sizeof(out));                      \
> -        if (s !=3D sizeof(out)) {                                 \
> +        if (s_ !=3D sizeof(out)) {                                \
>              g_critical("%s: command size incorrect %zu vs %zu", \
> -                       __func__, s, sizeof(out));               \
> +                       __func__, s_, sizeof(out));              \
>              return;                                             \
>          }                                                       \
>      } while (0)
> diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user=
-gpu/vhost-user-gpu.c
> index aa304475a0..bb41758e34 100644
> --- a/contrib/vhost-user-gpu/vhost-user-gpu.c
> +++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
> @@ -834,7 +834,7 @@ vg_resource_flush(VuGpu *g,
>                  .width =3D width,
>                  .height =3D height,
>              };
> -            pixman_image_t *i =3D
> +            pixman_image_t *img =3D
>                  pixman_image_create_bits(pixman_image_get_format(res->im=
age),
>                                           msg->payload.update.width,
>                                           msg->payload.update.height,
> @@ -842,11 +842,11 @@ vg_resource_flush(VuGpu *g,
>                                                        payload.update.dat=
a),
>                                           width * bpp);
>              pixman_image_composite(PIXMAN_OP_SRC,
> -                                   res->image, NULL, i,
> +                                   res->image, NULL, img,
>                                     extents->x1, extents->y1,
>                                     0, 0, 0, 0,
>                                     width, height);
> -            pixman_image_unref(i);
> +            pixman_image_unref(img);
>              vg_send_msg(g, msg, -1);
>              g_free(msg);
>          }
> --
> 2.41.0
>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD990802C7F
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 08:55:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA3n4-0003N0-Oz; Mon, 04 Dec 2023 02:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rA3n2-0003Mj-UT
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 02:54:52 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rA3n1-0008R8-8P
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 02:54:52 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5d33574f64eso44569027b3.3
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 23:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701676490; x=1702281290; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYnmv2Vzy2MKZJLX90chlVXBqyLghXG1WAjaA6GnU78=;
 b=FaBQuStgnrSz9n+zS3rfK4gLUgszN84TaLQBmcOF62gE+TVq1LiMYeRWX7TBUm4Y9K
 T7b097aI5hSns5XGYfGdjTgKRW/PZevt1JKbVnB2GChBu8Tius9QwHu9ogUNDc4VNOvS
 EvNfdRaZwIrqm2jKPHCtIJsU/GLCJYCDUO+lLaE5f17ykUry6A5J9jsM6LNgKGbJ04QX
 ++rS+L9ZiGsoJgNqyGqXM+oCBtM+w3vMaMZbhQvigIPlPM3dOPHJhzmEmILT1m6SM8DG
 iPfxnQWOPWL+m3pH89QnKhnxWf9nvl7TtUvW/pqd1JTBNRxRXloqOFdjF8e4Tppakcs6
 eKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701676490; x=1702281290;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bYnmv2Vzy2MKZJLX90chlVXBqyLghXG1WAjaA6GnU78=;
 b=pSaCAMSwrrEfSflqRKo6SiWe10K3/+JM0PZ/lbC4Qp2IsaDW/ExxY26rrb7DQh5sUC
 RgDlIMxi+Rq3AXFtRscBtSCuxPNSRZ46W9fs1xwRl09VCgHUISA1rIcTnfhlw6nk9Ubb
 5XqazqZKQ3zlTLoAPiwYPkuI+rEhEsQyLFpfRztb5Z5f9DgzvRdfTbsQ/cYIrK5p0vpy
 2LVIdRkzlhw6dYIGFNWmO1ypxZ5aFcabmZfuIfXNtLJtTlIQguOC1/ahWQ3Dbe3Hdi6+
 kdwK/pZblcRCvEXLEKYw4RywCwOh4Jp7/S9hVA/0QlmB5jhY/+Z13rFPFEfeJprli0zR
 FMbg==
X-Gm-Message-State: AOJu0YxyqmFWBD60oSkxlarDDIqerBzTLSrpjx4u4ZanzzlzeunSkyqE
 ZiG4ImTy67v2z8GDkqPUfL6kcOVLqePlXQ8IQlk=
X-Google-Smtp-Source: AGHT+IFWwWoT/7pKMlC7gPZ0TIQhFO6C9aIYI4MzQ6rDlUNboiyjyQACRdcEQ++3d7T/RacDSLfnbUY8L3XoC3AAZiE=
X-Received: by 2002:a81:450d:0:b0:5d7:1940:b36d with SMTP id
 s13-20020a81450d000000b005d71940b36dmr2856357ywa.57.1701676489760; Sun, 03
 Dec 2023 23:54:49 -0800 (PST)
MIME-Version: 1.0
References: <20231107093744.388099-1-aesteve@redhat.com>
 <20231107093744.388099-2-aesteve@redhat.com>
In-Reply-To: <20231107093744.388099-2-aesteve@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 Dec 2023 11:54:38 +0400
Message-ID: <CAJ+F1CLohGjKaKYk8x4MbNQ6e0M=E15VeJ5wjYW=O9nMapOZmg@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/virtio: check owner for removing objects
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 kraxel@redhat.com, stefanha@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Nov 7, 2023 at 1:37=E2=80=AFPM Albert Esteve <aesteve@redhat.com> w=
rote:
>
> Shared objects lack spoofing protection.
> For VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE messages
> received by the vhost-user interface, any backend was
> allowed to remove entries from the shared table just
> by knowing the UUID. Only the owner of the entry
> shall be allowed to removed their resources
> from the table.
>
> To fix that, add a check for all
> *SHARED_OBJECT_REMOVE messages received.
> A vhost device can only remove TYPE_VHOST_DEV
> entries that are owned by them, otherwise skip
> the removal, and inform the device that the entry
> has not been removed in the answer.
>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  hw/virtio/vhost-user.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 7b42ae8aae..5fdff0241f 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1602,10 +1602,26 @@ vhost_user_backend_handle_shared_object_add(struc=
t vhost_dev *dev,
>  }
>
>  static int
> -vhost_user_backend_handle_shared_object_remove(VhostUserShared *object)
> +vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
> +                                               VhostUserShared *object)
>  {
>      QemuUUID uuid;
>
> +    switch (virtio_object_type(&uuid)) {

../hw/virtio/vhost-user.c:1619:13: error: =E2=80=98uuid=E2=80=99 may be use=
d
uninitialized [-Werror=3Dmaybe-uninitialized]
 1619 |     switch (virtio_object_type(&uuid)) {
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~

> +    case TYPE_VHOST_DEV:
> +    {
> +        struct vhost_dev *owner =3D virtio_lookup_vhost_device(&uuid);
> +        if (owner =3D=3D NULL || dev !=3D owner) {
> +            /* Not allowed to remove non-owned entries */
> +            return 0;
> +        }
> +        break;
> +    }
> +    default:
> +        /* Not allowed to remove non-owned entries */
> +        return 0;

How do you remove TYPE_DMABUF entries after this patch?

> +    }
> +
>      memcpy(uuid.data, object->uuid, sizeof(object->uuid));
>      return virtio_remove_resource(&uuid);
>  }
> @@ -1785,7 +1801,8 @@ static gboolean backend_read(QIOChannel *ioc, GIOCo=
ndition condition,
>          ret =3D vhost_user_backend_handle_shared_object_add(dev, &payloa=
d.object);
>          break;
>      case VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE:
> -        ret =3D vhost_user_backend_handle_shared_object_remove(&payload.=
object);
> +        ret =3D vhost_user_backend_handle_shared_object_remove(dev,
> +                                                             &payload.ob=
ject);
>          break;
>      case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
>          ret =3D vhost_user_backend_handle_shared_object_lookup(dev->opaq=
ue, ioc,
> --
> 2.41.0
>


--=20
Marc-Andr=C3=A9 Lureau


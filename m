Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE2B7264CF
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:38:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vDu-0007Fb-F5; Wed, 07 Jun 2023 11:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q6vDf-0007C8-Ic
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:37:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q6vDd-0001CV-VL
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686152224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LfAiCZNJDyEjBwvJ9dmaGVgUVkNBoo0vSXR2541cWYs=;
 b=R8CCcK8K+y6DbRRQoTOOMsp81N2XlXLcJ+wOystXZJNJeLPQg0UniM1f64JgNhtvUji/d6
 YTkJ6+QVKA2UXJoqyifq1kLEVi4jzMG5XtSe5vZmQoU2erqW/CcxFoJtCf5GyFmD3gSHSt
 y3lrn3m2m3wv/PhWvfkrcQsDgNy/WNM=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-gu4URfPfPwefSVkK0XIMcA-1; Wed, 07 Jun 2023 09:52:06 -0400
X-MC-Unique: gu4URfPfPwefSVkK0XIMcA-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-56942442eb0so114825567b3.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 06:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686145925; x=1688737925;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LfAiCZNJDyEjBwvJ9dmaGVgUVkNBoo0vSXR2541cWYs=;
 b=f7QOWD8nvE4SVrgLiYIMUsq2ALNgL+8J32Tbn8fNyRgIEhdP4arH7btHVgj9Vpn/Sg
 8a4tgHGRpZyCt8ncQeUV18bgg4C//rBPywOH1kI/vbV34AMIyaeXF6zfMZ3ahB4C66eG
 uudHchO6NER3eC5BknfhYlGM8Fy383otZGBguLeXPXsm/fTvZA1pIVg0MTTDEsn7goeI
 sZVlZzE/vKEXs+pNJXPixQGvCcsidrSY2VW/x0KigkSel3/HHhmUMkQ3H3Grd2PWcMW7
 /0vokQgEU6Fd2ws1jKPrAA6GI/ZkxIn2iCZTYW+Q1GZnplywfKj5R48iGQUYU8o0fNVX
 kTmQ==
X-Gm-Message-State: AC+VfDzGJ0W6uB4/eHDTzRr2lQN/dS23avFzBgxlff9tghEDglSVZPwx
 FpaVORotMk+GVwU7iDBe3DxWLPJEl2T4oTpdxcfN5VFsVic2gd17LYZdY2w6ocEyhBMOaBolPxR
 t4nGPA54QMrkzZyzw9pBmOdiv122zhGaP3a50pCkrYA==
X-Received: by 2002:a0d:eb88:0:b0:55a:4a73:6177 with SMTP id
 u130-20020a0deb88000000b0055a4a736177mr7197551ywe.42.1686145925697; 
 Wed, 07 Jun 2023 06:52:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7wevowBpBHxBNerRA6aSKCSiDaJJLbATQUJJdZzTs0xrz8cI0EBoYuqRu8/ZKG6ZtZPH8hO3d/VgDhNhawAAc=
X-Received: by 2002:a0d:eb88:0:b0:55a:4a73:6177 with SMTP id
 u130-20020a0deb88000000b0055a4a736177mr7197528ywe.42.1686145925362; Wed, 07
 Jun 2023 06:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230607170842.488489-1-lingshan.zhu@intel.com>
In-Reply-To: <20230607170842.488489-1-lingshan.zhu@intel.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 7 Jun 2023 15:51:29 +0200
Message-ID: <CAJaqyWdQRDb=cev7LUXKiK9-gBhB2CY7fmcT-M+pdjgb29qDcw@mail.gmail.com>
Subject: Re: [PATCH] vdpa: dont check vhost_vdpa->suspended when unsupported
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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

On Wed, Jun 7, 2023 at 11:09=E2=80=AFAM Zhu Lingshan <lingshan.zhu@intel.co=
m> wrote:
>
> When read the state of a virtqueue, vhost_vdpa need
> to check whether the device is suspended.
>
> This commit verifies whether VHOST_BACKEND_F_SUSPEND is
> negotiated when checking vhost_vdpa->suspended.
>

I'll add: Otherwise, qemu prints XXX error message.

On second thought, not returning an error prevents the caller
(vhost.c:vhost_virtqueue_stop) from recovering used idx from the
guest.

I'm not sure about the right fix for this, should we call
virtio_queue_restore_last_avail_idx here? Communicate that the backend
cannot suspend so vhost.c can print a better error message?

Thanks!

> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  hw/virtio/vhost-vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index b3094e8a8b..ae176c06dd 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -1397,7 +1397,7 @@ static int vhost_vdpa_get_vring_base(struct vhost_d=
ev *dev,
>          return 0;
>      }
>
> -    if (!v->suspended) {
> +    if ((dev->backend_cap & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) && (!v->su=
spended)) {
>          /*
>           * Cannot trust in value returned by device, let vhost recover u=
sed
>           * idx from guest.
> --
> 2.39.1
>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D89180D423
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 18:39:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCkEL-0003KY-7B; Mon, 11 Dec 2023 12:38:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCkEJ-0003J1-Ea
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:38:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCkEG-0006GW-NP
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702316283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FIkhc9u8fBoIQ7tSTmDdJXNWtnQ3Vk4oE0Q8qPhw2S0=;
 b=g7Yl0ERUkYZkdRs2B7H1ZacRi3v7cugGMuARSfoKRscXvbAGLDM9INB1XSm3n2/4eyNfdJ
 f6fcsLMVOb3C0KO+jJvxSh6aNR2KudT/ZmeVgYKsPQG164BtH+rHpyLjt8b4ajkCD6hPzD
 axwXkZmluzRhWC7KLlDB/iMFka7x544=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-uYiwqAO4Nn-ZkFJOuiQfxA-1; Mon, 11 Dec 2023 12:38:01 -0500
X-MC-Unique: uYiwqAO4Nn-ZkFJOuiQfxA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-5d12853cb89so52728957b3.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 09:38:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702316281; x=1702921081;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FIkhc9u8fBoIQ7tSTmDdJXNWtnQ3Vk4oE0Q8qPhw2S0=;
 b=ut85BBQPFCDvmvHu2LnjoW0ot1x3lxQFrc//WZ+9JUE4pVD8+V8OzU1d+RBwqGwcN3
 6AmqIlGAWxF0U0zBVIciAfu/6zVSbtvs3+1fGvNsQ2xW6TbEzv0WMjfzWh48chHUGn8d
 kgIsCfog4mrrhdVTLlcQh9etWnoFNCPXFGGkgoye8oqT0wr+fN/p0HHI5mXPFd+wHwfq
 JGHaqCQy0EUK7ZpaLYIQVUTJF3M7Elx6k7MMBCqhSKkyjEvQSeJg/pKCrGSD//lZIxNO
 maQ7fNEP9gxCua1tVewQZnHfNRQ2h5pNvLhYzduWhE644NQln4Tb88CA5IdWwow3i5BD
 7Lcw==
X-Gm-Message-State: AOJu0Yw66MwQwClfcqvCSPotdLS1u9DaZqA+v/DkKzDSCCNUf7AsGjBe
 XmdtTjXULryAWhsegtDylBMzImyR6GIRw1gqK06/jsN/LwheKpiwTD8w59qUJv9p/q/QSaGO3Rj
 tlLRV57QZ07Wn2UWjAeC8qr7CVH/0bNE=
X-Received: by 2002:a0d:d653:0:b0:5de:7945:a67e with SMTP id
 y80-20020a0dd653000000b005de7945a67emr2956009ywd.32.1702316281398; 
 Mon, 11 Dec 2023 09:38:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOQ46PY54cQjrSr84F02lTdR4HQY5fX2WKtFB6iobvkdh1N1GMSnZfgcE06BWVCzVe4K6ZCMRMZiPWyj/SNMw=
X-Received: by 2002:a0d:d653:0:b0:5de:7945:a67e with SMTP id
 y80-20020a0dd653000000b005de7945a67emr2956004ywd.32.1702316281155; Mon, 11
 Dec 2023 09:38:01 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-19-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-19-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Dec 2023 18:37:25 +0100
Message-ID: <CAJaqyWfRbtk1EuNGda6TuK2z1VDCgZLmi-mEC037zweHEWyWVw@mail.gmail.com>
Subject: Re: [PATCH 18/40] vdpa: unregister listener on last dev cleanup
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Dec 7, 2023 at 7:50=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> So that the free of iova tree struct can be safely deferred to
> until the last vq referencing it goes away.
>

I think this patch message went out of sync too.

> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  hw/virtio/vhost-vdpa.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 4f026db..ea2dfc8 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -815,7 +815,10 @@ static int vhost_vdpa_cleanup(struct vhost_dev *dev)
>      }
>
>      vhost_vdpa_host_notifiers_uninit(dev, dev->nvqs);
> -    memory_listener_unregister(&v->shared->listener);
> +    if (vhost_vdpa_last_dev(dev) && v->shared->listener_registered) {
> +        memory_listener_unregister(&v->shared->listener);
> +        v->shared->listener_registered =3D false;
> +    }

I think this version is more correct, but it should not matter as the
device cleanup implies the device will not be used anymore, isn't it?
Or am I missing something?

>      vhost_vdpa_svq_cleanup(dev);
>
>      dev->opaque =3D NULL;
> --
> 1.8.3.1
>



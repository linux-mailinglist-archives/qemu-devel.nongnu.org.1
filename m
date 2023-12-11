Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF9280C7D6
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 12:22:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCeMg-00063x-0Z; Mon, 11 Dec 2023 06:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCeMe-00063l-4j
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 06:22:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCeMc-0001xv-MD
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 06:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702293737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fUALn3EYzeyavfyzfoHcH5ztZj+KR6g3UdCubekCsM0=;
 b=jRFEwPa8I3NvWnJq/5qsxhwvki4OVglEGXAFN4nUZ6UrHIX/CKbZS5TKhTUvWtz08N1A2U
 uxPzbhlYCGqEsBzzJ5f/BN9ZuH0OXoaFdvy2G8SHqveQTZQFmiO5994GXZdUN//i52UHNH
 gbG9McJTqRl3xFBrQJcHm7mkNcHJOZM=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-KEvlAm9pPFm9wZewl0QCMA-1; Mon, 11 Dec 2023 06:22:16 -0500
X-MC-Unique: KEvlAm9pPFm9wZewl0QCMA-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-5d340a9cf07so52204497b3.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 03:22:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702293736; x=1702898536;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fUALn3EYzeyavfyzfoHcH5ztZj+KR6g3UdCubekCsM0=;
 b=ttSA4SGrGgUvDQCi7lkN9rzZW7wZaGY/LRPRyDavmro1lyGwKJbc+g7mH3jEKBH1+V
 i9mRG6rZMlnEQSwFXzlKt0k4dsIYIDA49AjPYds9nziiJ21QEGzZHfWjCjcq1oqifSB5
 dmZFB3eAsk+MyE+jXH0RycLIvQbfiuD40v7JqrHoYsNoc1ri4xtbKbp0psQM0AAu1dJ7
 puDeyF0nmg4zeCa9RwhTfWPoYLTMv/62dwbAa4izD7RWTaIWgeiD5aS2aNiGpvsTMngw
 b7dfU4asdQRCt4ntBaYANjMRf9vP+OsEfZsYa8P9uJn8L3NBTCSTZcVUXfDShO5GA2pr
 M0bg==
X-Gm-Message-State: AOJu0Yyfj+3P7iAbXa5mM4GFAkmlfZPTDsR/hAI21X4FLIXst4HLJToC
 v1WqzC/c/yvGaJHFPGc9NS4sAfP1NEKYPU7Tpe1sUAXPHgR3r7x8SmSepSn6ROhBwYd5k8Kwy4V
 kj152G9uxWF4Z5cd67KiegqgMxOf1IdA=
X-Received: by 2002:a81:a045:0:b0:5d7:1940:dd6b with SMTP id
 x66-20020a81a045000000b005d71940dd6bmr2814053ywg.65.1702293735812; 
 Mon, 11 Dec 2023 03:22:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrVu4V32RwThlYboqUtI8NzK6isFJ0h8otn7N2vb2SYCnIwY/sKMeV8y8w5dDcrHwAf62mt2MtTwuvjqmqUCA=
X-Received: by 2002:a81:a045:0:b0:5d7:1940:dd6b with SMTP id
 x66-20020a81a045000000b005d71940dd6bmr2814048ywg.65.1702293735608; Mon, 11
 Dec 2023 03:22:15 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-10-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-10-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Dec 2023 12:21:39 +0100
Message-ID: <CAJaqyWcQQdp5C_nQNLhVd5x=2HnqOLCownEHBEP8Y6q4z8CANw@mail.gmail.com>
Subject: Re: [PATCH 09/40] vdpa: no repeat setting shadow_data
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
> Since shadow_data is now shared in the parent data struct, it
> just needs to be set only once by the first vq. This change
> will make shadow_data independent of svq enabled state, which
> can be optionally turned off when SVQ descritors and device

descri *p* tors typo.

> driver areas are all isolated to a separate address space.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Can you send this separately so we make this series smaller?

Apart from the typo,

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>  net/vhost-vdpa.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index c9bfc6f..2555897 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -387,13 +387,12 @@ static int vhost_vdpa_net_data_start(NetClientState=
 *nc)
>      if (s->always_svq ||
>          migration_is_setup_or_active(migrate_get_current()->state)) {
>          v->shadow_vqs_enabled =3D true;
> -        v->shared->shadow_data =3D true;
>      } else {
>          v->shadow_vqs_enabled =3D false;
> -        v->shared->shadow_data =3D false;
>      }
>
>      if (v->index =3D=3D 0) {
> +        v->shared->shadow_data =3D v->shadow_vqs_enabled;
>          vhost_vdpa_net_data_start_first(s);
>          return 0;
>      }
> --
> 1.8.3.1
>



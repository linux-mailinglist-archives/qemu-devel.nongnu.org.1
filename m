Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6D282A86E
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 08:35:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNpae-0001KI-Rv; Thu, 11 Jan 2024 02:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNpad-0001K4-GD
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:34:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNpaa-00057D-Bo
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704958495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLb7n/f2lhQ8b30j/DJ3u406BTIfXkE5aYBRkAzykuU=;
 b=LFiLkjtwQpIPUHR3BAf8+o8t6m6ji7FKZ0Soc0P7XJKjcenHPClmxBNcYMXb1X7avEOgPi
 N4u6H+wwHesG5Yjf7PUAExygIXFbUDYquU0Z5Ap91RAZAM4p4CO+T7vWm+nZgzcxpMVGpY
 G+OObXHbpYstzuf05Hg5Z6+U07iJGDk=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-kzXxHzujNg2hfSSFnXZ0FA-1; Thu, 11 Jan 2024 02:34:51 -0500
X-MC-Unique: kzXxHzujNg2hfSSFnXZ0FA-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3bd38dc3e33so4167189b6e.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 23:34:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704958491; x=1705563291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HLb7n/f2lhQ8b30j/DJ3u406BTIfXkE5aYBRkAzykuU=;
 b=qv1/cVNKzXpL4+DOz0bcIbxCAx/iq+N3BBQ/TsHXOUvQJ+CpPe77jVuKidFYEpP1h1
 b+2b5A5ZjK3haVuViC8BFHOglKKP+BN3raEAkm+aNbkpLOUiRtm5DxWjKiPzqxdpa5um
 GqhkB0Jg6r17Bwzsx6KY7lPIn4TYHowuRNkbifcuOqfHjzvgIqj+yBUeW5RGFOw89m1G
 v6Ps289Css0B2X5z+Xn7QS4aylMIjDMVWEzyqaNASUPgJPzMq+1vzdbp8omZVyEOwQBY
 WuAPJSS0p3lqI6QrOVqN833WxIWPjq3i2eWzJkgxzTh2gX23bzBin77B7/jvBPfUDUfm
 PSIA==
X-Gm-Message-State: AOJu0YyO1xOjOd+PTmvI78RRET1IhGmCbFN5fkhr7VkaQPGddWNbiaJk
 AE796TLnkz6U4cCb29QIZCkEUfWMdsECd8bthMYhgpDB05+9lQQk0ngnI3S37s65dbdFwhm05Q3
 0FE1bVU5yQGb/R2eWshGhZ+BdndJ8MFz3veCam94=
X-Received: by 2002:a05:6808:3093:b0:3bd:2101:90e7 with SMTP id
 bl19-20020a056808309300b003bd210190e7mr785938oib.25.1704958491078; 
 Wed, 10 Jan 2024 23:34:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNatSbWitfEb0j0zc9FEUg3GyaPkBA5x9bc0Q9RDxj76J5/LYB0GJlzN51cX7vkw2I7P/mwTTROMNyS+8lD+k=
X-Received: by 2002:a05:6808:3093:b0:3bd:2101:90e7 with SMTP id
 bl19-20020a056808309300b003bd210190e7mr785928oib.25.1704958490899; Wed, 10
 Jan 2024 23:34:50 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-10-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-10-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 15:34:39 +0800
Message-ID: <CACGkMEsSz4+AAKfOBxMM8vLOjemPfsX-KNDzpK3hji2_hKa1Sg@mail.gmail.com>
Subject: Re: [PATCH 09/40] vdpa: no repeat setting shadow_data
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Dec 8, 2023 at 2:50=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Since shadow_data is now shared in the parent data struct, it
> just needs to be set only once by the first vq. This change
> will make shadow_data independent of svq enabled state, which
> can be optionally turned off when SVQ descritors and device

Typo for descriptors.

> driver areas are all isolated to a separate address space.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

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



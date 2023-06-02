Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EA472085B
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 19:28:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q58Z5-0007B8-PY; Fri, 02 Jun 2023 13:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1q58Z2-0007Ao-4M
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:27:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1q58Z0-0000IT-5l
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685726865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZTtGCticPm+ZTg6KnPDRYI9Ghg1D32643S+GL972ns=;
 b=GzEgdTSJEg19hkmeBw1Z5NyHvypyNzmRH4wKamngQ5F5CFDcsKPk/c1P3sbv6jdbjb2uZK
 M7se14b6MijX5QnKgW7NvdL1SZmkzWHyntpJjcbRVXEtDgVP7x/T9YtfBR5Qk8wDfCXuTV
 ZJrnavTgaYkKRngrlCc6l7Dgs85aYXg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-lYxL-8cAOaOo2hZwkqY8qQ-1; Fri, 02 Jun 2023 13:27:43 -0400
X-MC-Unique: lYxL-8cAOaOo2hZwkqY8qQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4ec790b902bso1819424e87.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 10:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685726862; x=1688318862;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZTtGCticPm+ZTg6KnPDRYI9Ghg1D32643S+GL972ns=;
 b=Md9NTWWFGdSBd3bFfNH7ij3YtTsTbwhMKQZ8uB9t+MWLp6+F3YLAayJVABE5ZxBJCm
 /0nvhMZQjq6yH6sxmcNetRCoL6Fs/Zte5F7zkFxMO2mWhMtnREQpIdxtBXWiJnWjyswf
 1l8ML06L9tGIApU3+z1ECjY53xnPkGQHeYmAJfWZal9gOQoP4aycJKd25rnZLcgofGYU
 UNlgDcnIBeS8chz/N0+l6vo/7ei6IRP8DOOiHsUMqcao6Pxdpu8T7M4og4OFAY1P6joS
 AcilC9QTVihIhSVFs9j5PtSy+UvVNshL2nJ7MeINih+J8zu2Spsb+W2izzJtZmAEqG6/
 wXtw==
X-Gm-Message-State: AC+VfDyQhZnuniZjSJWbT91Gdk5O3k3qeeTNqwNm9p1/Z2OrKI0ijN5M
 hkyVUBakA1qTH6nvnAeDhv79Ay+ReO3Kq5cKdO8PCpq880GmJD50IEG0wf2r1KbeaKwfgEGE2NT
 pXtcSoEfwR4XdNp+/OCIsnh1D0uIRg1s=
X-Received: by 2002:ac2:4193:0:b0:4e8:5e39:6234 with SMTP id
 z19-20020ac24193000000b004e85e396234mr1980815lfh.16.1685726862446; 
 Fri, 02 Jun 2023 10:27:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6IOPIqg26JAPBJ/oSs5CKBJuFRrJjNw5AXK6l2xFt3FKaNAxMtcFfpMPR3V48ZcImJsL1iCSEFE9tGcUDcB0E=
X-Received: by 2002:ac2:4193:0:b0:4e8:5e39:6234 with SMTP id
 z19-20020ac24193000000b004e85e396234mr1980804lfh.16.1685726862146; Fri, 02
 Jun 2023 10:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230602143854.1879091-1-eperezma@redhat.com>
 <20230602143854.1879091-2-eperezma@redhat.com>
In-Reply-To: <20230602143854.1879091-2-eperezma@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Sat, 3 Jun 2023 01:27:05 +0800
Message-ID: <CAPpAL=wCTA+4TjONY88a4QNhJhRoezVuMwiwS+r0_6BpLfRxJg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] vdpa: do not block migration if device has cvq and
 x-svq=on
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
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

QE tested this series with vhost_vdpa and x-svq=3Don, guest can migrate
and everything works well.

Tested-by: Lei Yang <leiyang@redhat.com>

On Fri, Jun 2, 2023 at 10:39=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> It was a mistake to forbid in all cases, as SVQ is already able to send
> all the CVQ messages before start forwarding data vqs.  It actually
> caused a regression, making impossible to migrate device previously
> migratable.
>
> Fixes: 36e4647247f2 ("vdpa: add vhost_vdpa_net_valid_svq_features")
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  net/vhost-vdpa.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 37cdc84562..c63456ff7c 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -837,13 +837,16 @@ static NetClientState *net_vhost_vdpa_init(NetClien=
tState *peer,
>          s->vhost_vdpa.shadow_vq_ops_opaque =3D s;
>
>          /*
> -         * TODO: We cannot migrate devices with CVQ as there is no way t=
o set
> -         * the device state (MAC, MQ, etc) before starting the datapath.
> +         * TODO: We cannot migrate devices with CVQ and no x-svq enabled=
 as
> +         * there is no way to set the device state (MAC, MQ, etc) before
> +         * starting the datapath.
>           *
>           * Migration blocker ownership now belongs to s->vhost_vdpa.
>           */
> -        error_setg(&s->vhost_vdpa.migration_blocker,
> -                   "net vdpa cannot migrate with CVQ feature");
> +        if (!svq) {
> +            error_setg(&s->vhost_vdpa.migration_blocker,
> +                       "net vdpa cannot migrate with CVQ feature");
> +        }
>      }
>      ret =3D vhost_vdpa_add(nc, (void *)&s->vhost_vdpa, queue_pair_index,=
 nvqs);
>      if (ret) {
> --
> 2.31.1
>



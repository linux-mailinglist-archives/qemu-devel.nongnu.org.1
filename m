Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1BE7A157A
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 07:32:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh1Q0-0000Rn-Gi; Fri, 15 Sep 2023 01:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qh1Pu-0000RA-L6
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 01:31:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qh1Pn-0003GF-OC
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 01:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694755845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wM6d6/2w7EhB0FFchjxYZVeo9hU6deaT7Xe6W8TWeSs=;
 b=caNpENZ1ERUk1kPd38zpr13hiSSO2jcY1eHV1kVTPDEyHUzR0+xtEHR789Irp5Py/lFJUl
 YMXM16PReVouxBVqfQccZbKceF/U2CTG4W18tg/7ulyRwgGcmyGF8qxBYH3aTX7WvJhRyB
 CurW2p/gzZvUDngZo4ki8rdXKJYsb98=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-eMeZrccPOMerTTnpWqJfMg-1; Fri, 15 Sep 2023 01:30:44 -0400
X-MC-Unique: eMeZrccPOMerTTnpWqJfMg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-502d58d14beso170899e87.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 22:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694755842; x=1695360642;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wM6d6/2w7EhB0FFchjxYZVeo9hU6deaT7Xe6W8TWeSs=;
 b=EGKUB40skSdKt2BGBUknpvamKqLZ3y55aDc9EbqvCKrN9frp0MYCzrnAavmLhnA+LA
 1kmc2shHWosCObgX9oVZUPnbvGMWCPpYqKlc38t30gzZEOIIy7e9I/PlLQxUtf3a0/p4
 R7JgtgobuVSFi9Jx/VUuDjQJMY3W+ARUnYqvTzt57d6SZrGIYQDaWW3MVpdVr4/XtiGK
 PNCHaQqfGByd9LsUf2HPkiUmPoUkJA0BDyYvM3t5nJsoAtWqIvm8BUfAbZChcFFMmK/B
 6ZzNsIMfWZhDxrx49xZhTbvy4JMJMSFSFSRad3gdDQbFOSmllj5vccYytmMy89XwldSI
 2BDA==
X-Gm-Message-State: AOJu0YwyCxKsFxMnMt4bx95zN5NfdGIy9uzhWT9ZBSaODsGT5d4WtrBy
 AN5mXCvzDPLc1Q8qI07akYdZ9zk2UlCRag0iPX9ncQ2fLf6On6A2wtUVrfHtGN1hi8adYuAtWkR
 eIpDSwmYz73ohsfsiFJg5WkSTSVtkCjCdgYtSMz5flQ==
X-Received: by 2002:a19:790f:0:b0:500:7685:83d with SMTP id
 u15-20020a19790f000000b005007685083dmr432378lfc.48.1694755842485; 
 Thu, 14 Sep 2023 22:30:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7TUjgNN4CXFs2v89yb7sZebh1IazZnZsBdGvHXNUX6Je8alrgYIX86p5d9wAAp/vnEKOudgc69N7Qo4ZDPos=
X-Received: by 2002:a19:790f:0:b0:500:7685:83d with SMTP id
 u15-20020a19790f000000b005007685083dmr432369lfc.48.1694755842164; Thu, 14 Sep
 2023 22:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230911215435.4156314-1-stefanha@redhat.com>
In-Reply-To: <20230911215435.4156314-1-stefanha@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Sep 2023 13:30:31 +0800
Message-ID: <CACGkMEv1zui3mnQDXF3BLWqVCz3mtdSyS4jjKdO8ZABXTTD1gg@mail.gmail.com>
Subject: Re: [PATCH] vdpa: fix gcc cvq_isolated uninitialized variable warning
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Tue, Sep 12, 2023 at 5:54=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> gcc 13.2.1 emits the following warning:
>
>   net/vhost-vdpa.c: In function =E2=80=98net_vhost_vdpa_init.constprop=E2=
=80=99:
>   net/vhost-vdpa.c:1394:25: error: =E2=80=98cvq_isolated=E2=80=99 may be =
used uninitialized [-Werror=3Dmaybe-uninitialized]
>    1394 |         s->cvq_isolated =3D cvq_isolated;
>         |         ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
>   net/vhost-vdpa.c:1355:9: note: =E2=80=98cvq_isolated=E2=80=99 was decla=
red here
>    1355 |     int cvq_isolated;
>         |         ^~~~~~~~~~~~
>   cc1: all warnings being treated as errors
>
> Cc: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  net/vhost-vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 34202ca009..7eaee841aa 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1352,7 +1352,7 @@ static NetClientState *net_vhost_vdpa_init(NetClien=
tState *peer,
>      VhostVDPAState *s;
>      int ret =3D 0;
>      assert(name);
> -    int cvq_isolated;
> +    int cvq_isolated =3D 0;
>
>      if (is_datapath) {
>          nc =3D qemu_new_net_client(&net_vhost_vdpa_info, peer, device,
> --
> 2.41.0
>



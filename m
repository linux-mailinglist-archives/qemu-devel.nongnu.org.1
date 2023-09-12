Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DA279C729
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 08:48:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxB8-0006HG-JN; Tue, 12 Sep 2023 02:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qfxB4-0006Gn-84
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:47:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qfxB1-0002Tp-9K
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694501228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BMHwko3lYsRXN/xSkHJphN3ui+b/D8QAzAHNRNa47vQ=;
 b=GS/egNxno13pQFQzLIJ/7X9kCwutE1C+epnX2IkBGTjZBDP4onZthgbD1AaC4gkVw/y/GL
 7EjbLQrxuOoVRx4pXFNhSJB84fJWrxHU3rfwN+3su9OyA3kkpqCKfpiAD3UHxdlr+kXR4b
 yZw9OoWl/xTwvwD3g4Aydy+22Kb1jqs=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-XYP5SDu3M9eiiPBmw3zH7A-1; Tue, 12 Sep 2023 02:47:06 -0400
X-MC-Unique: XYP5SDu3M9eiiPBmw3zH7A-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-44d4bd0bd67so1996341137.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 23:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694501226; x=1695106026;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMHwko3lYsRXN/xSkHJphN3ui+b/D8QAzAHNRNa47vQ=;
 b=QDwRthXuJ7hAHl2/DJD8dEWVsyrhD7DzsznYIkCYzM/tX1rYFacsyIr5SOtTJxBCk2
 2kldW8OC2+Z8QpI/n3eM1RCoiC6hyuBprBrW8z5MvubEPahcZTTgD2g493VgSCEcrDsO
 fqajeCth29/+LjIJTcble3NZR3nfzI5kPC+G4cnHmxm6DR13MCAC0SJ8xh2IXFzpan4r
 aijLmEAYJGfV3rdG+tX71ne51ulWk0SknG9F6Ovk1P9Oxe3kRo6+p2qdC35acfJfqq0M
 /5XGKQbiYg39PchtJeRA5N1+LVuTzk2ClhTn/4desm303Rndwll0YZ6Nu7dfl7/rvbRd
 YZ+A==
X-Gm-Message-State: AOJu0Yw5z6FLzB6wEwNK8dQp9VTDNPGWmQIJvXUWmC1xGiCZlt9DSJq/
 AJtbunO5NYze3oViVYN5QW6ZudXiz9v/mYo/Bb9oPv800eYKx4Y1kWhETXY1wid4yKAIyjbVXvE
 VCjWU300eORdpXOGyRjMJI/xrQTDMH3k=
X-Received: by 2002:a67:ed96:0:b0:44d:4b34:af92 with SMTP id
 d22-20020a67ed96000000b0044d4b34af92mr10655794vsp.7.1694501226361; 
 Mon, 11 Sep 2023 23:47:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnBjmTEeIT3UHORH1bntoTYW6CFCxxQLzCR9NLMs1vqojrjY+xQMuuVVy2WGkhrvbtietpd0nj7KJlld6Jygc=
X-Received: by 2002:a67:ed96:0:b0:44d:4b34:af92 with SMTP id
 d22-20020a67ed96000000b0044d4b34af92mr10655788vsp.7.1694501226116; Mon, 11
 Sep 2023 23:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230911215435.4156314-1-stefanha@redhat.com>
In-Reply-To: <20230911215435.4156314-1-stefanha@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 12 Sep 2023 08:46:30 +0200
Message-ID: <CAJaqyWcSuiHHv-m2xDLYediKTPDLT7C4RvaWXcPZfxTjWHWp=Q@mail.gmail.com>
Subject: Re: [PATCH] vdpa: fix gcc cvq_isolated uninitialized variable warning
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Mon, Sep 11, 2023 at 11:54=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
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

I think GCC is evaluating the case where (queue_pair_index =3D=3D 0 &&
!is_datapath), which should be not possible.

If it is useful we can refactor the conditionals so we don't need the
variable at that level of the function. If not,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Cc: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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



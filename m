Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 953A67A0220
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 13:05:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgk9F-0006is-Od; Thu, 14 Sep 2023 07:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1qgk9D-0006i0-Dc
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:04:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1qgk9B-00047d-Nl
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694689472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1k7KPHKhKbE4fWRZNs6aS9/8IZ4QSwjwUAXaChRhjU=;
 b=E5so1R2Nn+VP8Wkt1hhIKkA5RmgLUx+b0TIy0j1MI3V7jI1HO1ylmaRto0Hc7nNquNoKEz
 x8Kv8E3HKveWpaQiDgt81AJtjKPKbaD7lEH55hxThaWZ+WtvyVStwoPkrrmavusHPd2Bj3
 bdm2UpexifVd1jWFn2HncTUW1RtN4Ek=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-LJe5bw6hMKmFrgiwIZOugQ-1; Thu, 14 Sep 2023 07:04:30 -0400
X-MC-Unique: LJe5bw6hMKmFrgiwIZOugQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-52e25bc2629so584037a12.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 04:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694689470; x=1695294270;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K1k7KPHKhKbE4fWRZNs6aS9/8IZ4QSwjwUAXaChRhjU=;
 b=R2o4lUpSH3yVdpWWyjwFdnzbWjKUEfdS2AmifeC0PpBQXoPRr3wYIN7HmeNuFhvavZ
 VIi87OZu8Wk8iA2b5OKZuCUjExnivRjDq2evtKKxb3oLjhgAEf1pfrVbOCRSL/d4VstM
 hFFvUZcw8dwEOEa0qccRqGL3nN4hZnFb/qcUHUhkw5pdiSLCTMCvFJwHV0a3q+hw9Cay
 zEOgfJElckaYTvLhc5LVWMPCcvCpcxVM8VXQlDmvJL7PAz+B4yJ4vA2wmS2D6d3UOIFW
 ZRmA83rEBXR9yOtsJcRQqthWR/4ut6Yysu49bScMZ57ZTdgGDBd3fuHPU0SjP69V4ptR
 smQA==
X-Gm-Message-State: AOJu0YxaJ1hRKID98+BnUI5NW6hRBpGU5DXE9STa9s7mTF90NJzb9UrK
 MwR7uNMY/tGoutAtr+Q6aR5rlD7JoC97/qSPGmr4S5z/BNuDVbMxtO3wHxtE4tRxRW19A+mX6bu
 fAUjBVyqXKmR62L0NRmay4PcaUlw0EOY=
X-Received: by 2002:a05:6402:b0e:b0:527:237d:3765 with SMTP id
 bm14-20020a0564020b0e00b00527237d3765mr4584071edb.26.1694689469877; 
 Thu, 14 Sep 2023 04:04:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgPVe9zh7Nkdc1OCeTiUWfmGe5pRAlgR+e/qcL8rPmgKECWNf3mF8HuYzvWp+BGFgc1FpcMyWFFU03cN9dlJI=
X-Received: by 2002:a05:6402:b0e:b0:527:237d:3765 with SMTP id
 bm14-20020a0564020b0e00b00527237d3765mr4584051edb.26.1694689469573; Thu, 14
 Sep 2023 04:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230913123408.2819185-1-eperezma@redhat.com>
 <CACGkMEur1FEqDiH9ZY7hfds6eVeQFqMhyDdgFzU-O+nf2JqR5Q@mail.gmail.com>
In-Reply-To: <CACGkMEur1FEqDiH9ZY7hfds6eVeQFqMhyDdgFzU-O+nf2JqR5Q@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 14 Sep 2023 19:03:53 +0800
Message-ID: <CAPpAL=wygd4fzb9AVNv6WBe7H4t5MQsE3kg4Fpo7VMG1ptLmNA@mail.gmail.com>
Subject: Re: [PATCH] vdpa net: zero vhost_vdpa iova_tree pointer at cleanup
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Shannon Nelson <snelson@pensando.io>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 yama@redhat.com, 
 Hawkins Jiawei <yin31149@gmail.com>, Cindy Lu <lulu@redhat.com>,
 qemu-stable@nongnu.org, 
 Dragos Tatulea <dtatulea@nvidia.com>, si-wei.liu@oracle.com, 
 Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
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

QE tested this patch with real nic,guest can works well after
cancelling migration.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Sep 14, 2023 at 11:23=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Wed, Sep 13, 2023 at 8:34=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > Not zeroing it causes a SIGSEGV if the live migration is cancelled, at
> > net device restart.
> >
> > This is caused because CVQ tries to reuse the iova_tree that is present
> > in the first vhost_vdpa device at the end of vhost_vdpa_net_cvq_start.
> > As a consequence, it tries to access an iova_tree that has been already
> > free.
> >
> > Fixes: 00ef422e9fbf ("vdpa net: move iova tree creation from init to st=
art")
> > Reported-by: Yanhui Ma <yama@redhat.com>
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>
> > ---
> >  net/vhost-vdpa.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > index 34202ca009..1714ff4b11 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -385,6 +385,8 @@ static void vhost_vdpa_net_client_stop(NetClientSta=
te *nc)
> >      dev =3D s->vhost_vdpa.dev;
> >      if (dev->vq_index + dev->nvqs =3D=3D dev->vq_index_end) {
> >          g_clear_pointer(&s->vhost_vdpa.iova_tree, vhost_iova_tree_dele=
te);
> > +    } else {
> > +        s->vhost_vdpa.iova_tree =3D NULL;
> >      }
> >  }
> >
> > --
> > 2.39.3
> >
>



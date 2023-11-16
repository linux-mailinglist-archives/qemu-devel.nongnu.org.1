Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC147EDB19
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 06:16:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3UiX-0005Pg-E7; Thu, 16 Nov 2023 00:15:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1r3UiU-0005PR-Ff
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 00:15:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1r3UiR-0003pv-VR
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 00:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700111698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tE3DLiEmW5lUAPg6nJe2o+87QkuUkwqDjoW9DeIzaxs=;
 b=GkHntw0ckeqiZIxVD9Am59r89rE4IESUENM+bwuXyDxz8galxXd9+j50IrsX2e0LSHuyqu
 KRNhyzM7YpnA6NcSalNuHBImMWoHtlNdYqLFct1WnIMTWDUAvo8OvZzimirxuEu5Xs3p/z
 rE8gZ3UWOKsGEYK22WMbpa0d8tKoWOU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-tA7Q0scINWu6Kftu2ZuMTw-1; Thu, 16 Nov 2023 00:14:56 -0500
X-MC-Unique: tA7Q0scINWu6Kftu2ZuMTw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-507d0e4eedaso333636e87.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 21:14:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700111694; x=1700716494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tE3DLiEmW5lUAPg6nJe2o+87QkuUkwqDjoW9DeIzaxs=;
 b=lWABXOD/lcflUBQMAr6E+QkzsLbJpr3KoAkT9dmidN+tWHAtsQ6FumFlcQlPqgLeQ8
 UGU7YJv3ec/Ww+m5cRjKJCIWiVyE9AsohVkX+rvUt9rtWMlfp7G9t0niiYBn/1+PQEav
 7Xw5V1vi8EgubNC37OBlzFr42Uw0ldzsspPxDNbys36n5vKVZjl6qbtO56ejuAIA9Qtf
 Sgiw3rJki8FdWPxRuHneLKCuMLWJ1zco9AEgHaUg+qrL8NM1ShrBtsB4H4JUuorVSe6n
 MhXBPuJPcMAxrlinyDMKs1USQzvstKsUVv5qmmxXx0TkPI3LfjCyld6hA59+gOs4U2iq
 fPzQ==
X-Gm-Message-State: AOJu0Ywm9ukIBommr5lscLvmpJ/wFbUMKFjFodGBQz6QNX7LoQXp5y0W
 n7hyvDRXq2AwG2hvJZueh9jdLEAeGTARksp0eDXVP0FuSrTMb5y6kRNU5zHr2sCMfjNRX+jnRyU
 bMO/U4AqdjDw0nFChQFmZN9OJLqGRj3E=
X-Received: by 2002:a05:6512:36d0:b0:505:6ede:20a9 with SMTP id
 e16-20020a05651236d000b005056ede20a9mr9085377lfs.65.1700111694675; 
 Wed, 15 Nov 2023 21:14:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5RoRWSdIa2n2fLHlxfxca7Dh7jZVLN4prk8iDYkeoW3FawG4yq/PsIyE3m4xG9BbOKXdBbbPilpOasSmtNXQ=
X-Received: by 2002:a05:6512:36d0:b0:505:6ede:20a9 with SMTP id
 e16-20020a05651236d000b005056ede20a9mr9085368lfs.65.1700111694294; Wed, 15
 Nov 2023 21:14:54 -0800 (PST)
MIME-Version: 1.0
References: <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
 <39a02a4c-f8fa-437c-892f-caca84b8d85d@daynix.com>
 <20231101050838-mutt-send-email-mst@kernel.org>
 <e469b33b-c3f3-4d88-bdf2-508c4a35c827@daynix.com>
 <CAOEp5OcDMdKKPHSVd-GxT-GkBpvbWkMijSBgwihPsEnxmDR7eA@mail.gmail.com>
 <20231102053202-mutt-send-email-mst@kernel.org>
 <CAOEp5OefD2LN2MDnEkE=DOMSX0Jw8Z6gAiKAag4dtkecmr1Jgg@mail.gmail.com>
 <2fbdee21-60f4-49ff-b61b-923c895f90ba@daynix.com>
 <CAOEp5Oc+wGmxTAezMz4f03kuqsngHAcpi7pqPQDT=PWuy=L7BA@mail.gmail.com>
 <dbd1d662-bf90-4982-b316-281923a0d778@daynix.com>
 <CAOEp5Oc5VzWk7e8gKHfHan1odge39bRUh-ZMojCvkQiTFpXdGg@mail.gmail.com>
 <8439be4e-a739-4cbd-a569-89b6c7f68ab9@daynix.com>
 <CAOEp5Oee2qinrZJgMMxUQt6zmPVFPCnThfqnLFSWqsSyAoHpjQ@mail.gmail.com>
 <3c8af942-ca7d-4528-975e-2935718a2428@daynix.com>
 <CAOEp5OfXH-1ygYMJxq1phwbOJkkvnwBce=TDVLwjsXG6UgwPGA@mail.gmail.com>
 <637b0f33-6b12-4623-b504-d3ea64908813@daynix.com>
 <CAOEp5Oc3mb=v-F3Xfx-ypzojq7hLeoPmxu53WA9_4mTx1j50BA@mail.gmail.com>
 <036085f8-7837-4842-bd8b-6c2b4ec560e0@daynix.com>
In-Reply-To: <036085f8-7837-4842-bd8b-6c2b4ec560e0@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 Nov 2023 13:14:43 +0800
Message-ID: <CACGkMEvO7PGhSOiwM=p=DKtTpvLWATHmUurAPpY6=skse0eMvg@mail.gmail.com>
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Nov 15, 2023 at 2:09=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
>
>
> On 2023/11/15 7:09, Yuri Benditovich wrote:
> >
> >
> > On Tue, Nov 14, 2023 at 9:03=E2=80=AFAM Akihiko Odaki <akihiko.odaki@da=
ynix.com
> > <mailto:akihiko.odaki@daynix.com>> wrote:
> >
> >     On 2023/11/14 2:26, Yuri Benditovich wrote:
> >      >
> >      >
> >      > On Mon, Nov 13, 2023 at 2:44=E2=80=AFPM Akihiko Odaki
> >     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
> >      > <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>> wrote:
> >      >
> >      >     On 2023/11/13 20:44, Yuri Benditovich wrote:
> >      >      >
> >      >      >
> >      >      > On Sat, Nov 11, 2023 at 5:28=E2=80=AFPM Akihiko Odaki
> >      >     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
> >     <mailto:akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>>
> >      >      > <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>
> >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>>> wrote:
> >      >      >
> >      >      >     On 2023/11/03 22:14, Yuri Benditovich wrote:
> >      >      >      >
> >      >      >      >
> >      >      >      > On Fri, Nov 3, 2023 at 11:55=E2=80=AFAM Akihiko Od=
aki
> >      >      >     <akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com> <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>
> >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com> <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>>
> >      >      >      > <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>
> >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>
> >      >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>
> >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>>>> wrote:
> >      >      >      >
> >      >      >      >     On 2023/11/03 18:35, Yuri Benditovich wrote:
> >      >      >      >      >
> >      >      >      >      >
> >      >      >      >      > On Thu, Nov 2, 2023 at 4:56=E2=80=AFPM Akih=
iko Odaki
> >      >      >      >     <akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>
> >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>> <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>
> >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>>
> >      >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>
> >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>> <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>
> >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>>>
> >      >      >      >      > <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>
> >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>
> >      >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>
> >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>>
> >      >      >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>
> >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>
> >      >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>
> >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>>>>> wrote:
> >      >      >      >      >
> >      >      >      >      >     On 2023/11/02 19:20, Yuri Benditovich w=
rote:
> >      >      >      >      >      >
> >      >      >      >      >      >
> >      >      >      >      >      > On Thu, Nov 2, 2023 at 11:33=E2=80=
=AFAM
> >     Michael S.
> >      >     Tsirkin
> >      >      >      >      >     <mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
> >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>
> >      >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
> >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>>
> >      >      >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
> >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>
> >      >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
> >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>>>
> >      >      >      >      >      > <mailto:mst@redhat.com
> >     <mailto:mst@redhat.com>
> >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>
> >      >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
> >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>>
> >      >      >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
> >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>
> >      >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
> >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>>>>> wrote:
> >      >      >      >      >      >
> >      >      >      >      >      >     On Thu, Nov 02, 2023 at 11:09:27=
AM
> >      >     +0200, Yuri
> >      >      >      >     Benditovich wrote:
> >      >      >      >      >      >      > Probably we mix two different
> >     patches
> >      >     in this
> >      >      >      >     discussion.
> >      >      >      >      >      >      > Focusing on the patch in the
> >     e-mail
> >      >     header:
> >      >      >      >      >      >      >
> >      >      >      >      >      >      > IMO it is not acceptable to
> >     fail QEMU run
> >      >      >     for one
> >      >      >      >     feature
> >      >      >      >      >     that we
> >      >      >      >      >      >     can't make
> >      >      >      >      >      >      > active when we silently drop
> >     all other
> >      >      >     features in
> >      >      >      >     such a
> >      >      >      >      >     case.
> >      >      >      >      >      >
> >      >      >      >      >      >     If the feature is off by default
> >     then it
> >      >     seems more
> >      >      >      >     reasonable
> >      >      >      >      >      >     and silent masking can be seen a=
s
> >     a bug.
> >      >      >      >      >      >     Most virtio features are on by
> >     default
> >      >     this is
> >      >      >     why it's
> >      >      >      >      >      >     reasonable to mask them.
> >      >      >      >      >      >
> >      >      >      >      >      >
> >      >      >      >      >      > If we are talking about RSS: setting=
 it
> >      >     initially
> >      >      >     off is the
> >      >      >      >      >     development
> >      >      >      >      >      > time decision.
> >      >      >      >      >      > When it will be completely stable
> >     there is
> >      >     no reason to
> >      >      >      >     keep it
> >      >      >      >      >     off by
> >      >      >      >      >      > default, so this is more a question
> >     of time
> >      >     and of a
> >      >      >      >     readiness of
> >      >      >      >      >     libvirt.
> >      >      >      >      >
> >      >      >      >      >     It is not ok to make "on" the default;
> >     that will
> >      >      >     enable RSS
> >      >      >      >     even when
> >      >      >      >      >     eBPF steering support is not present an=
d can
> >      >     result in
> >      >      >      >     performance
> >      >      >      >      >     degradation.
> >      >      >      >      >
> >      >      >      >      >
> >      >      >      >      > Exactly as it is today - with vhost=3Don th=
e host
> >      >     does not
> >      >      >     suggest RSS
> >      >      >      >      > without  eBPF.
> >      >      >      >      > I do not understand what you call "performa=
nce
> >      >      >     degradation", can you
> >      >      >      >      > describe the scenario?
> >      >      >      >
> >      >      >      >     I was not clear, but I was talking about the
> >     case of
> >      >      >     vhost=3Doff or peers
> >      >      >      >     other than tap (e.g., user). rss=3Don employs
> >     in-qemu RSS,
> >      >      >     which incurs
> >      >      >      >     overheads for such configurations.
> >      >      >      >
> >      >      >      >
> >      >      >      > So, vhost=3Doff OR peers other than tap:
> >      >      >      >
> >      >      >      > In the case of peers other than tap (IMO) we're no=
t
> >      >     talking about
> >      >      >      > performance at all.
> >      >      >      > Backends like "user" (without vnet_hdr) do not
> >     support _many_
> >      >      >      > performance-oriented features.
> >      >      >      > If RSS is somehow "supported" for such backends th=
is is
> >      >     rather a
> >      >      >      > misunderstanding (IMO again).
> >      >      >
> >      >      >     We do not need to ensure good performance when RSS is
> >     enabled
> >      >     by the
> >      >      >     guest for backends without eBPF steering program as
> >     you say.
> >      >     In-QEMU
> >      >      >     RSS
> >      >      >     is only useful for testing and not meant to improve t=
he
> >      >     performance.
> >      >      >
> >      >      >     However, if you set rss=3Don, QEMU will advertise the
> >      >     availability of RSS
> >      >      >     feature. The guest will have no mean to know if it's
> >      >     implemented in a
> >      >      >     way not performance-wise so it may decide to use the
> >     feature
> >      >     to improve
> >      >      >     the performance, which can result in performance
> >     degradation.
> >      >      >     Therefore,
> >      >      >     it's better not to set rss=3Don for such backends.
> >      >      >
> >      >      >
> >      >      > I still do not understand what is the scenario where you
> >     see or
> >      >     suspect
> >      >      > the mentioned "performance degradation".
> >      >      > We can discuss whether such a problem exists as soon as y=
ou
> >      >     explain it.
> >      >
> >      >     The scenario is that:
> >      >     - rss=3Don,
> >      >     - A backend without eBPF steering support is in use, and
> >      >     - The guest expects VIRTIO_NET_F_RSS has little overheads as
> >     hardware
> >      >     RSS implementations do.
> >      >
> >      >     I consider the risk of the performance degradation in such a
> >     situation
> >      >     is the reason why virtio-net emits a warning ("Can't load
> >     eBPF RSS -
> >      >     fallback to software RSS") when in-QEMU RSS is in use.
> >      >
> >      >
> >      > In a described scenario (vhost=3Doff) I do not see why the perfo=
rmance
> >      > degradation should happen:
> >      > the SW RSS (if activated) will place each packet into proper
> >     queue (even
> >      > if the auto_mq in kernel is not able to do that) and such a way =
the
> >      > guest will not need to reschedule the packet to proper CPU
> >      >
> >
> >     The scenario I'm concerned is that the guest has its own packet
> >     steering
> >     mechanism which is feature-wise superior to RSS. For example, Linux=
 has
> >     such a mechanism called RPS, which has some advantages due to its
> >     extensible nature according to:
> >     https://www.kernel.org/doc/html/v6.6/networking/scaling.html#rps-re=
ceive-packet-steering <https://www.kernel.org/doc/html/v6.6/networking/scal=
ing.html#rps-receive-packet-steering>
> >
> >     Such a guest may still prefer hardware RSS if available since hardw=
are
> >     RSS is expected to have less overheads. However, it is not true for
> >     in-qemu RSS, and using in-QEMU RSS instead of the guest-side steeri=
ng
> >     mechanism may just hide useful features the guest-side steering
> >     mechanism has and result in performance degradation.
> >
> >
> > Note that in terms of per-packet computation for RSS the in-QEMU RSS
> > does exactly the same operations in native code that the eBPF does in
> > the emulation.
> > So, I wouldn't say that SW RSS brings some "performance degradation".
> > We prefer eBPF as it can serve both vhost and non-vhost setups.
>
> I see the eBPF steering program in a different way.
>
> tuntap can have several queues,

Note that RSS can benefit for single queue as well.

> and the assignment of packets is
> automatically done by tuntap by default. However, the default assignment
> policy may not be good for all applications, and some may need a
> different policy. Such an application can still re-assign packets to
> application-internal queues that reside on different CPUs and that's
> what 'in-qemu' RSS does. However, that incurs communication overheads
> across CPUs. The eBPF steering program can eliminate the overheads by
> allowing the userspace to override the packet assignment policy with eBPF=
.
>

Yes, eBPF steering can do more than just RSS. For VM use cases, it
just needs to wait for the spec support. For example, spec will
support receiving flow director soon, we can leverage the eBPF support
for tuntap to do that.

> The eBPF steering program feature of tuntap and its benefit are
> independent of the vhost usage. In fact, the feature predates the usage
> in QEMU that combines vhost and eBPF steering program.

I think they should coexist. For example, for many reasons eBPF might
not be available on the host.

> The initial
> proposal of the eBPF steering program I found is submitted by Jason and
> available at:
> https://lore.kernel.org/lkml/1506500637-13881-1-git-send-email-jasowang@r=
edhat.com/
>
> Jason, please point out if you find something wrong in my understanding
> with the eBPF steering program feature or something to add.

Thanks

>



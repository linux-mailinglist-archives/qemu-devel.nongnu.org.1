Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 706BA81AC91
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 03:19:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG8dN-0007XS-VA; Wed, 20 Dec 2023 21:18:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rG8dL-0007X3-3Z
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 21:17:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rG8dJ-0007LS-HS
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 21:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703125075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hw1t6nTeIToWjqpxnTSUmGAnf/nHyHQ9BjOhHACRPM8=;
 b=iOQV7thIM5T4vM92rtK5EitfMUqeZ5hBo2zvRQcbMlS2iRQL3qDppr0eGtb2i8bXe/EP3y
 Nf5wq+Bt6NcuFatBkA5P6Bsyrxf/6aN2MaPRl0ZA+P2CHo9niwatxRgkm2g+Y6UciXLOtN
 XqkQp7EYe4GnAz7yO2hODIbvPt5vlr0=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-Yq3buFWWOGCJBOKykrj0SQ-1; Wed, 20 Dec 2023 21:17:53 -0500
X-MC-Unique: Yq3buFWWOGCJBOKykrj0SQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3b9e053babcso364234b6e.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 18:17:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703125073; x=1703729873;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hw1t6nTeIToWjqpxnTSUmGAnf/nHyHQ9BjOhHACRPM8=;
 b=D/rX7rv91/At9lylOcxvP2AFFSHFiEdc9WhKYVsvuiDuXX0O3PWFysDRrcY4rLKQtk
 3s9BbL2i7STBZ7XbF1ZPzzROtOe5xlP56qOKW5lH4xkqD/TrCCLaI+zPodIgGSe00tAM
 ueCCd2NKRYMpcLZExPv/VCLbp3TpwiIt/LXmrNOblrAT8sUdyVfaHSnn+crPRjeRXLmz
 4nSDwBwklEMY3I/e1/B8iN0GXxwilbG7EgbZ9LvJJisJp1UTUBKnTmfSZBdu2M1EbIK/
 5wbYuKKuVCLsN9SWDGMi8h4J0t9SLlJpDSuUVXSeabbtREHLI+fPHjVv4CzqzxhdTFea
 rpww==
X-Gm-Message-State: AOJu0YywkmWPsag9ojVIyg2C6TkVIhDOvV4+Z9ElZ/7Jw40VSp+OPP/3
 pV67AgzUbODQXj7XVjvkIz1PogU5b7Rfdix4fSfIgfOKh2Zy68qAAOrF2rf4pDw5JPCF2JdyPCN
 ww7SrrxZXrMAXxeObYc8wzqdJRaoyKqI=
X-Received: by 2002:a05:6808:159b:b0:3bb:6b24:d353 with SMTP id
 t27-20020a056808159b00b003bb6b24d353mr3349186oiw.58.1703125073153; 
 Wed, 20 Dec 2023 18:17:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFI4ac05ZKQcR1NzfK0WugT2AsZJ1fHcgGJ057gkTUQDhS/e+PCkt0lwBjtg5MzMHwlMqe9etQdjL1sLEnIQjk=
X-Received: by 2002:a05:6808:159b:b0:3bb:6b24:d353 with SMTP id
 t27-20020a056808159b00b003bb6b24d353mr3349171oiw.58.1703125072950; Wed, 20
 Dec 2023 18:17:52 -0800 (PST)
MIME-Version: 1.0
References: <20231215172830.2540987-1-eperezma@redhat.com>
 <20231215172830.2540987-9-eperezma@redhat.com>
 <CACGkMEvH=uU4QxMHVHTo5tQiuML2+NTE3gZssfz84-+4kGHa1Q@mail.gmail.com>
 <CAJaqyWczW+uwYBsWas97JY6OgiSurnvNQnnTYPFWv5La55GOOg@mail.gmail.com>
In-Reply-To: <CAJaqyWczW+uwYBsWas97JY6OgiSurnvNQnnTYPFWv5La55GOOg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Dec 2023 10:17:41 +0800
Message-ID: <CACGkMEukZNUnXRSwpVAROe7U7GzkubP9i37ev+qOSQvWxLEK_Q@mail.gmail.com>
Subject: Re: [PATCH for 9.0 08/12] vdpa: add vhost_vdpa_load_setup
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 si-wei.liu@oracle.com, 
 Lei Yang <leiyang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Dec 20, 2023 at 3:07=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Dec 20, 2023 at 6:22=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Sat, Dec 16, 2023 at 1:28=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > Callers can use this function to setup the incoming migration thread.
> > >
> > > This thread is able to map the guest memory while the migration is
> > > ongoing, without blocking QMP or other important tasks. While this
> > > allows the destination QEMU not to block, it expands the mapping time
> > > during migration instead of making it pre-migration.
> >
> > If it's just QMP, can we simply use bh with a quota here?
> >
>
> Because QEMU cannot guarantee the quota at write(fd,
> VHOST_IOTLB_UPDATE, ...).

So you mean the delay may be caused by a single syscall?

> Also, synchronization with
> vhost_vdpa_dev_start would complicate as it would need to be
> re-scheduled too.

Just a flush of the bh, or not?

But another question. How to synchronize with the memory API in this
case. Currently the updating (without vIOMMU) is done under the
listener callback.

Usually after the commit, Qemu may think the memory topology has been
updated. If it is done asynchronously, would we have any problem?

>
> As a half-baked idea, we can split the mapping chunks in manageable
> sizes, but I don't like that idea a lot.
>
> > Btw, have you measured the hotspot that causes such slowness? Is it
> > pinning or vendor specific mapping that slows down the progress? Or if
> > VFIO has a similar issue?
> >
>
> Si-Wei did the actual profiling as he is the one with the 128G guests,
> but most of the time was spent in the memory pinning. Si-Wei, please
> correct me if I'm wrong.
>
> I didn't check VFIO, but I think it just maps at realize phase with
> vfio_realize -> vfio_attach_device -> vfio_connect_container(). In
> previous testings, this delayed the VM initialization by a lot, as
> we're moving that 20s of blocking to every VM start.
>
> Investigating a way to do it only in the case of being the destination
> of a live migration, I think the right place is .load_setup migration
> handler. But I'm ok to move it for sure.

Adding Peter for more ideas.

>
> > >
> > > This thread joins at vdpa backend device start, so it could happen th=
at
> > > the guest memory is so large that we still have guest memory to map
> > > before this time.
> >
> > So we would still hit the QMP stall in this case?
> >
>
> This paragraph is kind of outdated, sorry. I can only cause this if I
> don't enable switchover_ack migration capability and if I artificially
> make memory pinning in the kernel artificially slow. But I didn't
> check QMP to be honest, so I can try to test it, yes.
>
> If QMP is not responsive, that means QMP is not responsive in QEMU
> master in that period actually. So we're only improving anyway.
>
> Thanks!
>

Thanks



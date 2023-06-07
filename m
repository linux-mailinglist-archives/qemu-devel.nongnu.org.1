Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 554CD7256FB
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 10:09:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6oE4-0000vu-Hp; Wed, 07 Jun 2023 04:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q6oE2-0000u6-3k
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:09:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q6oE0-0007Qa-DG
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686125339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OGp77i01/SIDau9dsGXM+5mDJyfSeAIA69geezh77fM=;
 b=FuIxKlhIcLieh1ocexZuJjJ6vsk/kFScT5U24tAjypet8xqUOvHNI4zfixWO0ek3W6HK0r
 tMAVNvJoaIm0Yxj42swePbMvs6yNwYfiwHdoMnxg5I+dRrmFd9p8aXM7zlWSPQ59SSKVIk
 tgW0/RSpYbghln6ZDBQ2n2qJkgGGOiY=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-zUBelTdHOyeaInrD_5bi7Q-1; Wed, 07 Jun 2023 04:08:57 -0400
X-MC-Unique: zUBelTdHOyeaInrD_5bi7Q-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-bb3a35ba742so2824364276.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 01:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686125337; x=1688717337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OGp77i01/SIDau9dsGXM+5mDJyfSeAIA69geezh77fM=;
 b=iWeakIdQ7hD1Z/+1x68gJvdb78a/12WyAfFjr9zaw71vxmfm7DStefBwSZJntakzq2
 98Y3rG1/vnY+rHDo42kBFqpuRYu9O8EBsuKlyp/O/fMzV3Do/6REG+mA4sdhQqNNEvKD
 oFjxFKCUSwApeLkq9gYGP05Q4XthLxghI1VWrAnfkkKkx9W2+MqjIfy9dZ11TID0YUS2
 kyytcSHnDQSMFRxd3Zwcq9R89m7619QrVc/i02tmcehKwV3UXFjaUb2sazeRYICqr141
 yoCNEKvwWBjzka7BLY+mWXKwojZGOYliEdWj0tkKX41jYDPsE4x24G++uqDTPM6e/8dP
 9BVA==
X-Gm-Message-State: AC+VfDzGXCgzlJzXixqHG7jYyHI7TR/hAmHIF7UF0toKRpvZ+nk9fh6h
 X2bl+Jq2fYgJEHCai+MUYjwkt8xn6Pyj/pX6XCdfLvtckT9vMYFcGSV5FLI7swbIY5DiBiu9yWA
 YtWk1n51APR6f1QGnE/koAPoHsjABaYA=
X-Received: by 2002:a25:e68a:0:b0:bac:6d5a:f6aa with SMTP id
 d132-20020a25e68a000000b00bac6d5af6aamr5270538ybh.23.1686125337189; 
 Wed, 07 Jun 2023 01:08:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5FeXSlF4YMYCGXW8gTt5EdlOUpJ/R21V0EbTTDCT8wKVSNIA9Y2twW/lzn7acxtTBq+8zAVE3TSuYtGBbFyxM=
X-Received: by 2002:a25:e68a:0:b0:bac:6d5a:f6aa with SMTP id
 d132-20020a25e68a000000b00bac6d5af6aamr5270522ybh.23.1686125336940; Wed, 07
 Jun 2023 01:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaqyWdV6pKP0SVZciMiu_HN86aJriZh0HBiwHNkO7+yErXnBA@mail.gmail.com>
 <c59d2d67-d31a-b6e6-54c5-5b81c18d9547@oracle.com>
In-Reply-To: <c59d2d67-d31a-b6e6-54c5-5b81c18d9547@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 7 Jun 2023 10:08:20 +0200
Message-ID: <CAJaqyWegsVHEVZt2_mf4wA8MuF7UXmU=UbHJfwyzURDRxfRgmg@mail.gmail.com>
Subject: Re: Reducing vdpa migration downtime because of memory pin / maps
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-level <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, 
 Michael Tsirkin <mst@redhat.com>, Longpeng <longpeng2@huawei.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Eli Cohen <elic@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>, Juan Quintela <quintela@redhat.com>, 
 David Gilbert <dgilbert@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Wed, Jun 7, 2023 at 12:43=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> Sorry for reviving this old thread, I lost the best timing to follow up
> on this while I was on vacation. I have been working on this and found
> out some discrepancy, please see below.
>
> On 4/5/23 04:37, Eugenio Perez Martin wrote:
> > Hi!
> >
> > As mentioned in the last upstream virtio-networking meeting, one of
> > the factors that adds more downtime to migration is the handling of
> > the guest memory (pin, map, etc). At this moment this handling is
> > bound to the virtio life cycle (DRIVER_OK, RESET). In that sense, the
> > destination device waits until all the guest memory / state is
> > migrated to start pinning all the memory.
> >
> > The proposal is to bind it to the char device life cycle (open vs
> > close),
>
> Hmmm, really? If it's the life cycle for char device, the next guest /
> qemu launch on the same vhost-vdpa device node won't make it work.
>

Maybe my sentence was not accurate, but I think we're on the same page here=
.

Two qemu instances opening the same char device at the same time are
not allowed, and vhost_vdpa_release clean all the maps. So the next
qemu that opens the char device should see a clean device anyway.

>
> >   so all the guest memory can be pinned for all the guest / qemu
> > lifecycle.
>
> I think to tie pinning to guest / qemu process life cycle makes more
> sense. Essentially this pinning part needs to be decoupled from the
> iotlb mapping abstraction layer, and can / should work as a standalone
> uAPI. Such that QEMU at the destination may launch and pin all guest's
> memory as needed without having to start the device, while awaiting any
> incoming migration request. Though problem is, there's no existing vhost
> uAPI that could properly serve as the vehicle for that. SET_OWNER /
> SET_MEM_TABLE / RESET_OWNER seems a remote fit.. Any objection against
> introducing a new but clean vhost uAPI for pinning guest pages, subject
> to guest's life cycle?
>

I think that to pin or not pin memory maps should be a kernel
decision, not to be driven by qemu. I'm not against it if needed, but
let me know if the current "clean at close" address your concerns.

> Another concern is the use_va stuff, originally it tags to the device
> level and is made static at the time of device instantiation, which is
> fine. But others to come just find a new home at per-group level or
> per-vq level struct. Hard to tell whether or not pinning is actually
> needed for the latter use_va friends, as they are essentially tied to
> the virtio life cycle or feature negotiation. While guest / Qemu starts
> way earlier than that. Perhaps just ignore those sub-device level use_va
> usages? Presumably !use_va at the device level is sufficient to infer
> the need of pinning for device?
>

I don't follow this. But I have the feeling that the subject of my
original mail is way more accurate if I would have said just "memory
maps".

I still consider the way to fix it is to actually delegate that to the
kernel vdpa, so it can choose if a particular ASID needs the pin or
not. But let me know if I missed something.

Thanks!

> Regards,
> -Siwei
>
>
> >
> > This has two main problems:
> > * At this moment the reset semantics forces the vdpa device to unmap
> > all the memory. So this change needs a vhost vdpa feature flag.
> > * This may increase the initialization time. Maybe we can delay it if
> > qemu is not the destination of a LM. Anyway I think this should be
> > done as an optimization on top.
> >
> > Any ideas or comments in this regard?
> >
> > Thanks!
> >
>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FF5719E68
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:42:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4iYj-0004K0-3Q; Thu, 01 Jun 2023 09:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4iYh-0004JP-2a
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:41:43 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4iYf-0007YG-9W
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:41:42 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2af225e5b4bso10919061fa.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 06:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685626899; x=1688218899;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRjFCmvtpsSicBzIGNQv4BxkrEkukTWabvKumZ3hq/0=;
 b=FtBFS2W5DmaK5bzqmNtJyllyAS6WVPTDyYTsB2e94jc6A8aqnqkqbdnvJRZO5dTvpP
 UxkHln2SUpGYxKzKVno0iTkcYq/y9PcKuc3ttU+Bkd6E8Pv1PbI5yMGbqdIgwAcvtF8g
 ENvoX0dHCf1rhduhilkUfeOe1KZOLqBbuWdhm58cLQgqlV8yzDji0EuI0oW/fkO52pFB
 5BEpM0qt5MMdEls6i3wMtG/qgLe2k+/ua1FWHovI9X0Zz5UapKUfhvdSAwJUGXlmKFdY
 xB/7PG6o3UgPZZPnm7DLnOPk1o9pqpXEiQrF39aDQsbhmPw8hqTFq9qQsoK3gKxsSxp0
 FvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685626899; x=1688218899;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRjFCmvtpsSicBzIGNQv4BxkrEkukTWabvKumZ3hq/0=;
 b=A3QnGQFgRBSNekAfLXA9bu0Tg0nLJeJzucJ/o2TMv0KJYKm3QdqE6W2KP2BOPXNLKy
 5KbWMmT3/jRNkxCgk73ylU9CcaPt2ENjD1Ujy08zylmY/4xG8UEKODx5KuTM2q+9Cm18
 Pe7N3ynaF0qoRUBMXMESZ1sg41tko2mWbs/xsIoYDsIPBqtm6Eit1GMifIYnJ0oWvMqI
 iLdNk4mS2N6aoYXkBJybKWO/qy3+IJ+z6yl3Okl0xcLwo5Iw4GnRV+uge/u+cWur3rW2
 lKZdZR2ZIVGC9T2eaLsRT/4x+YTCAxRRCNEUUu4zaS0ZPn5gS3mk0ynf11PEelAxiZoP
 oUig==
X-Gm-Message-State: AC+VfDwoAJzqoXj16pSPe0qYwIb4Mk4orm1qt2GZ1HvjL6KJvxRCRiQy
 ibxCItp17boZkjrEbswpnNyIxbDNRSO+XXpUOTY=
X-Google-Smtp-Source: ACHHUZ4nm4TZ8bj20anX7Lshdil0LAXBu6uCbkJ1H561AM0MI4DreyT0HuYR9V9YhiFZKaeMGUXq2KzqRmFikuA+oWo=
X-Received: by 2002:a2e:a3d0:0:b0:2a8:eae2:d563 with SMTP id
 w16-20020a2ea3d0000000b002a8eae2d563mr4908906lje.53.1685626898666; Thu, 01
 Jun 2023 06:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685584543.git.yin31149@gmail.com>
 <CAPpAL=yn=Js841iHzXM42+yPrLW7s=YLwY36BBxPDAvPGVaG0Q@mail.gmail.com>
In-Reply-To: <CAPpAL=yn=Js841iHzXM42+yPrLW7s=YLwY36BBxPDAvPGVaG0Q@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Thu, 1 Jun 2023 21:41:26 +0800
Message-ID: <CAKrof1P2v5oyHhiDWQV_p9Gdn_n3q60o5KVs6XVeiHRF56wNNA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Vhost-vdpa Shadow Virtqueue Offloads support
To: Lei Yang <leiyang@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On 2023/6/1 17:56, Lei Yang wrote:
> I'm a QE responsible for vhost_vdpa parts. Could you please provide me
> with the test steps for this series? I can test it in my environment
> and update the test results.
>

Hi Lei,

I am not sure if these are enough, but you can test it like this:

1. you can merge these patches into the latest master branch and compile th=
e
source. It should not trigger any error or warning.

2. start QEMU with the vdpa device and enable the ctrl_guest_offloads
feature on. The command line should like the following:
        -netdev type=3Dvhost-vdpa,id=3Dvdpa0,vhostdev=3D/dev/vhost-vdpa-0,x=
-svq=3Dtrue \
        -device virtio-net-pci,netdev=3Dvdpa0,ctrl_guest_offloads=3Don,...

It should also not trigger any error or warning. Without this series,
QEMU should fail with "vdpa svq does not work with features 4" error.

Regarding migration, it seems that testing it is not feasible at the
moment due to the migration blocker.

And you can test on my v3 patch, I will send the v3 patch to the mailing
lists later.

Thank you for your efforts!


>
>
>
>
> On Thu, Jun 1, 2023 at 4:29=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com=
> wrote:
>>
>> This series enables shadowed CVQ to intercept Offloads commands
>> through shadowed CVQ, update the virtio NIC device model so qemu
>> send it in a migration, and the restore of that Offloads state
>> in the destination.
>>
>> Changelog
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>> v2:
>>    - make some function arguments const
>>    - reuse virtio_vdev_has_feature() suggested by Eugenio and Jason
>>    - avoid sending CVQ command in default state suggested by Eugenio
>>
>> v1: https://lore.kernel.org/all/cover.1685359572.git.yin31149@gmail.com/
>>
>> Hawkins Jiawei (6):
>>    include/hw/virtio: make some VirtIODevice const
>>    vdpa: reuse virtio_vdev_has_feature()
>>    hw/net/virtio-net: make some VirtIONet const
>>    virtio-net: expose virtio_net_supported_guest_offloads()
>>    vdpa: Add vhost_vdpa_net_load_offloads()
>>    vdpa: Allow VIRTIO_NET_F_CTRL_GUEST_OFFLOADS in SVQ
>>
>>   hw/net/virtio-net.c            |  2 +-
>>   include/hw/virtio/virtio-net.h |  1 +
>>   include/hw/virtio/virtio.h     |  2 +-
>>   net/vhost-vdpa.c               | 45 +++++++++++++++++++++++++++++++---
>>   4 files changed, 44 insertions(+), 6 deletions(-)
>>
>> --
>> 2.25.1
>>
>>
>


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C68E472011C
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 14:06:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q53Xa-0002Jz-4l; Fri, 02 Jun 2023 08:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q53XS-0002Hs-8o
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:05:53 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q53XO-00033h-Rs
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:05:48 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b1a819b8d8so16879971fa.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 05:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685707545; x=1688299545;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dfGL2weTS34prZe6SdGOA+luXj3JHdWsDAn36fKVcJw=;
 b=oi1tHHVnL5vKbe1Y92pFXnlabFhrtRBhO9rMcU/mZ2DedWh/9bcAusZDRaZh+OGNax
 UtjHmt/ejchpK0mlNtXG3vSSHe63emvQnotuhHQ5SRBMmlX23oMuzQ7dNBUC6K+Z7C1R
 OYjuZPpAW1Gt0XS4GK9KuCBz7HjxrBIkISOuH1w538hj8J4Zw2K9JdGS4blmbHWrJH4w
 qzJW4lw3kjy+LOtgaN1RC0UrHvY+jxRJt8ZNOPh0anNCYBWKwjCDbRgoiLl/UmFLsnxU
 oSZZD9REo39jvNGVx68/C9J4POhSDmDJJ28tswydKLfqnzk97SnPbd3v1CA9L5prrzl9
 SQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685707545; x=1688299545;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dfGL2weTS34prZe6SdGOA+luXj3JHdWsDAn36fKVcJw=;
 b=IVofKqlDix2FMb5mczqcsMEvt2LycKg+W/4fWj0iqbOnMTBc5sep3xLKuQNQ12MxiS
 zE9OJXt1aANIlw3kzZAZSLgF9rivXb8jmgx3J6tSL3rwvzeFXrm8jS8g8EQwmUG6XJHW
 1Sf35LOKkE3lngBCM4icTatE0IBpCAlesCd8ZT52iBYFRFGmrYgpU2nuoY5rUhw+3FRk
 cLWah9BMRDPboh9a0ZAvcLo9wGvDX7IhoLo87VVqonFOw1AuCmVLeeov2RYe3sUeqmNV
 PwuzIFlpzMe5NfqLL1jRwWfTk5sZq4aQ7xX86375ZQYvV+aRCjyDc6iTXEnIgjCvwpKy
 ATjw==
X-Gm-Message-State: AC+VfDyFXqdo0/yzsoGMnvX/PSfrtdtJIqBfZCPxkE4HCPKreaQr/tX5
 RxfCZoYCa4GkOuHpbG3EB+6bT/6c7+uGH5v8eWU=
X-Google-Smtp-Source: ACHHUZ4OIjgSs2CujqfWPX+RxDGuZjd5fKn+szjeGDtQ000Yh+8pcwjUNuycmVNk5LGb8t0inrUEDBDWlboNc+gN0qE=
X-Received: by 2002:a2e:b0f2:0:b0:2b1:ad15:fe3b with SMTP id
 h18-20020a2eb0f2000000b002b1ad15fe3bmr1019471ljl.8.1685707544547; Fri, 02 Jun
 2023 05:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685623090.git.yin31149@gmail.com>
 <CAPpAL=wCZUghxGqApE6kW6PpFwWWDrrpGt_XwcOU39RUqcwRQw@mail.gmail.com>
In-Reply-To: <CAPpAL=wCZUghxGqApE6kW6PpFwWWDrrpGt_XwcOU39RUqcwRQw@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Fri, 2 Jun 2023 20:05:31 +0800
Message-ID: <CAKrof1PEyFOLX-dkzBn9VoLN7AKaA_qn8ffqQiX4bHLku5exnQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Vhost-vdpa Shadow Virtqueue Offloads support
To: Lei Yang <leiyang@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com, 
 qemu-devel@nongnu.org, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x232.google.com
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

On Fri, 2 Jun 2023 at 19:26, Lei Yang <leiyang@redhat.com> wrote:
>
> Hello Hawkins
>
> QE based on the qemu command line [1] to test this series with the
> following scenarios: reboot,shutdown,hotplug/unplug,ping, and
> offloads(tx,sg,tso,gso,gro), everything is working fine. It's just
> that even without applying your patch to test offload there is no
> error like "vdpa svq is not available for feature 4".
>
> [1] -device '{"driver": "virtio-net-pci", "mac": "00:11:22:33:44:00",
> "id": "net0", "netdev": "hostnet0", "ctrl_guest_offloads": true,
> "bus": "pcie-root-port-3", "addr": "0x0"}'  \
> -netdev vhost-vdpa,id=3Dhostnet0,vhostdev=3D/dev/vhost-vdpa-0,x-svq=3Don =
\

Hi Lei,

Thanks for your efforts.

However, I noticed a small correction. In the argument '-netdev',
the value of member 'x-svq' should be 'true' instead of 'on'.

I have tested these patches using a vp-vdpa device, and without them,
I encountered an error "vpda svq is not available for feature 4" while
trying to start QEMU. With these patches applied, everything works
perfectly.

Thanks!

>
> Tested-by: Lei Yang <leiyang@redhat.com>
>
>
>
>
> On Thu, Jun 1, 2023 at 9:49=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com=
> wrote:
> >
> > This series enables shadowed CVQ to intercept Offloads commands
> > through shadowed CVQ, update the virtio NIC device model so qemu
> > send it in a migration, and the restore of that Offloads state
> > in the destination.
> >
> > Changelog
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > v3:
> >   - refactor the commit message in patch
> > "virtio-net: expose virtio_net_supported_guest_offloads()"
> >
> > v2: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg00044.h=
tml
> >
> > v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-05/msg07198.h=
tml
> >
> > Hawkins Jiawei (6):
> >   include/hw/virtio: make some VirtIODevice const
> >   vdpa: reuse virtio_vdev_has_feature()
> >   hw/net/virtio-net: make some VirtIONet const
> >   virtio-net: expose virtio_net_supported_guest_offloads()
> >   vdpa: Add vhost_vdpa_net_load_offloads()
> >   vdpa: Allow VIRTIO_NET_F_CTRL_GUEST_OFFLOADS in SVQ
> >
> >  hw/net/virtio-net.c            |  2 +-
> >  include/hw/virtio/virtio-net.h |  1 +
> >  include/hw/virtio/virtio.h     |  2 +-
> >  net/vhost-vdpa.c               | 45 +++++++++++++++++++++++++++++++---
> >  4 files changed, 44 insertions(+), 6 deletions(-)
> >
> > --
> > 2.25.1
> >
> >
>


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D21FD759925
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 17:07:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM8kt-000525-R9; Wed, 19 Jul 2023 11:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qM8kr-0004x0-Gu
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:06:17 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qM8kp-0003dD-Kp
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:06:17 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1b0249f1322so5301995fac.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 08:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689779174; x=1690383974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k7m11GWqv1S0maEtX067fxtJsV5kkSay0znnC3lOix8=;
 b=A3y0YfTYVF9eYO2T31krXE8kXR7Ud5E/kFr0HqV/s/lb4/G46dDZ+elzDMBaGrhOLT
 oeL5qvxRJnpPwLEchhYzdS+tcMy52mdR80VArcCoKvWDi5E0ZFYF8hT1JHsbaKDc1yvp
 lrGpbsHZbW0mgXXtEHzSm1wrMlQEIaL4DVM3ZLNsO5QMUl/+yrmsaozM4AMYWHOrKHQ1
 FolfAld6KR7dhq1rnrZzJIiVfGfA+eXfTa2eobvYM6GQ/Q8yl3iyiZfthNIb3Zx2HbtG
 pBAacqPbPpHhfhfbHwcj5QFf84G2ZrWz7YZRpCSNTTlf8jsDqh96Ll2PAb9fp1xLPlAp
 p1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689779174; x=1690383974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k7m11GWqv1S0maEtX067fxtJsV5kkSay0znnC3lOix8=;
 b=dPhgX8Zf6sOtZW4Ez1aiHQXKt/JJpBJtmE+hQqoduzsbqbQS/aGTo0ku6wjtHWXV9J
 c4Dpvc3rqgN6p/uuEQAnx5GqKXbYqvKTG6iEvqllDCS8Giacn+JzBsBrTQc5mExnGs9o
 xItC5GSRm6zQjjlo9zpA6fACgaZj7q8ykbfmo+ZJ1JjCT/WrKAA8wJCQ1J3weNtcqQTP
 mdHQJK8/PO+mMaWJvsUFsoEPnVPM5WjTRCdIUHZDJ2v5zTFJzfaFemBsdJ4mMNHVEmbM
 t+iourQlzWtklO2No6nICOCm+gJdx/ob3IWoBmbggyp+R0U4uUbCASUBRaGN/TAppr9X
 5GPw==
X-Gm-Message-State: ABy/qLbZRo+rsUFPCCmFo9hr4gzCsteT9yOKqndpo0/q2k/bVeahNRDx
 ymG6azxtWiYEtTXn9BkUJFGT2xLY+TTqLoQwiO4=
X-Google-Smtp-Source: APBJJlGh7UzkeqGOvzQ/zfcSk/CSfRyemwcKFuVmfC7Tl/NT97WGZDboAlrDzb7f68D4ngbd1uS6dnqdSt5LXsnZLEs=
X-Received: by 2002:a05:6870:96a6:b0:1b3:8d35:c85f with SMTP id
 o38-20020a05687096a600b001b38d35c85fmr2605795oaq.1.1689779174307; Wed, 19 Jul
 2023 08:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-6-hreitz@redhat.com>
 <20230718145032.GF44841@fedora>
 <82796f23-c9a7-7a52-96c4-f70d10a06d0a@redhat.com>
In-Reply-To: <82796f23-c9a7-7a52-96c4-f70d10a06d0a@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 19 Jul 2023 11:06:02 -0400
Message-ID: <CAJSP0QWd4nSL=M8Yb59dMbrO8Lj7YXgh72=Wn9THXDQ90wLQsg@mail.gmail.com>
Subject: Re: [PATCH 5/6] vhost-vdpa: Match vhost-user's status reset
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 German Maglione <gmaglione@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 19 Jul 2023 at 10:10, Hanna Czenczek <hreitz@redhat.com> wrote:
>
> On 18.07.23 16:50, Stefan Hajnoczi wrote:
> > On Tue, Jul 11, 2023 at 05:52:27PM +0200, Hanna Czenczek wrote:
> >> vhost-vdpa and vhost-user differ in how they reset the status in their
> >> respective vhost_reset_status implementations: vhost-vdpa zeroes it,
> >> then re-adds the S_ACKNOWLEDGE and S_DRIVER config bits.  S_DRIVER_OK =
is
> >> then set in vhost_vdpa_dev_start().
> >>
> >> vhost-user in contrast just zeroes the status, and does no re-add any
> >> config bits until vhost_user_dev_start() (where it does re-add all of
> >> S_ACKNOWLEDGE, S_DRIVER, and S_DRIVER_OK).
> >>
> >> There is no documentation for vhost_reset_status, but its only caller =
is
> >> vhost_dev_stop().  So apparently, the device is to be stopped after
> >> vhost_reset_status, and therefore it makes more sense to keep the stat=
us
> >> field fully cleared until the back-end is re-started, which is how
> >> vhost-user does it.  Make vhost-vdpa do the same -- if nothing else it=
's
> >> confusing to have both vhost implementations handle this differently.
> >>
> >> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> >> ---
> >>   hw/virtio/vhost-vdpa.c | 6 +++---
> >>   1 file changed, 3 insertions(+), 3 deletions(-)
> > Hi Hanna,
> > The VIRTIO spec lists the Device Initialization sequence including the
> > bits set in the Device Status Register here:
> > https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.=
html#x1-1070001
> >
> > ACKNOWLEDGE and DRIVER must be set before FEATURES_OK. DRIVER_OK is set
> > after FEATURES_OK.
> >
> > The driver may read the Device Configuration Space once ACKNOWLEDGE and
> > DRIVER are set.
> >
> > QEMU's vhost code should follow this sequence (especially for vDPA wher=
e
> > full VIRTIO devices are implemented).
> >
> > vhost-user is not faithful to the VIRTIO spec here. That's probably due
> > to the fact that vhost-user didn't have the concept of the Device Statu=
s
> > Register until recently and back-ends mostly ignore it.
> >
> > Please do the opposite of this patch: bring vhost-user in line with the
> > VIRTIO specification so that the Device Initialization sequence is
> > followed correctly. I think vhost-vdpa already does the right thing.
>
> Hm.  This sounds all very good, but what leaves me lost is the fact that
> we never actually expose the status field to the guest, as far as I can
> see.  We have no set_status callback, and as written in the commit
> message, the only caller of reset_status is vhost_dev_stop().  So the
> status field seems completely artificial in vhost right now.  That is
> why I=E2=80=99m wondering what the flags even really mean.

vhost (including vDPA and vhost-user) is not a 100% passthrough
solution. The VMM emulates a VIRTIO device (e.g. virtio-fs-pci) that
has some separate state from the vhost back-end, including the Device
Status Register. This is analogous to how passthrough PCI devices
still have emulated PCI registers that are not passed through to the
physical PCI device.

However, just because the vDPA, and now vhost-user with the SET_STATUS
message, back-end is not directly exposed to the guest does not mean
it should diverge from the VIRTIO specification for no reason.

> Another point I made in the commit message is that it is strange that we
> reset the status to 0, and then add the ACKNOWLEDGE and DRIVER while the
> VM is still stopped.  It doesn=E2=80=99t make sense to me to set these fl=
ags
> while the guest driver is not operative.

While there is no harm in setting those bits, I agree that leaving the
Device Status Register at 0 while the VM is stopped would be nicer.

> If what you=E2=80=99re saying is that we must set FEATURES_OK only after
> ACKNOWLEDGE and DRIVER, wouldn=E2=80=99t it be still better to set all of=
 these
> flags only in vhost_*_dev_start(), but do it in two separate SET_STATUS
> calls?

The device initialization sequence could be put into vhost_dev_start():
1. ACKNOWLEDGE | DRIVER
2. FEATURES_OK via vhost_dev_set_features()
3. DRIVER_OK via ->vhost_dev_start()

But note that the ->vhost_dev_start() callback is too late to set
ACKNOWLEDGE | DRIVER because feature negotiation happens earlier.

> (You mentioned the configuration space =E2=80=93 is that accessed while b=
etween
> vhost_dev_stop and vhost_dev_start?)

I don't think so.

>
> Hanna
>
> >> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> >> index f7fd19a203..0cde8b40de 100644
> >> --- a/hw/virtio/vhost-vdpa.c
> >> +++ b/hw/virtio/vhost-vdpa.c
> >> @@ -1294,8 +1294,6 @@ static void vhost_vdpa_reset_status(struct vhost=
_dev *dev)
> >>       }
> >>
> >>       vhost_vdpa_reset_device(dev);
> >> -    vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
> >> -                               VIRTIO_CONFIG_S_DRIVER);
> >>       memory_listener_unregister(&v->listener);
> >>   }
> >>
> >> @@ -1334,7 +1332,9 @@ static int vhost_vdpa_dev_start(struct vhost_dev=
 *dev, bool started)
> >>           }
> >>           memory_listener_register(&v->listener, dev->vdev->dma_as);
> >>
> >> -        return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
> >> +        return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE=
 |
> >> +                                          VIRTIO_CONFIG_S_DRIVER |
> >> +                                          VIRTIO_CONFIG_S_DRIVER_OK);
> >>       }
> >>
> >>       return 0;
> >> --
> >> 2.41.0
> >>
>
>


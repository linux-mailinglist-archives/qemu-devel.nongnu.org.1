Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C90327B7DFD
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 13:16:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnzr2-00084h-0s; Wed, 04 Oct 2023 07:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qnzqs-0007xZ-5r
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:15:39 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qnzqp-0005Zc-0u
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:15:37 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6c620883559so1329633a34.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 04:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696418131; x=1697022931; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/UCbmjI48pqLlbD2RD5pa5zFuTo6uDg0TeojO50THgw=;
 b=Bk+2i90FBAvX7XIv/CBRdLHS6CL+YPVzTht1MKoLtUFRoI0m6JOO6bcUnmaoAFX9aL
 3YTE7s5gSrpopCV9PAoiEIdUjR9DgFP8jOMY9iRIAfWiCzyEGljh0nLwQUIo0hjl8jUt
 haesWTxOExgqwjOKck8162m9vhafw/EfJqCBh4mUgGQNVMG/Z1LOU++TRCWqwFpTG/lm
 +QOZfZnAcpTI20iOhy3UM34og1yM0gAsCchWM8l+BH3Wj5dLil0aAO0nfs8Lco+7hsJd
 LIn4xip1Nr+IKDr5v/tZlDqP/xm//0dh791+f81UrnYnAqoG+QWuab5lZjQjO5X/cck7
 kVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696418131; x=1697022931;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/UCbmjI48pqLlbD2RD5pa5zFuTo6uDg0TeojO50THgw=;
 b=eMRKr8XD7wIsA+Xukp5WaoPjFmRvKKBo8XqNL6ifdnZBWGorhTUdaLR3cRBJJA6v0w
 FO2UXSjDavJWwrloir88XNQdpqU1mm3ZhsKanW7sMgkGdTa6B+MX/bUBTDk1DrnAxu2Q
 IhyB7cOBLHsTuO87gJWMLcmShS0+xQZfMzZvKhquZD81hyrgLIZFZtZ0LlweJWkcx2Hw
 z27ngXD4698490MXmW06+x+UxDg+REBrxLsGmbui7uOEf2P0FoZXvfbqZuUxoYsRcacE
 1R+0qHPuf8YwC0ae8jg/DhYtujJz0mMvZDfClCzKS2qC/s6V7VhrcyTKKqKjhkBXKp7i
 VrBA==
X-Gm-Message-State: AOJu0YydvbqphUWnNBcpO0CFHDnEWYre19rEvJafeF502dUnJHgvnzsT
 1b8y8ax7Zyn92HkRp1Yr5aA2FbN3LkM5d6yDRGs=
X-Google-Smtp-Source: AGHT+IEf0ofEjrGQTxxcnSHbWitKX/tVpM8JjbVvSK3S+CTo4rVkahEeZBJ0Tx91GLu3ujeT4g+EMcLrAWiC7eduDUA=
X-Received: by 2002:a9d:7383:0:b0:6b9:cba0:93a9 with SMTP id
 j3-20020a9d7383000000b006b9cba093a9mr1772035otk.31.1696418131167; Wed, 04 Oct
 2023 04:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231004014532.1228637-1-stefanha@redhat.com>
 <20231004014532.1228637-2-stefanha@redhat.com>
 <346cfde5-82af-724e-cc02-8f55d06e67ee@redhat.com>
In-Reply-To: <346cfde5-82af-724e-cc02-8f55d06e67ee@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 4 Oct 2023 07:15:19 -0400
Message-ID: <CAJSP0QV0OWEAYB8h45fK4Gep2OVC7VM0daJbdDXunSpj-2Wctw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] vhost-user: do not send RESET_OWNER on device reset
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Raphael Norwitz <raphael.norwitz@nutanix.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 eperezma@redhat.com,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 4 Oct 2023 at 06:44, Hanna Czenczek <hreitz@redhat.com> wrote:
>
> On 04.10.23 03:45, Stefan Hajnoczi wrote:
> > The VHOST_USER_RESET_OWNER message is deprecated in the spec:
> >
> >     This is no longer used. Used to be sent to request disabling all
> >     rings, but some back-ends interpreted it to also discard connection
> >     state (this interpretation would lead to bugs).  It is recommended
> >     that back-ends either ignore this message, or use it to disable all
> >     rings.
>
> According to the spec, it is then indeed better to not call it in
> vhost_user_reset_device, because it seems like it would be interpreted
> as something completely different.
>
> However, between the three back-end implementations of vhost-user I know
> of (libvhost-user, DPDK, the vhost crates; four if you count RSD), none
> implement RESET_DEVICE.  libvhost-user and DPDK do implement
> RESET_OWNER, though, and they both do it by resetting the device, not by
> disabling any vring.  The vhost crate also implements RESET_OWNER, but
> it doesn=E2=80=99t do anything but forward it as such to the actual devic=
e
> implementation (virtiofsd doesn=E2=80=99t implement this function, so ign=
ores
> it).  It does document that it would disable all vrings, but does so in
> the past and has marked it deprecated (ever since the method was
> introduced in the fourth commit to the repository, making it extremely
> unlikely that anyone would implement it).

Hi Hanna,
vhost-user-backend still seems to reset all vhost-user protocol state,
making RESET_OWNER unusable:
https://github.com/rust-vmm/vhost/blob/main/crates/vhost-user-backend/src/h=
andler.rs#L230

Have I missed something?

Stefan

>
> So I would like to know why the spec says that it would disable all
> vrings, when none of the implementations (qemu, libvhost-user, DPDK)
> agree on that.  Let me look it up:
>
> Before commit c61f09ed855, it did say =E2=80=9Cstopping=E2=80=9D instead =
of
> =E2=80=9Cdisabling=E2=80=9D.  The commit doesn=E2=80=99t explain why it c=
hanged this. Commit
> a586e65bbd0 (just a week prior) deprecated the command, changing it from
> =E2=80=9Cconnection is about to be closed, [front-end] will no longer own=
 this
> connection=E2=80=9D to =E2=80=9Cdeprecated, used to be sent to request st=
opping all
> vrings=E2=80=9D.  To me, the front-end closing the connection sounds like=
 a good
> point to reset, which would indeed stop all vrings, but not just that.
> Notably, qemu agrees, because RESET_OWNER is used only in the
> vhost_user_reset_device() function. a586e65bbd0^ removed that function=E2=
=80=99s
> use, though, specifically because it would cause a reset, when the
> intention was just to stop.
>
> So it sounds to me like =E2=80=9Cused to be sent to request stopping all =
vrings=E2=80=9D
> is rather what vhost_net wanted, but specifically not what the message
> did, which was anything between nothing and a reset, I presume (because
> it never specified what the back-end was supposed to do, though
> apparently libvhost-user and DPDK both took it to mean reset).  Why it
> was then changed to =E2=80=9Cdisabling=E2=80=9D, I absolutely cannot say.
>
> Now, the code change here is indeed effectively a no-op, as you deduce
> below, but in the context of the whole series the situation is a bit
> different: As far as I understand, the point is to have guest-initiated
> resets be forwarded to back-ends.  But by removing the RESET_OWNER
> fallback, no back-end will actually do a reset still.
>
> I understand that as per the specification, using RESET_OWNER for
> resetting is wrong.  But all implementations that implemented it before
> it was deprecated do interpret it as a reset, so I don=E2=80=99t think us=
ing it
> as a fallback is actually wrong.
>
> Hanna
>
> > The only caller of vhost_user_reset_device() is vhost_user_scsi_reset()=
.
> > It checks that F_RESET_DEVICE was negotiated before calling it:
> >
> >    static void vhost_user_scsi_reset(VirtIODevice *vdev)
> >    {
> >        VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(vdev);
> >        struct vhost_dev *dev =3D &vsc->dev;
> >
> >        /*
> >         * Historically, reset was not implemented so only reset devices
> >         * that are expecting it.
> >         */
> >        if (!virtio_has_feature(dev->protocol_features,
> >                                VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
> >            return;
> >        }
> >
> >        if (dev->vhost_ops->vhost_reset_device) {
> >            dev->vhost_ops->vhost_reset_device(dev);
> >        }
> >    }
> >
> > Therefore VHOST_USER_RESET_OWNER is actually never sent by
> > vhost_user_reset_device(). Remove the dead code. This effectively moves
> > the vhost-user protocol specific code from vhost-user-scsi.c into
> > vhost-user.c where it belongs.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   hw/scsi/vhost-user-scsi.c |  9 ---------
> >   hw/virtio/vhost-user.c    | 13 +++++++++----
> >   2 files changed, 9 insertions(+), 13 deletions(-)
> >
> > diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> > index ee99b19e7a..8582b2e8ab 100644
> > --- a/hw/scsi/vhost-user-scsi.c
> > +++ b/hw/scsi/vhost-user-scsi.c
> > @@ -71,15 +71,6 @@ static void vhost_user_scsi_reset(VirtIODevice *vdev=
)
> >       VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(vdev);
> >       struct vhost_dev *dev =3D &vsc->dev;
> >
> > -    /*
> > -     * Historically, reset was not implemented so only reset devices
> > -     * that are expecting it.
> > -     */
> > -    if (!virtio_has_feature(dev->protocol_features,
> > -                            VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
> > -        return;
> > -    }
> > -
> >       if (dev->vhost_ops->vhost_reset_device) {
> >           dev->vhost_ops->vhost_reset_device(dev);
> >       }
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 8dcf049d42..7bed9ad7d5 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -1492,12 +1492,17 @@ static int vhost_user_reset_device(struct vhost=
_dev *dev)
> >   {
> >       VhostUserMsg msg =3D {
> >           .hdr.flags =3D VHOST_USER_VERSION,
> > +        .hdr.request =3D VHOST_USER_RESET_DEVICE,
> >       };
> >
> > -    msg.hdr.request =3D virtio_has_feature(dev->protocol_features,
> > -                                         VHOST_USER_PROTOCOL_F_RESET_D=
EVICE)
> > -        ? VHOST_USER_RESET_DEVICE
> > -        : VHOST_USER_RESET_OWNER;
> > +    /*
> > +     * Historically, reset was not implemented so only reset devices
> > +     * that are expecting it.
> > +     */
> > +    if (!virtio_has_feature(dev->protocol_features,
> > +                            VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
> > +        return -ENOSYS;
> > +    }
> >
> >       return vhost_user_write(dev, &msg, NULL, 0);
> >   }
>
>


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2437A2301
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:57:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBBX-000361-TO; Fri, 15 Sep 2023 11:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qhBBV-00035n-Cq
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qhBBT-0003fg-N4
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694793402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/JtYBfkx/DlY6daXTAxaG7usLPdYRZ6h7QkgUGdkBJY=;
 b=fHnVrmg206r1p65ZQviSZqHOSIXj1FbeKZJGpmAYte8j+OuGuM2SmQLUjAIcNsU8lN76U9
 /uo8AM286MrrOApxKwdCAtPjRYqDtUx2+70sigoKlKa5K4LJ1v4tSRnliEC19pz1TJCZgA
 Ig+JsmcESaD+WocFWCuypzkY7MAVC2E=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-8MPe2ccFOf23yBp2GJk_4w-1; Fri, 15 Sep 2023 11:56:40 -0400
X-MC-Unique: 8MPe2ccFOf23yBp2GJk_4w-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-d814634fe4bso2814435276.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 08:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694793400; x=1695398200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/JtYBfkx/DlY6daXTAxaG7usLPdYRZ6h7QkgUGdkBJY=;
 b=rz6nFBRADJvVjtUtD7N+6nsjFLQ4eH0kzFmypvdomi15VaT1+3C/KUDUWrMiNgHeYL
 ihfkV2ha7u7ktw7AZFMsTTKb1EcTr4WEAIJ/tTQN/wtcZTkNQxcf1f9jF/kebXIgQu5i
 i2khQ/Ykla0dMgVMjvII+OHoF13QOdtcm1w1x6b3NvWJhk+85ws4Dl2wmc/EPLXDtIg0
 wqMtjzqKfg/tnI9vTZD6M0C82ZuI1tUs1tIuCa3AcwYVEFKH5OKz4Su4ZAPa5SsGYjW9
 m2MeVWt0UoFYmjQex+zTdSYkEoG3a4RMeG/NtC094c8LtA212Gyl8IJ5U3XsGfI+gJQy
 vySg==
X-Gm-Message-State: AOJu0YynVSKvDFQmOCo9vIgbKN2rJKXDdOiEgyRd8cMEhAHHZxw1aFZr
 JM1G+SbdvylUzKIW1p2QNBv5koteu5aboE/rieFsG5Fv/ioRGOmbvH0M67hCEY7BKGqQYkUmroD
 zlGZ5XedlpZ+XMkkm2dSTHCypjvdIRuU=
X-Received: by 2002:a25:848c:0:b0:d81:57db:7589 with SMTP id
 v12-20020a25848c000000b00d8157db7589mr2008799ybk.48.1694793400409; 
 Fri, 15 Sep 2023 08:56:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHVKfFRub1KdhvUF18KzgwbE3BmABO1kdt5gJjND0Ds/qT6JhwDqKZlOz0oJfuo0Cz27Q1i32QdEkDiMz2Sz8=
X-Received: by 2002:a25:848c:0:b0:d81:57db:7589 with SMTP id
 v12-20020a25848c000000b00d8157db7589mr2008781ybk.48.1694793400148; Fri, 15
 Sep 2023 08:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687782442.git.mst@redhat.com>
 <152128d646973ed298d41dafd7a5bccff43336c8.1687782442.git.mst@redhat.com>
 <CAFEAcA8mNRZL2hQoRxtz1rKqbNS4srbSXY-paBQjPqbEXXE0SQ@mail.gmail.com>
 <CAFEAcA8W2doGJ3iRJxs5RRTj1ffxA8mi8J5VdaOMb1C_xAYncw@mail.gmail.com>
In-Reply-To: <CAFEAcA8W2doGJ3iRJxs5RRTj1ffxA8mi8J5VdaOMb1C_xAYncw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 15 Sep 2023 17:56:03 +0200
Message-ID: <CAJaqyWcFxJoVZ-11400y5gbb4_Sy6NuLu=e0zR42umbDCfHs1g@mail.gmail.com>
Subject: Re: [PULL 28/53] vdpa: move CVQ isolation check to net_init_vhost_vdpa
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
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

On Fri, Sep 15, 2023 at 4:53=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 27 Jun 2023 at 12:30, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > On Mon, 26 Jun 2023 at 13:29, Michael S. Tsirkin <mst@redhat.com> wrote=
:
> > >
> > > From: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > >
> > > Evaluating it at start time instead of initialization time may make t=
he
> > > guest capable of dynamically adding or removing migration blockers.
> > >
> > > Also, moving to initialization reduces the number of ioctls in the
> > > migration, reducing failure possibilities.
> > >
> > > As a drawback we need to check for CVQ isolation twice: one time with=
 no
> > > MQ negotiated and another one acking it, as long as the device suppor=
ts
> > > it.  This is because Vring ASID / group management is based on vq
> > > indexes, but we don't know the index of CVQ before negotiating MQ.
> >
> > I was looking at this code because of a Coverity report.
> > That turned out to be a false positive, but I did notice
> > something here that looks like it might be wrong:
>
> Ping? Would somebody like to have a look at whether there's
> a missing return statement here?
>

Hi Peter,

I'm sorry, it fell through the cracks. I'll send two patches to fix it
right now.

Thanks!

> > >
> > > +/**
> > > + * Probe if CVQ is isolated
> > > + *
> > > + * @device_fd         The vdpa device fd
> > > + * @features          Features offered by the device.
> > > + * @cvq_index         The control vq pair index
> > > + *
> > > + * Returns <0 in case of failure, 0 if false and 1 if true.
> > > + */
> > > +static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t fe=
atures,
> > > +                                          int cvq_index, Error **err=
p)
> > > +{
> > > +    uint64_t backend_features;
> > > +    int64_t cvq_group;
> > > +    uint8_t status =3D VIRTIO_CONFIG_S_ACKNOWLEDGE |
> > > +                     VIRTIO_CONFIG_S_DRIVER |
> > > +                     VIRTIO_CONFIG_S_FEATURES_OK;
> > > +    int r;
> > > +
> > > +    ERRP_GUARD();
> > > +
> > > +    r =3D ioctl(device_fd, VHOST_GET_BACKEND_FEATURES, &backend_feat=
ures);
> > > +    if (unlikely(r < 0)) {
> > > +        error_setg_errno(errp, errno, "Cannot get vdpa backend_featu=
res");
> > > +        return r;
> > > +    }
> > > +
> > > +    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASID))) {
> > > +        return 0;
> > > +    }
> > > +
> > > +    r =3D ioctl(device_fd, VHOST_SET_FEATURES, &features);
> > > +    if (unlikely(r)) {
> > > +        error_setg_errno(errp, errno, "Cannot set features");
> >
> > Shouldn't we have a 'return r' (or maybe a 'goto out') here ?
> > Otherwise we'll just plough onward and attempt to continue
> > execution...
> >
> > > +    }
> > > +
> > > +    r =3D ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
> > > +    if (unlikely(r)) {
> > > +        error_setg_errno(errp, -r, "Cannot set device features");
> >
> > Isn't this trying to set device status, not features ?
> >
> > > +        goto out;
> > > +    }
> >
> > thanks
> > -- PMM
>
> thanks
> -- PMM
>



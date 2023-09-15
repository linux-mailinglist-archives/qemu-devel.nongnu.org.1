Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A337A218D
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:54:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhACm-0003GC-5S; Fri, 15 Sep 2023 10:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qhAC6-0002A7-JU
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:53:20 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qhAC4-0006ql-N5
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:53:18 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-401ec23be82so23521695e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 07:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694789595; x=1695394395; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ok7gOWw4eBmR9k9M4uRpZ+gkb1jYsoiH9pIehvuPIEQ=;
 b=MEop7FAsPXq70Q4zJ+roBiMlqc+m46kYnYbjK1V+WbixBLhIuhjy3KLfswuHGZ5OjR
 O90eWcPePPlelyIlh5EJiWYTGRzZwtgYUMjW5q20Aw5I22Nts9H0PWNDYSE13RjhMDAH
 E0UB2/BzsAuxEo0KR5oxgbZ5Ztxd6Tp7FGlmeJO+BMPKb5WxDplYkCAQ2KAKJjnCUeJZ
 FNw6CCVGz1h7V17x5oJJKukH37ZywZA0oYh+yE99R3dWznMJl316P9mzyEY4LEJfM/x5
 gEvUGBs0R4E/zDEET3aA1YjpqeviUbl5pnSLPrEu6Lg2eWPYNUZ3xlBhRGE+3UWzh79A
 tx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694789595; x=1695394395;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ok7gOWw4eBmR9k9M4uRpZ+gkb1jYsoiH9pIehvuPIEQ=;
 b=JVtsJDmnyAUAGlyJuM7Y7shEvANZGFTJqdLoNYrJbD2AjIEDgUiCUNKGtcHzOuho5o
 5H2vRNSgqu/MhX+Z9LclV2YDGCaROwaMbDLarvtwcXQlIPayZwyb4hiNi1CATSOkCpxU
 PugOdnvt4gm4h3s2rThvT/fwdAdlWcUcATtHTLUYS9tWaTCnDfQd6JTGqwD83oPmEDL8
 RNi7b17nNZ4OXKgQ2GTan0NFW/polL1frUpBSB50zB4xZWZeMywdm0sp/ExbAsh3N95u
 0NKSFeb9IUugztWyfCKVi3/GW2Hq0hIsrMG4A/vseNMUmXV8RADWwUW36vAzDQc15IXb
 jZ4w==
X-Gm-Message-State: AOJu0YyvdmuSuYDv50CKNAxeqEudLMVpiI0XrDqFyKCrHP5okBho7r7/
 6dPD74Be8Dk6fBHQ1FZT8tzirrkwPj2WWoYbkl7bzw==
X-Google-Smtp-Source: AGHT+IGiVFvxnyT6r9Bz0TvO+r6Du2eLgvHidVU4wJ6KOGfpIBnl+kRiFnzETZbaCF63U4231QkrRLdaJYmDg+XU4hE=
X-Received: by 2002:a5d:4442:0:b0:319:8bd0:d18c with SMTP id
 x2-20020a5d4442000000b003198bd0d18cmr1784383wrr.52.1694789595143; Fri, 15 Sep
 2023 07:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687782442.git.mst@redhat.com>
 <152128d646973ed298d41dafd7a5bccff43336c8.1687782442.git.mst@redhat.com>
 <CAFEAcA8mNRZL2hQoRxtz1rKqbNS4srbSXY-paBQjPqbEXXE0SQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8mNRZL2hQoRxtz1rKqbNS4srbSXY-paBQjPqbEXXE0SQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Sep 2023 15:52:55 +0100
Message-ID: <CAFEAcA8W2doGJ3iRJxs5RRTj1ffxA8mi8J5VdaOMb1C_xAYncw@mail.gmail.com>
Subject: Re: [PULL 28/53] vdpa: move CVQ isolation check to net_init_vhost_vdpa
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 27 Jun 2023 at 12:30, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Mon, 26 Jun 2023 at 13:29, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > From: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >
> > Evaluating it at start time instead of initialization time may make the
> > guest capable of dynamically adding or removing migration blockers.
> >
> > Also, moving to initialization reduces the number of ioctls in the
> > migration, reducing failure possibilities.
> >
> > As a drawback we need to check for CVQ isolation twice: one time with n=
o
> > MQ negotiated and another one acking it, as long as the device supports
> > it.  This is because Vring ASID / group management is based on vq
> > indexes, but we don't know the index of CVQ before negotiating MQ.
>
> I was looking at this code because of a Coverity report.
> That turned out to be a false positive, but I did notice
> something here that looks like it might be wrong:

Ping? Would somebody like to have a look at whether there's
a missing return statement here?

> >
> > +/**
> > + * Probe if CVQ is isolated
> > + *
> > + * @device_fd         The vdpa device fd
> > + * @features          Features offered by the device.
> > + * @cvq_index         The control vq pair index
> > + *
> > + * Returns <0 in case of failure, 0 if false and 1 if true.
> > + */
> > +static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t feat=
ures,
> > +                                          int cvq_index, Error **errp)
> > +{
> > +    uint64_t backend_features;
> > +    int64_t cvq_group;
> > +    uint8_t status =3D VIRTIO_CONFIG_S_ACKNOWLEDGE |
> > +                     VIRTIO_CONFIG_S_DRIVER |
> > +                     VIRTIO_CONFIG_S_FEATURES_OK;
> > +    int r;
> > +
> > +    ERRP_GUARD();
> > +
> > +    r =3D ioctl(device_fd, VHOST_GET_BACKEND_FEATURES, &backend_featur=
es);
> > +    if (unlikely(r < 0)) {
> > +        error_setg_errno(errp, errno, "Cannot get vdpa backend_feature=
s");
> > +        return r;
> > +    }
> > +
> > +    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASID))) {
> > +        return 0;
> > +    }
> > +
> > +    r =3D ioctl(device_fd, VHOST_SET_FEATURES, &features);
> > +    if (unlikely(r)) {
> > +        error_setg_errno(errp, errno, "Cannot set features");
>
> Shouldn't we have a 'return r' (or maybe a 'goto out') here ?
> Otherwise we'll just plough onward and attempt to continue
> execution...
>
> > +    }
> > +
> > +    r =3D ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
> > +    if (unlikely(r)) {
> > +        error_setg_errno(errp, -r, "Cannot set device features");
>
> Isn't this trying to set device status, not features ?
>
> > +        goto out;
> > +    }
>
> thanks
> -- PMM

thanks
-- PMM


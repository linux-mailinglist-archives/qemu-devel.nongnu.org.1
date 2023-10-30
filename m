Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB257DBB9E
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:21:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxT7a-0003Pm-Qf; Mon, 30 Oct 2023 10:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qxT7Y-0003Ng-HY; Mon, 30 Oct 2023 10:20:00 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qxT7W-0005jw-ND; Mon, 30 Oct 2023 10:20:00 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-507cee17b00so6497946e87.2; 
 Mon, 30 Oct 2023 07:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698675596; x=1699280396; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ch/M8kkwMlcnuI6pWMJi3G4kNx7x20Bb0jbmSmyArSI=;
 b=C6oQ+NDNIwbYUgm8EIRZBrnKr+e6IVgNEOuP/Gzd5KSuh+yA4hSrD5MS5lHpt3qFDg
 K8verGNEiS6sp0Qeb6Yro7Stet2Zkrtc7JRPEjO9YnEBYcHvx5sAqNh8Sn6JYdXIn8wI
 O7H384gwihHil93GOpAHEY6pToe/z9KRE3H6FKUjlLvuqyqEu8V0xZI2qscXRrDUGfH3
 ZIbnU2Ie8P+emhKII/7DKSnUREFpU5YAFDpOrF23T+AAGX9QyvRyjUdSrD0hLBahF8IR
 DSxQHU9iBkhLYkFp8kg9JJvXJTAEuz35daAtzDSosuUcuP8T958gBvq9PW27qacv61xL
 dYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698675596; x=1699280396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ch/M8kkwMlcnuI6pWMJi3G4kNx7x20Bb0jbmSmyArSI=;
 b=IZivjAwj6AEUgnfXAvCqnFxO4LYqIM04ddZatbPpCYa6Ny4TQYfnnslw4HKgbbQDsM
 e2jsyDmKNoRYIkgryJyleSj+AMOKkPnes+pt2gLzIv7Uxgj3626yhzymnaahy5esYWur
 l8I6u16ixQPAPi199KAQYlFUF5dNGoL9TlfMAW1bWJI5taWvyZtOwTDgdmyR07RPqrr0
 AthJ6Hl+W9PKQ71QfPNpKi6nSRTqjE6znu71ogRNDThSrXfpJS1vt57k8KjQVO2+ilAm
 kXRtowpTkvAjE5tqnGLJrjHTW4N0H2Y2lqiOwDiXXEFiafM9y/+7Rj9Kt5RiZGADC6Rl
 Pf9Q==
X-Gm-Message-State: AOJu0Yzk/PdTRFgUMXLmZycyHk2eEZoh7wfo2QxUY907V8HUVyqYywJY
 zjXo35cyYQsJhj9nDYg5oqL2QQuDF70lj1yR9V8=
X-Google-Smtp-Source: AGHT+IFJPWf7znv8irbmlcC+8Yp1Qy64yMb0JZ8cNrOs7VfTIO4tRmZ8fOjGgsTdYTHt6wwwuk30PlHqU6bm/154BP8=
X-Received: by 2002:a05:6512:3b97:b0:507:9777:a34a with SMTP id
 g23-20020a0565123b9700b005079777a34amr10156151lfv.39.1698675595535; Mon, 30
 Oct 2023 07:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231030121847.4522-1-faithilikerun@gmail.com>
 <20231030121847.4522-2-faithilikerun@gmail.com>
 <j5lohqj57qcsjjgqv3n3tm5jv7bjnqlaogg3yvi5ieoto537tk@h5nhmixdnh6p>
In-Reply-To: <j5lohqj57qcsjjgqv3n3tm5jv7bjnqlaogg3yvi5ieoto537tk@h5nhmixdnh6p>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 30 Oct 2023 22:19:29 +0800
Message-ID: <CAAAx-8JZsAGQgV9ao05CS2-jVuDHeEbkT1GWe78+nUDe3OCRMA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] docs/qcow2: add the zoned format feature
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, dlemoal@kernel.org, hare@suse.de, 
 dmitry.fomichev@wdc.com, stefanha@redhat.com, qemu-block@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=faithilikerun@gmail.com; helo=mail-lf1-x12a.google.com
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

Eric Blake <eblake@redhat.com> =E4=BA=8E2023=E5=B9=B410=E6=9C=8830=E6=97=A5=
=E5=91=A8=E4=B8=80 22:05=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Oct 30, 2023 at 08:18:44PM +0800, Sam Li wrote:
> > Add the specs for the zoned format feature of the qcow2 driver.
> > The qcow2 file can be taken as zoned device and passed through by
> > virtio-blk device or NVMe ZNS device to the guest given zoned
> > information.
> >
> > Signed-off-by: Sam Li <faithilikerun@gmail.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  docs/system/qemu-block-drivers.rst.inc | 33 ++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-=
block-drivers.rst.inc
> > index 105cb9679c..4647c5fa29 100644
> > --- a/docs/system/qemu-block-drivers.rst.inc
> > +++ b/docs/system/qemu-block-drivers.rst.inc
> > @@ -172,6 +172,39 @@ This section describes each format and the options=
 that are supported for it.
> >      filename`` to check if the NOCOW flag is set or not (Capital 'C' i=
s
> >      NOCOW flag).
> >
> > +  .. option:: zoned
> > +    1 for host-managed zoned device and 0 for a non-zoned device.
>
> Should this be a bool or enum type, instead of requiring the user to
> know magic numbers?  Is there a potential to add yet another type in
> the future?

Mistake, sorry. Forgot to document this change but the configurations
in the subsequent patch uses enum type.

>
> > +
> > +  .. option:: zone_size
> > +
> > +    The size of a zone in bytes. The device is divided into zones of t=
his
> > +    size with the exception of the last zone, which may be smaller.
> > +
> > +  .. option:: zone_capacity
> > +
> > +    The initial capacity value, in bytes, for all zones. The capacity =
must
> > +    be less than or equal to zone size. If the last zone is smaller, t=
hen
> > +    its capacity is capped.
> > +
> > +    The zone capacity is per zone and may be different between zones i=
n real
> > +    devices. For simplicity, QCow2 sets all zones to the same capacity=
.
>
> Just making sure I understand: One possible setup would be to describe
> a block device with zones of size 1024M but with capacity 1000M (that
> is, the zone reserves 24M capacity for other purposes)?

Yes, it is. The NVMe ZNS drive allows that.

>
> Otherwise, I'm having a hard time seeing when you would ever set a
> capacity different from size.
>
> Are there requirements that one (or both) of these values must be
> powers of 2?  Or is the requirement merely that they must be a
> multiple of 512 bytes (because sub-sector operations are not
> permitted)?  Is there any implicit requirement based on qcow2
> implementation that a zone size/capacity must be a multiple of cluster
> size (other than possibly for the last zone)?

Yes. Linux will only expose zoned devices that have a zone size
that is a power of 2 number of LBAs.

No, the zone size/capacity is not necessarily a multiple of the cluster siz=
e.

>
> > +
> > +  .. option:: zone_nr_conv
> > +
> > +    The number of conventional zones of the zoned device.
> > +
> > +  .. option:: max_open_zones
> > +
> > +    The maximal allowed open zones.
> > +
> > +  .. option:: max_active_zones
> > +
> > +    The limit of the zones with implicit open, explicit open or closed=
 state.
> > +
> > +  .. option:: max_append_sectors
> > +
> > +    The maximal number of 512-byte sectors in a zone append request.
>
> Why is this value in sectors instead of bytes?  I understand that
> drivers may be written with sectors in mind, but any time we mix units
> in the public interface, it gets awkward.  I'd lean towards having
> bytes here, with a requirement that it be a multiple of 512.

Sorry. Same, already changed this in the following patches.

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org
>


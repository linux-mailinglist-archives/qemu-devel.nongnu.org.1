Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CA182A74D
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 06:43:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNnpF-0002ZY-Ae; Thu, 11 Jan 2024 00:41:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rNnpD-0002XG-49
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 00:41:55 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rNnp9-0006v9-9X
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 00:41:54 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5572a9b3420so10150075a12.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 21:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704951704; x=1705556504; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZdbIfSJAdlt6DhsESmtrA2LG4rQUIHeuuY56/cbQH04=;
 b=iWDDnl7s4yhuLVcFjoktakAnf4e2WZlH2/JoAUzdqt+Ov28D4m/5OZgiA89WDZNXeh
 AUEsJqucpEJuCY047Gn8j4C5Rp4lWMAzolBtmjlJHqYpuKgie7LmdVo9LQMPrkEqaHh5
 n5QEIKzRmKySA4wqocXpnSqU8dgNAOkCKHo00jPA3STxNBv3NWO9GCUjyLjgxfHm5p01
 qmw0H5LC4kuJCz8Er22sbLndDTdgSso4EXogt9e4aXNgr/u+SjZTw5Nhh8ANtn92CYX+
 J+ExbYnm4L5pE2LU1/gi1MW/dGt7Dcw/SgTkQ7otgviu72d51MC9LjGcTos9fxFUMYft
 fFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704951704; x=1705556504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZdbIfSJAdlt6DhsESmtrA2LG4rQUIHeuuY56/cbQH04=;
 b=m2MZ0tCqCWvdgJNNBHeo69RP4RJJaPQ60fs0eWZU89LsRss0jyc5sRRqHVxxG3UPgX
 RZpMMhXJr1AmdgB788hDiwJFYg7g9vpFsTmo5tfhMPhtG8Qqm8l2NgaQZaW9PyfU7tai
 +W2MXRK4a0TX0/Kn0sfukKtp7Pd44J4z0vLG0i/jkJkFhDHI0kLcUGOjPmtXcW+68Sp4
 ILZ2JuTXoFC1IFea+aJKJ0/5ODIgf4VuSdcFZrDI+pT08RuPJjYnxSgYIpFff+b15htR
 8nkKHFvDr/VXi/TvdOgeO31DtdCpi6k4bOOHsJ9kR9RezY4f3HLCLB4EK9eVSwc+Q8X4
 veUQ==
X-Gm-Message-State: AOJu0YxC+vbw8epToxcDF1PX6xO8/d3akDyaIOpd7B/ZDEzqPqoA4YSX
 dw7SeE0hTHDpIVqu2WgqjWX/gCBlrpVF70kkrW1ldJyj0pjKnQ==
X-Google-Smtp-Source: AGHT+IHrJNE81t5czPvOv7aVAosLZNAkfxzRF79lqIXDe2XnbY0kgQJzEfht4d9vwbRl4QhpE+MkMkguv9aK+FpZq/g=
X-Received: by 2002:a05:6402:40c6:b0:551:ec48:66ea with SMTP id
 z6-20020a05640240c600b00551ec4866eamr274803edb.30.1704951704437; Wed, 10 Jan
 2024 21:41:44 -0800 (PST)
MIME-Version: 1.0
References: <20231231205804.2366509-1-bryan.zhang@bytedance.com>
 <20231231205804.2366509-4-bryan.zhang@bytedance.com> <87jzon8ryv.fsf@suse.de>
 <CAAYibXgNC1vL1i9M9Sj1J1GS_msxTMJS+B143qFO0pnF4UQGKA@mail.gmail.com>
 <PH7PR11MB5941E2494C523E92DAF57DF7A36B2@PH7PR11MB5941.namprd11.prod.outlook.com>
 <87v883sh8g.fsf@suse.de>
 <PH7PR11MB5941922C2B1900E80D6ACF40A36A2@PH7PR11MB5941.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB5941922C2B1900E80D6ACF40A36A2@PH7PR11MB5941.namprd11.prod.outlook.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Wed, 10 Jan 2024 21:41:33 -0800
Message-ID: <CAAYibXhzafTX=KAp7XckpdiEC2rNgmxqFz1joaHf59YTnMpSMA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 3/5] migration: Introduce unimplemented
 'qatzip' compression method
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: Fabiano Rosas <farosas@suse.de>, Bryan Zhang <bryan.zhang@bytedance.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, 
 "quintela@redhat.com" <quintela@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "berrange@redhat.com" <berrange@redhat.com>, "Zou,
 Nanhai" <nanhai.zou@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Jan 8, 2024 at 6:26=E2=80=AFPM Liu, Yuan1 <yuan1.liu@intel.com> wro=
te:
>
> > -----Original Message-----
> > From: Fabiano Rosas <farosas@suse.de>
> > Sent: Tuesday, January 9, 2024 4:28 AM
> > To: Liu, Yuan1 <yuan1.liu@intel.com>; Hao Xiang <hao.xiang@bytedance.co=
m>
> > Cc: Bryan Zhang <bryan.zhang@bytedance.com>; qemu-devel@nongnu.org;
> > marcandre.lureau@redhat.com; peterx@redhat.com; quintela@redhat.com;
> > peter.maydell@linaro.org; berrange@redhat.com
> > Subject: RE: [External] Re: [PATCH 3/5] migration: Introduce unimplemen=
ted
> > 'qatzip' compression method
> >
> > "Liu, Yuan1" <yuan1.liu@intel.com> writes:
> >
> > >> -----Original Message-----
> > >> From: Hao Xiang <hao.xiang@bytedance.com>
> > >> Sent: Saturday, January 6, 2024 7:53 AM
> > >> To: Fabiano Rosas <farosas@suse.de>
> > >> Cc: Bryan Zhang <bryan.zhang@bytedance.com>; qemu-devel@nongnu.org;
> > >> marcandre.lureau@redhat.com; peterx@redhat.com; quintela@redhat.com;
> > >> peter.maydell@linaro.org; Liu, Yuan1 <yuan1.liu@intel.com>;
> > >> berrange@redhat.com
> > >> Subject: Re: [External] Re: [PATCH 3/5] migration: Introduce
> > >> unimplemented 'qatzip' compression method
> > >>
> > >> On Fri, Jan 5, 2024 at 12:07=E2=80=AFPM Fabiano Rosas <farosas@suse.=
de> wrote:
> > >> >
> > >> > Bryan Zhang <bryan.zhang@bytedance.com> writes:
> > >> >
> > >> > +cc Yuan Liu, Daniel Berrang=C3=A9
> > >> >
> > >> > > Adds support for 'qatzip' as an option for the multifd
> > >> > > compression method parameter, but copy-pastes the no-op logic to
> > >> > > leave the actual methods effectively unimplemented. This is in
> > >> > > preparation of a subsequent commit that will implement actually
> > >> > > using QAT for compression and decompression.
> > >> > >
> > >> > > Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> > >> > > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > >> > > ---
> > >> > >  hw/core/qdev-properties-system.c |  6 ++-
> > >> > >  migration/meson.build            |  1 +
> > >> > >  migration/multifd-qatzip.c       | 81
> > >> ++++++++++++++++++++++++++++++++
> > >> > >  migration/multifd.h              |  1 +
> > >> > >  qapi/migration.json              |  5 +-
> > >> > >  5 files changed, 92 insertions(+), 2 deletions(-)  create mode
> > >> > > 100644 migration/multifd-qatzip.c
> > >> > >
> > >> > > diff --git a/hw/core/qdev-properties-system.c
> > >> > > b/hw/core/qdev-properties-system.c
> > >> > > index 1a396521d5..d8e48dcb0e 100644
> > >> > > --- a/hw/core/qdev-properties-system.c
> > >> > > +++ b/hw/core/qdev-properties-system.c
> > >> > > @@ -658,7 +658,11 @@ const PropertyInfo qdev_prop_fdc_drive_type
> > >> > > =3D { const PropertyInfo qdev_prop_multifd_compression =3D {
> > >> > >      .name =3D "MultiFDCompression",
> > >> > >      .description =3D "multifd_compression values, "
> > >> > > -                   "none/zlib/zstd",
> > >> > > +                   "none/zlib/zstd"
> > >> > > +#ifdef CONFIG_QATZIP
> > >> > > +                   "/qatzip"
> > >> > > +#endif
> > >> > > +                   ,
> > >> > >      .enum_table =3D &MultiFDCompression_lookup,
> > >> > >      .get =3D qdev_propinfo_get_enum,
> > >> > >      .set =3D qdev_propinfo_set_enum, diff --git
> > >> > > a/migration/meson.build b/migration/meson.build index
> > >> > > 92b1cc4297..e20f318379 100644
> > >> > > --- a/migration/meson.build
> > >> > > +++ b/migration/meson.build
> > >> > > @@ -40,6 +40,7 @@ if get_option('live_block_migration').allowed(=
)
> > >> > >    system_ss.add(files('block.c'))  endif
> > >> > >  system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
> > >> > > +system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
> > >> > >
> > >> > >  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
> > >> > >                  if_true: files('ram.c', diff --git
> > >> > > a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c new fi=
le
> > >> > > mode 100644 index 0000000000..1733bbddb7
> > >> > > --- /dev/null
> > >> > > +++ b/migration/multifd-qatzip.c
> > >> > > @@ -0,0 +1,81 @@
> > >> > > +/*
> > >> > > + * Multifd QATzip compression implementation
> > >> > > + *
> > >> > > + * Copyright (c) Bytedance
> > >> > > + *
> > >> > > + * Authors:
> > >> > > + *  Bryan Zhang <bryan.zhang@bytedance.com>
> > >> > > + *  Hao Xiang   <hao.xiang@bytedance.com>
> > >> > > + *
> > >> > > + * This work is licensed under the terms of the GNU GPL, versio=
n 2
> > or
> > >> later.
> > >> > > + * See the COPYING file in the top-level directory.
> > >> > > + */
> > >> > > +
> > >> > > +#include "qemu/osdep.h"
> > >> > > +#include "exec/ramblock.h"
> > >> > > +#include "exec/target_page.h"
> > >> > > +#include "qapi/error.h"
> > >> > > +#include "migration.h"
> > >> > > +#include "options.h"
> > >> > > +#include "multifd.h"
> > >> > > +
> > >> > > +static int qatzip_send_setup(MultiFDSendParams *p, Error **errp=
) {
> > >> > > +    return 0;
> > >> > > +}
> > >> > > +
> > >> > > +static void qatzip_send_cleanup(MultiFDSendParams *p, Error
> > **errp)
> > >> > > +{};
> > >> > > +
> > >> > > +static int qatzip_send_prepare(MultiFDSendParams *p, Error **er=
rp)
> > >> > > +{
> > >> > > +    MultiFDPages_t *pages =3D p->pages;
> > >> > > +
> > >> > > +    for (int i =3D 0; i < p->normal_num; i++) {
> > >> > > +        p->iov[p->iovs_num].iov_base =3D pages->block->host + p=
-
> > >> >normal[i];
> > >> > > +        p->iov[p->iovs_num].iov_len =3D p->page_size;
> > >> > > +        p->iovs_num++;
> > >> > > +    }
> > >> > > +
> > >> > > +    p->next_packet_size =3D p->normal_num * p->page_size;
> > >> > > +    p->flags |=3D MULTIFD_FLAG_NOCOMP;
> > >> > > +    return 0;
> > >> > > +}
> > >> > > +
> > >> > > +static int qatzip_recv_setup(MultiFDRecvParams *p, Error **errp=
) {
> > >> > > +    return 0;
> > >> > > +}
> > >> > > +
> > >> > > +static void qatzip_recv_cleanup(MultiFDRecvParams *p) {};
> > >> > > +
> > >> > > +static int qatzip_recv_pages(MultiFDRecvParams *p, Error **errp=
) {
> > >> > > +    uint32_t flags =3D p->flags & MULTIFD_FLAG_COMPRESSION_MASK=
;
> > >> > > +
> > >> > > +    if (flags !=3D MULTIFD_FLAG_NOCOMP) {
> > >> > > +        error_setg(errp, "multifd %u: flags received %x flags
> > >> expected %x",
> > >> > > +                   p->id, flags, MULTIFD_FLAG_NOCOMP);
> > >> > > +        return -1;
> > >> > > +    }
> > >> > > +    for (int i =3D 0; i < p->normal_num; i++) {
> > >> > > +        p->iov[i].iov_base =3D p->host + p->normal[i];
> > >> > > +        p->iov[i].iov_len =3D p->page_size;
> > >> > > +    }
> > >> > > +    return qio_channel_readv_all(p->c, p->iov, p->normal_num,
> > >> > > +errp); }
> > >> > > +
> > >> > > +static MultiFDMethods multifd_qatzip_ops =3D {
> > >> > > +    .send_setup =3D qatzip_send_setup,
> > >> > > +    .send_cleanup =3D qatzip_send_cleanup,
> > >> > > +    .send_prepare =3D qatzip_send_prepare,
> > >> > > +    .recv_setup =3D qatzip_recv_setup,
> > >> > > +    .recv_cleanup =3D qatzip_recv_cleanup,
> > >> > > +    .recv_pages =3D qatzip_recv_pages };
> > >> > > +
> > >> > > +static void multifd_qatzip_register(void) {
> > >> > > +    multifd_register_ops(MULTIFD_COMPRESSION_QATZIP,
> > >> > > +&multifd_qatzip_ops); }
> > >> > > +
> > >> > > +migration_init(multifd_qatzip_register);
> > >> > > diff --git a/migration/multifd.h b/migration/multifd.h index
> > >> > > a835643b48..5600f7fc82 100644
> > >> > > --- a/migration/multifd.h
> > >> > > +++ b/migration/multifd.h
> > >> > > @@ -33,6 +33,7 @@ int multifd_queue_page(QEMUFile *f, RAMBlock
> > >> > > *block, ram_addr_t offset);  #define MULTIFD_FLAG_NOCOMP (0 << 1=
)
> > >> > > #define MULTIFD_FLAG_ZLIB (1 << 1)  #define MULTIFD_FLAG_ZSTD (2=
 <<
> > >> > > 1)
> > >> > > +#define MULTIFD_FLAG_QATZIP (3 << 1)
> > >> > >
> > >> > >  /* This value needs to be a multiple of qemu_target_page_size()=
 */
> > >> > > #define MULTIFD_PACKET_SIZE (512 * 1024) diff --git
> > >> > > a/qapi/migration.json b/qapi/migration.json index
> > >> > > 6d5a4b0489..e3cc195aed 100644
> > >> > > --- a/qapi/migration.json
> > >> > > +++ b/qapi/migration.json
> > >> > > @@ -625,11 +625,14 @@
> > >> > >  #
> > >> > >  # @zstd: use zstd compression method.
> > >> > >  #
> > >> > > +# @qatzip: use qatzip compression method.
> > >> > > +#
> > >> > >  # Since: 5.0
> > >> > >  ##
> > >> > >  { 'enum': 'MultiFDCompression',
> > >> > >    'data': [ 'none', 'zlib',
> > >> > > -            { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
> > >> > > +            { 'name': 'zstd', 'if': 'CONFIG_ZSTD' },
> > >> > > +            { 'name': 'qatzip', 'if': 'CONFIG_QATZIP'} ] }
> > >> >
> > >> > In another thread adding support to another Intel accelerator (IAA=
)
> > we
> > >> > decided that it was better to select the offloading as an accelera=
tor
> > >> > method to multifd zlib rather than as an entirely new compression
> > >> > format. Take a look at that discussion:
> > >> > https://lore.kernel.org/r/ZTFCnqbbqlmsUkRC@redhat.com
> > >>
> > >> We had some early discussion with Intel folks (probably a different
> > team
> > >> than the one with the above patchset). The understanding at the time=
 is
> > >> that QAT is good at both bulk data compression and decompression. IA=
A
> > is
> > >> good at decompression with smaller data size but compression
> > performance
> > >> is not the best. In multifd, we are compressing up to 128 4k pages a=
t a
> > >> time and potentially this can increase by configuring the packet siz=
e,
> > at
> > >> the time we thought QAT could be a better fit in the multifd live
> > >> migration scenario. We would like to hear more from Intel.
> > >>
> > >> From our benchmark testing, with two QAT devices, we can get deflate
> > >> compression throughout to around 7GB/s with ~160% CPU. That's beatin=
g
> > the
> > >> current software implementation (zlib and zstd) by a lot. We are sti=
ll
> > >> tuning the configuration in QEMU live migration now.
> > >>
> > >> >
> > >> > As I understand it, QAT + QATzip would be compatible with both zli=
b
> > >> > and IAA + QPL, so we'd add another accelerator method like this:
> > >> >
> > >> > https://lore.kernel.org/r/20240103112851.908082-3-yuan1.liu@intel.=
com
> > >> >
> > >>
> > >> I quickly read over the IAA patchset and I saw this:
> > >>
> > >> "However, due to some reasons, QPL is currently not compatible with =
the
> > >> existing Zlib method that Zlib compressed data can be decompressed b=
y
> > QPl
> > >> and vice versa."
> > >>
> > >> The above probably means the current zlib software implementation an=
d
> > IAA
> > >> are not compatible.
> > >>
> > >> For QAT, although, both Intel's QATzip and zlib are internally using
> > >> deflate, QATzip only supports deflate with a 4 byte header, deflate
> > >> wrapped by Gzip header and footer, or deflate wrapped by Intel=C2=AE=
 QAT
> > >> Gzip* extension header and footer. None of the headers can be
> > recognized
> > >> by zlib software implementation is my understanding. So if we want t=
o
> > make
> > >> them compatible with zlib, the QATzip library needs to support that.
> > >
> > > The QPL library currently cannot support the Z_SYNC_FLULSH operation =
of
> > zlib steaming.
> > > This is the reason why it is not compatible with zlib.
> > >
> >
> > I had understood from previous discussion that we'd be able to at least
> > support compression with QPL and decompression with the existing
> > zlib-based code. Is that not correct? I was about to suggest
> > experimenting with the window size in the existing code to hopefully
> > solve the 4kb window size issue. If there are other limitations, then
> > that will not be enough.
> >
> > Also, can you point to the source of that statement about Z_SYNC_FLUSH,
> > I couldn't find more information about it in the documentation.
>
> static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
> {
>     struct zlib_data *z =3D p->data;
>     z_stream *zs =3D &z->zs;
>     =E2=80=A6
>     for (i =3D 0; i < p->normal_num; i++) {
>         uint32_t available =3D z->zbuff_len - out_size;
>         int flush =3D Z_NO_FLUSH;
>
>         if (i =3D=3D p->normal_num - 1) {
>             flush =3D Z_SYNC_FLUSH;
>         }
> If I understand correctly, the current implementation of multifd zlib tre=
ats each multifd thread as a separate stream. This implementation adds zlib=
 headers and footers only to the beginning and end of the data, and the dat=
a transmitted in between does not require headers and footers.

zlib_send_prepare() is just calling the deflate() repeatedly in a
loop. While compressing the last page, it sets the flag Z_SYNC_FLUSH,
which should dump all pending output to the buffer.

"This implementation adds zlib headers and footers only to the
beginning and end of the data,"
^ You mean putting a header/footer per multifd packet, correct?

>
> The current implementation for IAA supports compressing data indicated by=
 p->normal_num as a single stream. Each compressed data segment has zlib he=
aders and footers. Since Z_SYNC_FLUSH is not supported, this means IAA has =
to complete the compression for a stream at once and cannot output parts of=
 a stream in advance. Therefore, the current IAA is not compatible with exi=
sting zlib. Currently, it seems that the QAT implementation follows a simil=
ar approach.

"Since Z_SYNC_FLUSH is not supported, this means IAA has to complete
the compression for a stream at once and cannot output parts of a
stream in advance."
Does IAA's deflate compression put a header/footer per page? Or per
multifd packet?

>
> Regarding the reference to Z_SYNC_FLUSH, you can find it at https://www.z=
lib.net/manual.html:
> =E2=80=9CIf the parameter flush is set to Z_SYNC_FLUSH, all pending outpu=
t is flushed to the output buffer and the output is aligned on a byte bound=
ary, so that the decompressor can get all input data available so far. (In =
particular avail_in is zero after the call if enough output space has been =
provided before the call.) Flushing may degrade compression for some compre=
ssion algorithms and so it should be used only when necessary. This complet=
es the current deflate block and follows it with an empty stored block that=
 is three bits plus filler bits to the next byte, followed by four bytes (0=
0 00 ff ff).=E2=80=9D
>
> Based on the information above, I suggest the following options:
>
> 1. Modify multifd zlib to perform stream compression each time with p->no=
rmal_num pages. If this modification makes IAA compatible with zlib, I will=
 implement it in the next version as per https://lore.kernel.org/all/202401=
03112851.908082-4-yuan1.liu@intel.com/T/ and provide performance data. We w=
ill also verify the feasibility with QAT.
>
> 2. Use zlib compression without stream compression, meaning each page is =
independently compressed. The advantage is that accelerators can concurrent=
ly process more pages, and the current IAA and QAT can both be compatible. =
The downside is a loss in compression ratio, and the length of the data aft=
er compressing each page needs to be added to MultiFDPacket_t. If future co=
mpression functionality considers support only on accelerators, the compres=
sion ratio can be improved through compression levels or other features wit=
hout additional host CPU overhead.
>

We noticed a pretty significant performance difference in QAT deflate
while using the streaming version VS the non-streaming version. The
non-streaming version has better performance.
Sounds like the easiest way to have zlib/IAA/QAT to be capable of
compressing/decompressing interchangeably is to set the Z_SYNC_FLUSH
flag on all deflate() calls in zlib_send_prepare(). And in my opinion,
it is worth the trade-off. If my hardware doesn't have accelerators
and I want pure software based compression, I would choose zstd over
zlib.

> Additionally, the default window size is set to 4K, which should effectiv=
ely support IAA hardware.
>
> > >> > All that, of course, assuming we even want to support both
> > >> > accelerators. They're addressing the same problem after all. I won=
der
> > >> > how we'd choose a precedence, since both seem to be present in the
> > >> > same processor family.
> > >> >
> > >> >
> > >>
> > >> That's an interesting question :-) I think overall performance
> > (throughput
> > >> and CPU overhead) should both be considered. IAA and QAT accelerator=
s
> > >> don't present on all systems. We Bytedance choose to have both on ou=
r
> > >> platform when purchasing from Intel.


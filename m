Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 787D782A7B0
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 07:41:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNojQ-0003Sa-6l; Thu, 11 Jan 2024 01:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rNojM-0003Ql-S9
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 01:39:56 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rNojG-00069s-Q8
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 01:39:55 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-55818b733f7so2922394a12.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 22:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704955186; x=1705559986; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PAByMzaKyfhliH3fkwd0xGJsF+a5w5y2+pC/RwWJfJQ=;
 b=DfpXSyXFY8AGN8ZcdxDTLLj0i9zgFTUrOYB5kvSnHs5hEznFrOoefAgBaMfbH9AZWE
 XSYOw/1LMs6gFlA5u2iSD+JtzqZDC5Qbii/Aemr69AcBEAUi/z+cDWRjhjPi75u7kkSr
 8JN+jfTS+JbXMQQ6TEBIaVGisEj2k7rtmEVjo0biZ+/5o6BcmaGxwHkRd0YYVwK04jkR
 5h1hFWFbIqkYOS1nWXHCyR48lsX4AO5qHD2UkGtL5GRD+zUZ6Zy1XrV8cWxh5FZucTfG
 wKQ6cuud65ujLcQLswUeGr0h2ok+4DIPPSkPUtgmhyNNfEDbK4lGnPAMKgwqiOdcb0lD
 77/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704955186; x=1705559986;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PAByMzaKyfhliH3fkwd0xGJsF+a5w5y2+pC/RwWJfJQ=;
 b=fdPHjrCY/ogo6ptTie972R0yP7FkLF5Il3FfVTJED3m2QteVxzFN7Ss6ivEG970N1o
 CvmLzOVQBS27M7YtGDjoYUWN2f8K8r0XnSVezyM5offHOsYswrCe9kKTE+LlERKlccyI
 ZLr9odL5+1/ZJcQ6cpSwGS29sxM0Vg0qeY55EhTw1Np4tnL5WD8eXsNEiDnBg2AlmEer
 8HOYCnt2BesvdvF9JNA2zHwarIYt9vOh3TxNl5yrjU/pg3LyfeLzo/j/NGstFriQH2EN
 /4bBQN99Fzw3d0uITrAFSUk7nWKPulMsrUs2489CdTZeTtRZmXRwSFQxx9DKLHA9osqv
 nd3g==
X-Gm-Message-State: AOJu0YycDmZUWbabMpY8by1ItuzCJKJN/LQt1nsE5OeHZcOFam/uiEOY
 PP26Zxv7pyKKdI+KWKVOMOgj/32H7JNJHeETehm5zc2dzoBtvw==
X-Google-Smtp-Source: AGHT+IGdcOea5/GEtXW/Xz2l8M8EuFgQB5PNJ+UwE9vIzHX6qCsnW2ckijt8akbMHD6mnHhmIu8s9E3tshTyE7wusQs=
X-Received: by 2002:aa7:d989:0:b0:557:7871:67f7 with SMTP id
 u9-20020aa7d989000000b00557787167f7mr299905eds.26.1704955186117; Wed, 10 Jan
 2024 22:39:46 -0800 (PST)
MIME-Version: 1.0
References: <20231231205804.2366509-1-bryan.zhang@bytedance.com>
 <20231231205804.2366509-4-bryan.zhang@bytedance.com> <87jzon8ryv.fsf@suse.de>
 <CAAYibXgNC1vL1i9M9Sj1J1GS_msxTMJS+B143qFO0pnF4UQGKA@mail.gmail.com>
 <PH7PR11MB5941E2494C523E92DAF57DF7A36B2@PH7PR11MB5941.namprd11.prod.outlook.com>
 <87v883sh8g.fsf@suse.de>
In-Reply-To: <87v883sh8g.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Wed, 10 Jan 2024 22:39:34 -0800
Message-ID: <CAAYibXjD5kyDrqpo5FyBvXGALN0vD1Qh+S90amtoy7=Zce0FrQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 3/5] migration: Introduce unimplemented
 'qatzip' compression method
To: Fabiano Rosas <farosas@suse.de>
Cc: "Liu, Yuan1" <yuan1.liu@intel.com>, Bryan Zhang <bryan.zhang@bytedance.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, 
 "quintela@redhat.com" <quintela@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "berrange@redhat.com" <berrange@redhat.com>
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

On Mon, Jan 8, 2024 at 12:28=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> "Liu, Yuan1" <yuan1.liu@intel.com> writes:
>
> >> -----Original Message-----
> >> From: Hao Xiang <hao.xiang@bytedance.com>
> >> Sent: Saturday, January 6, 2024 7:53 AM
> >> To: Fabiano Rosas <farosas@suse.de>
> >> Cc: Bryan Zhang <bryan.zhang@bytedance.com>; qemu-devel@nongnu.org;
> >> marcandre.lureau@redhat.com; peterx@redhat.com; quintela@redhat.com;
> >> peter.maydell@linaro.org; Liu, Yuan1 <yuan1.liu@intel.com>;
> >> berrange@redhat.com
> >> Subject: Re: [External] Re: [PATCH 3/5] migration: Introduce unimpleme=
nted
> >> 'qatzip' compression method
> >>
> >> On Fri, Jan 5, 2024 at 12:07=E2=80=AFPM Fabiano Rosas <farosas@suse.de=
> wrote:
> >> >
> >> > Bryan Zhang <bryan.zhang@bytedance.com> writes:
> >> >
> >> > +cc Yuan Liu, Daniel Berrang=C3=A9
> >> >
> >> > > Adds support for 'qatzip' as an option for the multifd compression
> >> > > method parameter, but copy-pastes the no-op logic to leave the
> >> > > actual methods effectively unimplemented. This is in preparation o=
f
> >> > > a subsequent commit that will implement actually using QAT for
> >> > > compression and decompression.
> >> > >
> >> > > Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> >> > > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> >> > > ---
> >> > >  hw/core/qdev-properties-system.c |  6 ++-
> >> > >  migration/meson.build            |  1 +
> >> > >  migration/multifd-qatzip.c       | 81
> >> ++++++++++++++++++++++++++++++++
> >> > >  migration/multifd.h              |  1 +
> >> > >  qapi/migration.json              |  5 +-
> >> > >  5 files changed, 92 insertions(+), 2 deletions(-)  create mode
> >> > > 100644 migration/multifd-qatzip.c
> >> > >
> >> > > diff --git a/hw/core/qdev-properties-system.c
> >> > > b/hw/core/qdev-properties-system.c
> >> > > index 1a396521d5..d8e48dcb0e 100644
> >> > > --- a/hw/core/qdev-properties-system.c
> >> > > +++ b/hw/core/qdev-properties-system.c
> >> > > @@ -658,7 +658,11 @@ const PropertyInfo qdev_prop_fdc_drive_type =
=3D {
> >> > > const PropertyInfo qdev_prop_multifd_compression =3D {
> >> > >      .name =3D "MultiFDCompression",
> >> > >      .description =3D "multifd_compression values, "
> >> > > -                   "none/zlib/zstd",
> >> > > +                   "none/zlib/zstd"
> >> > > +#ifdef CONFIG_QATZIP
> >> > > +                   "/qatzip"
> >> > > +#endif
> >> > > +                   ,
> >> > >      .enum_table =3D &MultiFDCompression_lookup,
> >> > >      .get =3D qdev_propinfo_get_enum,
> >> > >      .set =3D qdev_propinfo_set_enum,
> >> > > diff --git a/migration/meson.build b/migration/meson.build index
> >> > > 92b1cc4297..e20f318379 100644
> >> > > --- a/migration/meson.build
> >> > > +++ b/migration/meson.build
> >> > > @@ -40,6 +40,7 @@ if get_option('live_block_migration').allowed()
> >> > >    system_ss.add(files('block.c'))
> >> > >  endif
> >> > >  system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
> >> > > +system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
> >> > >
> >> > >  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
> >> > >                  if_true: files('ram.c', diff --git
> >> > > a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c new file
> >> > > mode 100644 index 0000000000..1733bbddb7
> >> > > --- /dev/null
> >> > > +++ b/migration/multifd-qatzip.c
> >> > > @@ -0,0 +1,81 @@
> >> > > +/*
> >> > > + * Multifd QATzip compression implementation
> >> > > + *
> >> > > + * Copyright (c) Bytedance
> >> > > + *
> >> > > + * Authors:
> >> > > + *  Bryan Zhang <bryan.zhang@bytedance.com>
> >> > > + *  Hao Xiang   <hao.xiang@bytedance.com>
> >> > > + *
> >> > > + * This work is licensed under the terms of the GNU GPL, version =
2 or
> >> later.
> >> > > + * See the COPYING file in the top-level directory.
> >> > > + */
> >> > > +
> >> > > +#include "qemu/osdep.h"
> >> > > +#include "exec/ramblock.h"
> >> > > +#include "exec/target_page.h"
> >> > > +#include "qapi/error.h"
> >> > > +#include "migration.h"
> >> > > +#include "options.h"
> >> > > +#include "multifd.h"
> >> > > +
> >> > > +static int qatzip_send_setup(MultiFDSendParams *p, Error **errp) =
{
> >> > > +    return 0;
> >> > > +}
> >> > > +
> >> > > +static void qatzip_send_cleanup(MultiFDSendParams *p, Error **err=
p)
> >> > > +{};
> >> > > +
> >> > > +static int qatzip_send_prepare(MultiFDSendParams *p, Error **errp=
)
> >> > > +{
> >> > > +    MultiFDPages_t *pages =3D p->pages;
> >> > > +
> >> > > +    for (int i =3D 0; i < p->normal_num; i++) {
> >> > > +        p->iov[p->iovs_num].iov_base =3D pages->block->host + p-
> >> >normal[i];
> >> > > +        p->iov[p->iovs_num].iov_len =3D p->page_size;
> >> > > +        p->iovs_num++;
> >> > > +    }
> >> > > +
> >> > > +    p->next_packet_size =3D p->normal_num * p->page_size;
> >> > > +    p->flags |=3D MULTIFD_FLAG_NOCOMP;
> >> > > +    return 0;
> >> > > +}
> >> > > +
> >> > > +static int qatzip_recv_setup(MultiFDRecvParams *p, Error **errp) =
{
> >> > > +    return 0;
> >> > > +}
> >> > > +
> >> > > +static void qatzip_recv_cleanup(MultiFDRecvParams *p) {};
> >> > > +
> >> > > +static int qatzip_recv_pages(MultiFDRecvParams *p, Error **errp) =
{
> >> > > +    uint32_t flags =3D p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
> >> > > +
> >> > > +    if (flags !=3D MULTIFD_FLAG_NOCOMP) {
> >> > > +        error_setg(errp, "multifd %u: flags received %x flags
> >> expected %x",
> >> > > +                   p->id, flags, MULTIFD_FLAG_NOCOMP);
> >> > > +        return -1;
> >> > > +    }
> >> > > +    for (int i =3D 0; i < p->normal_num; i++) {
> >> > > +        p->iov[i].iov_base =3D p->host + p->normal[i];
> >> > > +        p->iov[i].iov_len =3D p->page_size;
> >> > > +    }
> >> > > +    return qio_channel_readv_all(p->c, p->iov, p->normal_num,
> >> > > +errp); }
> >> > > +
> >> > > +static MultiFDMethods multifd_qatzip_ops =3D {
> >> > > +    .send_setup =3D qatzip_send_setup,
> >> > > +    .send_cleanup =3D qatzip_send_cleanup,
> >> > > +    .send_prepare =3D qatzip_send_prepare,
> >> > > +    .recv_setup =3D qatzip_recv_setup,
> >> > > +    .recv_cleanup =3D qatzip_recv_cleanup,
> >> > > +    .recv_pages =3D qatzip_recv_pages };
> >> > > +
> >> > > +static void multifd_qatzip_register(void) {
> >> > > +    multifd_register_ops(MULTIFD_COMPRESSION_QATZIP,
> >> > > +&multifd_qatzip_ops); }
> >> > > +
> >> > > +migration_init(multifd_qatzip_register);
> >> > > diff --git a/migration/multifd.h b/migration/multifd.h index
> >> > > a835643b48..5600f7fc82 100644
> >> > > --- a/migration/multifd.h
> >> > > +++ b/migration/multifd.h
> >> > > @@ -33,6 +33,7 @@ int multifd_queue_page(QEMUFile *f, RAMBlock
> >> > > *block, ram_addr_t offset);  #define MULTIFD_FLAG_NOCOMP (0 << 1)
> >> > > #define MULTIFD_FLAG_ZLIB (1 << 1)  #define MULTIFD_FLAG_ZSTD (2 <=
<
> >> > > 1)
> >> > > +#define MULTIFD_FLAG_QATZIP (3 << 1)
> >> > >
> >> > >  /* This value needs to be a multiple of qemu_target_page_size() *=
/
> >> > > #define MULTIFD_PACKET_SIZE (512 * 1024) diff --git
> >> > > a/qapi/migration.json b/qapi/migration.json index
> >> > > 6d5a4b0489..e3cc195aed 100644
> >> > > --- a/qapi/migration.json
> >> > > +++ b/qapi/migration.json
> >> > > @@ -625,11 +625,14 @@
> >> > >  #
> >> > >  # @zstd: use zstd compression method.
> >> > >  #
> >> > > +# @qatzip: use qatzip compression method.
> >> > > +#
> >> > >  # Since: 5.0
> >> > >  ##
> >> > >  { 'enum': 'MultiFDCompression',
> >> > >    'data': [ 'none', 'zlib',
> >> > > -            { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
> >> > > +            { 'name': 'zstd', 'if': 'CONFIG_ZSTD' },
> >> > > +            { 'name': 'qatzip', 'if': 'CONFIG_QATZIP'} ] }
> >> >
> >> > In another thread adding support to another Intel accelerator (IAA) =
we
> >> > decided that it was better to select the offloading as an accelerato=
r
> >> > method to multifd zlib rather than as an entirely new compression
> >> > format. Take a look at that discussion:
> >> > https://lore.kernel.org/r/ZTFCnqbbqlmsUkRC@redhat.com
> >>
> >> We had some early discussion with Intel folks (probably a different te=
am
> >> than the one with the above patchset). The understanding at the time i=
s
> >> that QAT is good at both bulk data compression and decompression. IAA =
is
> >> good at decompression with smaller data size but compression performan=
ce
> >> is not the best. In multifd, we are compressing up to 128 4k pages at =
a
> >> time and potentially this can increase by configuring the packet size,=
 at
> >> the time we thought QAT could be a better fit in the multifd live
> >> migration scenario. We would like to hear more from Intel.
> >>
> >> From our benchmark testing, with two QAT devices, we can get deflate
> >> compression throughout to around 7GB/s with ~160% CPU. That's beating =
the
> >> current software implementation (zlib and zstd) by a lot. We are still
> >> tuning the configuration in QEMU live migration now.
> >>
> >> >
> >> > As I understand it, QAT + QATzip would be compatible with both zlib
> >> > and IAA + QPL, so we'd add another accelerator method like this:
> >> >
> >> > https://lore.kernel.org/r/20240103112851.908082-3-yuan1.liu@intel.co=
m
> >> >
> >>
> >> I quickly read over the IAA patchset and I saw this:
> >>
> >> "However, due to some reasons, QPL is currently not compatible with th=
e
> >> existing Zlib method that Zlib compressed data can be decompressed by =
QPl
> >> and vice versa."
> >>
> >> The above probably means the current zlib software implementation and =
IAA
> >> are not compatible.
> >>
> >> For QAT, although, both Intel's QATzip and zlib are internally using
> >> deflate, QATzip only supports deflate with a 4 byte header, deflate
> >> wrapped by Gzip header and footer, or deflate wrapped by Intel=C2=AE Q=
AT
> >> Gzip* extension header and footer. None of the headers can be recogniz=
ed
> >> by zlib software implementation is my understanding. So if we want to =
make
> >> them compatible with zlib, the QATzip library needs to support that.
> >
> > The QPL library currently cannot support the Z_SYNC_FLULSH operation of=
 zlib steaming.
> > This is the reason why it is not compatible with zlib.
> >

When doing the QPL compression, if we set both QPL_FLAG_FIRST and
QPL_FLAG_LAST flags and run a single job for all pages in a multifd
packet, would it generate the same format as Z_SYNC_FLULSH in the
current zlib-based code?

>
> I had understood from previous discussion that we'd be able to at least
> support compression with QPL and decompression with the existing
> zlib-based code. Is that not correct? I was about to suggest
> experimenting with the window size in the existing code to hopefully
> solve the 4kb window size issue. If there are other limitations, then
> that will not be enough.

>
> Also, can you point to the source of that statement about Z_SYNC_FLUSH,
> I couldn't find more information about it in the documentation.
>
> >> > All that, of course, assuming we even want to support both
> >> > accelerators. They're addressing the same problem after all. I wonde=
r
> >> > how we'd choose a precedence, since both seem to be present in the
> >> > same processor family.
> >> >
> >> >
> >>
> >> That's an interesting question :-) I think overall performance (throug=
hput
> >> and CPU overhead) should both be considered. IAA and QAT accelerators
> >> don't present on all systems. We Bytedance choose to have both on our
> >> platform when purchasing from Intel.


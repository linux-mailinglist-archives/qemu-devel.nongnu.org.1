Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8C9825E88
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 07:33:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rM0Dl-0007Zk-26; Sat, 06 Jan 2024 01:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rM0Di-0007ZI-JL
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 01:31:46 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rM0Df-0008TL-Gi
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 01:31:46 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-555144cd330so272628a12.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 22:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704522699; x=1705127499; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YizGA5nyRb+WVCm/VzvxYivjeD7z+YLJbt/VePjH97Y=;
 b=VixIoJnS3HfhM0S0S7bKtp4z99GkatorOIxtGP6I4Ub7mbrzDPCY03XXPaRsb1MG0u
 MNexUH8XEIZvzBgIqiwLOAv4Bnz8JBwGjia+qLty3fT83vEQDIak8ULRAFDOiINw8Wi7
 ncfukhUjsLJEJzm24Zzm/qtpUr4XrsIkdWsfebLfrn1LdxeRO7g1bBA0FGJkJbwk9Qwa
 foo646zymHGMn44n27nO/FCuNxGD3u+FOxKPt09XUZorO5ZDzr2IYUvxtc/d32DmIJgr
 cvCagaNXHnXpOcuCe5T0tGMcNbAfy8Fjm6RVactLCGGIf8q+ivxpeRQ8JmQwJj+xy0cv
 +ErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704522699; x=1705127499;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YizGA5nyRb+WVCm/VzvxYivjeD7z+YLJbt/VePjH97Y=;
 b=fWBH/WejsjaY+QSXJAAp67dby+74a+cjiVMuG9E6wjis90hQvEsJYWThj6fv7W4EhD
 xBnynnDt0pWARlYRAxqid/NaEQSegk/iXcS4Kd0uk2IeLm4nd5ZbxXo3jvrmONpPVs0u
 b29++9p+ZQbycLeUIMZ5OfDXE0PYWHZ7I29MJTPDlJRngtxs6LX5dbKmvDpGAvb70S0B
 HJdE09v3X42eidLlAvu655vpvRl2FxfP0r2f79dHt3Pg+DFX7+6p3BW2xDCBeeowgEuz
 y4q8egXe1Ex9ngdFlVNKzQU3fpiazQ0XK/CZud78J8soJHWT32hEw2hEm5TOZplUbswg
 ap2w==
X-Gm-Message-State: AOJu0YxQxk84dWGK0f2VLAGwHxQAyCFwUM4c/5Pe6Q6i662fOkovIPk+
 zm0KIz1FfS3k+NuJ2MaHPYZ3UmGHt0MqueDkuGEBiftCBiJ9tg==
X-Google-Smtp-Source: AGHT+IH6/3Bwk7jtbkMdXqLBrCyCJgnnHN3XBosZEhLmlm87YhD6V1TcnBRR6qvOX6MtWlshbwPw23CEdjNA7HoybIQ=
X-Received: by 2002:a50:d7d0:0:b0:554:4dce:9d47 with SMTP id
 m16-20020a50d7d0000000b005544dce9d47mr224467edj.14.1704522699324; Fri, 05 Jan
 2024 22:31:39 -0800 (PST)
MIME-Version: 1.0
References: <20231231205804.2366509-1-bryan.zhang@bytedance.com>
 <20231231205804.2366509-4-bryan.zhang@bytedance.com> <87jzon8ryv.fsf@suse.de>
 <CAAYibXgNC1vL1i9M9Sj1J1GS_msxTMJS+B143qFO0pnF4UQGKA@mail.gmail.com>
In-Reply-To: <CAAYibXgNC1vL1i9M9Sj1J1GS_msxTMJS+B143qFO0pnF4UQGKA@mail.gmail.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Fri, 5 Jan 2024 22:31:28 -0800
Message-ID: <CAAYibXgE+62nqDE1vZqXrSRFJK5J74CdBT66GVq=G0RwzJGHpQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 3/5] migration: Introduce unimplemented
 'qatzip' compression method
To: Fabiano Rosas <farosas@suse.de>
Cc: Bryan Zhang <bryan.zhang@bytedance.com>, qemu-devel@nongnu.org, 
 marcandre.lureau@redhat.com, peterx@redhat.com, quintela@redhat.com, 
 peter.maydell@linaro.org, yuan1.liu@intel.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x530.google.com
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

On Fri, Jan 5, 2024 at 3:52=E2=80=AFPM Hao Xiang <hao.xiang@bytedance.com> =
wrote:
>
> On Fri, Jan 5, 2024 at 12:07=E2=80=AFPM Fabiano Rosas <farosas@suse.de> w=
rote:
> >
> > Bryan Zhang <bryan.zhang@bytedance.com> writes:
> >
> > +cc Yuan Liu, Daniel Berrang=C3=A9
> >
> > > Adds support for 'qatzip' as an option for the multifd compression
> > > method parameter, but copy-pastes the no-op logic to leave the actual
> > > methods effectively unimplemented. This is in preparation of a
> > > subsequent commit that will implement actually using QAT for compress=
ion
> > > and decompression.
> > >
> > > Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> > > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > > ---
> > >  hw/core/qdev-properties-system.c |  6 ++-
> > >  migration/meson.build            |  1 +
> > >  migration/multifd-qatzip.c       | 81 ++++++++++++++++++++++++++++++=
++
> > >  migration/multifd.h              |  1 +
> > >  qapi/migration.json              |  5 +-
> > >  5 files changed, 92 insertions(+), 2 deletions(-)
> > >  create mode 100644 migration/multifd-qatzip.c
> > >
> > > diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properti=
es-system.c
> > > index 1a396521d5..d8e48dcb0e 100644
> > > --- a/hw/core/qdev-properties-system.c
> > > +++ b/hw/core/qdev-properties-system.c
> > > @@ -658,7 +658,11 @@ const PropertyInfo qdev_prop_fdc_drive_type =3D =
{
> > >  const PropertyInfo qdev_prop_multifd_compression =3D {
> > >      .name =3D "MultiFDCompression",
> > >      .description =3D "multifd_compression values, "
> > > -                   "none/zlib/zstd",
> > > +                   "none/zlib/zstd"
> > > +#ifdef CONFIG_QATZIP
> > > +                   "/qatzip"
> > > +#endif
> > > +                   ,
> > >      .enum_table =3D &MultiFDCompression_lookup,
> > >      .get =3D qdev_propinfo_get_enum,
> > >      .set =3D qdev_propinfo_set_enum,
> > > diff --git a/migration/meson.build b/migration/meson.build
> > > index 92b1cc4297..e20f318379 100644
> > > --- a/migration/meson.build
> > > +++ b/migration/meson.build
> > > @@ -40,6 +40,7 @@ if get_option('live_block_migration').allowed()
> > >    system_ss.add(files('block.c'))
> > >  endif
> > >  system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
> > > +system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
> > >
> > >  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
> > >                  if_true: files('ram.c',
> > > diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
> > > new file mode 100644
> > > index 0000000000..1733bbddb7
> > > --- /dev/null
> > > +++ b/migration/multifd-qatzip.c
> > > @@ -0,0 +1,81 @@
> > > +/*
> > > + * Multifd QATzip compression implementation
> > > + *
> > > + * Copyright (c) Bytedance
> > > + *
> > > + * Authors:
> > > + *  Bryan Zhang <bryan.zhang@bytedance.com>
> > > + *  Hao Xiang   <hao.xiang@bytedance.com>
> > > + *
> > > + * This work is licensed under the terms of the GNU GPL, version 2 o=
r later.
> > > + * See the COPYING file in the top-level directory.
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "exec/ramblock.h"
> > > +#include "exec/target_page.h"
> > > +#include "qapi/error.h"
> > > +#include "migration.h"
> > > +#include "options.h"
> > > +#include "multifd.h"
> > > +
> > > +static int qatzip_send_setup(MultiFDSendParams *p, Error **errp)
> > > +{
> > > +    return 0;
> > > +}
> > > +
> > > +static void qatzip_send_cleanup(MultiFDSendParams *p, Error **errp) =
{};
> > > +
> > > +static int qatzip_send_prepare(MultiFDSendParams *p, Error **errp)
> > > +{
> > > +    MultiFDPages_t *pages =3D p->pages;
> > > +
> > > +    for (int i =3D 0; i < p->normal_num; i++) {
> > > +        p->iov[p->iovs_num].iov_base =3D pages->block->host + p->nor=
mal[i];
> > > +        p->iov[p->iovs_num].iov_len =3D p->page_size;
> > > +        p->iovs_num++;
> > > +    }
> > > +
> > > +    p->next_packet_size =3D p->normal_num * p->page_size;
> > > +    p->flags |=3D MULTIFD_FLAG_NOCOMP;
> > > +    return 0;
> > > +}
> > > +
> > > +static int qatzip_recv_setup(MultiFDRecvParams *p, Error **errp)
> > > +{
> > > +    return 0;
> > > +}
> > > +
> > > +static void qatzip_recv_cleanup(MultiFDRecvParams *p) {};
> > > +
> > > +static int qatzip_recv_pages(MultiFDRecvParams *p, Error **errp)
> > > +{
> > > +    uint32_t flags =3D p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
> > > +
> > > +    if (flags !=3D MULTIFD_FLAG_NOCOMP) {
> > > +        error_setg(errp, "multifd %u: flags received %x flags expect=
ed %x",
> > > +                   p->id, flags, MULTIFD_FLAG_NOCOMP);
> > > +        return -1;
> > > +    }
> > > +    for (int i =3D 0; i < p->normal_num; i++) {
> > > +        p->iov[i].iov_base =3D p->host + p->normal[i];
> > > +        p->iov[i].iov_len =3D p->page_size;
> > > +    }
> > > +    return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
> > > +}
> > > +
> > > +static MultiFDMethods multifd_qatzip_ops =3D {
> > > +    .send_setup =3D qatzip_send_setup,
> > > +    .send_cleanup =3D qatzip_send_cleanup,
> > > +    .send_prepare =3D qatzip_send_prepare,
> > > +    .recv_setup =3D qatzip_recv_setup,
> > > +    .recv_cleanup =3D qatzip_recv_cleanup,
> > > +    .recv_pages =3D qatzip_recv_pages
> > > +};
> > > +
> > > +static void multifd_qatzip_register(void)
> > > +{
> > > +    multifd_register_ops(MULTIFD_COMPRESSION_QATZIP, &multifd_qatzip=
_ops);
> > > +}
> > > +
> > > +migration_init(multifd_qatzip_register);
> > > diff --git a/migration/multifd.h b/migration/multifd.h
> > > index a835643b48..5600f7fc82 100644
> > > --- a/migration/multifd.h
> > > +++ b/migration/multifd.h
> > > @@ -33,6 +33,7 @@ int multifd_queue_page(QEMUFile *f, RAMBlock *block=
, ram_addr_t offset);
> > >  #define MULTIFD_FLAG_NOCOMP (0 << 1)
> > >  #define MULTIFD_FLAG_ZLIB (1 << 1)
> > >  #define MULTIFD_FLAG_ZSTD (2 << 1)
> > > +#define MULTIFD_FLAG_QATZIP (3 << 1)
> > >
> > >  /* This value needs to be a multiple of qemu_target_page_size() */
> > >  #define MULTIFD_PACKET_SIZE (512 * 1024)
> > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > index 6d5a4b0489..e3cc195aed 100644
> > > --- a/qapi/migration.json
> > > +++ b/qapi/migration.json
> > > @@ -625,11 +625,14 @@
> > >  #
> > >  # @zstd: use zstd compression method.
> > >  #
> > > +# @qatzip: use qatzip compression method.
> > > +#
> > >  # Since: 5.0
> > >  ##
> > >  { 'enum': 'MultiFDCompression',
> > >    'data': [ 'none', 'zlib',
> > > -            { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
> > > +            { 'name': 'zstd', 'if': 'CONFIG_ZSTD' },
> > > +            { 'name': 'qatzip', 'if': 'CONFIG_QATZIP'} ] }
> >
> > In another thread adding support to another Intel accelerator (IAA) we
> > decided that it was better to select the offloading as an accelerator
> > method to multifd zlib rather than as an entirely new compression
> > format. Take a look at that discussion:
> > https://lore.kernel.org/r/ZTFCnqbbqlmsUkRC@redhat.com
>
> We had some early discussion with Intel folks (probably a different
> team than the one with the above patchset). The understanding at the
> time is that QAT is good at both bulk data compression and
> decompression. IAA is good at decompression with smaller data size but
> compression performance is not the best. In multifd, we are
> compressing up to 128 4k pages at a time and potentially this can
> increase by configuring the packet size, at the time we thought QAT
> could be a better fit in the multifd live migration scenario. We would
> like to hear more from Intel.
>
> From our benchmark testing, with two QAT devices, we can get deflate
> compression throughout to around 7GB/s with ~160% CPU. That's beating
> the current software implementation (zlib and zstd) by a lot. We are
> still tuning the configuration in QEMU live migration now.
>
> >
> > As I understand it, QAT + QATzip would be compatible with both zlib and
> > IAA + QPL, so we'd add another accelerator method like this:
> >
> > https://lore.kernel.org/r/20240103112851.908082-3-yuan1.liu@intel.com
> >
>
> I quickly read over the IAA patchset and I saw this:
>
> "However, due to some reasons, QPL is currently
> not compatible with the existing Zlib method that Zlib compressed data
> can be decompressed by QPl and vice versa."
>
> The above probably means the current zlib software implementation and
> IAA are not compatible.
>
> For QAT, although, both Intel's QATzip and zlib are internally using
> deflate, QATzip only supports deflate with a 4 byte header, deflate
> wrapped by Gzip header and footer, or deflate wrapped by Intel=C2=AE QAT
> Gzip* extension header and footer. None of the headers can be
> recognized by zlib software implementation is my understanding. So if
> we want to make them compatible with zlib, the QATzip library needs to
> support that.

I took a closer look at Intel's documentation here
https://github.com/intel/QATzip
QATzip does have a compression format QZ_DEFLATE_RAW, which uses the
deflate format but no header at all. This looks like the same as what
QEMU's current zlib implementation does - using the raw deflate
format. I can have a quick test to confirm that. Meanwhile, the
documentation mentioned that if using the raw deflate format,
decompression cannot be offloaded by QAT hardware. So there is a
trade-off here if we want to avoid creating a new compression format
in QEMU.

>
> > All that, of course, assuming we even want to support both
> > accelerators. They're addressing the same problem after all. I wonder
> > how we'd choose a precedence, since both seem to be present in the same
> > processor family.
> >
> >
>
> That's an interesting question :-) I think overall performance
> (throughput and CPU overhead) should both be considered. IAA and QAT
> accelerators don't present on all systems. We Bytedance choose to have
> both on our platform when purchasing from Intel.


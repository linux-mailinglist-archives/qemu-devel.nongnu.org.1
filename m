Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 501DC8379FD
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 01:48:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS4wZ-00068h-Gv; Mon, 22 Jan 2024 19:47:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rS4wV-00068R-TM
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 19:47:08 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rS4wT-0000q2-O2
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 19:47:07 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a28bd9ca247so422529766b.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 16:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1705970821; x=1706575621; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hOyhwFTfoOywJuZpPcLwNS+03mXI0myXG8a+UcTAQmE=;
 b=L88EqerGC+HLLoOoqkW2gBibqBBQi5WV4yEWhPJgT9V6CKcEIVHMnOXMY/4pEPMAIy
 USpMr2sV9q9O1qQDRjgULSy/fXxti4Hadx/AWwYmKAULGg+7F1jCE4hg/ebZGkwXutYk
 DGfBayJwNxmdPKLqsXGF9mh6RvLYWYdwA4v5pSOArwciFvP7XJewAMb9qFCdXMjcC3Sy
 5RCz1Qt+bo68T4szurOu7mFC6HYElMUxgrL9+TFTnJ6DhjttA6VhW1d8+J9DaHmNtZVP
 35Yzc/DfbFfQT61q8wY2PICHVcAKaKNVd3raP3OtBECFSYhxHe0uzZAe6NYMZXaFnew6
 nonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705970821; x=1706575621;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hOyhwFTfoOywJuZpPcLwNS+03mXI0myXG8a+UcTAQmE=;
 b=YjY2ojOOgTGlC5G4YdQ3U6KdEphMTqNG0a5p3NpEWsnco7XUdxlJWf5S/ffUHmiy1k
 LMPcsXDwt8kVG278XhUHpv48H28Ck2ZcuvgM734g+tXaW44JVgH9ah+wmIPqXAGsfBgm
 mFY+39KcBYIolHKcPHFotcxlkm8agRBiB0qWU99445IvU7ecnj3gzcj1Ba6D+ErA/Uo9
 ryf8H1Lfm/fNhC+ekxZkwiL5vhEkhMJZ/qJsK7NNcgSToj1aQ3vi3ZHN9Ep8aE9JTGWs
 CN9vF+gBbyPL9pu63hwDuuivTW4T5nqmW+UtWB89HbFYSSTi0yEIeQe+I8fItv+ormnL
 iNRQ==
X-Gm-Message-State: AOJu0Yxwa7S+WYYcT2i1/F2v1EdlgRU8b8Yj6+HgJ3qxcUNwsO4LsLVz
 uZaKf/Kt2Z7KhO1XoSZFqQPycaMAkby4uL+T5ffQeL9nl0wSbRDgDl6CuckC5Hd1um2C/75Nq+M
 srKlyfv/XpR9oSgqMLBL7W/+/M8up2Zo30rUApA==
X-Google-Smtp-Source: AGHT+IENfB6idIjYm4txu7o22ACeD0LxJfbf2rmHeWWYOX1w5oVpaCva2KReSbmvn8m6RoFRV94f8hxYggaZOxWYUiI=
X-Received: by 2002:a17:907:8dcb:b0:a30:74db:b497 with SMTP id
 tg11-20020a1709078dcb00b00a3074dbb497mr1073540ejc.101.1705970821430; Mon, 22
 Jan 2024 16:47:01 -0800 (PST)
MIME-Version: 1.0
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
 <20240104004452.324068-4-hao.xiang@bytedance.com>
 <2EA69F35-5AEB-4A0B-B7AC-7D650C1CFC1E@nutanix.com>
In-Reply-To: <2EA69F35-5AEB-4A0B-B7AC-7D650C1CFC1E@nutanix.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Mon, 22 Jan 2024 16:46:49 -0800
Message-ID: <CAAYibXi3tbi57Od4WUv0QvsU6d9BVTpXDw8CXKHwjziCZx+DiQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 03/20] multifd: Zero pages transmission
To: Shivam Kumar <shivam.kumar1@nutanix.com>
Cc: "farosas@suse.de" <farosas@suse.de>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "peterx@redhat.com" <peterx@redhat.com>, 
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, 
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x62c.google.com
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

On Sun, Jan 14, 2024 at 11:01=E2=80=AFPM Shivam Kumar <shivam.kumar1@nutani=
x.com> wrote:
>
>
>
> > On 04-Jan-2024, at 6:14 AM, Hao Xiang <hao.xiang@bytedance.com> wrote:
> >
> > From: Juan Quintela <quintela@redhat.com>
> >
> > This implements the zero page dection and handling.
> >
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > ---
> > migration/multifd.c | 41 +++++++++++++++++++++++++++++++++++++++--
> > migration/multifd.h |  5 +++++
> > 2 files changed, 44 insertions(+), 2 deletions(-)
> >
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 5a1f50c7e8..756673029d 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -11,6 +11,7 @@
> >  */
> >
> > #include "qemu/osdep.h"
> > +#include "qemu/cutils.h"
> > #include "qemu/rcu.h"
> > #include "exec/target_page.h"
> > #include "sysemu/sysemu.h"
> > @@ -279,6 +280,12 @@ static void multifd_send_fill_packet(MultiFDSendPa=
rams *p)
> >
> >         packet->offset[i] =3D cpu_to_be64(temp);
> >     }
> > +    for (i =3D 0; i < p->zero_num; i++) {
> > +        /* there are architectures where ram_addr_t is 32 bit */
> > +        uint64_t temp =3D p->zero[i];
> > +
> > +        packet->offset[p->normal_num + i] =3D cpu_to_be64(temp);
> > +    }
> > }
> >
> > static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **err=
p)
> > @@ -361,6 +368,18 @@ static int multifd_recv_unfill_packet(MultiFDRecvP=
arams *p, Error **errp)
> >         p->normal[i] =3D offset;
> >     }
> >
> > +    for (i =3D 0; i < p->zero_num; i++) {
> > +        uint64_t offset =3D be64_to_cpu(packet->offset[p->normal_num +=
 i]);
> > +
> > +        if (offset > (p->block->used_length - p->page_size)) {
> > +            error_setg(errp, "multifd: offset too long %" PRIu64
> > +                       " (max " RAM_ADDR_FMT ")",
> > +                       offset, p->block->used_length);
> > +            return -1;
> > +        }
> > +        p->zero[i] =3D offset;
> > +    }
> > +
> >     return 0;
> > }
> >
> > @@ -664,6 +683,8 @@ static void *multifd_send_thread(void *opaque)
> >     MultiFDSendParams *p =3D opaque;
> >     MigrationThread *thread =3D NULL;
> >     Error *local_err =3D NULL;
> > +    /* qemu older than 8.2 don't understand zero page on multifd chann=
el */
> > +    bool use_zero_page =3D !migrate_use_main_zero_page();
> >     int ret =3D 0;
> >     bool use_zero_copy_send =3D migrate_zero_copy_send();
> >
> > @@ -689,6 +710,7 @@ static void *multifd_send_thread(void *opaque)
> >         qemu_mutex_lock(&p->mutex);
> >
> >         if (p->pending_job) {
> > +            RAMBlock *rb =3D p->pages->block;
> >             uint64_t packet_num =3D p->packet_num;
> >             uint32_t flags;
> >             p->normal_num =3D 0;
> > @@ -701,8 +723,16 @@ static void *multifd_send_thread(void *opaque)
> >             }
> >
> >             for (int i =3D 0; i < p->pages->num; i++) {
> > -                p->normal[p->normal_num] =3D p->pages->offset[i];
> > -                p->normal_num++;
> > +                uint64_t offset =3D p->pages->offset[i];
> > +                if (use_zero_page &&
> > +                    buffer_is_zero(rb->host + offset, p->page_size)) {
> > +                    p->zero[p->zero_num] =3D offset;
> > +                    p->zero_num++;
> > +                    ram_release_page(rb->idstr, offset);
> > +                } else {
> > +                    p->normal[p->normal_num] =3D offset;
> > +                    p->normal_num++;
> > +                }
> >             }
> >
> >             if (p->normal_num) {
> > @@ -1155,6 +1185,13 @@ static void *multifd_recv_thread(void *opaque)
> >             }
> >         }
> >
> > +        for (int i =3D 0; i < p->zero_num; i++) {
> > +            void *page =3D p->host + p->zero[i];
> > +            if (!buffer_is_zero(page, p->page_size)) {
> > +                memset(page, 0, p->page_size);
> > +            }
> > +        }
> > +
> I am wondering if zeroing the zero page on the destination can also be of=
floaded to DSA. Can it help in reducing cpu consumption on the destination =
in case of multifd-based migration?

I have that change coded up and I have tested for performance. It's
not saving as much CPU cycles as I hoped. The problem is that on the
sender side, we run zero page detection on every single page but on
the receiver side, we only zero-ing the pages if the sender tells us
so. For instance, if a multifd packet with 128 pages are all zero
pages, we can offload the zero-ing pages on the entire 128 pages in a
single DSA operation and that's the best case. In a worse case, if a
multifd packet with 128 pages only has say 10 zero pages, we can
offload the zero-ing pages on only the 10 pages instead of the entire
128 pages. Considering DSA software overhead, that is not a good deal.

In the future, if we refactor the multifd path to separate zero pages
in its own packet, it will be a different story. For instance, if
there are 1024 non-contiguous zero pages detected, they will be sent
across multiple packets. With a new packet format, those pages can be
put into the same packet (and we can put more than 1024 zero pages in
a packet) and DSA offloading can become much more effective. We can
add that function after we have the new packet format implemented.

> >         if (flags & MULTIFD_FLAG_SYNC) {
> >             qemu_sem_post(&multifd_recv_state->sem_sync);
> >             qemu_sem_wait(&p->sem_sync);
> > diff --git a/migration/multifd.h b/migration/multifd.h
> > index d587b0e19c..13762900d4 100644
> > --- a/migration/multifd.h
> > +++ b/migration/multifd.h
> > @@ -53,6 +53,11 @@ typedef struct {
> >     uint32_t unused32[1];    /* Reserved for future use */
> >     uint64_t unused64[3];    /* Reserved for future use */
> >     char ramblock[256];
> > +    /*
> > +     * This array contains the pointers to:
> > +     *  - normal pages (initial normal_pages entries)
> > +     *  - zero pages (following zero_pages entries)
> > +     */
> >     uint64_t offset[];
> > } __attribute__((packed)) MultiFDPacket_t;
> >
> > --
> > 2.30.2
> >
> >
> >
>


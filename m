Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB9F77B447
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 10:37:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVT4O-0003Rq-By; Mon, 14 Aug 2023 04:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qVT4L-0003R5-JK
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 04:36:57 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qVT4E-0002Tw-N7
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 04:36:57 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so10571229a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 01:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1692002208; x=1692607008;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dWhOJ5Ihfb0LSnp0FlG8CvBbMXR2LW+fk3j6cfcJoRs=;
 b=MJLxOZRf7hGE4lxnqfvkAnKl+JpZhRr9dGSqa/VZg0KOBfuC6SEpmcGwawp3DPyfLT
 XbcvqCNcRz10xPaAciHG7n6bS7UEEdDodegAfeau/uC7RPQDTlx/glQTgXDHAQtuwnAG
 YgEk0sx3gzp1wdFJNaB1bKzYqQGqufvF1XcsTxIePjmPYt1hRoIvgZku84pHEtEloH5/
 aVA2iLo2yu80vSOyJkpkktYMVfXQKdVIWuwBBQEtGn8/A8WrCEfE4sq84qsL5df/S+Tf
 +P+igGhvBeUlHJxKOCIpfImzyGwKKZOd3MkCfdVmo8Tzt4gFp87oQH6jAKyeALF904dE
 yFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692002208; x=1692607008;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dWhOJ5Ihfb0LSnp0FlG8CvBbMXR2LW+fk3j6cfcJoRs=;
 b=hTzPNO+JcJy1IRlDyZfMic6Tuxd5OvkmrDCi5rsMw1tA+8VTwbTEG/Vx6nsAGKRW+/
 b2YvFdRJRN9R+XfmsTrkyJmf9CTsI1jwNgtswwC7qSIAad3AdgS7eC9+ryXMP2dIgHvA
 PGCWalZJ4eFf5Bk1+g91sLIRIqJxsZ3XI5W8ladirT2fJQeBClbwtVc67XWkysv4IgE9
 2F66Kw1FVuram/cJX1PONVfFQyxOVKy4Z9WKI5sow+cWUDFmK9EKYYV7vwVc60Py2rUX
 EkMIp8Ocu3VRDCBXt9kgIXV7rnZloaYBOEWkLJLmQxCBMaUJ/r4ACaQVHRiwjsRT7KKx
 guwg==
X-Gm-Message-State: AOJu0YzwFA39dGHiqzIcIyamMelNowMEVe9X5r/ooJ1VXzfoFKaxJ4Qj
 rb47yqb11zjg2FzxnZbmiMpHpf0cGJYfTHaAlbV2jA==
X-Google-Smtp-Source: AGHT+IHw5oJhuOsu81dUgxDh0h3FFOF9b+4Hh/drCxI2Ib/ae6HuAa0Nx0o6G4htVI2hfH4SE6Ugn9xCOct1uzJD2Xk=
X-Received: by 2002:a17:907:1dcd:b0:994:5457:269e with SMTP id
 og13-20020a1709071dcd00b009945457269emr9941084ejc.0.1692002208138; Mon, 14
 Aug 2023 01:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230802204125.33688-1-andrew@daynix.com>
 <20230802204125.33688-2-andrew@daynix.com>
 <CACGkMEshvbR3kK+NWqHqDZBkDNLHkWPtxTPE-hVhtaSzAeBvcA@mail.gmail.com>
 <CABcq3pESApSkzCngEW4JUmtbx2bpiRzeo928fSaVkk50JRrd9g@mail.gmail.com>
 <CACGkMEviH+GXBvsbzsR3PU76XbXA4=tMg2dGBtc5PGs935ci7w@mail.gmail.com>
In-Reply-To: <CACGkMEviH+GXBvsbzsR3PU76XbXA4=tMg2dGBtc5PGs935ci7w@mail.gmail.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Mon, 14 Aug 2023 11:36:36 +0300
Message-ID: <CABcq3pEesaCErpS2Z+FfP6Ac0xEmGZ5HfR2hKBL=0gZhKEqUbw@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] ebpf: Added eBPF map update through mmap.
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, berrange@redhat.com, 
 qemu-devel@nongnu.org, yuri.benditovich@daynix.com, yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::535;
 envelope-from=andrew@daynix.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi, all.

I've researched an issue a bit. And what can we do?
In the case of an "old" kernel 5.4, we need to load RSS eBPF without
BPF_F_MAPPABLE
and use bpf syscall to update the maps. This requires additional capabiliti=
es,
and the libvirtd will never give any capabilities to Qemu.
So, the only case for "fallback" is running Qemu manually with
capabilities(or with root) on kernel 5.4.

We can add hack/fallback to RSS ebpf loading routine with additional
checks and modify for BPF_F_MAPPABLE.
And we can add a fallback for mmap/syscall ebpf access.

The problem is that we need kernel 5.5 with BPF_F_MAPPABLE in headers
to compile Qemu with fallback,
or move macro to the Qemu headers.

It can be implemented something like this:
RSS eBPF open/load:
 * open the skeleton.
 * load the skeleton as is - it would fail because of an unknown BPF_F_MAPP=
ABLE.
 * hack/modify map_flags for skeleton and try to reload.
RSS eBPF map update(this is straightforward):
 * check the mem pointer if null, use bpf syscall

The advantage of hacks in Qemu is that we are aware of the eBPF context.
I suggest creating different series of patches that would implement
the hack/fallback,
If we really want to support eBPF on old kernels.

On Wed, Aug 9, 2023 at 5:21=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Wed, Aug 9, 2023 at 7:15=E2=80=AFAM Andrew Melnichenko <andrew@daynix.=
com> wrote:
> >
> > Hi all,
> >
> > On Tue, Aug 8, 2023 at 5:39=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Thu, Aug 3, 2023 at 5:01=E2=80=AFAM Andrew Melnychenko <andrew@day=
nix.com> wrote:
> > > >
> > > > Changed eBPF map updates through mmaped array.
> > > > Mmaped arrays provide direct access to map data.
> > > > It should omit using bpf_map_update_elem() call,
> > > > which may require capabilities that are not present.
> > > >
> > > > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > > > ---
> > > >  ebpf/ebpf_rss.c | 117 ++++++++++++++++++++++++++++++++++++++------=
----
> > > >  ebpf/ebpf_rss.h |   5 +++
> > > >  2 files changed, 99 insertions(+), 23 deletions(-)
> > > >
> > > > diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
> > > > index cee658c158b..247f5eee1b6 100644
> > > > --- a/ebpf/ebpf_rss.c
> > > > +++ b/ebpf/ebpf_rss.c
> > > > @@ -27,19 +27,83 @@ void ebpf_rss_init(struct EBPFRSSContext *ctx)
> > > >  {
> > > >      if (ctx !=3D NULL) {
> > > >          ctx->obj =3D NULL;
> > > > +        ctx->program_fd =3D -1;
> > > > +        ctx->map_configuration =3D -1;
> > > > +        ctx->map_toeplitz_key =3D -1;
> > > > +        ctx->map_indirections_table =3D -1;
> > > > +
> > > > +        ctx->mmap_configuration =3D NULL;
> > > > +        ctx->mmap_toeplitz_key =3D NULL;
> > > > +        ctx->mmap_indirections_table =3D NULL;
> > > >      }
> > > >  }
> > > >
> > > >  bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)
> > > >  {
> > > > -    return ctx !=3D NULL && ctx->obj !=3D NULL;
> > > > +    return ctx !=3D NULL && (ctx->obj !=3D NULL || ctx->program_fd=
 !=3D -1);
> > > > +}
> > > > +
> > > > +static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
> > > > +{
> > > > +    if (!ebpf_rss_is_loaded(ctx)) {
> > > > +        return false;
> > > > +    }
> > > > +
> > > > +    ctx->mmap_configuration =3D mmap(NULL, qemu_real_host_page_siz=
e(),
> > > > +                                   PROT_READ | PROT_WRITE, MAP_SHA=
RED,
> > > > +                                   ctx->map_configuration, 0);
> > > > +    if (ctx->mmap_configuration =3D=3D MAP_FAILED) {
> > > > +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF configurat=
ion array");
> > > > +        return false;
> > > > +    }
> > > > +    ctx->mmap_toeplitz_key =3D mmap(NULL, qemu_real_host_page_size=
(),
> > > > +                                   PROT_READ | PROT_WRITE, MAP_SHA=
RED,
> > > > +                                   ctx->map_toeplitz_key, 0);
> > > > +    if (ctx->mmap_toeplitz_key =3D=3D MAP_FAILED) {
> > > > +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF toeplitz k=
ey");
> > > > +        goto toeplitz_fail;
> > > > +    }
> > > > +    ctx->mmap_indirections_table =3D mmap(NULL, qemu_real_host_pag=
e_size(),
> > > > +                                   PROT_READ | PROT_WRITE, MAP_SHA=
RED,
> > > > +                                   ctx->map_indirections_table, 0)=
;
> > > > +    if (ctx->mmap_indirections_table =3D=3D MAP_FAILED) {
> > > > +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF indirectio=
n table");
> > > > +        goto indirection_fail;
> > > > +    }
> > > > +
> > > > +    return true;
> > > > +
> > > > +indirection_fail:
> > > > +    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
> > > > +toeplitz_fail:
> > > > +    munmap(ctx->mmap_configuration, qemu_real_host_page_size());
> > > > +
> > > > +    ctx->mmap_configuration =3D NULL;
> > > > +    ctx->mmap_toeplitz_key =3D NULL;
> > > > +    ctx->mmap_indirections_table =3D NULL;
> > > > +    return false;
> > > > +}
> > > > +
> > > > +static void ebpf_rss_munmap(struct EBPFRSSContext *ctx)
> > > > +{
> > > > +    if (!ebpf_rss_is_loaded(ctx)) {
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    munmap(ctx->mmap_indirections_table, qemu_real_host_page_size(=
));
> > > > +    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
> > > > +    munmap(ctx->mmap_configuration, qemu_real_host_page_size());
> > > > +
> > > > +    ctx->mmap_configuration =3D NULL;
> > > > +    ctx->mmap_toeplitz_key =3D NULL;
> > > > +    ctx->mmap_indirections_table =3D NULL;
> > > >  }
> > > >
> > > >  bool ebpf_rss_load(struct EBPFRSSContext *ctx)
> > > >  {
> > > >      struct rss_bpf *rss_bpf_ctx;
> > > >
> > > > -    if (ctx =3D=3D NULL) {
> > > > +    if (ctx =3D=3D NULL || ebpf_rss_is_loaded(ctx)) {
> > > >          return false;
> > > >      }
> > > >
> > > > @@ -66,10 +130,18 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
> > > >      ctx->map_toeplitz_key =3D bpf_map__fd(
> > > >              rss_bpf_ctx->maps.tap_rss_map_toeplitz_key);
> > > >
> > > > +    if (!ebpf_rss_mmap(ctx)) {
> > > > +        goto error;
> > > > +    }
> > > > +
> > > >      return true;
> > > >  error:
> > > >      rss_bpf__destroy(rss_bpf_ctx);
> > > >      ctx->obj =3D NULL;
> > > > +    ctx->program_fd =3D -1;
> > > > +    ctx->map_configuration =3D -1;
> > > > +    ctx->map_toeplitz_key =3D -1;
> > > > +    ctx->map_indirections_table =3D -1;
> > > >
> > > >      return false;
> > > >  }
> > > > @@ -77,15 +149,11 @@ error:
> > > >  static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,
> > > >                                  struct EBPFRSSConfig *config)
> > > >  {
> > > > -    uint32_t map_key =3D 0;
> > > > -
> > > >      if (!ebpf_rss_is_loaded(ctx)) {
> > > >          return false;
> > > >      }
> > > > -    if (bpf_map_update_elem(ctx->map_configuration,
> > > > -                            &map_key, config, 0) < 0) {
> > > > -        return false;
> > > > -    }
> > > > +
> > > > +    memcpy(ctx->mmap_configuration, config, sizeof(*config));
> > > >      return true;
> > > >  }
> > > >
> > > > @@ -93,27 +161,19 @@ static bool ebpf_rss_set_indirections_table(st=
ruct EBPFRSSContext *ctx,
> > > >                                              uint16_t *indirections=
_table,
> > > >                                              size_t len)
> > > >  {
> > > > -    uint32_t i =3D 0;
> > > > -
> > > >      if (!ebpf_rss_is_loaded(ctx) || indirections_table =3D=3D NULL=
 ||
> > > >         len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
> > > >          return false;
> > > >      }
> > > >
> > > > -    for (; i < len; ++i) {
> > > > -        if (bpf_map_update_elem(ctx->map_indirections_table, &i,
> > > > -                                indirections_table + i, 0) < 0) {
> > > > -            return false;
> > > > -        }
> > > > -    }
> > > > +    memcpy(ctx->mmap_indirections_table, indirections_table,
> > > > +            sizeof(*indirections_table) * len);
> > >
> > > As discussed, should we stick the compatibility on the host without
> > > bpf mmap support?
> > >
> > > If we don't, we need at least probe BPF mmap and disable ebpf rss? If
> > > yes, we should track if the map is mmaped and switch between memcpy
> > > and syscall.
> > >
> > > Thanks
> >
> > I've made some tests.
> > I've checked eBPF program on kernels 5.4, 5.5, and 6.3 with libbpf
> > 1.0.1, 1.1.0, and last 1.2.0.
>
> It looks to me we don't check the libbpf version now. Do we need to do
> that (e.g the bpf mmap support for libbpf is not supported from the
> start).
>
> > Overall, eBPF program requires explicit declaration of BPF_F_MAPPABLE m=
ap_flags.
> > Without this flag, the program can be loaded on every tested
> > kernel/libbpf configuration but Qemu can't mmap() the eBPF
> > fds(obviously).
>
> Exactly, and that's why I'm asking whether or not we need to probe mmap h=
ere.
>
> This is because, without this series, Qemu can work without BPF mmap
> (but with privilege). And this doesn't work after this series.
>
> > Alternative to mmap() is bpf_map_update_elem() syscall/method which
> > would require capabilities for Qemu.
>
> Yes, but that's a different "problem". I think we should keep Qemu
> work in that setup. (privilege + syscall updating).
>
> > With this flag, kernel 5.4 + libbpf can't load eBPF object.
> > So, compatibility would require 2 different eBPF objects or some kind
> > of hack, also it would require additional capability for Qemu.
> > I don't think that we need checks for disabling eBPF RSS. It wouldn't
> > brake anything on the old kernel and after an update, it should work
> > ok.
>
> Even on old kernel + old libbpf without bpf mmap support?
>
> Thanks
>
> >
> > >
> > > >      return true;
> > > >  }
> > > >
> > > >  static bool ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,
> > > >                                       uint8_t *toeplitz_key)
> > > >  {
> > > > -    uint32_t map_key =3D 0;
> > > > -
> > > >      /* prepare toeplitz key */
> > > >      uint8_t toe[VIRTIO_NET_RSS_MAX_KEY_SIZE] =3D {};
> > > >
> > > > @@ -123,10 +183,7 @@ static bool ebpf_rss_set_toepliz_key(struct EB=
PFRSSContext *ctx,
> > > >      memcpy(toe, toeplitz_key, VIRTIO_NET_RSS_MAX_KEY_SIZE);
> > > >      *(uint32_t *)toe =3D ntohl(*(uint32_t *)toe);
> > > >
> > > > -    if (bpf_map_update_elem(ctx->map_toeplitz_key, &map_key, toe,
> > > > -                            0) < 0) {
> > > > -        return false;
> > > > -    }
> > > > +    memcpy(ctx->mmap_toeplitz_key, toe, VIRTIO_NET_RSS_MAX_KEY_SIZ=
E);
> > > >      return true;
> > > >  }
> > > >
> > > > @@ -160,6 +217,20 @@ void ebpf_rss_unload(struct EBPFRSSContext *ct=
x)
> > > >          return;
> > > >      }
> > > >
> > > > -    rss_bpf__destroy(ctx->obj);
> > > > +    ebpf_rss_munmap(ctx);
> > > > +
> > > > +    if (ctx->obj) {
> > > > +        rss_bpf__destroy(ctx->obj);
> > > > +    } else {
> > > > +        close(ctx->program_fd);
> > > > +        close(ctx->map_configuration);
> > > > +        close(ctx->map_toeplitz_key);
> > > > +        close(ctx->map_indirections_table);
> > > > +    }
> > > > +
> > > >      ctx->obj =3D NULL;
> > > > +    ctx->program_fd =3D -1;
> > > > +    ctx->map_configuration =3D -1;
> > > > +    ctx->map_toeplitz_key =3D -1;
> > > > +    ctx->map_indirections_table =3D -1;
> > > >  }
> > > > diff --git a/ebpf/ebpf_rss.h b/ebpf/ebpf_rss.h
> > > > index bf3f2572c7c..ab08a7266d0 100644
> > > > --- a/ebpf/ebpf_rss.h
> > > > +++ b/ebpf/ebpf_rss.h
> > > > @@ -20,6 +20,11 @@ struct EBPFRSSContext {
> > > >      int map_configuration;
> > > >      int map_toeplitz_key;
> > > >      int map_indirections_table;
> > > > +
> > > > +    /* mapped eBPF maps for direct access to omit bpf_map_update_e=
lem() */
> > > > +    void *mmap_configuration;
> > > > +    void *mmap_toeplitz_key;
> > > > +    void *mmap_indirections_table;
> > > >  };
> > > >
> > > >  struct EBPFRSSConfig {
> > > > --
> > > > 2.41.0
> > > >
> > >
> >
>


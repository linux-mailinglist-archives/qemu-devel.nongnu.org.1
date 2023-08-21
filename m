Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9228478220E
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 05:59:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXw37-00006i-Mf; Sun, 20 Aug 2023 23:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qXw34-00006P-BL
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 23:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qXw31-0003O2-Fk
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 23:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692590265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=88zEsS7uE4I5YDu2doVi9ZHb8DvbVjaLkKPSA2oJ7dk=;
 b=KUVBs/qhQKnUnLqp314JjNSyhA/bMRXcqiMNE+uVBSlDAviSEnk1go4tffpk/wviw+rt2S
 sNq9FoPyshPllG5qsUVAT3WXc2FKxYp+mRfg62YXz71b4n+qs5l8wVp9YU++tTbNeV/B1D
 LUpP+9aKHTrmVI2t7nnTQBcqLNM716g=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-Lh3trF0ZOt-Y-JAnrYwt6w-1; Sun, 20 Aug 2023 23:57:41 -0400
X-MC-Unique: Lh3trF0ZOt-Y-JAnrYwt6w-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b8405aace3so29745901fa.3
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 20:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692590260; x=1693195060;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=88zEsS7uE4I5YDu2doVi9ZHb8DvbVjaLkKPSA2oJ7dk=;
 b=BmvjSDYTTU6GSZF3dXgvtlJ5Cw4WfW9qd9d1WYoD0wvQ7/WyrwGFqEKCi7ObBmBQO2
 opBU1gweUdtbdad++lIV0qqQNcX+iXE/gjFW1J2jkdyo5fFBmuE2N4NUVhoJtA6Q7a8/
 jC59+LsQbUu1yRy030LCoojgtnxT8HYmnwYntUicrqOr0Luh+BPvjp72k7cFNaKc8UxA
 MU6B+FT2SjtF7HNnHlc2UK+IPGatJKnWHSDfHIKVVgWG90w51+VRJvdvUFWkUgwjC7QV
 0ZfoN4C5Kfgy6JvCvOShyeSQepqu2oh0syR3ozqFeh0Zoq/91w60ipmz5WYsDzvVtkeq
 8tLg==
X-Gm-Message-State: AOJu0Yx/7gIlczZ5KBEEiJtWLbtw+Dat/1g3CmbMaL5HMORbV46PBYbO
 pFS6QkksaO3epe8iut/RfuYBwku4JltDEPhCGmXDPLRsw0EQPIeIv7J9l1HEoODDVWj9dKAyIYS
 cCeJxuHl2Qc9uWfy3bQ/AZ8f+sOnNVh4=
X-Received: by 2002:a2e:980f:0:b0:2b9:ea6b:64b with SMTP id
 a15-20020a2e980f000000b002b9ea6b064bmr3637286ljj.37.1692590260322; 
 Sun, 20 Aug 2023 20:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKPaaoiMFoKHTqrfHm6CmaxlvNd1FgKbxGssZ7EiEokQo6h62e24RMXCj9wDQRi0ueb+aNYJ89Ndl2uFBGfbo=
X-Received: by 2002:a2e:980f:0:b0:2b9:ea6b:64b with SMTP id
 a15-20020a2e980f000000b002b9ea6b064bmr3637272ljj.37.1692590259974; Sun, 20
 Aug 2023 20:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230802204125.33688-1-andrew@daynix.com>
 <20230802204125.33688-2-andrew@daynix.com>
 <CACGkMEshvbR3kK+NWqHqDZBkDNLHkWPtxTPE-hVhtaSzAeBvcA@mail.gmail.com>
 <CABcq3pESApSkzCngEW4JUmtbx2bpiRzeo928fSaVkk50JRrd9g@mail.gmail.com>
 <CACGkMEviH+GXBvsbzsR3PU76XbXA4=tMg2dGBtc5PGs935ci7w@mail.gmail.com>
 <CABcq3pEesaCErpS2Z+FfP6Ac0xEmGZ5HfR2hKBL=0gZhKEqUbw@mail.gmail.com>
 <CACGkMEu8HVxc9QjVU+vTOAiH4oAUG87q7kHGqbk1Hkv+VRNZ7Q@mail.gmail.com>
 <CABcq3pE5fJC7hqD2q3O9WmPGHJhp5Gs0bC=icoHaRD7uBGo9oQ@mail.gmail.com>
In-Reply-To: <CABcq3pE5fJC7hqD2q3O9WmPGHJhp5Gs0bC=icoHaRD7uBGo9oQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Aug 2023 11:57:29 +0800
Message-ID: <CACGkMEt6kF8TgV41Nhj_GdzQqKb_T1AWLse+XwXrZVj9AAR-qQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] ebpf: Added eBPF map update through mmap.
To: Andrew Melnichenko <andrew@daynix.com>
Cc: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, berrange@redhat.com, 
 qemu-devel@nongnu.org, yuri.benditovich@daynix.com, yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Aug 18, 2023 at 10:08=E2=80=AFAM Andrew Melnichenko <andrew@daynix.=
com> wrote:
>
> Hi all,
>
> On Wed, Aug 16, 2023 at 4:16=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Mon, Aug 14, 2023 at 4:36=E2=80=AFPM Andrew Melnichenko <andrew@dayn=
ix.com> wrote:
> > >
> > > Hi, all.
> > >
> > > I've researched an issue a bit. And what can we do?
> > > In the case of an "old" kernel 5.4, we need to load RSS eBPF without
> > > BPF_F_MAPPABLE
> > > and use bpf syscall to update the maps. This requires additional capa=
bilities,
> > > and the libvirtd will never give any capabilities to Qemu.
> > > So, the only case for "fallback" is running Qemu manually with
> > > capabilities(or with root) on kernel 5.4.
> > >
> > > We can add hack/fallback to RSS ebpf loading routine with additional
> > > checks and modify for BPF_F_MAPPABLE.
> > > And we can add a fallback for mmap/syscall ebpf access.
> > >
> > > The problem is that we need kernel 5.5 with BPF_F_MAPPABLE in headers
> > > to compile Qemu with fallback,
> > > or move macro to the Qemu headers.
> > >
> > > It can be implemented something like this:
> > > RSS eBPF open/load:
> > >  * open the skeleton.
> > >  * load the skeleton as is - it would fail because of an unknown BPF_=
F_MAPPABLE.
> > >  * hack/modify map_flags for skeleton and try to reload.
> > > RSS eBPF map update(this is straightforward):
> > >  * check the mem pointer if null, use bpf syscall
> > >
> > > The advantage of hacks in Qemu is that we are aware of the eBPF conte=
xt.
> > > I suggest creating different series of patches that would implement
> > > the hack/fallback,
> > > If we really want to support eBPF on old kernels.
> >
> > So I think the simplest way is to disable eBPF RSS support on old
> > kernels? (e.g during the configure)
> >
> > Thanks
>
> I think it's possible to check BPF_F_MAPPABLE flag during configuration.
> The absence of this flag would indicate that the kernel probably is
> old on the build machine.
>
> It wouldn't solve the issue with a "new" environment and old
> kernel(g.e. fallback kernel).

eBPF RSS support will just be disabled, this seems to be fine.

> Or "old" environment and new kernel(g.e. self-build one).

I don't see what's the issue in this case.

> Also, the environment on the build maintainer's machine and end-up
> system may be different
> (assuming that the build machine is always up to date).

Yes, but this "issue" is not specific to RSS eBPF?

> On the other hand, there is already a fallback to "in-qemu" RSS if eBPF f=
ails.

I see, but the question is what's the implication for the mgmt layer
e.g libvirt in this case?

Thanks

>
> If it requires, we can add the check, I don't see that it solves much
> without hack.
> It will be required if we add mmap/syscall hack for element update.
>
> >
> > >
> > > On Wed, Aug 9, 2023 at 5:21=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Wed, Aug 9, 2023 at 7:15=E2=80=AFAM Andrew Melnichenko <andrew@d=
aynix.com> wrote:
> > > > >
> > > > > Hi all,
> > > > >
> > > > > On Tue, Aug 8, 2023 at 5:39=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > > >
> > > > > > On Thu, Aug 3, 2023 at 5:01=E2=80=AFAM Andrew Melnychenko <andr=
ew@daynix.com> wrote:
> > > > > > >
> > > > > > > Changed eBPF map updates through mmaped array.
> > > > > > > Mmaped arrays provide direct access to map data.
> > > > > > > It should omit using bpf_map_update_elem() call,
> > > > > > > which may require capabilities that are not present.
> > > > > > >
> > > > > > > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > > > > > > ---
> > > > > > >  ebpf/ebpf_rss.c | 117 ++++++++++++++++++++++++++++++++++++++=
----------
> > > > > > >  ebpf/ebpf_rss.h |   5 +++
> > > > > > >  2 files changed, 99 insertions(+), 23 deletions(-)
> > > > > > >
> > > > > > > diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
> > > > > > > index cee658c158b..247f5eee1b6 100644
> > > > > > > --- a/ebpf/ebpf_rss.c
> > > > > > > +++ b/ebpf/ebpf_rss.c
> > > > > > > @@ -27,19 +27,83 @@ void ebpf_rss_init(struct EBPFRSSContext =
*ctx)
> > > > > > >  {
> > > > > > >      if (ctx !=3D NULL) {
> > > > > > >          ctx->obj =3D NULL;
> > > > > > > +        ctx->program_fd =3D -1;
> > > > > > > +        ctx->map_configuration =3D -1;
> > > > > > > +        ctx->map_toeplitz_key =3D -1;
> > > > > > > +        ctx->map_indirections_table =3D -1;
> > > > > > > +
> > > > > > > +        ctx->mmap_configuration =3D NULL;
> > > > > > > +        ctx->mmap_toeplitz_key =3D NULL;
> > > > > > > +        ctx->mmap_indirections_table =3D NULL;
> > > > > > >      }
> > > > > > >  }
> > > > > > >
> > > > > > >  bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)
> > > > > > >  {
> > > > > > > -    return ctx !=3D NULL && ctx->obj !=3D NULL;
> > > > > > > +    return ctx !=3D NULL && (ctx->obj !=3D NULL || ctx->prog=
ram_fd !=3D -1);
> > > > > > > +}
> > > > > > > +
> > > > > > > +static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
> > > > > > > +{
> > > > > > > +    if (!ebpf_rss_is_loaded(ctx)) {
> > > > > > > +        return false;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    ctx->mmap_configuration =3D mmap(NULL, qemu_real_host_pa=
ge_size(),
> > > > > > > +                                   PROT_READ | PROT_WRITE, M=
AP_SHARED,
> > > > > > > +                                   ctx->map_configuration, 0=
);
> > > > > > > +    if (ctx->mmap_configuration =3D=3D MAP_FAILED) {
> > > > > > > +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF conf=
iguration array");
> > > > > > > +        return false;
> > > > > > > +    }
> > > > > > > +    ctx->mmap_toeplitz_key =3D mmap(NULL, qemu_real_host_pag=
e_size(),
> > > > > > > +                                   PROT_READ | PROT_WRITE, M=
AP_SHARED,
> > > > > > > +                                   ctx->map_toeplitz_key, 0)=
;
> > > > > > > +    if (ctx->mmap_toeplitz_key =3D=3D MAP_FAILED) {
> > > > > > > +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF toep=
litz key");
> > > > > > > +        goto toeplitz_fail;
> > > > > > > +    }
> > > > > > > +    ctx->mmap_indirections_table =3D mmap(NULL, qemu_real_ho=
st_page_size(),
> > > > > > > +                                   PROT_READ | PROT_WRITE, M=
AP_SHARED,
> > > > > > > +                                   ctx->map_indirections_tab=
le, 0);
> > > > > > > +    if (ctx->mmap_indirections_table =3D=3D MAP_FAILED) {
> > > > > > > +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF indi=
rection table");
> > > > > > > +        goto indirection_fail;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    return true;
> > > > > > > +
> > > > > > > +indirection_fail:
> > > > > > > +    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size(=
));
> > > > > > > +toeplitz_fail:
> > > > > > > +    munmap(ctx->mmap_configuration, qemu_real_host_page_size=
());
> > > > > > > +
> > > > > > > +    ctx->mmap_configuration =3D NULL;
> > > > > > > +    ctx->mmap_toeplitz_key =3D NULL;
> > > > > > > +    ctx->mmap_indirections_table =3D NULL;
> > > > > > > +    return false;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void ebpf_rss_munmap(struct EBPFRSSContext *ctx)
> > > > > > > +{
> > > > > > > +    if (!ebpf_rss_is_loaded(ctx)) {
> > > > > > > +        return;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    munmap(ctx->mmap_indirections_table, qemu_real_host_page=
_size());
> > > > > > > +    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size(=
));
> > > > > > > +    munmap(ctx->mmap_configuration, qemu_real_host_page_size=
());
> > > > > > > +
> > > > > > > +    ctx->mmap_configuration =3D NULL;
> > > > > > > +    ctx->mmap_toeplitz_key =3D NULL;
> > > > > > > +    ctx->mmap_indirections_table =3D NULL;
> > > > > > >  }
> > > > > > >
> > > > > > >  bool ebpf_rss_load(struct EBPFRSSContext *ctx)
> > > > > > >  {
> > > > > > >      struct rss_bpf *rss_bpf_ctx;
> > > > > > >
> > > > > > > -    if (ctx =3D=3D NULL) {
> > > > > > > +    if (ctx =3D=3D NULL || ebpf_rss_is_loaded(ctx)) {
> > > > > > >          return false;
> > > > > > >      }
> > > > > > >
> > > > > > > @@ -66,10 +130,18 @@ bool ebpf_rss_load(struct EBPFRSSContext=
 *ctx)
> > > > > > >      ctx->map_toeplitz_key =3D bpf_map__fd(
> > > > > > >              rss_bpf_ctx->maps.tap_rss_map_toeplitz_key);
> > > > > > >
> > > > > > > +    if (!ebpf_rss_mmap(ctx)) {
> > > > > > > +        goto error;
> > > > > > > +    }
> > > > > > > +
> > > > > > >      return true;
> > > > > > >  error:
> > > > > > >      rss_bpf__destroy(rss_bpf_ctx);
> > > > > > >      ctx->obj =3D NULL;
> > > > > > > +    ctx->program_fd =3D -1;
> > > > > > > +    ctx->map_configuration =3D -1;
> > > > > > > +    ctx->map_toeplitz_key =3D -1;
> > > > > > > +    ctx->map_indirections_table =3D -1;
> > > > > > >
> > > > > > >      return false;
> > > > > > >  }
> > > > > > > @@ -77,15 +149,11 @@ error:
> > > > > > >  static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,
> > > > > > >                                  struct EBPFRSSConfig *config=
)
> > > > > > >  {
> > > > > > > -    uint32_t map_key =3D 0;
> > > > > > > -
> > > > > > >      if (!ebpf_rss_is_loaded(ctx)) {
> > > > > > >          return false;
> > > > > > >      }
> > > > > > > -    if (bpf_map_update_elem(ctx->map_configuration,
> > > > > > > -                            &map_key, config, 0) < 0) {
> > > > > > > -        return false;
> > > > > > > -    }
> > > > > > > +
> > > > > > > +    memcpy(ctx->mmap_configuration, config, sizeof(*config))=
;
> > > > > > >      return true;
> > > > > > >  }
> > > > > > >
> > > > > > > @@ -93,27 +161,19 @@ static bool ebpf_rss_set_indirections_ta=
ble(struct EBPFRSSContext *ctx,
> > > > > > >                                              uint16_t *indire=
ctions_table,
> > > > > > >                                              size_t len)
> > > > > > >  {
> > > > > > > -    uint32_t i =3D 0;
> > > > > > > -
> > > > > > >      if (!ebpf_rss_is_loaded(ctx) || indirections_table =3D=
=3D NULL ||
> > > > > > >         len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
> > > > > > >          return false;
> > > > > > >      }
> > > > > > >
> > > > > > > -    for (; i < len; ++i) {
> > > > > > > -        if (bpf_map_update_elem(ctx->map_indirections_table,=
 &i,
> > > > > > > -                                indirections_table + i, 0) <=
 0) {
> > > > > > > -            return false;
> > > > > > > -        }
> > > > > > > -    }
> > > > > > > +    memcpy(ctx->mmap_indirections_table, indirections_table,
> > > > > > > +            sizeof(*indirections_table) * len);
> > > > > >
> > > > > > As discussed, should we stick the compatibility on the host wit=
hout
> > > > > > bpf mmap support?
> > > > > >
> > > > > > If we don't, we need at least probe BPF mmap and disable ebpf r=
ss? If
> > > > > > yes, we should track if the map is mmaped and switch between me=
mcpy
> > > > > > and syscall.
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > I've made some tests.
> > > > > I've checked eBPF program on kernels 5.4, 5.5, and 6.3 with libbp=
f
> > > > > 1.0.1, 1.1.0, and last 1.2.0.
> > > >
> > > > It looks to me we don't check the libbpf version now. Do we need to=
 do
> > > > that (e.g the bpf mmap support for libbpf is not supported from the
> > > > start).
> > > >
> > > > > Overall, eBPF program requires explicit declaration of BPF_F_MAPP=
ABLE map_flags.
> > > > > Without this flag, the program can be loaded on every tested
> > > > > kernel/libbpf configuration but Qemu can't mmap() the eBPF
> > > > > fds(obviously).
> > > >
> > > > Exactly, and that's why I'm asking whether or not we need to probe =
mmap here.
> > > >
> > > > This is because, without this series, Qemu can work without BPF mma=
p
> > > > (but with privilege). And this doesn't work after this series.
> > > >
> > > > > Alternative to mmap() is bpf_map_update_elem() syscall/method whi=
ch
> > > > > would require capabilities for Qemu.
> > > >
> > > > Yes, but that's a different "problem". I think we should keep Qemu
> > > > work in that setup. (privilege + syscall updating).
> > > >
> > > > > With this flag, kernel 5.4 + libbpf can't load eBPF object.
> > > > > So, compatibility would require 2 different eBPF objects or some =
kind
> > > > > of hack, also it would require additional capability for Qemu.
> > > > > I don't think that we need checks for disabling eBPF RSS. It woul=
dn't
> > > > > brake anything on the old kernel and after an update, it should w=
ork
> > > > > ok.
> > > >
> > > > Even on old kernel + old libbpf without bpf mmap support?
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > >
> > > > > > >      return true;
> > > > > > >  }
> > > > > > >
> > > > > > >  static bool ebpf_rss_set_toepliz_key(struct EBPFRSSContext *=
ctx,
> > > > > > >                                       uint8_t *toeplitz_key)
> > > > > > >  {
> > > > > > > -    uint32_t map_key =3D 0;
> > > > > > > -
> > > > > > >      /* prepare toeplitz key */
> > > > > > >      uint8_t toe[VIRTIO_NET_RSS_MAX_KEY_SIZE] =3D {};
> > > > > > >
> > > > > > > @@ -123,10 +183,7 @@ static bool ebpf_rss_set_toepliz_key(str=
uct EBPFRSSContext *ctx,
> > > > > > >      memcpy(toe, toeplitz_key, VIRTIO_NET_RSS_MAX_KEY_SIZE);
> > > > > > >      *(uint32_t *)toe =3D ntohl(*(uint32_t *)toe);
> > > > > > >
> > > > > > > -    if (bpf_map_update_elem(ctx->map_toeplitz_key, &map_key,=
 toe,
> > > > > > > -                            0) < 0) {
> > > > > > > -        return false;
> > > > > > > -    }
> > > > > > > +    memcpy(ctx->mmap_toeplitz_key, toe, VIRTIO_NET_RSS_MAX_K=
EY_SIZE);
> > > > > > >      return true;
> > > > > > >  }
> > > > > > >
> > > > > > > @@ -160,6 +217,20 @@ void ebpf_rss_unload(struct EBPFRSSConte=
xt *ctx)
> > > > > > >          return;
> > > > > > >      }
> > > > > > >
> > > > > > > -    rss_bpf__destroy(ctx->obj);
> > > > > > > +    ebpf_rss_munmap(ctx);
> > > > > > > +
> > > > > > > +    if (ctx->obj) {
> > > > > > > +        rss_bpf__destroy(ctx->obj);
> > > > > > > +    } else {
> > > > > > > +        close(ctx->program_fd);
> > > > > > > +        close(ctx->map_configuration);
> > > > > > > +        close(ctx->map_toeplitz_key);
> > > > > > > +        close(ctx->map_indirections_table);
> > > > > > > +    }
> > > > > > > +
> > > > > > >      ctx->obj =3D NULL;
> > > > > > > +    ctx->program_fd =3D -1;
> > > > > > > +    ctx->map_configuration =3D -1;
> > > > > > > +    ctx->map_toeplitz_key =3D -1;
> > > > > > > +    ctx->map_indirections_table =3D -1;
> > > > > > >  }
> > > > > > > diff --git a/ebpf/ebpf_rss.h b/ebpf/ebpf_rss.h
> > > > > > > index bf3f2572c7c..ab08a7266d0 100644
> > > > > > > --- a/ebpf/ebpf_rss.h
> > > > > > > +++ b/ebpf/ebpf_rss.h
> > > > > > > @@ -20,6 +20,11 @@ struct EBPFRSSContext {
> > > > > > >      int map_configuration;
> > > > > > >      int map_toeplitz_key;
> > > > > > >      int map_indirections_table;
> > > > > > > +
> > > > > > > +    /* mapped eBPF maps for direct access to omit bpf_map_up=
date_elem() */
> > > > > > > +    void *mmap_configuration;
> > > > > > > +    void *mmap_toeplitz_key;
> > > > > > > +    void *mmap_indirections_table;
> > > > > > >  };
> > > > > > >
> > > > > > >  struct EBPFRSSConfig {
> > > > > > > --
> > > > > > > 2.41.0
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>



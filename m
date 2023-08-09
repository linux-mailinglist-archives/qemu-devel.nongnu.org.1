Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4558B7750DD
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 04:21:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTYp5-0005O0-If; Tue, 08 Aug 2023 22:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qTYp3-0005Nl-WA
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qTYp2-0002xz-3o
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691547675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NWfgALESuGITyRs8sFZGZtahmoGlyNlVPj/nGIcdL6I=;
 b=VZYJGe3xJGzg9pY+YLXtdKNyevaF8aBbRTX9MHsXMaJufBY5eFANNe7RtybuxbrwdHK70G
 22RLKsWcpeBss2JP8AoXbApBwkH8o1MfsCtLiTonXB+NkeJTI2VdfdTJ77QVUJ6IeW9CEy
 JAuWVpbLcJgsTBIY/Sip7Rmq+pAHUCM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-WhLPARQVO02eL9TCHDvcmg-1; Tue, 08 Aug 2023 22:21:13 -0400
X-MC-Unique: WhLPARQVO02eL9TCHDvcmg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b9fa64db5cso66930001fa.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 19:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691547671; x=1692152471;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NWfgALESuGITyRs8sFZGZtahmoGlyNlVPj/nGIcdL6I=;
 b=M3BjWRXjBpV4uhJ/le3szgXsZ/XP8CucjxhfnhMHaQAqrGKKUTuSC5tT8D3dbGTkzA
 ZyLod/S86SDKdgZqs8Eizn215e0RLYqJaIS7BppNAmHZrp/iJ/ROloNEgzSO91QP8Uoj
 7CodVuNoZuLP2++MLqPX9gbBDIBZCV7sWuT0RWkNkgtaJFXGipRtRA9eiQqujsguIW3J
 iOCEO5kva04GJJ8U8pRm2IJ5av+KXCIpN3yX4pZQlTXNiJn5WAGuEONo1EfOoTgZZVmu
 8dTOrQBL6jK0+4K8pFD5LOtK/rhk65+T2qiI+zHKRMr0CWfNi2X99o+7rd30qC5bsp15
 YSoA==
X-Gm-Message-State: AOJu0YwLhXl1H84UgE7WsMSP/8jxwBZE3yFQHz4LrTpIvHEDJkBIh3Ae
 0QDSNvd+EIYFte56VDqf65usJXL8GvAyCv9bo1LFK5IGTgV6Y+WXLKStumO6YKdeMuCU09yVvLW
 iBc1I5lw3NyY30Bbm8uejYd+mATnixs0=
X-Received: by 2002:a2e:88c4:0:b0:2b9:412a:111d with SMTP id
 a4-20020a2e88c4000000b002b9412a111dmr917331ljk.42.1691547671684; 
 Tue, 08 Aug 2023 19:21:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFicumqUubNog89UCI3E/MlGcwoHmaDVZAnzz4690AjxEDx1jJjYZlxtVJN1X2hc9ncDX/U600Ssv/pBYWP8Gs=
X-Received: by 2002:a2e:88c4:0:b0:2b9:412a:111d with SMTP id
 a4-20020a2e88c4000000b002b9412a111dmr917321ljk.42.1691547671338; Tue, 08 Aug
 2023 19:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230802204125.33688-1-andrew@daynix.com>
 <20230802204125.33688-2-andrew@daynix.com>
 <CACGkMEshvbR3kK+NWqHqDZBkDNLHkWPtxTPE-hVhtaSzAeBvcA@mail.gmail.com>
 <CABcq3pESApSkzCngEW4JUmtbx2bpiRzeo928fSaVkk50JRrd9g@mail.gmail.com>
In-Reply-To: <CABcq3pESApSkzCngEW4JUmtbx2bpiRzeo928fSaVkk50JRrd9g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Aug 2023 10:21:00 +0800
Message-ID: <CACGkMEviH+GXBvsbzsR3PU76XbXA4=tMg2dGBtc5PGs935ci7w@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] ebpf: Added eBPF map update through mmap.
To: Andrew Melnichenko <andrew@daynix.com>
Cc: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, berrange@redhat.com, 
 qemu-devel@nongnu.org, yuri.benditovich@daynix.com, yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 9, 2023 at 7:15=E2=80=AFAM Andrew Melnichenko <andrew@daynix.co=
m> wrote:
>
> Hi all,
>
> On Tue, Aug 8, 2023 at 5:39=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Thu, Aug 3, 2023 at 5:01=E2=80=AFAM Andrew Melnychenko <andrew@dayni=
x.com> wrote:
> > >
> > > Changed eBPF map updates through mmaped array.
> > > Mmaped arrays provide direct access to map data.
> > > It should omit using bpf_map_update_elem() call,
> > > which may require capabilities that are not present.
> > >
> > > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > > ---
> > >  ebpf/ebpf_rss.c | 117 ++++++++++++++++++++++++++++++++++++++--------=
--
> > >  ebpf/ebpf_rss.h |   5 +++
> > >  2 files changed, 99 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
> > > index cee658c158b..247f5eee1b6 100644
> > > --- a/ebpf/ebpf_rss.c
> > > +++ b/ebpf/ebpf_rss.c
> > > @@ -27,19 +27,83 @@ void ebpf_rss_init(struct EBPFRSSContext *ctx)
> > >  {
> > >      if (ctx !=3D NULL) {
> > >          ctx->obj =3D NULL;
> > > +        ctx->program_fd =3D -1;
> > > +        ctx->map_configuration =3D -1;
> > > +        ctx->map_toeplitz_key =3D -1;
> > > +        ctx->map_indirections_table =3D -1;
> > > +
> > > +        ctx->mmap_configuration =3D NULL;
> > > +        ctx->mmap_toeplitz_key =3D NULL;
> > > +        ctx->mmap_indirections_table =3D NULL;
> > >      }
> > >  }
> > >
> > >  bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)
> > >  {
> > > -    return ctx !=3D NULL && ctx->obj !=3D NULL;
> > > +    return ctx !=3D NULL && (ctx->obj !=3D NULL || ctx->program_fd !=
=3D -1);
> > > +}
> > > +
> > > +static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
> > > +{
> > > +    if (!ebpf_rss_is_loaded(ctx)) {
> > > +        return false;
> > > +    }
> > > +
> > > +    ctx->mmap_configuration =3D mmap(NULL, qemu_real_host_page_size(=
),
> > > +                                   PROT_READ | PROT_WRITE, MAP_SHARE=
D,
> > > +                                   ctx->map_configuration, 0);
> > > +    if (ctx->mmap_configuration =3D=3D MAP_FAILED) {
> > > +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF configuratio=
n array");
> > > +        return false;
> > > +    }
> > > +    ctx->mmap_toeplitz_key =3D mmap(NULL, qemu_real_host_page_size()=
,
> > > +                                   PROT_READ | PROT_WRITE, MAP_SHARE=
D,
> > > +                                   ctx->map_toeplitz_key, 0);
> > > +    if (ctx->mmap_toeplitz_key =3D=3D MAP_FAILED) {
> > > +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF toeplitz key=
");
> > > +        goto toeplitz_fail;
> > > +    }
> > > +    ctx->mmap_indirections_table =3D mmap(NULL, qemu_real_host_page_=
size(),
> > > +                                   PROT_READ | PROT_WRITE, MAP_SHARE=
D,
> > > +                                   ctx->map_indirections_table, 0);
> > > +    if (ctx->mmap_indirections_table =3D=3D MAP_FAILED) {
> > > +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF indirection =
table");
> > > +        goto indirection_fail;
> > > +    }
> > > +
> > > +    return true;
> > > +
> > > +indirection_fail:
> > > +    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
> > > +toeplitz_fail:
> > > +    munmap(ctx->mmap_configuration, qemu_real_host_page_size());
> > > +
> > > +    ctx->mmap_configuration =3D NULL;
> > > +    ctx->mmap_toeplitz_key =3D NULL;
> > > +    ctx->mmap_indirections_table =3D NULL;
> > > +    return false;
> > > +}
> > > +
> > > +static void ebpf_rss_munmap(struct EBPFRSSContext *ctx)
> > > +{
> > > +    if (!ebpf_rss_is_loaded(ctx)) {
> > > +        return;
> > > +    }
> > > +
> > > +    munmap(ctx->mmap_indirections_table, qemu_real_host_page_size())=
;
> > > +    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
> > > +    munmap(ctx->mmap_configuration, qemu_real_host_page_size());
> > > +
> > > +    ctx->mmap_configuration =3D NULL;
> > > +    ctx->mmap_toeplitz_key =3D NULL;
> > > +    ctx->mmap_indirections_table =3D NULL;
> > >  }
> > >
> > >  bool ebpf_rss_load(struct EBPFRSSContext *ctx)
> > >  {
> > >      struct rss_bpf *rss_bpf_ctx;
> > >
> > > -    if (ctx =3D=3D NULL) {
> > > +    if (ctx =3D=3D NULL || ebpf_rss_is_loaded(ctx)) {
> > >          return false;
> > >      }
> > >
> > > @@ -66,10 +130,18 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
> > >      ctx->map_toeplitz_key =3D bpf_map__fd(
> > >              rss_bpf_ctx->maps.tap_rss_map_toeplitz_key);
> > >
> > > +    if (!ebpf_rss_mmap(ctx)) {
> > > +        goto error;
> > > +    }
> > > +
> > >      return true;
> > >  error:
> > >      rss_bpf__destroy(rss_bpf_ctx);
> > >      ctx->obj =3D NULL;
> > > +    ctx->program_fd =3D -1;
> > > +    ctx->map_configuration =3D -1;
> > > +    ctx->map_toeplitz_key =3D -1;
> > > +    ctx->map_indirections_table =3D -1;
> > >
> > >      return false;
> > >  }
> > > @@ -77,15 +149,11 @@ error:
> > >  static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,
> > >                                  struct EBPFRSSConfig *config)
> > >  {
> > > -    uint32_t map_key =3D 0;
> > > -
> > >      if (!ebpf_rss_is_loaded(ctx)) {
> > >          return false;
> > >      }
> > > -    if (bpf_map_update_elem(ctx->map_configuration,
> > > -                            &map_key, config, 0) < 0) {
> > > -        return false;
> > > -    }
> > > +
> > > +    memcpy(ctx->mmap_configuration, config, sizeof(*config));
> > >      return true;
> > >  }
> > >
> > > @@ -93,27 +161,19 @@ static bool ebpf_rss_set_indirections_table(stru=
ct EBPFRSSContext *ctx,
> > >                                              uint16_t *indirections_t=
able,
> > >                                              size_t len)
> > >  {
> > > -    uint32_t i =3D 0;
> > > -
> > >      if (!ebpf_rss_is_loaded(ctx) || indirections_table =3D=3D NULL |=
|
> > >         len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
> > >          return false;
> > >      }
> > >
> > > -    for (; i < len; ++i) {
> > > -        if (bpf_map_update_elem(ctx->map_indirections_table, &i,
> > > -                                indirections_table + i, 0) < 0) {
> > > -            return false;
> > > -        }
> > > -    }
> > > +    memcpy(ctx->mmap_indirections_table, indirections_table,
> > > +            sizeof(*indirections_table) * len);
> >
> > As discussed, should we stick the compatibility on the host without
> > bpf mmap support?
> >
> > If we don't, we need at least probe BPF mmap and disable ebpf rss? If
> > yes, we should track if the map is mmaped and switch between memcpy
> > and syscall.
> >
> > Thanks
>
> I've made some tests.
> I've checked eBPF program on kernels 5.4, 5.5, and 6.3 with libbpf
> 1.0.1, 1.1.0, and last 1.2.0.

It looks to me we don't check the libbpf version now. Do we need to do
that (e.g the bpf mmap support for libbpf is not supported from the
start).

> Overall, eBPF program requires explicit declaration of BPF_F_MAPPABLE map=
_flags.
> Without this flag, the program can be loaded on every tested
> kernel/libbpf configuration but Qemu can't mmap() the eBPF
> fds(obviously).

Exactly, and that's why I'm asking whether or not we need to probe mmap her=
e.

This is because, without this series, Qemu can work without BPF mmap
(but with privilege). And this doesn't work after this series.

> Alternative to mmap() is bpf_map_update_elem() syscall/method which
> would require capabilities for Qemu.

Yes, but that's a different "problem". I think we should keep Qemu
work in that setup. (privilege + syscall updating).

> With this flag, kernel 5.4 + libbpf can't load eBPF object.
> So, compatibility would require 2 different eBPF objects or some kind
> of hack, also it would require additional capability for Qemu.
> I don't think that we need checks for disabling eBPF RSS. It wouldn't
> brake anything on the old kernel and after an update, it should work
> ok.

Even on old kernel + old libbpf without bpf mmap support?

Thanks

>
> >
> > >      return true;
> > >  }
> > >
> > >  static bool ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,
> > >                                       uint8_t *toeplitz_key)
> > >  {
> > > -    uint32_t map_key =3D 0;
> > > -
> > >      /* prepare toeplitz key */
> > >      uint8_t toe[VIRTIO_NET_RSS_MAX_KEY_SIZE] =3D {};
> > >
> > > @@ -123,10 +183,7 @@ static bool ebpf_rss_set_toepliz_key(struct EBPF=
RSSContext *ctx,
> > >      memcpy(toe, toeplitz_key, VIRTIO_NET_RSS_MAX_KEY_SIZE);
> > >      *(uint32_t *)toe =3D ntohl(*(uint32_t *)toe);
> > >
> > > -    if (bpf_map_update_elem(ctx->map_toeplitz_key, &map_key, toe,
> > > -                            0) < 0) {
> > > -        return false;
> > > -    }
> > > +    memcpy(ctx->mmap_toeplitz_key, toe, VIRTIO_NET_RSS_MAX_KEY_SIZE)=
;
> > >      return true;
> > >  }
> > >
> > > @@ -160,6 +217,20 @@ void ebpf_rss_unload(struct EBPFRSSContext *ctx)
> > >          return;
> > >      }
> > >
> > > -    rss_bpf__destroy(ctx->obj);
> > > +    ebpf_rss_munmap(ctx);
> > > +
> > > +    if (ctx->obj) {
> > > +        rss_bpf__destroy(ctx->obj);
> > > +    } else {
> > > +        close(ctx->program_fd);
> > > +        close(ctx->map_configuration);
> > > +        close(ctx->map_toeplitz_key);
> > > +        close(ctx->map_indirections_table);
> > > +    }
> > > +
> > >      ctx->obj =3D NULL;
> > > +    ctx->program_fd =3D -1;
> > > +    ctx->map_configuration =3D -1;
> > > +    ctx->map_toeplitz_key =3D -1;
> > > +    ctx->map_indirections_table =3D -1;
> > >  }
> > > diff --git a/ebpf/ebpf_rss.h b/ebpf/ebpf_rss.h
> > > index bf3f2572c7c..ab08a7266d0 100644
> > > --- a/ebpf/ebpf_rss.h
> > > +++ b/ebpf/ebpf_rss.h
> > > @@ -20,6 +20,11 @@ struct EBPFRSSContext {
> > >      int map_configuration;
> > >      int map_toeplitz_key;
> > >      int map_indirections_table;
> > > +
> > > +    /* mapped eBPF maps for direct access to omit bpf_map_update_ele=
m() */
> > > +    void *mmap_configuration;
> > > +    void *mmap_toeplitz_key;
> > > +    void *mmap_indirections_table;
> > >  };
> > >
> > >  struct EBPFRSSConfig {
> > > --
> > > 2.41.0
> > >
> >
>



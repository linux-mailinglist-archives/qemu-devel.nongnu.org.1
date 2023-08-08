Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2BE774F35
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 01:17:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTVvT-0000MD-In; Tue, 08 Aug 2023 19:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qTVvP-0000Li-Tf
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 19:15:41 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qTVvN-0002hN-2C
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 19:15:39 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-523643207dbso180029a12.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 16:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691536534; x=1692141334;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UogSUNYZsXEmxqlsQCIcYgh75F7Ys26MOnKPR7Gydx8=;
 b=VyNrOmoaIgm1DATD571Byeh2Tf6Ak6O0m4FV38u7aq3OED3ld1Pu8UK3NAzHTpWyfc
 0x+9PhM7S9JYaGzK0fv+hrmRSOGJ9yNXn4bTU2w77HR7FKUATGkU1X6dfrLxstUlVUN5
 gtWGWkS2lc1fzU9ox6WbQ4qu/kAOByGpEc+S0FhaM4mtBRoxI0TvnahqqEqUxsANTVas
 qIFVNhofrA8HBUW3VP0i3Py0gvlx5pLFj1ih5UdY7F0F7cjH9cF7etaH2JglTobmxC8W
 /jm3VLprxJHy/ABV8egGCIfxNpJS5jP5Vqa2lo9PvPv+EVJRX4tAIYRKfaF1DPAUb16d
 uUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691536534; x=1692141334;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UogSUNYZsXEmxqlsQCIcYgh75F7Ys26MOnKPR7Gydx8=;
 b=BC1FCoWWjPzul21KQpQxxOuoV1taqYmpwfzmdPsxzdbv+U2aoFoMmbBJkE1FODv5Bc
 zfp/8fTH+VYz1SF4B6ePxfx2xmeO07zPqteMgBs7kJtg3bIKeqbLvQGQaxrhbXs6uU+4
 YTytJxb+S7prhmWwSMnrCEzt8lJVuYaHdFSLHvPONzI4bFJCCDV9B3j7eVRyaSnW3PJn
 RuncuWw7wXBi28pj5kn11uzByGWp+asfBiz8RjAtBH5n8DMUH70YNv3FZdTRIAeP3fPC
 P9cV/0WjeESEscBIPCaap/wRBnM0XooYN9tb1ATNuCvNbV1nn5L24OoDiv4c0Kslted2
 eefA==
X-Gm-Message-State: AOJu0Yw64gbhiNwpvfzWAFJrVXQ4voEthsu5zLmxx1TD1YFHVfMVkyg+
 KaB/KcLHaALVCEFM5zfC07Bfq4Z/7f0kfeWpZ5d14Q==
X-Google-Smtp-Source: AGHT+IHcdEeqQ3L7fz3EtSZ6+/bvTzWIkhLVJjM1LCp+VHzuG+PnhW/bUI/Y3L1qohEQSNxCGw+6R9iOGgpQSzxkrdw=
X-Received: by 2002:aa7:df82:0:b0:523:4bfa:b450 with SMTP id
 b2-20020aa7df82000000b005234bfab450mr895288edy.27.1691536533870; Tue, 08 Aug
 2023 16:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230802204125.33688-1-andrew@daynix.com>
 <20230802204125.33688-2-andrew@daynix.com>
 <CACGkMEshvbR3kK+NWqHqDZBkDNLHkWPtxTPE-hVhtaSzAeBvcA@mail.gmail.com>
In-Reply-To: <CACGkMEshvbR3kK+NWqHqDZBkDNLHkWPtxTPE-hVhtaSzAeBvcA@mail.gmail.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Wed, 9 Aug 2023 02:15:22 +0300
Message-ID: <CABcq3pESApSkzCngEW4JUmtbx2bpiRzeo928fSaVkk50JRrd9g@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] ebpf: Added eBPF map update through mmap.
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, berrange@redhat.com, 
 qemu-devel@nongnu.org, yuri.benditovich@daynix.com, yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::52d;
 envelope-from=andrew@daynix.com; helo=mail-ed1-x52d.google.com
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

Hi all,

On Tue, Aug 8, 2023 at 5:39=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Thu, Aug 3, 2023 at 5:01=E2=80=AFAM Andrew Melnychenko <andrew@daynix.=
com> wrote:
> >
> > Changed eBPF map updates through mmaped array.
> > Mmaped arrays provide direct access to map data.
> > It should omit using bpf_map_update_elem() call,
> > which may require capabilities that are not present.
> >
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > ---
> >  ebpf/ebpf_rss.c | 117 ++++++++++++++++++++++++++++++++++++++----------
> >  ebpf/ebpf_rss.h |   5 +++
> >  2 files changed, 99 insertions(+), 23 deletions(-)
> >
> > diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
> > index cee658c158b..247f5eee1b6 100644
> > --- a/ebpf/ebpf_rss.c
> > +++ b/ebpf/ebpf_rss.c
> > @@ -27,19 +27,83 @@ void ebpf_rss_init(struct EBPFRSSContext *ctx)
> >  {
> >      if (ctx !=3D NULL) {
> >          ctx->obj =3D NULL;
> > +        ctx->program_fd =3D -1;
> > +        ctx->map_configuration =3D -1;
> > +        ctx->map_toeplitz_key =3D -1;
> > +        ctx->map_indirections_table =3D -1;
> > +
> > +        ctx->mmap_configuration =3D NULL;
> > +        ctx->mmap_toeplitz_key =3D NULL;
> > +        ctx->mmap_indirections_table =3D NULL;
> >      }
> >  }
> >
> >  bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)
> >  {
> > -    return ctx !=3D NULL && ctx->obj !=3D NULL;
> > +    return ctx !=3D NULL && (ctx->obj !=3D NULL || ctx->program_fd !=
=3D -1);
> > +}
> > +
> > +static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
> > +{
> > +    if (!ebpf_rss_is_loaded(ctx)) {
> > +        return false;
> > +    }
> > +
> > +    ctx->mmap_configuration =3D mmap(NULL, qemu_real_host_page_size(),
> > +                                   PROT_READ | PROT_WRITE, MAP_SHARED,
> > +                                   ctx->map_configuration, 0);
> > +    if (ctx->mmap_configuration =3D=3D MAP_FAILED) {
> > +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF configuration =
array");
> > +        return false;
> > +    }
> > +    ctx->mmap_toeplitz_key =3D mmap(NULL, qemu_real_host_page_size(),
> > +                                   PROT_READ | PROT_WRITE, MAP_SHARED,
> > +                                   ctx->map_toeplitz_key, 0);
> > +    if (ctx->mmap_toeplitz_key =3D=3D MAP_FAILED) {
> > +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF toeplitz key")=
;
> > +        goto toeplitz_fail;
> > +    }
> > +    ctx->mmap_indirections_table =3D mmap(NULL, qemu_real_host_page_si=
ze(),
> > +                                   PROT_READ | PROT_WRITE, MAP_SHARED,
> > +                                   ctx->map_indirections_table, 0);
> > +    if (ctx->mmap_indirections_table =3D=3D MAP_FAILED) {
> > +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF indirection ta=
ble");
> > +        goto indirection_fail;
> > +    }
> > +
> > +    return true;
> > +
> > +indirection_fail:
> > +    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
> > +toeplitz_fail:
> > +    munmap(ctx->mmap_configuration, qemu_real_host_page_size());
> > +
> > +    ctx->mmap_configuration =3D NULL;
> > +    ctx->mmap_toeplitz_key =3D NULL;
> > +    ctx->mmap_indirections_table =3D NULL;
> > +    return false;
> > +}
> > +
> > +static void ebpf_rss_munmap(struct EBPFRSSContext *ctx)
> > +{
> > +    if (!ebpf_rss_is_loaded(ctx)) {
> > +        return;
> > +    }
> > +
> > +    munmap(ctx->mmap_indirections_table, qemu_real_host_page_size());
> > +    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
> > +    munmap(ctx->mmap_configuration, qemu_real_host_page_size());
> > +
> > +    ctx->mmap_configuration =3D NULL;
> > +    ctx->mmap_toeplitz_key =3D NULL;
> > +    ctx->mmap_indirections_table =3D NULL;
> >  }
> >
> >  bool ebpf_rss_load(struct EBPFRSSContext *ctx)
> >  {
> >      struct rss_bpf *rss_bpf_ctx;
> >
> > -    if (ctx =3D=3D NULL) {
> > +    if (ctx =3D=3D NULL || ebpf_rss_is_loaded(ctx)) {
> >          return false;
> >      }
> >
> > @@ -66,10 +130,18 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
> >      ctx->map_toeplitz_key =3D bpf_map__fd(
> >              rss_bpf_ctx->maps.tap_rss_map_toeplitz_key);
> >
> > +    if (!ebpf_rss_mmap(ctx)) {
> > +        goto error;
> > +    }
> > +
> >      return true;
> >  error:
> >      rss_bpf__destroy(rss_bpf_ctx);
> >      ctx->obj =3D NULL;
> > +    ctx->program_fd =3D -1;
> > +    ctx->map_configuration =3D -1;
> > +    ctx->map_toeplitz_key =3D -1;
> > +    ctx->map_indirections_table =3D -1;
> >
> >      return false;
> >  }
> > @@ -77,15 +149,11 @@ error:
> >  static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,
> >                                  struct EBPFRSSConfig *config)
> >  {
> > -    uint32_t map_key =3D 0;
> > -
> >      if (!ebpf_rss_is_loaded(ctx)) {
> >          return false;
> >      }
> > -    if (bpf_map_update_elem(ctx->map_configuration,
> > -                            &map_key, config, 0) < 0) {
> > -        return false;
> > -    }
> > +
> > +    memcpy(ctx->mmap_configuration, config, sizeof(*config));
> >      return true;
> >  }
> >
> > @@ -93,27 +161,19 @@ static bool ebpf_rss_set_indirections_table(struct=
 EBPFRSSContext *ctx,
> >                                              uint16_t *indirections_tab=
le,
> >                                              size_t len)
> >  {
> > -    uint32_t i =3D 0;
> > -
> >      if (!ebpf_rss_is_loaded(ctx) || indirections_table =3D=3D NULL ||
> >         len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
> >          return false;
> >      }
> >
> > -    for (; i < len; ++i) {
> > -        if (bpf_map_update_elem(ctx->map_indirections_table, &i,
> > -                                indirections_table + i, 0) < 0) {
> > -            return false;
> > -        }
> > -    }
> > +    memcpy(ctx->mmap_indirections_table, indirections_table,
> > +            sizeof(*indirections_table) * len);
>
> As discussed, should we stick the compatibility on the host without
> bpf mmap support?
>
> If we don't, we need at least probe BPF mmap and disable ebpf rss? If
> yes, we should track if the map is mmaped and switch between memcpy
> and syscall.
>
> Thanks

I've made some tests.
I've checked eBPF program on kernels 5.4, 5.5, and 6.3 with libbpf
1.0.1, 1.1.0, and last 1.2.0.
Overall, eBPF program requires explicit declaration of BPF_F_MAPPABLE map_f=
lags.
Without this flag, the program can be loaded on every tested
kernel/libbpf configuration but Qemu can't mmap() the eBPF
fds(obviously).
Alternative to mmap() is bpf_map_update_elem() syscall/method which
would require capabilities for Qemu.
With this flag, kernel 5.4 + libbpf can't load eBPF object.
So, compatibility would require 2 different eBPF objects or some kind
of hack, also it would require additional capability for Qemu.
I don't think that we need checks for disabling eBPF RSS. It wouldn't
brake anything on the old kernel and after an update, it should work
ok.

>
> >      return true;
> >  }
> >
> >  static bool ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,
> >                                       uint8_t *toeplitz_key)
> >  {
> > -    uint32_t map_key =3D 0;
> > -
> >      /* prepare toeplitz key */
> >      uint8_t toe[VIRTIO_NET_RSS_MAX_KEY_SIZE] =3D {};
> >
> > @@ -123,10 +183,7 @@ static bool ebpf_rss_set_toepliz_key(struct EBPFRS=
SContext *ctx,
> >      memcpy(toe, toeplitz_key, VIRTIO_NET_RSS_MAX_KEY_SIZE);
> >      *(uint32_t *)toe =3D ntohl(*(uint32_t *)toe);
> >
> > -    if (bpf_map_update_elem(ctx->map_toeplitz_key, &map_key, toe,
> > -                            0) < 0) {
> > -        return false;
> > -    }
> > +    memcpy(ctx->mmap_toeplitz_key, toe, VIRTIO_NET_RSS_MAX_KEY_SIZE);
> >      return true;
> >  }
> >
> > @@ -160,6 +217,20 @@ void ebpf_rss_unload(struct EBPFRSSContext *ctx)
> >          return;
> >      }
> >
> > -    rss_bpf__destroy(ctx->obj);
> > +    ebpf_rss_munmap(ctx);
> > +
> > +    if (ctx->obj) {
> > +        rss_bpf__destroy(ctx->obj);
> > +    } else {
> > +        close(ctx->program_fd);
> > +        close(ctx->map_configuration);
> > +        close(ctx->map_toeplitz_key);
> > +        close(ctx->map_indirections_table);
> > +    }
> > +
> >      ctx->obj =3D NULL;
> > +    ctx->program_fd =3D -1;
> > +    ctx->map_configuration =3D -1;
> > +    ctx->map_toeplitz_key =3D -1;
> > +    ctx->map_indirections_table =3D -1;
> >  }
> > diff --git a/ebpf/ebpf_rss.h b/ebpf/ebpf_rss.h
> > index bf3f2572c7c..ab08a7266d0 100644
> > --- a/ebpf/ebpf_rss.h
> > +++ b/ebpf/ebpf_rss.h
> > @@ -20,6 +20,11 @@ struct EBPFRSSContext {
> >      int map_configuration;
> >      int map_toeplitz_key;
> >      int map_indirections_table;
> > +
> > +    /* mapped eBPF maps for direct access to omit bpf_map_update_elem(=
) */
> > +    void *mmap_configuration;
> > +    void *mmap_toeplitz_key;
> > +    void *mmap_indirections_table;
> >  };
> >
> >  struct EBPFRSSConfig {
> > --
> > 2.41.0
> >
>


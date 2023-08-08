Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F5E7736DB
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 04:41:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTCdH-00045r-00; Mon, 07 Aug 2023 22:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qTCdC-00045h-IA
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 22:39:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qTCd9-0005rn-UB
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 22:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691462371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jqkKW7cGTuNOUpogNbIEgXpCg6OhtKLeCV99qALBa84=;
 b=DOrqAApLvmLzE9ygFS3zGqZAkfN0//pm9fJaImDxY4m9Rd9VA8LxgyRzBwzEGL3iXfQXni
 9YIf1qnmxk1s+P8dahWGZr3W3E/KSzmoaQinTPbVUZesz35XfKPGxqzTWYECpuwaunwyD4
 Y91y6jbyij0zYQUx1LBn2wdUTIvyfJ0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-8bQkYlknM3iRwhp0QcxCzQ-1; Mon, 07 Aug 2023 22:39:27 -0400
X-MC-Unique: 8bQkYlknM3iRwhp0QcxCzQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b9e8abe56bso49485581fa.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 19:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691462366; x=1692067166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jqkKW7cGTuNOUpogNbIEgXpCg6OhtKLeCV99qALBa84=;
 b=Q7eUneytyZSypF/pzHxbbbR5hgqGX14T7LALFU3+X4iIKiwnLtmRxm+YTe9uBW2gyj
 2WS3FDVX+GkRpPHtk3tUXDgB8AgoCPK89WIwE0vISc0UpBX0Z8MpkyZX6O9c/N3dtATV
 N3J4YEnV2x0T7g22oBj0sYoI1YYCEGwMvBNhdDNP3mdV+JGK9K27MmEcrcw+nXKXGMoY
 VwjnpK3cD5rE4/JzaJlLADB9zalNuHXzot6QfS2YhbLqv9vr19vaZX4Aaqx4ZhL1zgSy
 bpt6Km8ZnuMnobE4WHbNXal5nPdvK4IL3BpFkaTKhzehoiV1Wl72bxLrccFNKZw0Pz/n
 zt+w==
X-Gm-Message-State: AOJu0Yyy130s4yfFjxlk9CA2zCcYJ+JFHwVimm6DhvCFYQCSITb4bH4c
 URRzLtZAkl5YXrM+R31henjK5Ufv+GjK6GcIJYQiLlUbg4CKDkgs4cODDA7w/2DItlfdDsny0WI
 r2g7XyjU2NETe237sG3Rkexe3NEGNemM=
X-Received: by 2002:a2e:9217:0:b0:2b9:f31e:51ff with SMTP id
 k23-20020a2e9217000000b002b9f31e51ffmr7780893ljg.37.1691462365895; 
 Mon, 07 Aug 2023 19:39:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt6klFPiGftwMRffQFjsJmRmj3mWbzKUgP57tQV4/wlwCkoxuP9ZaxFDxBKQ2QCr1fkFa2P8i0dQBrmBpsLio=
X-Received: by 2002:a2e:9217:0:b0:2b9:f31e:51ff with SMTP id
 k23-20020a2e9217000000b002b9f31e51ffmr7780880ljg.37.1691462365508; Mon, 07
 Aug 2023 19:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230802204125.33688-1-andrew@daynix.com>
 <20230802204125.33688-2-andrew@daynix.com>
In-Reply-To: <20230802204125.33688-2-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Aug 2023 10:39:14 +0800
Message-ID: <CACGkMEshvbR3kK+NWqHqDZBkDNLHkWPtxTPE-hVhtaSzAeBvcA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] ebpf: Added eBPF map update through mmap.
To: Andrew Melnychenko <andrew@daynix.com>
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

On Thu, Aug 3, 2023 at 5:01=E2=80=AFAM Andrew Melnychenko <andrew@daynix.co=
m> wrote:
>
> Changed eBPF map updates through mmaped array.
> Mmaped arrays provide direct access to map data.
> It should omit using bpf_map_update_elem() call,
> which may require capabilities that are not present.
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  ebpf/ebpf_rss.c | 117 ++++++++++++++++++++++++++++++++++++++----------
>  ebpf/ebpf_rss.h |   5 +++
>  2 files changed, 99 insertions(+), 23 deletions(-)
>
> diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
> index cee658c158b..247f5eee1b6 100644
> --- a/ebpf/ebpf_rss.c
> +++ b/ebpf/ebpf_rss.c
> @@ -27,19 +27,83 @@ void ebpf_rss_init(struct EBPFRSSContext *ctx)
>  {
>      if (ctx !=3D NULL) {
>          ctx->obj =3D NULL;
> +        ctx->program_fd =3D -1;
> +        ctx->map_configuration =3D -1;
> +        ctx->map_toeplitz_key =3D -1;
> +        ctx->map_indirections_table =3D -1;
> +
> +        ctx->mmap_configuration =3D NULL;
> +        ctx->mmap_toeplitz_key =3D NULL;
> +        ctx->mmap_indirections_table =3D NULL;
>      }
>  }
>
>  bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)
>  {
> -    return ctx !=3D NULL && ctx->obj !=3D NULL;
> +    return ctx !=3D NULL && (ctx->obj !=3D NULL || ctx->program_fd !=3D =
-1);
> +}
> +
> +static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
> +{
> +    if (!ebpf_rss_is_loaded(ctx)) {
> +        return false;
> +    }
> +
> +    ctx->mmap_configuration =3D mmap(NULL, qemu_real_host_page_size(),
> +                                   PROT_READ | PROT_WRITE, MAP_SHARED,
> +                                   ctx->map_configuration, 0);
> +    if (ctx->mmap_configuration =3D=3D MAP_FAILED) {
> +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF configuration ar=
ray");
> +        return false;
> +    }
> +    ctx->mmap_toeplitz_key =3D mmap(NULL, qemu_real_host_page_size(),
> +                                   PROT_READ | PROT_WRITE, MAP_SHARED,
> +                                   ctx->map_toeplitz_key, 0);
> +    if (ctx->mmap_toeplitz_key =3D=3D MAP_FAILED) {
> +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF toeplitz key");
> +        goto toeplitz_fail;
> +    }
> +    ctx->mmap_indirections_table =3D mmap(NULL, qemu_real_host_page_size=
(),
> +                                   PROT_READ | PROT_WRITE, MAP_SHARED,
> +                                   ctx->map_indirections_table, 0);
> +    if (ctx->mmap_indirections_table =3D=3D MAP_FAILED) {
> +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF indirection tabl=
e");
> +        goto indirection_fail;
> +    }
> +
> +    return true;
> +
> +indirection_fail:
> +    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
> +toeplitz_fail:
> +    munmap(ctx->mmap_configuration, qemu_real_host_page_size());
> +
> +    ctx->mmap_configuration =3D NULL;
> +    ctx->mmap_toeplitz_key =3D NULL;
> +    ctx->mmap_indirections_table =3D NULL;
> +    return false;
> +}
> +
> +static void ebpf_rss_munmap(struct EBPFRSSContext *ctx)
> +{
> +    if (!ebpf_rss_is_loaded(ctx)) {
> +        return;
> +    }
> +
> +    munmap(ctx->mmap_indirections_table, qemu_real_host_page_size());
> +    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
> +    munmap(ctx->mmap_configuration, qemu_real_host_page_size());
> +
> +    ctx->mmap_configuration =3D NULL;
> +    ctx->mmap_toeplitz_key =3D NULL;
> +    ctx->mmap_indirections_table =3D NULL;
>  }
>
>  bool ebpf_rss_load(struct EBPFRSSContext *ctx)
>  {
>      struct rss_bpf *rss_bpf_ctx;
>
> -    if (ctx =3D=3D NULL) {
> +    if (ctx =3D=3D NULL || ebpf_rss_is_loaded(ctx)) {
>          return false;
>      }
>
> @@ -66,10 +130,18 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
>      ctx->map_toeplitz_key =3D bpf_map__fd(
>              rss_bpf_ctx->maps.tap_rss_map_toeplitz_key);
>
> +    if (!ebpf_rss_mmap(ctx)) {
> +        goto error;
> +    }
> +
>      return true;
>  error:
>      rss_bpf__destroy(rss_bpf_ctx);
>      ctx->obj =3D NULL;
> +    ctx->program_fd =3D -1;
> +    ctx->map_configuration =3D -1;
> +    ctx->map_toeplitz_key =3D -1;
> +    ctx->map_indirections_table =3D -1;
>
>      return false;
>  }
> @@ -77,15 +149,11 @@ error:
>  static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,
>                                  struct EBPFRSSConfig *config)
>  {
> -    uint32_t map_key =3D 0;
> -
>      if (!ebpf_rss_is_loaded(ctx)) {
>          return false;
>      }
> -    if (bpf_map_update_elem(ctx->map_configuration,
> -                            &map_key, config, 0) < 0) {
> -        return false;
> -    }
> +
> +    memcpy(ctx->mmap_configuration, config, sizeof(*config));
>      return true;
>  }
>
> @@ -93,27 +161,19 @@ static bool ebpf_rss_set_indirections_table(struct E=
BPFRSSContext *ctx,
>                                              uint16_t *indirections_table=
,
>                                              size_t len)
>  {
> -    uint32_t i =3D 0;
> -
>      if (!ebpf_rss_is_loaded(ctx) || indirections_table =3D=3D NULL ||
>         len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
>          return false;
>      }
>
> -    for (; i < len; ++i) {
> -        if (bpf_map_update_elem(ctx->map_indirections_table, &i,
> -                                indirections_table + i, 0) < 0) {
> -            return false;
> -        }
> -    }
> +    memcpy(ctx->mmap_indirections_table, indirections_table,
> +            sizeof(*indirections_table) * len);

As discussed, should we stick the compatibility on the host without
bpf mmap support?

If we don't, we need at least probe BPF mmap and disable ebpf rss? If
yes, we should track if the map is mmaped and switch between memcpy
and syscall.

Thanks

>      return true;
>  }
>
>  static bool ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,
>                                       uint8_t *toeplitz_key)
>  {
> -    uint32_t map_key =3D 0;
> -
>      /* prepare toeplitz key */
>      uint8_t toe[VIRTIO_NET_RSS_MAX_KEY_SIZE] =3D {};
>
> @@ -123,10 +183,7 @@ static bool ebpf_rss_set_toepliz_key(struct EBPFRSSC=
ontext *ctx,
>      memcpy(toe, toeplitz_key, VIRTIO_NET_RSS_MAX_KEY_SIZE);
>      *(uint32_t *)toe =3D ntohl(*(uint32_t *)toe);
>
> -    if (bpf_map_update_elem(ctx->map_toeplitz_key, &map_key, toe,
> -                            0) < 0) {
> -        return false;
> -    }
> +    memcpy(ctx->mmap_toeplitz_key, toe, VIRTIO_NET_RSS_MAX_KEY_SIZE);
>      return true;
>  }
>
> @@ -160,6 +217,20 @@ void ebpf_rss_unload(struct EBPFRSSContext *ctx)
>          return;
>      }
>
> -    rss_bpf__destroy(ctx->obj);
> +    ebpf_rss_munmap(ctx);
> +
> +    if (ctx->obj) {
> +        rss_bpf__destroy(ctx->obj);
> +    } else {
> +        close(ctx->program_fd);
> +        close(ctx->map_configuration);
> +        close(ctx->map_toeplitz_key);
> +        close(ctx->map_indirections_table);
> +    }
> +
>      ctx->obj =3D NULL;
> +    ctx->program_fd =3D -1;
> +    ctx->map_configuration =3D -1;
> +    ctx->map_toeplitz_key =3D -1;
> +    ctx->map_indirections_table =3D -1;
>  }
> diff --git a/ebpf/ebpf_rss.h b/ebpf/ebpf_rss.h
> index bf3f2572c7c..ab08a7266d0 100644
> --- a/ebpf/ebpf_rss.h
> +++ b/ebpf/ebpf_rss.h
> @@ -20,6 +20,11 @@ struct EBPFRSSContext {
>      int map_configuration;
>      int map_toeplitz_key;
>      int map_indirections_table;
> +
> +    /* mapped eBPF maps for direct access to omit bpf_map_update_elem() =
*/
> +    void *mmap_configuration;
> +    void *mmap_toeplitz_key;
> +    void *mmap_indirections_table;
>  };
>
>  struct EBPFRSSConfig {
> --
> 2.41.0
>



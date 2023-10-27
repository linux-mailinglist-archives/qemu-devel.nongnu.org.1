Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 575637D8F3B
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:08:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwGwC-0007BD-83; Fri, 27 Oct 2023 03:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qwGw9-0007Ao-Vf
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 03:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qwGw8-0004qf-4m
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 03:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698390434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2unHgdsW3ogKSGp5Gjo62UTq45Yff+3C64I/AkUvlXI=;
 b=ZlD7SRhZcwiE9A7uqEWZ77PQ2Z82zSppB8bS+3kjJZ+cCJNbQEqPh0n9KF6Gat7tTvPKAN
 g778eaPMlUJvzCI2MxsgawwGTGuW0e3teCINDnhxXuXJzSfOKEDqZ/2iN695oKmjIyEW3v
 HnnfMeTkz6lLLFGmjIX0u6/hk5f91Jk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-08f0_B-4P4ONDQQGoO839g-1; Fri, 27 Oct 2023 03:07:12 -0400
X-MC-Unique: 08f0_B-4P4ONDQQGoO839g-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-507a3ae32b2so1976375e87.2
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 00:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698390431; x=1698995231;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2unHgdsW3ogKSGp5Gjo62UTq45Yff+3C64I/AkUvlXI=;
 b=es0UgDX0gPdWMTRVzm+R1rrtAO70yC8s2tODOzD+3JuSldcNZXCsWzlxjSAprbld00
 Ti2H2Gg8t3TgMaEVTGiwlPuGIjAmWXKq1xBh9uEEdFeJl+Tv+4dPTcSRVMhsMl1D5d8D
 ESy66A84nPOWvLpb3F27jkuZJLjOVuGik/TS558nvKVW7jYVOzB9HKauTc7DN8zJccTW
 SK9KhoJz9nflthQcDSjnxr8BEtSlRGt+vU6f95VQcI3VnXSW8YWUV9MeIteUZMhuQoyG
 QKTbBZAzeb2I0n9bVmMOCLmjjWL9eIs8hdyMakHVDGwjGg9eDIHGcsTgcul/vDrx9V+0
 D4pQ==
X-Gm-Message-State: AOJu0Yy1/epJS5dw6Qz9gs1u2WznbPUoQgT3B3Cvo1xfJuT6j1K2MxKZ
 liNPo3w1zdSHVBuuaagO6EtSMeR03pxjEnKOAD6I53ofLHaIDOY3jOefKzdbDffeverQpmWbkZW
 zKuVfl3MM1oUmz8hQ9NsU+pcdX5i1zho=
X-Received: by 2002:ac2:4105:0:b0:4fb:bef0:948e with SMTP id
 b5-20020ac24105000000b004fbbef0948emr1010357lfi.5.1698390431351; 
 Fri, 27 Oct 2023 00:07:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPPAmkKKQevgLg3+xi5hDJ0XzRVpLKzRnQ20gZb9H42rd5k3RYPReH5+lt9kfcWX7s7cbjIDmS2AJ2wj1zfeI=
X-Received: by 2002:ac2:4105:0:b0:4fb:bef0:948e with SMTP id
 b5-20020ac24105000000b004fbbef0948emr1010346lfi.5.1698390430983; Fri, 27 Oct
 2023 00:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
 <20231017040932.62997-12-akihiko.odaki@daynix.com>
In-Reply-To: <20231017040932.62997-12-akihiko.odaki@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Oct 2023 15:07:00 +0800
Message-ID: <CACGkMEvY4fjrBgjLMFRNN0LmJ+iQaC=z3KTumwB=+d1Ofz0yzg@mail.gmail.com>
Subject: Re: [PATCH v5 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 17, 2023 at 12:10=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> vhost requires eBPF for RSS. Even when eBPF is not available, virtio-net
> reported RSS availability, and raised a warning only after the
> guest requested RSS, and the guest could not know that RSS is not
> available.
>
> Check RSS availability during device realization and return an error
> if RSS is requested but not available. Assert RSS availability when
> the guest actually requests the feature.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  ebpf/ebpf_rss.h      |   2 +-
>  ebpf/ebpf_rss-stub.c |   4 +-
>  ebpf/ebpf_rss.c      |  68 +++++++++-----------------
>  hw/net/virtio-net.c  | 114 +++++++++++++++++++++----------------------
>  4 files changed, 82 insertions(+), 106 deletions(-)
>
> diff --git a/ebpf/ebpf_rss.h b/ebpf/ebpf_rss.h
> index bf3f2572c7..1128173572 100644
> --- a/ebpf/ebpf_rss.h
> +++ b/ebpf/ebpf_rss.h
> @@ -36,7 +36,7 @@ bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx);
>
>  bool ebpf_rss_load(struct EBPFRSSContext *ctx);
>
> -bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *=
config,
> +void ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *=
config,
>                        uint16_t *indirections_table, uint8_t *toeplitz_ke=
y);
>
>  void ebpf_rss_unload(struct EBPFRSSContext *ctx);
> diff --git a/ebpf/ebpf_rss-stub.c b/ebpf/ebpf_rss-stub.c
> index e71e229190..525b358597 100644
> --- a/ebpf/ebpf_rss-stub.c
> +++ b/ebpf/ebpf_rss-stub.c
> @@ -28,10 +28,10 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
>      return false;
>  }
>
> -bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *=
config,
> +void ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *=
config,
>                        uint16_t *indirections_table, uint8_t *toeplitz_ke=
y)
>  {
> -    return false;
> +    g_assert_not_reached();
>  }
>
>  void ebpf_rss_unload(struct EBPFRSSContext *ctx)
> diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
> index cee658c158..6cdf82d059 100644
> --- a/ebpf/ebpf_rss.c
> +++ b/ebpf/ebpf_rss.c
> @@ -74,42 +74,32 @@ error:
>      return false;
>  }
>
> -static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,
> +static void ebpf_rss_set_config(struct EBPFRSSContext *ctx,
>                                  struct EBPFRSSConfig *config)
>  {
>      uint32_t map_key =3D 0;
>
> -    if (!ebpf_rss_is_loaded(ctx)) {
> -        return false;
> -    }
> -    if (bpf_map_update_elem(ctx->map_configuration,
> -                            &map_key, config, 0) < 0) {
> -        return false;
> -    }
> -    return true;
> +    assert(ebpf_rss_is_loaded(ctx));
> +    assert(!bpf_map_update_elem(ctx->map_configuration, &map_key, config=
, 0));

Guest trigger-rable assertion should be avoided as much as possible.

Thanks



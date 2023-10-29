Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7D37DAEC4
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 23:17:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxE5D-0002UP-Ue; Sun, 29 Oct 2023 18:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qxE51-0002Mq-Ul
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 18:16:33 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qxE4v-00026N-71
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 18:16:20 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c6b48cb2b6so15683251fa.2
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 15:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698617768; x=1699222568;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BGzCiJmDIETYEQ64pdolEVu3tp3edFoCG5ZkdJdU3FY=;
 b=p/Yr3IKheln2ytxHyWt+XDcIocW1HyBjtobhEn9lJFwkoJZlW5x0paulxTnco/edMf
 75BPTUWo0UACcuKY1GOOHJ5K1w0XPomeIqDOVWY0QNHpFG1lmkzNw7Q2/P0hBCw2NLnf
 SNpMh9apdggMLuq45i5PieXiEo22UjUzV9wr6MgSNScaXqPTnveih1w0EkxtLAYJb+He
 KxW9VebifCf7HCN0EvlZ9wsaF4vjY2ss1yF0tektpKadrg8CpBTdGoAd14Mq8pN8NXfp
 3IS6vrRc39E/IBZP/DOrq0msfTDcwXcwMQ2arlQO/QO9nQd++/viddKOoHP67nTAwjJF
 cSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698617768; x=1699222568;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BGzCiJmDIETYEQ64pdolEVu3tp3edFoCG5ZkdJdU3FY=;
 b=l7hpYm8XfPZVDJAZwANRjUE1nIW6hDg4IKUIWgwn2AeHcfWytmF+Ni+6I+QTnQcobo
 nWAnDS4Kuk2r1oBTzd2PBa/R5DglRgKRrolF8dqo88tI+31HrHsdv6+sybz30s1AOGLx
 ouLE5aK/+mJ9l8yyAooUzL9Nu/q+VLvk8ULgV1E4ghcd+Xqw3LojJh02QwYBQHnRJuW4
 pLhMChv3zsxbRVYEF9e9rH7vJ4ZoumtENDtz0pwBeIdd5xkGBq4ilh9ELzgfIWs3zw+o
 KhLT1cOQc8T2tUSZvSEiEkKlxaIcR514F7LSsPc7cBunHTSnTmvF8LN6I6RUp3VT1FWs
 xZqg==
X-Gm-Message-State: AOJu0Yz61P3V0Ry/lDXIE+AhXZ8YgWYUk/jgGfHV758ewDVJNVO2IPf3
 lZhybKfoBqLdY8y8BlVPwp75n93aZuke+5DIP29N6w==
X-Google-Smtp-Source: AGHT+IF/4QT9o4ZnubqPPZXrsAj+k/jBY6eIlUJfL/W767s/xtBlY/H93hxbwJQsYcQX4/hyvGD8wvkMo9eUPF/GT0U=
X-Received: by 2002:a2e:9049:0:b0:2bc:db99:1775 with SMTP id
 n9-20020a2e9049000000b002bcdb991775mr5263639ljg.26.1698617768011; Sun, 29 Oct
 2023 15:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
 <20231017040932.62997-12-akihiko.odaki@daynix.com>
In-Reply-To: <20231017040932.62997-12-akihiko.odaki@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 30 Oct 2023 00:15:56 +0200
Message-ID: <CAOEp5OfG4nY9ymuryyARuCeOC3Y2uyFzeuAZOTR5qDkJcTL_BQ@mail.gmail.com>
Subject: Re: [PATCH v5 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000abfab00608e244e6"
Received-SPF: none client-ip=2a00:1450:4864:20::230;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lj1-x230.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000abfab00608e244e6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 7:10=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com>
wrote:

> vhost requires eBPF for RSS. Even when eBPF is not available, virtio-net
> reported RSS availability, and raised a warning only after the
> guest requested RSS, and the guest could not know that RSS is not
> available.
>
>
The existing code suggests the RSS feature for vhost case only when the
ebpf is loaded.
https://github.com/qemu/qemu/blob/master/hw/net/virtio-net.c#L828
Am I wrong?



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
> -bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig
> *config,
> +void ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig
> *config,
>                        uint16_t *indirections_table, uint8_t
> *toeplitz_key);
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
> -bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig
> *config,
> +void ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig
> *config,
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
,
> 0));
>  }
>
> -static bool ebpf_rss_set_indirections_table(struct EBPFRSSContext *ctx,
> +static void ebpf_rss_set_indirections_table(struct EBPFRSSContext *ctx,
>                                              uint16_t *indirections_table=
,
>                                              size_t len)
>  {
>      uint32_t i =3D 0;
>
> -    if (!ebpf_rss_is_loaded(ctx) || indirections_table =3D=3D NULL ||
> -       len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
> -        return false;
> -    }
> +    assert(ebpf_rss_is_loaded(ctx));
> +    assert(indirections_table);
> +    assert(len <=3D VIRTIO_NET_RSS_MAX_TABLE_LEN);
>
>      for (; i < len; ++i) {
> -        if (bpf_map_update_elem(ctx->map_indirections_table, &i,
> -                                indirections_table + i, 0) < 0) {
> -            return false;
> -        }
> +        assert(!bpf_map_update_elem(ctx->map_indirections_table, &i,
> +                                    indirections_table + i, 0));
>      }
> -    return true;
>  }
>
> -static bool ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,
> +static void ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,
>                                       uint8_t *toeplitz_key)
>  {
>      uint32_t map_key =3D 0;
> @@ -117,41 +107,29 @@ static bool ebpf_rss_set_toepliz_key(struct
> EBPFRSSContext *ctx,
>      /* prepare toeplitz key */
>      uint8_t toe[VIRTIO_NET_RSS_MAX_KEY_SIZE] =3D {};
>
> -    if (!ebpf_rss_is_loaded(ctx) || toeplitz_key =3D=3D NULL) {
> -        return false;
> -    }
> +    assert(ebpf_rss_is_loaded(ctx));
> +    assert(toeplitz_key);
> +
>      memcpy(toe, toeplitz_key, VIRTIO_NET_RSS_MAX_KEY_SIZE);
>      *(uint32_t *)toe =3D ntohl(*(uint32_t *)toe);
>
> -    if (bpf_map_update_elem(ctx->map_toeplitz_key, &map_key, toe,
> -                            0) < 0) {
> -        return false;
> -    }
> -    return true;
> +    assert(!bpf_map_update_elem(ctx->map_toeplitz_key, &map_key, toe, 0)=
);
>  }
>
> -bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig
> *config,
> +void ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig
> *config,
>                        uint16_t *indirections_table, uint8_t *toeplitz_ke=
y)
>  {
> -    if (!ebpf_rss_is_loaded(ctx) || config =3D=3D NULL ||
> -        indirections_table =3D=3D NULL || toeplitz_key =3D=3D NULL) {
> -        return false;
> -    }
> -
> -    if (!ebpf_rss_set_config(ctx, config)) {
> -        return false;
> -    }
> +    assert(ebpf_rss_is_loaded(ctx));
> +    assert(config);
> +    assert(indirections_table);
> +    assert(toeplitz_key);
>
> -    if (!ebpf_rss_set_indirections_table(ctx, indirections_table,
> -                                      config->indirections_len)) {
> -        return false;
> -    }
> +    ebpf_rss_set_config(ctx, config);
>
> -    if (!ebpf_rss_set_toepliz_key(ctx, toeplitz_key)) {
> -        return false;
> -    }
> +    ebpf_rss_set_indirections_table(ctx, indirections_table,
> +                                    config->indirections_len);
>
> -    return true;
> +    ebpf_rss_set_toepliz_key(ctx, toeplitz_key);
>  }
>
>  void ebpf_rss_unload(struct EBPFRSSContext *ctx)
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 25fc06bd93..20feb20bb1 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1242,14 +1242,10 @@ static bool virtio_net_attach_epbf_rss(VirtIONet
> *n)
>
>      rss_data_to_rss_config(&n->rss_data, &config);
>
> -    if (!ebpf_rss_set_all(&n->ebpf_rss, &config,
> -                          n->rss_data.indirections_table,
> n->rss_data.key)) {
> -        return false;
> -    }
> +    ebpf_rss_set_all(&n->ebpf_rss, &config,
> +                     n->rss_data.indirections_table, n->rss_data.key);
>
> -    if (!virtio_net_attach_ebpf_to_backend(n->nic,
> n->ebpf_rss.program_fd)) {
> -        return false;
> -    }
> +    assert(virtio_net_attach_ebpf_to_backend(n->nic,
> n->ebpf_rss.program_fd));
>
>      return true;
>  }
> @@ -1266,12 +1262,7 @@ static void virtio_net_commit_rss_config(VirtIONet
> *n)
>          if (n->rss_data.populate_hash) {
>              virtio_net_detach_epbf_rss(n);
>          } else if (!virtio_net_attach_epbf_rss(n)) {
> -            if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
> -                warn_report("Can't use eBPF RSS for vhost");
> -            } else {
> -                warn_report("Can't use eBPF RSS - fallback to software
> RSS");
> -                n->rss_data.enabled_software_rss =3D true;
> -            }
> +            n->rss_data.enabled_software_rss =3D true;
>          }
>
>          trace_virtio_net_rss_enable(n->rss_data.hash_types,
> @@ -3514,6 +3505,50 @@ static bool
> failover_hide_primary_device(DeviceListener *listener,
>      return qatomic_read(&n->failover_primary_hidden);
>  }
>
> +static void virtio_net_device_unrealize(DeviceState *dev)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    VirtIONet *n =3D VIRTIO_NET(dev);
> +    int i, max_queue_pairs;
> +
> +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> +        virtio_net_unload_ebpf(n);
> +    }
> +
> +    /* This will stop vhost backend if appropriate. */
> +    virtio_net_set_status(vdev, 0);
> +
> +    g_free(n->netclient_name);
> +    n->netclient_name =3D NULL;
> +    g_free(n->netclient_type);
> +    n->netclient_type =3D NULL;
> +
> +    g_free(n->mac_table.macs);
> +    g_free(n->vlans);
> +
> +    if (n->failover) {
> +        qobject_unref(n->primary_opts);
> +        device_listener_unregister(&n->primary_listener);
> +        remove_migration_state_change_notifier(&n->migration_state);
> +    } else {
> +        assert(n->primary_opts =3D=3D NULL);
> +    }
> +
> +    max_queue_pairs =3D n->multiqueue ? n->max_queue_pairs : 1;
> +    for (i =3D 0; i < max_queue_pairs; i++) {
> +        virtio_net_del_queue(n, i);
> +    }
> +    /* delete also control vq */
> +    virtio_del_queue(vdev, max_queue_pairs * 2);
> +    qemu_announce_timer_del(&n->announce_timer, false);
> +    g_free(n->vqs);
> +    qemu_del_nic(n->nic);
> +    virtio_net_rsc_cleanup(n);
> +    g_free(n->rss_data.indirections_table);
> +    net_rx_pkt_uninit(n->rx_pkt);
> +    virtio_cleanup(vdev);
> +}
> +
>  static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> @@ -3685,53 +3720,16 @@ static void virtio_net_device_realize(DeviceState
> *dev, Error **errp)
>
>      net_rx_pkt_init(&n->rx_pkt);
>
> -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> -        virtio_net_load_ebpf(n);
> -    }
> -}
> -
> -static void virtio_net_device_unrealize(DeviceState *dev)
> -{
> -    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> -    VirtIONet *n =3D VIRTIO_NET(dev);
> -    int i, max_queue_pairs;
> -
> -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> -        virtio_net_unload_ebpf(n);
> -    }
> -
> -    /* This will stop vhost backend if appropriate. */
> -    virtio_net_set_status(vdev, 0);
> -
> -    g_free(n->netclient_name);
> -    n->netclient_name =3D NULL;
> -    g_free(n->netclient_type);
> -    n->netclient_type =3D NULL;
> -
> -    g_free(n->mac_table.macs);
> -    g_free(n->vlans);
> -
> -    if (n->failover) {
> -        qobject_unref(n->primary_opts);
> -        device_listener_unregister(&n->primary_listener);
> -        remove_migration_state_change_notifier(&n->migration_state);
> -    } else {
> -        assert(n->primary_opts =3D=3D NULL);
> -    }
> +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS) &&
> +        !virtio_net_load_ebpf(n)) {
> +        if (get_vhost_net(nc->peer)) {
> +            error_setg(errp, "Can't load eBPF RSS for vhost");
> +            virtio_net_device_unrealize(dev);
> +            return;
> +        }
>
> -    max_queue_pairs =3D n->multiqueue ? n->max_queue_pairs : 1;
> -    for (i =3D 0; i < max_queue_pairs; i++) {
> -        virtio_net_del_queue(n, i);
> +        warn_report_once("Can't load eBPF RSS - fallback to software
> RSS");
>      }
> -    /* delete also control vq */
> -    virtio_del_queue(vdev, max_queue_pairs * 2);
> -    qemu_announce_timer_del(&n->announce_timer, false);
> -    g_free(n->vqs);
> -    qemu_del_nic(n->nic);
> -    virtio_net_rsc_cleanup(n);
> -    g_free(n->rss_data.indirections_table);
> -    net_rx_pkt_uninit(n->rx_pkt);
> -    virtio_cleanup(vdev);
>  }
>
>  static void virtio_net_reset(VirtIODevice *vdev)
> --
> 2.42.0
>
>

--000000000000abfab00608e244e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 17, 2023 at 7:10=E2=80=AF=
AM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.od=
aki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">vhost requires eBPF for RSS. Even when eBPF is not available,=
 virtio-net<br>
reported RSS availability, and raised a warning only after the<br>
guest requested RSS, and the guest could not know that RSS is not<br>
available.<br>
<br>
</blockquote><div><br></div><div>The existing code suggests the RSS feature=
 for vhost case only when the ebpf is loaded.</div><div><a href=3D"https://=
github.com/qemu/qemu/blob/master/hw/net/virtio-net.c#L828">https://github.c=
om/qemu/qemu/blob/master/hw/net/virtio-net.c#L828</a><br></div><div>Am I wr=
ong?</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Check RSS availability during device realization and retur=
n an error<br>
if RSS is requested but not available. Assert RSS availability when<br>
the guest actually requests the feature.<br>
<br>
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
---<br>
=C2=A0ebpf/ebpf_rss.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0ebpf/ebpf_rss-stub.c |=C2=A0 =C2=A04 +-<br>
=C2=A0ebpf/ebpf_rss.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 68 +++++++++-------------=
----<br>
=C2=A0hw/net/virtio-net.c=C2=A0 | 114 +++++++++++++++++++++----------------=
------<br>
=C2=A04 files changed, 82 insertions(+), 106 deletions(-)<br>
<br>
diff --git a/ebpf/ebpf_rss.h b/ebpf/ebpf_rss.h<br>
index bf3f2572c7..1128173572 100644<br>
--- a/ebpf/ebpf_rss.h<br>
+++ b/ebpf/ebpf_rss.h<br>
@@ -36,7 +36,7 @@ bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx);<br>
<br>
=C2=A0bool ebpf_rss_load(struct EBPFRSSContext *ctx);<br>
<br>
-bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *co=
nfig,<br>
+void ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *co=
nfig,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint16_t *indirections_table, uint8_t *toeplitz_key);<br>
<br>
=C2=A0void ebpf_rss_unload(struct EBPFRSSContext *ctx);<br>
diff --git a/ebpf/ebpf_rss-stub.c b/ebpf/ebpf_rss-stub.c<br>
index e71e229190..525b358597 100644<br>
--- a/ebpf/ebpf_rss-stub.c<br>
+++ b/ebpf/ebpf_rss-stub.c<br>
@@ -28,10 +28,10 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0}<br>
<br>
-bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *co=
nfig,<br>
+void ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *co=
nfig,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint16_t *indirections_table, uint8_t *toeplitz_key)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 g_assert_not_reached();<br>
=C2=A0}<br>
<br>
=C2=A0void ebpf_rss_unload(struct EBPFRSSContext *ctx)<br>
diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c<br>
index cee658c158..6cdf82d059 100644<br>
--- a/ebpf/ebpf_rss.c<br>
+++ b/ebpf/ebpf_rss.c<br>
@@ -74,42 +74,32 @@ error:<br>
=C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0}<br>
<br>
-static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,<br>
+static void ebpf_rss_set_config(struct EBPFRSSContext *ctx,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct EBPFRSSConfig *config)<=
br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint32_t map_key =3D 0;<br>
<br>
-=C2=A0 =C2=A0 if (!ebpf_rss_is_loaded(ctx)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 if (bpf_map_update_elem(ctx-&gt;map_configuration,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;map_key, config, 0) &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 assert(ebpf_rss_is_loaded(ctx));<br>
+=C2=A0 =C2=A0 assert(!bpf_map_update_elem(ctx-&gt;map_configuration, &amp;=
map_key, config, 0));<br>
=C2=A0}<br>
<br>
-static bool ebpf_rss_set_indirections_table(struct EBPFRSSContext *ctx,<br=
>
+static void ebpf_rss_set_indirections_table(struct EBPFRSSContext *ctx,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0uint16_t *indirections_table,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0size_t len)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint32_t i =3D 0;<br>
<br>
-=C2=A0 =C2=A0 if (!ebpf_rss_is_loaded(ctx) || indirections_table =3D=3D NU=
LL ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0len &gt; VIRTIO_NET_RSS_MAX_TABLE_LEN) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 assert(ebpf_rss_is_loaded(ctx));<br>
+=C2=A0 =C2=A0 assert(indirections_table);<br>
+=C2=A0 =C2=A0 assert(len &lt;=3D VIRTIO_NET_RSS_MAX_TABLE_LEN);<br>
<br>
=C2=A0 =C2=A0 =C2=A0for (; i &lt; len; ++i) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bpf_map_update_elem(ctx-&gt;map_indirectio=
ns_table, &amp;i,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indirections_table + i, 0) &lt; 0) {=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(!bpf_map_update_elem(ctx-&gt;map_indire=
ctions_table, &amp;i,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indirections_table + i=
, 0));<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
-static bool ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,<br>
+static void ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t *toepli=
tz_key)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint32_t map_key =3D 0;<br>
@@ -117,41 +107,29 @@ static bool ebpf_rss_set_toepliz_key(struct EBPFRSSCo=
ntext *ctx,<br>
=C2=A0 =C2=A0 =C2=A0/* prepare toeplitz key */<br>
=C2=A0 =C2=A0 =C2=A0uint8_t toe[VIRTIO_NET_RSS_MAX_KEY_SIZE] =3D {};<br>
<br>
-=C2=A0 =C2=A0 if (!ebpf_rss_is_loaded(ctx) || toeplitz_key =3D=3D NULL) {<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 assert(ebpf_rss_is_loaded(ctx));<br>
+=C2=A0 =C2=A0 assert(toeplitz_key);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0memcpy(toe, toeplitz_key, VIRTIO_NET_RSS_MAX_KEY_SIZE);=
<br>
=C2=A0 =C2=A0 =C2=A0*(uint32_t *)toe =3D ntohl(*(uint32_t *)toe);<br>
<br>
-=C2=A0 =C2=A0 if (bpf_map_update_elem(ctx-&gt;map_toeplitz_key, &amp;map_k=
ey, toe,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0) &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 assert(!bpf_map_update_elem(ctx-&gt;map_toeplitz_key, &amp;m=
ap_key, toe, 0));<br>
=C2=A0}<br>
<br>
-bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *co=
nfig,<br>
+void ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *co=
nfig,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint16_t *indirections_table, uint8_t *toeplitz_key)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 if (!ebpf_rss_is_loaded(ctx) || config =3D=3D NULL ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 indirections_table =3D=3D NULL || toeplitz_key=
 =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (!ebpf_rss_set_config(ctx, config)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 assert(ebpf_rss_is_loaded(ctx));<br>
+=C2=A0 =C2=A0 assert(config);<br>
+=C2=A0 =C2=A0 assert(indirections_table);<br>
+=C2=A0 =C2=A0 assert(toeplitz_key);<br>
<br>
-=C2=A0 =C2=A0 if (!ebpf_rss_set_indirections_table(ctx, indirections_table=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;indi=
rections_len)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ebpf_rss_set_config(ctx, config);<br>
<br>
-=C2=A0 =C2=A0 if (!ebpf_rss_set_toepliz_key(ctx, toeplitz_key)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ebpf_rss_set_indirections_table(ctx, indirections_table,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;indirection=
s_len);<br>
<br>
-=C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 ebpf_rss_set_toepliz_key(ctx, toeplitz_key);<br>
=C2=A0}<br>
<br>
=C2=A0void ebpf_rss_unload(struct EBPFRSSContext *ctx)<br>
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
index 25fc06bd93..20feb20bb1 100644<br>
--- a/hw/net/virtio-net.c<br>
+++ b/hw/net/virtio-net.c<br>
@@ -1242,14 +1242,10 @@ static bool virtio_net_attach_epbf_rss(VirtIONet *n=
)<br>
<br>
=C2=A0 =C2=A0 =C2=A0rss_data_to_rss_config(&amp;n-&gt;rss_data, &amp;config=
);<br>
<br>
-=C2=A0 =C2=A0 if (!ebpf_rss_set_all(&amp;n-&gt;ebpf_rss, &amp;config,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 n-&gt;rss_data.indirections_table, n-&gt;rss_data.key)) {=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ebpf_rss_set_all(&amp;n-&gt;ebpf_rss, &amp;config,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0n-&gt;rss_data.indirections_table, n-&gt;rss_data.key);<br>
<br>
-=C2=A0 =C2=A0 if (!virtio_net_attach_ebpf_to_backend(n-&gt;nic, n-&gt;ebpf=
_rss.program_fd)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 assert(virtio_net_attach_ebpf_to_backend(n-&gt;nic, n-&gt;eb=
pf_rss.program_fd));<br>
<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
@@ -1266,12 +1262,7 @@ static void virtio_net_commit_rss_config(VirtIONet *=
n)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (n-&gt;rss_data.populate_hash) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_net_detach_epbf_rss(=
n);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!virtio_net_attach_epbf_rss(n)=
) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_vhost_net(qemu_get_queue=
(n-&gt;nic)-&gt;peer)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report(&quot;=
Can&#39;t use eBPF RSS for vhost&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report(&quot;=
Can&#39;t use eBPF RSS - fallback to software RSS&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rss_data.ena=
bled_software_rss =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rss_data.enabled_software_=
rss =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_virtio_net_rss_enable(n-&gt;rss_dat=
a.hash_types,<br>
@@ -3514,6 +3505,50 @@ static bool failover_hide_primary_device(DeviceListe=
ner *listener,<br>
=C2=A0 =C2=A0 =C2=A0return qatomic_read(&amp;n-&gt;failover_primary_hidden)=
;<br>
=C2=A0}<br>
<br>
+static void virtio_net_device_unrealize(DeviceState *dev)<br>
+{<br>
+=C2=A0 =C2=A0 VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);<br>
+=C2=A0 =C2=A0 VirtIONet *n =3D VIRTIO_NET(dev);<br>
+=C2=A0 =C2=A0 int i, max_queue_pairs;<br>
+<br>
+=C2=A0 =C2=A0 if (virtio_has_feature(n-&gt;host_features, VIRTIO_NET_F_RSS=
)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_unload_ebpf(n);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* This will stop vhost backend if appropriate. */<br>
+=C2=A0 =C2=A0 virtio_net_set_status(vdev, 0);<br>
+<br>
+=C2=A0 =C2=A0 g_free(n-&gt;netclient_name);<br>
+=C2=A0 =C2=A0 n-&gt;netclient_name =3D NULL;<br>
+=C2=A0 =C2=A0 g_free(n-&gt;netclient_type);<br>
+=C2=A0 =C2=A0 n-&gt;netclient_type =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 g_free(n-&gt;mac_table.macs);<br>
+=C2=A0 =C2=A0 g_free(n-&gt;vlans);<br>
+<br>
+=C2=A0 =C2=A0 if (n-&gt;failover) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qobject_unref(n-&gt;primary_opts);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 device_listener_unregister(&amp;n-&gt;primary_=
listener);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 remove_migration_state_change_notifier(&amp;n-=
&gt;migration_state);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(n-&gt;primary_opts =3D=3D NULL);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 max_queue_pairs =3D n-&gt;multiqueue ? n-&gt;max_queue_pairs=
 : 1;<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; max_queue_pairs; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_del_queue(n, i);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 /* delete also control vq */<br>
+=C2=A0 =C2=A0 virtio_del_queue(vdev, max_queue_pairs * 2);<br>
+=C2=A0 =C2=A0 qemu_announce_timer_del(&amp;n-&gt;announce_timer, false);<b=
r>
+=C2=A0 =C2=A0 g_free(n-&gt;vqs);<br>
+=C2=A0 =C2=A0 qemu_del_nic(n-&gt;nic);<br>
+=C2=A0 =C2=A0 virtio_net_rsc_cleanup(n);<br>
+=C2=A0 =C2=A0 g_free(n-&gt;rss_data.indirections_table);<br>
+=C2=A0 =C2=A0 net_rx_pkt_uninit(n-&gt;rx_pkt);<br>
+=C2=A0 =C2=A0 virtio_cleanup(vdev);<br>
+}<br>
+<br>
=C2=A0static void virtio_net_device_realize(DeviceState *dev, Error **errp)=
<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);<br>
@@ -3685,53 +3720,16 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0net_rx_pkt_init(&amp;n-&gt;rx_pkt);<br>
<br>
-=C2=A0 =C2=A0 if (virtio_has_feature(n-&gt;host_features, VIRTIO_NET_F_RSS=
)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_load_ebpf(n);<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
-<br>
-static void virtio_net_device_unrealize(DeviceState *dev)<br>
-{<br>
-=C2=A0 =C2=A0 VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);<br>
-=C2=A0 =C2=A0 VirtIONet *n =3D VIRTIO_NET(dev);<br>
-=C2=A0 =C2=A0 int i, max_queue_pairs;<br>
-<br>
-=C2=A0 =C2=A0 if (virtio_has_feature(n-&gt;host_features, VIRTIO_NET_F_RSS=
)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_unload_ebpf(n);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 /* This will stop vhost backend if appropriate. */<br>
-=C2=A0 =C2=A0 virtio_net_set_status(vdev, 0);<br>
-<br>
-=C2=A0 =C2=A0 g_free(n-&gt;netclient_name);<br>
-=C2=A0 =C2=A0 n-&gt;netclient_name =3D NULL;<br>
-=C2=A0 =C2=A0 g_free(n-&gt;netclient_type);<br>
-=C2=A0 =C2=A0 n-&gt;netclient_type =3D NULL;<br>
-<br>
-=C2=A0 =C2=A0 g_free(n-&gt;mac_table.macs);<br>
-=C2=A0 =C2=A0 g_free(n-&gt;vlans);<br>
-<br>
-=C2=A0 =C2=A0 if (n-&gt;failover) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qobject_unref(n-&gt;primary_opts);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 device_listener_unregister(&amp;n-&gt;primary_=
listener);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 remove_migration_state_change_notifier(&amp;n-=
&gt;migration_state);<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(n-&gt;primary_opts =3D=3D NULL);<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (virtio_has_feature(n-&gt;host_features, VIRTIO_NET_F_RSS=
) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 !virtio_net_load_ebpf(n)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_vhost_net(nc-&gt;peer)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Can&#39;t=
 load eBPF RSS for vhost&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_device_unrealize(dev)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 max_queue_pairs =3D n-&gt;multiqueue ? n-&gt;max_queue_pairs=
 : 1;<br>
-=C2=A0 =C2=A0 for (i =3D 0; i &lt; max_queue_pairs; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_del_queue(n, i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report_once(&quot;Can&#39;t load eBPF RSS=
 - fallback to software RSS&quot;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 /* delete also control vq */<br>
-=C2=A0 =C2=A0 virtio_del_queue(vdev, max_queue_pairs * 2);<br>
-=C2=A0 =C2=A0 qemu_announce_timer_del(&amp;n-&gt;announce_timer, false);<b=
r>
-=C2=A0 =C2=A0 g_free(n-&gt;vqs);<br>
-=C2=A0 =C2=A0 qemu_del_nic(n-&gt;nic);<br>
-=C2=A0 =C2=A0 virtio_net_rsc_cleanup(n);<br>
-=C2=A0 =C2=A0 g_free(n-&gt;rss_data.indirections_table);<br>
-=C2=A0 =C2=A0 net_rx_pkt_uninit(n-&gt;rx_pkt);<br>
-=C2=A0 =C2=A0 virtio_cleanup(vdev);<br>
=C2=A0}<br>
<br>
=C2=A0static void virtio_net_reset(VirtIODevice *vdev)<br>
-- <br>
2.42.0<br>
<br>
</blockquote></div></div>

--000000000000abfab00608e244e6--


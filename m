Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF6D7DB9B0
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 13:16:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxRAU-0004K2-VV; Mon, 30 Oct 2023 08:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qxRAS-0004Jf-0x
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 08:14:52 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qxRAO-0004yw-VK
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 08:14:51 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-507d1cc0538so6060555e87.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 05:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698668087; x=1699272887;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IK7p+CAjtsCaUih1o1GHjGUf8j6Z304GXnxq6PVy3zs=;
 b=KBSAUNLesUUHPtRgAijdG+H/MsVBx4G4c8JsgCKyzfDLFHFUkXiWO6ppCKOWNDn1sY
 AkO8PKRj0OsHpDle/jbblaKAJEaJaPA8a22XYdGUxhraG9Zebe3TZuJq915P6j9pp+HW
 OXGUdmhs700t1GZ5GVMGdqpFOAKl/AptgZm73jd7PtNhJFflMrMBqpkznroRn4gczLR5
 mjyTzRWTIFfZbsFoNppi2mX6n0tfq+9Q81lf0yk2x2awPmfMyKDYHP2d60AAduKv4TX+
 q+quwpDi0674AhxIv5p466UU35daRSjyfGePSU0HZvmKbD0t/w5K4Oc7+vVXnAU+PTUt
 fonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698668087; x=1699272887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IK7p+CAjtsCaUih1o1GHjGUf8j6Z304GXnxq6PVy3zs=;
 b=vlGYN4sYoUWf4lIqKaqfn/c8acTr6g+fyjuOm5s+y4zCtqlfqpgTCQlRa2v9UHGvtB
 bYAYf+vYpUXokhJFGPC3FixTR82C0wqm6gZs1VWRjiao23xRfChGTelRP9Q6MyyWYXqW
 sFj5lIKjBZ/WABZyvspYdB3RRu1JgJQ864xLgk5AB6GxVnCg3hS44w+v8J9rBV4sscLF
 87b18gO3HfIucRlryUgmj3qCwQ3WIUGQqfis4LEVyqUnvgmoBpsHbsLzsKRAFM9mFBUd
 7grrsdQPDyn6IDenaR41NN1HS5XacpYvixTfIojizzB+7aODSZwWuGsVgfm+Dp2AXX+F
 WeCg==
X-Gm-Message-State: AOJu0YzPIFrQF4SPfz7W0tB1wxUz27ZaIwmt2iZSmPAUfiXfNOeodd1b
 q7SyKbbepduBoTftSSJvB5O6/2gwA1a0EQYsJauUFA==
X-Google-Smtp-Source: AGHT+IHToSsbYvjs7vGIC7HjOl1fhi59NnMQHdksOBzmMeUL6OvbfMTE+Hs7wcE0Miwl99IfWFXF6YpIcwUCCTwDNdA=
X-Received: by 2002:a19:6d1b:0:b0:507:95ea:1e72 with SMTP id
 i27-20020a196d1b000000b0050795ea1e72mr6131634lfc.22.1698668086692; Mon, 30
 Oct 2023 05:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
 <20231030051356.33123-12-akihiko.odaki@daynix.com>
In-Reply-To: <20231030051356.33123-12-akihiko.odaki@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 30 Oct 2023 14:14:34 +0200
Message-ID: <CAOEp5OdEEVcojjwCOU+9Z5yBKN+e5iNbAMOA5d-97D81N4Y0tw@mail.gmail.com>
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e626040608edfbb9"
Received-SPF: none client-ip=2a00:1450:4864:20::130;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lf1-x130.google.com
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

--000000000000e626040608edfbb9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 7:14=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com>
wrote:

> vhost requires eBPF for RSS. When eBPF is not available, virtio-net
> implicitly disables RSS even if the user explicitly requests it. Return
> an error instead of implicitly disabling RSS if RSS is requested but not
> available.
>

I think that suggesting RSS feature when in fact it is not available is not
a good idea, this rather desinforms the guest.
Existing behavior (IMHO) makes more sense.
We can extend this discussion if needed, of course.


> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/net/virtio-net.c | 97 ++++++++++++++++++++++-----------------------
>  1 file changed, 48 insertions(+), 49 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 5d4afd12b2..7bb91617d0 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -792,9 +792,6 @@ static uint64_t virtio_net_get_features(VirtIODevice
> *vdev, uint64_t features,
>          return features;
>      }
>
> -    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
> -        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
> -    }
>      features =3D vhost_net_get_features(get_vhost_net(nc->peer), feature=
s);
>      vdev->backend_features =3D features;
>
> @@ -3533,6 +3530,50 @@ static bool
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
> +        migration_remove_notifier(&n->migration_state);
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
> @@ -3704,53 +3745,11 @@ static void virtio_net_device_realize(DeviceState
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
> +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS) &&
> +        !virtio_net_load_ebpf(n)) {
> +        error_setg(errp, "Can't load eBPF RSS");
> +        virtio_net_device_unrealize(dev);
>      }
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
> -        migration_remove_notifier(&n->migration_state);
> -    } else {
> -        assert(n->primary_opts =3D=3D NULL);
> -    }
> -
> -    max_queue_pairs =3D n->multiqueue ? n->max_queue_pairs : 1;
> -    for (i =3D 0; i < max_queue_pairs; i++) {
> -        virtio_net_del_queue(n, i);
> -    }
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

--000000000000e626040608edfbb9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 30, 2023 at 7:14=E2=80=AF=
AM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.od=
aki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">vhost requires eBPF for RSS. When eBPF is not available, virt=
io-net<br>
implicitly disables RSS even if the user explicitly requests it. Return<br>
an error instead of implicitly disabling RSS if RSS is requested but not<br=
>
available.<br></blockquote><div><br></div><div>I think that suggesting RSS =
feature when in fact it is not available is not a good idea, this rather de=
sinforms the guest.</div><div>Existing behavior (IMHO) makes more sense.<br=
></div><div>We can extend this discussion if needed, of course.</div><div><=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
---<br>
=C2=A0hw/net/virtio-net.c | 97 ++++++++++++++++++++++----------------------=
-<br>
=C2=A01 file changed, 48 insertions(+), 49 deletions(-)<br>
<br>
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
index 5d4afd12b2..7bb91617d0 100644<br>
--- a/hw/net/virtio-net.c<br>
+++ b/hw/net/virtio-net.c<br>
@@ -792,9 +792,6 @@ static uint64_t virtio_net_get_features(VirtIODevice *v=
dev, uint64_t features,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return features;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (!ebpf_rss_is_loaded(&amp;n-&gt;ebpf_rss)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_clear_feature(&amp;features, VIRTIO_NET=
_F_RSS);<br>
-=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0features =3D vhost_net_get_features(get_vhost_net(nc-&g=
t;peer), features);<br>
=C2=A0 =C2=A0 =C2=A0vdev-&gt;backend_features =3D features;<br>
<br>
@@ -3533,6 +3530,50 @@ static bool failover_hide_primary_device(DeviceListe=
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_remove_notifier(&amp;n-&gt;migration=
_state);<br>
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
@@ -3704,53 +3745,11 @@ static void virtio_net_device_realize(DeviceState *=
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
+=C2=A0 =C2=A0 if (virtio_has_feature(n-&gt;host_features, VIRTIO_NET_F_RSS=
) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 !virtio_net_load_ebpf(n)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Can&#39;t load eBPF RSS=
&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_device_unrealize(dev);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
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
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_remove_notifier(&amp;n-&gt;migration=
_state);<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(n-&gt;primary_opts =3D=3D NULL);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 max_queue_pairs =3D n-&gt;multiqueue ? n-&gt;max_queue_pairs=
 : 1;<br>
-=C2=A0 =C2=A0 for (i =3D 0; i &lt; max_queue_pairs; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_del_queue(n, i);<br>
-=C2=A0 =C2=A0 }<br>
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

--000000000000e626040608edfbb9--


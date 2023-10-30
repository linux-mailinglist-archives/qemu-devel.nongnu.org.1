Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 152C07DBA14
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 13:44:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxRbZ-0003ci-Pg; Mon, 30 Oct 2023 08:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qxRbX-0003bl-Bu
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 08:42:51 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qxRbU-0002On-VR
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 08:42:51 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c503dbe50dso63857121fa.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 05:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698669765; x=1699274565;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K5AIUcYccCMNHr2WYNIM+JPx6kzWvOoF5rDmypX3KrM=;
 b=e6PsPXE39n6hyWC0Iw72kukXxjJoic6Vq22D31C7Ik9dJiDNhGMNVOfmj89AXUjHrd
 JXfkq1VVsNosghpcQRQjuSpNd4HVEyR5Oqy38KHiqn99Zc+r2L47apForb7CHVF5k6hJ
 LEP1lhPMcejhCQ/PYJIeD5uzehx2Es5UuxqAH/IDQNQ3N71lGClszAVH9HtyyUNCidM0
 5TsV9dtLCRXWN0jXyClVZ0eBwtTMkgS2NCxy/zB5H0b7MhSYABNcwMX2rfHmroBPp/U/
 spWJxo8rWvGBJNP2P5gCZw7Nic8O4tBTzWxkji+ymindvlqgy/Ur6FTj90gP4Fa8TC/x
 MgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698669765; x=1699274565;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K5AIUcYccCMNHr2WYNIM+JPx6kzWvOoF5rDmypX3KrM=;
 b=LqnZ6CqF9HEEjcuJLROcc7dhYHCQQ5xbkx6CbBrB3hmpe+P/ZFbqIDah7O1fmXZTM9
 LkPImQYjdjjjbjG83xylZs+BM4wwhk+kL9w2MrlNLxLXVQDYSGhMyWtf33plRL2NX8fM
 ASiTGIZav9VDH9RUarg6vJsIcuhFjjpp/U3IzRn4zPY4NWgbfHOnBtu9qeCkXCrPqNKD
 bli+jnpAdLfimcH4abFeDCrLqOrDifLhQcU4Iy9Xoub1VXGiGs2LeP0CtCdmzJuaddN8
 GVg7Q5oXDyQtL7TW1F8yHrdRcOO2sky6GVv1x1LHcnRmAYQ91QjA3diq5G/eGT7o9y6Z
 qhwA==
X-Gm-Message-State: AOJu0YxFBG8/DSKGhWy2v4IqQXt/oj+vwkHcRl2tq+yWtculr3d/YAm0
 BzFY9ZQ0nxh74bFfv1iFgpsEQRjWjlQDAKxY+KJ0JQ==
X-Google-Smtp-Source: AGHT+IGXWrH52bUx9rZYsOrz4aTDCylEcSHCzLmZUgzwJvQMP8k123huV6epvfnONp2ZYHFzurdBX919r7PZp+7EXLo=
X-Received: by 2002:a2e:965a:0:b0:2c5:130c:d41e with SMTP id
 z26-20020a2e965a000000b002c5130cd41emr7995089ljh.29.1698669764883; Mon, 30
 Oct 2023 05:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
 <20231030051356.33123-13-akihiko.odaki@daynix.com>
In-Reply-To: <20231030051356.33123-13-akihiko.odaki@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 30 Oct 2023 14:42:32 +0200
Message-ID: <CAOEp5OfL_cJyhbwqhBXfiwAP3pybsxEbiLmmNtpPuJYqLGPWTg@mail.gmail.com>
Subject: Re: [PATCH v6 12/21] virtio-net: Enable software RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ed4f700608ee5f3d"
Received-SPF: none client-ip=2a00:1450:4864:20::235;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lj1-x235.google.com
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

--000000000000ed4f700608ee5f3d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 7:14=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com>
wrote:

> virtio-net implements software RSS but does not enable it. Enable it
> when RSS is requested, but the eBPF implementation is not available.
> We also check if vhost is in use in such a case since software RSS is
> incompatible with vhost. A warning will be emitted when falling back to
> software RSS since it provides no performance benefit.
>
>
Can you please elaborate what is wrong from your point of view in the
existing implementation?
In general it does (IMO) what you describe.
I'd like to note several things:
- The "vhost=3Doff" is in fact the fallback mode (libvirt default is vhost=
=3Don)
- The main goal of software RSS was to provide a reference for RSS
implementation for future virtio-net hardware
- Performance benefit of software RSS (as well as implementation in EBPF)
is delivery of each packet to proper virtqueue/CPU and avoiding packet
rescheduling in the guest
- The best thing (IMO) would be to implement hash delivery with vhost=3Don,
i.e. in EBPF and as soon as this is possible - rely on the hardware/host
capabilities and stop calculating the hash in the guest driver (as we do
today in Windows)




> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/net/virtio-net.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 7bb91617d0..1fa020d905 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1260,10 +1260,12 @@ static bool virtio_net_attach_epbf_rss(VirtIONet
> *n)
>
>      if (!ebpf_rss_set_all(&n->ebpf_rss, &config,
>                            n->rss_data.indirections_table,
> n->rss_data.key)) {
> +        warn_report("Failed to configure eBPF RSS");
>          return false;
>      }
>
>      if (!virtio_net_attach_ebpf_to_backend(n->nic,
> n->ebpf_rss.program_fd)) {
> +        warn_report("Failed to attach eBPF to backend");
>          return false;
>      }
>
> @@ -1278,16 +1280,10 @@ static void virtio_net_detach_epbf_rss(VirtIONet
> *n)
>  static void virtio_net_commit_rss_config(VirtIONet *n)
>  {
>      if (n->rss_data.enabled) {
> -        n->rss_data.enabled_software_rss =3D n->rss_data.populate_hash;
> +        n->rss_data.enabled_software_rss =3D n->rss_data.populate_hash |=
|
> +                                           !virtio_net_attach_epbf_rss(n=
);
>          if (n->rss_data.populate_hash) {
>              virtio_net_detach_epbf_rss(n);
> -        } else if (!virtio_net_attach_epbf_rss(n)) {
> -            if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
> -                warn_report("Can't load eBPF RSS for vhost");
> -            } else {
> -                warn_report("Can't load eBPF RSS - fallback to software
> RSS");
> -                n->rss_data.enabled_software_rss =3D true;
> -            }
>          }
>
>          trace_virtio_net_rss_enable(n->rss_data.hash_types,
> @@ -3747,8 +3743,13 @@ static void virtio_net_device_realize(DeviceState
> *dev, Error **errp)
>
>      if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS) &&
>          !virtio_net_load_ebpf(n)) {
> -        error_setg(errp, "Can't load eBPF RSS");
> -        virtio_net_device_unrealize(dev);
> +        if (get_vhost_net(nc->peer)) {
> +            error_setg(errp, "Can't load eBPF RSS for vhost");
> +            virtio_net_device_unrealize(dev);
> +            return;
> +        }
> +
> +        warn_report_once("Can't load eBPF RSS - fallback to software
> RSS");
>      }
>  }
>
> --
> 2.42.0
>
>

--000000000000ed4f700608ee5f3d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 30, 2023 at 7:14=E2=80=AF=
AM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.od=
aki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">virtio-net implements software RSS but does not enable it. En=
able it<br>
when RSS is requested, but the eBPF implementation is not available.<br>
We also check if vhost is in use in such a case since software RSS is<br>
incompatible with vhost. A warning will be emitted when falling back to<br>
software RSS since it provides no performance benefit.<br>
<br></blockquote><div><br></div><div>Can you please elaborate what is wrong=
 from your point of view in the existing implementation?</div><div>In gener=
al it does (IMO) what you describe.</div><div>I&#39;d like to note several =
things:</div><div>- The &quot;vhost=3Doff&quot; is in fact the fallback mod=
e (libvirt default is vhost=3Don)</div><div>- The main goal of software RSS=
 was to provide a reference for RSS implementation for future virtio-net ha=
rdware<br></div><div>- Performance benefit of software RSS (as well as impl=
ementation in EBPF) is delivery of each packet to proper virtqueue/CPU and =
avoiding packet rescheduling=C2=A0in the guest</div><div>- The best thing (=
IMO) would be to implement hash delivery with vhost=3Don, i.e. in EBPF and =
as soon as this is possible - rely on the hardware/host capabilities and st=
op calculating the hash in the guest driver (as we do today in Windows)</di=
v><div><br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
---<br>
=C2=A0hw/net/virtio-net.c | 21 +++++++++++----------<br>
=C2=A01 file changed, 11 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
index 7bb91617d0..1fa020d905 100644<br>
--- a/hw/net/virtio-net.c<br>
+++ b/hw/net/virtio-net.c<br>
@@ -1260,10 +1260,12 @@ static bool virtio_net_attach_epbf_rss(VirtIONet *n=
)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!ebpf_rss_set_all(&amp;n-&gt;ebpf_rss, &amp;config,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0n-&gt;rss_data.indirections_table, n-&gt;rss_data.k=
ey)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report(&quot;Failed to configure eBPF RSS=
&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!virtio_net_attach_ebpf_to_backend(n-&gt;nic, n-&gt=
;ebpf_rss.program_fd)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report(&quot;Failed to attach eBPF to bac=
kend&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -1278,16 +1280,10 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n=
)<br>
=C2=A0static void virtio_net_commit_rss_config(VirtIONet *n)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (n-&gt;rss_data.enabled) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rss_data.enabled_software_rss =3D n-&gt;=
rss_data.populate_hash;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rss_data.enabled_software_rss =3D n-&gt;=
rss_data.populate_hash ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0!virtio_net_attach_epbf_rss(n);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (n-&gt;rss_data.populate_hash) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_net_detach_epbf_rss(=
n);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (!virtio_net_attach_epbf_rss(n)) {<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_vhost_net(qemu_get_queue=
(n-&gt;nic)-&gt;peer)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report(&quot;=
Can&#39;t load eBPF RSS for vhost&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report(&quot;=
Can&#39;t load eBPF RSS - fallback to software RSS&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rss_data.ena=
bled_software_rss =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_virtio_net_rss_enable(n-&gt;rss_dat=
a.hash_types,<br>
@@ -3747,8 +3743,13 @@ static void virtio_net_device_realize(DeviceState *d=
ev, Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (virtio_has_feature(n-&gt;host_features, VIRTIO_NET_=
F_RSS) &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!virtio_net_load_ebpf(n)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Can&#39;t load eBPF RSS=
&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_device_unrealize(dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_vhost_net(nc-&gt;peer)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Can&#39;t=
 load eBPF RSS for vhost&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_device_unrealize(dev)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report_once(&quot;Can&#39;t load eBPF RSS=
 - fallback to software RSS&quot;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-- <br>
2.42.0<br>
<br>
</blockquote></div></div>

--000000000000ed4f700608ee5f3d--


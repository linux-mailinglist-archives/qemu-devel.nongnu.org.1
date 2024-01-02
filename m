Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FE3821AD3
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 12:21:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKcog-0007Yh-GR; Tue, 02 Jan 2024 06:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rKcoe-0007YE-Jc
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 06:20:12 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rKcob-0001bF-Cy
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 06:20:12 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2cd0f4f306fso3887661fa.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 03:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1704194405; x=1704799205;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/q6AIqT2HqO7NnW/Ase10Iws0ET6wlNo9D5ZvW8ci7Y=;
 b=y3E6dlt3ZUlzWqkO0Bta9rczE8AJOBpS0JXUmS1om03E/4pD2xzKqF1BJabvsB8NcY
 GgOqEVbPYhVNhNiR2NljQeuUXIifMQUyF6TQdD69dAPYnlxZrPC1XW7ppLx4C7lHaOR5
 /XvFz6PDHnAXeOwINkF6UlRD/KL49NMJW1L4YABQuNERzx1DHAunzoyAn4hFzs12RSWe
 tUxygsKwO4nqyw7skxiXXqqlnriWk7Zq8iVRPB9X3DUk6Zxpu+yuQgxvE57o8xNAEpuf
 N5+fO8H/+9djE/CPiJaFQrs10FASLNrCLnklFMKk506V2RRTK2k+HD5d3msynpaTgvfd
 bDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704194405; x=1704799205;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/q6AIqT2HqO7NnW/Ase10Iws0ET6wlNo9D5ZvW8ci7Y=;
 b=CrPEajU5PljKYpp3XOYRRHdGis3r+c3+Sj3tPbWAgEz6sfExiK4oOHhnn83Ga2moyv
 o/VPPX3FngH2B/DlyTDN3DpXEgQtnOjvSdsDQXQ3am/X0FjvB6RKX42RY/pmusz9xMvi
 vhO2x/dt7VrfYbT9O1H8HgByQv3njnHv8idNmk08kfijDyeXtW3GmxZRjJMj6SYdxVVX
 bR0X63n+kdF0NDlTuvHLXcRs8MJNftFhjCD4D7Jy0WfHcPCjiFSh8sht03zIArrQDQ7d
 xM7unhr6yKSa9fFh+LTWolL6ooOomFOaXHKcMh4XoBSPUUQpBd216RaFAK+m5/1milxw
 aFbg==
X-Gm-Message-State: AOJu0YwqNFU9+yjn/MUFhDJ+5R/KQr6M9eMw980h4mE4ZTG1FP8JzFt1
 dxA9rQGK4s6p9HQ3M6s6ickm28qS7xUjxchMgarzz7hmfMGP4Q==
X-Google-Smtp-Source: AGHT+IExwyU0hNkQcWuedR7wT374/Ju+WsQpJp+NCuJm6srVDpxvJqEsPYiweDIDLLm2OWSeZKXlXO+TmqX4ZiCAhBo=
X-Received: by 2002:a05:6512:398b:b0:50e:7fb4:ebaf with SMTP id
 j11-20020a056512398b00b0050e7fb4ebafmr5106435lfu.133.1704194405320; Tue, 02
 Jan 2024 03:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20240102032901.3234-1-jasowang@redhat.com>
In-Reply-To: <20240102032901.3234-1-jasowang@redhat.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 2 Jan 2024 13:19:53 +0200
Message-ID: <CAOEp5Oe9PcZd2999bzYGCVTd8xbX8+_HXW2UbAZLSoVzSxYjnw@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: correctly copy vnet header when flushing TX
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, Xiao Lei <leixiao.nop@zju.edu.cn>, 
 qemu-stable@nongnu.org, Mauro Matteo Cascella <mcascell@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000285dcf060df4ae0b"
Received-SPF: none client-ip=2a00:1450:4864:20::22a;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--000000000000285dcf060df4ae0b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I agree, thank you.

Where is this CVE-2023-6693 available?

Thanks,
Yuri

On Tue, Jan 2, 2024 at 5:29=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:

> When HASH_REPORT is negotiated, the guest_hdr_len might be larger than
> the size of the mergeable rx buffer header. Using
> virtio_net_hdr_mrg_rxbuf during the header swap might lead a stack
> overflow in this case. Fixing this by using virtio_net_hdr_v1_hash
> instead.
>
> Reported-by: Xiao Lei <leixiao.nop@zju.edu.cn>
> Cc: Yuri Benditovich <yuri.benditovich@daynix.com>
> Cc: qemu-stable@nongnu.org
> Cc: Mauro Matteo Cascella <mcascell@redhat.com>
> Fixes: CVE-2023-6693
> Fixes: e22f0603fb2f ("virtio-net: reference implementation of hash report=
")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/net/virtio-net.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 80c56f0cfc..73024babd4 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -674,6 +674,11 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n,
> int mergeable_rx_bufs,
>
>      n->mergeable_rx_bufs =3D mergeable_rx_bufs;
>
> +    /*
> +     * Note: when extending the vnet header, please make sure to
> +     * change the vnet header copying logic in virtio_net_flush_tx()
> +     * as well.
> +     */
>      if (version_1) {
>          n->guest_hdr_len =3D hash_report ?
>              sizeof(struct virtio_net_hdr_v1_hash) :
> @@ -2693,7 +2698,7 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *=
q)
>          ssize_t ret;
>          unsigned int out_num;
>          struct iovec sg[VIRTQUEUE_MAX_SIZE], sg2[VIRTQUEUE_MAX_SIZE + 1]=
,
> *out_sg;
> -        struct virtio_net_hdr_mrg_rxbuf mhdr;
> +        struct virtio_net_hdr_v1_hash vhdr;
>
>          elem =3D virtqueue_pop(q->tx_vq, sizeof(VirtQueueElement));
>          if (!elem) {
> @@ -2710,7 +2715,7 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *=
q)
>          }
>
>          if (n->has_vnet_hdr) {
> -            if (iov_to_buf(out_sg, out_num, 0, &mhdr, n->guest_hdr_len) =
<
> +            if (iov_to_buf(out_sg, out_num, 0, &vhdr, n->guest_hdr_len) =
<
>                  n->guest_hdr_len) {
>                  virtio_error(vdev, "virtio-net header incorrect");
>                  virtqueue_detach_element(q->tx_vq, elem, 0);
> @@ -2718,8 +2723,8 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *=
q)
>                  return -EINVAL;
>              }
>              if (n->needs_vnet_hdr_swap) {
> -                virtio_net_hdr_swap(vdev, (void *) &mhdr);
> -                sg2[0].iov_base =3D &mhdr;
> +                virtio_net_hdr_swap(vdev, (void *) &vhdr);
> +                sg2[0].iov_base =3D &vhdr;
>                  sg2[0].iov_len =3D n->guest_hdr_len;
>                  out_num =3D iov_copy(&sg2[1], ARRAY_SIZE(sg2) - 1,
>                                     out_sg, out_num,
> --
> 2.42.0
>
>

--000000000000285dcf060df4ae0b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I agree, thank you.</div><div><br></div><div>Where is=
 this CVE-2023-6693 available?<br></div><div><br></div><div>Thanks,</div><d=
iv>Yuri</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Tue, Jan 2, 2024 at 5:29=E2=80=AFAM Jason Wang &lt;<a href=
=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">When HASH_REPORT is nego=
tiated, the guest_hdr_len might be larger than<br>
the size of the mergeable rx buffer header. Using<br>
virtio_net_hdr_mrg_rxbuf during the header swap might lead a stack<br>
overflow in this case. Fixing this by using virtio_net_hdr_v1_hash<br>
instead.<br>
<br>
Reported-by: Xiao Lei &lt;<a href=3D"mailto:leixiao.nop@zju.edu.cn" target=
=3D"_blank">leixiao.nop@zju.edu.cn</a>&gt;<br>
Cc: Yuri Benditovich &lt;<a href=3D"mailto:yuri.benditovich@daynix.com" tar=
get=3D"_blank">yuri.benditovich@daynix.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-stable=
@nongnu.org</a><br>
Cc: Mauro Matteo Cascella &lt;<a href=3D"mailto:mcascell@redhat.com" target=
=3D"_blank">mcascell@redhat.com</a>&gt;<br>
Fixes: CVE-2023-6693<br>
Fixes: e22f0603fb2f (&quot;virtio-net: reference implementation of hash rep=
ort&quot;)<br>
Signed-off-by: Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" target=
=3D"_blank">jasowang@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/net/virtio-net.c | 13 +++++++++----<br>
=C2=A01 file changed, 9 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
index 80c56f0cfc..73024babd4 100644<br>
--- a/hw/net/virtio-net.c<br>
+++ b/hw/net/virtio-net.c<br>
@@ -674,6 +674,11 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, i=
nt mergeable_rx_bufs,<br>
<br>
=C2=A0 =C2=A0 =C2=A0n-&gt;mergeable_rx_bufs =3D mergeable_rx_bufs;<br>
<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Note: when extending the vnet header, please make su=
re to<br>
+=C2=A0 =C2=A0 =C2=A0* change the vnet header copying logic in virtio_net_f=
lush_tx()<br>
+=C2=A0 =C2=A0 =C2=A0* as well.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0if (version_1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n-&gt;guest_hdr_len =3D hash_report ?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(struct virtio_net_hd=
r_v1_hash) :<br>
@@ -2693,7 +2698,7 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int out_num;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iovec sg[VIRTQUEUE_MAX_SIZE], sg2[=
VIRTQUEUE_MAX_SIZE + 1], *out_sg;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_net_hdr_mrg_rxbuf mhdr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_net_hdr_v1_hash vhdr;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elem =3D virtqueue_pop(q-&gt;tx_vq, sizeo=
f(VirtQueueElement));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!elem) {<br>
@@ -2710,7 +2715,7 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (n-&gt;has_vnet_hdr) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (iov_to_buf(out_sg, out_num, =
0, &amp;mhdr, n-&gt;guest_hdr_len) &lt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (iov_to_buf(out_sg, out_num, =
0, &amp;vhdr, n-&gt;guest_hdr_len) &lt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n-&gt;guest_h=
dr_len) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_error(=
vdev, &quot;virtio-net header incorrect&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtqueue_det=
ach_element(q-&gt;tx_vq, elem, 0);<br>
@@ -2718,8 +2723,8 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVA=
L;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (n-&gt;needs_vnet_hdr_sw=
ap) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_hdr_swa=
p(vdev, (void *) &amp;mhdr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sg2[0].iov_base =
=3D &amp;mhdr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_hdr_swa=
p(vdev, (void *) &amp;vhdr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sg2[0].iov_base =
=3D &amp;vhdr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sg2[0].iov_le=
n =3D n-&gt;guest_hdr_len;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out_num =3D i=
ov_copy(&amp;sg2[1], ARRAY_SIZE(sg2) - 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_sg, out_num,<br>
-- <br>
2.42.0<br>
<br>
</blockquote></div>

--000000000000285dcf060df4ae0b--


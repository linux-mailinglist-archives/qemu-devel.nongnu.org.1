Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5BE7E03BF
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 14:28:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyuCK-0005kE-A7; Fri, 03 Nov 2023 09:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qyuCH-0005j3-Kf
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 09:26:49 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qyuCE-0002jQ-Dv
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 09:26:49 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-507c5249d55so2658902e87.3
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 06:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1699018004; x=1699622804;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mfZZxVHH8uI+pAbH73jyBBWZDILcgiPj8rsnNR2pp0E=;
 b=VfRqJRwNCkMM9oY3H2uydwzWQrHdPlhzdm2++8R/M96owOCJEzyz9vjpAXVQYSrwzU
 3KbW8wcqY/XASJuHcNQS94WCcm04+X6leeJ/FTwv9H89bdmV6ExumEbyGetcgRVQ4HCl
 DRUVOIOcGXmk2PM+TnUP7XustHbARcZhJ62xK/JbNRHBfdkydpv8+HSFPfNV4X1u0qEw
 9TUvMPxxNh9fNCTD4DRwMr0/m/wTwB6+fLamN726RTwr8uYMgdCdXFaLHkFZccj9eKbg
 OkZO8OSn5FjnfYSQTurB6CaC2qlihXBdV6R3++s1d/vp0dL9nr9YcFJvaEAhEIs8a2WZ
 CVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699018004; x=1699622804;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mfZZxVHH8uI+pAbH73jyBBWZDILcgiPj8rsnNR2pp0E=;
 b=eD2paCV+3SOvesa8T89seBFLNuBQv/UjBSlPt+poG5acEgsjJ5bIgFZXRCEEaPvm8r
 4nX3u7GZkUPnScR+dUVTCyXcrzeGIsA8REFRzNlrqDU/AysHiUmzAbGHwiABbtgf+hGI
 YneX0dV7YQXoVHeRQygB0WGMjbFkBQfZvH0jDRqBwFnA5FH4PyntCdKYWo+c3TWPy8yU
 BbItCJTBGYBV06FTjIRHc+yMCXfWKe/+Vsr9zXn+o5UTApdspLXJTLTpdYLeyKW1miiz
 uTRxY9togHv024pbRvbeHEhShWIa0JFCxKS1yKp9h9EMA4bvmA220P0CnEbYueiACxnE
 azaw==
X-Gm-Message-State: AOJu0YzEaEgRkbx0oIn6JP0B+YBgllLRqrEiQ1dU+BBpKfylVSVe68q8
 GcbfAaD6+tXGSClzfIU71rs0Uj/9nU7m8HUgY0K4mw==
X-Google-Smtp-Source: AGHT+IExiCVIYn/KuInHIAHS2cel7+jPjYOti3/oL8jd7t58E1oPRAcfytHgHN3UC8zlwS0PDAgd7e1/OLVMR6MzMnk=
X-Received: by 2002:a05:6512:3d17:b0:500:cb2b:8678 with SMTP id
 d23-20020a0565123d1700b00500cb2b8678mr20023230lfv.40.1699018004111; Fri, 03
 Nov 2023 06:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
 <20231030051356.33123-16-akihiko.odaki@daynix.com>
In-Reply-To: <20231030051356.33123-16-akihiko.odaki@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Fri, 3 Nov 2023 15:26:32 +0200
Message-ID: <CAOEp5OdGOJXGtOcKGANHMp7g71aFDn5B=80Ap5-Si2UeiqMERQ@mail.gmail.com>
Subject: Re: [PATCH v6 15/21] virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009a37ad06093f7446"
Received-SPF: none client-ip=2a00:1450:4864:20::131;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000009a37ad06093f7446
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 7:15=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com>
wrote:

> virtio-net can report hash values even if the peer does not have a
> virtio-net header.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/net/virtio-net.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index e30105884c..bdb4579f98 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -774,8 +774,6 @@ static uint64_t virtio_net_get_features(VirtIODevice
> *vdev, uint64_t features,
>          virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
>          virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
>          virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
> -
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
>      }
>
>
IMO, we should not enable any advanced features for backends without
vnet_hdr unless we have a strong reason to do so.
( HOST_TSO and GUEST_TSO are performance boosters and they are not
supported without vnet_hdr )
I'd rather disable also RSS under this "if".



>      if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
> --
> 2.42.0
>
>

--0000000000009a37ad06093f7446
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 30, 2023 at 7:15=E2=80=AF=
AM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.od=
aki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">virtio-net can report hash values even if the peer does not h=
ave a<br>
virtio-net header.<br>
<br>
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
---<br>
=C2=A0hw/net/virtio-net.c | 2 --<br>
=C2=A01 file changed, 2 deletions(-)<br>
<br>
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
index e30105884c..bdb4579f98 100644<br>
--- a/hw/net/virtio-net.c<br>
+++ b/hw/net/virtio-net.c<br>
@@ -774,8 +774,6 @@ static uint64_t virtio_net_get_features(VirtIODevice *v=
dev, uint64_t features,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_clear_feature(&amp;features, VIRTI=
O_NET_F_HOST_USO);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_clear_feature(&amp;features, VIRTI=
O_NET_F_GUEST_USO4);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_clear_feature(&amp;features, VIRTI=
O_NET_F_GUEST_USO6);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_clear_feature(&amp;features, VIRTIO_NET=
_F_HASH_REPORT);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br></blockquote><div><br></div><div>IMO, we should not enable any advanced=
 features for backends without vnet_hdr unless we have a strong reason to d=
o so.</div><div>( HOST_TSO and GUEST_TSO are performance boosters and they =
are=C2=A0not supported without vnet_hdr )</div><div>I&#39;d rather disable =
also RSS under this &quot;if&quot;.</div><div><br></div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {<br>
-- <br>
2.42.0<br>
<br>
</blockquote></div></div>

--0000000000009a37ad06093f7446--


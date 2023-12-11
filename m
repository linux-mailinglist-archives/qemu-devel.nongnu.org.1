Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9723980C88F
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 12:55:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCesP-000859-UY; Mon, 11 Dec 2023 06:55:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rCesJ-00083X-6f
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 06:55:03 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rCesG-0007wZ-OK
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 06:55:02 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c9f099cf3aso64773341fa.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 03:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702295699; x=1702900499;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hU1S3Rb+V7DlnCfAaxQ54xKDwTeZVyTBW0Re30BSqAU=;
 b=ndJx2Oyjxkka7rHhBQvEpU0cGBtcMH6vRkwTYLg/vQSojhVl44aWJUQw2p/qLVu95k
 QzjgwUgPN+3wPESNSVOZA/Wm6i+ffpDpfGPcaWjN9QYRp3BqPbdoBzlQsZ32gFsUk2Bb
 8HeJFtlvn3Ub/Fkj+wNWslkVn/ZaBOW7aOu6j8MEs+OpkBsTenjokymPp5lXISrQj9YF
 XcSwmu9SSEHU5tuUVbJch2xwX06UFO1Z3Za9cOvgDum45MUlCa5m6CKYH8ZBbGt5Q7HZ
 4GyFPtq1SAcvgmqEVFlXsmT/Ti6OvraqI9Q5Hj4vqrrqjqAhuKX7E214ekhazEe+AlKo
 ds0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702295699; x=1702900499;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hU1S3Rb+V7DlnCfAaxQ54xKDwTeZVyTBW0Re30BSqAU=;
 b=WxkMeJjbYYssBy83DqcuC1wlasUoWwhW80ktOCvboYdlTIGEWN0TSjsS6OQHmkwupG
 qNmA5n78qZecCYsXS8wpjtvho+MZ6KTIB98ryqVyFpsvybW8745h+LA11D3pOe0BBjSS
 fyPDtuB6jeQxFM2c/Mtmo5JclPV9XSRkJth1e8+F+EIaB4DuJkGEVZFU0VreoxjE9vN7
 J1/cdhq3BJOziTsE+PtxmSnqWRYxgHJ41VG5LVve2+i9Dgs10KSHN6RCOiaBxJch03tr
 8G4DZc2B6WB8/g9dEDoKhto0jKRbFHpX2LGMsb+m1O68j/jzRzUlddkQmazwUdCQajPH
 EMVg==
X-Gm-Message-State: AOJu0Yz0PFahYx++zKbaJEPwDCFH/QbAPWIY6Ri1oxn7Z0nvgdJs8nSK
 HRVexwYpjjIjiz25ko25i5ErGAMMyIJ4paNUucN6IA==
X-Google-Smtp-Source: AGHT+IH5a83Ubq1J0D7NCz/FlAUt+fpfKPzQa2IcmSyDIwI+8i7WqVrsvKXF1r79mHHXn+POvGbwNZ3MAha4CoLqzQ0=
X-Received: by 2002:a2e:a4a8:0:b0:2cc:1d6c:87c7 with SMTP id
 g8-20020a2ea4a8000000b002cc1d6c87c7mr909409ljm.58.1702295698789; Mon, 11 Dec
 2023 03:54:58 -0800 (PST)
MIME-Version: 1.0
References: <20231210-rss-v8-0-9553ee714d38@daynix.com>
In-Reply-To: <20231210-rss-v8-0-9553ee714d38@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 11 Dec 2023 13:54:46 +0200
Message-ID: <CAOEp5Ofj+a2rqGWw=oLXBqrXqUj6XRc=Je3ScaE5sxZFzaAOdA@mail.gmail.com>
Subject: Re: [PATCH v8 00/19] virtio-net RSS/hash report fixes and improvements
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org, 
 "Zhang, Chen" <chen.zhang@intel.com>, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: multipart/alternative; boundary="0000000000006de91e060c3a9a78"
Received-SPF: none client-ip=2a00:1450:4864:20::233;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lj1-x233.google.com
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

--0000000000006de91e060c3a9a78
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

People, I suggest to wait a little and understand what happens with the
previous series from Andrew Melnichenko (support for qemu under libvirt etc=
)
According to response from Jason from Sept 8 it was queued but I do not see
it in the master branch.

Thanks a lot.

On Sun, Dec 10, 2023 at 7:30=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com>
wrote:

> This series contains fixes and improvements for virtio-net RSS and hash
> reporting feature.
>
> V7 -> V8:
>   Reset author email addresses.
>   Rebased.
>
> V6 -> V7:
>   Dropped patch "virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT".
>   Dropped the changes to remove packet flags.
>   Re-introduced tap_receive() and changed it to call tap_receive_iov().
>   Removed tap_get_vnet_hdr_len().
>   Fixed tap initialization not to call tap_fd_set_vnet_hdr_len() for tap
>   without virtio-net header.
>   Changed to call error_report() instead of warn_report() for
>   programming errors.
>
> V5 -> V6:
>   Corrected the message for patch "virtio-net: Return an error when vhost
>   cannot enable RSS".
>   Removed changes to introduce asserts from "virtio-net: Return an error
>   when vhost cannot enable RSS".
>   Reorganized patches "virtio-net: Return an error when vhost cannot
>   enable RSS" and "virtio-net: Do not clear VIRTIO_NET_F_RSS". This
>   version now contains patches "virtio-net: Return an error when vhost
>   cannot enable RSS" and "virtio-net: Enable software RSS".
>   Rebased.
>
> V4 -> V5:
>   Added patch "virtio-net: Do not write hashes to peer buffer".
>
> V3 -> V4:
>   Extract patches "tap: Remove tap_receive()" and  "net: Remove flag
>   propagation" from "net: Remove receive_raw()".
>   Added patch "virtio-net: Always set populate_hash".
>   Added patch "virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT".
>   Added patch "ebpf: Use standard section name".
>   Added patch "ebpf: Simplify error handling".
>   Added patch "ebpf: Return 0 when configuration fails".
>   Added patch "ebpf: Refactor tun_rss_steering_prog()".
>   Added patch "ebpf: Add a separate target for skeleton".
>
> V2 -> V3:
>   Added patch "tap: Remove tap_probe_vnet_hdr_len()".
>   Added patch "tap: Remove qemu_using_vnet_hdr()".
>   Added patch "net: Move virtio-net header length assertion".
>   Added patch "net: Remove receive_raw()".
>   Added patch "tap: Shrink zeroed virtio-net header".
>   Dropped patch "tap: Fix virtio-net header buffer size".
>
> V1 -> V2:
>   Added patch "ebpf: Fix RSS error handling".
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Akihiko Odaki (19):
>       tap: Remove tap_probe_vnet_hdr_len()
>       tap: Remove qemu_using_vnet_hdr()
>       net: Move virtio-net header length assertion
>       net: Remove receive_raw()
>       tap: Call tap_receive_iov() from tap_receive()
>       tap: Shrink zeroed virtio-net header
>       virtio-net: Copy header only when necessary
>       virtio-net: Disable RSS on reset
>       virtio-net: Unify the logic to update NIC state for RSS
>       virtio-net: Return an error when vhost cannot enable RSS
>       virtio-net: Report RSS warning at device realization
>       virtio-net: Always set populate_hash
>       virtio-net: Do not write hashes to peer buffer
>       ebpf: Fix RSS error handling
>       ebpf: Use standard section name
>       ebpf: Simplify error handling
>       ebpf: Return 0 when configuration fails
>       ebpf: Refactor tun_rss_steering_prog()
>       ebpf: Add a separate target for skeleton
>
>  ebpf/rss.bpf.skeleton.h  | 1557
> +++++++++++++++++++++++-----------------------
>  include/net/net.h        |    8 -
>  net/tap_int.h            |    1 -
>  ebpf/ebpf_rss.c          |   12 +-
>  hw/net/e1000e.c          |    1 -
>  hw/net/igb.c             |    1 -
>  hw/net/net_tx_pkt.c      |    4 +-
>  hw/net/virtio-net.c      |  308 +++++----
>  hw/net/vmxnet3.c         |    2 -
>  net/dump.c               |    4 +-
>  net/net.c                |   47 +-
>  net/netmap.c             |    5 -
>  net/tap-bsd.c            |    5 -
>  net/tap-linux.c          |   20 -
>  net/tap-solaris.c        |    5 -
>  net/tap-stub.c           |    5 -
>  net/tap.c                |   77 +--
>  tools/ebpf/rss.bpf.c     |   46 +-
>  tools/ebpf/Makefile.ebpf |   15 +-
>  19 files changed, 986 insertions(+), 1137 deletions(-)
> ---
> base-commit: 9c74490bff6c8886a922008d0c9ce6cae70dd17e
> change-id: 20231210-rss-e7c98e722253
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>
>

--0000000000006de91e060c3a9a78
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">People, I suggest to wait a little and understand what hap=
pens with the previous series from Andrew Melnichenko (support for qemu und=
er libvirt etc)<div>According to response from Jason from Sept 8 it was que=
ued but I do not see it in the master branch.</div><div><br></div><div>Than=
ks a lot.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Sun, Dec 10, 2023 at 7:30=E2=80=AFAM Akihiko Odaki &lt;<=
a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This ser=
ies contains fixes and improvements for virtio-net RSS and hash<br>
reporting feature.<br>
<br>
V7 -&gt; V8:<br>
=C2=A0 Reset author email addresses.<br>
=C2=A0 Rebased.<br>
<br>
V6 -&gt; V7:<br>
=C2=A0 Dropped patch &quot;virtio-net: Do not clear VIRTIO_NET_F_HASH_REPOR=
T&quot;.<br>
=C2=A0 Dropped the changes to remove packet flags.<br>
=C2=A0 Re-introduced tap_receive() and changed it to call tap_receive_iov()=
.<br>
=C2=A0 Removed tap_get_vnet_hdr_len().<br>
=C2=A0 Fixed tap initialization not to call tap_fd_set_vnet_hdr_len() for t=
ap<br>
=C2=A0 without virtio-net header.<br>
=C2=A0 Changed to call error_report() instead of warn_report() for<br>
=C2=A0 programming errors.<br>
<br>
V5 -&gt; V6:<br>
=C2=A0 Corrected the message for patch &quot;virtio-net: Return an error wh=
en vhost<br>
=C2=A0 cannot enable RSS&quot;.<br>
=C2=A0 Removed changes to introduce asserts from &quot;virtio-net: Return a=
n error<br>
=C2=A0 when vhost cannot enable RSS&quot;.<br>
=C2=A0 Reorganized patches &quot;virtio-net: Return an error when vhost can=
not<br>
=C2=A0 enable RSS&quot; and &quot;virtio-net: Do not clear VIRTIO_NET_F_RSS=
&quot;. This<br>
=C2=A0 version now contains patches &quot;virtio-net: Return an error when =
vhost<br>
=C2=A0 cannot enable RSS&quot; and &quot;virtio-net: Enable software RSS&qu=
ot;.<br>
=C2=A0 Rebased.<br>
<br>
V4 -&gt; V5:<br>
=C2=A0 Added patch &quot;virtio-net: Do not write hashes to peer buffer&quo=
t;.<br>
<br>
V3 -&gt; V4:<br>
=C2=A0 Extract patches &quot;tap: Remove tap_receive()&quot; and=C2=A0 &quo=
t;net: Remove flag<br>
=C2=A0 propagation&quot; from &quot;net: Remove receive_raw()&quot;.<br>
=C2=A0 Added patch &quot;virtio-net: Always set populate_hash&quot;.<br>
=C2=A0 Added patch &quot;virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT&=
quot;.<br>
=C2=A0 Added patch &quot;ebpf: Use standard section name&quot;.<br>
=C2=A0 Added patch &quot;ebpf: Simplify error handling&quot;.<br>
=C2=A0 Added patch &quot;ebpf: Return 0 when configuration fails&quot;.<br>
=C2=A0 Added patch &quot;ebpf: Refactor tun_rss_steering_prog()&quot;.<br>
=C2=A0 Added patch &quot;ebpf: Add a separate target for skeleton&quot;.<br=
>
<br>
V2 -&gt; V3:<br>
=C2=A0 Added patch &quot;tap: Remove tap_probe_vnet_hdr_len()&quot;.<br>
=C2=A0 Added patch &quot;tap: Remove qemu_using_vnet_hdr()&quot;.<br>
=C2=A0 Added patch &quot;net: Move virtio-net header length assertion&quot;=
.<br>
=C2=A0 Added patch &quot;net: Remove receive_raw()&quot;.<br>
=C2=A0 Added patch &quot;tap: Shrink zeroed virtio-net header&quot;.<br>
=C2=A0 Dropped patch &quot;tap: Fix virtio-net header buffer size&quot;.<br=
>
<br>
V1 -&gt; V2:<br>
=C2=A0 Added patch &quot;ebpf: Fix RSS error handling&quot;.<br>
<br>
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
---<br>
Akihiko Odaki (19):<br>
=C2=A0 =C2=A0 =C2=A0 tap: Remove tap_probe_vnet_hdr_len()<br>
=C2=A0 =C2=A0 =C2=A0 tap: Remove qemu_using_vnet_hdr()<br>
=C2=A0 =C2=A0 =C2=A0 net: Move virtio-net header length assertion<br>
=C2=A0 =C2=A0 =C2=A0 net: Remove receive_raw()<br>
=C2=A0 =C2=A0 =C2=A0 tap: Call tap_receive_iov() from tap_receive()<br>
=C2=A0 =C2=A0 =C2=A0 tap: Shrink zeroed virtio-net header<br>
=C2=A0 =C2=A0 =C2=A0 virtio-net: Copy header only when necessary<br>
=C2=A0 =C2=A0 =C2=A0 virtio-net: Disable RSS on reset<br>
=C2=A0 =C2=A0 =C2=A0 virtio-net: Unify the logic to update NIC state for RS=
S<br>
=C2=A0 =C2=A0 =C2=A0 virtio-net: Return an error when vhost cannot enable R=
SS<br>
=C2=A0 =C2=A0 =C2=A0 virtio-net: Report RSS warning at device realization<b=
r>
=C2=A0 =C2=A0 =C2=A0 virtio-net: Always set populate_hash<br>
=C2=A0 =C2=A0 =C2=A0 virtio-net: Do not write hashes to peer buffer<br>
=C2=A0 =C2=A0 =C2=A0 ebpf: Fix RSS error handling<br>
=C2=A0 =C2=A0 =C2=A0 ebpf: Use standard section name<br>
=C2=A0 =C2=A0 =C2=A0 ebpf: Simplify error handling<br>
=C2=A0 =C2=A0 =C2=A0 ebpf: Return 0 when configuration fails<br>
=C2=A0 =C2=A0 =C2=A0 ebpf: Refactor tun_rss_steering_prog()<br>
=C2=A0 =C2=A0 =C2=A0 ebpf: Add a separate target for skeleton<br>
<br>
=C2=A0ebpf/rss.bpf.skeleton.h=C2=A0 | 1557 +++++++++++++++++++++++---------=
--------------<br>
=C2=A0include/net/net.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 8 -<br>
=C2=A0net/tap_int.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0=
 1 -<br>
=C2=A0ebpf/ebpf_rss.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A012 +-=
<br>
=C2=A0hw/net/e1000e.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 -<=
br>
=C2=A0hw/net/igb.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 1 -<br>
=C2=A0hw/net/net_tx_pkt.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 4 +-<br>
=C2=A0hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 308 +++++----<br>
=C2=A0hw/net/vmxnet3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 2 -<=
br>
=C2=A0net/dump.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A0 4 +-<br>
=C2=A0net/net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A047 +-<br>
=C2=A0net/netmap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 5 -<br>
=C2=A0net/tap-bsd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0=
 5 -<br>
=C2=A0net/tap-linux.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A020 -<=
br>
=C2=A0net/tap-solaris.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 5 -<br>
=C2=A0net/tap-stub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0=
 5 -<br>
=C2=A0net/tap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A077 +--<br>
=C2=A0tools/ebpf/rss.bpf.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A046 +-<br>
=C2=A0tools/ebpf/Makefile.ebpf |=C2=A0 =C2=A015 +-<br>
=C2=A019 files changed, 986 insertions(+), 1137 deletions(-)<br>
---<br>
base-commit: 9c74490bff6c8886a922008d0c9ce6cae70dd17e<br>
change-id: 20231210-rss-e7c98e722253<br>
<br>
Best regards,<br>
-- <br>
Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_bl=
ank">akihiko.odaki@daynix.com</a>&gt;<br>
<br>
</blockquote></div>

--0000000000006de91e060c3a9a78--


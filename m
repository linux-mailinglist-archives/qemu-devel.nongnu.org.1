Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 567E67769CD
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 22:22:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTpgG-0000kL-6S; Wed, 09 Aug 2023 16:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qTpgE-0000k7-8k
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 16:21:18 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qTpgC-0007FH-Ge
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 16:21:18 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4fe3678010eso213534e87.3
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 13:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691612474; x=1692217274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6TX84wKJnc8azC3YuoK94GEzSEcJOUh0wUAdYhJxEGc=;
 b=ooJRmqQZF8fXZu8Z5Z1Ha9J5NZPT5mTwp7ChStqnB2+HT4G0oyYC3vypdp4lf/mzo4
 CgD2U1VATPJ3c2+Qvd/jJf6XAJuuCb6PmGERkyhnILyXENSAuN+rUYNdKHWbiwBUvAmW
 kEW+YmvwlWYb0F0fK48QtUJ6B8ceeQKGsCnKNTyvoN8XWQAGhKpH9JdiMBiO6Iz881IJ
 FPCUFfolU47jJqQdAsmbjKGazq+7qUpvr8RXrHhDY+di+VMVNUFArty+39iH87Cw6O+h
 wZGqodbfriMDUuroaXxIBmyCtvqamyxoRufmx+LGbLTTUR68Jd4FqntBO8i37ROWskAi
 t2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691612474; x=1692217274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6TX84wKJnc8azC3YuoK94GEzSEcJOUh0wUAdYhJxEGc=;
 b=Ycsgh6jT58fr4o7nJX5kEGGzGiiRkOWoamsaWUhZ2DmXeeFgARP6qVyHOyja8k/FyT
 kKPd4ObJdkejdNn/qsp5Dqz08UNqaHUgY75jwDJJkvhnC5ClERnQ7ReekM5AqHgNm0Zv
 6M+E5AbBQLl5OvojqqftcTOqUad/yAIV3R4ztEk8Ugbl7Q718RyiH7z9euNcf6wTi5y8
 rbLLU18dHX3P5a+L4nI7yz4fjsLGvcGD0Eh2lPeG0p1l5DRrh/n9ayKxYwlbdNeMmJ16
 vvIhi07C/vljs64BPZ6l+o2JM92a2uWJ3oNHRbBb5fKxg5LAr2maGXYPsd2TN+WrGTm3
 BhBg==
X-Gm-Message-State: AOJu0YzQHPhcBD9xmdI+5tBcQg4JfYNLuSxVCNd5PNeeq+POLEXZaNdd
 DMevnFetOj5ptJWJzGNk6gpGE4UKQSsUDU6/Era9hA==
X-Google-Smtp-Source: AGHT+IH02xeMK4IwR8sWjsFDh/YB0L3Ikr9oJBrmve2BnornTc0eT1ThTvR7KTX5TDHtfcXCujvgqFmW0PUJiIslMTs=
X-Received: by 2002:a05:6512:2312:b0:4f9:556b:93c5 with SMTP id
 o18-20020a056512231200b004f9556b93c5mr135687lfu.40.1691612474271; Wed, 09 Aug
 2023 13:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
In-Reply-To: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Wed, 9 Aug 2023 23:21:01 +0300
Message-ID: <CAOEp5Ocvd=WByDkh4jDO1mcbQbcAxA=As61_JaUxaP-t3+FMzQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] virtio-net: add USO feature (UDP segmentation
 offload)
To: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com, akihiko.odaki@daynix.com, 
 jasowang@redhat.com, sriram.yagnaraman@est.tech, mst@redhat.com, 
 sw@weilnetz.de, qemu-devel@nongnu.org
Cc: yan@daynix.com
Content-Type: multipart/alternative; boundary="000000000000a08187060283380e"
Received-SPF: none client-ip=2a00:1450:4864:20::136;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lf1-x136.google.com
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

--000000000000a08187060283380e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping

On Tue, Aug 1, 2023 at 1:32=E2=80=AFAM Yuri Benditovich <yuri.benditovich@d=
aynix.com>
wrote:

> Starting from 6.2 the kernel supports UDP segmentation offload, it
> uses GSO_UDP_L4 to mark packets with UDP sermentation request
>
> v1->v2:
>  Enable USO features by default starting from 8.1
>  Move command-line parameters to the last patch
>
> Andrew Melnychenko (2):
>   tap: Add USO support to tap device.
>   virtio-net: Add USO flags to vhost support.
>
> Yuri Benditovich (2):
>   tap: Add check for USO features
>   virtio-net: Add support for USO features
>
>  hw/core/machine.c    |  4 ++++
>  hw/net/e1000e_core.c |  2 +-
>  hw/net/igb_core.c    |  2 +-
>  hw/net/vhost_net.c   |  3 +++
>  hw/net/virtio-net.c  | 35 ++++++++++++++++++++++++++++++++---
>  hw/net/vmxnet3.c     |  2 ++
>  include/net/net.h    |  7 +++++--
>  net/net.c            | 13 +++++++++++--
>  net/tap-bsd.c        |  7 ++++++-
>  net/tap-linux.c      | 27 ++++++++++++++++++++++++---
>  net/tap-linux.h      |  2 ++
>  net/tap-solaris.c    |  7 ++++++-
>  net/tap-stub.c       |  7 ++++++-
>  net/tap-win32.c      |  2 +-
>  net/tap.c            | 18 +++++++++++++++---
>  net/tap_int.h        |  4 +++-
>  net/vhost-vdpa.c     |  3 +++
>  17 files changed, 125 insertions(+), 20 deletions(-)
>
> --
> 2.34.3
>
>

--000000000000a08187060283380e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ping</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Aug 1, 2023 at 1:32=E2=80=AFAM Yuri Benditovic=
h &lt;<a href=3D"mailto:yuri.benditovich@daynix.com">yuri.benditovich@dayni=
x.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">Starting from 6.2 the kernel supports UDP segmentation offload, it<br>
uses GSO_UDP_L4 to mark packets with UDP sermentation request<br>
<br>
v1-&gt;v2:<br>
=C2=A0Enable USO features by default starting from 8.1<br>
=C2=A0Move command-line parameters to the last patch<br>
<br>
Andrew Melnychenko (2):<br>
=C2=A0 tap: Add USO support to tap device.<br>
=C2=A0 virtio-net: Add USO flags to vhost support.<br>
<br>
Yuri Benditovich (2):<br>
=C2=A0 tap: Add check for USO features<br>
=C2=A0 virtio-net: Add support for USO features<br>
<br>
=C2=A0hw/core/machine.c=C2=A0 =C2=A0 |=C2=A0 4 ++++<br>
=C2=A0hw/net/e1000e_core.c |=C2=A0 2 +-<br>
=C2=A0hw/net/igb_core.c=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0hw/net/vhost_net.c=C2=A0 =C2=A0|=C2=A0 3 +++<br>
=C2=A0hw/net/virtio-net.c=C2=A0 | 35 ++++++++++++++++++++++++++++++++---<br=
>
=C2=A0hw/net/vmxnet3.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 ++<br>
=C2=A0include/net/net.h=C2=A0 =C2=A0 |=C2=A0 7 +++++--<br>
=C2=A0net/net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 13 +++++++++++--=
<br>
=C2=A0net/tap-bsd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 ++++++-<br>
=C2=A0net/tap-linux.c=C2=A0 =C2=A0 =C2=A0 | 27 ++++++++++++++++++++++++---<=
br>
=C2=A0net/tap-linux.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
=C2=A0net/tap-solaris.c=C2=A0 =C2=A0 |=C2=A0 7 ++++++-<br>
=C2=A0net/tap-stub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 7 ++++++-<br>
=C2=A0net/tap-win32.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0net/tap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 18 +++++++++++++=
++---<br>
=C2=A0net/tap_int.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +++-<br>
=C2=A0net/vhost-vdpa.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +++<br>
=C2=A017 files changed, 125 insertions(+), 20 deletions(-)<br>
<br>
-- <br>
2.34.3<br>
<br>
</blockquote></div>

--000000000000a08187060283380e--


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C241277F06C
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 08:17:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWWJG-00057P-KS; Thu, 17 Aug 2023 02:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qWWJ9-00055b-5Y
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 02:16:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qWWJ5-0000S4-Po
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 02:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692252990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0fHeTkq5BJaRJEBdgkCFw6a0KuI4quOMn/wNIkULyuE=;
 b=CXhwyHgmuKQ3fzxVlmuTbPDmR4oW/MA/B6Xu3l2u4Xc6kaML5GztWpTJoI+p+nTx9Ej4D7
 2izYJL/EhdQyKoICK9m4JIwYy7fjSGFGDRvNs59pTnm+uxSrw4UpuG84Ne70OyidSjaKyp
 TrcBoD25kozLAJVxQtSjegadyRG5Sh0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-X4_5KLCkN9WsFKbqBHhGXA-1; Thu, 17 Aug 2023 02:15:21 -0400
X-MC-Unique: X4_5KLCkN9WsFKbqBHhGXA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b9cd6a555aso72235271fa.3
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 23:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692252920; x=1692857720;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0fHeTkq5BJaRJEBdgkCFw6a0KuI4quOMn/wNIkULyuE=;
 b=JKcmuCEj5fn2waNgsv6n1UCafgCu2FIcrkHdKlEd53/9KEfYxuTw+Lzb7MaJdRsNRW
 YnAnhDCzdAh6uCeELiE7z50RhFnhkXFsdtr/MTM3fz8aAfSjN3JxhFtZ3Ex0sc71lxDu
 0BO1dLyl/zf+2qboNkaixk9O0GYF1rDZPn6YNFJwpQ8WxwQ4KwnrTQaxNrIKUahNW0rr
 UHknfBAIlfFIRDuNBMjDDVvWCMimIBqu0IJD7ot8kGywhy+10v8/PQxqDdqiJr9eM6lJ
 A1P1msQt8LKwMtdXGYA6vsLqwGOxfvwTanu0rlBoV/uOCVxGZkNLaM78QYq7mr+G492u
 I3mg==
X-Gm-Message-State: AOJu0YxmjlBWGMWsPUontoYtMq8O2kYVH6FdnOSjhctHNfef+MOIR/9F
 j31yY3Rfa9n4GYff2pYv6QpqMIOsJpPfFJyLZf/wD41R0rBLwuLYuayK60wKJDMv8w2NgLMvLOD
 k08ibYqRnuEYe3Yn24TrX/qU4HxkeFEU=
X-Received: by 2002:a2e:3318:0:b0:2b6:d6e1:a191 with SMTP id
 d24-20020a2e3318000000b002b6d6e1a191mr4283424ljc.23.1692252920440; 
 Wed, 16 Aug 2023 23:15:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGJ9h+0UCetxbiTaUKffP5e8AlD+VPyL1S18DiIeMnXsn3zv3LBYMQBeWFyYzBCK3WmIlsEx9xgd7zyVyD4QY=
X-Received: by 2002:a2e:3318:0:b0:2b6:d6e1:a191 with SMTP id
 d24-20020a2e3318000000b002b6d6e1a191mr4283405ljc.23.1692252920078; Wed, 16
 Aug 2023 23:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230816200446.1408797-1-efim.shevrin@virtuozzo.com>
In-Reply-To: <20230816200446.1408797-1-efim.shevrin@virtuozzo.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Thu, 17 Aug 2023 09:15:08 +0300
Message-ID: <CAPMcbCowQoNn4b-Q+wFeT8m2OTFU+PDkDGq8=U--tdeEcDjk6Q@mail.gmail.com>
Subject: Re: [PATCH] qga: Start qemu-ga service after NetworkManager start
To: Efim Shevrin <efim.shevrin@virtuozzo.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, pbonzini@redhat.com, 
 den@openvz.org
Content-Type: multipart/alternative; boundary="0000000000002bf9620603185675"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000002bf9620603185675
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Efim

Thanks for your contribution.

I think your patch is a partial solution because other network managers can
be used
for example systemd-networkd or dhcpcd. Maybe a better solution is
After=3Dnetwork.target.

Do you have any other suggestions?

Best Regards,
Konstantin Kostiuk.


On Wed, Aug 16, 2023 at 11:20=E2=80=AFPM Efim Shevrin <efim.shevrin@virtuoz=
zo.com>
wrote:

> From: Fima Shevrin <efim.shevrin@virtuozzo.com>
>
> When the guest OS starts, qemu-ga sends an event to the host.
> This event allows services on the host to start configuring
> the already running guest OS. When configuring network settings,
> it is possible that an external service will receive a signal
> from qemu-ga about the start of guest OS, while NetworkManager
> may not be running yet. Therefore, network setting may not
> be available. With the current patch, we eliminate the described
> race condition between qemu-ga and NetworkManager for guest OS
> network setting cases.
>
> Signed-off-by: Fima Shevrin <efim.shevrin@virtuozzo.com>
> ---
>  contrib/systemd/qemu-guest-agent.service | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/systemd/qemu-guest-agent.service
> b/contrib/systemd/qemu-guest-agent.service
> index 51cd7b37ff..6e2d059356 100644
> --- a/contrib/systemd/qemu-guest-agent.service
> +++ b/contrib/systemd/qemu-guest-agent.service
> @@ -2,6 +2,7 @@
>  Description=3DQEMU Guest Agent
>  BindTo=3Ddev-virtio\x2dports-org.qemu.guest_agent.0.device
>  After=3Ddev-virtio\x2dports-org.qemu.guest_agent.0.device
> +After=3DNetworkManager.service
>
>  [Service]
>  ExecStart=3D-/usr/bin/qemu-ga
> --
> 2.34.1
>
>

--0000000000002bf9620603185675
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi, Efim<br><br>Thanks for your contribution.<br><br>=
I think your patch is a partial solution because other network managers can=
 be used</div><div>for example systemd-networkd or dhcpcd. Maybe a better s=
olution is After=3Dnetwork.target. <br></div><div><br></div><div>Do you hav=
e any other suggestions?<br></div><div><br></div><div><div><div dir=3D"ltr"=
 class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"l=
tr"><div>Best Regards,</div><div>Konstantin Kostiuk.</div></div></div></div=
><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Wed, Aug 16, 2023 at 11:20=E2=80=AFPM Efim Shevrin &lt;<a hre=
f=3D"mailto:efim.shevrin@virtuozzo.com">efim.shevrin@virtuozzo.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Fim=
a Shevrin &lt;<a href=3D"mailto:efim.shevrin@virtuozzo.com" target=3D"_blan=
k">efim.shevrin@virtuozzo.com</a>&gt;<br>
<br>
When the guest OS starts, qemu-ga sends an event to the host.<br>
This event allows services on the host to start configuring<br>
the already running guest OS. When configuring network settings,<br>
it is possible that an external service will receive a signal<br>
from qemu-ga about the start of guest OS, while NetworkManager<br>
may not be running yet. Therefore, network setting may not<br>
be available. With the current patch, we eliminate the described<br>
race condition between qemu-ga and NetworkManager for guest OS<br>
network setting cases.<br>
<br>
Signed-off-by: Fima Shevrin &lt;<a href=3D"mailto:efim.shevrin@virtuozzo.co=
m" target=3D"_blank">efim.shevrin@virtuozzo.com</a>&gt;<br>
---<br>
=C2=A0contrib/systemd/qemu-guest-agent.service | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/contrib/systemd/qemu-guest-agent.service b/contrib/systemd/qem=
u-guest-agent.service<br>
index 51cd7b37ff..6e2d059356 100644<br>
--- a/contrib/systemd/qemu-guest-agent.service<br>
+++ b/contrib/systemd/qemu-guest-agent.service<br>
@@ -2,6 +2,7 @@<br>
=C2=A0Description=3DQEMU Guest Agent<br>
=C2=A0BindTo=3Ddev-virtio\x2dports-org.qemu.guest_agent.0.device<br>
=C2=A0After=3Ddev-virtio\x2dports-org.qemu.guest_agent.0.device<br>
+After=3DNetworkManager.service<br>
<br>
=C2=A0[Service]<br>
=C2=A0ExecStart=3D-/usr/bin/qemu-ga<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--0000000000002bf9620603185675--



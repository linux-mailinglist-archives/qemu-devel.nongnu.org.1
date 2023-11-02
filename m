Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD03F7DEFC3
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:21:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyUot-0003Yj-VZ; Thu, 02 Nov 2023 06:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qyUoq-0003Y4-DX
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:20:56 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qyUon-0001cn-Na
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:20:56 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c523ac38fbso10733581fa.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 03:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698920452; x=1699525252;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=32W/MkNf86Mjal47bxOML2AqJMC/1XbwXA3ABHgXWjU=;
 b=IfrUn3MGZh4MW168Uibgj0zpvdA3rQdzvLFgv0O9RjSmXxCs4/iYrBkU6FHRIvlcUb
 M9LQPtknVuxLOJUB9xUMeK0pi2t6RBxfc1VtteKq05WJCz4tpmA0LvcPwd93qRPorDqN
 QVfIDTr3/C292SsH2ebQTCi1LraHN/4kF47cmnds6WEGN9OK2QAlZxYUqKIjKeAsVA2J
 kVPz3YAnmER5PWRPt25X9d/lPQcRlhxCgNcdEWcg9hRl/KRt+6tBxDFCjrLErXbpT2dI
 McZZTe+n8VIcDoaxrhMknpIxSKUAnchlsvQymTcBcV70PY779XFr86CTfpXcoYXWntkO
 Jbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698920452; x=1699525252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=32W/MkNf86Mjal47bxOML2AqJMC/1XbwXA3ABHgXWjU=;
 b=S0H2V3zQlcva3hJIUaZ+I8hqTq3fZBzLHy8+p3u84sFegyn0ygzt5PLKIYe6a8yi6O
 K2jpNmAfFjhX1B8TNStCj1wMyisT1N/uf/bB5Brr3dQJk2mB0y5dca1NhOznx6h9bvGf
 9el6KvZj0YhDBASoSB51ZGAVOdS24LmhBeiBcUCEQU/j3PURIBI9KkaeuykT0OWH6z6q
 tnBByh67OSN4PiPPTNbDzzlBYIxByvcWtWEIX5vmqCY9sFlYE1cRXzPO7m9+1BqTEwk6
 DA9+XGs69/8lH8aI7ITFZxJzyJKglvl/HBvhS+HHaNKH16n75DeNp+Oo5tDFKheVbmq6
 lMgA==
X-Gm-Message-State: AOJu0YwA+vbTiDTpye/K41ekOILjf+nCj25fnytvzP6j1cvpKN0Kueze
 YYL/TXmHRjcGV96Hv2TgieFFBqK4squ6WntdIGyhjw==
X-Google-Smtp-Source: AGHT+IH3GW5fQZMfj9qGSYtwImgnk/z1lQoll+Gh+Yh8TPPNr6kQKlay5moV7HkywpM0/K/pG6tZGzz0nutiBI4Y2P4=
X-Received: by 2002:a2e:8e6b:0:b0:2c6:efc6:946f with SMTP id
 t11-20020a2e8e6b000000b002c6efc6946fmr1086296ljk.30.1698920451879; Thu, 02
 Nov 2023 03:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
 <CAOEp5Oern10jW8Pi-_mceU_ZJVD=a1f3tW8rB2O4efLX45-nvw@mail.gmail.com>
 <8880b6f9-f556-46f7-a191-eeec0fe208b0@daynix.com>
 <CACGkMEv=A0KS-LtgZmsMehdoUL=EuQzhkfNipKaV1kdUr2Y5Bw@mail.gmail.com>
 <d0db0fb1-0a58-45b7-a623-df6ee9096e2e@daynix.com>
 <20231101023805-mutt-send-email-mst@kernel.org>
 <39a02a4c-f8fa-437c-892f-caca84b8d85d@daynix.com>
 <20231101050838-mutt-send-email-mst@kernel.org>
 <e469b33b-c3f3-4d88-bdf2-508c4a35c827@daynix.com>
 <CAOEp5OcDMdKKPHSVd-GxT-GkBpvbWkMijSBgwihPsEnxmDR7eA@mail.gmail.com>
 <20231102053202-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231102053202-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 2 Nov 2023 12:20:39 +0200
Message-ID: <CAOEp5OefD2LN2MDnEkE=DOMSX0Jw8Z6gAiKAag4dtkecmr1Jgg@mail.gmail.com>
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Andrew Melnychenko <andrew@daynix.com>
Content-Type: multipart/alternative; boundary="00000000000009477f060928be7b"
Received-SPF: none client-ip=2a00:1450:4864:20::22a;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lj1-x22a.google.com
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

--00000000000009477f060928be7b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 11:33=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:

> On Thu, Nov 02, 2023 at 11:09:27AM +0200, Yuri Benditovich wrote:
> > Probably we mix two different patches in this discussion.
> > Focusing on the patch in the e-mail header:
> >
> > IMO it is not acceptable to fail QEMU run for one feature that we can't
> make
> > active when we silently drop all other features in such a case.
>
> If the feature is off by default then it seems more reasonable
> and silent masking can be seen as a bug.
> Most virtio features are on by default this is why it's
> reasonable to mask them.
>
>
If we are talking about RSS: setting it initially off is the development
time decision.
When it will be completely stable there is no reason to keep it off by
default, so this is more a question of time and of a readiness of libvirt.

> --
> MST
>
>

--00000000000009477f060928be7b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 2, 2023 at 11:33=E2=80=AF=
AM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n Thu, Nov 02, 2023 at 11:09:27AM +0200, Yuri Benditovich wrote:<br>
&gt; Probably we mix two different patches in this discussion.<br>
&gt; Focusing on the patch in the e-mail header:<br>
&gt; <br>
&gt; IMO it is not acceptable to fail QEMU run for one feature that we can&=
#39;t make<br>
&gt; active when we silently drop all other features in such a case.<br>
<br>
If the feature is off by default then it seems more reasonable<br>
and silent masking can be seen as a bug.<br>
Most virtio features are on by default this is why it&#39;s<br>
reasonable to mask them.<br>
<br></blockquote><div><br></div><div>If we are talking about RSS: setting i=
t initially off is the development time decision.=C2=A0</div><div>When it w=
ill be completely stable there is no reason to keep it off by default, so t=
his is more a question of time and of a readiness of libvirt.=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
-- <br>
MST<br>
<br>
</blockquote></div></div>

--00000000000009477f060928be7b--


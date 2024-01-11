Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DDB82B239
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 16:56:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNxOP-0001Ot-WC; Thu, 11 Jan 2024 10:54:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rNxOK-0001Oj-Ly
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:54:48 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rNxOE-0002UB-P2
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:54:46 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-28b82dc11e6so3293541a91.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 07:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1704988358; x=1705593158;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KwuBge6OSP9GsLaivULUMKkyWjvhgEEm5Po2ddIf1co=;
 b=ktHu8J+AxvZb4mLTDEfDifJe+PO/BNVIcYnTtnB6+hOUDTk5DUsSUhoTFTsPXjiuak
 ZArWH8emGzlBWn8c1bxCPCsAjJFM4msdr1vlArQ4YDg/maWHz58PzXxiMJeeCfsA/6sI
 WWY7ATsVPnnLenvKPSrBklucv08vouiWiY9FlcnRbbs7fHdvedwM6u1c+iZMz2j6Kod/
 pwoeq2Ol37bJsQ6k+oRzk7a/7idMXMXOyOCyOJG0mPqTUp4Q/KyZ5A0q8FVs3drNYdG0
 CeN5fNtuOhpUdtFk8RDBrxrXBec8n7q8O2B/KTLr81logYs7Uug0dkGU7ZQrFwpdm/ZJ
 jEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704988358; x=1705593158;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KwuBge6OSP9GsLaivULUMKkyWjvhgEEm5Po2ddIf1co=;
 b=bSSqSt/cw+e76eUzri7GpTAIYfPbvPW6SqEM8WNRV3yqKfA48sD5zkJ+ZKf3b7J7t8
 P8+LYLAluzyA5Dv0IqEEz9EkXyff97QrfQdIxQjaLkjDuHryrpC134Gms6gcpj30UVTQ
 0SPOeUYHKE5XneYQswnbRuUnZlriqTG1h64Soa4d1AHVl7IhplbPPqzEyZYtn/N0A3H/
 ex9iOcPs2j3ffrLPVd0KnrukTtkCy+bCDTxT7lXuMF0ocZzCk+oJAF3nn/Zlv6IgD7uZ
 wNHMGy0utFfqmXE7GH1lRWfIQlF0E5oE3oWMVWWYbDkTXRyzE9cRSNVIPBaLNphGdJ7S
 Q2Tw==
X-Gm-Message-State: AOJu0YzBdrTMMokPsjKuKnHES6uc31L7TWSwz9Bd7DU2VRgQFXqjpECs
 pKnTYJFQxUAw0dcSSXsGKZ2uW7VVTtdp0IRa0bT/ADTFXScXbw==
X-Google-Smtp-Source: AGHT+IEJOpYquXVfUqO3U3t4Ybm+L7OBpicrVX4CVJRbZMTpEDRRgdc9LCxx0jrMcILLb1qxiblFRZCp4/UJqzTr8LI=
X-Received: by 2002:a17:90a:1008:b0:28c:fb01:a2d5 with SMTP id
 b8-20020a17090a100800b0028cfb01a2d5mr1090587pja.67.1704988356582; Thu, 11 Jan
 2024 07:52:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1703482349.git.yong.huang@smartx.com>
 <20ab47b728492cedb7ea671239f0397a141c3f5a.1703482349.git.yong.huang@smartx.com>
 <87o7dsufrk.fsf@pond.sub.org>
In-Reply-To: <87o7dsufrk.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Thu, 11 Jan 2024 23:52:20 +0800
Message-ID: <CAK9dgmZR2Pyaj1ECp8wF9RV_WFvAGN8DHgy0MoNq_+hHbbe4fA@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 06/10] block: Support detached LUKS header
 creation using blockdev-create
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000057331f060ead896b"
Received-SPF: none client-ip=2607:f8b0:4864:20::1029;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x1029.google.com
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

--00000000000057331f060ead896b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 10:05=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om>
wrote:

> Fails to compile for me:
>
> ../block/crypto.c: In function =E2=80=98block_crypto_co_create_luks=E2=80=
=99:
> ../block/crypto.c:784:1: error: control reaches end of non-void function
> [-Werror=3Dreturn-type]
>   784 | }
>       | ^
>
>
Ok, I'll check it out and fix it in the next version.

By the way, I'm stuck with some other work, so version 4 might not be
finished for
a few weeks, but I'll get to it as soon as I can.

Thanks,
Yong

--=20
Best regards

--00000000000057331f060ead896b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 11, 20=
24 at 10:05=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redha=
t.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left=
-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Fails to =
compile for me:<br>
<br>
../block/crypto.c: In function =E2=80=98block_crypto_co_create_luks=E2=80=
=99:<br>
../block/crypto.c:784:1: error: control reaches end of non-void function [-=
Werror=3Dreturn-type]<br>
=C2=A0 784 | }<br>
=C2=A0 =C2=A0 =C2=A0 | ^<br>
<br>
</blockquote></div><br clear=3D"all"><div><div class=3D"gmail_default" styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Ok, I&#39;ll check i=
t out and fix it in the next version.</div><div class=3D"gmail_default" sty=
le=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></div><div clas=
s=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-ser=
if">By the way, I&#39;m stuck with some other work, so version 4 might not =
be finished for</div><div class=3D"gmail_default" style=3D"font-family:&quo=
t;comic sans ms&quot;,sans-serif">a few weeks, but I&#39;ll get to it as so=
on as I can.=C2=A0<br></div><br></div><div><div class=3D"gmail_default" sty=
le=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Thanks,=C2=A0</div>=
<div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;=
,sans-serif">Yong</div><br></div><span class=3D"gmail_signature_prefix">-- =
</span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><fon=
t face=3D"comic sans ms, sans-serif">Best regards</font></div></div></div>

--00000000000057331f060ead896b--


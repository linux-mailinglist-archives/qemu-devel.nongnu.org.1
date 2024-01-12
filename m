Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E349E82C266
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 16:02:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOJ1o-0005i7-U4; Fri, 12 Jan 2024 10:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rOJ1l-0005gP-0O
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:00:57 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rOJ1g-0000Xi-NZ
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:00:56 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d4a2526a7eso40138445ad.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 06:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1705071528; x=1705676328;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3wjwIUFfJ9w4KzO3QS1MAtt/nxSJ9nef+JNC/yNrjuU=;
 b=jfVmiapCjBnqQzF0eqJPyxQktowqwpHu11Bjqm1+stWr8DYZqIkj2np2q4BvyxzsBM
 hXNnZA4tUNlcyw+hM2nHZgaekUZuhVwbEL5aL3uJBAsXYcx2ntbF4BfPjJp1vmjymz1B
 4Evd4g2KIOyeezBh1kzbKJfYMirHUIiTB6+5Z+JrNlcO4fgQf946dormVemRX/7VgbzK
 Vo8YKIuq2u2sJwxv3TZOTzM/+uh66NLawDp46dpXr6V1W5n4dJLaTuTAS5rdjPW0lwqv
 TfDKPeCSIH8mohfm7s0XM+qdxBq2lW7ok1X/XJUjq+p8Mdag96dw1okOk9zvvImx4x/Y
 BE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705071528; x=1705676328;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3wjwIUFfJ9w4KzO3QS1MAtt/nxSJ9nef+JNC/yNrjuU=;
 b=byMlVbT2C8TXjxknf4cNrkya6qRrGifB7pSlKa8CkQC7jUyjeK/4Yv+W3XtwEMOSU6
 Izbgm4lpsWOopILasyn2WgfiDABjhZnJJiH4e2ode5G4+AOAE0jRyupXuOTdLIFcVx9w
 PsTqw1CrFal2lihJ3oCq4HtPDYDysRf5rgTCIlCzfaECeR1WFkqwZitxXirXknNE/igs
 sGrkKapq+eKS7+QRNSgjhpFntaqPhDLXcgb6pgHxWp9KF+jR1OkwbNcupDiZ+Z65ME3V
 2jSo5Zm/rwRaO63PPElanvOq5CUhyTcoE5cdOD2/jZM5/ugORw1bxXQY855poQLnnviW
 sn6A==
X-Gm-Message-State: AOJu0YyEmuteYkriJERdz01P4VhTdJWIbthivRukuUFyFEvZ4hEaqBvB
 AkDBTjqZg97hn7zc1zaC9OLkVL4NvgZg6CTdIEKSOFoRYyjI1A==
X-Google-Smtp-Source: AGHT+IHpcVzdmCYnDiiSQW9V9Lc9qdMTu6OyoYlTwTWUSAPR5lMQQ15cyT7AeTBZjQBfoqDWXJUo/GO5ZfjfwZCeyrI=
X-Received: by 2002:a17:90a:5786:b0:28c:f2f5:a966 with SMTP id
 g6-20020a17090a578600b0028cf2f5a966mr1245921pji.10.1705071526307; Fri, 12 Jan
 2024 06:58:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1704382761.git.yong.huang@smartx.com>
 <6f0de9a1c82f64c4055908573d82a1c86c4d99e8.1704382761.git.yong.huang@smartx.com>
 <87h6jiodgx.fsf@pond.sub.org>
In-Reply-To: <87h6jiodgx.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 12 Jan 2024 22:58:28 +0800
Message-ID: <CAK9dgmZnwNTc4EiPAseb2qB3zWaAPvfMR5uBXE_JsUvzr7uoTA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hmp: Drop unknown feature and status bits
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a4865b060ec0e6ca"
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x633.google.com
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

--000000000000a4865b060ec0e6ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 10:04=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om>
wrote:

> Hyman Huang <yong.huang@smartx.com> writes:
>
> > The QMP command "x-query-virtio-status" outputs the full
> > feature and status bit information, so there is no need
> > to maintain it in the HMP output; drop it.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
>
> I'm not sure hiding unknown bits from HMP users is a good idea.  Sure,
> you can use QMP to find them, but why would you when HMP gives no clue
> that its output is incomplete?
>
> I'd simply keep them, i.e. drop this patch.
>
>
Ok, I'm not insisting on that.

Thanks,
Yong

--=20
Best regards

--000000000000a4865b060ec0e6ca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 12, 20=
24 at 10:04=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redha=
t.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left=
-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Hyman Hua=
ng &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huan=
g@smartx.com</a>&gt; writes:<br>
<br>
&gt; The QMP command &quot;x-query-virtio-status&quot; outputs the full<br>
&gt; feature and status bit information, so there is no need<br>
&gt; to maintain it in the HMP output; drop it.<br>
&gt;<br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
<br>
I&#39;m not sure hiding unknown bits from HMP users is a good idea.=C2=A0 S=
ure,<br>
you can use QMP to find them, but why would you when HMP gives no clue<br>
that its output is incomplete?<br>
<br>
I&#39;d simply keep them, i.e. drop this patch.<br>
<br>
</blockquote></div><div><br></div><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">Ok, I&#39;m not insisting on=
 that.</div><br clear=3D"all"><div><div class=3D"gmail_default" style=3D"fo=
nt-family:&quot;comic sans ms&quot;,sans-serif">Thanks,=C2=A0</div><div cla=
ss=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-se=
rif">Yong</div><br></div><span class=3D"gmail_signature_prefix">-- </span><=
br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=
=3D"comic sans ms, sans-serif">Best regards</font></div></div></div>

--000000000000a4865b060ec0e6ca--


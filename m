Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF48179C765
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 09:00:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxM6-0000be-7f; Tue, 12 Sep 2023 02:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qfxM2-0000U2-GI
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:58:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qfxLz-0007Ug-VY
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694501910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wZrTqukWHnPWWbvnZDqlF5kaRTDI2U9oKEUB+v8CpRA=;
 b=UXmCyIk6sCnoS+EXAcvRWOfavIiKHHmypqKRwIQhBodv5gmkA3xZgMO8/eBqMZ+F2S1Ph2
 PIsIeHWVIO6Q6WbXXsAsOp1Dv8yTK+KUBOl/wWsIjpHGSWCiIfpnsLJ2vSPeuCst/Y49v7
 +R648QZ2gbB+kq1z4PhaFjS8FIbd0ho=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-5UR58K-TOSKU6iwfo8V_FA-1; Tue, 12 Sep 2023 02:58:28 -0400
X-MC-Unique: 5UR58K-TOSKU6iwfo8V_FA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-273983789adso6327480a91.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 23:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694501907; x=1695106707;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wZrTqukWHnPWWbvnZDqlF5kaRTDI2U9oKEUB+v8CpRA=;
 b=CMeEIleIaSSatNozq60iziKCEUixihl+ALU9w+6qQ1GYlGIHOp6p33FAPBZ4WTfxDQ
 0LWLimhJdlUcRFxYT0aW0Yf4MquFGukUrSnILErSQs2MdzPUnEPa7hKZh/nkSGeBGFsj
 wYrAj5WtXgkbH9/QBMjvOQcNpjUCoSWTHkutwWOQS4kYsONtugfH3rSLsbMMnrn850yQ
 Wm0j9YxQOaP9t5cxUfnehHmiNza8074mzA7C6rPzNqV8//EvLTXHN9xc9Z/KCfKRndhH
 1LN7nT6q9txlQ1z+f/b7r5UPFpd2zlxdkklfJNM4VboNhydjMZpe2jm+4jqeNFDQnnV+
 HcYg==
X-Gm-Message-State: AOJu0YydGf4v4BDp3BLXuA5p8pL+1c0eR0cMGt+7fSwQIFGfPQ6h/SF6
 ye+nN2kf1+l5LkkeLd8o+CTtNZFciKK+1ot5FQ49S+TZzieGF1XQbJ9a+C0TEPnBQYmNI+R1F8/
 /Tb4yH1as+AOfPyeJeaVyyLQFB07Nj+M=
X-Received: by 2002:a17:90b:1988:b0:262:ded7:63d with SMTP id
 mv8-20020a17090b198800b00262ded7063dmr9558697pjb.17.1694501907584; 
 Mon, 11 Sep 2023 23:58:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdhPk2C53JGPn6b40/XqlpTSfZL9/bzKuDoxeb/5Ra9gFzlgnRZoIqPlSwcJcjyRHBsEig8rOITNLrzDKCuoA=
X-Received: by 2002:a17:90b:1988:b0:262:ded7:63d with SMTP id
 mv8-20020a17090b198800b00262ded7063dmr9558688pjb.17.1694501907303; Mon, 11
 Sep 2023 23:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230912062836.1530898-1-marcandre.lureau@redhat.com>
In-Reply-To: <20230912062836.1530898-1-marcandre.lureau@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 12 Sep 2023 08:58:16 +0200
Message-ID: <CADSE00+RX4=0zGs+JvP=Un2+f44MrXpKB+buL=C_Za_K=Zya9g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ui: fix crash when there are no active_console
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000041a4f7060523f8c5"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
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

--00000000000041a4f7060523f8c5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 8:28=E2=80=AFAM <marcandre.lureau@redhat.com> wrote=
:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> 0x0000555555888630 in dpy_ui_info_supported (con=3D0x0) at
> ../ui/console.c:812
> 812         return con->hw_ops->ui_info !=3D NULL;
> (gdb) bt
> #0  0x0000555555888630 in dpy_ui_info_supported (con=3D0x0) at
> ../ui/console.c:812
> #1  0x00005555558a44b1 in protocol_client_msg (vs=3D0x5555578c76c0,
> data=3D0x5555581e93f0 <incomplete sequence \373>, len=3D24) at ../ui/vnc.=
c:2585
> #2  0x00005555558a19ac in vnc_client_read (vs=3D0x5555578c76c0) at
> ../ui/vnc.c:1607
> #3  0x00005555558a1ac2 in vnc_client_io (ioc=3D0x5555581eb0e0,
> condition=3DG_IO_IN, opaque=3D0x5555578c76c0) at ../ui/vnc.c:1635
>
> Fixes:
> https://issues.redhat.com/browse/RHEL-2600
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/console.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/ui/console.c b/ui/console.c
> index 90ae4be602..0fbec4d0bd 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -808,6 +808,9 @@ bool dpy_ui_info_supported(QemuConsole *con)
>      if (con =3D=3D NULL) {
>          con =3D active_console;
>      }
> +    if (con =3D=3D NULL) {
> +        return false;
> +    }
>
>      return con->hw_ops->ui_info !=3D NULL;
>  }
> --
> 2.41.0
>
> Reviewed-by: Albert Esteve <aesteve@redhat.com>

--00000000000041a4f7060523f8c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 12, 2023 at 8:28=E2=80=AF=
AM &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@r=
edhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
<br>
Thread 1 &quot;qemu-system-x86&quot; received signal SIGSEGV, Segmentation =
fault.<br>
0x0000555555888630 in dpy_ui_info_supported (con=3D0x0) at ../ui/console.c:=
812<br>
812=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return con-&gt;hw_ops-&gt;ui_info !=3D=
 NULL;<br>
(gdb) bt<br>
#0=C2=A0 0x0000555555888630 in dpy_ui_info_supported (con=3D0x0) at ../ui/c=
onsole.c:812<br>
#1=C2=A0 0x00005555558a44b1 in protocol_client_msg (vs=3D0x5555578c76c0, da=
ta=3D0x5555581e93f0 &lt;incomplete sequence \373&gt;, len=3D24) at ../ui/vn=
c.c:2585<br>
#2=C2=A0 0x00005555558a19ac in vnc_client_read (vs=3D0x5555578c76c0) at ../=
ui/vnc.c:1607<br>
#3=C2=A0 0x00005555558a1ac2 in vnc_client_io (ioc=3D0x5555581eb0e0, conditi=
on=3DG_IO_IN, opaque=3D0x5555578c76c0) at ../ui/vnc.c:1635<br>
<br>
Fixes:<br>
<a href=3D"https://issues.redhat.com/browse/RHEL-2600" rel=3D"noreferrer" t=
arget=3D"_blank">https://issues.redhat.com/browse/RHEL-2600</a><br>
<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0ui/console.c | 3 +++<br>
=C2=A01 file changed, 3 insertions(+)<br>
<br>
diff --git a/ui/console.c b/ui/console.c<br>
index 90ae4be602..0fbec4d0bd 100644<br>
--- a/ui/console.c<br>
+++ b/ui/console.c<br>
@@ -808,6 +808,9 @@ bool dpy_ui_info_supported(QemuConsole *con)<br>
=C2=A0 =C2=A0 =C2=A0if (con =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0con =3D active_console;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 if (con =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0return con-&gt;hw_ops-&gt;ui_info !=3D NULL;<br>
=C2=A0}<br>
-- <br>
2.41.0<br>
<br></blockquote><div>Reviewed-by: Albert Esteve &lt;<a href=3D"mailto:aest=
eve@redhat.com">aesteve@redhat.com</a>&gt;=C2=A0</div></div></div>

--00000000000041a4f7060523f8c5--



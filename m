Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A39747A8B49
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:11:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj1fQ-0006P8-Em; Wed, 20 Sep 2023 14:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj1fN-0006Oy-QV
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:11:13 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj1fL-00087M-CE
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:11:12 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-405082a8c77so1247765e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695233470; x=1695838270;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J1iXM0MLDwbszemP1C1sPVPWvMgSV6u2YcGSdtNV0wU=;
 b=mZcpx8VOpcEsN6fwZv3NtMaeEfTDRrNs6gtNUTw1IylQtbIDAjUO+AEalRKUDaVDzZ
 W80fWbdSTlBi4a3Smd4ENGjZyJ2Yf3ogqDweXQoLSbfcUoOCJql8CtuSJEMyrZBdAFuH
 a4SSEk+csz4CbRUrOevZOnlgxn/HZ5mziy6eYTKQt1rFqeHQKwk5VXOeSZGkswqThzSK
 rYYtmyWNUQntWjhnD0R0hP94CD8cbfbBv+Lfsw7tiU5g0mZ260lxC67c09n5+i4jfitr
 UUXRlaFEXpUigG0r8vkR/X+G2xekLmiCP0SKjSQNIuqGs6lGwZlBqcc4ejOhp7htSVfe
 V/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695233470; x=1695838270;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J1iXM0MLDwbszemP1C1sPVPWvMgSV6u2YcGSdtNV0wU=;
 b=nmiXuq3O8SvCBceJFOLGU2EKYrCypHE5Z8MYOUG/z9ers0KSGhWMUxVrfsEbNWoWES
 W83jhDIIKMZmkdsqZ67vJF442rYrhutskXJS2IWgtogZwNfwCiaWg7Z/kPhlXS72XlY3
 KtE0Gp5XRvhKEA75GKVRWa01OrMLw9FT+yxSgZxcEvTd1iWeWtpuepUwHiai2dOvoxfA
 uiB/UpEsC1rsMZDbtSj8ZukgFe3EXkvtnBozhrggu2qLeMN83jDMiWkh3DTrXnQSjYCC
 7gyHKdjrZCEyXP51dPQZ3aOSuKOb0WuKnAm0gvRkXaqep/Kr0dVwASXlMTSfWFpyYh7J
 3QkA==
X-Gm-Message-State: AOJu0Yy2U0L/ya2k3OgiyYjbCwT6dJbAGpIOVbFVA74FF1HRLnnYocc0
 A5FEuvuUdaiVfdLXTIKbd1uP521GJIEAZUzLB0Xv4TMyuTH99yh57/+JCeUA
X-Google-Smtp-Source: AGHT+IHMPyCWRr4VqFjws6b0s2S/wyQboah8IVAqW+d2mYyfbn36TpuGcyWq7IDRAU6lA6cHgtMY0oKUj2EvFjEau9s=
X-Received: by 2002:aa7:c589:0:b0:531:3c4e:98bc with SMTP id
 g9-20020aa7c589000000b005313c4e98bcmr3220044edq.8.1695233448601; Wed, 20 Sep
 2023 11:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-8-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-8-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 19:10:37 +0100
Message-ID: <CANCZdfpTFB8oSWvjTfidsEa6jkZFo-x9=nGT2Qf6h2cwddkY7w@mail.gmail.com>
Subject: Re: [PATCH v2 07/28] bsd-user: Implement target_to_host_rlim and
 host_to_target_rlim conversion.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000083fb810605ce4b61"
Received-SPF: none client-ip=2a00:1450:4864:20::32e;
 envelope-from=wlosh@bsdimp.com; helo=mail-wm1-x32e.google.com
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

--00000000000083fb810605ce4b61
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 10:39=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/bsd-proc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


> diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
> index 68410a0aa9..19e39a2f76 100644
> --- a/bsd-user/bsd-proc.c
> +++ b/bsd-user/bsd-proc.c
> @@ -38,3 +38,13 @@ int target_to_host_resource(int code)
>      return code;
>  }
>
> +rlim_t target_to_host_rlim(abi_llong target_rlim)
> +{
> +    return tswap64(target_rlim);
> +}
> +
> +abi_llong host_to_target_rlim(rlim_t rlim)
> +{
> +    return tswap64(rlim);
> +}
> +
> --
> 2.42.0
>
>

--00000000000083fb810605ce4b61
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 17, 2023 at 10:39=E2=80=
=AFPM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.tah=
a2.7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-proc.c | 10 ++++++++++<br>
=C2=A01 file changed, 10 insertions(+)<br></blockquote><div><br></div><div>=
Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.c=
om</a>&gt;=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c<br>
index 68410a0aa9..19e39a2f76 100644<br>
--- a/bsd-user/bsd-proc.c<br>
+++ b/bsd-user/bsd-proc.c<br>
@@ -38,3 +38,13 @@ int target_to_host_resource(int code)<br>
=C2=A0 =C2=A0 =C2=A0return code;<br>
=C2=A0}<br>
<br>
+rlim_t target_to_host_rlim(abi_llong target_rlim)<br>
+{<br>
+=C2=A0 =C2=A0 return tswap64(target_rlim);<br>
+}<br>
+<br>
+abi_llong host_to_target_rlim(rlim_t rlim)<br>
+{<br>
+=C2=A0 =C2=A0 return tswap64(rlim);<br>
+}<br>
+<br>
-- <br>
2.42.0<br>
<br>
</blockquote></div></div>

--00000000000083fb810605ce4b61--


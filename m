Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFD082F39B
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 19:00:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPnj4-0001cJ-Mz; Tue, 16 Jan 2024 12:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rPnj2-0001c4-Qh
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 12:59:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rPnj1-0002V5-AF
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 12:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705427986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UMc2Kc5Jl9A+Bok/Irw+YNHjH17ACpwStRVenK0Qtcg=;
 b=IEK0hun05O8azzLkbVWMtISir2W1hGSNLB9l4gMPlQci6TjSImzqmYSPgS3C083zN45aYQ
 2qhbsLNwgFI8d7QrHkInEE+SoUG7QxjRGLv3ULgFDHhGdAEOozKuVJ1Mca8bJrinCbJEKt
 GuLRgr5bbOCo02J9xgkNzBtzrRKiQSQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-xsQ4CGW3OVCeZP7si6f4tg-1; Tue, 16 Jan 2024 12:24:54 -0500
X-MC-Unique: xsQ4CGW3OVCeZP7si6f4tg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2cddb11b256so5598891fa.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 09:24:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705425893; x=1706030693;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UMc2Kc5Jl9A+Bok/Irw+YNHjH17ACpwStRVenK0Qtcg=;
 b=GTkh/upHHG8bdKEBmCGayJF3/XJt8aac0peJtqk0CvHYexlilehQYtfdrHB1Eo0TvH
 8cotrAArXITolgnwcFKiHRRIOgm5Arkc5cn9sMgTA4q9lcpoHvm1a3LEUO5bAbwX0cCy
 Q7H27O2JibZPDRMBLaBFOTyJSYj5QZ+0PlelzX1nkpGZa2O2ZUnaukVvb2IQ4EHAu5d7
 E1OsvQpb6mfh6QG+09Mhu/NqjRq0idXSv0H6cilZvrnhNV+yjxsXAuotgYT3+ADw9lwO
 klxL6gbH+wke8zn1yYmiNwffhinhN2jSsKQ8EMSv3eg8e7NnosqY6SwNYoBLPw5H/1Ng
 QGsA==
X-Gm-Message-State: AOJu0Yz7ZyEmKF0X4jy0WqcG9pzhgHvmV+kZwHuzYF+Be1xToJ0P6TOo
 GIzS4IxOk7Ztw76SsbAQPUoh7nmRC0H9XhplImeBdsQ7zJxBPo9edv/kMrcBmDwgIIFROm8EbMe
 FS4sXUXuSBCEXM+pzeHabI9Qjx2knDFjAaO7LPfc=
X-Received: by 2002:a2e:b0e4:0:b0:2cd:28c8:8d66 with SMTP id
 h4-20020a2eb0e4000000b002cd28c88d66mr4365654ljl.18.1705425892781; 
 Tue, 16 Jan 2024 09:24:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsTroLyjTWZdjCHsWLb/+R6rU0cwS9B+HMVwvRMKdAtH5zinsMa9h5Sz9/8kITr6F+PozYvCGqlt6AE2ioqo8=
X-Received: by 2002:a2e:b0e4:0:b0:2cd:28c8:8d66 with SMTP id
 h4-20020a2eb0e4000000b002cd28c88d66mr4365651ljl.18.1705425892503; Tue, 16 Jan
 2024 09:24:52 -0800 (PST)
MIME-Version: 1.0
References: <20240103165131.2166988-1-sam@rfc1149.net>
 <89ba5778-42c7-4228-8ec1-ff72f3e213ce@linaro.org>
In-Reply-To: <89ba5778-42c7-4228-8ec1-ff72f3e213ce@linaro.org>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Tue, 16 Jan 2024 19:24:41 +0200
Message-ID: <CAPMcbCpd26RN9HtfnYtHgcZ7GddbtNcgNPwmJCbeJnz3qY8wVQ@mail.gmail.com>
Subject: Re: [PATCH] tests/unit/test-qga: do not qualify executable paths
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Samuel Tardieu <sam@rfc1149.net>, qemu-devel@nongnu.org, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000838b6d060f13688b"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000838b6d060f13688b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Wed, Jan 3, 2024 at 7:34=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> On 3/1/24 17:51, Samuel Tardieu wrote:
> > guest-exec invocation does not need the full path of the executable to
> > execute. Using only the command names ensures correct execution of the
> > test on systems not adhering to the FHS.
> >
> > Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
> > ---
> >   tests/unit/test-qga.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
>
>

--000000000000838b6d060f13688b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a hr=
ef=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>=
&gt;</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Wed, Jan 3, 2024 at 7:34=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;=
<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">On 3/1/24 17:51, Samu=
el Tardieu wrote:<br>
&gt; guest-exec invocation does not need the full path of the executable to=
<br>
&gt; execute. Using only the command names ensures correct execution of the=
<br>
&gt; test on systems not adhering to the FHS.<br>
&gt; <br>
&gt; Signed-off-by: Samuel Tardieu &lt;<a href=3D"mailto:sam@rfc1149.net" t=
arget=3D"_blank">sam@rfc1149.net</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0tests/unit/test-qga.c | 6 +++---<br>
&gt;=C2=A0 =C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
<br>
<br>
</blockquote></div></div>

--000000000000838b6d060f13688b--



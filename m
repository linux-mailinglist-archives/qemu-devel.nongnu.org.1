Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9453B7E3AF6
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 12:18:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0K5S-0005dv-Gz; Tue, 07 Nov 2023 06:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1r0K5K-0005Vb-Gu
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:17:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1r0K5F-0006v6-ST
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699355844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hlI7k+PDq1EDJS3rGJFrP+0qAFzPftcQEHkWaVkweTw=;
 b=hM4vgQF7cGNpSmB/gen+oIInP4nA24Qd/e3Dy5FygWfBct5+PZ1s61A8XinDD0MBXatTwo
 nCt+ziFszvHnqP9FPgLbe8GX35fYtbuY25T+1A0poVSCYZKWk4BZorrIlpYEbyGS4w3F+9
 k//zZh9F8LWjEyTk6n/dPn68MWWyTnE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-lz9AIT7_NGy3WAGLLtXPWA-1; Tue, 07 Nov 2023 06:17:23 -0500
X-MC-Unique: lz9AIT7_NGy3WAGLLtXPWA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5079fd9754cso5307821e87.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 03:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699355841; x=1699960641;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hlI7k+PDq1EDJS3rGJFrP+0qAFzPftcQEHkWaVkweTw=;
 b=TCfmDo1BjoQdi0WDnBFbtHqE1YdnblsPDJFYFOOmk33uy/VicCbuydfT8pw1cT5YRh
 7VVe1IyxMFR1HiZ+KWyAH/Uz0SsNOW4M8KKSFDaQRtyFAAY915c0Jr9wqEkdPvnzVYOH
 Es7QFsQ6Ebp7hR/QIODWbtpipP8uwOJTEplYIWwE/d/f8fRRe2Bhk2N95FL8eSzr/5ii
 myODJkOuUwe+iVlXj5dAqhmvvut0kp6R/XG00U4bzTJ9mVksUZnCUrdsrHZRPra/n9vB
 FzTJNv6qqQ4xHosRgiRibBISOIPAWcNXfKXqzG5p4/U5Ft8V6hyWrWCAX0D3jvdlp6U4
 hX7A==
X-Gm-Message-State: AOJu0YyLJKO71YHC4oNqx/KEp8AdO+ykVqOprgjgTX/no7/C8QZaj4io
 FN7IuULN+E+emrUQWXdzmUi8mSIEhQaeouE/PwgYWfE+bQ9CNiAZhclZiAw3YYnntGJOEI6D5U2
 YHRKC+B+btNUREFClRIchY2pkWT5Cq9Q=
X-Received: by 2002:ac2:4c2d:0:b0:509:46fb:1fe3 with SMTP id
 u13-20020ac24c2d000000b0050946fb1fe3mr11728011lfq.42.1699355841691; 
 Tue, 07 Nov 2023 03:17:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEERKFUcIL7AKjvN+kgzEgMP5AKiOmx+EnCqNPKO1JfchnHTIp3ugJHEkEn2LJUbsv19dG68Ty3XzTuHuGQa7k=
X-Received: by 2002:ac2:4c2d:0:b0:509:46fb:1fe3 with SMTP id
 u13-20020ac24c2d000000b0050946fb1fe3mr11727999lfq.42.1699355841313; Tue, 07
 Nov 2023 03:17:21 -0800 (PST)
MIME-Version: 1.0
References: <20231107101811.14189-1-thuth@redhat.com>
In-Reply-To: <20231107101811.14189-1-thuth@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Tue, 7 Nov 2023 13:17:10 +0200
Message-ID: <CAPMcbCo3oNo6UO0zJp0=vuywX8cR5ucz3GB+XJVTJRAvK-Be+Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add more guest-agent related files to the
 corresponding section
To: Thomas Huth <thuth@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000044cfe406098e1d82"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_IMAGE_ONLY_20=1.546, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_REMOTE_IMAGE=0.01,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--00000000000044cfe406098e1d82
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Tue, Nov 7, 2023 at 12:18=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:

> contrib/systemd/qemu-guest-agent.service , tests/data/test-qga-config
> and tests/data/test-qga-os-release belong to the guest agent, so make
> sure that these files are covered here, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b7be61119f..48a6507759 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3144,10 +3144,11 @@ M: Michael Roth <michael.roth@amd.com>
>  M: Konstantin Kostiuk <kkostiuk@redhat.com>
>  S: Maintained
>  F: qga/
> +F: contrib/systemd/qemu-guest-agent.service
>  F: docs/interop/qemu-ga.rst
>  F: docs/interop/qemu-ga-ref.rst
>  F: scripts/qemu-guest-agent/
> -F: tests/unit/test-qga.c
> +F: tests/*/test-qga*
>  T: git https://github.com/mdroth/qemu.git qga
>
>  QEMU Guest Agent Win32
> --
> 2.41.0
>
>

--00000000000044cfe406098e1d82
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a hr=
ef=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>=
&gt;</div><div class=3D"gmail-yj6qo gmail-ajU"><div id=3D"gmail-:10i" class=
=3D"gmail-ajR" role=3D"button" tabindex=3D"0" aria-label=3D"Show trimmed co=
ntent" aria-expanded=3D"false"><img class=3D"gmail-ajT" src=3D"https://ssl.=
gstatic.com/ui/v1/icons/mail/images/cleardot.gif"></div></div></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 7=
, 2023 at 12:18=E2=80=AFPM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.c=
om">thuth@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">contrib/systemd/qemu-guest-agent.service , tests/data/t=
est-qga-config<br>
and tests/data/test-qga-os-release belong to the guest agent, so make<br>
sure that these files are covered here, too.<br>
<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank">thuth@redhat.com</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index b7be61119f..48a6507759 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -3144,10 +3144,11 @@ M: Michael Roth &lt;<a href=3D"mailto:michael.roth@=
amd.com" target=3D"_blank">michael.roth@amd.com</a>&gt;<br>
=C2=A0M: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com" targ=
et=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
=C2=A0S: Maintained<br>
=C2=A0F: qga/<br>
+F: contrib/systemd/qemu-guest-agent.service<br>
=C2=A0F: docs/interop/qemu-ga.rst<br>
=C2=A0F: docs/interop/qemu-ga-ref.rst<br>
=C2=A0F: scripts/qemu-guest-agent/<br>
-F: tests/unit/test-qga.c<br>
+F: tests/*/test-qga*<br>
=C2=A0T: git <a href=3D"https://github.com/mdroth/qemu.git" rel=3D"noreferr=
er" target=3D"_blank">https://github.com/mdroth/qemu.git</a> qga<br>
<br>
=C2=A0QEMU Guest Agent Win32<br>
-- <br>
2.41.0<br>
<br>
</blockquote></div>

--00000000000044cfe406098e1d82--



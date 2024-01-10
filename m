Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B32829CB7
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 15:39:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNZie-00011a-Dd; Wed, 10 Jan 2024 09:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peng.ji@smartx.com>)
 id 1rNTG8-0001Qm-CM
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 02:44:20 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peng.ji@smartx.com>)
 id 1rNTG4-0002XR-AH
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 02:44:18 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50ea9daac4cso3990935e87.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 23:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1704872532; x=1705477332;
 darn=nongnu.org; 
 h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lPFexRQiU0fkcWAZ01Bxe4+xbvNSM3v/uXvymNl6aMI=;
 b=ncedmw8kB20ryQNxq8omC0sMQIj9gbKKyoVVpG5dSiuLnjwrC/UhjtmQ68gHSnSNIH
 t8isbycXeAKLA8BnkownWHkncDifTO+VmG7KFjTx4riXurhTcx2fccqRUA29Caj/06x7
 sN3l1+I5HsU18EXgFqPcPMcXRNz3SeekW3gyAR0xB9Jk5HSqWLDIXe8D1vQUXOQaCIe7
 YLXqJSNCB+gJSDOJdeo2pF79d13XIV/tybzE/1o96MCRDjMj9OK/sO1whZEgXNWFn6Wj
 8nX5OQ6KSoD3pSS5SXF2nbohPbBW6EaZNjT+OfnTUMONE4gKYc1xzmFBF5iQ1sYnI2q2
 PJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704872532; x=1705477332;
 h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lPFexRQiU0fkcWAZ01Bxe4+xbvNSM3v/uXvymNl6aMI=;
 b=Hsp0WmMrsYaAywst+6MBzxgWJcxWLEx8OKJYiz2CiJenGWp2xafh7CzoVXd0AsasG1
 EzBV8c7BjnHsqi4FOLWJMaJe0M3tleRMfAz2ejzcIJj/LDPqTbzcYyVvldanvFp3a7Ul
 NIuARQISWp2Ofuzv8ytM7+8+FmO5cMDEbyM1lLI5mP9Z3H3/Ri/mgmWMIdgpsIig4txR
 vDf91M0XUEf3aACPVqadvXHYxAzVTb+GChZCC3LNiKpmmPH49+U9qKtwAjPpr+mfYBv6
 gVTWr4DTAkXnhTv8K7gdCg9tD+caYu0s71tKsOnGsohlBLnR+1W320wFgVtlTcqF2wED
 bU6A==
X-Gm-Message-State: AOJu0YxW3e+/mRsqT5mJPT5ASymaDXYzIdWj+NMUSzSVDWJauOi6jtuy
 u73llqbHxmSwHLg5yxa8qD1TsmOWN8gBjMjY+2CNGc2eIgWven4b2g99y99+CKDD7NUU
X-Received: by 2002:a05:6512:684:b0:50e:3e13:e142 with SMTP id
 t4-20020a056512068400b0050e3e13e142mt166315lfe.118.1704872531638; Tue, 09 Jan
 2024 23:42:11 -0800 (PST)
MIME-Version: 1.0
References: <20231227071540.4035803-1-peng.ji@smartx.com>
 <5492018d-8b72-4aea-b33c-bb9f4f6b4f48@linaro.org>
In-Reply-To: <5492018d-8b72-4aea-b33c-bb9f4f6b4f48@linaro.org>
From: Peng Ji <peng.ji@smartx.com>
Date: Wed, 10 Jan 2024 15:42:00 +0800
Message-ID: <CACbqNXcjB7p=xpYPPY01dJ2W97h608SGCr4-_xDtQovBOodACw@mail.gmail.com>
Subject: Re: [PATCH] qga-win: Fix guest-get-fsinfo multi-disks collection
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a3b2d9060e92916c"
Received-SPF: none client-ip=2a00:1450:4864:20::12b;
 envelope-from=peng.ji@smartx.com; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, MISSING_HEADERS=1.021,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 10 Jan 2024 09:37:56 -0500
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

--000000000000a3b2d9060e92916c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping !
please review this patch :
https://patchew.org/QEMU/20231227071540.4035803-1-peng.ji@smartx.com/

thanks



On Fri, Jan 5, 2024 at 9:47=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> On 27/12/23 08:15, peng.ji@smartx.com wrote:
> > From: Peng Ji <peng.ji@smartx.com>
> >
> > When a volume has more than one disk, all disks cannot be
> > returned correctly because there is not enough malloced memory
> > for disk extents, so before executing DeviceIoControl for the
> > second time, get the correct size of the required memory space
> > to store all disk extents.
> >
> > Signed-off-by: Peng Ji <peng.ji@smartx.com>
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2075
>
> > ---
> >   qga/commands-win32.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index 697c65507c..a1015757d8 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> > @@ -935,6 +935,8 @@ static GuestDiskAddressList
> *build_guest_disk_info(char *guid, Error **errp)
> >           DWORD last_err =3D GetLastError();
> >           if (last_err =3D=3D ERROR_MORE_DATA) {
> >               /* Try once more with big enough buffer */
> > +            size =3D sizeof(VOLUME_DISK_EXTENTS) +
> > +               (sizeof(DISK_EXTENT) * (extents->NumberOfDiskExtents -
> 1));
> >               g_free(extents);
> >               extents =3D g_malloc0(size);
> >               if (!DeviceIoControl(
>
>

--000000000000a3b2d9060e92916c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><pre id=3D"gmail-b" style=3D"font-size:13px;background-ima=
ge:initial;background-position:initial;background-size:initial;background-r=
epeat:initial;background-origin:initial;background-clip:initial;color:rgb(0=
,0,51)">ping !
please review this patch : <a href=3D"https://patchew.org/QEMU/202312270715=
40.4035803-1-peng.ji@smartx.com/">https://patchew.org/QEMU/20231227071540.4=
035803-1-peng.ji@smartx.com/</a></pre><pre id=3D"gmail-b" style=3D"font-siz=
e:13px;background-image:initial;background-position:initial;background-size=
:initial;background-repeat:initial;background-origin:initial;background-cli=
p:initial;color:rgb(0,0,51)">thanks<br></pre></div><div dir=3D"ltr"><br></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Fri, Jan 5, 2024 at 9:47=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 27/12/2=
3 08:15, <a href=3D"mailto:peng.ji@smartx.com" target=3D"_blank">peng.ji@sm=
artx.com</a> wrote:<br>
&gt; From: Peng Ji &lt;<a href=3D"mailto:peng.ji@smartx.com" target=3D"_bla=
nk">peng.ji@smartx.com</a>&gt;<br>
&gt; <br>
&gt; When a volume has more than one disk, all disks cannot be<br>
&gt; returned correctly because there is not enough malloced memory<br>
&gt; for disk extents, so before executing DeviceIoControl for the<br>
&gt; second time, get the correct size of the required memory space<br>
&gt; to store all disk extents.<br>
&gt; <br>
&gt; Signed-off-by: Peng Ji &lt;<a href=3D"mailto:peng.ji@smartx.com" targe=
t=3D"_blank">peng.ji@smartx.com</a>&gt;<br>
<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2075" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/2075</a><br>
<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0qga/commands-win32.c | 2 ++<br>
&gt;=C2=A0 =C2=A01 file changed, 2 insertions(+)<br>
&gt; <br>
&gt; diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
&gt; index 697c65507c..a1015757d8 100644<br>
&gt; --- a/qga/commands-win32.c<br>
&gt; +++ b/qga/commands-win32.c<br>
&gt; @@ -935,6 +935,8 @@ static GuestDiskAddressList *build_guest_disk_info=
(char *guid, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DWORD last_err =3D GetLastErro=
r();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (last_err =3D=3D ERROR_MORE=
_DATA) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Try once more=
 with big enough buffer */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D sizeof(VOLUME_DISK=
_EXTENTS) +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(sizeof(DISK_E=
XTENT) * (extents-&gt;NumberOfDiskExtents - 1));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(extents);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0extents =3D g_ma=
lloc0(size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!DeviceIoCon=
trol(<br>
<br>
</blockquote></div>

--000000000000a3b2d9060e92916c--


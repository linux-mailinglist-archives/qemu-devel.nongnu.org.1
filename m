Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C350B82F322
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 18:25:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPnB6-0007Bm-7D; Tue, 16 Jan 2024 12:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rPnB4-0007Bd-Jy
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 12:24:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rPnB2-0004vZ-S5
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 12:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705425879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UFTOAtk6nVTZd/lNKdd46mgMTN9oS8Ln9bSuX/IZg+Y=;
 b=JfkTLOtAnSBGRk92nz5cofglZlIhkSuof1TuCABEf0oTyKIdOXctB9HscQ7F0I4sFubM5/
 i8+4U6r48azouK+GytFkxeckMMVDmAWFGT0PqmjLAMqMGXj5oy+Wk7YMjhbfdle/gtUDLU
 5uAuAjPU7c101XSee7qeX/p0u4ve8TI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-5xk4iurPPSug-mX_4tDVvg-1; Tue, 16 Jan 2024 12:24:37 -0500
X-MC-Unique: 5xk4iurPPSug-mX_4tDVvg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2cccd597158so89987241fa.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 09:24:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705425876; x=1706030676;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UFTOAtk6nVTZd/lNKdd46mgMTN9oS8Ln9bSuX/IZg+Y=;
 b=amaL3FskiT20Q6jQrXW0sROU80gXphTL24i7c6MzGlh8+IjL5qvKjK1RavQ/BKeK1n
 xD82X+2Tn1YAX5twFWfMJBcue1HuOQyHXipkGDslzInSikoQ01l+Bzl8OsdO+ER1zp+a
 r7Z07hwSI/XTLR9v46E8pv2Zs47JEOZbO27ZOrCa1wwCFk44fIrU7szc9CWmdemjn/Cm
 wR5wJ92kpWw9+KaLJ8GxcedSgfVZDSDRyLzp5xj3TTnbbGnxvy6A0oLS+CzVYXpGrcgE
 BN/f4KUZqtmO2ZrUAOs9We8oQiKn7v5Z9/KIn4WYZCL+1c3o0bBdOPBHm8D9csZDtBv6
 vEsA==
X-Gm-Message-State: AOJu0YxRYBYZSW42VREcS5ZVGTxZWkrltgMESHEVI62PqfWmeyhkgMwj
 FrqU6OPGIKYef/qTZP27JZM2d2IZUzDuFjvGxbu7LOPJcboOIRHKlaGOuUCJeD/puwufIQTNxKq
 RP0sPtFn6M+INoKOFMUzV8b4BI3OhKkr/uBmd4mOL7md+Aw7LEw==
X-Received: by 2002:a2e:9e83:0:b0:2cd:8a63:ac95 with SMTP id
 f3-20020a2e9e83000000b002cd8a63ac95mr3531545ljk.73.1705425875919; 
 Tue, 16 Jan 2024 09:24:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTmjQEX4J+j2EOyz3+aqSM42v0i6BDhGhRN7nOrQCQWAGaFHNDlAo0JPjdZip320jOmyngtZW/RoeDdr668ek=
X-Received: by 2002:a2e:9e83:0:b0:2cd:8a63:ac95 with SMTP id
 f3-20020a2e9e83000000b002cd8a63ac95mr3531535ljk.73.1705425875493; Tue, 16 Jan
 2024 09:24:35 -0800 (PST)
MIME-Version: 1.0
References: <20231227071540.4035803-1-peng.ji@smartx.com>
 <5492018d-8b72-4aea-b33c-bb9f4f6b4f48@linaro.org>
 <CACbqNXcjB7p=xpYPPY01dJ2W97h608SGCr4-_xDtQovBOodACw@mail.gmail.com>
In-Reply-To: <CACbqNXcjB7p=xpYPPY01dJ2W97h608SGCr4-_xDtQovBOodACw@mail.gmail.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Tue, 16 Jan 2024 19:24:24 +0200
Message-ID: <CAPMcbCqYqRwCjuSXeUE+PCPfssAtZ2bjnTWq1iDzEug=Lvpvqg@mail.gmail.com>
Subject: Re: [PATCH] qga-win: Fix guest-get-fsinfo multi-disks collection
To: Peng Ji <peng.ji@smartx.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Michael Roth <michael.roth@amd.com>, 
 Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007ff2d3060f136795"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

--0000000000007ff2d3060f136795
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Wed, Jan 10, 2024 at 9:42=E2=80=AFAM Peng Ji <peng.ji@smartx.com> wrote:

> ping !
> please review this patch : https://patchew.org/QEMU/20231227071540.403580=
3-1-peng.ji@smartx.com/
>
> thanks
>
>
>
> On Fri, Jan 5, 2024 at 9:47=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org>
> wrote:
>
>> On 27/12/23 08:15, peng.ji@smartx.com wrote:
>> > From: Peng Ji <peng.ji@smartx.com>
>> >
>> > When a volume has more than one disk, all disks cannot be
>> > returned correctly because there is not enough malloced memory
>> > for disk extents, so before executing DeviceIoControl for the
>> > second time, get the correct size of the required memory space
>> > to store all disk extents.
>> >
>> > Signed-off-by: Peng Ji <peng.ji@smartx.com>
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2075
>>
>> > ---
>> >   qga/commands-win32.c | 2 ++
>> >   1 file changed, 2 insertions(+)
>> >
>> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>> > index 697c65507c..a1015757d8 100644
>> > --- a/qga/commands-win32.c
>> > +++ b/qga/commands-win32.c
>> > @@ -935,6 +935,8 @@ static GuestDiskAddressList
>> *build_guest_disk_info(char *guid, Error **errp)
>> >           DWORD last_err =3D GetLastError();
>> >           if (last_err =3D=3D ERROR_MORE_DATA) {
>> >               /* Try once more with big enough buffer */
>> > +            size =3D sizeof(VOLUME_DISK_EXTENTS) +
>> > +               (sizeof(DISK_EXTENT) * (extents->NumberOfDiskExtents -
>> 1));
>> >               g_free(extents);
>> >               extents =3D g_malloc0(size);
>> >               if (!DeviceIoControl(
>>
>>

--0000000000007ff2d3060f136795
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 1=
0, 2024 at 9:42=E2=80=AFAM Peng Ji &lt;<a href=3D"mailto:peng.ji@smartx.com=
">peng.ji@smartx.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><div dir=3D"ltr"><pre id=3D"m_593194527299737631gmail-b=
" style=3D"font-size:13px;background-image:initial;background-position:init=
ial;background-size:initial;background-repeat:initial;background-origin:ini=
tial;background-clip:initial;color:rgb(0,0,51)">ping !
please review this patch : <a href=3D"https://patchew.org/QEMU/202312270715=
40.4035803-1-peng.ji@smartx.com/" target=3D"_blank">https://patchew.org/QEM=
U/20231227071540.4035803-1-peng.ji@smartx.com/</a></pre><pre id=3D"m_593194=
527299737631gmail-b" style=3D"font-size:13px;background-image:initial;backg=
round-position:initial;background-size:initial;background-repeat:initial;ba=
ckground-origin:initial;background-clip:initial;color:rgb(0,0,51)">thanks<b=
r></pre></div><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 5, 2024 at 9:47=E2=80=AFPM P=
hilippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org" target=
=3D"_blank">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On 27/12/23 08:15, <a href=3D"mailto:peng.ji@s=
martx.com" target=3D"_blank">peng.ji@smartx.com</a> wrote:<br>
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
</blockquote></div>

--0000000000007ff2d3060f136795--



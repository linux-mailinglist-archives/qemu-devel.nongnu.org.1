Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 608EB80132A
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 19:53:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r98cb-00019Q-NG; Fri, 01 Dec 2023 13:52:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1r98cZ-00019A-Hd
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 13:52:15 -0500
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1r98cX-0004cy-Cz
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 13:52:15 -0500
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-423f28ae2d0so23211cf.1
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 10:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1701456731; x=1702061531; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8+fPOikW23LwNbtlZadfahlmeJrB2uWP6vzyrKdgg/U=;
 b=fCj3SjzQUGTZO0kQIVjD/VeWf5Ss0q6ajML4cCH/E8VW/GPiR30wek4QEwRAdl7sF0
 twxYtNvFhEVch+RrA2S/TvAum2vJmEnEtw0Tiu9j8fcV0ee12ptaFb01acu4wuvEHej+
 Kb0z/BFeUV810vjPCggGWrWEHwoYgq8+XJ3WMbirLbIceCOvU42g+EhWrFpx2CKEIoMj
 F1em5uTzLG64LhKAHz/PdxXZQe8RahIkSGWI20Sr1m/anz8JWt1SLsee2SkNgcmy2DgC
 S7xv8XJEsj2visZCFg+qNXI+RoCx6mWu1jbybbMn0cuk8KoSrjGl2CmRbLWzqexeT9A2
 tmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701456731; x=1702061531;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8+fPOikW23LwNbtlZadfahlmeJrB2uWP6vzyrKdgg/U=;
 b=lZWqchN1KGAdRPgL2C3LUJUQHu9fDqx31fuKzgaVIn2CJLMq1iYO6OYy0ZOsQb4uPR
 xYSwZEY69eQuNaJmn/czfivAtp90mE8dLeehrBo5G3V+hOaQ6tIjfUf/HZMLX9Ui716c
 karr7H0O3MQhbLb96t31zou2t4gRB3luMMKiFYH8lmf6iDcMQ98rxgssZNV0HE8PJzWG
 VRv8hqMVZWV0cRF1iP+60Ch3+4KRr0hDYcaClR0HcnHe1gdV05ePiud8wET0zvwmYHy5
 QL8MISfJEs1Nfn2tgO0RGRwQK1K4NJTpgPompnQfJpOJVSlePU2wp87zTIuM0B3KtLfo
 HC/g==
X-Gm-Message-State: AOJu0Yzixbbqlfe5IHHKMId34ASKgAQBJ3U4lW1QK047WkXMJ1O7aOdB
 TPLZIcq3JjBDLh0mzFiDwrJ97IIXjE2zHJPl8lWemg==
X-Google-Smtp-Source: AGHT+IHWe82jI/3yo/kcxSAtMHpf/YMYsg/CWwQUObTvkhNL3AeSLsZvrIqYtcGL+VbaXMQ2iALxCAPUF+SaMJ91H+A=
X-Received: by 2002:a05:622a:15c4:b0:41c:e312:cbd2 with SMTP id
 d4-20020a05622a15c400b0041ce312cbd2mr206010qty.29.1701456731351; Fri, 01 Dec
 2023 10:52:11 -0800 (PST)
MIME-Version: 1.0
References: <20231201032140.2470599-1-scw@google.com>
 <20231201032140.2470599-3-scw@google.com>
 <63d6f19a-ec9b-4397-bf90-95e89a618838@linaro.org>
In-Reply-To: <63d6f19a-ec9b-4397-bf90-95e89a618838@linaro.org>
From: Shu-Chun Weng <scw@google.com>
Date: Fri, 1 Dec 2023 10:51:57 -0800
Message-ID: <CAF3nBxjGBtGnKr3m9soohGDPB9z+C7SkJt00FQOucYQNQUqCxw@mail.gmail.com>
Subject: Re: [PATCH 2/2] linux-user: Fix openat() emulation to not modify atime
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>, Jonah Petri <jonah@petri.us>, 
 Edoardo Spadolini <edoardo.spadolini@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000001c2442060b77448d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=scw@google.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--0000000000001c2442060b77448d
Content-Type: multipart/alternative; boundary="000000000000131621060b7744ec"

--000000000000131621060b7744ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 4:42=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> Hi Shu-Chun,
>
> On 1/12/23 04:21, Shu-Chun Weng wrote:
> > Commit b8002058 strengthened openat()'s /proc detection by calling
> > realpath(3) on the given path, which allows various paths and symlinks
> > that points to the /proc file system to be intercepted correctly.
> >
> > Using realpath(3), though, has a side effect that it reads the symlinks
> > along the way, and thus changes their atime. The results in the
> > following code snippet already get ~now instead of the real atime:
> >
> >    int fd =3D open("/path/to/a/symlink", O_PATH | O_NOFOLLOW);
> >    struct stat st;
> >    fstat(fd, st);
> >    return st.st_atime;
> >
> > This change opens a path that doesn't appear to be part of /proc
> > directly and checks the destination of /proc/self/fd/n to determine if
> > it actually refers to a file in /proc.
> >
> > Neither this nor the existing code works with symlinks or indirect path=
s
> > (e.g.  /tmp/../proc/self/exe) that points to /proc/self/exe because it
> > is itself a symlink, and both realpath(3) and /proc/self/fd/n will
> > resolve into the location of QEMU.
>
> Does this fix any of the following issues?
> https://gitlab.com/qemu-project/qemu/-/issues/829


Not this one -- this is purely in the logic of util/path.c, which we do see
and carry an internal patch. It's quite a behavior change so we never
upstreamed it.


> https://gitlab.com/qemu-project/qemu/-/issues/927


No, either. This patch only touches the path handling, not how files are
opened.

https://gitlab.com/qemu-project/qemu/-/issues/2004


Yes! Though I don't have a toolchain for HPPA or any of the architectures
intercepting /proc/cpuinfo handy, I hacked the condition and confirmed that
on 7.1 and 8.2, test.c as attached in the bug prints out the host cpuinfo
while with this patch, it prints out the content generated by
`open_cpuinfo()`.


>
>
> > Signed-off-by: Shu-Chun Weng <scw@google.com>
>

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2004

> ---
> >   linux-user/syscall.c | 42 +++++++++++++++++++++++++++++++++---------
> >   1 file changed, 33 insertions(+), 9 deletions(-)
>
>
On Fri, Dec 1, 2023 at 9:09=E2=80=AFAM Helge Deller <deller@gmx.de> wrote:

> On 12/1/23 04:21, Shu-Chun Weng wrote:
> > Commit b8002058 strengthened openat()'s /proc detection by calling
> > realpath(3) on the given path, which allows various paths and symlinks
> > that points to the /proc file system to be intercepted correctly.
> >
> > Using realpath(3), though, has a side effect that it reads the symlinks
> > along the way, and thus changes their atime.
>
> Ah, ok. I didn't thought of that side effect when I came up with the patc=
h.
> Does the updated atimes trigger some real case issue ?
>

We have an internal library shimming the underlying filesystem that uses
the `open(O_PATH|O_NOFOLLOW)`+`fstat()` pattern for all file stats.
Checking symlink atime is in one of the unittests, though I don't know if
production ever uses it.


>
> Helge
>

--000000000000131621060b7744ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Fri, Dec 1, 2023 at 4:42=E2=80=AFAM Philippe Mathieu-Da=
ud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt;=
 wrote:<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi Shu-Chun,<br>
<br>
On 1/12/23 04:21, Shu-Chun Weng wrote:<br>
&gt; Commit b8002058 strengthened openat()&#39;s /proc detection by calling=
<br>
&gt; realpath(3) on the given path, which allows various paths and symlinks=
<br>
&gt; that points to the /proc file system to be intercepted correctly.<br>
&gt; <br>
&gt; Using realpath(3), though, has a side effect that it reads the symlink=
s<br>
&gt; along the way, and thus changes their atime. The results in the<br>
&gt; following code snippet already get ~now instead of the real atime:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 int fd =3D open(&quot;/path/to/a/symlink&quot;, O_PATH | =
O_NOFOLLOW);<br>
&gt;=C2=A0 =C2=A0 struct stat st;<br>
&gt;=C2=A0 =C2=A0 fstat(fd, st);<br>
&gt;=C2=A0 =C2=A0 return st.st_atime;<br>
&gt; <br>
&gt; This change opens a path that doesn&#39;t appear to be part of /proc<b=
r>
&gt; directly and checks the destination of /proc/self/fd/n to determine if=
<br>
&gt; it actually refers to a file in /proc.<br>
&gt; <br>
&gt; Neither this nor the existing code works with symlinks or indirect pat=
hs<br>
&gt; (e.g.=C2=A0 /tmp/../proc/self/exe) that points to /proc/self/exe becau=
se it<br>
&gt; is itself a symlink, and both realpath(3) and /proc/self/fd/n will<br>
&gt; resolve into the location of QEMU.<br>
<br>
Does this fix any of the following issues?<br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/829" rel=3D"norefe=
rrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/issues/829</=
a></blockquote><div><br></div><div>Not this one -- this is purely in the lo=
gic of util/path.c, which we do see and carry an internal patch. It&#39;s q=
uite a behavior change so we never upstreamed it.<br></div><div>=C2=A0<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/927" rel=3D"norefe=
rrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/issues/927</=
a></blockquote><div><br></div><div>No, either. This patch only touches the =
path handling, not how files are opened.<br></div><div><br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2004" rel=3D"noref=
errer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/issues/2004=
</a></blockquote><div><br></div><div>Yes! Though I don&#39;t have a toolcha=
in for HPPA or any of the architectures intercepting /proc/cpuinfo handy, I=
 hacked the condition and confirmed that on 7.1 and 8.2, test.c as attached=
 in the bug prints out the host cpuinfo while with this patch, it prints ou=
t the content generated by `open_cpuinfo()`.</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><br>
<br>
&gt; Signed-off-by: Shu-Chun Weng &lt;<a href=3D"mailto:scw@google.com" tar=
get=3D"_blank">scw@google.com</a>&gt;<br></blockquote><div><br></div><div>R=
esolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2004">htt=
ps://gitlab.com/qemu-project/qemu/-/issues/2004</a></div><div><br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
&gt; ---<br>
&gt;=C2=A0 =C2=A0linux-user/syscall.c | 42 ++++++++++++++++++++++++++++++++=
+---------<br>
&gt;=C2=A0 =C2=A01 file changed, 33 insertions(+), 9 deletions(-)<br>
<br></blockquote><div><br></div><div><div dir=3D"ltr" class=3D"gmail_attr">=
On Fri, Dec 1, 2023 at 9:09=E2=80=AFAM Helge Deller &lt;<a href=3D"mailto:d=
eller@gmx.de">deller@gmx.de</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">On 12/1/23 04:21, Shu-Chun Weng wrote:<br>
&gt; Commit b8002058 strengthened openat()&#39;s /proc detection by calling=
<br>
&gt; realpath(3) on the given path, which allows various paths and symlinks=
<br>
&gt; that points to the /proc file system to be intercepted correctly.<br>
&gt;<br>
&gt; Using realpath(3), though, has a side effect that it reads the symlink=
s<br>
&gt; along the way, and thus changes their atime.<br>
<br>
Ah, ok. I didn&#39;t thought of that side effect when I came up with the pa=
tch.<br>
Does the updated atimes trigger some real case issue ?<br></blockquote><div=
><br></div><div>We have an internal library shimming the underlying filesys=
tem that uses the `open(O_PATH|O_NOFOLLOW)`+`fstat()` pattern for all file =
stats. Checking symlink atime is in one of the unittests, though I don&#39;=
t know if production ever uses it.<br></div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
Helge<br>
</blockquote>=C2=A0</div></div></div>

--000000000000131621060b7744ec--

--0000000000001c2442060b77448d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPoAYJKoZIhvcNAQcCoIIPkTCCD40CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz6MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
ntFX6HMwVwYDVR0gBFAwTjAJBgdngQwBBQEBMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAMBgNVHRMBAf8EAjAAMIGaBggr
BgEFBQcBAQSBjTCBijA+BggrBgEFBQcwAYYyaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vY2Ev
Z3NhdGxhc3Izc21pbWVjYTIwMjAwSAYIKwYBBQUHMAKGPGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2ln
bi5jb20vY2FjZXJ0L2dzYXRsYXNyM3NtaW1lY2EyMDIwLmNydDAfBgNVHSMEGDAWgBR8zApo16Lr
HixyG9HNXZVvjfvyYzBGBgNVHR8EPzA9MDugOaA3hjVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29t
L2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwLmNybDANBgkqhkiG9w0BAQsFAAOCAQEATNQsRyrYexxI
brRqQbycsBDuR8bKRXtZnWRKoKbLkP5WUoyTziRQxX87y7t5+HulkvcHv+iN4NXsE34NBcNJhtGs
D4jXPDYBUkCheUTRNezlU3uo9XegMj7CpgPAjve1C5bX0003iXWpE+61UbPqCJc8Ko/i3BP6qUNJ
rt0xX6FSMibe3h3vhJzRuHp0SHtU4XuQDeyeMPo2dS15ZbRgi62k+I4BIw1XPnzpFDB+Vqqg4ezU
9lycvOtLk6T5oBrG1F+SDG8tm5M9e3XxEGez5FPSgkLTfQOCcDMzYQfmWL2NgB3FV/4REZLeoHd1
mbTKETYl94c2zp85DnzksvjWADGCAmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoT
EEdsb2JhbFNpZ24gbnYtc2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0Eg
MjAyMAIQAT8LWTW8LldwYsDkJlcz3zANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg
N7NMEz0/AyH1d7QKwAqHIvCztoOODbbhfoWwbdCWyzwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjMxMjAxMTg1MjExWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjAL
BgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBALzdkRkwtJbwu6XQLz5x
X9kUXkRdzyCF3O+6XmMBL/XFIZEkeGxM5bvvgAlaOEocQJC0XOk1rr92koQHEYAR6EVzus0XJWQf
gohrQZXF5rOuSI80D8vSLMz5Qe9BIS/X8eoqOruxTPsHNyvRYN13ECy6N04KgskUklpd8FRx1bv8
BctX8uaFmKDE7sQ4uv6z6okDrQU5snXo5yE8yJ4r2Z9kRhkfmmHmAU8bpFcXZizaHAzcCdkvnIt+
0oEi2De3XpF1c83+ccLGgZIQM8ORnE8RtMmlZ6EqmzgLdOorrbcTjkuswiPStnEH5NuYqDNgPGN+
4E5SWqM3KjjN0zQwmO8=
--0000000000001c2442060b77448d--


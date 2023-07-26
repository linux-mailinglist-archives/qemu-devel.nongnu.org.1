Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E66762A58
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 06:38:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOWH9-0002EN-Fr; Wed, 26 Jul 2023 00:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinglimin@cmss.chinamobile.com>)
 id 1qOWH5-0002Du-U6
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 00:37:23 -0400
Received: from cmccmta6.chinamobile.com ([111.22.67.139]
 helo=cmccmta2.chinamobile.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinglimin@cmss.chinamobile.com>) id 1qOWH2-0001ad-FT
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 00:37:23 -0400
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee564c0a2ed39b-1e486;
 Wed, 26 Jul 2023 12:37:12 +0800 (CST)
X-RM-TRANSID: 2ee564c0a2ed39b-1e486
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [IPv6:::ffff:172.20.211.33] (unknown[223.108.79.99])
 by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee564c0a2f760a-62850;
 Wed, 26 Jul 2023 12:37:12 +0800 (CST)
X-RM-TRANSID: 2ee564c0a2f760a-62850
MIME-Version: 1.0
To: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Cc: "richard.henderson@linaro.org" <richard.henderson@linaro.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: <dinglimin@cmss.chinamobile.com>
Subject: =?utf-8?Q?=E5=9B=9E=E5=A4=8D:_[PATCH]_semihosting/uaccess.c:_Replaced_a_m?=
 =?utf-8?Q?alloc_call_with_g=5Fmalloc.?=
Date: Wed, 26 Jul 2023 12:37:10 +0800
Importance: normal
X-Priority: 3
In-Reply-To: <CAFEAcA-ErMrk60uZMu8M-0G15aTvhOZsYsvJD1F-YbLGOFDBYA@mail.gmail.com>
References: <20230725080630.1083-1-dinglimin@cmss.chinamobile.com>
 <20230725090039.1271-1-dinglimin@cmss.chinamobile.com>
 <106cf02f-f746-e216-22be-8f7594028695@tls.msk.ru>
 <CAFEAcA-ErMrk60uZMu8M-0G15aTvhOZsYsvJD1F-YbLGOFDBYA@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="_3DD5A187-4286-4919-9294-C9508DF89758_"
Received-SPF: pass client-ip=111.22.67.139;
 envelope-from=dinglimin@cmss.chinamobile.com; helo=cmccmta2.chinamobile.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DOS_BODY_HIGH_NO_MID=0.001,
 HTML_MESSAGE=0.001, MISSING_MID=0.497, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
Message-Id: <E1qOWH5-0002Du-U6@lists.gnu.org>
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

--_3DD5A187-4286-4919-9294-C9508DF89758_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

>On Tue, 25 Jul 2023 at 10:13, Michael Tokarev <mjt@tls.msk.ru> wrote:
> >
> > 25.07.2023 12:00, dinglimin wrote:
> > > Replaced a call to malloc() and its respective call to free() with g_=
malloc() and g_free().
> > >
> > > Signed-off-by: dinglimin <dinglimin@cmss.chinamobile.com>
> > >
> > > V1 -> V2:if cpu_memory_rw_debug failed, still need to set p=3DNULL
> > > ---
> > >   semihosting/uaccess.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
> > > index 8018828069..2ac754cdb6 100644
> > > --- a/semihosting/uaccess.c
> > > +++ b/semihosting/uaccess.c
> > > @@ -14,10 +14,10 @@
> > >   void *softmmu_lock_user(CPUArchState *env, target_ulong addr,
> > >                           target_ulong len, bool copy)
> > >   {
> > > -    void *p =3D malloc(len);
> > > +    void *p =3D g_malloc(len);
> > >       if (p && copy) {
> > >           if (cpu_memory_rw_debug(env_cpu(env), addr, p, len, 0)) {
> > > -            free(p);
> > > +            g_free(p);
> > >               p =3D NULL;
> > >           }
>> >       }
> >
>> Ok, that was the obvious part.  Now a next one, also obvious.
> >
> > You changed lock_user to use g_malloc(), but unlock_user
> > still uses free() instead of g_free().  At the very least
> > the other one needs to be changed too.  And I'd say the callers
> > should be analyzed to ensure they don't free() the result
> (they should not, think it is a bug if they do).
>
> We can be pretty sure the callers don't free() the returned
> value, because the calling code is also used in user-mode,
> where the lock/unlock implementation is entirely different
> and calling free() on the pointer will not work.
>=20
> > lock_user/unlock_user (which #defines to softmmu_lock_user/
> > softmmu_unlock_user in softmmu mode) is used a *lot*.
>=20
> The third part here, is that g_malloc() does not ever
> fail -- it will abort() on out of memory. However
> the code here is still handling g_malloc() returning NULL.
> The equivalent for "we expect this might fail" (which we want
> here, because the guest is passing us the length of memory
> to try to allocate) is g_try_malloc().
>=20
> thanks
> -- PMM
g_malloc() is preferred more than g_try_* functions, which return NULL on e=
rror,
 when the size of the requested allocation  is small.=20
This is because allocating few bytes should not be a problem in a healthy s=
ystem.=20
Otherwise, the system is already in a critical state.

Plan to delete null checks after g malloc().


=E5=8F=91=E4=BB=B6=E4=BA=BA: Peter Maydell
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B47=E6=9C=8825=E6=97=A5 17=
:35
=E6=94=B6=E4=BB=B6=E4=BA=BA: Michael Tokarev
=E6=8A=84=E9=80=81: dinglimin; richard.henderson@linaro.org; qemu-devel@non=
gnu.org
=E4=B8=BB=E9=A2=98: Re: [PATCH] semihosting/uaccess.c: Replaced a malloc ca=
ll with g_malloc.

On Tue, 25 Jul 2023 at 10:13, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 25.07.2023 12:00, dinglimin wrote:
> > Replaced a call to malloc() and its respective call to free() with g_ma=
lloc() and g_free().
> >
> > Signed-off-by: dinglimin <dinglimin@cmss.chinamobile.com>
> >
> > V1 -> V2:if cpu_memory_rw_debug failed, still need to set p=3DNULL
> > ---
> >   semihosting/uaccess.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
> > index 8018828069..2ac754cdb6 100644
> > --- a/semihosting/uaccess.c
> > +++ b/semihosting/uaccess.c
> > @@ -14,10 +14,10 @@
> >   void *softmmu_lock_user(CPUArchState *env, target_ulong addr,
> >                           target_ulong len, bool copy)
> >   {
> > -    void *p =3D malloc(len);
> > +    void *p =3D g_malloc(len);
> >       if (p && copy) {
> >           if (cpu_memory_rw_debug(env_cpu(env), addr, p, len, 0)) {
> > -            free(p);
> > +            g_free(p);
> >               p =3D NULL;
> >           }
> >       }
>
> Ok, that was the obvious part.  Now a next one, also obvious.
>
> You changed lock_user to use g_malloc(), but unlock_user
> still uses free() instead of g_free().  At the very least
> the other one needs to be changed too.  And I'd say the callers
> should be analyzed to ensure they don't free() the result
> (they should not, think it is a bug if they do).

We can be pretty sure the callers don't free() the returned
value, because the calling code is also used in user-mode,
where the lock/unlock implementation is entirely different
and calling free() on the pointer will not work.

> lock_user/unlock_user (which #defines to softmmu_lock_user/
> softmmu_unlock_user in softmmu mode) is used a *lot*.

The third part here, is that g_malloc() does not ever
fail -- it will abort() on out of memory. However
the code here is still handling g_malloc() returning NULL.
The equivalent for "we expect this might fail" (which we want
here, because the guest is passing us the length of memory
to try to allocate) is g_try_malloc().

thanks
-- PMM


--_3DD5A187-4286-4919-9294-C9508DF89758_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta ht=
tp-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8"><meta name=
=3DGenerator content=3D"Microsoft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:DengXian;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style></head><body lang=3DZH-CN link=3Dblue vlink=3D"#954F72"><div cla=
ss=3DWordSection1><p class=3DMsoNormal><span lang=3DEN-US>&gt;On Tue, 25 Ju=
l 2023 at 10:13, Michael Tokarev &lt;mjt@tls.msk.ru&gt; wrote:</span></p><p=
 class=3DMsoNormal><span lang=3DEN-US>&gt; &gt;</span></p><p class=3DMsoNor=
mal><span lang=3DEN-US>&gt; &gt; 25.07.2023 12:00, dinglimin wrote:</span><=
/p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt; &gt; Replaced a call t=
o malloc() and its respective call to free() with g_malloc() and g_free().<=
/span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt; &gt;</span></p>=
<p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt; &gt; Signed-off-by: dingl=
imin &lt;dinglimin@cmss.chinamobile.com&gt;</span></p><p class=3DMsoNormal>=
<span lang=3DEN-US>&gt; &gt; &gt;</span></p><p class=3DMsoNormal><span lang=
=3DEN-US>&gt; &gt; &gt; V1 -&gt; V2:if cpu_memory_rw_debug failed, still ne=
ed to set p=3DNULL</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &=
gt; &gt; ---</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt; &g=
t;=C2=A0=C2=A0 semihosting/uaccess.c | 4 ++--</span></p><p class=3DMsoNorma=
l><span lang=3DEN-US>&gt; &gt; &gt;=C2=A0=C2=A0 1 file changed, 2 insertion=
s(+), 2 deletions(-)</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt;=
 &gt; &gt;</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt; &gt;=
 diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c</span></p><p cl=
ass=3DMsoNormal><span lang=3DEN-US>&gt; &gt; &gt; index 8018828069..2ac754c=
db6 100644</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt; &gt;=
 --- a/semihosting/uaccess.c</span></p><p class=3DMsoNormal><span lang=3DEN=
-US>&gt; &gt; &gt; +++ b/semihosting/uaccess.c</span></p><p class=3DMsoNorm=
al><span lang=3DEN-US>&gt; &gt; &gt; @@ -14,10 +14,10 @@</span></p><p class=
=3DMsoNormal><span lang=3DEN-US>&gt; &gt; &gt;=C2=A0=C2=A0 void *softmmu_lo=
ck_user(CPUArchState *env, target_ulong addr,</span></p><p class=3DMsoNorma=
l><span lang=3DEN-US>&gt; &gt; &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong len, bool copy)</sp=
an></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt; &gt;=C2=A0=C2=A0 {=
</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt; &gt; -=C2=A0=
=C2=A0=C2=A0 void *p =3D malloc(len);</span></p><p class=3DMsoNormal><span =
lang=3DEN-US>&gt; &gt; &gt; +=C2=A0=C2=A0=C2=A0 void *p =3D g_malloc(len);<=
/span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt; &gt;=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (p &amp;&amp; copy) {</span></p><p class=3DM=
soNormal><span lang=3DEN-US>&gt; &gt; &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cpu_memory_rw_debug(env_cpu(env), addr, p, =
len, 0)) {</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt; &gt;=
 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(p=
);</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt; &gt; +=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(p);</sp=
an></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt; &gt;=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p =
=3D NULL;</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt; &gt;=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }</span></p><p=
 class=3DMsoNormal><span lang=3DEN-US>&gt;&gt; &gt;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 }</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt;<=
/span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt;&gt; Ok, that was the=
 obvious part.=C2=A0 Now a next one, also obvious.</span></p><p class=3DMso=
Normal><span lang=3DEN-US>&gt; &gt;</span></p><p class=3DMsoNormal><span la=
ng=3DEN-US>&gt; &gt; You changed lock_user to use g_malloc(), but unlock_us=
er</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt; still uses f=
ree() instead of g_free().=C2=A0 At the very least</span></p><p class=3DMso=
Normal><span lang=3DEN-US>&gt; &gt; the other one needs to be changed too.=
=C2=A0 And I'd say the callers</span></p><p class=3DMsoNormal><span lang=3D=
EN-US>&gt; &gt; should be analyzed to ensure they don't free() the result</=
span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; (they should not, thi=
nk it is a bug if they do).</span></p><p class=3DMsoNormal><span lang=3DEN-=
US>&gt;<o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>=
&gt; We can be pretty sure the callers don't free() the returned</span></p>=
<p class=3DMsoNormal><span lang=3DEN-US>&gt; value, because the calling cod=
e is also used in user-mode,</span></p><p class=3DMsoNormal><span lang=3DEN=
-US>&gt; where the lock/unlock implementation is entirely different</span><=
/p><p class=3DMsoNormal><span lang=3DEN-US>&gt; and calling free() on the p=
ointer will not work.</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt=
; </span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt; lock_user/un=
lock_user (which #defines to softmmu_lock_user/</span></p><p class=3DMsoNor=
mal><span lang=3DEN-US>&gt; &gt; softmmu_unlock_user in softmmu mode) is us=
ed a *lot*.</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; </span><=
/p><p class=3DMsoNormal><span lang=3DEN-US>&gt; The third part here, is tha=
t g_malloc() does not ever</span></p><p class=3DMsoNormal><span lang=3DEN-U=
S>&gt; fail -- it will abort() on out of memory. However</span></p><p class=
=3DMsoNormal><span lang=3DEN-US>&gt; the code here is still handling g_mall=
oc() returning NULL.</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt;=
 The equivalent for &quot;we expect this might fail&quot; (which we want</s=
pan></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; here, because the gues=
t is passing us the length of memory</span></p><p class=3DMsoNormal><span l=
ang=3DEN-US>&gt; to try to allocate) is g_try_malloc().</span></p><p class=
=3DMsoNormal><span lang=3DEN-US>&gt; </span></p><p class=3DMsoNormal><span =
lang=3DEN-US>&gt; thanks</span></p><p class=3DMsoNormal><span lang=3DEN-US>=
&gt; -- PMM</span></p><p class=3DMsoNormal><span lang=3DEN-US>g_malloc() is=
 preferred more than g_try_* functions, which return NULL on error,</span><=
/p><p class=3DMsoNormal><span lang=3DEN-US> when the size of the requested =
allocation=C2=A0 is small. </span></p><p class=3DMsoNormal><span lang=3DEN-=
US>This is because allocating few bytes should not be a problem in a health=
y system. </span></p><p class=3DMsoNormal><span lang=3DEN-US>Otherwise, the=
 system is already in a critical state.</span></p><p class=3DMsoNormal><spa=
n lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-US>Plan to delete null checks after g malloc().</span><span lang=3DEN=
-US style=3D'font-size:12.0pt'><o:p></o:p></span></p><p class=3DMsoNormal><=
span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span la=
ng=3DEN-US style=3D'font-size:12.0pt;font-family:SimSun'><o:p>&nbsp;</o:p><=
/span></p><div style=3D'mso-element:para-border-div;border:none;border-top:=
solid #E1E1E1 1.0pt;padding:3.0pt 0cm 0cm 0cm'><p class=3DMsoNormal style=
=3D'border:none;padding:0cm'><b>=E5=8F=91=E4=BB=B6=E4=BA=BA<span lang=3DEN-=
US>: </span></b><span lang=3DEN-US><a href=3D"mailto:peter.maydell@linaro.o=
rg">Peter Maydell</a><br></span><b>=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4<spa=
n lang=3DEN-US>: </span></b><span lang=3DEN-US>2023</span>=E5=B9=B4<span la=
ng=3DEN-US>7</span>=E6=9C=88<span lang=3DEN-US>25</span>=E6=97=A5<span lang=
=3DEN-US> 17:35<br></span><b>=E6=94=B6=E4=BB=B6=E4=BA=BA<span lang=3DEN-US>=
: </span></b><span lang=3DEN-US><a href=3D"mailto:mjt@tls.msk.ru">Michael T=
okarev</a><br></span><b>=E6=8A=84=E9=80=81<span lang=3DEN-US>: </span></b><=
span lang=3DEN-US><a href=3D"mailto:dinglimin@cmss.chinamobile.com">dinglim=
in</a>; <a href=3D"mailto:richard.henderson@linaro.org">richard.henderson@l=
inaro.org</a>; <a href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.o=
rg</a><br></span><b>=E4=B8=BB=E9=A2=98<span lang=3DEN-US>: </span></b><span=
 lang=3DEN-US>Re: [PATCH] semihosting/uaccess.c: Replaced a malloc call wit=
h g_malloc.</span></p></div><p class=3DMsoNormal><span lang=3DEN-US style=
=3D'font-size:12.0pt;font-family:SimSun'><o:p>&nbsp;</o:p></span></p><p cla=
ss=3DMsoNormal><span lang=3DEN-US>On Tue, 25 Jul 2023 at 10:13, Michael Tok=
arev &lt;mjt@tls.msk.ru&gt; wrote:</span></p><p class=3DMsoNormal><span lan=
g=3DEN-US>&gt;<o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-US>&gt; 25.07.2023 12:00, dinglimin wrote:</span></p><p class=3DMsoNo=
rmal><span lang=3DEN-US>&gt; &gt; Replaced a call to malloc() and its respe=
ctive call to free() with g_malloc() and g_free().</span></p><p class=3DMso=
Normal><span lang=3DEN-US>&gt; &gt;</span></p><p class=3DMsoNormal><span la=
ng=3DEN-US>&gt; &gt; Signed-off-by: dinglimin &lt;dinglimin@cmss.chinamobil=
e.com&gt;</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt;</span=
></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt; V1 -&gt; V2:if cpu_m=
emory_rw_debug failed, still need to set p=3DNULL</span></p><p class=3DMsoN=
ormal><span lang=3DEN-US>&gt; &gt; ---</span></p><p class=3DMsoNormal><span=
 lang=3DEN-US>&gt; &gt;=C2=A0=C2=A0 semihosting/uaccess.c | 4 ++--</span></=
p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt;=C2=A0=C2=A0 1 file chan=
ged, 2 insertions(+), 2 deletions(-)</span></p><p class=3DMsoNormal><span l=
ang=3DEN-US>&gt; &gt;</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt=
; &gt; diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c</span></p=
><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt; index 8018828069..2ac754=
cdb6 100644</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt; ---=
 a/semihosting/uaccess.c</span></p><p class=3DMsoNormal><span lang=3DEN-US>=
&gt; &gt; +++ b/semihosting/uaccess.c</span></p><p class=3DMsoNormal><span =
lang=3DEN-US>&gt; &gt; @@ -14,10 +14,10 @@</span></p><p class=3DMsoNormal><=
span lang=3DEN-US>&gt; &gt;=C2=A0=C2=A0 void *softmmu_lock_user(CPUArchStat=
e *env, target_ulong addr,</span></p><p class=3DMsoNormal><span lang=3DEN-U=
S>&gt; &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 target_ulong len, bool copy)</span></p><p class=3DMsoNor=
mal><span lang=3DEN-US>&gt; &gt;=C2=A0=C2=A0 {</span></p><p class=3DMsoNorm=
al><span lang=3DEN-US>&gt; &gt; -=C2=A0=C2=A0=C2=A0 void *p =3D malloc(len)=
;</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt; +=C2=A0=C2=A0=
=C2=A0 void *p =3D g_malloc(len);</span></p><p class=3DMsoNormal><span lang=
=3DEN-US>&gt; &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (p &amp;&amp; cop=
y) {</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt;=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0if (cpu_memory_rw_debug=
(env_cpu(env), addr, p, len, 0)) {</span></p><p class=3DMsoNormal><span lan=
g=3DEN-US>&gt; &gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 free(p);</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt=
; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
g_free(p);</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt;=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 p =3D NULL;</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &=
gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }</span></p=
><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 }</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt;<o:p>&=
nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; Ok, that=
 was the obvious part.=C2=A0 Now a next one, also obvious.</span></p><p cla=
ss=3DMsoNormal><span lang=3DEN-US>&gt;<o:p>&nbsp;</o:p></span></p><p class=
=3DMsoNormal><span lang=3DEN-US>&gt; You changed lock_user to use g_malloc(=
), but unlock_user</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; s=
till uses free() instead of g_free().=C2=A0 At the very least</span></p><p =
class=3DMsoNormal><span lang=3DEN-US>&gt; the other one needs to be changed=
 too.=C2=A0 And I'd say the callers</span></p><p class=3DMsoNormal><span la=
ng=3DEN-US>&gt; should be analyzed to ensure they don't free() the result</=
span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; (they should not, thi=
nk it is a bug if they do).</span></p><p class=3DMsoNormal><span lang=3DEN-=
US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>We c=
an be pretty sure the callers don't free() the returned</span></p><p class=
=3DMsoNormal><span lang=3DEN-US>value, because the calling code is also use=
d in user-mode,</span></p><p class=3DMsoNormal><span lang=3DEN-US>where the=
 lock/unlock implementation is entirely different</span></p><p class=3DMsoN=
ormal><span lang=3DEN-US>and calling free() on the pointer will not work.</=
span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></=
p><p class=3DMsoNormal><span lang=3DEN-US>&gt; lock_user/unlock_user (which=
 #defines to softmmu_lock_user/</span></p><p class=3DMsoNormal><span lang=
=3DEN-US>&gt; softmmu_unlock_user in softmmu mode) is used a *lot*.</span><=
/p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p c=
lass=3DMsoNormal><span lang=3DEN-US>The third part here, is that g_malloc()=
 does not ever</span></p><p class=3DMsoNormal><span lang=3DEN-US>fail -- it=
 will abort() on out of memory. However</span></p><p class=3DMsoNormal><spa=
n lang=3DEN-US>the code here is still handling g_malloc() returning NULL.</=
span></p><p class=3DMsoNormal><span lang=3DEN-US>The equivalent for &quot;w=
e expect this might fail&quot; (which we want</span></p><p class=3DMsoNorma=
l><span lang=3DEN-US>here, because the guest is passing us the length of me=
mory</span></p><p class=3DMsoNormal><span lang=3DEN-US>to try to allocate) =
is g_try_malloc().</span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&=
nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>thanks</span>=
</p><p class=3DMsoNormal><span lang=3DEN-US>-- PMM</span></p><p class=3DMso=
Normal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p></div></body></html>=

--_3DD5A187-4286-4919-9294-C9508DF89758_--





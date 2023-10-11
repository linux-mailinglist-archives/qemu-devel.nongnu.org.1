Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F0F7C48D1
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 06:25:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqQln-0007Sd-F9; Wed, 11 Oct 2023 00:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qqQll-0007SQ-PG
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 00:24:25 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qqQlj-0002gM-9b
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 00:24:25 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso1097348a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 21:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696998261; x=1697603061;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U7wu6oRSaoVQbnHHGelTdN6bIyM+EPtZAoXS7nDMkso=;
 b=lz4ingyi1YKnbdksqs36Y9iY4AbsmCt+HMcNXS9hpo/inPKGIiS4WByl36uE3MbmEc
 D4HSX8Myl3Kbeg76pRgNBcY8e1jTRBfr00TRRBFSgu74sSpsqO5H9dwQe1b0F5KrEpZ6
 9fJ39mb5txXUvwdz9tEaootiHFzjD7qoINQ4d/CGm/djRhqBmoBd/nwXQH9ZBrds9xgF
 PH+7v/zikSsxy4gm/DPTTvmA3knTQttGLCitBQbNNoZaSRFUIYJwJ/phTuv3r9QyiPj/
 JVmfzAqnRTh/NjuctNC2LX8mm6BceEYnRFIS05lENBHl+pz0KJCYpZuqI6GX3IZHyfxC
 Nwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696998261; x=1697603061;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U7wu6oRSaoVQbnHHGelTdN6bIyM+EPtZAoXS7nDMkso=;
 b=cxERbFpMt29yB1xc7UQEX1Hq/nCt6/I3cYwEM4KFs+bX2irpteuHoZlRZK4jol1H/Y
 8zumSBsZ/t3QviLfAI22kcs+fIvVV6onQZb2V5HCof7GSpgY1mRPv0idpZsqkUYgfVGo
 Ef9sdweyJ5r6/eeZwcDxujRSRba/l0ifAdh/3AOWLfhkvtymE6qh1W7A1omgSIuhm5j5
 Pa6UIcG9G3b2PaWUrk2nPwB3IHpY4Q0JI6xjfQmv6GS0W3U9glM02ToXyRbagWYln4J/
 O6ni8vYEmzVfXxoLMHOOHHYvIllLUtrenhabV9Y6MAxfrgL47DcXHXv3EGhEuoWQYP4l
 kWWA==
X-Gm-Message-State: AOJu0Yw1l/Sl04QJRXWRX8+EercRWLT3pU4WImqz8BwSwcPoNs1AsppN
 gr887ug4gAsFeFSVyr+mG2HpzvmieY7eWB883FihQQ==
X-Google-Smtp-Source: AGHT+IGhoCoIopK78Sr6OH7qT6JFFWRCteBVoiyNYlmXUi8tovrXSWFUWvGc2Xrw7Iy08mZjtcH6w3gwQhBjxfKBThc=
X-Received: by 2002:a05:6402:5213:b0:533:4a89:5b2e with SMTP id
 s19-20020a056402521300b005334a895b2emr14081644edd.1.1696998261120; Tue, 10
 Oct 2023 21:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-7-npiggin@gmail.com>
 <CANCZdfqNJ97EgAax=P7pzny8zcULfiLEVJighecm5=DgLtRv8g@mail.gmail.com>
 <CW56TZQEDIBH.36TCETGSU8X47@wheely>
In-Reply-To: <CW56TZQEDIBH.36TCETGSU8X47@wheely>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 10 Oct 2023 22:24:24 -0600
Message-ID: <CANCZdfoRpo3beY6VgEj3g=d8bnvqHc-6pqSM_GstJ=j5GAhS7Q@mail.gmail.com>
Subject: Re: [RFC PATCH 06/11] tests/avocado: Add FreeBSD distro boot tests
 for ppc
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000089f292060769325f"
Received-SPF: none client-ip=2a00:1450:4864:20::535;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

--00000000000089f292060769325f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 6:36=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com>=
 wrote:

> On Wed Oct 11, 2023 at 7:55 AM AEST, Warner Losh wrote:
> > On Tue, Oct 10, 2023 at 1:53=E2=80=AFAM Nicholas Piggin <npiggin@gmail.=
com>
> wrote:
> >
> > > FreeBSD project provides qcow2 images that work well for testing QEMU=
.
> > > Add pseries tests for HPT and Radix, KVM and TCG.
> > >
> > > Other architectures could be added so this does not get a ppc_ prefix
> > > but is instead named similarly to boot_linux.
> > >
> > > Cc: Warner Losh <imp@bsdimp.com>
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > >
> > > CC'ing Warner to check if it's okay for us to use these images and
> > > any comments or suggestions. avocado tests have many Linux boots so
> we'd
> > > do much better to expand test coverage by adding some other systems.
> > >
> >
> > I like this.... I'm a little worried at the exact hash encoded in it, b=
ut
> > since there's a checksum
> > to match, it's OK I guess. It will give this code a shelf-life of month=
s,
> > IIRC our retention policy.
>
> Oh I didn't realise, I saw some 2021 dates in the directory listing but
> looks
> like they're not for the artifacts themselves.
>
> I don't suppose you know if there are any long-term artifacts kept
> around, or someone who I could ask?
>
> The downside of using short term images is that it can be harder to
> reproduce reports from others, bisect, run manual testing, etc. I think
> these would still be useful, so long as they get updated regularly.
>

Yes. We're in kind of a weird zone. powerpc64le is a new architecture, so
hasn't had artifacts for long. 14.0 is in progress, but not done yet, so
there's
no 'long term stable' version to use yet.

I don't know what our current retention policy is, hence my caution.


> >
> > Other than that, I think this is good. Not familiar enough with Avocado
> to
> > understand
> > skipping for gitlab CI, but given the extreme crunch on minutes, I thin=
k
> > that's OK.
>
> Yeah I'm not sure what the situation there is, I didn't want to add new
> tests of any significant weight yet. We could always flip it on later if
> people want it.
>

That makes sense.


> >
> > Other than one nit below which is fine if it is intentionally left behi=
nd
> > (or removed):
> >
> > Reviewed-by: Warner Losh <imp@bsdimp.com>
> >
> > Please don't hesitate to reach out to me if this is failing. I'll act a=
s
> a
> > backstop to get
> > it to the right people.
>
> Thanks Warner.
>

You bet. I'll give a heads up once we have 14.0 out so we can switch to
a more stable artifact.

Warner


> >
> > Warner
> >
> >
> [snip]
>
> > > +    def run_pseries_test(self, force_HPT=3DFalse):
> > > +        # We need zstd for all the tuxrun tests
> > > +        # See
> https://github.com/avocado-framework/avocado/issues/5609
> > > +        zstd =3D find_command('zstd', False)
> > > +        if zstd is False:
> > > +            self.cancel('Could not find "zstd", which is required to=
 '
> > > +                        'decompress rootfs')
> > > +        self.zstd =3D zstd
> > > +
> > > +        drive_url =3D ('
> > >
> https://artifact.ci.freebsd.org/snapshot/15.0-CURRENT/a2440348eed75bb7682=
579af0905b652747fd016/powerpc/powerpc64le/disk.qcow2.zst
> > > ')
> > > +        drive_hash =3D '8ab11a05ccab3d44215fd4667a70454ed10a203f'
> > > +        drive_path_zstd =3D self.fetch_asset(drive_url,
> > > asset_hash=3Ddrive_hash)
> > > +        drive_path =3D os.path.join(self.workdir, 'disk.qcow2')
> > > +        # archive.zstd_uncompress(drive_path_zstd, drive_path)
> > >
> >
> > Why is this commented out? It looks like a leftover maybe?
> >
>
> Ah yes, avocado recently got zstd_uncompress but it seems not
> available for QEMU yet so we have to do it by hand. I'll remove.
>
> Thanks,
> Nick
>

--00000000000089f292060769325f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 10, 2023 at 6:36=E2=80=AF=
PM Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmail.com">npiggin@gmail.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On Wed Oct 11, 2023 at 7:55 AM AEST, Warner Losh wrote:<br>
&gt; On Tue, Oct 10, 2023 at 1:53=E2=80=AFAM Nicholas Piggin &lt;<a href=3D=
"mailto:npiggin@gmail.com" target=3D"_blank">npiggin@gmail.com</a>&gt; wrot=
e:<br>
&gt;<br>
&gt; &gt; FreeBSD project provides qcow2 images that work well for testing =
QEMU.<br>
&gt; &gt; Add pseries tests for HPT and Radix, KVM and TCG.<br>
&gt; &gt;<br>
&gt; &gt; Other architectures could be added so this does not get a ppc_ pr=
efix<br>
&gt; &gt; but is instead named similarly to boot_linux.<br>
&gt; &gt;<br>
&gt; &gt; Cc: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_=
blank">imp@bsdimp.com</a>&gt;<br>
&gt; &gt; Signed-off-by: Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmai=
l.com" target=3D"_blank">npiggin@gmail.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; CC&#39;ing Warner to check if it&#39;s okay for us to use these i=
mages and<br>
&gt; &gt; any comments or suggestions. avocado tests have many Linux boots =
so we&#39;d<br>
&gt; &gt; do much better to expand test coverage by adding some other syste=
ms.<br>
&gt; &gt;<br>
&gt;<br>
&gt; I like this.... I&#39;m a little worried at the exact hash encoded in =
it, but<br>
&gt; since there&#39;s a checksum<br>
&gt; to match, it&#39;s OK I guess. It will give this code a shelf-life of =
months,<br>
&gt; IIRC our retention policy.<br>
<br>
Oh I didn&#39;t realise, I saw some 2021 dates in the directory listing but=
 looks<br>
like they&#39;re not for the artifacts themselves.<br>
<br>
I don&#39;t suppose you know if there are any long-term artifacts kept<br>
around, or someone who I could ask?<br>
<br>
The downside of using short term images is that it can be harder to<br>
reproduce reports from others, bisect, run manual testing, etc. I think<br>
these would still be useful, so long as they get updated regularly.<br></bl=
ockquote><div><br></div><div>Yes. We&#39;re in kind of a weird zone. powerp=
c64le is a new architecture, so</div><div>hasn&#39;t had artifacts for long=
. 14.0 is in progress, but not done yet, so there&#39;s</div><div>no &#39;l=
ong term stable&#39; version to use yet.</div><div><br></div><div>I don&#39=
;t know what our current retention policy is, hence my caution.<br></div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt; Other than that, I think this is good. Not familiar enough with Avocad=
o to<br>
&gt; understand<br>
&gt; skipping for gitlab CI, but given the extreme crunch on minutes, I thi=
nk<br>
&gt; that&#39;s OK.<br>
<br>
Yeah I&#39;m not sure what the situation there is, I didn&#39;t want to add=
 new<br>
tests of any significant weight yet. We could always flip it on later if<br=
>
people want it.<br></blockquote><div><br></div><div>That makes sense.<br></=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt; Other than one nit below which is fine if it is intentionally left beh=
ind<br>
&gt; (or removed):<br>
&gt;<br>
&gt; Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=
=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt;<br>
&gt; Please don&#39;t hesitate to reach out to me if this is failing. I&#39=
;ll act as a<br>
&gt; backstop to get<br>
&gt; it to the right people.<br>
<br>
Thanks Warner.<br></blockquote><div><br></div><div>You bet. I&#39;ll give a=
 heads up once we have 14.0 out so we can switch to</div><div>a more stable=
 artifact.</div><div><br></div><div>Warner<br></div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt; Warner<br>
&gt;<br>
&gt;<br>
[snip]<br>
<br>
&gt; &gt; +=C2=A0 =C2=A0 def run_pseries_test(self, force_HPT=3DFalse):<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # We need zstd for all the tuxrun te=
sts<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # See <a href=3D"https://github.com/=
avocado-framework/avocado/issues/5609" rel=3D"noreferrer" target=3D"_blank"=
>https://github.com/avocado-framework/avocado/issues/5609</a><br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 zstd =3D find_command(&#39;zstd&#39;=
, False)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if zstd is False:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.cancel(&#39;Could=
 not find &quot;zstd&quot;, which is required to &#39;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &#39;decompress rootfs&#39;)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.zstd =3D zstd<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 drive_url =3D (&#39;<br>
&gt; &gt; <a href=3D"https://artifact.ci.freebsd.org/snapshot/15.0-CURRENT/=
a2440348eed75bb7682579af0905b652747fd016/powerpc/powerpc64le/disk.qcow2.zst=
" rel=3D"noreferrer" target=3D"_blank">https://artifact.ci.freebsd.org/snap=
shot/15.0-CURRENT/a2440348eed75bb7682579af0905b652747fd016/powerpc/powerpc6=
4le/disk.qcow2.zst</a><br>
&gt; &gt; &#39;)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 drive_hash =3D &#39;8ab11a05ccab3d44=
215fd4667a70454ed10a203f&#39;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 drive_path_zstd =3D self.fetch_asset=
(drive_url,<br>
&gt; &gt; asset_hash=3Ddrive_hash)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 drive_path =3D os.path.join(self.wor=
kdir, &#39;disk.qcow2&#39;)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # archive.zstd_uncompress(drive_path=
_zstd, drive_path)<br>
&gt; &gt;<br>
&gt;<br>
&gt; Why is this commented out? It looks like a leftover maybe?<br>
&gt;<br>
<br>
Ah yes, avocado recently got zstd_uncompress but it seems not<br>
available for QEMU yet so we have to do it by hand. I&#39;ll remove.<br>
<br>
Thanks,<br>
Nick<br>
</blockquote></div></div>

--00000000000089f292060769325f--


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E3A9687AB
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Sep 2024 14:39:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl6KF-0002FB-L3; Mon, 02 Sep 2024 08:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1sl6KE-0002ET-5g
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 08:38:30 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1sl6KC-00015z-0f
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 08:38:29 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2da4e84c198so139556a91.0
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 05:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725280705; x=1725885505; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cex8U41EsijBpGRTOJOeaVeMvJWeGQqHeMDq621Lsg8=;
 b=WIlX30meL5GH18vw+b5T36aSOssOGWlxUsx4LYpLLpd29vp7ZPVLPAikcApIISK3CI
 k/lzEJIHcUlQ7x6ARF/0m/56rseZD63Y/leIaKe+UOhcFwYIZ8j5T5xPKRLAHV/Rt4T/
 jhpCFaLGFCRobPYlFNJSyty1Wbp0+BAO3jpj2hrmWtmfotIWBrjyWHQ9qlWujKQYgpKC
 8OO7bzncfy7ylSh0caMvcj+ukRr9KNazYfNeixYfkj8NDNiqy+1x69HlHYu74JCvLNsA
 6WKoi1SHU+4xk6C6HjrDpoT+cSy6nFzvcV2hEhB9RnJQZSfkwgvZO8EKmcZBIJRYcYDW
 DH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725280705; x=1725885505;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cex8U41EsijBpGRTOJOeaVeMvJWeGQqHeMDq621Lsg8=;
 b=KJXYFQ5tKvfDJqMbTg6/GqQwBrOt9BH4XN5x536y1wwQow0dj0mATtbjKvMtaQ+nL+
 WKcl24Z2rGL1gt3hHFXPnVxhR+/TveDkGAnWhyjsxw1wArUj+Qn9zwzfwEPzJzQ8KALn
 kNvjUz2Gtos/WvH2g/7pth2QhNPH+RfEb6AoQ8eke/YnX6s4u06yFmVL6OVxRWUg5qSV
 q8zQlqdwAp7GMe62YRtPPo+7hXwtE6sZVENXj2I6KZlkGoq97XpSYeL4iHOKRsOHXkDN
 sgp/0hXUvDTWAAwxwo9SXm9itpE5rfoiLv9veUB5c5Fi2Y/82YCPHHREendn+9u2ny1B
 G0Nw==
X-Gm-Message-State: AOJu0YwfNFmDi4A3YoR5569EKUQ1xzNlut87/4lKUtYkjhS16g5ZiEcl
 wtwPlWXClgG6VzjmWzU/9KMevc0Vnw1MLmngq4DQJzg7mZ6smNBgFmIAAsqaVICWCf6Bu2mVNuO
 5ZKhiBhQsDZ9w1lBIMV9Gt+Conm0=
X-Google-Smtp-Source: AGHT+IHTWZeXh9kw7GxOUO5NTLHX21WPjq2sqzW7Yks/0Tzx+sFKJFUmgIvUelC9W8ZugxhQQ6Z2/IDhTcnUpXnTJ80=
X-Received: by 2002:a17:90b:24a:b0:2d8:a9af:b94f with SMTP id
 98e67ed59e1d1-2d8a9afbb93mr5205447a91.7.1725280704820; Mon, 02 Sep 2024
 05:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240816162044.5764-1-just4now666666@gmail.com>
 <871q2ae24s.fsf@draig.linaro.org>
 <CACkyd_anZKrjNUKE+nwzSvJGQwxQ2zq2J8sGawq3pKYLVT9vXQ@mail.gmail.com>
 <CACkyd_ZNPzhg8pqkdLucyJ70wZKJARR_65r5CJBy0+U=7GR_1Q@mail.gmail.com>
 <87h6b452m5.fsf@draig.linaro.org>
In-Reply-To: <87h6b452m5.fsf@draig.linaro.org>
From: Elisha Hollander <just4now666666@gmail.com>
Date: Mon, 2 Sep 2024 15:38:12 +0300
Message-ID: <CACkyd_YG-r837VfoPaOw5bKCczAUQYFOobW=2SF37esppbc0XQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] allow using a higher icount
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008c7eff0621223763"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=just4now666666@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000008c7eff0621223763
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just checked with 9.0.2 it it still gives the error...

On Wed, Aug 28, 2024, 14:05 Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:

> Elisha Hollander <just4now666666@gmail.com> writes:
>
> > Although it gives `undefined symbol: qemu_plugin_scoreboard_free`. But
> > probably I messed something up...
>
> Are you using an older QEMU? We should trigger an API warning if they
> are mismatched but maybe thats not working.
>
> >
> > On Tue, Aug 27, 2024, 14:59 Elisha Hollander <just4now666666@gmail.com>
> wrote:
> >
> >  Oh nice, I didn't know that
> >
> >  On Tue, Aug 27, 2024, 12:39 Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> >
> >  Elisha Hollander <just4now666666@gmail.com> writes:
> >
> >  > Signed-off-by: Elisha Hollander <just4now666666@gmail.com>
> >
> >  What is the use-case for this patch?
> >
> >  If you are simply looking to slow the emulated system down please have=
 a
> >  look at:
> >
> >
> https://qemu.readthedocs.io/en/master/about/emulation.html#limit-instruct=
ions-per-second
> >
> >  which uses the plugin system to limit the run rate and sleep if its
> >  running too fast. The longer term goal is to deprecate the icount cloc=
k
> >  alignment feature from the core code and leave icount to just provide
> >  the deterministic execution needed for record/replay and reverse
> >  debugging.
> >
> >  > ---
> >  >  accel/tcg/cpu-exec.c      | 4 +---
> >  >  accel/tcg/icount-common.c | 4 ++--
> >  >  2 files changed, 3 insertions(+), 5 deletions(-)
> >  >
> >  > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> >  > index 8163295f34..4c2baf8ed4 100644
> >  > --- a/accel/tcg/cpu-exec.c
> >  > +++ b/accel/tcg/cpu-exec.c
> >  > @@ -95,11 +95,10 @@ static void align_clocks(SyncClocks *sc, CPUStat=
e
> *cpu)
> >  >  static void print_delay(const SyncClocks *sc)
> >  >  {
> >  >      static float threshold_delay;
> >  > -    static int64_t last_realtime_clock;
> >  >      static int nb_prints;
> >  >
> >  >      if (icount_align_option &&
> >  > -        sc->realtime_clock - last_realtime_clock >=3D
> MAX_DELAY_PRINT_RATE &&
> >  > +        sc->diff_clk >=3D MAX_DELAY_PRINT_RATE &&
> >  >          nb_prints < MAX_NB_PRINTS) {
> >  >          if ((-sc->diff_clk / (float)1000000000LL > threshold_delay)
> ||
> >  >              (-sc->diff_clk / (float)1000000000LL <
> >  > @@ -109,7 +108,6 @@ static void print_delay(const SyncClocks *sc)
> >  >                          threshold_delay - 1,
> >  >                          threshold_delay);
> >  >              nb_prints++;
> >  > -            last_realtime_clock =3D sc->realtime_clock;
> >  >          }
> >  >      }
> >  >  }
> >  > diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
> >  > index 8d3d3a7e9d..f07f8baf4d 100644
> >  > --- a/accel/tcg/icount-common.c
> >  > +++ b/accel/tcg/icount-common.c
> >  > @@ -46,8 +46,8 @@
> >  >   * is TCG-specific, and does not need to be built for other accels.
> >  >   */
> >  >  static bool icount_sleep =3D true;
> >  > -/* Arbitrarily pick 1MIPS as the minimum allowable speed.  */
> >  > -#define MAX_ICOUNT_SHIFT 10
> >  > +/* Arbitrarily pick the minimum allowable speed.  */
> >  > +#define MAX_ICOUNT_SHIFT 30
> >  >
> >  >  /* Do not count executed instructions */
> >  >  ICountMode use_icount =3D ICOUNT_DISABLED;
> >
> >  --
> >  Alex Benn=C3=A9e
> >  Virtualisation Tech Lead @ Linaro
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--0000000000008c7eff0621223763
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Just checked with 9.0.2 it it still gives the error...</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed=
, Aug 28, 2024, 14:05 Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@li=
naro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Elisha Hollander &lt;<a href=3D"mailto:just4now666666@gmail.c=
om" target=3D"_blank" rel=3D"noreferrer">just4now666666@gmail.com</a>&gt; w=
rites:<br>
<br>
&gt; Although it gives `undefined symbol: qemu_plugin_scoreboard_free`. But=
<br>
&gt; probably I messed something up...<br>
<br>
Are you using an older QEMU? We should trigger an API warning if they<br>
are mismatched but maybe thats not working.<br>
<br>
&gt;<br>
&gt; On Tue, Aug 27, 2024, 14:59 Elisha Hollander &lt;<a href=3D"mailto:jus=
t4now666666@gmail.com" target=3D"_blank" rel=3D"noreferrer">just4now666666@=
gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 Oh nice, I didn&#39;t know that<br>
&gt;<br>
&gt;=C2=A0 On Tue, Aug 27, 2024, 12:39 Alex Benn=C3=A9e &lt;<a href=3D"mail=
to:alex.bennee@linaro.org" target=3D"_blank" rel=3D"noreferrer">alex.bennee=
@linaro.org</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 Elisha Hollander &lt;<a href=3D"mailto:just4now666666@gmail.com"=
 target=3D"_blank" rel=3D"noreferrer">just4now666666@gmail.com</a>&gt; writ=
es:<br>
&gt;<br>
&gt;=C2=A0 &gt; Signed-off-by: Elisha Hollander &lt;<a href=3D"mailto:just4=
now666666@gmail.com" target=3D"_blank" rel=3D"noreferrer">just4now666666@gm=
ail.com</a>&gt;<br>
&gt;<br>
&gt;=C2=A0 What is the use-case for this patch?<br>
&gt;<br>
&gt;=C2=A0 If you are simply looking to slow the emulated system down pleas=
e have a<br>
&gt;=C2=A0 look at:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 <a href=3D"https://qemu.readthedocs.io/en/master/about/em=
ulation.html#limit-instructions-per-second" rel=3D"noreferrer noreferrer" t=
arget=3D"_blank">https://qemu.readthedocs.io/en/master/about/emulation.html=
#limit-instructions-per-second</a><br>
&gt;<br>
&gt;=C2=A0 which uses the plugin system to limit the run rate and sleep if =
its<br>
&gt;=C2=A0 running too fast. The longer term goal is to deprecate the icoun=
t clock<br>
&gt;=C2=A0 alignment feature from the core code and leave icount to just pr=
ovide<br>
&gt;=C2=A0 the deterministic execution needed for record/replay and reverse=
<br>
&gt;=C2=A0 debugging.<br>
&gt;<br>
&gt;=C2=A0 &gt; ---<br>
&gt;=C2=A0 &gt;=C2=A0 accel/tcg/cpu-exec.c=C2=A0 =C2=A0 =C2=A0 | 4 +---<br>
&gt;=C2=A0 &gt;=C2=A0 accel/tcg/icount-common.c | 4 ++--<br>
&gt;=C2=A0 &gt;=C2=A0 2 files changed, 3 insertions(+), 5 deletions(-)<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c<br=
>
&gt;=C2=A0 &gt; index 8163295f34..4c2baf8ed4 100644<br>
&gt;=C2=A0 &gt; --- a/accel/tcg/cpu-exec.c<br>
&gt;=C2=A0 &gt; +++ b/accel/tcg/cpu-exec.c<br>
&gt;=C2=A0 &gt; @@ -95,11 +95,10 @@ static void align_clocks(SyncClocks *sc=
, CPUState *cpu)<br>
&gt;=C2=A0 &gt;=C2=A0 static void print_delay(const SyncClocks *sc)<br>
&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 static float threshold_delay;<br>
&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 static int64_t last_realtime_clock;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 static int nb_prints;<br>
&gt;=C2=A0 &gt;=C2=A0 <br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (icount_align_option &amp;&amp;<br>
&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sc-&gt;realtime_clock - last_r=
ealtime_clock &gt;=3D MAX_DELAY_PRINT_RATE &amp;&amp;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sc-&gt;diff_clk &gt;=3D MAX_DE=
LAY_PRINT_RATE &amp;&amp;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nb_prints &lt; MAX_NB_PRI=
NTS) {<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((-sc-&gt;diff_clk / (=
float)1000000000LL &gt; threshold_delay) ||<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (-sc-&gt;di=
ff_clk / (float)1000000000LL &lt;<br>
&gt;=C2=A0 &gt; @@ -109,7 +108,6 @@ static void print_delay(const SyncClock=
s *sc)<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 threshold_delay - 1,<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 threshold_delay);<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nb_prints++=
;<br>
&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_realtime_cl=
ock =3D sc-&gt;realtime_clock;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt;=C2=A0 &gt; diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-c=
ommon.c<br>
&gt;=C2=A0 &gt; index 8d3d3a7e9d..f07f8baf4d 100644<br>
&gt;=C2=A0 &gt; --- a/accel/tcg/icount-common.c<br>
&gt;=C2=A0 &gt; +++ b/accel/tcg/icount-common.c<br>
&gt;=C2=A0 &gt; @@ -46,8 +46,8 @@<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0* is TCG-specific, and does not need to be buil=
t for other accels.<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 &gt;=C2=A0 static bool icount_sleep =3D true;<br>
&gt;=C2=A0 &gt; -/* Arbitrarily pick 1MIPS as the minimum allowable speed.=
=C2=A0 */<br>
&gt;=C2=A0 &gt; -#define MAX_ICOUNT_SHIFT 10<br>
&gt;=C2=A0 &gt; +/* Arbitrarily pick the minimum allowable speed.=C2=A0 */<=
br>
&gt;=C2=A0 &gt; +#define MAX_ICOUNT_SHIFT 30<br>
&gt;=C2=A0 &gt;=C2=A0 <br>
&gt;=C2=A0 &gt;=C2=A0 /* Do not count executed instructions */<br>
&gt;=C2=A0 &gt;=C2=A0 ICountMode use_icount =3D ICOUNT_DISABLED;<br>
&gt;<br>
&gt;=C2=A0 -- <br>
&gt;=C2=A0 Alex Benn=C3=A9e<br>
&gt;=C2=A0 Virtualisation Tech Lead @ Linaro<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div>

--0000000000008c7eff0621223763--


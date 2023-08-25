Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7784C787CC8
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 03:09:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZLK2-00038f-4j; Thu, 24 Aug 2023 21:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1qZLJz-00038I-EX
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 21:09:07 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1qZLJw-0003pQ-SU
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 21:09:06 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b9a2033978so5598451fa.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 18:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692925743; x=1693530543;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1reuS4IRhUUL0sKsCn3vVj+Dpqn4QuPwL+Nw/5z39HE=;
 b=bkBbxB0MgTbW0ZO/T9/kjedkMYNn99bDuv5JSfcY0zePq6Fhw2D4dFf+G8U9xSR6EE
 /Z4ah4Z37ptI3Mq461zRNY6Bn83GEwGHtsjrgW0FDJ56YJQ9QQ2TeR6tUzWMy8TgGlr3
 JyHrZdCKwicxstOXuGavEJ04MKDBh5zubk3N7pDmpmTEMAHDHBpoSgbxy/h0qbzvdEYe
 kb7rbGNYusOinIwZq7KFMxwk7oZBC2Pv38MfhlFta1+MmL2aR8UWhPue11y7AIWMRc6e
 Mnd+c942mc5tAff7X6/EUEcGwWC1JyytoU0ZQGA1CLraan7GNrzU29PvA7vIzm36CnI6
 JQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692925743; x=1693530543;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1reuS4IRhUUL0sKsCn3vVj+Dpqn4QuPwL+Nw/5z39HE=;
 b=E4AtRw3JaZKOx9uS628QEYARyadQKn1QDiehxJGfhIJGTIrNq1q9bENoso5JAJFORV
 iFtWfrJvf7vn6grc98LRxWIZYl3LYM2Ajelbmul1mDS8igEHWnuwy6FTPBFh2tBVBxqf
 OzHRwh06mfA0nRVD4FpenndUJUEy5z5MLeKb6OBU/aki1Xw9bePISgz8xDqiPJ+gQqDO
 GyQy11UCgGclcg2dMa55mMJCY+OpJFHDb8CRVNQscW4vm4WaGV6TRPDGis61uekQyCIt
 BUt31pYf5BWC31aLnGlqTMNV7+x9BHUgE9skUzy8ccTQg6urAflhYF/1tI7ibPqB6Iy5
 J7Ug==
X-Gm-Message-State: AOJu0Ywu8hWmbDBRXfbzcklQIjJTGmJ7q4ibD2ne7+NMngdqKJQv/EiG
 9/OWm8uWyJaqRksQLov8A6xvc2ew4l3VFfSq1w==
X-Google-Smtp-Source: AGHT+IE0I6whpxAA2RqMs41ttit+sOXK9NuSQylr9GqSBBPjKGzUc1S8zWEXPuBYF5NSBMZnt+6oCPeq0NjZHpL15RA=
X-Received: by 2002:a2e:9dcd:0:b0:2b6:e105:6174 with SMTP id
 x13-20020a2e9dcd000000b002b6e1056174mr12897059ljj.47.1692925742713; Thu, 24
 Aug 2023 18:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAOYM0N261g8zrDKq2jQo4mriHEhNXWo-oXZ0LCryL+BmUX-h6g@mail.gmail.com>
 <87jztlt27t.fsf@pond.sub.org>
 <CAFEAcA8QnXJF73C7c1Y=yVJbBQAK-uFm9DQDJZdugc24ybsk5g@mail.gmail.com>
In-Reply-To: <CAFEAcA8QnXJF73C7c1Y=yVJbBQAK-uFm9DQDJZdugc24ybsk5g@mail.gmail.com>
From: Liu Jaloo <liu.jaloo@gmail.com>
Date: Fri, 25 Aug 2023 09:09:01 +0800
Message-ID: <CAOYM0N184NXQ5jK+fTE=nsb5sJ_dg3mV6ZT9d2zoVQbsPD0mog@mail.gmail.com>
Subject: Re: constructor vs. __constructor__
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000008690350603b4fd94"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=liu.jaloo@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000008690350603b4fd94
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your reply.

On Thu, Aug 24, 2023 at 5:33=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Thu, 24 Aug 2023 at 06:55, Markus Armbruster <armbru@redhat.com> wrote=
:
> >
> > Liu Jaloo <liu.jaloo@gmail.com> writes:
> >
> > > What's the difference between  "__attribute__((constructor))" and
> > > "__attribute__((__constructor__))" in qemu source?
> >
> > Reading the fine manual helps:
> >
> >     You may optionally specify attribute names with =E2=80=98__=E2=80=
=99 preceding and
> >     following the name.  This allows you to use them in header files
> >     without being concerned about a possible macro of the same name. Fo=
r
> >     example, you may use the attribute name __noreturn__ instead of
> >     noreturn.
>
> As usual in the QEMU sources, we are not particularly consistent
> about using one version compared to the other. However we
> mostly use the "__attribute__((foo))" form rather than
> "__attribute__((__foo__))" so if you're writing new code then
> prefer the former.
>
> We also have a handful of uses of "__attribute((foo))" and
> "__attribute((__foo__))". Definitely don't add more of those :-)
>
> thanks
> -- PMM
>

--0000000000008690350603b4fd94
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for your reply.<br></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 24, 2023 at 5:33=E2=
=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">pete=
r.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On Thu, 24 Aug 2023 at 06:55, Markus Armbruster &lt;<a =
href=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&g=
t; wrote:<br>
&gt;<br>
&gt; Liu Jaloo &lt;<a href=3D"mailto:liu.jaloo@gmail.com" target=3D"_blank"=
>liu.jaloo@gmail.com</a>&gt; writes:<br>
&gt;<br>
&gt; &gt; What&#39;s the difference between=C2=A0 &quot;__attribute__((cons=
tructor))&quot; and<br>
&gt; &gt; &quot;__attribute__((__constructor__))&quot; in qemu source?<br>
&gt;<br>
&gt; Reading the fine manual helps:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0You may optionally specify attribute names with =E2=
=80=98__=E2=80=99 preceding and<br>
&gt;=C2=A0 =C2=A0 =C2=A0following the name.=C2=A0 This allows you to use th=
em in header files<br>
&gt;=C2=A0 =C2=A0 =C2=A0without being concerned about a possible macro of t=
he same name. For<br>
&gt;=C2=A0 =C2=A0 =C2=A0example, you may use the attribute name __noreturn_=
_ instead of<br>
&gt;=C2=A0 =C2=A0 =C2=A0noreturn.<br>
<br>
As usual in the QEMU sources, we are not particularly consistent<br>
about using one version compared to the other. However we<br>
mostly use the &quot;__attribute__((foo))&quot; form rather than<br>
&quot;__attribute__((__foo__))&quot; so if you&#39;re writing new code then=
<br>
prefer the former.<br>
<br>
We also have a handful of uses of &quot;__attribute((foo))&quot; and<br>
&quot;__attribute((__foo__))&quot;. Definitely don&#39;t add more of those =
:-)<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--0000000000008690350603b4fd94--


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1597B2964
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 02:08:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm124-0001VI-D5; Thu, 28 Sep 2023 20:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crauer@google.com>) id 1qm11p-0001Uc-Ou
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 20:06:46 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <crauer@google.com>) id 1qm11b-0004hL-Ii
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 20:06:45 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c1e3a4a06fso102415865ad.3
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 17:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695945988; x=1696550788; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=05DRJFyDe8vk6upmI+dJM7NtLnApDdy7Sg1oM2sN+m4=;
 b=iCPVOik0mtdfvYFRyHdqsdcZeRkmB9FJ44goKPK4260QFvhkCCmYMwsFvLKwSLz8HE
 OVufIasjjzl97XKENBJylVb1k1ORpZT4vLbQAl+E4/zFgYX0anc85YqmX4xDgzniBsvv
 wgaE7S9HHrkn0mlramobi3U1CsyMtAPTSq95WpxnFrG053CnwSMrK47hcPBw+IPnDeWl
 rg2Q9rQcZgd3w/v1rNyQfKxF+NNEzsFUPte/NYqGZgc/Hbvo0JW7cBSeV91+bUej63gA
 o5D9vdoFT8fo4jgg0+U7F36VJSB517lZ4wigDnZYCk8uAmfH/NrcnBe/WO0huEamx0Zm
 VPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695945988; x=1696550788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=05DRJFyDe8vk6upmI+dJM7NtLnApDdy7Sg1oM2sN+m4=;
 b=cnVZOPdPQHUBzs95xnGLNmIIRTlHYKQJv4y7GwS8UE1Q/apbjhnWb/uUUdz8lwsv1A
 G9GpylkvDoRuaKI7Lax8b/10HLZUnQn75JHbqL2CDZP2U3awuPc6HBYLkapptmiOsNqV
 zENQU1VFZx0yebUABFDlmuKnXUsrHsmWEAocSHJKaONxyoEX4I6AktBoqjBVTTaE/0j7
 Kx36bjEciE/F2DkGWQRWhIB96B2bV+fyfdiGYt4jEu78zPt30UBcLcDzNhBltw5lkowa
 yT2szumUC1C0WIxFh9PYMkApL2wbvyjRIeztI3yQgoDOUyDAjQj+dtwuzT2ju03gN+P6
 Uijw==
X-Gm-Message-State: AOJu0YyQS7kZCBdzroqb6MT95Nx3TsAoPEBVpJlcQncEYlrBSNH4vxkg
 XT6lcqO8Vy4AvO+ZY8u34VO+w/LNq5zey0MPc+AUBA==
X-Google-Smtp-Source: AGHT+IHrevWJgUoHftWOv0W8VIloVlC/pHMuCOJXa0LfWh82+oCOshxycdtUrDFwnuWaYusvtMo8Qrk+MdvvpdDGzOc=
X-Received: by 2002:a17:90a:d787:b0:273:f51f:1626 with SMTP id
 z7-20020a17090ad78700b00273f51f1626mr2350374pju.35.1695945988175; Thu, 28 Sep
 2023 17:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230928034505.255480-1-crauer@google.com>
 <e5ddb46e-e677-3fc8-4f32-0f59e85eb304@redhat.com>
In-Reply-To: <e5ddb46e-e677-3fc8-4f32-0f59e85eb304@redhat.com>
From: Chris Rauer <crauer@google.com>
Date: Thu, 28 Sep 2023 17:06:16 -0700
Message-ID: <CAFtMCFWPjmgVn++ioNvKHtAft3+fFrba0ci0TePpMTzptwCVsA@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest: Fix npcm7xx_timer-test.c flaky test
To: Thomas Huth <thuth@redhat.com>
Cc: kfting@nuvoton.com, wuhaotsh@google.com, lvivier@redhat.com, 
 pbonzini@redhat.com, stefanha@redhat.com, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002fd4c0060674322f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=crauer@google.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

--0000000000002fd4c0060674322f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ack.  will send out v2.

On Wed, Sep 27, 2023 at 9:44=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:

> On 28/09/2023 05.45, Chris Rauer wrote:
>
> Could you please add a proper patch description how this is fixing the
> issue?
>
>   Thanks,
>    Thomas
>
>
> > Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1897
> > Signed-off-by: Chris Rauer <crauer@google.com>
> > ---
> >   tests/qtest/npcm7xx_timer-test.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/tests/qtest/npcm7xx_timer-test.c
> b/tests/qtest/npcm7xx_timer-test.c
> > index 43711049ca..58f58c2f71 100644
> > --- a/tests/qtest/npcm7xx_timer-test.c
> > +++ b/tests/qtest/npcm7xx_timer-test.c
> > @@ -465,6 +465,7 @@ static void test_periodic_interrupt(gconstpointer
> test_data)
> >       int i;
> >
> >       tim_reset(td);
> > +    clock_step_next();
> >
> >       tim_write_ticr(td, count);
> >       tim_write_tcsr(td, CEN | IE | MODE_PERIODIC | PRESCALE(ps));
>
>

--0000000000002fd4c0060674322f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ack.=C2=A0 will send out v2.</div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 27, 2023 at 9:44=
=E2=80=AFPM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On 28/09/2023 05.45, Chris Rauer wrote:<br>
<br>
Could you please add a proper patch description how this is fixing the issu=
e?<br>
<br>
=C2=A0 Thanks,<br>
=C2=A0 =C2=A0Thomas<br>
<br>
<br>
&gt; Fixes: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/1897" =
rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-=
/issues/1897</a><br>
&gt; Signed-off-by: Chris Rauer &lt;<a href=3D"mailto:crauer@google.com" ta=
rget=3D"_blank">crauer@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0tests/qtest/npcm7xx_timer-test.c | 1 +<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+)<br>
&gt; <br>
&gt; diff --git a/tests/qtest/npcm7xx_timer-test.c b/tests/qtest/npcm7xx_ti=
mer-test.c<br>
&gt; index 43711049ca..58f58c2f71 100644<br>
&gt; --- a/tests/qtest/npcm7xx_timer-test.c<br>
&gt; +++ b/tests/qtest/npcm7xx_timer-test.c<br>
&gt; @@ -465,6 +465,7 @@ static void test_periodic_interrupt(gconstpointer =
test_data)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tim_reset(td);<br>
&gt; +=C2=A0 =C2=A0 clock_step_next();<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tim_write_ticr(td, count);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tim_write_tcsr(td, CEN | IE | MODE_PERIODIC =
| PRESCALE(ps));<br>
<br>
</blockquote></div>

--0000000000002fd4c0060674322f--


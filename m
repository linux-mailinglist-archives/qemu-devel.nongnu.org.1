Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E117AB9B2
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 21:01:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjlNU-0007Cz-M1; Fri, 22 Sep 2023 14:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qjlNS-00079G-FI
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 14:59:46 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qjlNQ-00083P-Ce
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 14:59:46 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c131ddfeb8so34154071fa.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 11:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695409181; x=1696013981;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/yCwQGcoJ7dLmP41+h0F+5WelwzapK0Sqj9o7479ZqA=;
 b=HVK1hB0zXMlvRtHW0+U2J5bz3k9cWc4vGuTm181WCD2O7WKqE3yEclvZvLB7ETdgxI
 3PPueWgMVnTr7UOK/yvuiyYrozy3E7NGIfyOKCtj4cz9jRv9F1GiTPzH3d8GSP6wYHy5
 H8N/+kguf1ualwtTAF6c4IcNTKk95kE4BQa4ZTyF+zEXxY9EK1V3UdX//55cKMO3vITl
 2f1YwzYRjkFvmqRCCtZwFv+jVzspiLqch5TcIGzqiE3oPir+Xaqg5IJ0m4CQIOjk0IX3
 cdm8U1NdLl+hTCr/Gel4oWgxwg2J0WO1u3/JAWaRn2OyI8i2gpB2DpWDz05kR4K5rIjC
 sSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695409181; x=1696013981;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/yCwQGcoJ7dLmP41+h0F+5WelwzapK0Sqj9o7479ZqA=;
 b=XytE0ax6Ou+OxkHNAu7Y3aGEoWvGJtfabTbMKzslXZ1hF13Uoqde8Hv5rTKyvot8Cu
 p3bHaG6q8FGn37aFe5DAq+Yu6eBOoxPEO9PXsvDJgdirqXlxN32wQMnBCn20vInXt56/
 jLWL9zmp8L3w43Al3yTvpx0x0i/kwOSLbESHfsfCuQHKSqsUd5JSGiA+ZRsd5u3wuFY5
 i2B+97wbNAcWbXY8xjMUD5cLRtTafFkQEN0ocC8ug/dxcD+7STvkpQ/ti/D7BaymHWr7
 /Es7Hk/s2rnyxwZ5+hW2AFSIVDUDzm/NK6yNZMi1bRN7zpHWZcpFf3Tg/dphOzu3n5Dw
 B7Sg==
X-Gm-Message-State: AOJu0YwkdDROecVRmN83ANzIKNS+QtvFCKAUHVcTFXokYBBXK8OEtxLN
 8tTBNOYinYhNiteihi0BhhIaXEM4Xvv7hGyikFTpBg==
X-Google-Smtp-Source: AGHT+IHSrKXYZ0GJw0MNB2cq8QghdK7OL2E6RN+wBXFiIZbYaKRNJPrI3DvXteknRE/tLM4AcyN1u5lUczWQMUDVxo4=
X-Received: by 2002:ac2:5973:0:b0:502:fe11:a68f with SMTP id
 h19-20020ac25973000000b00502fe11a68fmr310845lfp.28.1695409181181; Fri, 22 Sep
 2023 11:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <87r0mqlf9x.fsf@pond.sub.org>
 <f7fca6b0-ed28-8f72-e960-f73f2bc8fcbe@gmail.com>
 <CAFEAcA9Mi0rwUo5x0ejQdvosokALc5XFT2oLqgHuaXLZWNom0w@mail.gmail.com>
In-Reply-To: <CAFEAcA9Mi0rwUo5x0ejQdvosokALc5XFT2oLqgHuaXLZWNom0w@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 22 Sep 2023 12:59:29 -0600
Message-ID: <CANCZdfpKyAf+pSwv-A7JeDFF0+Q4jiV_Dmg=SGJG_+w-68LzRw@mail.gmail.com>
Subject: Re: Help wanted for enabling -Wshadow=local
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 Alberto Garcia <berto@igalia.com>, Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jeffery <andrew@aj.id.au>, Ani Sinha <anisinha@redhat.com>,
 Brian Cain <bcain@quicinc.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 "Daniel P. Berrange" <berrange@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, 
 Eduardo Habkost <eduardo@habkost.net>, Eric Auger <eric.auger@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fan Ni <fan.ni@samsung.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Joel Stanley <joel@jms.id.au>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Laurent Vivier <laurent@vivier.eu>, 
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Thomas Huth <thuth@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000fe5ff80605f735f7"
Received-SPF: none client-ip=2a00:1450:4864:20::233;
 envelope-from=wlosh@bsdimp.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000fe5ff80605f735f7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 11:49=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org>
wrote:

> On Fri, 22 Sept 2023 at 18:43, Daniel Henrique Barboza
> <danielhb413@gmail.com> wrote:
> > Can you publish your branch with the current -Wshadow=3Dlocal patches i=
n
> > gitlab/github? I'm hitting (and fixing) a lot of errors that aren't
> listed
> > here, meaning they're either fixed already in your local branch or need=
s
> to
> > be fixed.
>
> Markus sent an email with the git branch, but it doesn't seem to have
> reached the list, perhaps because it also included a 10,000 line
> build log and probably hit the length limit... Anyway, to quote
> him from that email (which I got because of a direct CC):
>
> > Pushed to https://repo.or.cz/qemu/armbru.git branch shadow-next.  I'll
> > keep collecting shadow patches there, and I'll rebase as needed.
>

I have 3 changes for bsd-user. Two are trivial, hardly worth commenting on.

The third one, though, makes me ask the question: When should we pass in
cpu_env to functions and when should we use the global value?

I have a lot of changes that look like:

-static inline abi_long do_freebsd_thr_exit(CPUArchState *cpu_env,
+static inline abi_long do_freebsd_thr_exit(CPUArchState *env,
         abi_ulong tid_addr)
 {
-    CPUState *cpu =3D env_cpu(cpu_env);
+    CPUState *cpu =3D env_cpu(env);
     TaskState *ts;
...
<other cases of cpu_env -> env>

Should I just drop the arg, or do the arg rename? Or "Gee, Warner, that
really depends since it's context sensitive" in which case I'll just post a
review to the list.

Warner

--000000000000fe5ff80605f735f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 22, 2023 at 11:49=E2=80=
=AFAM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.m=
aydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Fri, 22 Sept 2023 at 18:43, Daniel Henrique Barboza<br>
&lt;<a href=3D"mailto:danielhb413@gmail.com" target=3D"_blank">danielhb413@=
gmail.com</a>&gt; wrote:<br>
&gt; Can you publish your branch with the current -Wshadow=3Dlocal patches =
in<br>
&gt; gitlab/github? I&#39;m hitting (and fixing) a lot of errors that aren&=
#39;t listed<br>
&gt; here, meaning they&#39;re either fixed already in your local branch or=
 needs to<br>
&gt; be fixed.<br>
<br>
Markus sent an email with the git branch, but it doesn&#39;t seem to have<b=
r>
reached the list, perhaps because it also included a 10,000 line<br>
build log and probably hit the length limit... Anyway, to quote<br>
him from that email (which I got because of a direct CC):<br>
<br>
&gt; Pushed to <a href=3D"https://repo.or.cz/qemu/armbru.git" rel=3D"norefe=
rrer" target=3D"_blank">https://repo.or.cz/qemu/armbru.git</a> branch shado=
w-next.=C2=A0 I&#39;ll<br>
&gt; keep collecting shadow patches there, and I&#39;ll rebase as needed.<b=
r></blockquote><div><br></div><div>I have 3 changes for bsd-user. Two are t=
rivial, hardly worth commenting on.</div><div><br></div><div>The third one,=
 though, makes me ask the question: When should we pass in cpu_env to funct=
ions and when should we use the global value?</div><div><br></div><div>I ha=
ve a lot of changes that look like:</div><div><br></div>-static inline abi_=
long do_freebsd_thr_exit(CPUArchState *cpu_env,<br>+static inline abi_long =
do_freebsd_thr_exit(CPUArchState *env,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0abi_ulong tid_addr)<br>=C2=A0{<br>- =C2=A0 =C2=A0CPUState *cpu =3D env_c=
pu(cpu_env);<br>+ =C2=A0 =C2=A0CPUState *cpu =3D env_cpu(env);<br>=C2=A0 =
=C2=A0 =C2=A0TaskState *ts;<br><div>...<br></div><div>&lt;other cases of cp=
u_env -&gt; env&gt;</div><div><br></div><div>Should I just drop the arg, or=
 do the arg rename? Or &quot;Gee, Warner, that really depends since it&#39;=
s context sensitive&quot; in which case I&#39;ll just post a review to the =
list.</div><div><br></div><div>Warner</div></div></div>

--000000000000fe5ff80605f735f7--


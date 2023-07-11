Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D20274F813
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 20:39:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJIFZ-0001Es-48; Tue, 11 Jul 2023 14:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qJIFW-0001EF-PQ
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 14:38:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qJIFT-0005oH-B8
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 14:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689100684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uyAVL2i+oeGxGW7ieNr7kP2YHipSWkB0QBvZwgtnGus=;
 b=I0xw5l3RUFISS9Ii1hFxPdIlHRgMcvsrsomPV+hqVscYLr1hDlKzT4OvW86Drh3oE/q28J
 WjbljHNXAAPQ50W1hRIGodfsQNCKv+OEoRbPd2+Z0ACC3J2a6Erfvw/YOfmTNcP4Gu46xG
 dw6pdH3A9r1iQ1SwKs5MedCY7n9vyGU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-JpMBKeKWPrGHFtEVMIOuXg-1; Tue, 11 Jul 2023 14:38:03 -0400
X-MC-Unique: JpMBKeKWPrGHFtEVMIOuXg-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1b8c8bd3f7dso61530585ad.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 11:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689100682; x=1691692682;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uyAVL2i+oeGxGW7ieNr7kP2YHipSWkB0QBvZwgtnGus=;
 b=RZBdLTwPZJQK/wMscpHbvGuciRJmcyB3z8uOkSFHXBzE4kyxiHFyj+XGGKcVSlooOI
 4ar8s23ipcW8gAsN3kZLYeDXH34HtDIMwpd4NGG/kMXZ0z3tcz7LQP3zNEYrFLL1M3aS
 eLKd/XAnnHHhh1eqQaSUSzITTa0I/KuLynxGf2rfu6N5Q9Axl8RI3wypUmpWTaOWeDah
 oGuSGX9Pe7gvFa2Q8mwpPnogYBplHwDRpjljZPZzxusO4hbfroqrcQy5u/304v0FJgsp
 Zb5tRlSEUAh9OgMSZiWB2xcR4DZqgTPyJlK6HoFr0I+RlJwmstS7uX5pBW1U1j9GfiRA
 nJ+A==
X-Gm-Message-State: ABy/qLYv4w2PB+euISx1z1NuW7767cnvmWTao/mNaMh+jqN9Drq8q5J+
 fEBRgR0NMBk8Tf4lFq1uqbYBldSWDh1cOYToHzgcXF9td9HR1E4Jz7fvGu13lroMQu5O9XtnqaF
 DVqdvGtzqSngngc11IT6XBduLngBD55E=
X-Received: by 2002:a05:6a20:3217:b0:12c:763b:f098 with SMTP id
 hl23-20020a056a20321700b0012c763bf098mr11583190pzc.11.1689100682053; 
 Tue, 11 Jul 2023 11:38:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHoSAlY4ARY0Fp3ZsZMKK+Q0hBUDtyX04P6LSauiEU19HwH32ASA4iG4LA7Vz0zsRZ9eZK8iSy06mYGYkIPjPc=
X-Received: by 2002:a05:6a20:3217:b0:12c:763b:f098 with SMTP id
 hl23-20020a056a20321700b0012c763bf098mr11583166pzc.11.1689100681637; Tue, 11
 Jul 2023 11:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <666fb6bf-f3dd-f0b8-877e-9e73acf31c7d@linaro.org>
 <e7590da1-4586-17d7-b036-ecbfe179e3aa@ispras.ru>
In-Reply-To: <e7590da1-4586-17d7-b036-ecbfe179e3aa@ispras.ru>
From: John Snow <jsnow@redhat.com>
Date: Tue, 11 Jul 2023 14:37:49 -0400
Message-ID: <CAFn=p-Yk9NnaWh=zkq+zTWDBpwyXLhcV6We_86K8LU_4tiL+bQ@mail.gmail.com>
Subject: Re: tests/avocado/replay_kernel: ReplayKernelNormal.test_aarch64_virt
 failing
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 QEMU Developers <qemu-devel@nongnu.org>, 
 qemu-arm <qemu-arm@nongnu.org>, Cleber Rosa <crosa@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000001e84b806003a662b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

--0000000000001e84b806003a662b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023, 12:43 AM Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
wrote:

> On 10.07.2023 20:14, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi,
> >
> > Per tests/avocado/replay_kernel.py:
> >
> >      def test_aarch64_virt(self):
> >          ...
> >          console_pattern =3D 'VFS: Cannot open root device'
> >
> > the test is succeeding, but Avocado reports an error.
>
> Does the emulator exit when error "Cannot open root device" happens?
> Therefore 'quit' command can't be processed in this case.
>
> >
> > I could get a verbose debug.log, so sharing it here, enjoy!
> >
> > Regards,
> >
> > Phil.
>

Yep, this is a race condition on cleanup.

The machine/qmp libraries will throw an exception if they can't exit
cleanly, which is by design to catch QEMU crashes on the exit/teardown path=
.

If the test expects the QEMU process to exit voluntarily without being
issued 'quit' via QMP, you should use vm.wait() instead of vm.shutdown().

It looks like the QMP library is getting a SHUTDOWN event for which the
reason is "guest-reset". The socket dies and the VM management code
ultimately reports that it wasn't able to shut the guest down cleanly
because it went away unexpectedly, which is true.

(Sorry the traceback is so verbose - perils of asyncio and accidentally
losing debug information means you see a bunch of traces that look almost
identical as they're handled and reported from the backend to the frontend,
then re-contextualized for each library it bubbles up through. Winds up
looking gnarly but it does give incredibly rich detail for the crash, so
thanks for uploading the log! These failures used to crash silently with no
info whatsoever.)

--js

--0000000000001e84b806003a662b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Jul 11, 2023, 12:43 AM Pavel Dovgalyuk &lt;<a =
href=3D"mailto:pavel.dovgalyuk@ispras.ru">pavel.dovgalyuk@ispras.ru</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">On 10.07.2023 20:14, Philip=
pe Mathieu-Daud=C3=A9 wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; Per tests/avocado/replay_kernel.py:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 def test_aarch64_virt(self):<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console_pattern =3D &=
#39;VFS: Cannot open root device&#39;<br>
&gt; <br>
&gt; the test is succeeding, but Avocado reports an error.<br>
<br>
Does the emulator exit when error &quot;Cannot open root device&quot; happe=
ns?<br>
Therefore &#39;quit&#39; command can&#39;t be processed in this case.<br>
<br>
&gt; <br>
&gt; I could get a verbose debug.log, so sharing it here, enjoy!<br>
&gt; <br>
&gt; Regards,<br>
&gt; <br>
&gt; Phil.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Yep, this is a race condition on cleanup.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">The machine/qmp libraries will throw an excepti=
on if they can&#39;t exit cleanly, which is by design to catch QEMU crashes=
 on the exit/teardown path.</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">If the test expects the QEMU process to exit voluntarily without being =
issued &#39;quit&#39; via QMP, you should use vm.wait() instead of vm.shutd=
own().</div><div dir=3D"auto"><br></div><div dir=3D"auto">It looks like the=
 QMP library is getting a SHUTDOWN event for which the reason is &quot;gues=
t-reset&quot;. The socket dies and the VM management code ultimately report=
s that it wasn&#39;t able to shut the guest down cleanly because it went aw=
ay unexpectedly, which is true.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">(Sorry the traceback is so verbose - perils of asyncio and accide=
ntally losing debug information means you see a bunch of traces that look a=
lmost identical as they&#39;re handled and reported from the backend to the=
 frontend, then re-contextualized for each library it bubbles up through. W=
inds up looking gnarly but it does give incredibly rich detail for the cras=
h, so thanks for uploading the log! These failures used to crash silently w=
ith no info whatsoever.)</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>--js</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000001e84b806003a662b--



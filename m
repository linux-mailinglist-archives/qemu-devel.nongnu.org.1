Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0690D7B1E22
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:25:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlr0B-0007iC-LZ; Thu, 28 Sep 2023 09:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qlqzg-0007YE-Aa
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qlqzd-0000dn-Eg
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6NUpsLxHMUFjC7UbYy80gvV7HwccDyX3suYmijKob7A=;
 b=O4K0NOqGZ9sEI5TEJrjUJjGGVQBFgTpwBLp6VDXMq1UCDaTJUyTEiNRrkss5+KhxkL9hKP
 FVJk4tp4KKqGUmlXN01A8iWbu3qYeRzXaOTrB2YM8ljf4NyzXuk2Ouc9/3B+g9fmUO8Mod
 knN9iDSu4VtDqyLSta+wRb7BCyW0Qfo=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-v2WMtWG6Me-sI8O-aIV0Ng-1; Thu, 28 Sep 2023 09:23:46 -0400
X-MC-Unique: v2WMtWG6Me-sI8O-aIV0Ng-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-692bf04c548so11300807b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 06:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695907424; x=1696512224;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6NUpsLxHMUFjC7UbYy80gvV7HwccDyX3suYmijKob7A=;
 b=kqYw6gF/e12KQGjAOVYmZWsrjDZYFOZNVnq/4LyOCqLYoyNSpHoFe0bW010PacvkUm
 N3zVQvp8yW2/wrhL9jqi27bu/Qa39/ulPFG40Zw0jN4ZrP0FPve7WvDq88jI15Rav9qd
 FICmwnLyr5zzLbT7aqRBhfD+JVysQOWgLH1uLNqizqkZJwI/qAL2HA7gZmFcauVEAmW4
 GYYFcCJmHHWAlat1V7I9jTsBV2/791LDKmc9P7KmjVkC/4ADhQUIWfVCqpiyvDVJjLIN
 Crr9Z+H3jpRDPXBG+09JXbY+CEu9OTyhe+FWkb6pY7KFheID1NnIzgJwB2OZzEoN849A
 pylA==
X-Gm-Message-State: AOJu0Yx+DzA4WQZ+78NDRzpQFvmQvKjDZHu+jqzD3Ve3DwSMcqtVGHGO
 KuyrlOHx9Kou3wxPouwvcvs1y9FAVTBICU9bp5C1sInSjo9kDs30BOQrq5ctDdnM1wVsXh1EAAf
 atHm5q6EzHWAUv+vcUPuNyAPA6ks4LCw=
X-Received: by 2002:a05:6a20:9701:b0:15d:bd4b:c9e5 with SMTP id
 hr1-20020a056a20970100b0015dbd4bc9e5mr971869pzc.61.1695907424602; 
 Thu, 28 Sep 2023 06:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp2nw/rO6C+aC0oga6H8deNB6Nb7JdC9eNS5nrS9EOYqohDBm9o+4CyiTGo9Yw/0u7635Vaf8cl5wyU+zEY2c=
X-Received: by 2002:a05:6a20:9701:b0:15d:bd4b:c9e5 with SMTP id
 hr1-20020a056a20970100b0015dbd4bc9e5mr971839pzc.61.1695907424246; Thu, 28 Sep
 2023 06:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230928044943.849073-1-jsnow@redhat.com>
 <ZRU1YoV0ndInO5Wb@redhat.com>
In-Reply-To: <ZRU1YoV0ndInO5Wb@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 28 Sep 2023 09:23:33 -0400
Message-ID: <CAFn=p-YOqXV0rO80=diTmtype75YtFrE99tkZ6gs_giofukcyQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] python/machine: use socketpair() for console socket
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, 
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Ani Sinha <anisinha@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000098371806066b37fc"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000098371806066b37fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023, 4:12 AM Daniel P. Berrang=C3=A9 <berrange@redhat.com>
wrote:

> On Thu, Sep 28, 2023 at 12:49:37AM -0400, John Snow wrote:
> > Like we did for the QMP socket, use socketpair() for the console socket
> > so that hopefully there isn't a race condition during early boot where
> > data might get dropped on the floor.
> >
> > May or may not help with various race conditions where early console
> > output is not showing up in the logs and/or potentially being missed by
> > wait_for_console_pattern.
> >
> > V3:
> >   - Rebased.
>
> V3 has R-B on every single patch already. Should this
> just have been a PULL instead ?
>

I guess just erring on the side of caution with some fresh patches for
patchew since it had been a while since V2 and I did have to rebase this.

I'll send the PR soon if there's no objections.


> >
> > V2:
> >   - Fixed some Socket ownership/garbage collection problems
> >   - Fixed callers of now-dropped VM arguments/properties
> >   - added a dedicated sock_fd arg to ConsoleSocket()
> >   - now using socketpair() for qtest console, too.
> >   - dropped sock_dir arg from *all* machine.py classes
> >   - Tested quite a bit more thoroughly ...
> >
> > CI: https://gitlab.com/jsnow/qemu/-/pipelines/1019123030
> >
> > John Snow (6):
> >   python/machine: move socket setup out of _base_args property
> >   python/machine: close sock_pair in cleanup path
> >   python/console_socket: accept existing FD in initializer
> >   python/machine: use socketpair() for console connections
> >   python/machine: use socketpair() for qtest connection
> >   python/machine: remove unused sock_dir argument
> >
> >  python/qemu/machine/console_socket.py      | 29 ++++++++---
> >  python/qemu/machine/machine.py             | 58 +++++++++++++---------
> >  python/qemu/machine/qtest.py               | 54 +++++++++++++++-----
> >  tests/avocado/acpi-bits.py                 |  5 +-
> >  tests/avocado/avocado_qemu/__init__.py     |  2 +-
> >  tests/avocado/machine_aspeed.py            |  5 +-
> >  tests/qemu-iotests/iotests.py              |  2 +-
> >  tests/qemu-iotests/tests/copy-before-write |  3 +-
> >  8 files changed, 104 insertions(+), 54 deletions(-)
> >
> > --
> > 2.41.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--00000000000098371806066b37fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Sep 28, 2023, 4:12 AM Daniel P. Berrang=C3=A9 =
&lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">On Thu, Sep 28, 2023 at 12:49:37=
AM -0400, John Snow wrote:<br>
&gt; Like we did for the QMP socket, use socketpair() for the console socke=
t<br>
&gt; so that hopefully there isn&#39;t a race condition during early boot w=
here<br>
&gt; data might get dropped on the floor.<br>
&gt; <br>
&gt; May or may not help with various race conditions where early console<b=
r>
&gt; output is not showing up in the logs and/or potentially being missed b=
y<br>
&gt; wait_for_console_pattern.<br>
&gt; <br>
&gt; V3:<br>
&gt;=C2=A0 =C2=A0- Rebased.<br>
<br>
V3 has R-B on every single patch already. Should this<br>
just have been a PULL instead ?<br></blockquote></div></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">I guess just erring on the side of caution w=
ith some fresh patches for patchew since it had been a while since V2 and I=
 did have to rebase this.</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">I&#39;ll send the PR soon if there&#39;s no objections.=C2=A0</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">
<br>
&gt; <br>
&gt; V2:<br>
&gt;=C2=A0 =C2=A0- Fixed some Socket ownership/garbage collection problems<=
br>
&gt;=C2=A0 =C2=A0- Fixed callers of now-dropped VM arguments/properties<br>
&gt;=C2=A0 =C2=A0- added a dedicated sock_fd arg to ConsoleSocket()<br>
&gt;=C2=A0 =C2=A0- now using socketpair() for qtest console, too.<br>
&gt;=C2=A0 =C2=A0- dropped sock_dir arg from *all* machine.py classes<br>
&gt;=C2=A0 =C2=A0- Tested quite a bit more thoroughly ...<br>
&gt; <br>
&gt; CI: <a href=3D"https://gitlab.com/jsnow/qemu/-/pipelines/1019123030" r=
el=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/jsnow/qem=
u/-/pipelines/1019123030</a><br>
&gt; <br>
&gt; John Snow (6):<br>
&gt;=C2=A0 =C2=A0python/machine: move socket setup out of _base_args proper=
ty<br>
&gt;=C2=A0 =C2=A0python/machine: close sock_pair in cleanup path<br>
&gt;=C2=A0 =C2=A0python/console_socket: accept existing FD in initializer<b=
r>
&gt;=C2=A0 =C2=A0python/machine: use socketpair() for console connections<b=
r>
&gt;=C2=A0 =C2=A0python/machine: use socketpair() for qtest connection<br>
&gt;=C2=A0 =C2=A0python/machine: remove unused sock_dir argument<br>
&gt; <br>
&gt;=C2=A0 python/qemu/machine/console_socket.py=C2=A0 =C2=A0 =C2=A0 | 29 +=
+++++++---<br>
&gt;=C2=A0 python/qemu/machine/machine.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| 58 +++++++++++++---------<br>
&gt;=C2=A0 python/qemu/machine/qtest.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 54 +++++++++++++++-----<br>
&gt;=C2=A0 tests/avocado/acpi-bits.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +-<br>
&gt;=C2=A0 tests/avocado/avocado_qemu/__init__.py=C2=A0 =C2=A0 =C2=A0|=C2=
=A0 2 +-<br>
&gt;=C2=A0 tests/avocado/machine_aspeed.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 5 +-<br>
&gt;=C2=A0 tests/qemu-iotests/iotests.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 tests/qemu-iotests/tests/copy-before-write |=C2=A0 3 +-<br>
&gt;=C2=A0 8 files changed, 104 insertions(+), 54 deletions(-)<br>
&gt; <br>
&gt; -- <br>
&gt; 2.41.0<br>
&gt; <br>
&gt; <br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a h=
ref=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://fstop138.berrange=
.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0=
 <a href=3D"https://www.instagram.com/dberrange" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div></div>

--00000000000098371806066b37fc--



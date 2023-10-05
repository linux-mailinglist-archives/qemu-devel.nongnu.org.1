Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 169C97BA1D5
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 17:00:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoPpT-0003Jv-SJ; Thu, 05 Oct 2023 10:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qoPpQ-0003IZ-JI
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 10:59:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qoPp8-000560-F7
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 10:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696517973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YcKj9U7YI0xDriXE/1H6YzU/nCPF39Nq45iBb4rGlbI=;
 b=G4DMzcpjx1vc4XulcauVQAdYx0uJB/d/sKalwBtHdlWg7DBUk0mA/HlZ8M3bibBAR++4c8
 k7hYO1p37LQ0zekTNdcXQStIO2Iul+PLnKcyk3A5EfMLQBt48rN2b1gAXpWAflAWjFl9mU
 Kg/FXBfIj38ZBTpp6ufhS/DUKMTaex8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-uGBm_BfJP8OMWqxgL6EIjQ-1; Thu, 05 Oct 2023 10:59:31 -0400
X-MC-Unique: uGBm_BfJP8OMWqxgL6EIjQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-27903b68503so941254a91.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 07:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696517971; x=1697122771;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YcKj9U7YI0xDriXE/1H6YzU/nCPF39Nq45iBb4rGlbI=;
 b=kQPGF8E5/pITJFDqP+35pOqOJoxUIGts1/kpfRpcF95URc/GTOULBTJTiIc0MxP/ri
 gBPfEtKxd6UK19hNpAX4EhGyfERBkI/Ra1/XJsQWyRsd6mAKh1/pHLjCyM4JrWNQICjH
 CIsMR58Cd7F0AvEkOpLTHu4QxHgVRwLAd6DAGcEMerHxQnpo8e4vOhZdmNIx2L5WZpyY
 3fRvqjO9DrDoXiZOa/8TEaMF7TaONa24MiSPoPU7h36hwJx9eJdDRSv5tKtc3QdHqCqZ
 0DLNCPZgiBTmWONibYWgtEqmRsf6uOwZ3xxNBfvhdfrUskKPIzoi2QYZ9nPpD89ZqKyE
 k91g==
X-Gm-Message-State: AOJu0YzM9m5EObzwsKnVKPeTt90wCs9mxOiRTTjRQdCpQsCc5Ipp1xID
 7FDUSDZH60Dyf7HOul9sp7tSXqFt20k2+7GyV5Zkkqi9pQoWT0LpbgR37GBIdjajaoqxgic3/tK
 Zaew2lzbrjnZGbFgBtmwJmF2GaMmlt0c=
X-Received: by 2002:a17:90b:19d0:b0:268:4c01:eb56 with SMTP id
 nm16-20020a17090b19d000b002684c01eb56mr5091645pjb.2.1696517970831; 
 Thu, 05 Oct 2023 07:59:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX1n2bU8IfFkTzC3c50KOPeq1qqZARC0JDHQXEpIhigH4mkD7oUoA3tpJYHxslXK7Bb6v8l7/MbTXJgaKV0wM=
X-Received: by 2002:a17:90b:19d0:b0:268:4c01:eb56 with SMTP id
 nm16-20020a17090b19d000b002684c01eb56mr5091624pjb.2.1696517970544; Thu, 05
 Oct 2023 07:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231004194613.2900323-1-jsnow@redhat.com>
 <3984cd72-931b-fa9b-e7ac-3d60487ac442@linaro.org>
 <CAJSP0QUYd58Q03Ugm2ULh=aiA8jUni2XM0aZAvxE1CoYbaW5cQ@mail.gmail.com>
In-Reply-To: <CAJSP0QUYd58Q03Ugm2ULh=aiA8jUni2XM0aZAvxE1CoYbaW5cQ@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 5 Oct 2023 10:59:18 -0400
Message-ID: <CAFn=p-Z9L54hV5Wx9N7ZGufRzvLrSAna4xnXxDO1VbA-MvVMvQ@mail.gmail.com>
Subject: Re: [PULL 0/9] Python patches
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, 
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 Qemu-block <qemu-block@nongnu.org>, Beraldo Leal <bleal@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <v.sementsov-og@mail.ru>,
 Thomas Huth <thuth@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fd61660606f95ea1"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

--000000000000fd61660606f95ea1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 5, 2023, 9:00 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Thu, 5 Oct 2023 at 00:49, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg>
> wrote:
> >
> > Hi John,
> >
> > On 4/10/23 21:46, John Snow wrote:
> > > The following changes since commit
> da1034094d375afe9e3d8ec8980550ea0f06f7e0:
> > >
> > >    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into
> staging (2023-10-03 07:43:44 -0400)
> > >
> > > are available in the Git repository at:
> > >
> > >    https://gitlab.com/jsnow/qemu.git tags/python-pull-request
> > >
> > > for you to fetch changes up to
> 4d7a663cbe8343e884b88e44bd88d37dd0a470e5:
> > >
> > >    Python: test Python 3.12 (2023-10-04 15:19:00 -0400)
> > >
> > > ----------------------------------------------------------------
> > > Python pullreq
> > >
> > > Buffering improvements for qemu machine, minor changes to support the
> > > newly released Python 3.12
> > >
> > > ----------------------------------------------------------------
> > >
> > > John Snow (9):
> > >    Python/iotests: Add type hint for nbd module
> > >    python/machine: move socket setup out of _base_args property
> > >    python/machine: close sock_pair in cleanup path
> > >    python/console_socket: accept existing FD in initializer
> > >    python/machine: use socketpair() for console connections
> > >    python/machine: use socketpair() for qtest connection
> > >    python/machine: remove unused sock_dir argument
> > >    python/qmp: remove Server.wait_closed() call for Python 3.12
> > >    Python: test Python 3.12
> >
> > Is that a pull request or a patch series to be reviewed?
>
> Strange, some of the patches have Reviewed-by tags but others do not.
> I could not find a "Add type hint for nbd module" patch on the mailing
> list before this pull request, so I guess it hasn't been reviewed.
>
> I'll hold off from merging this series for now.
>
> John: Please make sure all patches have been on the mailing list for
> review before sending a pull request.
>
> Stefan
>

Okey Dokey.

--js

--000000000000fd61660606f95ea1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Oct 5, 2023, 9:00 AM Stefan Hajnoczi &lt;<a hr=
ef=3D"mailto:stefanha@gmail.com">stefanha@gmail.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">On Thu, 5 Oct 2023 at 00:49, Philippe Mathi=
eu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank" re=
l=3D"noreferrer">philmd@linaro.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi John,<br>
&gt;<br>
&gt; On 4/10/23 21:46, John Snow wrote:<br>
&gt; &gt; The following changes since commit da1034094d375afe9e3d8ec8980550=
ea0f06f7e0:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 Merge tag &#39;for-upstream&#39; of <a href=3D"https=
://gitlab.com/bonzini/qemu" rel=3D"noreferrer noreferrer" target=3D"_blank"=
>https://gitlab.com/bonzini/qemu</a> into staging (2023-10-03 07:43:44 -040=
0)<br>
&gt; &gt;<br>
&gt; &gt; are available in the Git repository at:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 <a href=3D"https://gitlab.com/jsnow/qemu.git" rel=3D=
"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/jsnow/qemu.git=
</a> tags/python-pull-request<br>
&gt; &gt;<br>
&gt; &gt; for you to fetch changes up to 4d7a663cbe8343e884b88e44bd88d37dd0=
a470e5:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 Python: test Python 3.12 (2023-10-04 15:19:00 -0400)=
<br>
&gt; &gt;<br>
&gt; &gt; ----------------------------------------------------------------<=
br>
&gt; &gt; Python pullreq<br>
&gt; &gt;<br>
&gt; &gt; Buffering improvements for qemu machine, minor changes to support=
 the<br>
&gt; &gt; newly released Python 3.12<br>
&gt; &gt;<br>
&gt; &gt; ----------------------------------------------------------------<=
br>
&gt; &gt;<br>
&gt; &gt; John Snow (9):<br>
&gt; &gt;=C2=A0 =C2=A0 Python/iotests: Add type hint for nbd module<br>
&gt; &gt;=C2=A0 =C2=A0 python/machine: move socket setup out of _base_args =
property<br>
&gt; &gt;=C2=A0 =C2=A0 python/machine: close sock_pair in cleanup path<br>
&gt; &gt;=C2=A0 =C2=A0 python/console_socket: accept existing FD in initial=
izer<br>
&gt; &gt;=C2=A0 =C2=A0 python/machine: use socketpair() for console connect=
ions<br>
&gt; &gt;=C2=A0 =C2=A0 python/machine: use socketpair() for qtest connectio=
n<br>
&gt; &gt;=C2=A0 =C2=A0 python/machine: remove unused sock_dir argument<br>
&gt; &gt;=C2=A0 =C2=A0 python/qmp: remove Server.wait_closed() call for Pyt=
hon 3.12<br>
&gt; &gt;=C2=A0 =C2=A0 Python: test Python 3.12<br>
&gt;<br>
&gt; Is that a pull request or a patch series to be reviewed?<br>
<br>
Strange, some of the patches have Reviewed-by tags but others do not.<br>
I could not find a &quot;Add type hint for nbd module&quot; patch on the ma=
iling<br>
list before this pull request, so I guess it hasn&#39;t been reviewed.<br>
<br>
I&#39;ll hold off from merging this series for now.<br>
<br>
John: Please make sure all patches have been on the mailing list for<br>
review before sending a pull request.<br>
<br>
Stefan<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Okey Dokey.</div><div dir=3D"auto"><br></div><div dir=3D"auto">--js</=
div></div>

--000000000000fd61660606f95ea1--



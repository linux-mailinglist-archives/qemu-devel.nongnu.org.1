Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FB770DF8B
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:42:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1TCN-0004Ho-NN; Tue, 23 May 2023 10:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q1TCL-0004EV-PP
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:41:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q1TCI-0007Up-Q8
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684852869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eoVSCYLvX/niD9VEyeXYZeucnv3QQ9euIX0bVgRHy5U=;
 b=HupruXO6cYiweL/IsSixk8UgMd5AWqYyTGuFQYWMqqUpYSWV/ZmUhn2fAAuzT7wqKVVQa2
 Jr99VYOj20S6Wdu2C3NPFEckqNrNuy5GMM5KpvG/g/vtnhStRnz32ub5rc1H/3ipDPQ0ij
 p4paclCm5XJkc+HKUz2Ng9m//WKx/8I=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-cFslAIOKNAWs-0UtyXX6LA-1; Tue, 23 May 2023 10:41:08 -0400
X-MC-Unique: cFslAIOKNAWs-0UtyXX6LA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-25332df5afaso4153292a91.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 07:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684852866; x=1687444866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eoVSCYLvX/niD9VEyeXYZeucnv3QQ9euIX0bVgRHy5U=;
 b=bZDXEhgsSoq0OsaLwieGUyu9J+dzX6AwemHMgNoR1/MTTHQvmpQbTItgSdydOIaR2u
 VuLjKuAB4z6lQZkpnRf6AL1+JLB4nCIasQaK7bXVVM/+suD5gK+/8k9C0upAeF9Vymwj
 XZzcebYszGaAcDBcRw1kWFwnsbj2Wm05sN5UP+30EZVdeGttkld499G3h+t/qIgA401N
 lwgwJQ4ayzYgrGUeBwPCPV9a2A+j090zytnPUPKNbfXSpC0U2facv9ikkSv4p+zDVApF
 PrJZ0M6dSxMHu05UFVSeZjJnI4LfiBlllCEimELd5B2unqkkdGh9sG2FkViTDWdqPvwF
 YFgg==
X-Gm-Message-State: AC+VfDwNGOR6EFhnVRpfUVdvySNcDmNN7GmhlBJEAqFIs+Q2lnjTA7sI
 eoEXTZURzlwg2bVv9X8L4q2P+lipPDi2RoLYtJDznOSgYPIKDyH0HargZvA21UHO+NZjP1X7qeN
 XaWAin+UmZmcOJpNI2noxkq7wlr7itl9J/tS/FhY=
X-Received: by 2002:a17:90a:17ec:b0:253:45e5:af5c with SMTP id
 q99-20020a17090a17ec00b0025345e5af5cmr13951049pja.32.1684852866583; 
 Tue, 23 May 2023 07:41:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ79mXoLvuZ5NabkBIAasdVpgJ8Lj/TNatDoZfD8LSZhtU16hv/H66VoSxIODRx47stwqV9yVNQ9Ot912F4BUas=
X-Received: by 2002:a17:90a:17ec:b0:253:45e5:af5c with SMTP id
 q99-20020a17090a17ec00b0025345e5af5cmr13951041pja.32.1684852866363; Tue, 23
 May 2023 07:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230517163406.2593480-1-jsnow@redhat.com>
In-Reply-To: <20230517163406.2593480-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 23 May 2023 10:40:55 -0400
Message-ID: <CAFn=p-a42EPq9LzQ+No3crhxCchUDxQH7eYcAEmtiq0mXz7HnA@mail.gmail.com>
Subject: Re: [PATCH 0/5] python: backport socket changes from python-qemu-qmp
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Beraldo Leal <bleal@redhat.com>, 
 Daniel Berrange <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000994b9f05fc5d60f8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000994b9f05fc5d60f8
Content-Type: text/plain; charset="UTF-8"

On Wed, May 17, 2023, 12:34 PM John Snow <jsnow@redhat.com> wrote:

> This is a small patchset designed to backport the changes made to the
> qemu.qmp code to utilize pre-existing sockets. This contains some small
> changes to machine.py to match the new API. This is necessary to do
> before dropping qemu.qmp from qemu.git so we can utilize the future
> 0.0.3 version of qemu.qmp.
>
> (This should also fix the bug where the buffering limit was not being
> applied properly


^to

connections utilizing pre-existing sockets.)
>
> John Snow (5):
>   python/qmp: allow sockets to be passed to connect()
>   python/qmp/legacy: allow using sockets for connect()
>   python/machine: use connect-based interface for existing sockets
>   python/qmp/legacy: remove open_with_socket() calls
>   Revert "python/qmp/protocol: add open_with_socket()"
>
>  python/qemu/machine/machine.py | 17 +++++++------
>  python/qemu/qmp/legacy.py      | 26 +++++++++-----------
>  python/qemu/qmp/protocol.py    | 45 +++++++++++++++-------------------
>  3 files changed, 41 insertions(+), 47 deletions(-)
>
> --
> 2.40.0
>

ping - I'll send a PR for this on Friday if no objections. It just
synchronizes the two codebases ahead of my plan to finally delete the
duplication once and for all.

(and *that* series will need some good review and attention.)

--js

>

--000000000000994b9f05fc5d60f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, May 17, 2023, 12:34 PM John Snow &lt;<a href=
=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">This is a small patchset designed to backport the=
 changes made to the<br>
qemu.qmp code to utilize pre-existing sockets. This contains some small<br>
changes to machine.py to match the new API. This is necessary to do<br>
before dropping qemu.qmp from qemu.git so we can utilize the future<br>
0.0.3 version of qemu.qmp.<br>
<br>
(This should also fix the bug where the buffering limit was not being<br>
applied properly </blockquote></div></div><div dir=3D"auto"><br></div><div =
dir=3D"auto">^to</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cl=
ass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">connections utilizing pr=
e-existing sockets.)<br>
<br>
John Snow (5):<br>
=C2=A0 python/qmp: allow sockets to be passed to connect()<br>
=C2=A0 python/qmp/legacy: allow using sockets for connect()<br>
=C2=A0 python/machine: use connect-based interface for existing sockets<br>
=C2=A0 python/qmp/legacy: remove open_with_socket() calls<br>
=C2=A0 Revert &quot;python/qmp/protocol: add open_with_socket()&quot;<br>
<br>
=C2=A0python/qemu/machine/machine.py | 17 +++++++------<br>
=C2=A0python/qemu/qmp/legacy.py=C2=A0 =C2=A0 =C2=A0 | 26 +++++++++---------=
--<br>
=C2=A0python/qemu/qmp/protocol.py=C2=A0 =C2=A0 | 45 +++++++++++++++--------=
-----------<br>
=C2=A03 files changed, 41 insertions(+), 47 deletions(-)<br>
<br>
-- <br>
2.40.0<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">ping - I&#39;ll send a PR for this on Friday if no objections. It jus=
t synchronizes the two codebases ahead of my plan to finally delete the dup=
lication once and for all.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">(and *that* series will need some good review and attention.)</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">--js</div><div dir=3D"auto"><div c=
lass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000994b9f05fc5d60f8--



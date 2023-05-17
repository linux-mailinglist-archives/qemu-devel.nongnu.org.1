Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EA070706F
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 20:08:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLZG-0003Sb-0c; Wed, 17 May 2023 14:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzLZC-0003S9-Ci
 for qemu-devel@nongnu.org; Wed, 17 May 2023 14:08:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzLZ7-0002WO-Sw
 for qemu-devel@nongnu.org; Wed, 17 May 2023 14:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684346876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+UK5D+don4v4vbjMouA2r/3qMD173xfIhGlPm5WrbE=;
 b=K36XyGyp8IDUYZQJtp/g2P61euDloBKsYBjEy9cOCCMQSSVxWILyPicdT9ySCqckhyoPKo
 RoWOnPoH8VGgvygawYyWQ94Rk2ccoaD56UOlXBV1VMaS5TW9GSqpGRME/myb5qkgapxs7p
 hRMHP0vTBs3ZvpzNl1r6xcmpuFQZWwo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-i7xd0CNpMnGlUP7xjTzpAQ-1; Wed, 17 May 2023 14:07:54 -0400
X-MC-Unique: i7xd0CNpMnGlUP7xjTzpAQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5308f5d8ac9so616285a12.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 11:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684346874; x=1686938874;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L+UK5D+don4v4vbjMouA2r/3qMD173xfIhGlPm5WrbE=;
 b=kEmtzN6Qkxr9uWFNTxPwvw7qOhdgR5kE4OSMIfYfdTIpZu8zrCjfY0EGqODMm7XA7h
 o43wLpeS194dWcjX2xgvaZhhDSiXDY0FeLe3RUTJZ9bg0RF9alZ4lP8bgbG7/2DShKCX
 Wk8aaGctDds5C/BC9as4jgAAOcjfXVn4BAsh1AhrUN9VIl4GN0mJrFdr15w76detznXz
 OhlSViS6SNk4g/3ssrpZt2dm+T17u3QnCiKKpmsGAf0Vb1SiW01+shoCOfNdARYdLGc5
 XowTVuFMNbJdjMZorwQjUxjBCZ9hvrdZbvHW5BVF56vkgOMOmoy/SNRbZ4ql/oHHCPF4
 Q4/A==
X-Gm-Message-State: AC+VfDzq0aLBUYAqfBKTUgqJJQTH/CPOuA7/JubzScHuvcQ/aHNa16WS
 s+/ARyG3HgveRF0EOO+T+JybyQQRaynEC+IExgnFENnpzXBjjjYXh/pYzbhCcP3f2kxIxruUlDJ
 UlCNNKzhQ8QjIDvJ9FS29BIBzrzYPSWk=
X-Received: by 2002:a05:6a20:2584:b0:105:94e5:f5c2 with SMTP id
 k4-20020a056a20258400b0010594e5f5c2mr18100546pzd.13.1684346873727; 
 Wed, 17 May 2023 11:07:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5HWtsWdaWIe25VjyUC258XPsRQOJrypy28kapjjUcZHIIKMyD+AbzMROTpDYPG86nfWob5Z9X/SS31oT3TK/c=
X-Received: by 2002:a05:6a20:2584:b0:105:94e5:f5c2 with SMTP id
 k4-20020a056a20258400b0010594e5f5c2mr18100522pzd.13.1684346873413; Wed, 17
 May 2023 11:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230320105404.637661-1-berrange@redhat.com>
 <00341422-35d7-7091-5be4-808e1431f113@yandex-team.ru>
 <CAFn=p-bFgZYJO5bMbAXXJkdtov5CiEC2YAx6AN_DOF0B_i+OKg@mail.gmail.com>
 <CAFn=p-bgcKVQhyU2sNHy6HoPJimAEhG_97XjsTX26AV32dXVXw@mail.gmail.com>
In-Reply-To: <CAFn=p-bgcKVQhyU2sNHy6HoPJimAEhG_97XjsTX26AV32dXVXw@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 17 May 2023 14:07:42 -0400
Message-ID: <CAFn=p-YZWd51JxpaqAMw5Sxa0hRE61gdoTUBeSsX3UQ8s_CLwg@mail.gmail.com>
Subject: Re: [PATCH] python: honour message limit when using pre-opened socket
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, May 15, 2023 at 5:14=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
> On Mon, Mar 20, 2023 at 8:27=E2=80=AFPM John Snow <jsnow@redhat.com> wrot=
e:
> >
> > On Mon, Mar 20, 2023 at 8:20=E2=80=AFAM Vladimir Sementsov-Ogievskiy
> > <vsementsov@yandex-team.ru> wrote:
> > >
> > > On 20.03.23 13:54, Daniel P. Berrang=C3=A9 wrote:
> > > > The default message recv limit in asyncio is smaller than our needs=
, so
> > > > when opening connections we override it. This was done when opening=
 a
> > > > connection using a socket address, but was missed when using a
> > > > pre-opened socket file descriptor.
> > > >
> > > > This latent bug was exposed when the QEMUMachine class was enhanced=
 to
> > > > use socketpair() when no socket address was passed by:
> > > >
> > > >    commit bd4c0ef409140bd1be393407c04005ac077d4574
> > > >    Author: Marc-Andr=C3=A9 Lureau<marcandre.lureau@redhat.com>
> > > >    Date:   Wed Jan 11 12:01:01 2023 +0400
> > > >
> > > >      python/qemu/machine: use socketpair() for QMP by default
> > > >
> > > > Signed-off-by: Daniel P. Berrang=C3=A9<berrange@redhat.com>
> > >
> > > Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > >
> > > Thanks!
> > >
> > > --
> > > Best regards,
> > > Vladimir
> > >
> >
> > Thanks x3. Will stage in both places.
> >
>
> ... Realizing I let the two codebases diverge a bit more than I had
> meant to allow, and the "open with socket" rewrite I made never got
> brought back to qemu.git, tch. I believe this bug only exists in
> qemu.git because of that. I need to backport my changes to qemu.git
> and ensure that there isn't a problem with the revised code as it
> exists in qemu.qmp.
>
> I'll have to fix that *before* I drop qemu.qmp from the qemu.git repo,
> which I am hoping will be soon after Paolo takes the new Python
> patches that create a venv during configure time.
>
> --js

OK, I've just sent two series:

(1) A MR for python-qemu-qmp here, which backports a few misc fixes
from qemu.git back over to python-qemu-qmp;
https://gitlab.com/qemu-project/python-qemu-qmp/-/merge_requests/23
This needs approval from at least one person. If you're interested in
becoming a "reviewer" there, let me know and I'll add you if you
aren't already.

(2) A patchset for qemu.git that backports the socket changes that
went into python-qemu-qmp.
https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04285.html
This should fix the bug described here in this series, and is
necessary to merge before I swap the in-tree qemu.git for a vendored
qemu.qmp package.
Review welcomed, but any changes we need will need to happen on the
python-qemu-qmp repo first.

Dropping the in-tree qemu.qmp package is going to happen after the
large series Paolo just sent a PR for,
https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04330.html
which adds a configure-time venv to the QEMU build system.

Hoping to drop qemu.qmp *this dev cycle* and release v0.0.3 for
qemu.qmp and vendor it to qemu.git as a .whl file.

Thanks,
--js



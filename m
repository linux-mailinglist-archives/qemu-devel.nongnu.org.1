Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0DEAE9500
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Jun 2025 07:01:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUeiZ-0004lI-Bw; Thu, 26 Jun 2025 01:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uUeiV-0004jO-Mg
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:00:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uUeiT-00075D-Pc
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750914003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ux55LTzZu+8r8VvC9MmnRWtiQyH3i5QT3q5f9MnpL9Q=;
 b=jS5qymLz3NvgXlMVUAdrOpS86royABUYMv2N1Clp+qw2lmaen0SY4XDkunmrVHtTfZ/8j8
 MX3gU5gF8N38bD2VpKj1zSQavQfRZm1ozc+OG1X+HUYX0H736rzIyAwE71AuLMVGoEOHOj
 V+x+2zXx3K9ThHVQ/ijx/bpJlEjZqxc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-bzK0JSyXOEeHtuAvfZED4w-1; Thu,
 26 Jun 2025 00:54:34 -0400
X-MC-Unique: bzK0JSyXOEeHtuAvfZED4w-1
X-Mimecast-MFC-AGG-ID: bzK0JSyXOEeHtuAvfZED4w_1750913670
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4886119560B2; Thu, 26 Jun 2025 04:54:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CE3F30001A1; Thu, 26 Jun 2025 04:54:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B9BE521E6A27; Thu, 26 Jun 2025 06:54:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Joel Stanley <joel@jms.id.au>,  Yi Liu
 <yi.l.liu@intel.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Helge Deller
 <deller@gmx.de>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Andrew
 Jeffery <andrew@codeconstruct.com.au>,  Fabiano Rosas <farosas@suse.de>,
 Alexander Bulekov <alxndr@bu.edu>,  Darren Kenny
 <darren.kenny@oracle.com>,  Leif Lindholm
 <leif.lindholm@oss.qualcomm.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>,  Ed
 Maste <emaste@freebsd.org>,  Gerd Hoffmann <kraxel@redhat.com>,  Warner
 Losh <imp@bsdimp.com>,  Kevin Wolf <kwolf@redhat.com>,  Tyrone Ting
 <kfting@nuvoton.com>,  Eric Blake <eblake@redhat.com>,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Yoshinori Sato <ysato@users.sourceforge.jp>,  Troy
 Lee <leetroy@gmail.com>,  Halil Pasic <pasic@linux.ibm.com>,  Akihiko
 Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Michael Roth
 <michael.roth@amd.com>,  Laurent Vivier <laurent@vivier.eu>,  Ani Sinha
 <anisinha@redhat.com>,  Weiwei Li <liwei1518@gmail.com>,  Eric Farman
 <farman@linux.ibm.com>,  Steven Lee <steven_lee@aspeedtech.com>,  Brian
 Cain <brian.cain@oss.qualcomm.com>,  Li-Wen Hsu <lwhsu@freebsd.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,  qemu-s390x@nongnu.org,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  qemu-block@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,  =?utf-8?Q?Cl=C3=A9ment?=
 Mathieu--Drif <clement.mathieu--drif@eviden.com>,  Maksim Davydov
 <davydov-max@yandex-team.ru>,  Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>,  Christian
 Borntraeger
 <borntraeger@linux.ibm.com>,  Paul Durrant <paul@xen.org>,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,  Jagannathan Raman
 <jag.raman@oracle.com>,  Igor Mitsyanko <i.mitsyanko@gmail.com>,  Max
 Filippov <jcmvbkbc@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Anton Johansson <anjo@rev.ng>,  Peter Maydell <peter.maydell@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,  Eric Auger <eric.auger@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,  qemu-arm@nongnu.org,  Hao Wu
 <wuhaotsh@google.com>,  Mads Ynddal <mads@ynddal.dk>,  Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>,  qemu-riscv@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Nicholas Piggin
 <npiggin@gmail.com>,  Michael Rolnik <mrolnik@gmail.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Alessandro Di Federico <ale@rev.ng>,  Thomas Huth
 <thuth@redhat.com>,  Antony Pavlov <antonynpavlov@gmail.com>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Hanna Reitz <hreitz@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Marcelo Tosatti <mtosatti@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,  Daniel Henrique Barboza
 <danielhb413@gmail.com>,  Qiuhao Li <Qiuhao.Li@outlook.com>,  Hyman Huang
 <yong.huang@smartx.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,  qemu-rust@nongnu.org,  Bandan Das
 <bsd@redhat.com>,  Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Philippe =?utf-8?Q?Ma?=
 =?utf-8?Q?thieu-Daud=C3=A9?=
 <philmd@linaro.org>,  kvm@vger.kernel.org,  Fam Zheng <fam@euphon.net>,
 Jia Liu <proljc@gmail.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Alistair Francis <alistair@alistair23.me>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,  Kyle Evans
 <kevans@freebsd.org>,  Song Gao <gaosong@loongson.cn>,  Alexandre Iooss
 <erdnaxe@crans.org>,  Aurelien Jarno <aurelien@aurel32.net>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Peter Xu <peterx@redhat.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  BALATON Zoltan <balaton@eik.bme.hu>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  =?utf-8?B?RnLDqWTDqXJpYw==?= Barrat
 <fbarrat@linux.ibm.com>,
 qemu-ppc@nongnu.org,  Radoslaw Biernacki <rad@semihalf.com>,  Beniamino
 Galvani <b.galvani@gmail.com>,  David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  David Woodhouse
 <dwmw2@infradead.org>,  Eduardo Habkost <eduardo@habkost.net>,  Ahmed
 Karaman <ahmedkhaledkaraman@gmail.com>,  Huacai Chen
 <chenhuacai@kernel.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Harsh
 Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 06/12] python: upgrade to python3.9+ syntax
In-Reply-To: <CAFn=p-YPN6MWZiETi7XWkyYVPpe7uew49CwjEdAsMmW=ZPOx5A@mail.gmail.com>
 (John Snow's message of "Wed, 25 Jun 2025 13:35:24 -0400")
References: <20250612205451.1177751-1-jsnow@redhat.com>
 <20250612205451.1177751-7-jsnow@redhat.com>
 <87cyatmw40.fsf@pond.sub.org>
 <CAFn=p-YPN6MWZiETi7XWkyYVPpe7uew49CwjEdAsMmW=ZPOx5A@mail.gmail.com>
Date: Thu, 26 Jun 2025 06:54:18 +0200
Message-ID: <87cyar14sl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> On Tue, Jun 24, 2025 at 3:34=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This patch is fully automated, using pymagic, isort and autoflake.
>> >
>> > Create a script named pymagic.sh:
>> >
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>> >
>> > pyupgrade --exit-zero-even-if-changed --keep-percent-format \
>> >           --py39-plus "$@"
>> >
>> > autoflake -i "$@"
>> >
>> > isort --settings-file python/setup.cfg \
>> >       -p compat -p qapidoc_legacy -p iotests -o qemu "$@"
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>> >
>> > Then, from qemu.git root:
>> >
>> >> find . -type f -name '*.py' | xargs pymagic
>> >> git grep --name-only "#!/usr/bin/env python" | xargs pymagic
>> >
>> > This changes a lot of old Pythonisms, but in particular it upgrades the
>> > old Python type hint paradigm to the new 3.9+ paradigm wherein you no
>> > longer need to import List, Dict, Tuple, Set, etc from the Typing modu=
le
>> > and instead directly subscript the built-in types list, dict, tuple,
>> > set, etc. The old-style annotations are deprecated as of 3.9 and are
>> > eligible for removal starting in Python 3.14, though the exact date of
>> > their removal is not yet known.
>> >
>> > pyupgrade updates the imports and type hint paradigms (as well as
>> > updating other old 'isms, such as removing the unicode string
>> > prefix). autoflake in turn then removes any unused import statements,
>> > possibly left behind by pyupgrade. Lastly, isort fixes the import order
>> > and formatting to the standard we use in qemu.git/python and
>> > scripts/qapi in particular.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> [...]
>>
>> >  448 files changed, 1959 insertions(+), 1631 deletions(-)
>>
>> *=C3=84chz*
>>
>
> Gesundheit.
>
>
>>
>> I hate it when people ask me to split up my mechanical patches...
>>
>> One split is by subsystem / maintainer.  I've done this a few times, and
>> it's quite a bother.  Questionable use of your time if you ask me.
>>
>
> I'd prefer not to unless it is requested of me specifically. I don't think
> most maintainers really care about the nuances of Python and as long as
> their stuff continues to work they're not going to mind much.
>
> Or, to be frank: I don't think this series would ever garner enough review
> and attention to warrant the labor it'd take to tailor it to such a revie=
w.
> It's mechanical, it's boring, it should be fine.
>
> I switched from a manual patch series to a tool-driven one specifically to
> make it more mindless and less interesting, and going through and splitti=
ng
> it back out is ... eh. I would prefer not to.
>
>
>>
>> There's another split here...  Your pymagic.sh runs three tools.  If you
>> commit after each one, the patch splits into three.
>>
>
> I use all three because each one alone isn't sufficient to then pass the
> static analysis checks, they each do a little bit of damage that another
> tool corrects afterwards.
>
> pyupgrade works to modernize syntax, but leaves impotent import statements
> hanging.

Import statements it made impotent, I presume.

> autoflake removes those impotent imports.
> isort fixes the import statement ordering and formatting to our standard.

Out of curiosity: what messes up ordering and formatting?

> (And then I do some manual fixups to fix the linting tests where things
> were auto-formatted suboptimally.)
>
> I can still split it out for review purposes, like I did here with some
> manual fixups appended to the end.
>
> Just, for merge, they'll be combined by necessity as a result of our
> no-regressions-for-bisect rule.

I see.

>> I understand you pass --py39-plus to pyupgrade to get the type hints
>> modernized.  If you run it without --py39-plus for all the miscellaneous
>> upgrades, commit, then run it with --py39-plus for just the type hint
>> upgrades, commit, the last patch splits again.
>>
>
> I can try it! I actually didn't try running it without py39-plus at all, =
so
> I don't know what that'll do. but no harm in an experiment.
>
>
>>
>> Thoughts?
>
>
> First and foremost I just thought it'd be good to get this mechanical
> change squared away in one giant patch so we could add this one singular
> horrible mega-commit into the git blame "ignored commits" list to minimize
> the impact of the "flag day".

Point.

Still, it's awfully hard to see what the horrible mega-commit does.

A patch that does one thing entirely mechanically is fine even when it's
huge.  Understanding the one thing is easy.  I can usually develop
confidence in the patch.

A patch that does many things mechanically can be problematic.  If it's
small enough, I can just review them like any other patch.  If it's way
too big for that, we have to rely on appeal to authority, i.e. the
tool(s) that generated the patch.  Certainly not nothing, but it gives
me an uneasy feeling.

This is why I'm keen to see the type hint upgrade split off.  I expect
the type hint part to do one thing entirely mechanically (fine), and I
hope the other part will be small enough to let me build confidence in
it.

> This upgrade will have to happen "eventually" but it needn't be "right
> now", but I figured it'd be good to get it out of the way... or put anoth=
er
> way, "better my mess than someone else's".

I'd prefer upgrade now rather than later for the Python code I maintain.



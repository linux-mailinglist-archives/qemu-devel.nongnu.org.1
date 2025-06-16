Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9709ADAB6F
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Jun 2025 11:04:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR5kH-0006fr-LS; Mon, 16 Jun 2025 05:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uR5jj-0006Vi-95; Mon, 16 Jun 2025 05:02:41 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uR5jf-0006Fs-Gl; Mon, 16 Jun 2025 05:02:38 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 55G8rZGk082978
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 16 Jun 2025 17:53:35 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=KScVJRjX5qHx2qPV2Idy8E22L/QoVbymW4s2ZmhlRqk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:From:Subject:To;
 s=rs20250326; t=1750064017; v=1;
 b=u8P2EHe+1Y+3zACB4AUA3bkn/KAg15g60iwqmmx8tIcExa0kj2B3qDQM0W6d7OY+
 VSnFJGbZc2rJgdN5gK8R7ctygc0RUk3VAF7yFGFwbbQEaW7nx/1j99kraEJM522U
 880sw6x8Y0OFe7fe1iLwC4VUTiJZfCP2sX7s/EF+VrmF7u3x2fGeDYlp2LNKYWbj
 EIMlWMtydWaTXPmIe6mZv1bmhCS9fwPPGINHFbhzxcqIJs4ukEN6xFpliyxAsq4l
 kdwV17yNkvKZujSwi0NB3erFgwCY1Bv8y8tlCJDE9A/q9Fru+iBod8QBtDaFASvS
 xtUzTYDCN4eH5DW21FDDYg==
Message-ID: <ffdab955-0255-4781-8bcf-909dcc195a01@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 16 Jun 2025 17:53:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH v2 00/12] Python: Fix 'make check-dev' and modernize to
 3.9+
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Fabiano Rosas
 <farosas@suse.de>, Alexander Bulekov <alxndr@bu.edu>,
 Darren Kenny <darren.kenny@oracle.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Ed Maste <emaste@freebsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Kevin Wolf <kwolf@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>, Eric Blake <eblake@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Troy Lee <leetroy@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>, Ani Sinha <anisinha@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Eric Farman <farman@linux.ibm.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Jamin Lin <jamin_lin@aspeedtech.com>,
 qemu-s390x@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paul Durrant <paul@xen.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-arm@nongnu.org,
 Hao Wu <wuhaotsh@google.com>, Mads Ynddal <mads@ynddal.dk>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Rolnik <mrolnik@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alessandro Di Federico <ale@rev.ng>, Thomas Huth <thuth@redhat.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Hanna Reitz <hreitz@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Hyman Huang <yong.huang@smartx.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-rust@nongnu.org,
 Bandan Das <bsd@redhat.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Fam Zheng <fam@euphon.net>,
 Jia Liu <proljc@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Kyle Evans <kevans@freebsd.org>, Song Gao <gaosong@loongson.cn>,
 Alexandre Iooss <erdnaxe@crans.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 qemu-ppc@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Beniamino Galvani <b.galvani@gmail.com>, David Hildenbrand
 <david@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, Eduardo Habkost
 <eduardo@habkost.net>, Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20250612205451.1177751-1-jsnow@redhat.com>
Content-Language: en-US
In-Reply-To: <20250612205451.1177751-1-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/06/13 5:54, John Snow wrote:
> This series does a couple things that I'll probably end up splitting out
> into smaller series if history is any guide, but either way, here it
> goes:

I'm surprised with the large number of Ccs. I suggest splitting the 
series with subsystem boundaries to reduce the number of Ccs for each 
split series.

> 
> A) Convert qemu.git/python/ to a PEP517/pyproject.toml
> package. Ultimately this means deleting setup.py and fully migrating to
> newer python infrastructure. I think this should be safe to do by now,
> but admittedly I am not *confident* as it relies on setuptools versions
> in the wild, not python versions. My motivation for trying it is to fix
> "make check-dev", which has been broken for the last two Fedora releases
> under newer setuptools which have started removing support for the
> pre-PEP517 packaging formats, which will only continue to get worse from
> here on out.

I'm afraid this change may not be safe.

The documentation of setuptools says pyproject.toml is supported since 
61.0.0:
https://setuptools.pypa.io/en/stable/userguide/pyproject_config.html

Looking at Repology as suggested in docs/about/build-platforms.rst, the 
following distributions have older setuptools, unfortunately:
CentOS Stream 9: 53.0.0
Debian 11: 44.1.1
Ubuntu 22.04: 44.1.1

docs/about/build-platforms.rst also says:
 > Optional build dependencies
 >   Build components whose absence does not affect the ability to build
 >   QEMU may not be available in distros, or may be too old for our
 >   requirements. Many of these, such as additional modules for the
 >   functional testing framework or various linters, are written in
 >   Python and therefore can also be installed using ``pip``.

In my understanding, QEMU Python Tooling is an optional component so 
dropping the support of old Linux distribution is tolerated according to 
the documentation. But I think we still need to assess the potential 
impact on the usability to justify that.

A possible option is to fetch a new version of setuptools version when 
necessary. The same documentation says:
 > Python build dependencies
 >   Some of QEMU's build dependencies are written in Python.  Usually
 >   these are only packaged by distributions for the default Python
 >   runtime.
 >   If QEMU bumps its minimum Python version and a non-default runtime
 >   is required, it may be necessary to fetch python modules from the
 >   Python Package Index (PyPI) via ``pip``, in order to build QEMU.

Automatically fetching a compatible version of setuptools as described 
here will reduce the adverse effect of the change.

The documentation page of setuptools I mentioned earlier has the 
following note:
 > If compatibility with legacy builds or versions of tools that don’t
 > support certain packaging standards (e.g. PEP 517 or PEP 660), a
 > simple setup.py script can be added to your project [1] (while keeping
 > the configuration in pyproject.toml):
 >
 > from setuptools import setup
 >
 > setup()

I have no idea what it means though. (Will it automatically fetch new 
setuptools to parse pyproject.toml or something?)

> C) Move us to 3.9+ style type hints. They are deprecated in 3.9, and
> *could* be removed at any time. I figured now was a good time as any to
> get rid of them before they become a problem randomly some day in the
> future.

I guess you meant that the old style type hints are deprecated.

Regards,
Akihiko Odaki


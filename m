Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83675ADAFE2
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Jun 2025 14:10:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR8dq-0004yB-6j; Mon, 16 Jun 2025 08:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uR8dk-0004ww-9P; Mon, 16 Jun 2025 08:08:41 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uR8dg-0003YF-Qg; Mon, 16 Jun 2025 08:08:39 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 55GC5CYt045357
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 16 Jun 2025 21:05:12 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ued+FNLco7H3M7eWjlnqd/mRkFKELch/S6J+7qUNeug=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1750075514; v=1;
 b=ojXlCOq1RciJ2fdqnbl0b58/xEt3z34Gtmypg6Zu3hIPBlB8cgvJk51vp0i1M5p7
 n7dS8l2WWoU9OS/+C0h1nDsaD1kJzkeoB4JhUTy1ouT/QD8ef9e7ySK8GZhtrFpj
 jRIIG+b83Qk6+gc8F9Lzj1F05D4RptL8UYEdQ0P/soe2JdZ4PcIteWfNR/I9WKMk
 yKBqb/fTVIRiG7Z0upwN4l+sVhwD4ERg9azQp0uN9y5et8L8fA9ffXj8WdjVotie
 3FM+JNaaEJnHXTPMss/XdAMtzqI6cGPVGl1XNA3FhL7cai2eNz3yLWndfYRgtnaG
 MJWCImLpqoHqvMut4bISmQ==
Message-ID: <a0652351-8443-492d-96dc-9772bf08341d@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 16 Jun 2025 21:05:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] python: update pylint ignores
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
 <20250612205451.1177751-3-jsnow@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250612205451.1177751-3-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
> The next patch will synchronize the qemu.qmp library with the external,
> standalone version. That synchronization will require an extra ignore
> for pylint, so do that now.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


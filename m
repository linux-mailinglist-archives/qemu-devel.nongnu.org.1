Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 124637FFDBC
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 22:41:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8ome-0003Ac-5D; Thu, 30 Nov 2023 16:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r8omb-00039R-ED; Thu, 30 Nov 2023 16:41:17 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r8omZ-0001eG-95; Thu, 30 Nov 2023 16:41:17 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4629E75A4C4;
 Thu, 30 Nov 2023 22:41:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id wx21V_Q-LTE0; Thu, 30 Nov 2023 22:41:09 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4F947756094; Thu, 30 Nov 2023 22:41:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4B666756066;
 Thu, 30 Nov 2023 22:41:09 +0100 (CET)
Date: Thu, 30 Nov 2023 22:41:09 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Stefan Hajnoczi <stefanha@redhat.com>
cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org, 
 Song Gao <gaosong@loongson.cn>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Thomas Huth <thuth@redhat.com>, Hyman Huang <yong.huang@smartx.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, 
 David Woodhouse <dwmw2@infradead.org>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Max Filippov <jcmvbkbc@gmail.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Paul Durrant <paul@xen.org>, 
 Jagannathan Raman <jag.raman@oracle.com>, 
 Juan Quintela <quintela@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 qemu-arm@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Fam Zheng <fam@euphon.net>, Eric Blake <eblake@redhat.com>, 
 Jiri Slaby <jslaby@suse.cz>, Alexander Graf <agraf@csgraf.de>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>, 
 Eric Farman <farman@linux.ibm.com>, Stafford Horne <shorne@gmail.com>, 
 David Hildenbrand <david@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 Reinoud Zandijk <reinoud@netbsd.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Cameron Esfahani <dirty@apple.com>, xen-devel@lists.xenproject.org, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-riscv@nongnu.org, 
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, 
 John Snow <jsnow@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>, 
 Michael Roth <michael.roth@amd.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Bin Meng <bin.meng@windriver.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, kvm@vger.kernel.org, 
 qemu-block@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, 
 Anthony Perard <anthony.perard@citrix.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Leonardo Bras <leobras@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 1/6] system/cpus: rename qemu_mutex_lock_iothread() to
 qemu_bql_lock()
In-Reply-To: <20231130204325.GE1184658@fedora>
Message-ID: <2e5f3da3-958e-fed3-5e15-0e9aa09159e1@eik.bme.hu>
References: <20231129212625.1051502-1-stefanha@redhat.com>
 <20231129212625.1051502-2-stefanha@redhat.com> <ZWjr0TKxihlpd1jm@x1n>
 <20231130204325.GE1184658@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Thu, 30 Nov 2023, Stefan Hajnoczi wrote:

> On Thu, Nov 30, 2023 at 03:08:49PM -0500, Peter Xu wrote:
>> On Wed, Nov 29, 2023 at 04:26:20PM -0500, Stefan Hajnoczi wrote:
>>> The Big QEMU Lock (BQL) has many names and they are confusing. The
>>> actual QemuMutex variable is called qemu_global_mutex but it's commonly
>>> referred to as the BQL in discussions and some code comments. The
>>> locking APIs, however, are called qemu_mutex_lock_iothread() and
>>> qemu_mutex_unlock_iothread().
>>>
>>> The "iothread" name is historic and comes from when the main thread was
>>> split into into KVM vcpu threads and the "iothread" (now called the main
>>> loop thread). I have contributed to the confusion myself by introducing
>>> a separate --object iothread, a separate concept unrelated to the BQL.
>>>
>>> The "iothread" name is no longer appropriate for the BQL. Rename the
>>> locking APIs to:
>>> - void qemu_bql_lock(void)
>>> - void qemu_bql_unlock(void)
>>> - bool qemu_bql_locked(void)
>>>
>>> There are more APIs with "iothread" in their names. Subsequent patches
>>> will rename them. There are also comments and documentation that will be
>>> updated in later patches.
>>>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>
>> Acked-by: Peter Xu <peterx@redhat.com>
>>
>> Two nickpicks:
>>
>>   - BQL contains "QEMU" as the 2nd character, so maybe easier to further
>>     rename qemu_bql into bql_?
>
> Philippe wondered whether the variable name should end with _mutex (or
> _lock is common too), so an alternative might be big_qemu_lock. That's
> imperfect because it doesn't start with the usual qemu_ prefix.
> qemu_big_lock is better in that regard but inconsistent with our BQL
> abbreviation.

BQL isn't very specific for those unfamiliar with the code but it's short 
and already used and known by people so I'm OK with qemu_bql with some 
comments and docs explainig here and there what bql stands for should be 
enough for new people to quickly find out. If we want to be more verbose 
how about "qemu_global_mutex" which is self describing but longer and does 
not resemble BQL so then comments may be needed to explain this is what 
was called BQL as well. I don't mind either way though.

Regards,
BALATON Zoltan

> I don't like putting an underscore at the end. It's unusual and would
> make me wonder what that means.
>
> Naming is hard, but please discuss and I'm open to change to BQL
> variable's name to whatever we all agree on.
>
>>
>>   - Could we keep the full spell of BQL at some places, so people can still
>>     reference it if not familiar?  IIUC most of the BQL helpers will root
>>     back to the major three functions (_lock, _unlock, _locked), perhaps
>>     add a comment of "BQL stands for..." over these three functions as
>>     comment?
>
> Yes, I'll update the doc comments to say "Big QEMU Lock (BQL)" for each
> of these functions.
>
> Stefan
>


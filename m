Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D81C67E3283
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 02:11:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Ac0-0000d0-1D; Mon, 06 Nov 2023 20:10:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r0Abt-0000bX-SD
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 20:10:32 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r0Abr-0006Fb-9P
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 20:10:29 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 80C5574705E;
 Tue,  7 Nov 2023 02:10:35 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 735AD7456A7; Tue,  7 Nov 2023 02:10:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 70BE3745681;
 Tue,  7 Nov 2023 02:10:35 +0100 (CET)
Date: Tue, 7 Nov 2023 02:10:35 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Stefan Hajnoczi <stefanha@gmail.com>
cc: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PULL v2 22/24] hw/display: make ATI_VGA depend on PIXMAN
In-Reply-To: <CAJSP0QUDDMgoRSZ0bYjhjUo3YScJerUdawSaoNNVWyQ6Up=q+g@mail.gmail.com>
Message-ID: <94018b35-7a33-7887-f1a8-13a9ee7b6542@eik.bme.hu>
References: <20231106095542.1852973-1-marcandre.lureau@redhat.com>
 <20231106095542.1852973-23-marcandre.lureau@redhat.com>
 <4da573ce-756e-d31b-5c13-4e0f8245dd08@linaro.org>
 <CAJ+F1C+c73Aura=JEWyp7z4_3eiNzV1Z8BOeURjJ+2YUucatCA@mail.gmail.com>
 <5f8901af-17e7-daec-4e02-ba1df3f5dbb6@linaro.org>
 <eefcde0e-2409-f119-9b00-6746ca3cf819@eik.bme.hu>
 <CAJ+F1C+Z3_iGnnyGNZgqGW511oET=TWb7qZerBWdnkbYxDqjww@mail.gmail.com>
 <22f2b9d8-8893-0a78-a55c-1ecb482bfad2@eik.bme.hu>
 <CAJSP0QUDDMgoRSZ0bYjhjUo3YScJerUdawSaoNNVWyQ6Up=q+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-450277361-1699319435=:52866"
X-Virus-Scanned: ClamAV using ClamSMTP
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-450277361-1699319435=:52866
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 7 Nov 2023, Stefan Hajnoczi wrote:
> On Mon, 6 Nov 2023 at 19:04, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> On Mon, 6 Nov 2023, Marc-André Lureau wrote:
>>> Hi Zoltan
>>>
>>> On Mon, Nov 6, 2023 at 2:53 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>>
>>>> On Mon, 6 Nov 2023, Philippe Mathieu-Daudé wrote:
>>>>> On 6/11/23 11:11, Marc-André Lureau wrote:
>>>>>> Hi Philippe
>>>>>>
>>>>>> On Mon, Nov 6, 2023 at 2:03 PM Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> wrote:
>>>>>>>
>>>>>>> Hi Marc-André,
>>>>>>>
>>>>>>> Cc'ing Fuloong maintainers,
>>>>>>>
>>>>>>> On 6/11/23 10:55, marcandre.lureau@redhat.com wrote:
>>>>>>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>>>>>
>>>>>>>> To avoid a kconfig cycle, change "depends on PCI" to "select PCI".
>>>>>>>>
>>>>>>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>>>>> Acked-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>>>>> ---
>>>>>>>>    configs/devices/mips64el-softmmu/default.mak | 3 +--
>>>>>>>>    hw/display/Kconfig                           | 3 ++-
>>>>>>>>    hw/display/meson.build                       | 2 +-
>>>>>>>>    hw/mips/Kconfig                              | 2 ++
>>>>>>>>    4 files changed, 6 insertions(+), 4 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/configs/devices/mips64el-softmmu/default.mak
>>>>>>>> b/configs/devices/mips64el-softmmu/default.mak
>>>>>>>> index d5188f7ea5..4d80d60511 100644
>>>>>>>> --- a/configs/devices/mips64el-softmmu/default.mak
>>>>>>>> +++ b/configs/devices/mips64el-softmmu/default.mak
>>>>>>>> @@ -1,9 +1,8 @@
>>>>>>>>    # Default configuration for mips64el-softmmu
>>>>>>>>
>>>>>>>>    include ../mips-softmmu/common.mak
>>>>>>>> -CONFIG_FULOONG=y
>>>>>>>> +#CONFIG_FULOONG=y
>>>>>>>
>>>>>>> Why is the justification to disable this board? From the
>>>>>>> bare "avoid a kconfig cycle" commit message, it is not
>>>>>>> obvious to me.
>>>>>>
>>>>>> It's not actually disabled, it's enabled by default in kconfig.
>>>>>
>>>>> OK, so let's remove the line entirely, not comment it, please.
>>>>
>>>> Well it's disabled without pixman... I have a series adding fallbacks to
>>>> ati-vga similar to sm501 (which is also needed on aarch64 macOS where
>>>> pixman does not work) and with that this isn't needed. So I think it's
>>>> better to rebase this series on mine then some of this becomes
>>>> unnecessary.
>>>>
>>>
>>>
>>> It's not ready yet though. We can later revert some of this change
>>
>> What's not ready about it?
>>
>>> when your fallback version is applied. In the meantime, this doesn't
>>> change the behaviour unless PIXMAN has been disabled, so it should be
>>> acceptable. Agree? thanks
>>
>> I think it would be better to not commit something that should be reverted
>> soon. I understand you don't want to rebase yout series but I also don't
>> want to revert it later so either do the rebase now or hold off with this
>> series until after mine got in please.
>
> QEMU 8.2 soft freeze is today. If you both can resolve this and send
> pull requests today, then the changes will make it into 8.2.
> Otherwise, asking for this pull request to be rebased has the effect
> of delaying it until 8.3.
>
> I'll keep an eye on this series today.

Marc-André has sent a pull request that contains my ati-vga series:
https://patchew.org/QEMU/20231106133219.2173660-1-marcandre.lureau@redhat.com/
so I think he intends to rebase this series and send another version today 
or come back to this later. (8.3 will be called 9.0 by the way).

Regards,
BALATON Zoltan
--3866299591-450277361-1699319435=:52866--


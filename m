Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B888D81A5CF
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:59:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFztC-0001Lh-Et; Wed, 20 Dec 2023 11:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rFzt9-0001LS-Rd
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:57:43 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rFzt7-00028A-HL
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:57:43 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0709875A4D7;
 Wed, 20 Dec 2023 17:57:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id N5KMEDMOsExu; Wed, 20 Dec 2023 17:57:33 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1AE6C75A4BC; Wed, 20 Dec 2023 17:57:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 18353756066;
 Wed, 20 Dec 2023 17:57:33 +0100 (CET)
Date: Wed, 20 Dec 2023 17:57:33 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Fabiano Rosas <farosas@suse.de>
cc: Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Dave Blanchard <dave@killthe.net>, QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: Qemu resets terminal to crazy defaults
In-Reply-To: <87a5q4rj8j.fsf@suse.de>
Message-ID: <c76b134d-bab8-fea2-6df2-bd9baaa80771@eik.bme.hu>
References: <20231219132135.c4bff4807c9d7215b179f240@killthe.net>
 <87plz22d9r.fsf@suse.de>
 <CAFEAcA-RJUUZo0KYujQskkAim_qXkJxtuSb9wtgxoP0XSEtKYQ@mail.gmail.com>
 <CANCZdfqX=URh2C+upKQPF9sg9TX6oZpHfrYF6rGRNz-6SdbhLw@mail.gmail.com>
 <87a5q4rj8j.fsf@suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2058111875-1703091453=:72834"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

--3866299591-2058111875-1703091453=:72834
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 20 Dec 2023, Fabiano Rosas wrote:
> Warner Losh <imp@bsdimp.com> writes:
>
>> On Tue, Dec 19, 2023, 1:55 PM Peter Maydell <peter.maydell@linaro.org>
>> wrote:
>>
>>> On Tue, 19 Dec 2023 at 19:40, Fabiano Rosas <farosas@suse.de> wrote:
>>>>
>>>> Dave Blanchard <dave@killthe.net> writes:
>>>>
>>>>> Hello all, can you please help me to understand what Qemu is doing
>>> here?
>>>>>
>>>>> When connecting to the guest for example using a serial/tcp/telnet
>>> link, some kind of code is being immediately transmitted over the link
>>> which screws up my Xterm terminal settings, including changing the text
>>> cursor shape and most notably, disabling wraparound of long lines, so that
>>> they get truncated at the edge of the window instead.
>>>>>
>>>>> Can this behavior be disabled by command line, and if not, what is the
>>> code doing exactly so I can know where to disable it? I tried disabling all
>>> calls to tcsetattr() but that had no effect.
>>>
>>>> I looked into the automatic margins issue a long time ago and I seem to
>>>> remember it was caused by the firmware (SeaBIOS) configuring the
>>>> terminal and QEMU just never returning it to the original state. I
>>>> eventually gave up trying to fix it because I was having trouble finding
>>>> a reliable point in QEMU shutdown sequence to enable the capability
>>>> back. Nowadays I just run 'tput smam' after quitting QEMU.
>>>
>>> To check whether this is happening because of the BIOS (or other
>>> guest code) vs QEMU itself, you can try running QEMU in a configuration
>>> where it doesn't run any BIOS code. One I happen to know offhand
>>> is an arm one:
>>>
>>>    qemu-system-aarch64 -M virt -serial stdio
>>>
>>> This won't print anything, because we haven't loaded any guest
>>> code at all and there's no default BIOS on this machine type.
>>> (The emulated CPU is sat in effectively a tight loop taking
>>> exceptions.) If that messes up the terminal settings, then it's
>>> likely being done by something inside QEMU. If it doesn't, then
>>> it sounds like as you say it'll be because of the SeaBIOS
>>> firmware writing stuff to the terminal.
>>>
>>> (There might be a way to run the x86 PC machine without it
>>> running a BIOS, for a similar test, but I don't know if there
>>> is or how to do it off the top of my head.)
>>>
>
> I tried using an empty bios file. I see with 'info registers' that the
> vcpu is spinning. After quitting QEMU, the terminal state is unchanged:
>
> $ dd if=/dev/zero of=dummy-bios.bin count=256 bs=1k
> $ qemu-system-x86_64 -nographic -bios ./dummy-bios.bin
> $ <line wrap preserved>
>
> With SeaBIOS, the issue manifests:
>
> $ qemu-system-x86_64 -nographic
> SeaBIOS (version rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org)
> <bunch of boot and iPXE messages>
> ...
> $ <line wrap disabled>
>
>>> I do know that QEMU doesn't clean up things the guest does
>>> to the terminal, because for instance if you have a serial
>>> terminal and the guest puts it into "emit boldface/bright",
>>> that doesn't go back to normal non-bold text when QEMU exits.
>>> (It would be nice if it did do that...)
>>>
>>
>> It would be nice indeed. Trouble is quarrying the state beforehand to know
>> what to reset by random software producing effectively random bytes..
>>
>
> Maybe we could focus on the more annoying/obvious state? The line wrap
> issue is a very salient one, specially since QEMU command lines
> themselves tend to take more than one line.
>
>> ESC c
>>
>> is the reset sequence as well...but that's likely too big a hammer.

There's 'stty sane' which is supposed to reset to reasonable values, maybe 
that could be used but I'm not sure it could fix all strange states. It's 
better than reset as reset also drops scrollback history.

Regards,
BALATON Zoltan
--3866299591-2058111875-1703091453=:72834--


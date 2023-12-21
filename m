Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1134D81B7C6
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 14:31:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGJ7r-0008Ch-1j; Thu, 21 Dec 2023 08:30:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rGJ7p-0008CY-9J
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 08:30:09 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rGJ7Z-0002cO-Ri
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 08:30:08 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3F58721DB4;
 Thu, 21 Dec 2023 13:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1703165390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=92jyCrKBY09QD/qaZ2AzhBSeFLZ3qELGx5CVaqfWw/s=;
 b=KE+zlEzmlQBpacdu+xkUubesPYEed0B214K6xDmG48f90QZS0Uvp4txAe3zocklLDtGSKk
 6qGZGcmig7OMsaHlFt+BmqJ4p088eaMXL4hBEAF48WjrmOCF2YiySf/SDwHdUuuzKRPQ6Z
 +b+t6c+pXTWlXFdeJVMMb1uZVBi8GwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1703165390;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=92jyCrKBY09QD/qaZ2AzhBSeFLZ3qELGx5CVaqfWw/s=;
 b=vozfp+RQWLtvCchqEjMbEnJpOldbMFda46HzHi0JETY82MnW6aIga3/a2A6ZuD3VNLQ20d
 rIRDxDrmIfTXo1Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1703165390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=92jyCrKBY09QD/qaZ2AzhBSeFLZ3qELGx5CVaqfWw/s=;
 b=KE+zlEzmlQBpacdu+xkUubesPYEed0B214K6xDmG48f90QZS0Uvp4txAe3zocklLDtGSKk
 6qGZGcmig7OMsaHlFt+BmqJ4p088eaMXL4hBEAF48WjrmOCF2YiySf/SDwHdUuuzKRPQ6Z
 +b+t6c+pXTWlXFdeJVMMb1uZVBi8GwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1703165390;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=92jyCrKBY09QD/qaZ2AzhBSeFLZ3qELGx5CVaqfWw/s=;
 b=vozfp+RQWLtvCchqEjMbEnJpOldbMFda46HzHi0JETY82MnW6aIga3/a2A6ZuD3VNLQ20d
 rIRDxDrmIfTXo1Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13F6E13725;
 Thu, 21 Dec 2023 13:29:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7XnlMsw9hGVcBgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 21 Dec 2023 13:29:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Dave Blanchard <dave@killthe.net>, QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: Qemu resets terminal to crazy defaults
In-Reply-To: <c76b134d-bab8-fea2-6df2-bd9baaa80771@eik.bme.hu>
References: <20231219132135.c4bff4807c9d7215b179f240@killthe.net>
 <87plz22d9r.fsf@suse.de>
 <CAFEAcA-RJUUZo0KYujQskkAim_qXkJxtuSb9wtgxoP0XSEtKYQ@mail.gmail.com>
 <CANCZdfqX=URh2C+upKQPF9sg9TX6oZpHfrYF6rGRNz-6SdbhLw@mail.gmail.com>
 <87a5q4rj8j.fsf@suse.de> <c76b134d-bab8-fea2-6df2-bd9baaa80771@eik.bme.hu>
Date: Thu, 21 Dec 2023 10:29:45 -0300
Message-ID: <877cl7r8dy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-3.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -3.10
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Wed, 20 Dec 2023, Fabiano Rosas wrote:
>> Warner Losh <imp@bsdimp.com> writes:
>>
>>> On Tue, Dec 19, 2023, 1:55=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org>
>>> wrote:
>>>
>>>> On Tue, 19 Dec 2023 at 19:40, Fabiano Rosas <farosas@suse.de> wrote:
>>>>>
>>>>> Dave Blanchard <dave@killthe.net> writes:
>>>>>
>>>>>> Hello all, can you please help me to understand what Qemu is doing
>>>> here?
>>>>>>
>>>>>> When connecting to the guest for example using a serial/tcp/telnet
>>>> link, some kind of code is being immediately transmitted over the link
>>>> which screws up my Xterm terminal settings, including changing the text
>>>> cursor shape and most notably, disabling wraparound of long lines, so =
that
>>>> they get truncated at the edge of the window instead.
>>>>>>
>>>>>> Can this behavior be disabled by command line, and if not, what is t=
he
>>>> code doing exactly so I can know where to disable it? I tried disablin=
g all
>>>> calls to tcsetattr() but that had no effect.
>>>>
>>>>> I looked into the automatic margins issue a long time ago and I seem =
to
>>>>> remember it was caused by the firmware (SeaBIOS) configuring the
>>>>> terminal and QEMU just never returning it to the original state. I
>>>>> eventually gave up trying to fix it because I was having trouble find=
ing
>>>>> a reliable point in QEMU shutdown sequence to enable the capability
>>>>> back. Nowadays I just run 'tput smam' after quitting QEMU.
>>>>
>>>> To check whether this is happening because of the BIOS (or other
>>>> guest code) vs QEMU itself, you can try running QEMU in a configuration
>>>> where it doesn't run any BIOS code. One I happen to know offhand
>>>> is an arm one:
>>>>
>>>>    qemu-system-aarch64 -M virt -serial stdio
>>>>
>>>> This won't print anything, because we haven't loaded any guest
>>>> code at all and there's no default BIOS on this machine type.
>>>> (The emulated CPU is sat in effectively a tight loop taking
>>>> exceptions.) If that messes up the terminal settings, then it's
>>>> likely being done by something inside QEMU. If it doesn't, then
>>>> it sounds like as you say it'll be because of the SeaBIOS
>>>> firmware writing stuff to the terminal.
>>>>
>>>> (There might be a way to run the x86 PC machine without it
>>>> running a BIOS, for a similar test, but I don't know if there
>>>> is or how to do it off the top of my head.)
>>>>
>>
>> I tried using an empty bios file. I see with 'info registers' that the
>> vcpu is spinning. After quitting QEMU, the terminal state is unchanged:
>>
>> $ dd if=3D/dev/zero of=3Ddummy-bios.bin count=3D256 bs=3D1k
>> $ qemu-system-x86_64 -nographic -bios ./dummy-bios.bin
>> $ <line wrap preserved>
>>
>> With SeaBIOS, the issue manifests:
>>
>> $ qemu-system-x86_64 -nographic
>> SeaBIOS (version rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org)
>> <bunch of boot and iPXE messages>
>> ...
>> $ <line wrap disabled>
>>
>>>> I do know that QEMU doesn't clean up things the guest does
>>>> to the terminal, because for instance if you have a serial
>>>> terminal and the guest puts it into "emit boldface/bright",
>>>> that doesn't go back to normal non-bold text when QEMU exits.
>>>> (It would be nice if it did do that...)
>>>>
>>>
>>> It would be nice indeed. Trouble is quarrying the state beforehand to k=
now
>>> what to reset by random software producing effectively random bytes..
>>>
>>
>> Maybe we could focus on the more annoying/obvious state? The line wrap
>> issue is a very salient one, specially since QEMU command lines
>> themselves tend to take more than one line.
>>
>>> ESC c
>>>
>>> is the reset sequence as well...but that's likely too big a hammer.
>
> There's 'stty sane' which is supposed to reset to reasonable values, mayb=
e=20
> that could be used but I'm not sure it could fix all strange states. It's=
=20
> better than reset as reset also drops scrollback history.
>
> Regards,
> BALATON Zoltan

For this one issue of linewrapping being disabled, we could probe the
state of the capability somewhere at QEMU start:

\033[?7$p
7;1$y  <-- 1 means enabled, 2 means disabled

And then restore it when shutting down. I think it would be worth it
because this issue has been present in QEMU for a long time. In fact,
this thread from 2019 from where I took the above information already
mentions QEMU "leaving the terminal in a weird state":

https://unix.stackexchange.com/questions/558770/how-to-query-the-terminal-s=
tate-that-is-set-by-escape-sequences-such-as-tput-sma

There's a catch though with the above escape sequence which is that
terminal multiplexers such as tmux and screen will not pass it down to
the terminal emulator as is. They both require some wrapping of the
sequence.

Screen requires: \033P<query sequence>\033\\
Tmux requires:   \033Ptmux;<query sequence>\033\\

with the sequence used by screen also working if given directly to the
terminal emulator (tested w/ TERM=3Dxterm-256color via xfce-terminal), so
the only special case really is tmux.

I'd say we could have a routine, probably at char.c that probes the
state and registers an atexit handler (or similar) to restore the
state. In time, if we find more ways in which the guest can mess up the
terminal state, we could evaluate case-by-case and add code for the more
annoying issues.



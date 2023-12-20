Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9C981A241
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 16:24:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFyQ4-0001QF-2Q; Wed, 20 Dec 2023 10:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rFyPp-0001Pi-3h
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 10:23:22 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rFyPk-0007jX-Eu
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 10:23:19 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0ECAC21FD5;
 Wed, 20 Dec 2023 15:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1703085792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LyPuH2Bg1VeqgV8UgY2s+ld3VbZzKdq+8S8lWDrxbtI=;
 b=KNvWRvG2dTtxeTD9AAWRc0H5D4xSDYCITFJoot0jy2zXVMxWhyE8Q9d7qYQyQAHNYDNkAQ
 YIum0dUB3YyV92HjeBczT9ZJw3nUu5FZ/xAqNVGRreJ1Zlq6yA22PtgY1roIVOT7buPRtJ
 k91juVoWROCUdmd8u2wzYU3hXY2g46w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1703085792;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LyPuH2Bg1VeqgV8UgY2s+ld3VbZzKdq+8S8lWDrxbtI=;
 b=NseXL3tAA8lovLBYNipQCKnF4gyWyaICrtcJrId5phSk2Lq+rak3zztRIMKbTXjl5UsWi2
 3CVgHQBOvNIJ8gDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1703085792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LyPuH2Bg1VeqgV8UgY2s+ld3VbZzKdq+8S8lWDrxbtI=;
 b=KNvWRvG2dTtxeTD9AAWRc0H5D4xSDYCITFJoot0jy2zXVMxWhyE8Q9d7qYQyQAHNYDNkAQ
 YIum0dUB3YyV92HjeBczT9ZJw3nUu5FZ/xAqNVGRreJ1Zlq6yA22PtgY1roIVOT7buPRtJ
 k91juVoWROCUdmd8u2wzYU3hXY2g46w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1703085792;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LyPuH2Bg1VeqgV8UgY2s+ld3VbZzKdq+8S8lWDrxbtI=;
 b=NseXL3tAA8lovLBYNipQCKnF4gyWyaICrtcJrId5phSk2Lq+rak3zztRIMKbTXjl5UsWi2
 3CVgHQBOvNIJ8gDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82CBB136A5;
 Wed, 20 Dec 2023 15:23:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FsqEEt8Gg2VvMAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 20 Dec 2023 15:23:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Dave Blanchard <dave@killthe.net>, QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: Qemu resets terminal to crazy defaults
In-Reply-To: <CANCZdfqX=URh2C+upKQPF9sg9TX6oZpHfrYF6rGRNz-6SdbhLw@mail.gmail.com>
References: <20231219132135.c4bff4807c9d7215b179f240@killthe.net>
 <87plz22d9r.fsf@suse.de>
 <CAFEAcA-RJUUZo0KYujQskkAim_qXkJxtuSb9wtgxoP0XSEtKYQ@mail.gmail.com>
 <CANCZdfqX=URh2C+upKQPF9sg9TX6oZpHfrYF6rGRNz-6SdbhLw@mail.gmail.com>
Date: Wed, 20 Dec 2023 12:23:08 -0300
Message-ID: <87a5q4rj8j.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; NEURAL_HAM_SHORT(-0.19)[-0.960];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linaro.org:email,qemu.org:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Warner Losh <imp@bsdimp.com> writes:

> On Tue, Dec 19, 2023, 1:55=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
> wrote:
>
>> On Tue, 19 Dec 2023 at 19:40, Fabiano Rosas <farosas@suse.de> wrote:
>> >
>> > Dave Blanchard <dave@killthe.net> writes:
>> >
>> > > Hello all, can you please help me to understand what Qemu is doing
>> here?
>> > >
>> > > When connecting to the guest for example using a serial/tcp/telnet
>> link, some kind of code is being immediately transmitted over the link
>> which screws up my Xterm terminal settings, including changing the text
>> cursor shape and most notably, disabling wraparound of long lines, so th=
at
>> they get truncated at the edge of the window instead.
>> > >
>> > > Can this behavior be disabled by command line, and if not, what is t=
he
>> code doing exactly so I can know where to disable it? I tried disabling =
all
>> calls to tcsetattr() but that had no effect.
>>
>> > I looked into the automatic margins issue a long time ago and I seem to
>> > remember it was caused by the firmware (SeaBIOS) configuring the
>> > terminal and QEMU just never returning it to the original state. I
>> > eventually gave up trying to fix it because I was having trouble findi=
ng
>> > a reliable point in QEMU shutdown sequence to enable the capability
>> > back. Nowadays I just run 'tput smam' after quitting QEMU.
>>
>> To check whether this is happening because of the BIOS (or other
>> guest code) vs QEMU itself, you can try running QEMU in a configuration
>> where it doesn't run any BIOS code. One I happen to know offhand
>> is an arm one:
>>
>>    qemu-system-aarch64 -M virt -serial stdio
>>
>> This won't print anything, because we haven't loaded any guest
>> code at all and there's no default BIOS on this machine type.
>> (The emulated CPU is sat in effectively a tight loop taking
>> exceptions.) If that messes up the terminal settings, then it's
>> likely being done by something inside QEMU. If it doesn't, then
>> it sounds like as you say it'll be because of the SeaBIOS
>> firmware writing stuff to the terminal.
>>
>> (There might be a way to run the x86 PC machine without it
>> running a BIOS, for a similar test, but I don't know if there
>> is or how to do it off the top of my head.)
>>

I tried using an empty bios file. I see with 'info registers' that the
vcpu is spinning. After quitting QEMU, the terminal state is unchanged:

$ dd if=3D/dev/zero of=3Ddummy-bios.bin count=3D256 bs=3D1k
$ qemu-system-x86_64 -nographic -bios ./dummy-bios.bin
$ <line wrap preserved>

With SeaBIOS, the issue manifests:

$ qemu-system-x86_64 -nographic
SeaBIOS (version rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org)
<bunch of boot and iPXE messages>
...
$ <line wrap disabled>

>> I do know that QEMU doesn't clean up things the guest does
>> to the terminal, because for instance if you have a serial
>> terminal and the guest puts it into "emit boldface/bright",
>> that doesn't go back to normal non-bold text when QEMU exits.
>> (It would be nice if it did do that...)
>>
>
> It would be nice indeed. Trouble is quarrying the state beforehand to know
> what to reset by random software producing effectively random bytes..
>

Maybe we could focus on the more annoying/obvious state? The line wrap
issue is a very salient one, specially since QEMU command lines
themselves tend to take more than one line.

> ESC c
>
> is the reset sequence as well...but that's likely too big a hammer.
>
> Warner
>
> thanks
>> -- PMM
>>
>>


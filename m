Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA238190F8
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:40:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfvm-0001Pr-Sq; Tue, 19 Dec 2023 14:39:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rFfvl-0001Pf-1H
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:39:05 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rFfvj-0007jD-9M
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:39:04 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 65A3A21EF6;
 Tue, 19 Dec 2023 19:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1703014739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kqUyj92l/EyvsmfcOWn1e+2Gfk0DEFi+8DeKWVhiQVY=;
 b=BuI6QbeQORHxjvvmdWlKtw5IwwClZiceTXWPdMC0vEOcFaqj4Z6FfLhfLF4tr9Ythi6Fqp
 +VTDvwrPczogvblcIkF8H/wL9f5/3/ni4Ix8qkTvXPNHnh3y/ICChpO+J7xfRV+60EBTtM
 lC18UF8omggPHnCmIpv02vqHNcR2zB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1703014739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kqUyj92l/EyvsmfcOWn1e+2Gfk0DEFi+8DeKWVhiQVY=;
 b=hCDh/oms1Y+BRMR9LmeQJHC86NobqD5JINr4/Z71NiAQSepjZWrJT8M62anBAs3HH+JKKW
 PI46LLgTM0kKPsCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1703014739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kqUyj92l/EyvsmfcOWn1e+2Gfk0DEFi+8DeKWVhiQVY=;
 b=BuI6QbeQORHxjvvmdWlKtw5IwwClZiceTXWPdMC0vEOcFaqj4Z6FfLhfLF4tr9Ythi6Fqp
 +VTDvwrPczogvblcIkF8H/wL9f5/3/ni4Ix8qkTvXPNHnh3y/ICChpO+J7xfRV+60EBTtM
 lC18UF8omggPHnCmIpv02vqHNcR2zB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1703014739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kqUyj92l/EyvsmfcOWn1e+2Gfk0DEFi+8DeKWVhiQVY=;
 b=hCDh/oms1Y+BRMR9LmeQJHC86NobqD5JINr4/Z71NiAQSepjZWrJT8M62anBAs3HH+JKKW
 PI46LLgTM0kKPsCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E26CC136A5;
 Tue, 19 Dec 2023 19:38:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hcRVKlLxgWVQLQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 19 Dec 2023 19:38:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Dave Blanchard <dave@killthe.net>, qemu-devel@nongnu.org
Subject: Re: Qemu resets terminal to crazy defaults
In-Reply-To: <20231219132135.c4bff4807c9d7215b179f240@killthe.net>
References: <20231219132135.c4bff4807c9d7215b179f240@killthe.net>
Date: Tue, 19 Dec 2023 16:38:56 -0300
Message-ID: <87plz22d9r.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BuI6QbeQ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="hCDh/oms"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.59 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 BAYES_HAM(-0.08)[63.07%]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -3.59
X-Rspamd-Queue-Id: 65A3A21EF6
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

Dave Blanchard <dave@killthe.net> writes:

> Hello all, can you please help me to understand what Qemu is doing here? 
>
> When connecting to the guest for example using a serial/tcp/telnet link, some kind of code is being immediately transmitted over the link which screws up my Xterm terminal settings, including changing the text cursor shape and most notably, disabling wraparound of long lines, so that they get truncated at the edge of the window instead. 
>
> Can this behavior be disabled by command line, and if not, what is the code doing exactly so I can know where to disable it? I tried disabling all calls to tcsetattr() but that had no effect.
>
> Dave

I looked into the automatic margins issue a long time ago and I seem to
remember it was caused by the firmware (SeaBIOS) configuring the
terminal and QEMU just never returning it to the original state. I
eventually gave up trying to fix it because I was having trouble finding
a reliable point in QEMU shutdown sequence to enable the capability
back. Nowadays I just run 'tput smam' after quitting QEMU.

Not a lot of help, I know. Hopefuly someone else has more information
about this. I'd be interested in finding a proper solution for this
situation.


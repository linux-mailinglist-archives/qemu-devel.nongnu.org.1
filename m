Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C547856A2E
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Feb 2024 17:55:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raezS-0006Td-DF; Thu, 15 Feb 2024 11:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1raezQ-0006TP-6A
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 11:53:36 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1raezO-0005ou-B4
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 11:53:35 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 800982222D;
 Thu, 15 Feb 2024 16:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708016009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JKA3XuZgeuWKkDBDniSCib2DmiM7CNBysAwz9GmmmBM=;
 b=0GSV/2x6JwHaR2iaKAh9E649uAwlMwtDJRi8cVgDyARwQnCzA1H7nu/YeTQs4pm22LF7le
 h6J6sN55kiwWSzLU0u9aNQOaOShCL6vDiWQn9ryY8Fdb5dvIHLCBdO+VJUtex8pLwDKj4e
 5ZC2HW+g18mJoSi4BjdTaD8PyTil6Yg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708016009;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JKA3XuZgeuWKkDBDniSCib2DmiM7CNBysAwz9GmmmBM=;
 b=8cCiw58uAW3vVFESczX3FjgGLeVJoFe/IZ1m2egxqaeWzaJil62bxhGzqUdmblfTKW2xC9
 z3aQdKl84LsvNcDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708016009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JKA3XuZgeuWKkDBDniSCib2DmiM7CNBysAwz9GmmmBM=;
 b=0GSV/2x6JwHaR2iaKAh9E649uAwlMwtDJRi8cVgDyARwQnCzA1H7nu/YeTQs4pm22LF7le
 h6J6sN55kiwWSzLU0u9aNQOaOShCL6vDiWQn9ryY8Fdb5dvIHLCBdO+VJUtex8pLwDKj4e
 5ZC2HW+g18mJoSi4BjdTaD8PyTil6Yg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708016009;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JKA3XuZgeuWKkDBDniSCib2DmiM7CNBysAwz9GmmmBM=;
 b=8cCiw58uAW3vVFESczX3FjgGLeVJoFe/IZ1m2egxqaeWzaJil62bxhGzqUdmblfTKW2xC9
 z3aQdKl84LsvNcDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D1A713A53;
 Thu, 15 Feb 2024 16:53:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ap50MYhBzmXtCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 15 Feb 2024 16:53:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: migration-test random intermittent failure, openbsd VM
In-Reply-To: <CAFEAcA_cLRruqwz+3muBE-RfyV5RQgyrFgz4beeVo3TtGaoPXw@mail.gmail.com>
References: <CAFEAcA8p9BKCrn9EfFXTpHE+5w-_8zhtE_52SpZLuS-+zpF5Gg@mail.gmail.com>
 <87plx6bzo8.fsf@suse.de>
 <CAFEAcA_cLRruqwz+3muBE-RfyV5RQgyrFgz4beeVo3TtGaoPXw@mail.gmail.com>
Date: Thu, 15 Feb 2024 13:53:26 -0300
Message-ID: <875xypsm7t.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[99.99%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linaro.org:email];
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 8 Feb 2024 at 18:04, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> +cc Daniel.
>>
>> > Random intermittent in migration-test when running the tests
>> > in the openbsd VM (i.e. what you get from 'make -C build vm-build-openbsd')
>> > Any ideas?
>>
>> Where's your HEAD at?
>
> 03e4bc0bc02 in this case.
>
> thanks
> -- PMM

I spent some time on this today, it reproduces inconsistently and I
couldn't find much.

The only thing I noticed so far is that when the tests fail, netstat
shows several ports at TIME_WAIT TCP state, including the one that just
got rejected. Maybe some issue with how we're closing these sockets
vs. the openbsd network stack implementation. But that's a long shot
without more investigation.


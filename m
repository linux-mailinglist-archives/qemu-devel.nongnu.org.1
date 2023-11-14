Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAC97EA862
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 02:52:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2iZl-00055v-0F; Mon, 13 Nov 2023 20:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r2iZj-00055n-Ki
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 20:50:47 -0500
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r2iZi-0004qg-2P
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 20:50:47 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6356C218A8;
 Tue, 14 Nov 2023 01:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699926642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uNpKyew8GJg07M4rXwnge64SxoI4SsnUZt0hTAIK/Jo=;
 b=Tw76aMWglWJvkIauv93eYwPgNWRvks7k/u5zxgZj5BkulNFC1R9Nwq/H4s0BiSudxHpRqQ
 uM4lVF2I7s2MdyMUjRMFk1o6OiycrIsREp20jDoeZl5YnWwTeS3aTKw5RSrkHUhg5T7SCG
 q9CZOhjdb9uh3uCBrslJZ5SoHfG7qbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699926642;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uNpKyew8GJg07M4rXwnge64SxoI4SsnUZt0hTAIK/Jo=;
 b=cO5swB2sVY/WrG9IdHs4djWROytIIOv3hIQkeR+XuZXPDU6dlBj6jgP+EH+DZ5/h04olbD
 laemCukKMyFKHyAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E93D4132F1;
 Tue, 14 Nov 2023 01:50:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OfRBLHHSUmWPWAAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 14 Nov 2023 01:50:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Leonardo
 Bras <leobras@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [RFC PATCH 2/2] migration/multifd: Move semaphore release into
 main thread
In-Reply-To: <ZVJSx6FOg8WfSbrz@x1n>
References: <20231109165856.15224-1-farosas@suse.de>
 <20231109165856.15224-3-farosas@suse.de> <ZU0rY662a5C1mvyf@x1n>
 <87pm0hzucq.fsf@suse.de> <ZVJSx6FOg8WfSbrz@x1n>
Date: Mon, 13 Nov 2023 22:50:39 -0300
Message-ID: <877cml5ci8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Nov 10, 2023 at 09:05:41AM -0300, Fabiano Rosas wrote:
>
> [...]
>
>> > Then assuming we have a clear model with all these threads issue fixed (no
>> > matter whether we'd shrink 2N threads into N threads), then what we need to
>> > do, IMHO, is making sure to join() all of them before destroying anything
>> > (say, per-channel MultiFDSendParams).  Then when we destroy everything
>> > safely, either mutex/sem/etc..  Because no one will race us anymore.
>> 
>> This doesn't address the race. There's a data dependency between the
>> multifd channels and the migration thread around the channels_ready
>> semaphore. So we cannot join the migration thread because it could be
>> stuck waiting for the semaphore, which means we cannot join+cleanup the
>> channel thread because the semaphore is still being used.
>
> I think this is the major part of confusion, on why this can happen.
>
> The problem is afaik multifd_save_cleanup() is only called by
> migrate_fd_cleanup(), which is further only called in:
>
>   1) migrate_fd_cleanup_bh()
>   2) migrate_fd_connect()
>
> For 1): it's only run when migration comletes/fails/etc. (in all cases,
> right before it quits..) and then kicks off migrate_fd_cleanup_schedule().
> So migration thread shouldn't be stuck, afaiu, or it won't be able to kick
> that BH.
>
> For 2): it's called by the main thread, where migration thread should have
> not yet been created.
>
> With that, I don't see how migrate_fd_cleanup() would need to worry about
> migration thread
>
> Did I miss something?

There are two points:

1) multifd_new_send_channel_async() doesn't set an Error. Even if
multifd_channel_connect() fails, we'll still continue with
migrate_fd_connect(). I don't see any code that looks at the migration
error (s->error).

2) the TLS handshake thread of one of the channels could simply not get
any chance to run until something else fails and we reach
multifd_save_cleanup() from the BH path.

This second point in particular is why I don't think simply joining the
TLS thread will avoid the race. There's nothing linking the multifd
channels together, we could have 7 of them operational and a 8th one
still going through the TLS handshake.

That said, I'm not sure about the exact path we take to reach the bug
situation. It's very hard to reproduce so I'm relying entirely on code
inspection.


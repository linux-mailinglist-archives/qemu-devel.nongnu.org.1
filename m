Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ABF7C7801
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 22:41:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr2Tf-0006v6-5Y; Thu, 12 Oct 2023 16:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qr2Tb-0006ut-SV; Thu, 12 Oct 2023 16:40:11 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qr2TZ-0004d3-PV; Thu, 12 Oct 2023 16:40:11 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1B748218A9;
 Thu, 12 Oct 2023 20:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697143206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EMQjqzMflilP67EVnZALNfHdMdnRHtlt5+QHTvZZbuI=;
 b=SZkJauHk0Q/q2fapC4Y6Dq+VoZcGiUMMeNmvFPgL6PnL/tA9XdFHyyJpvQLoRnFO49Uw6I
 uKQvIgZxDpp7xR+RKrQpWiSgrq5RfGgQVUlP5r1N7Vbbh1t5urPehHuy1OkL6WEUeHDR1b
 ZxygP9gaapd8N2fzRQxm0SsqgdbWbK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697143206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EMQjqzMflilP67EVnZALNfHdMdnRHtlt5+QHTvZZbuI=;
 b=ZXMidg1eZVHpeeI0Pf6pILKhLvt5BtmnN8bcm4jhaJ5X5lzfBJEuiE789zH0LUIjKHiy8E
 hk5IlgpldXCPXZCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2F91139ED;
 Thu, 12 Oct 2023 20:40:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LfFnG6VZKGXjRwAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 12 Oct 2023 20:40:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 jsnow@redhat.com, vsementsov@yandex-team.ru, eblake@redhat.com,
 leobras@redhat.com, peterx@redhat.com, quintela@redhat.com,
 pbonzini@redhat.com, t.lamprecht@proxmox.com
Subject: Re: [PATCH v4] migration: hold the BQL during setup
In-Reply-To: <20231012103307.371092-1-f.ebner@proxmox.com>
References: <20231012103307.371092-1-f.ebner@proxmox.com>
Date: Thu, 12 Oct 2023 17:40:03 -0300
Message-ID: <87mswnziak.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -4.10
X-Spamd-Result: default: False [-4.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.00)[11.19%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWELVE(0.00)[13];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fiona Ebner <f.ebner@proxmox.com> writes:

> This is intended to be a semantic revert of commit 9b09503752
> ("migration: run setup callbacks out of big lock"). There have been so
> many changes since that commit (e.g. a new setup callback
> dirty_bitmap_save_setup() that also needs to be adapted now), it's
> easier to do the revert manually.
>
> For snapshots, the bdrv_writev_vmstate() function is used during setup
> (in QIOChannelBlock backing the QEMUFile), but not holding the BQL
> while calling it could lead to an assertion failure. To understand
> how, first note the following:

Would it make sense to add a GLOBAL_STATE_CODE() annotation to
qio_channel_block_writev?

> 1. Generated coroutine wrappers for block layer functions spawn the
> coroutine and use AIO_WAIT_WHILE()/aio_poll() to wait for it.
> 2. If the host OS switches threads at an inconvenient time, it can
> happen that a bottom half scheduled for the main thread's AioContext
> is executed as part of a vCPU thread's aio_poll().
>
> An example leading to the assertion failure is as follows:
>
> main thread:
> 1. A snapshot-save QMP command gets issued.
> 2. snapshot_save_job_bh() is scheduled.
>
> vCPU thread:
> 3. aio_poll() for the main thread's AioContext is called (e.g. when
> the guest writes to a pflash device, as part of blk_pwrite which is a
> generated coroutine wrapper).
> 4. snapshot_save_job_bh() is executed as part of aio_poll().
> 3. qemu_savevm_state() is called.
> 4. qemu_mutex_unlock_iothread() is called. Now
> qemu_get_current_aio_context() returns 0x0.
> 5. bdrv_writev_vmstate() is executed during the usual savevm setup
> via qemu_fflush(). But this function is a generated coroutine wrapper,
> so it uses AIO_WAIT_WHILE. There, the assertion
> assert(qemu_get_current_aio_context() == qemu_get_aio_context());
> will fail.
>
> To fix it, ensure that the BQL is held during setup. While it would
> only be needed for snapshots, adapting migration too avoids additional
> logic for conditional locking/unlocking in the setup callbacks.
> Writing the header could (in theory) also trigger qemu_fflush() and
> thus bdrv_writev_vmstate(), so the locked section also covers the
> qemu_savevm_state_header() call, even for migration for consistentcy.
>
> The section around multifd_send_sync_main() needs to be unlocked to
> avoid a deadlock. In particular, the function calls

... the multifd_save_setup() function calls ...

otherwise this paragraph makes no sense.

> socket_send_channel_create() using multifd_new_send_channel_async() as
> a callback and then waits for the callback to signal via the
> channels_ready semaphore. The connection happens via
> qio_task_run_in_thread(), but the callback is only executed via
> qio_task_thread_result() which is scheduled for the main event loop.
> Without unlocking the section, the main thread would never get to
> process the task result and the callback meaning there would be no
> signal via the channels_ready semaphore.
>
> The comment in ram_init_bitmaps() was introduced by 4987783400
> ("migration: fix incorrect memory_global_dirty_log_start outside BQL")
> and is removed, because it referred to the qemu_mutex_lock_iothread()
> call.
>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

Thanks for taking the time to explain stuff in the commit message.

I dislike having unnecessary dependencies on the BQL throughout the
migration code, but I see people preferred that over conditional locking
in the previous versions, so in the name of consensus:

Reviewed-by: Fabiano Rosas <farosas@suse.de>



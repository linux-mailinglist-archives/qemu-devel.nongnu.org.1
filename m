Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 397627E607E
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 23:51:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0rNR-0007HL-Re; Wed, 08 Nov 2023 17:50:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r0rN8-0007Gu-0p
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 17:50:07 -0500
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r0rN2-0001gy-IX
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 17:50:05 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 24E4721976;
 Wed,  8 Nov 2023 22:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699483796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FS2PUeacwh90XR+a+FmmmI1eoPpLxsdcQh8tVy9iLSU=;
 b=sPcm6mLT5jYqWS/OxtCfTmMDWNJqDLL4LUQG34SwR1x98yvtCyTRuHp+IkTBTStjSS+G9f
 GgbzEGUaHSgGR5hVwQwsSe0zalAqXyqU0ne1F+Q4TMaTLy11qX6ApnlP7lW+zr/YFfOX51
 SPL8wKgIJOrNsOhm4CUPT7fbM2uQ7Mw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699483796;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FS2PUeacwh90XR+a+FmmmI1eoPpLxsdcQh8tVy9iLSU=;
 b=aQu/mC9Td5oLbn5HxH/djDGmUDXHZOl34/LYta2jLUtSxIMuzax2NSBmiLQoL6tvQNJill
 gXyAXjDtokGd8zDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A77D7138F2;
 Wed,  8 Nov 2023 22:49:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RuzWHJMQTGV6SQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 08 Nov 2023 22:49:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH RFC 3/7] migration: multifd_send_kick_main()
In-Reply-To: <20231022201211.452861-4-peterx@redhat.com>
References: <20231022201211.452861-1-peterx@redhat.com>
 <20231022201211.452861-4-peterx@redhat.com>
Date: Wed, 08 Nov 2023 19:49:53 -0300
Message-ID: <87zfznvp0u.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> When a multifd sender thread hit errors, it always needs to kick the main
> thread by kicking all the semaphores that it can be waiting upon.
>
> Provide a helper for it and deduplicate the code.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/multifd.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 4afdd88602..33fb21d0e4 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -374,6 +374,18 @@ struct {
>      MultiFDMethods *ops;
>  } *multifd_send_state;
>  
> +/*
> + * The migration thread can wait on either of the two semaphores.  This
> + * function can be used to kick the main thread out of waiting on either of
> + * them.  Should mostly only be called when something wrong happened with
> + * the current multifd send thread.
> + */
> +static void multifd_send_kick_main(MultiFDSendParams *p)
> +{
> +    qemu_sem_post(&p->sem_sync);
> +    qemu_sem_post(&multifd_send_state->channels_ready);
> +}
> +
>  /*
>   * How we use multifd_send_state->pages and channel->pages?
>   *
> @@ -746,8 +758,7 @@ out:
>          assert(local_err);
>          trace_multifd_send_error(p->id);
>          multifd_send_terminate_threads(local_err);
> -        qemu_sem_post(&p->sem_sync);
> -        qemu_sem_post(&multifd_send_state->channels_ready);
> +        multifd_send_kick_main(p);
>          error_free(local_err);
>      }
>  
> @@ -787,8 +798,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
>       * is not created, and then tell who pay attention to me.
>       */
>      p->quit = true;
> -    qemu_sem_post(&multifd_send_state->channels_ready);
> -    qemu_sem_post(&p->sem_sync);
> +    multifd_send_kick_main(p);

There's a bug here in the original code:

It's not really safe to call any of these outside of the channel lock
because multifd_save_cleanup() could execute at the same time and call
qemu_sem_destroy() -> qemu_mutex_destroy(), which can assert because we
might be holding the sem_lock.

It seems the reason we get away with this today is merely due to
timing. A subset of this problem was already encountered here:

[PATCH] migrate/multifd: fix coredump when the multifd thread cleanup
https://lore.kernel.org/r/20230621081826.3203053-1-zhangjianguo18@huawei.com

We could probably release the semaphores for all channels at once inside
multifd_save_cleanup() in the main thread. We'd have a
multifd_send_kick_main() in each channel when it fails and this:

void multifd_save_cleanup(void)
{
    ...   
    for (i = 0; i < migrate_multifd_channels(); i++) {
        MultiFDSendParams *p = &multifd_send_state->params[i];

        if (p->running) {
            qemu_thread_join(&p->thread);
        } else {
            multifd_send_kick_main(p);
        }
    }
    for (i = 0; i < migrate_multifd_channels(); i++) {
        qemu_sem_destroy, etc...
    }
    ...
}    


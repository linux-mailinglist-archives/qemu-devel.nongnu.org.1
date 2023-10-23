Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2E87D39E7
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 16:43:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quw8a-00050V-4e; Mon, 23 Oct 2023 10:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quw8Y-00050M-L6
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 10:42:34 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quw8X-000739-0g
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 10:42:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CD451218A2;
 Mon, 23 Oct 2023 14:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698072150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IRkwudxhs0rGYndURCylHFNmvnt4svpxpnNSB1en66s=;
 b=Rpgunwa7DaMHLcz9HMV2B7iBeZ7bpcl5m9kHqFBzRLvOZti1QWpZcwm/9IOsCRNhurhzS1
 sLLZES7Ae9eKEfB//PDsOHJuvyb73UHsAoQqeGO/YRD73EBPwfJKeDtsDBaOhPLKN1tLHO
 HPumBILgNE5c0kK9ccPuhriKvkERWj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698072150;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IRkwudxhs0rGYndURCylHFNmvnt4svpxpnNSB1en66s=;
 b=/Yl9qe2zDCF2m+pK7af8Jz1A+D5jyKa1yKcW5k1KSwCnoPMLa4wusSMzKKzdnHcUz1pdFr
 Dg9KJZN1zjX+VsAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62060139C2;
 Mon, 23 Oct 2023 14:42:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2H+nC1aGNmXTdgAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 14:42:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH RFC 4/7] migration: Drop MultiFDSendParams.quit and
 cleanup error paths
In-Reply-To: <20231022201211.452861-5-peterx@redhat.com>
References: <20231022201211.452861-1-peterx@redhat.com>
 <20231022201211.452861-5-peterx@redhat.com>
Date: Mon, 23 Oct 2023 11:42:28 -0300
Message-ID: <87jzrdz9gr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -5.05
X-Spamd-Result: default: False [-5.05 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.95)[86.65%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
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

Peter Xu <peterx@redhat.com> writes:

> Multifd send side has two fields to indicate error quits:
>
>   - MultiFDSendParams.quit
>   - &multifd_send_state->exiting
>
> Merge them into the global one.  The replacement is done by changing all
> p->quit checks into the global var check.  The global check doesn't need
> any lock.
>
> A few more things done on top of this altogether:
>
>   - multifd_send_terminate_threads()
>
>     Moving the xchg() of &multifd_send_state->exiting upper, so as to cover
>     the tracepoint, migrate_set_error() and migrate_set_state().
>
>   - multifd_send_sync_main()
>
>     In the 2nd loop, add one more check over the global var to make sure we
>     don't keep the looping if QEMU already decided to quit.
>
>   - multifd_tls_outgoing_handshake()
>
>     Use multifd_send_terminate_threads() to set the error state.  That has
>     a benefit of updating MigrationState.error to that error too, so we can
>     persist that 1st error we hit in that specific channel.
>
>   - multifd_new_send_channel_async()
>
>     Take similar approach like above, drop the migrate_set_error() because
>     multifd_send_terminate_threads() already covers that.  Unwrap the helper
>     multifd_new_send_channel_cleanup() along the way; not really needed.

This all looks good to me. I had a very similar patch in the works. Just
one comment below.

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/multifd.h |  2 --
>  migration/multifd.c | 82 ++++++++++++++-------------------------------
>  2 files changed, 26 insertions(+), 58 deletions(-)
>
> diff --git a/migration/multifd.h b/migration/multifd.h
> index a835643b48..2acf400085 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -97,8 +97,6 @@ typedef struct {
>      QemuMutex mutex;
>      /* is this channel thread running */
>      bool running;
> -    /* should this thread finish */
> -    bool quit;
>      /* multifd flags for each packet */
>      uint32_t flags;
>      /* global number of generated multifd packets */
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 33fb21d0e4..9d458914a9 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -411,10 +411,6 @@ static int multifd_send_pages(QEMUFile *f)
>      MultiFDSendParams *p = NULL; /* make happy gcc */
>      MultiFDPages_t *pages = multifd_send_state->pages;
>  
> -    if (qatomic_read(&multifd_send_state->exiting)) {
> -        return -1;
> -    }
> -

I'd keep this. This function can be called from outside of multifd code
so the channels could be completely gone already.



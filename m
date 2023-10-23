Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C397D3A82
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:16:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quwes-0001gQ-TW; Mon, 23 Oct 2023 11:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quweq-0001eQ-0V
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:15:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quweo-0007Pv-1P
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:15:55 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 596011FE24;
 Mon, 23 Oct 2023 15:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698074152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iO8tSSl183D7MQMUDQ7j0DuyMpF3qiIzBeKU8eMCvhQ=;
 b=ymtuZr+qB9toGXJshF9hVjhKNBqyKIV95CmXvgNHzrzuKR5zQ8W0gPx6ajw8q43LXXbyKa
 LTHZcQx9e1VY2PGotIyzLAofU6FyUVASp+VjDYhKjo7RL/QXkarSIxdRPOp362n3nT1uOb
 xOgFCg9Oc4HnjMvflZkd7qAf4RP0yug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698074152;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iO8tSSl183D7MQMUDQ7j0DuyMpF3qiIzBeKU8eMCvhQ=;
 b=d2L9SZ1T6jPL06wFnMwzg6l4Szhq/GoBmMnnUIGyFRtooL6SooiwNB9TW0HYHajJOmbENH
 7u6RCxKqegqRDXCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF3CC132FD;
 Mon, 23 Oct 2023 15:15:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id l9opKieONmWrCgAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 15:15:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH RFC 6/7] migration: Split multifd pending_job into two
 booleans
In-Reply-To: <20231022201211.452861-7-peterx@redhat.com>
References: <20231022201211.452861-1-peterx@redhat.com>
 <20231022201211.452861-7-peterx@redhat.com>
Date: Mon, 23 Oct 2023 12:15:49 -0300
Message-ID: <87bkcpz7x6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -4.14
X-Spamd-Result: default: False [-4.14 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.04)[57.73%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/multifd.h | 16 ++++++++++------
>  migration/multifd.c | 33 +++++++++++++++++++++++----------
>  2 files changed, 33 insertions(+), 16 deletions(-)
>
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 2acf400085..ddee7b8d8a 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -101,12 +101,16 @@ typedef struct {
>      uint32_t flags;
>      /* global number of generated multifd packets */
>      uint64_t packet_num;
> -    /* thread has work to do */
> -    int pending_job;
> -    /* array of pages to sent.
> -     * The owner of 'pages' depends of 'pending_job' value:
> -     * pending_job == 0 -> migration_thread can use it.
> -     * pending_job != 0 -> multifd_channel can use it.
> +    /* thread has a request to sync all data */
> +    bool pending_sync;
> +    /* thread has something to send */
> +    bool pending_job;
> +    /*
> +     * Array of pages to sent. The owner of 'pages' depends of
> +     * 'pending_job' value:
> +     *
> +     *   - true -> multifd_channel owns it.
> +     *   - false -> migration_thread owns it.
>       */
>      MultiFDPages_t *pages;
>  
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 8140520843..fe8d746ff9 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -425,7 +425,7 @@ static int multifd_send_pages(QEMUFile *f)
>          p = &multifd_send_state->params[i];
>          qemu_mutex_lock(&p->mutex);
>          if (!p->pending_job) {
> -            p->pending_job++;
> +            p->pending_job = true;
>              next_channel = (i + 1) % migrate_multifd_channels();
>              break;
>          }
> @@ -615,8 +615,7 @@ int multifd_send_sync_main(QEMUFile *f)
>  
>          qemu_mutex_lock(&p->mutex);
>          p->packet_num = multifd_send_state->packet_num++;
> -        p->flags |= MULTIFD_FLAG_SYNC;
> -        p->pending_job++;
> +        p->pending_sync = true;
>          qemu_mutex_unlock(&p->mutex);
>          qemu_sem_post(&p->sem);
>      }
> @@ -747,8 +746,6 @@ static void *multifd_send_thread(void *opaque)
>  
>          qemu_mutex_lock(&p->mutex);
>          if (p->pending_job) {
> -            bool need_sync = p->flags & MULTIFD_FLAG_SYNC;
> -
>              if (!multifd_send_prepare(p, &local_err)) {
>                  assert(local_err);
>                  qemu_mutex_unlock(&p->mutex);
> @@ -764,12 +761,27 @@ static void *multifd_send_thread(void *opaque)
>              qemu_mutex_lock(&p->mutex);
>  
>              /* Send successful, mark the task completed */
> -            p->pending_job--;
> +            p->pending_job = false;
> +
> +        } else if (p->pending_sync) {

Is your intention here to stop sending the SYNC along with the pages?
This would have to loop once more to send the sync.



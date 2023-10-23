Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DC07D38AB
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 15:59:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quvRH-0001bM-6F; Mon, 23 Oct 2023 09:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quvRB-0001Wq-CC
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:57:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quvR9-0002Rz-6L
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:57:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8C06C1FE18;
 Mon, 23 Oct 2023 13:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698069461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HxcX6/XmLw+D1PwZFGsdUQJVYzWE2/dZVDlqUFSeVGA=;
 b=dXHqJD/iJ5/rCJiH47Hquk0/94vDp1Ca9RE/NUEoPJLxL0kzx/kGtGb+Qlj9TmR6jaM0rv
 c8xOSgGToWuHZtYfFrY/AaG4VQa6IJKU9URaFMBIlwoJjGDiC7iJlbhR/s7GtOrpM3Z7bT
 EdqhsbjJXN0cG5FwgiDmSsFBhtvLZJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698069461;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HxcX6/XmLw+D1PwZFGsdUQJVYzWE2/dZVDlqUFSeVGA=;
 b=0PFJHzx1/U7afm34NoRf7fJaBioL2Le7YWa5eFLvUqeDtc96eQPTevG/l2ukcp0XHbNOmb
 bG7r8YVlNHanoUDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15402132FD;
 Mon, 23 Oct 2023 13:57:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EqCdNNR7NmXqXgAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 13:57:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>, Juan
 Quintela <quintela@redhat.com>, Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v2 07/11] migration: Create compress_update_rates()
In-Reply-To: <20231019110724.15324-8-quintela@redhat.com>
References: <20231019110724.15324-1-quintela@redhat.com>
 <20231019110724.15324-8-quintela@redhat.com>
Date: Mon, 23 Oct 2023 10:57:38 -0300
Message-ID: <874jih1lwt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -6.64
X-Spamd-Result: default: False [-6.64 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-2.54)[97.92%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[web.de];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-3.00)[-1.000];
 RCPT_COUNT_FIVE(0.00)[6];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,web.de]
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

Juan Quintela <quintela@redhat.com> writes:

> So we can move more compression_counters stuff to ram-compress.c.
> Create compression_counters struct to add the stuff that was on
> MigrationState.
>
> Reviewed-by: Lukas Straub <lukasstraub2@web.de>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram-compress.h |  1 +
>  migration/ram.h          |  1 -
>  migration/ram-compress.c | 42 +++++++++++++++++++++++++++++++++++++++-
>  migration/ram.c          | 29 +--------------------------
>  4 files changed, 43 insertions(+), 30 deletions(-)
>
> diff --git a/migration/ram-compress.h b/migration/ram-compress.h
> index b228640092..76dacd3ec7 100644
> --- a/migration/ram-compress.h
> +++ b/migration/ram-compress.h
> @@ -71,5 +71,6 @@ void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len);
>  void populate_compress(MigrationInfo *info);
>  uint64_t ram_compressed_pages(void);
>  void update_compress_thread_counts(const CompressParam *param, int bytes_xmit);
> +void compress_update_rates(uint64_t page_count);
>  
>  #endif
> diff --git a/migration/ram.h b/migration/ram.h
> index 145c915ca7..9cf8f58e97 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -34,7 +34,6 @@
>  #include "io/channel.h"
>  
>  extern XBZRLECacheStats xbzrle_counters;
> -extern CompressionStats compression_counters;
>  
>  /* Should be holding either ram_list.mutex, or the RCU lock. */
>  #define RAMBLOCK_FOREACH_NOT_IGNORED(block)            \
> diff --git a/migration/ram-compress.c b/migration/ram-compress.c
> index f56e1f8e69..af42cab0fe 100644
> --- a/migration/ram-compress.c
> +++ b/migration/ram-compress.c
> @@ -41,7 +41,20 @@
>  #include "ram.h"
>  #include "migration-stats.h"
>  
> -CompressionStats compression_counters;

Could we remove CompressionStats from migration.json now?

Anyway:
Reviewed-by: Fabiano Rosas <farosas@suse.de>


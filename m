Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 485177EAFC0
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 13:22:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2sQW-00010D-EV; Tue, 14 Nov 2023 07:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r2sQN-0000z9-QB
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 07:21:47 -0500
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r2sQM-0005y3-Aj
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 07:21:47 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4DED91F86A;
 Tue, 14 Nov 2023 12:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699964504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dLhHLaPI8auL6sA6J6LP30S1Uv5qvRDJH2D8NUoDj4w=;
 b=bTx7kZQuz8f/7NpL4HuuWoT5gbtx0Jpn6ZeRUElXIfmAjKct1UsGV221ACrOpIsWDVMOxK
 7JCJw5xnw/H+SB6U4v5VdtRPUDPNiZP416ovoBmoXR2HERWGjW6YnURVhwo01egJYipKeU
 wvJaH8DCRf2OfxCrDPwitNuIomsSVFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699964504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dLhHLaPI8auL6sA6J6LP30S1Uv5qvRDJH2D8NUoDj4w=;
 b=86xuC9QvL/qIHA7nq9RPoFl2Ol9fs6Z9p1Mrrw0fl/yy6PHIzyKr010/i38V9joRkDASbo
 dUvxD9QRsdQqHmAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D358E13416;
 Tue, 14 Nov 2023 12:21:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mQT4JldmU2XfZgAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 14 Nov 2023 12:21:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Peter Maydell
 <peter.maydell@linaro.org>, Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH] migration: fix coverity migrate_mode finding
In-Reply-To: <1699907025-215450-1-git-send-email-steven.sistare@oracle.com>
References: <1699907025-215450-1-git-send-email-steven.sistare@oracle.com>
Date: Tue, 14 Nov 2023 09:21:41 -0300
Message-ID: <87zfzgbk4q.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -6.73
X-Spamd-Result: default: False [-6.73 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-2.63)[98.38%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Coverity diagnoses a possible out-of-range array index here ...
>
>     static GSList *migration_blockers[MIG_MODE__MAX];
>
>     fill_source_migration_info() {
>         GSList *cur_blocker = migration_blockers[migrate_mode()];
>
> ... because it does not know that MIG_MODE__MAX will never be returned as
> a migration mode.  To fix, assert so in migrate_mode().
>
> Fixes: fa3673e497a1 ("migration: per-mode blockers")
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  migration/options.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/migration/options.c b/migration/options.c
> index 8d8ec73..3e3e0b9 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -833,8 +833,10 @@ uint64_t migrate_max_postcopy_bandwidth(void)
>  MigMode migrate_mode(void)
>  {
>      MigrationState *s = migrate_get_current();
> +    MigMode mode = s->parameters.mode;
>  
> -    return s->parameters.mode;
> +    assert(mode >= 0 && mode < MIG_MODE__MAX);
> +    return mode;
>  }
>  
>  int migrate_multifd_channels(void)

Reviewed-by: Fabiano Rosas <farosas@suse.de>


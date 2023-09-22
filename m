Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A33F17AB7CF
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 19:39:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjk6X-0003Lk-TZ; Fri, 22 Sep 2023 13:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qjk6V-0003LO-KW
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 13:38:11 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qjk6U-0000AG-5d
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 13:38:11 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 146EA1FD7F;
 Fri, 22 Sep 2023 17:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695404287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MiSqJLQm9flimE6zMHoSwyy7soGWsscgW3c19hcJl1w=;
 b=OaHPW0jgQAlcXfTHPH2IfuATrZ4FqYOBqa1Zj6qA0+vqyscqgO8Fvn795YErTaZhx9x82N
 UpatvBuCVErZsvZS35p2aDCuMjUer9jtl+PbZ/FDt/Qoel3RhGybd5EEZep3Yaq8BB9gt5
 EPSaZRX+LDQACLNiJZwWZMCUryz/RB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695404287;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MiSqJLQm9flimE6zMHoSwyy7soGWsscgW3c19hcJl1w=;
 b=BoMpGiBkHxuvt1muqCQnsION8Qjw/yCRjw3CnkyKGL3g7TYnDlXRayIntvm/wwtjXahlq+
 OLHaZhk3q9BIZUBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90C1C13597;
 Fri, 22 Sep 2023 17:38:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id V6D7Fv7QDWVJWgAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 22 Sep 2023 17:38:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>, quintela@redhat.com,
 peterx@redhat.com, leobras@redhat.com
Cc: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/4] migration: check for rate_limit_max for
 RATE_LIMIT_DISABLED
In-Reply-To: <20230922065625.21848-3-elena.ufimtseva@oracle.com>
References: <20230922065625.21848-1-elena.ufimtseva@oracle.com>
 <20230922065625.21848-3-elena.ufimtseva@oracle.com>
Date: Fri, 22 Sep 2023 14:38:04 -0300
Message-ID: <877coim7lv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
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

Elena Ufimtseva <elena.ufimtseva@oracle.com> writes:

> In migration rate limiting atomic operations are used
> to read the rate limit variables and transferred bytes and
> they are expensive. Check first if rate_limit_max is equal
> to RATE_LIMIT_DISABLED and return false immediately if so.
>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  migration/migration-stats.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/migration/migration-stats.c b/migration/migration-stats.c
> index 095d6d75bb..abc31483d5 100644
> --- a/migration/migration-stats.c
> +++ b/migration/migration-stats.c
> @@ -24,14 +24,14 @@ bool migration_rate_exceeded(QEMUFile *f)
>          return true;
>      }
>  
> -    uint64_t rate_limit_start = stat64_get(&mig_stats.rate_limit_start);
> -    uint64_t rate_limit_current = migration_transferred_bytes(f);

There's a qemu_fflush() hiding inside migration_transferred_bytes(). It
currently always flushes if we haven't detected an error in the
file. After this patch we will stop flushing at this point if
ratelimiting is disabled.

You might want to add that information to the commit message to make it
easier to track if this ends up causing a regression.

Reviewed-by: Fabiano Rosas <farosas@suse.de>


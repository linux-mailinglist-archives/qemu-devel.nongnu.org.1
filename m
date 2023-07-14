Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23083753B79
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 15:06:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKIU4-0006e8-1q; Fri, 14 Jul 2023 09:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qKIU2-0006cg-CF; Fri, 14 Jul 2023 09:05:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qKIU0-00032w-Q5; Fri, 14 Jul 2023 09:05:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 09D111F86B;
 Fri, 14 Jul 2023 13:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689339915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uvuf7VRvZ1te6ZO9RJdGAAs1ZMlq1cqkm1Juh9QqCJk=;
 b=NE5+Uip6zBFaD4Tt/ZJll83uUV0RdY3biyJgpcV5k5A8vy7LvTlERz/Gf7HjVNBwcZn83S
 rL3CCR4RSMI53Ku3SYpn0DW2TQgCjjFy1z0IHQ0w9OK7Dlf/6V8e87rS7YSM7KuwxVZlT1
 qma6YxKRcEu38YLgPrOk+MeVFv65aM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689339915;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uvuf7VRvZ1te6ZO9RJdGAAs1ZMlq1cqkm1Juh9QqCJk=;
 b=QRqg7YKa2fWOQHa90t4ZBt7L84vVH9eh5F2LjZwejnLE1GsWWmucGVOHxXAeVFoS3BqMwU
 Ovn+4JA0Cm7nZWCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FE1813A15;
 Fri, 14 Jul 2023 13:05:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8ryaFgpIsWRBZgAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 14 Jul 2023 13:05:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH, trivial 24/29] tree-wide spelling fixes in comments and
 some messages: migration/
In-Reply-To: <20230714113834.1186117-26-mjt@tls.msk.ru>
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
 <20230714113834.1186117-26-mjt@tls.msk.ru>
Date: Fri, 14 Jul 2023 10:05:12 -0300
Message-ID: <87sf9qiqyf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  migration/migration-stats.c | 2 +-
>  migration/migration.h       | 4 ++--
>  migration/multifd-zlib.c    | 2 +-
>  migration/multifd-zstd.c    | 2 +-
>  migration/multifd.c         | 2 +-
>  migration/savevm.c          | 2 +-
>  migration/trace-events      | 2 +-
>  7 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/migration/migration-stats.c b/migration/migration-stats.c
> index f98c8260be..f195e89732 100644
> --- a/migration/migration-stats.c
> +++ b/migration/migration-stats.c
> @@ -50,3 +50,3 @@ void migration_rate_set(uint64_t limit)
>      /*
> -     * 'limit' is per second.  But we check it each BUFER_DELAY miliseconds.
> +     * 'limit' is per second.  But we check it each BUFER_DELAY milliseconds.

BUFER is a typo here as well.

Aside from that:

Reviewed-by: Fabiano Rosas <farosas@suse.de>


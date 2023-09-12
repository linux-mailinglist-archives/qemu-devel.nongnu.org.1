Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA97F79C127
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 02:33:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfrKl-0007qd-PO; Mon, 11 Sep 2023 20:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qfrKj-0007qE-07
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 20:32:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qfrKg-0004AG-RX
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 20:32:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 34F5621835;
 Tue, 12 Sep 2023 00:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694478765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uJOLrNSQopeUDuPwTgUcWu/GdzKWO/d/LUUN1BU6rxA=;
 b=cIHWMRvUMLQ6/jwuO8KM5835TjVe1S2WswmGP2GtDWBLglZOLWwqYhq0d+BNXeJrkKaiJp
 7DdQEFpaPyNTxPwplWMJUjFVhJVCC3+QxmtWPI1AFiP99xEIZrVBoK4IymKFi51baVnsR+
 kvUcSsGL+1IQZqUzal9pLPp+5T1uxBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694478765;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uJOLrNSQopeUDuPwTgUcWu/GdzKWO/d/LUUN1BU6rxA=;
 b=W/FHXgRH3mh5wMdBJF5giN8ypcYukBmhryrKSFVylwpx73HtXaIEpq5Mf8ZCHPU4iEbdb3
 7x4/3hCKL1GVbOBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C29413780;
 Tue, 12 Sep 2023 00:32:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6PM8D6yx/2QCVgAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 12 Sep 2023 00:32:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 8/9] migration: Add migration_rp_wait|kick()
In-Reply-To: <20230829214235.69309-9-peterx@redhat.com>
References: <20230829214235.69309-1-peterx@redhat.com>
 <20230829214235.69309-9-peterx@redhat.com>
Date: Mon, 11 Sep 2023 21:32:41 -0300
Message-ID: <874jk0mdsm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

> It's just a simple wrapper for rp_sem on either wait() or kick(), make it
> even clearer on how it is used.  Prepared to be used even for other things.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.h | 15 +++++++++++++++
>  migration/migration.c |  4 ++--
>  migration/ram.c       | 16 +++++++---------
>  3 files changed, 24 insertions(+), 11 deletions(-)
>
> diff --git a/migration/migration.h b/migration/migration.h
> index a5c95e4d43..b6de78dbdd 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -304,6 +304,12 @@ struct MigrationState {
>           * be cleared in the rp_thread!
>           */
>          bool          rp_thread_created;
> +        /*
> +         * Used to synchonize between migration main thread and return path

synchronize

Reviewed-by: Fabiano Rosas <farosas@suse.de>


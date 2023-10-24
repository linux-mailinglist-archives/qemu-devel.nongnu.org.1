Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 872667D59DC
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:41:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvLOO-0002mu-C3; Tue, 24 Oct 2023 13:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qvLOF-0002jR-3o; Tue, 24 Oct 2023 13:40:27 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qvLOD-0004pi-1Q; Tue, 24 Oct 2023 13:40:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 503FB21C23;
 Tue, 24 Oct 2023 17:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698169223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jVB2fQpgn0k13SkXPQ10qeCffZ9TzQoVTI5CxnDN8t8=;
 b=AnTZb1/LhqyEGp2q6xz2EQli1z5pqGivATK8iOI6/8clPty5sa4EsNIt5wiKKv5eGFSpd/
 yT4KkNWIde5Qo7I6/7CsMn8HzZ61TjiRqWNH9KQXBSGcixuMwHKamMLk9AIlfH/60ZB00Z
 dESbqTD9t+QdAhciEPG3QsrS7mmEy+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698169223;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jVB2fQpgn0k13SkXPQ10qeCffZ9TzQoVTI5CxnDN8t8=;
 b=7AyMNi9ouKHNLrU014UiPgeJZ5FR+6jQQ8kSsRVtgoPsAK7wU0kTfKx+UaWzgE+7hi9Prn
 rsRG6cInyVkw8RAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49F8D13A96;
 Tue, 24 Oct 2023 17:40:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bBZUBXQBOGXBDgAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 24 Oct 2023 17:40:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, =?utf-8?Q?Daniel_P?=
 =?utf-8?Q?_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Hailiang Zhang
 <zhanghailiang@xfusion.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter
 Xu <peterx@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 04/12] migration: Use the number of transferred bytes
 directly
In-Reply-To: <20231024151042.90349-5-quintela@redhat.com>
References: <20231024151042.90349-1-quintela@redhat.com>
 <20231024151042.90349-5-quintela@redhat.com>
Date: Tue, 24 Oct 2023 14:40:01 -0300
Message-ID: <871qdjudfy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -7.10
X-Spamd-Result: default: False [-7.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[99.99%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[11];
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

Juan Quintela <quintela@redhat.com> writes:

> We only use migration_transferred_bytes() to calculate the rate_limit,
> for that we don't need to flush whatever is on the qemu_file buffer.
> Remember that the buffer is really small (normal case is 32K if we use
> iov's can be 64 * TARGET_PAGE_SIZE), so this is not relevant to
> calculations.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration-stats.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/migration-stats.c b/migration/migration-stats.c
> index 4cc989d975..1d9197b4c3 100644
> --- a/migration/migration-stats.c
> +++ b/migration/migration-stats.c
> @@ -63,7 +63,7 @@ uint64_t migration_transferred_bytes(QEMUFile *f)
>  {
>      uint64_t multifd = stat64_get(&mig_stats.multifd_bytes);
>      uint64_t rdma = stat64_get(&mig_stats.rdma_bytes);
> -    uint64_t qemu_file = qemu_file_transferred(f);
> +    uint64_t qemu_file = stat64_get(&mig_stats.qemu_file_transferred);
>  
>      trace_migration_transferred_bytes(qemu_file, multifd, rdma);
>      return qemu_file + multifd + rdma;

Reviewed-by: Fabiano Rosas <farosas@suse.de>


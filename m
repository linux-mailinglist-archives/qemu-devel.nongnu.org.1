Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE827D59F0
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:49:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvLXB-0002tE-3V; Tue, 24 Oct 2023 13:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qvLWR-00021G-F4; Tue, 24 Oct 2023 13:49:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qvLWO-0007SC-Tw; Tue, 24 Oct 2023 13:48:55 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 06E0E1FE9A;
 Tue, 24 Oct 2023 17:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698169731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1C8AVkUYKZ+09YmhLT9DghKZNz4eO1ll8FRI0iGzQc0=;
 b=IsJwn+BoyufCuLC2TFcI4KiS4o9e4mbuOAS8t1Gmg3bUfdEGTdflTpNW6vI2T7f7XKeXt2
 nREpkC9fqSnOKRs+SMpkdPS4W26TvGVhPGs0RXePOXqxsICOl9GM8hEyMyYT3ugFVukJQs
 1npCI/uXqjHkE8jekO73tqQYOIJjgbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698169731;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1C8AVkUYKZ+09YmhLT9DghKZNz4eO1ll8FRI0iGzQc0=;
 b=ZegY5/CwpFXsji1b9DOo1LizevQUr167wp32sjr0t+K6OSxCRdLHoE+iKLwQYsCJvuJ0cJ
 RWJG8P9T+Cje+FCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E2F21391C;
 Tue, 24 Oct 2023 17:48:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7HROFoIDOGWREgAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 24 Oct 2023 17:48:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, =?utf-8?Q?Daniel_P?=
 =?utf-8?Q?_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Hailiang Zhang
 <zhanghailiang@xfusion.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter
 Xu <peterx@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 11/12] migration: Remove transferred atomic counter
In-Reply-To: <20231024151042.90349-12-quintela@redhat.com>
References: <20231024151042.90349-1-quintela@redhat.com>
 <20231024151042.90349-12-quintela@redhat.com>
Date: Tue, 24 Oct 2023 14:48:48 -0300
Message-ID: <87pm13sygv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -7.07
X-Spamd-Result: default: False [-7.07 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-2.97)[99.88%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[11];
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

> After last commit, it is a write only variable.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration-stats.h | 4 ----
>  migration/multifd.c         | 3 ---
>  migration/ram.c             | 1 -
>  3 files changed, 8 deletions(-)
>
> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> index 68f3939188..05290ade76 100644
> --- a/migration/migration-stats.h
> +++ b/migration/migration-stats.h
> @@ -97,10 +97,6 @@ typedef struct {
>       * Number of bytes sent through RDMA.
>       */
>      Stat64 rdma_bytes;
> -    /*
> -     * Total number of bytes transferred.
> -     */
> -    Stat64 transferred;
>      /*
>       * Number of pages transferred that were full of zeros.
>       */
> diff --git a/migration/multifd.c b/migration/multifd.c
> index e2a45c667a..ec58c58082 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -188,7 +188,6 @@ static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
>          return -1;
>      }
>      stat64_add(&mig_stats.multifd_bytes, size);
> -    stat64_add(&mig_stats.transferred, size);
>      return 0;
>  }
>  
> @@ -733,8 +732,6 @@ static void *multifd_send_thread(void *opaque)
>  
>              stat64_add(&mig_stats.multifd_bytes,
>                         p->next_packet_size + p->packet_len);
> -            stat64_add(&mig_stats.transferred,
> -                       p->next_packet_size + p->packet_len);
>              p->next_packet_size = 0;
>              qemu_mutex_lock(&p->mutex);
>              p->pending_job--;
> diff --git a/migration/ram.c b/migration/ram.c
> index 5ccf70333a..6d2bf50614 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -455,7 +455,6 @@ void ram_transferred_add(uint64_t bytes)
>      } else {
>          stat64_add(&mig_stats.downtime_bytes, bytes);
>      }
> -    stat64_add(&mig_stats.transferred, bytes);
>  }
>  
>  struct MigrationOps {

Reviewed-by: Fabiano Rosas <farosas@suse.de>


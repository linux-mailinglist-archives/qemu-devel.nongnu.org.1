Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D687D59D1
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:36:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvLJS-0008DF-67; Tue, 24 Oct 2023 13:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qvLJP-0008Bs-D7; Tue, 24 Oct 2023 13:35:27 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qvLJN-0003ai-Sr; Tue, 24 Oct 2023 13:35:27 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2C7BF1FE99;
 Tue, 24 Oct 2023 17:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698168924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+IvY7egBWqVdc+y0FDtcn8nUmJhhl6cgBj2Y0unsrZI=;
 b=GdERmuc4jvsvvGM/04gtU7ZOBGPK3ChMFRvFEmuxMbcMBDb148BZE7X18U5LDV14NEMiOE
 B6Cr0c1ctj3Ey1J7BT2TjIqy3JbZfDCLsuyt/BKmJm34C2S3bSmeDs5/zDvWFYO7PgMZmx
 bq5yfaC5Jj6r98o3qsd9zDG5X7vUrGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698168924;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+IvY7egBWqVdc+y0FDtcn8nUmJhhl6cgBj2Y0unsrZI=;
 b=foCZRT7lVuvYF8QYgTjRjMlH+Rym9lDrVzAlJKyVMAIfLYNoDYwv6ZRoyGUTR7N8PhUdmC
 WFKz/NBTIHFe4xAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0E771391C;
 Tue, 24 Oct 2023 17:35:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id B2ULH1sAOGWWDAAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 24 Oct 2023 17:35:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, =?utf-8?Q?Daniel_P?=
 =?utf-8?Q?_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Hailiang Zhang
 <zhanghailiang@xfusion.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter
 Xu <peterx@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 03/12] qemu_file: total_transferred is not used anymore
In-Reply-To: <20231024151042.90349-4-quintela@redhat.com>
References: <20231024151042.90349-1-quintela@redhat.com>
 <20231024151042.90349-4-quintela@redhat.com>
Date: Tue, 24 Oct 2023 14:35:21 -0300
Message-ID: <874jifudnq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
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

Juan Quintela <quintela@redhat.com> writes:

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/qemu-file.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 384985f534..641ab703cc 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -41,9 +41,6 @@ struct QEMUFile {
>      QIOChannel *ioc;
>      bool is_writable;
>  
> -    /* The sum of bytes transferred on the wire */
> -    uint64_t total_transferred;
> -
>      int buf_index;
>      int buf_size; /* 0 when writing */
>      uint8_t buf[IO_BUF_SIZE];
> @@ -282,7 +279,6 @@ void qemu_fflush(QEMUFile *f)
>              qemu_file_set_error_obj(f, -EIO, local_error);
>          } else {
>              uint64_t size = iov_size(f->iov, f->iovcnt);
> -            f->total_transferred += size;
>              stat64_add(&mig_stats.qemu_file_transferred, size);
>          }

Reviewed-by: Fabiano Rosas <farosas@suse.de>


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDF97D59DA
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:41:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvLOl-000394-BE; Tue, 24 Oct 2023 13:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qvLOb-00038I-Rp; Tue, 24 Oct 2023 13:40:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qvLOU-00050j-E2; Tue, 24 Oct 2023 13:40:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4EACF21C23;
 Tue, 24 Oct 2023 17:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698169237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BXrg3hIIFC3yW7ElEjZQ4YOH5R26W5IUSsglIfh9Txc=;
 b=bVIAtJYgZkcvvXMLdFuyq2OVDRQ6ETP21s+vuIyz+YvOkH7Y83n5p+k7baQkyWVqh1ZSP5
 25vVGre4uLfRL0+SgjJ8ysgwS1JnzjU3nKMfmI6DnDfJir12hLxA5KTp75/FAYCpVVtGT7
 tL5Zg+rvCnFR4ylUGdGGGw7QEoYPNTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698169237;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BXrg3hIIFC3yW7ElEjZQ4YOH5R26W5IUSsglIfh9Txc=;
 b=Rnf0vpS9XCN5REbH8bSXHgp0SQ99n/tCKzcgcydDJs2eegKIpCLureHAOBXYQJFigLO8AC
 MO5O7RB+SjC+4UAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5B4F1391C;
 Tue, 24 Oct 2023 17:40:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id u3TxJ5QBOGUGDwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 24 Oct 2023 17:40:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, =?utf-8?Q?Daniel_P?=
 =?utf-8?Q?_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Hailiang Zhang
 <zhanghailiang@xfusion.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter
 Xu <peterx@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 05/12] qemu_file: Remove unused qemu_file_transferred()
In-Reply-To: <20231024151042.90349-6-quintela@redhat.com>
References: <20231024151042.90349-1-quintela@redhat.com>
 <20231024151042.90349-6-quintela@redhat.com>
Date: Tue, 24 Oct 2023 14:40:34 -0300
Message-ID: <87y1frsyul.fsf@suse.de>
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

Juan Quintela <quintela@redhat.com> writes:

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/qemu-file.h | 18 ------------------
>  migration/qemu-file.c |  7 -------
>  2 files changed, 25 deletions(-)
>
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index a29c37b0d0..8b71152754 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -33,24 +33,6 @@ QEMUFile *qemu_file_new_input(QIOChannel *ioc);
>  QEMUFile *qemu_file_new_output(QIOChannel *ioc);
>  int qemu_fclose(QEMUFile *f);
>  
> -/*
> - * qemu_file_transferred:
> - *
> - * Report the total number of bytes transferred with
> - * this file.
> - *
> - * For writable files, any pending buffers will be
> - * flushed, so the reported value will be equal to
> - * the number of bytes transferred on the wire.
> - *
> - * For readable files, the reported value will be
> - * equal to the number of bytes transferred on the
> - * wire.
> - *
> - * Returns: the total bytes transferred
> - */
> -uint64_t qemu_file_transferred(QEMUFile *f);
> -
>  /*
>   * qemu_file_transferred_noflush:
>   *
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 641ab703cc..efa5f11033 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -632,13 +632,6 @@ uint64_t qemu_file_transferred_noflush(QEMUFile *f)
>      return ret;
>  }
>  
> -uint64_t qemu_file_transferred(QEMUFile *f)
> -{
> -    g_assert(qemu_file_is_writable(f));
> -    qemu_fflush(f);
> -    return stat64_get(&mig_stats.qemu_file_transferred);
> -}
> -
>  void qemu_put_be16(QEMUFile *f, unsigned int v)
>  {
>      qemu_put_byte(f, v >> 8);

Reviewed-by: Fabiano Rosas <farosas@suse.de>


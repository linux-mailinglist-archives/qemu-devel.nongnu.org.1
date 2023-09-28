Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF25A7B1F60
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 16:21:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlrsU-0004db-3e; Thu, 28 Sep 2023 10:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qlrsQ-0004cy-5E
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 10:20:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qlrsB-00074Y-Mj
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 10:20:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 228271F88F;
 Thu, 28 Sep 2023 14:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695910810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ko7ONwkBcrmLlz+23SlGc50YvgC5H/TjaYihb8aQXBA=;
 b=ypwPSXcglQLDSAVe8WKD51EWX9Ni/c53XNvcuRuL35+hUSJWDJE4owaPCzyL3L3J7+BM0Y
 xhIf71KEemuqITp3WoHnu7kOELESWbFrlGf79/5qWaeEwYH2AjkId5tElLf7oivqW6ZMr7
 64lRjy8SfLKkTcOOmzo1Jn3wUFm1swQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695910810;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ko7ONwkBcrmLlz+23SlGc50YvgC5H/TjaYihb8aQXBA=;
 b=sFNIER99ic0utJzczX0YgsXN4jI0ESWnl1TgExRaDlMIPsshKGQl+VeXLu9dkCUQcAI7jo
 FDEiXjIMiN5cWgDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA9E413581;
 Thu, 28 Sep 2023 14:20:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zll/HZmLFWX1CwAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 28 Sep 2023 14:20:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 lizhijian@fujitsu.com, eblake@redhat.com
Subject: Re: [PATCH v2 06/53] migration/rdma: Fix unwanted integer truncation
In-Reply-To: <20230928132019.2544702-7-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-7-armbru@redhat.com>
Date: Thu, 28 Sep 2023 11:20:07 -0300
Message-ID: <87wmwamlbc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
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

Markus Armbruster <armbru@redhat.com> writes:

> qio_channel_rdma_readv() assigns the size_t value of qemu_rdma_fill()
> to an int variable before it adds it to @done / subtracts it from
> @want, both size_t.  Truncation when qemu_rdma_fill() copies more than
> INT_MAX bytes.  Seems vanishingly unlikely, but needs fixing all the
> same.
>
> Fixes: 6ddd2d76ca6f (migration: convert RDMA to use QIOChannel interface)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  migration/rdma.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 4289346617..5f423f66f0 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -2852,7 +2852,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
>      RDMAControlHeader head;
>      int ret = 0;
>      ssize_t i;
> -    size_t done = 0;
> +    size_t done = 0, len;
>  
>      RCU_READ_LOCK_GUARD();
>      rdma = qatomic_rcu_read(&rioc->rdmain);
> @@ -2873,9 +2873,9 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
>           * were given and dish out the bytes until we run
>           * out of bytes.
>           */
> -        ret = qemu_rdma_fill(rdma, data, want, 0);
> -        done += ret;
> -        want -= ret;
> +        len = qemu_rdma_fill(rdma, data, want, 0);
> +        done += len;
> +        want -= len;
>          /* Got what we needed, so go to next iovec */
>          if (want == 0) {
>              continue;
> @@ -2902,9 +2902,9 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
>          /*
>           * SEND was received with new bytes, now try again.
>           */
> -        ret = qemu_rdma_fill(rdma, data, want, 0);
> -        done += ret;
> -        want -= ret;
> +        len = qemu_rdma_fill(rdma, data, want, 0);
> +        done += len;
> +        want -= len;
>  
>          /* Still didn't get enough, so lets just return */
>          if (want) {

Reviewed-by: Fabiano Rosas <farosas@suse.de>


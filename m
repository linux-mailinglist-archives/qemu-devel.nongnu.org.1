Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 176927B3700
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 17:38:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmFXc-0005CN-HY; Fri, 29 Sep 2023 11:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qmFXZ-0005Af-Vv
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 11:36:29 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qmFXV-0005bb-3p
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 11:36:29 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A4B1E1F45E;
 Fri, 29 Sep 2023 15:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696001783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6VV1UQHEAj5QQ2LsHlLxLjKw/4PsTzbKZv5GhFhOIQ0=;
 b=EEUMGDMEIc/J81d5veH7WV24u6jUsTxidzvzlJOnuWKCUzMNvas0eeM1BaHaFbnpSLsr/i
 7psAvYmSfSgLDxxPJeROFTLN+5Yyfi7vSJgYzuSRVW7onYFUfZMKIovVpgLcQb5SUuAP9O
 yNxGtVChe30InEIBP71+rQkG2acxKAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696001783;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6VV1UQHEAj5QQ2LsHlLxLjKw/4PsTzbKZv5GhFhOIQ0=;
 b=LIGY1zQHpNFoytyXUVaO7xGbLytG1w0q3in0dm8+zj9b75RFoT1IlG9DZIvUNtw4T3eKUB
 VB6zvBFwcILbHwAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38A5413434;
 Fri, 29 Sep 2023 15:36:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id F7Z9AffuFmWkPAAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 29 Sep 2023 15:36:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 lizhijian@fujitsu.com, eblake@redhat.com
Subject: Re: [PATCH v2 52/53] migration/rdma: Use error_report() & friends
 instead of stderr
In-Reply-To: <20230928132019.2544702-53-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-53-armbru@redhat.com>
Date: Fri, 29 Sep 2023 12:36:20 -0300
Message-ID: <87msx5yosr.fsf@suse.de>
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

Markus Armbruster <armbru@redhat.com> writes:

> error_report() obeys -msg, reports the current error location if any,
> and reports to the current monitor if any.  Reporting to stderr
> directly with fprintf() or perror() is wrong, because it loses all
> this.
>
> Fix the offenders.  Bonus: resolves a FIXME about problematic use of
> errno.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  migration/rdma.c | 44 +++++++++++++++++++++-----------------------
>  1 file changed, 21 insertions(+), 23 deletions(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 54b59d12b1..dba0802fca 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -877,12 +877,12 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
>  
>          if (roce_found) {
>              if (ib_found) {
> -                fprintf(stderr, "WARN: migrations may fail:"
> -                                " IPv6 over RoCE / iWARP in linux"
> -                                " is broken. But since you appear to have a"
> -                                " mixed RoCE / IB environment, be sure to only"
> -                                " migrate over the IB fabric until the kernel "
> -                                " fixes the bug.\n");
> +                warn_report("WARN: migrations may fail:"
> +                            " IPv6 over RoCE / iWARP in linux"
> +                            " is broken. But since you appear to have a"
> +                            " mixed RoCE / IB environment, be sure to only"
> +                            " migrate over the IB fabric until the kernel "
> +                            " fixes the bug.");

Won't this become "warning: WARN:"?

>              } else {
>                  error_setg(errp, "RDMA ERROR: "
>                             "You only have RoCE / iWARP devices in your systems"
> @@ -1418,12 +1418,8 @@ static int qemu_rdma_unregister_waiting(RDMAContext *rdma)
>          block->remote_keys[chunk] = 0;
>  
>          if (ret != 0) {
> -            /*
> -             * FIXME perror() is problematic, bcause ibv_dereg_mr() is
> -             * not documented to set errno.  Will go away later in
> -             * this series.
> -             */
> -            perror("unregistration chunk failed");
> +            error_report("unregistration chunk failed: %s",
> +                         strerror(ret));

Doesn't seem to fix the issue, ret might still not be an errno. Am I
missing something?

>              return -1;
>          }


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D838D7B3666
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 17:09:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmF7H-0000Xz-PG; Fri, 29 Sep 2023 11:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qmF7F-0000Xg-D6
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 11:09:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qmF79-00006b-QU
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 11:09:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 55B5D21892;
 Fri, 29 Sep 2023 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696000150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PeT9DxaH9gSbHNxerOslsVhJI4/uTGPzEWxZJZ7NsYA=;
 b=T1rvb6n6GuCrrjeoc2gr4EmTMhqA0slFzMEEg7JOY/c1dDIeDQRWFzBWX+0Skg+eCv/lbS
 WNegqD7RB+C/jg3zlqkJnLkCIzUARDBXOh7L2Bvmz1f8mzxR7WoJ0QIaO47Gpw9HjzLs9n
 ODjsDd1hp9Lo/1ySPh+NKoWjPnsBr2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696000150;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PeT9DxaH9gSbHNxerOslsVhJI4/uTGPzEWxZJZ7NsYA=;
 b=5g74kde3NVOqT7R+WSkR1aW25sJvPEzAItU4NWGVSAhqscctIbDq/l3YWeZpTfNQmpkMnI
 GTYQo22ssGYQWmDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDE1713434;
 Fri, 29 Sep 2023 15:09:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gFwvKpXoFmUrLwAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 29 Sep 2023 15:09:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 lizhijian@fujitsu.com, eblake@redhat.com
Subject: Re: [PATCH v2 16/53] migration/rdma: Fix or document problematic
 uses of errno
In-Reply-To: <20230928132019.2544702-17-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-17-armbru@redhat.com>
Date: Fri, 29 Sep 2023 12:09:07 -0300
Message-ID: <87y1gpyq24.fsf@suse.de>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> We use errno after calling Libibverbs functions that are not
> documented to set errno (manual page does not mention errno), or where
> the documentation is unclear ("returns [...] the value of errno on
> failure").  While this could be read as "sets errno and returns it",
> a glance at the source code[*] kills that hope:
>
>     static inline int ibv_post_send(struct ibv_qp *qp, struct ibv_send_wr *wr,
>                                     struct ibv_send_wr **bad_wr)
>     {
>             return qp->context->ops.post_send(qp, wr, bad_wr);
>     }
>
> The callback can be
>
>     static int mana_post_send(struct ibv_qp *ibqp, struct ibv_send_wr *wr,
>                               struct ibv_send_wr **bad)
>     {
>             /* This version of driver supports RAW QP only.
>              * Posting WR is done directly in the application.
>              */
>             return EOPNOTSUPP;
>     }
>
> Neither of them touches errno.
>
> One of these errno uses is easy to fix, so do that now.  Several more
> will go away later in the series; add temporary FIXME commments.
> Three will remain; add TODO comments.  TODO, not FIXME, because the
> bug might be in Libibverbs documentation.
>
> [*] https://github.com/linux-rdma/rdma-core.git
>     commit 55fa316b4b18f258d8ac1ceb4aa5a7a35b094dcf
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  migration/rdma.c | 45 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 6 deletions(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 28097ce604..bba8c99fa9 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -853,6 +853,12 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
>  
>          for (x = 0; x < num_devices; x++) {
>              verbs = ibv_open_device(dev_list[x]);
> +            /*
> +             * ibv_open_device() is not documented to set errno.  If
> +             * it does, it's somebody else's doc bug.  If it doesn't,
> +             * the use of errno below is wrong.
> +             * TODO Find out whether ibv_open_device() sets errno.
> +             */
>              if (!verbs) {
>                  if (errno == EPERM) {
>                      continue;

This function can call into glibc, so it's not unreasonable to expect
errno to be set at some point. We're not relying on errno to be set,
just taking an action if it happens to be.

I don't think someone would just decide to handle EPERM at this point
for no reason. Specially since the manual makes no mention to
errno. This was probably introduced after someone got bit by it.

... indeed the commit 5b61d57521 ("rdma: Fix qemu crash when IPv6
address is used for migration") introduced this to fix a crash.



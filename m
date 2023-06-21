Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E24B7386C5
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:23:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByjW-0000tT-Em; Wed, 21 Jun 2023 10:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qByjU-0000tK-CX
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:22:52 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qByjS-0000oJ-R5
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:22:52 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 606561FEAB;
 Wed, 21 Jun 2023 14:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1687357368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3LbDV9fIwPZxPlQPFTZlTi5F9fw4s3nsfpB3zo48hAY=;
 b=DnVt/aUWZzX0Y+x0J7N+Sbf6ImCYIgb0/emf3+gs5a1SvqU3ECMMVbzqkW+amG6048syKd
 wZ76HkJesFgrLsiNLjbBs34imcmck0N8kSbhyMueZBuB52234ngXavlKmBYyqNCTgUSgS7
 2CvaN+4wWu3HATodnAG8++XmEuoPf4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1687357368;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3LbDV9fIwPZxPlQPFTZlTi5F9fw4s3nsfpB3zo48hAY=;
 b=yAfesyIcXtJW7bllbOKBw6875FKndVgzpzQQq+8u8R2ZfaORQRaZF0oeuoDhjzcn/avqv9
 tnptoGJcQGGtotCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B121D133E6;
 Wed, 21 Jun 2023 14:22:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8sFMGLcHk2SbBAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 21 Jun 2023 14:22:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: z00619469 <zhangjianguo18@huawei.com>, qemu-devel@nongnu.org
Cc: chenyuhui5@huawei.com, xuyinghua3@huawei.com, liheng.liheng@huawei.com,
 renxuming@huawei.com, pengyi.pengyi@huawei.com, yubihong@huawei.com,
 zhengchuan@huawei.com, huhao33@huawei.com
Subject: Re: [PATCH] migrate/multifd: fix coredump when the multifd thread
 cleanup
In-Reply-To: <20230621081826.3203053-1-zhangjianguo18@huawei.com>
References: <20230621081826.3203053-1-zhangjianguo18@huawei.com>
Date: Wed, 21 Jun 2023 11:22:44 -0300
Message-ID: <87wmzwsxmz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
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

z00619469 via <qemu-devel@nongnu.org> writes:

> From: c00454449 <chenyuhui5@huawei.com>
>
> There is a coredump while trying to destroy mutex when
> p->running is false but p->mutex is not unlock.
> Make sure all mutexes has been released before destroy them.
>
> Signed-off-by: c00454449 <chenyuhui5@huawei.com>
> ---
>  migration/multifd.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index b7ad7002e0..7dcdb2d3a0 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -523,9 +523,7 @@ void multifd_save_cleanup(void)
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
> -        if (p->running) {

The need for this flag is dubious IMO. Commit 10351fbad1
("migration/multifd: Join all multifd threads in order to avoid leaks")
already moved the other join outside of it. If we figure out another way
to deal with the sem_sync lockup we could probably remove this
altogether.


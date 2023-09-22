Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 361C97AB58A
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 18:07:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjigH-0001oK-SW; Fri, 22 Sep 2023 12:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qjigG-0001jY-88
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 12:07:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qjigE-00089u-IH
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 12:06:59 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A5DFB1F37F;
 Fri, 22 Sep 2023 16:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695398816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KTbE6yb+0fG1pe4fc8TZ1aWB3w2ysSZ2aBH43kFQD30=;
 b=j2ncKvzfpHiEylM5PN3VkVaA1YOwlLGIXkF0Gh3wbLPHoGsdKnO4KDCU8NkBSDavFBX4PO
 bjon6PLdg77r6yi9mUL4F5PYmZhfR3Xx4ENou9dGejjnlBsauOOmBdJUAH+GFH5LIazdzU
 yykP4tMd879Aq7RxV2y7/WwqKTsfTcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695398816;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KTbE6yb+0fG1pe4fc8TZ1aWB3w2ysSZ2aBH43kFQD30=;
 b=4JJmz0wGzF/s87yhoG7oDsBgscPIq47TMmLbeG/ScFw8sEQzVG1T1g1Qplbb3rNZ3pyfIN
 hgfHOJPvWowVVfCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3888013478;
 Fri, 22 Sep 2023 16:06:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id egznAKC7DWV0LwAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 22 Sep 2023 16:06:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>, quintela@redhat.com,
 peterx@redhat.com, leobras@redhat.com
Cc: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/4] multifd: wait for channels_ready before sending sync
In-Reply-To: <20230922065625.21848-2-elena.ufimtseva@oracle.com>
References: <20230922065625.21848-1-elena.ufimtseva@oracle.com>
 <20230922065625.21848-2-elena.ufimtseva@oracle.com>
Date: Fri, 22 Sep 2023 13:06:53 -0300
Message-ID: <87bkdumbtu.fsf@suse.de>
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

Elena Ufimtseva <elena.ufimtseva@oracle.com> writes:

> In multifd_send_sync_main we need to wait for channels_ready
> before submitting sync packet as the threads may still be sending
> their previous pages.
> There is also no need to check for channels_ready in the loop
> before the wait for sem_sync, next iteration of sending pages
> or another sync will start with waiting for channels_ready
> semaphore.
> Changes to commit 90b3cec351996dd8ef4eb847ad38607812c5e7f5
> ("multifd: Fix the number of channels ready")
>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  migration/multifd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 0f6b203877..e61e458151 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -595,6 +595,7 @@ int multifd_send_sync_main(QEMUFile *f)
>          }
>      }
>  
> +    qemu_sem_wait(&multifd_send_state->channels_ready);
>      /*
>       * When using zero-copy, it's necessary to flush the pages before any of
>       * the pages can be sent again, so we'll make sure the new version of the
> @@ -630,7 +631,6 @@ int multifd_send_sync_main(QEMUFile *f)
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
> -        qemu_sem_wait(&multifd_send_state->channels_ready);
>          trace_multifd_send_sync_main_wait(p->id);
>          qemu_sem_wait(&p->sem_sync);

Please take a look at the series I just sent. Basically, I think we
should wait on 'sem' for the number of existing channels and not just
once per sync. Otherwise I think we'd hit the same issue this patch is
trying to fix when we loop into the n+1 channels. I think the
assert(!p->pending_job) in patch 3 helps prove that's more appropriate.

Let me know what you think.

Thanks


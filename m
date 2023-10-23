Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF407D3921
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 16:18:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quvkp-0007Vh-05; Mon, 23 Oct 2023 10:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quvkl-0007VF-RK
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 10:17:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quvkk-0007d7-9V
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 10:17:59 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D944D1FE18;
 Mon, 23 Oct 2023 14:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698070676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XeK5sCuYcXFozWXnpfHoLIgZM3Ggl2Nw/o/ogLz7qQk=;
 b=fnc2zaFUe0tdDBp6bnqzKie+4wr1D6wP8kDF0OODxDIfCclJMORfVBIE1KtGOeduMj9hhQ
 O0PCwr8tNTFLyPEsKCGVGSHJxP4V95xIPW5sYKclocw3VMEvrxbFNXxAUyMFbCBfnE2EyA
 kb6bh8fgPURO562DuMeusjfRarmdF7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698070676;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XeK5sCuYcXFozWXnpfHoLIgZM3Ggl2Nw/o/ogLz7qQk=;
 b=p2ZsNuKyusaVEqYMSTKSBfdAMelIS1Ap0xHibLVOTI/1aK2TbRzf5ToPTcCZpCQLeQYq39
 XbPaoNFj/0II7BDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F51F139C2;
 Mon, 23 Oct 2023 14:17:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 60PlCpSANmXJaQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 14:17:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH RFC 2/7] migration: Fix error leak in
 multifd_tls_outgoing_handshake()
In-Reply-To: <20231022201211.452861-3-peterx@redhat.com>
References: <20231022201211.452861-1-peterx@redhat.com>
 <20231022201211.452861-3-peterx@redhat.com>
Date: Mon, 23 Oct 2023 11:17:54 -0300
Message-ID: <87msw9zalp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -6.85
X-Spamd-Result: default: False [-6.85 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-2.75)[98.90%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
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

Peter Xu <peterx@redhat.com> writes:

> The Error* is leaked when error triggerred.
>
> It logically should have a Fixes here, but since the code changed a few
> times, the backport won't be straightforward anyway.  Let's not bother with
> leaking an error in the failure path for now.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/multifd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index c8bdd88041..4afdd88602 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -789,6 +789,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
>      p->quit = true;
>      qemu_sem_post(&multifd_send_state->channels_ready);
>      qemu_sem_post(&p->sem_sync);
> +    error_free(err);
>  }
>  
>  static void *multifd_tls_handshake_thread(void *opaque)

Reviewed-by: Fabiano Rosas <farosas@suse.de>


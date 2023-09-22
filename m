Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0827AB931
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 20:33:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjkxE-00089b-12; Fri, 22 Sep 2023 14:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qjkxB-000895-QI
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 14:32:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qjkxA-00032L-9E
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 14:32:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 47B7421A9F;
 Fri, 22 Sep 2023 18:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695407554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D39M92nZoWKveQvTrtQu6elidDkHUZxDUtsOf6HWd+4=;
 b=TcaU9Fj7MNPWIOXjTKjFQx3QIXU/qZpStdZ3ylimQKApIxocIRsz8TGciCE0w6PKJeXvf7
 quRgIFh0M2AUC/cz+hcl4ALcEKaiYxMnikjK9ewKMhjktUXnDri5LSk8AptxFGjcc0U8Yo
 ndGwbadzBSFYnnfoOHxhbJIxmnUvQo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695407554;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D39M92nZoWKveQvTrtQu6elidDkHUZxDUtsOf6HWd+4=;
 b=9BwNbglvBAXQV1NU67b4hDWLGCu0A4PjLQhDny/mJmE5Rlq6NTybCH4Sbu5T1AlMvMaK8r
 Ee7KJFagAiownzCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CEA2E13478;
 Fri, 22 Sep 2023 18:32:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3n40JsHdDWXUcgAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 22 Sep 2023 18:32:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>, quintela@redhat.com,
 peterx@redhat.com, leobras@redhat.com
Cc: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/4] multifd: reset next_packet_len after sending pages
In-Reply-To: <20230922065625.21848-5-elena.ufimtseva@oracle.com>
References: <20230922065625.21848-1-elena.ufimtseva@oracle.com>
 <20230922065625.21848-5-elena.ufimtseva@oracle.com>
Date: Fri, 22 Sep 2023 15:32:31 -0300
Message-ID: <871qeqm534.fsf@suse.de>
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

> Sometimes multifd sends just sync packet with no pages
> (normal_num is 0). In this case the old value is being
> preserved and being accounted for while only packet_len
> is being transferred.
> Reset it to 0 after sending and accounting for.
>
> TODO: Fix the same packet ids in the stream.
> with this patch, there is still an issue with the duplicated
> packets ids being sent (with different number of pages/flags).
> See in below multifd_send trace (before this change):
> multifd_send 394.774 pid=55477 id=0x1 packet_num=0x6f0 normal=0x57 flags=0x1 next_packet_size=0x57000
> multifd_send 181.244 pid=55477 id=0x1 packet_num=0x6f0 normal=0x0 flags=0x0 next_packet_size=0x57000
>
> With this commit there are still duplicated packets, but since no pages
> are being sent with sync flag set, next_packet_size is 0:
> multifd_send 27.814 pid=18602 id=0x1 packet_num=0x574 normal=0x7b flags=0x1 next_packet_size=0x7b000
> multifd_send 136054.792 pid=18602 id=0x1 packet_num=0x574 normal=0x0 flags=0x0 next_packet_size=0x0
> If there is a suggestion how to fix this properly, I will be
> glad to use it.
>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  migration/multifd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 3281397b18..8b4e26051b 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -730,6 +730,7 @@ static void *multifd_send_thread(void *opaque)
>                         p->next_packet_size + p->packet_len);
>              stat64_add(&mig_stats.transferred,
>                         p->next_packet_size + p->packet_len);
> +            p->next_packet_size = 0;
>              qemu_mutex_lock(&p->mutex);
>              p->pending_job--;
>              qemu_mutex_unlock(&p->mutex);

Reviewed-by: Fabiano Rosas <farosas@suse.de>


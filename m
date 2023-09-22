Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 124547AB36B
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 16:20:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjgzl-0006wj-1M; Fri, 22 Sep 2023 10:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qjgzj-0006wV-Ao
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:18:59 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qjgzg-0001ql-LP
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:18:59 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 16E1921CA4;
 Fri, 22 Sep 2023 14:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695392333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VAvGJQI/dGf1vgh0OYWBpmCQH7kFoLK/nhQu7gj74f8=;
 b=fJ4S1H+xbveWBpUxInd9Cpr39VsnRb8zwE/qAl0dpHCT2EFMTdOneRfNKy1TQRHnFAOZUX
 UlpuE1f3tQVQoaTAmZIbaxsrjuKG6Dr1/dkL7fpDChSuj0Mx77HKu4G09n/SfC8rwWkt9m
 9Ea5FquwdOaau2Ed/U1jxaTnbrtzXoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695392333;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VAvGJQI/dGf1vgh0OYWBpmCQH7kFoLK/nhQu7gj74f8=;
 b=K+QeMTa31P1R+IbWLqhDXr9HAxHuBLGJE+zbpt8CLy3ApoLEhUaXskG7BZGLNq6PrsLBRo
 aPmIRcXABeJMQ0Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94B1B13478;
 Fri, 22 Sep 2023 14:18:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7nAQGEyiDWUTeQAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 22 Sep 2023 14:18:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>, quintela@redhat.com,
 peterx@redhat.com, leobras@redhat.com
Cc: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/4] multifd: various fixes
In-Reply-To: <20230922065625.21848-1-elena.ufimtseva@oracle.com>
References: <20230922065625.21848-1-elena.ufimtseva@oracle.com>
Date: Fri, 22 Sep 2023 11:18:50 -0300
Message-ID: <877coi70l1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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

> Hello
>
> While working and testing various live migration scenarios,
> a few issues were found.
>
> This is my first patches in live migration and I will
> appreciate the suggestions from the community if these
> patches could be done differently.
>
> [PATCH 1/4] multifd: wait for channels_ready before sending sync
> I am not certain about this change since it seems that
> the sync flag could be the part of the packets with pages that are
> being sent out currently.
> But the traces show this is not always the case:
> multifd_send 230.873 pid=55477 id=0x0 packet_num=0x6f4 normal=0x40 flags=0x1 next_packet_size=0x40000
> multifd_send 14.718 pid=55477 id=0x1 packet_num=0x6f5 normal=0x0 flags=0x1 next_packet_size=0x80000
> If the sync packet is indeed can be a standalone one, then waiting for
> channels_ready before seem to be appropriate, but waisting iteration on
> sync only packet.

I haven't looked at this code for a while, so there's some context
switching to be made, but you're definitely on the right track here. I
actually have an unsent patch doing almost the same as your patch
1/4. I'll comment more there.

About the sync being standalone, I would expect that to always be the
case since we're incrementing packet_num at that point.

> [PATCH 4/4] is also relevant to 1/4, but fixes the over-accounting in
> case of sync only packet.
>
>
> Thank you in advance and looking forward for your feedback.
>
> Elena
>
> Elena Ufimtseva (4):
>   multifd: wait for channels_ready before sending sync
>   migration: check for rate_limit_max for RATE_LIMIT_DISABLED
>   multifd: fix counters in multifd_send_thread
>   multifd: reset next_packet_len after sending pages
>
>  migration/migration-stats.c |  8 ++++----
>  migration/multifd.c         | 11 ++++++-----
>  2 files changed, 10 insertions(+), 9 deletions(-)

